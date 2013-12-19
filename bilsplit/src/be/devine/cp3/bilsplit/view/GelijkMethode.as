package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.BillService;

import feathers.controls.Button;

import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.NumericStepper;
import feathers.controls.Panel;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayout;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;


public class GelijkMethode extends Sprite implements IcanBeViewed{

    private var _appmodel:Appmodel;
    private var _buttonGroup:LayoutGroup;
    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;
    private var _totaalbedraglabel:Label;
    private var _bedragperpersoon:Label;
    private var _bedragperpersoonlabel:Label;
    private var _personenlabel:Label;
    private var stepper:NumericStepper;
    private var _bedraginput:TextInput;
    private var _savebutton:Button;
    private var _bs:BillService;
    private var _panel:Panel;
    private var _txtInput:TextInput;

    [Embed(source = "/../assets/images/billsplitterlogokleingelijk.png")]
    private static const Logo:Class;

    private var _layout:LayoutGroup;

    private var w:Number;
    private var h:Number;

    public function GelijkMethode() {
        trace('[gelijkmethode] constructor');

        _appmodel = Appmodel.getInstance();
        _bs = new BillService();
        _layout = new LayoutGroup();

        _savebutton = new Button();
        _savebutton.label = "save";
        _savebutton.addEventListener(Event.TRIGGERED, savebutton_triggeredHandler);

        _buttonGroup = new LayoutGroup();
        addChild(_layout);
    }

    private function stepper_changeHandler(event:Event):void {
        var stepper:NumericStepper = NumericStepper( event.currentTarget );
        _appmodel.aantalPersonen = stepper.value;
        berekenPerPersoon();

    }

    public function setSize(w:Number, h:Number):void {
        trace("[GelijkMethode] setSize");

        _savebutton.x = 27;
        _savebutton.y = 600;
        _layout.addChild(_savebutton);

        stepper = new NumericStepper();

        stepper.minimum = 1;
        stepper.maximum = 99;
        stepper.value = _appmodel.aantalPersonen;
        stepper.step = 1;
        _layout.addChild( stepper );

        stepper.addEventListener( Event.CHANGE, stepper_changeHandler );


        this.w = w;
        this.h = h;

        stepper.x = w - 213;
        stepper.y = 300;

        _personenlabel = new Label();
        _personenlabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _personenlabel.text = "Aantal personen: ";

        _layout.addChild(_personenlabel);

        _personenlabel.x = 30;
        _personenlabel.y = 305;

        _explicitWidth = w;
        _explicitHeight = h;

        _layout.readjustLayout();

        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        _layout.addChild(_buttonGroup);

        var logo:Image = Image.fromBitmap(new Logo());
        logo.x = 10;
        logo.y = 10;
        _layout.addChild(logo);
        addChild(_layout);

    }

    private function berekenPerPersoon():void{

        //geeft een getal terug met 2 decimalen
        //Totaal kan enkele centen verschillen met de som van de personen
        _bedragperpersoon.text = "€ " + Math.round(100 * _appmodel.totaalBedrag / _appmodel.aantalPersonen) / 100;

    }


    private function buttonGroupCreationCompleteHandler(event:Event):void {
        setSize(_explicitWidth, _explicitHeight);

        _totaalbedraglabel = new Label();
        _totaalbedraglabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _totaalbedraglabel.text = "Totaalbedrag:";
        _layout.addChild(_totaalbedraglabel);

        _totaalbedraglabel.x = 30;
        _totaalbedraglabel.y = 205;


        this._bedraginput = new TextInput();
        this._bedraginput.prompt = _appmodel.huidigeBill.totaalBedrag + "";
        this._bedraginput.restrict = "0-9.";
        this._bedraginput.layoutData = new AnchorLayoutData();
        this.addChild(this._bedraginput);
        this._bedraginput.addEventListener(Event.CHANGE, bedragchangehandler);

        _bedraginput.x = w - 215;
        _bedraginput.y = 200;

        _bedragperpersoonlabel = new Label();
        _bedragperpersoonlabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _bedragperpersoonlabel.text = "Bedrag per persoon: ";
        _layout.addChild(_bedragperpersoonlabel);

        _bedragperpersoonlabel.x = 30;
        _bedragperpersoonlabel.y = 405;

        _bedragperpersoon = new Label();
        _bedragperpersoon.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _layout.addChild(_bedragperpersoon);

        _bedragperpersoon.x = w - 214;
        _bedragperpersoon.y = 405;

        _bedragperpersoon.text = "€ 0";

        berekenPerPersoon();
    }

    private function bedragchangehandler(event:Event):void {
        _appmodel.totaalBedrag = Number(_bedraginput.text);
        berekenPerPersoon();
    }


    private function savebutton_triggeredHandler(event:Event):void
    {
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

    }

    private function billconfirmed(event:Event):void {
        this.removeChild(_panel);
        _appmodel.huidigeBill.naam = this._txtInput.text;
        _appmodel.addBill(_appmodel.huidigeBill);
        _appmodel.huidigScherm = "start";
    }
}
}
