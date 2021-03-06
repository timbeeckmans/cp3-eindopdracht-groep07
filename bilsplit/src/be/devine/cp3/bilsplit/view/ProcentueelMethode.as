package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.BillService;
import be.devine.cp3.bilsplit.model.PersoonData;

import feathers.controls.Button;
import feathers.controls.Callout;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.Panel;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayout;


import starling.display.Image;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;

public class ProcentueelMethode extends Sprite implements IcanBeViewed {

    private var _appmodel:Appmodel;
    private var _addPersoon:Button;
    private var _totaalbedraglabel:Label;
    private var _layout:LayoutGroup;
    private var _panel:Panel;
    private var _txtInput:TextInput;
    private var _sliders:Array;
    private var _bedraginput:TextInput;
    private var container:ScrollContainer;
    private var _savebutton:Button;
    private var _bs:BillService;

    private var w:Number;
    private var h:Number;

    [Embed(source = "/../assets/images/billsplitterlogokleinprocen.png")]
    private static const Logo:Class;
    private var _totaalLabel:Label;

    public function ProcentueelMethode() {
        _appmodel = Appmodel.getInstance();

        _bs = new BillService();

        _addPersoon = new Button();
        _addPersoon.label = "voeg een persoon toe.";
        _addPersoon.addEventListener(Event.TRIGGERED, addPersoon_triggeredHandler);

        _savebutton = new Button();
        _savebutton.label = "save";
        _savebutton.addEventListener(Event.TRIGGERED, savebutton_triggeredHandler);

        _bedraginput = new TextInput();
        _bedraginput.prompt = "0";
        _bedraginput.restrict = "0-9.";
        _bedraginput.layoutData = new AnchorLayoutData();
        _bedraginput.addEventListener(Event.CHANGE, bedragchangehandler);


        _totaalLabel = new Label();
        _sliders = createSliders();

        _totaalbedraglabel = new Label();
        _totaalbedraglabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _totaalbedraglabel.text = "Totaal bedrag: ";



    }

    private function bedragchangehandler(event:Event):void {
        this._bedraginput.prompt = "";
        _appmodel.totaalBedrag = Number(_bedraginput.text);
        persoonView_persoonWaardeChangedHandler();

    }

    private function createSliders():Array
    {
        var array:Array = [];

        for each(var persoon:PersoonData in _appmodel.personen){
            var persoonView:PersoonView = new PersoonView(persoon, PersoonView.PROCENTUEEL);
            persoonView.addEventListener(PersoonView.PERSOON_DELETED, removePersoon_triggeredHandler);
            persoonView.addEventListener(PersoonView.PERSOON_WAARDE_CHANGED, persoonView_persoonWaardeChangedHandler);
            array.push(persoonView);
        }
        _sliders = array;
        if(w && h)setSize(w, h);

        return array;
    }

    public function setSize(w:Number, h:Number):void{
        this.w = w;
        this.h = h;
        var ypos:Number = 0;

        if(_layout)removeChild(_layout);
        _layout = new LayoutGroup();


        _savebutton.x = 27;
        _savebutton.y = 600;
        _layout.addChild(_savebutton);
        _addPersoon.x = 27;
        _addPersoon.y = 100;
        _layout.addChild(_addPersoon);
        _layout.y = 100;

        _layout.addChild(_totaalbedraglabel);
        _totaalbedraglabel.x = 25;
        _totaalbedraglabel.y = 0;


        _bedraginput.x = 25;
        _bedraginput.y = 40;
        _layout.addChild(_bedraginput);

        _totaalLabel.x = w - 150;
        _totaalLabel.y = h - 190;
        _totaalLabel.text = "Totaal: " + berekenTotaalBedrag();
        _layout.addChild(_totaalLabel);

        container = new ScrollContainer();
        container.elasticity = 0.5;
        container.width = 500;
        container.height = h - 400;
        container.padding = 5;
        container.y = 270;
        container.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;


        var topColor:uint = 0xbb670d;
        var bottomColor:uint = 0xf5c089;
        var quad1:Quad = new Quad(container.width, container.height);
        quad1.setVertexColor(0, topColor);
        quad1.setVertexColor(1, topColor);
        quad1.setVertexColor(2, bottomColor);
        quad1.setVertexColor(3, bottomColor);
        container.backgroundSkin = quad1;
        addChild( container );


        for each(var persoon:PersoonView in _sliders){
            persoon.x = 20;
            persoon.y = ypos;
            persoon.width = 200;
            container.addChild(persoon);
            ypos += 100;
        }


        var logo:Image = Image.fromBitmap(new Logo());
        logo.x = 25;
        logo.y = 10;
        addChild(logo);

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


        _panel.x = 80;
        _panel.y = 200;
    }

    private function personConfirmed(event:Event):void
    {
        this.removeChild(_panel);

        var nieuwPersoon:PersoonData = new PersoonData(_txtInput.text);
        _appmodel.addPersoon(nieuwPersoon);

        createSliders();
    }

    private function removePersoon_triggeredHandler(event:Event):void
    {
        var target:PersoonView = event.currentTarget as PersoonView;
        var oudPersoon:PersoonData = target.data;
        _appmodel.removePersoon(oudPersoon);
        createSliders();
    }

    private function savebutton_triggeredHandler(event:Event):void
    {
        if(_appmodel.huidigeBill.totaalBedrag == berekenTotaalBedrag()){

            _panel = new Panel();
            _panel.headerProperties.title = "Hoe heet deze bill?";

            var layout:HorizontalLayout = new HorizontalLayout();
            layout.gap = 20;
            layout.padding = 20;
            _panel.layout = layout;

            this.addChild( _panel );

            _txtInput = new TextInput();
            _txtInput.text = "Bill";
            _panel.addChild( _txtInput );

            var confirmButton:Button = new Button();
            confirmButton.label = "Ok";
            confirmButton.addEventListener(Event.TRIGGERED, billconfirmed);
            _panel.addChild( confirmButton );

            _panel.x = 80;
            _panel.y = 200;

        }else{
            var button:Button = Button( event.currentTarget );
            var content:Label = new Label();
            content.text = createFoutmelding();
            var callout:Callout = Callout.show( content, button, Callout.DIRECTION_RIGHT );
            callout.height = 50;
        }


    }

    private function berekenTotaalBedrag():Number{
        var totaal:Number = 0;
        for each(var persoon:PersoonData in _appmodel.huidigeBill.personen){
            totaal += persoon.bedragTeBetalen;
        }
        return Math.round(totaal*100)/100;
    }

    private function berekenTotaalProcent():Number{
        var totaal:Number = 0;
        for each(var persoon:PersoonData in _appmodel.huidigeBill.personen){
            totaal += persoon.procentTeBetalen;
        }
        return totaal;
    }

    private function createFoutmelding():String
    {
        var verschil:Number = 100 - berekenTotaalProcent();
        var melding:String = 'je hebt ' + Math.abs(verschil);

        if(verschil < 0){
            melding = melding + '% te veel.';
        }else{
            melding = melding + '% te weinig.';
        }

        return melding;
    }

    private function billconfirmed(event:Event):void {
        this.removeChild(_panel);
        _appmodel.huidigeBill.naam = this._txtInput.text;
        _appmodel.addBill(_appmodel.huidigeBill);
        _appmodel.huidigScherm = "start";
    }

    private function persoonView_persoonWaardeChangedHandler(event:Event = null):void
    {
        _totaalLabel.text = "Totaal: " + berekenTotaalBedrag();
    }
}
}
