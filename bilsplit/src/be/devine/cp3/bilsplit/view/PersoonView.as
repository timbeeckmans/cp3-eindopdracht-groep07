/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 11/12/13
 * Time: 21:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.Billmodel;
import be.devine.cp3.bilsplit.model.PersoonData;

import feathers.controls.Button;

import feathers.controls.Label;
import feathers.controls.LayoutGroup;

import feathers.controls.Slider;

import flash.events.Event;

import starling.display.Sprite;
import starling.events.Event;

public class PersoonView extends Sprite
{
    public static const PROCENTUEEL:String = "procentueel";
    public static const PROPORTIONEEL:String = "proportioneel";
    public static const PERSOON_DELETED:String = "persoonDeleted";
    public static const PERSOON_WAARDE_CHANGED:String = "persoonWaardeChanged";

    private var _data:PersoonData;
    private var _type:String;
    private var _layout:LayoutGroup;
    private var _slider:Slider;
    private var _appmodel:Appmodel;
    private var _deleteButton:Button;
    private var _procent:Label;
    private var _bedrag:Label;

    public function PersoonView(data:PersoonData, type:String)
    {
        _appmodel = Appmodel.getInstance();
        _data = data;
        _type = type;

        _appmodel.huidigeBill.addEventListener(Billmodel.TOTAALBEDRAG_CHANGED_EVENT, billmodel_totaalBedragChangedHandler);

        _layout = new LayoutGroup();

        var label:Label = new Label();
        label.text = data.naam;
        _layout.addChild(label);


        _bedrag = new Label();
        _bedrag.text = "€ " + _data.bedragTeBetalen;
        _bedrag.y = 60;

        _slider = new Slider();
        _slider.minimum = 0;
        _slider.step = 1;
        _slider.page = 1;
        _slider.addEventListener( starling.events.Event.CHANGE, slider_changeHandler );
        _layout.addChild( _slider );
        _slider.y = 40;
        _slider.x = 140;

        if(_type == PROCENTUEEL){
            _procent = new Label();
            _procent.text = _data.procentTeBetalen + "%";
            _procent.y = 40;
            _slider.maximum = 100;
            _slider.value = data.procentTeBetalen;
            berekenProcentueel();
        }


        if(_type == PROPORTIONEEL){
            if(_appmodel.huidigeBill.totaalBedrag <= 0) _appmodel.huidigeBill.totaalBedrag = 1;
            _slider.maximum = _appmodel.totaalBedrag;
            _slider.value = data.bedragTeBetalen;
        }

        _deleteButton = new Button();
        _deleteButton.x = 380;
        _deleteButton.label = "X";
        _deleteButton.addEventListener(starling.events.Event.TRIGGERED, deleteButton_triggeredHandler);
        _layout.addChild(_deleteButton);
        _deleteButton.y = 40;
        _layout.addChild(_bedrag);
        if(_type == PROCENTUEEL)_layout.addChild(_procent);

        addChild(_layout);

    }

    private function slider_changeHandler(event:starling.events.Event):void
    {
        if(_type == PROCENTUEEL){
            _data.procentTeBetalen = _slider.value;
            _procent.text = _slider.value + "%";
            berekenProcentueel();
        }
        if(_type == PROPORTIONEEL)_data.bedragTeBetalen = _slider.value;
        _bedrag.text = '€ ' + _data.bedragTeBetalen;
        dispatchEvent(new starling.events.Event(PERSOON_WAARDE_CHANGED));
    }

    private function billmodel_totaalBedragChangedHandler(event:flash.events.Event):void
    {
        if(_type == PROPORTIONEEL){
            _slider.maximum = _appmodel.totaalBedrag;
            if(_slider.value > _appmodel.totaalBedrag)_slider.value = _appmodel.totaalBedrag;
        }

        if(_type == PROCENTUEEL){
            berekenProcentueel()
        }
        _bedrag.text = '€ ' + _data.bedragTeBetalen;
    }

    private function deleteButton_triggeredHandler(event:starling.events.Event):void
    {
        dispatchEvent(new starling.events.Event(PERSOON_DELETED))
    }

    public function get data():PersoonData
    {
        return _data;
    }

    public function berekenProcentueel():void{
        _data.bedragTeBetalen = Math.round(_appmodel.huidigeBill.totaalBedrag * _data.procentTeBetalen) / 100;
    }
}
}
