package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.PersoonData;

import feathers.controls.Button;

import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.TextInput;
import feathers.layout.HorizontalLayout;

import starling.display.Sprite;
import starling.events.Event;

public class ProportioneelMethode extends Sprite implements IcanBeViewed {

    private var _appmodel:Appmodel;
    private var _addPersoon:Button;
    private var _layout:LayoutGroup;
    private var _panel:Panel;
    private var _txtInput:TextInput;
    private var _sliders:Array;

    private var w:Number;
    private var h:Number;

    public function ProportioneelMethode() {

        _appmodel = Appmodel.getInstance();
        _appmodel.personen = [];
        var eerstePersoon:PersoonData = new PersoonData("ik");
        eerstePersoon.procentTeBetalen = 100;
        _appmodel.addPersoon(eerstePersoon);

        _addPersoon = new Button();
        _addPersoon.label = "voeg een persoon toe.";
        _addPersoon.addEventListener(Event.TRIGGERED, addPersoon_triggeredHandler);

        _sliders = createSliders();

    }

    private function createSliders():Array
    {
        var array:Array = [];
        for each(var persoon:PersoonData in _appmodel.personen){
            var persoonView:PersoonView = new PersoonView(persoon, PersoonView.PROPORTIONEEL);
            persoonView.addEventListener(PersoonView.PERSOON_DELETED, removePersoon_triggeredHandler);
            array.push(persoonView);
        }
        _sliders = array;
        if(w && h)setSize(w, h);

        return array;
    }

    public function setSize(w:Number, h:Number):void{
        this.w = w;
        this.h = h;
        var ypos:Number = 100;

        if(_layout)removeChild(_layout);
        _layout = new LayoutGroup();
        _layout.addChild(_addPersoon);

        for each(var persoon:PersoonView in _sliders){
            persoon.y = ypos;
            persoon.width = 200;
            _layout.addChild(persoon);
            ypos += 120;
            trace(ypos);
        }

        addChild(_layout);

    }

    private function addPersoon_triggeredHandler(e:Event):void
    {
        _panel = new Panel();
        _panel.headerProperties.title = "Hoe heet deze persoon?";

        var layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = 20;
        layout.padding = 20;
        _panel.layout = layout;

        this.addChild( _panel );

        _txtInput = new TextInput();
        _txtInput.text = "persoon " + (_appmodel.aantalPersonen + 1);
        _panel.addChild( _txtInput );

        var confirmButton:Button = new Button();
        confirmButton.label = "Ok";
        confirmButton.addEventListener(Event.TRIGGERED, personConfirmed);
        _panel.addChild( confirmButton );
    }

    private function personConfirmed(event:Event):void
    {
        this.removeChild(_panel);
        trace("[procentueelmethode] add persoon");

        var nieuwPersoon:PersoonData = new PersoonData(_txtInput.text);
        _appmodel.addPersoon(nieuwPersoon);
        trace(_appmodel.personen);

        createSliders();
    }

    private function removePersoon_triggeredHandler(event:Event):void
    {
        trace("[procentueelmethode] remove persoon");
        var target:PersoonView = event.currentTarget as PersoonView;
        var oudPersoon:PersoonData = target.data;
        _appmodel.removePersoon(oudPersoon);
        createSliders();
    }
}
}
