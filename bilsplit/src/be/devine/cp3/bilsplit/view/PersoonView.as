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

    private var _data:PersoonData;
    private var _type:String;
    private var _layout:LayoutGroup;
    private var _slider:Slider;
    private var _appmodel:Appmodel;
    private var _deleteButton:Button;

    public function PersoonView(data:PersoonData, type:String)
    {
        _appmodel = Appmodel.getInstance();
        _appmodel.totaalBedrag = 50;
        _data = data;
        _type = type;

        _layout = new LayoutGroup();

        var label:Label = new Label();
        label.text = data.naam;
        label.x = 10;
        label.y = 10;
        _layout.addChild(label);

        _slider = new Slider();
        _slider.y = 50;
        _slider.x = 10;
        _slider.minimum = 0;
        _slider.step = 1;
        _slider.page = 10;
        _slider.value = data.procentTeBetalen;
        _slider.addEventListener( starling.events.Event.CHANGE, slider_changeHandler );
        _layout.addChild( _slider );
        if(_type == PROCENTUEEL)_slider.maximum = 100;
        if(_type == PROPORTIONEEL && !_appmodel.totaalBedrag == 0)_slider.maximum = _appmodel.totaalBedrag;

        _deleteButton = new Button();
        _deleteButton.x = 200;
        _deleteButton.label = "X";
        _deleteButton.addEventListener(starling.events.Event.TRIGGERED, deleteButton_triggeredHandler);
        _layout.addChild(_deleteButton);

        addChild(_layout);

        _appmodel.addEventListener(Appmodel.TOTAALBEDRAG_CHANGED_EVENT, appmodel_totaalBedragChangedHandler);
    }

    private function slider_changeHandler(event:starling.events.Event):void
    {
        if(_type == PROCENTUEEL)_data.procentTeBetalen = _slider.value;
        if(_type == PROPORTIONEEL)_data.bedragTeBetalen = _slider.value;
    }

    private function appmodel_totaalBedragChangedHandler(event:flash.events.Event):void
    {
        if(_type == PROPORTIONEEL){
            _slider.maximum = _appmodel.totaalBedrag;
            if(_slider.value > _appmodel.totaalBedrag)_slider.value = _appmodel.totaalBedrag;
        }
    }

    private function deleteButton_triggeredHandler(event:starling.events.Event):void
    {
        dispatchEvent(new starling.events.Event(PERSOON_DELETED))
    }

    public function get data():PersoonData
    {
        return _data;
    }
}
}
