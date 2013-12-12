package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.Button;

import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.NumericStepper;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

import starling.display.Sprite;
import starling.events.Event;
public class GelijkMethode extends Sprite implements IcanBeViewed{

    private var _appmodel:Appmodel;
    private var _buttonGroup:LayoutGroup;
    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;
    private var _totaalbedraglabel:Label;
    private var _totaalbedragwaarde:Label;
    private var _bedragperpersoon:Label;
    private var _bedragperpersoonlabel:Label;
    private var _personenlabel:Label;
    private var stepper:NumericStepper;
    private var _bedraginput:TextInput;

    private var _layout:LayoutGroup;

    private var w:Number;
    private var h:Number;

    public function GelijkMethode() {
        _appmodel = Appmodel.getInstance();
        _layout = new LayoutGroup();


        _appmodel.aantalPersonen = 1;

        trace('[gelijkmethode]');

        _buttonGroup = new LayoutGroup();
        addChild(_layout);


        stepper = new NumericStepper();

        stepper.minimum = 1;
        stepper.maximum = 99;
        stepper.value = _appmodel.aantalPersonen;
        stepper.step = 1;
        _layout.addChild( stepper );

        stepper.addEventListener( Event.CHANGE, stepper_changeHandler );


    }

    private function stepper_changeHandler(event:Event):void {
        var stepper:NumericStepper = NumericStepper( event.currentTarget );
        _appmodel.aantalPersonen = stepper.value;
        berekenPerPersoon();

    }

    public function setSize(w:Number, h:Number):void {
        this.w = w;
        this.h = h;

        stepper.x = w - 213;
        stepper.y = 200;

        _personenlabel = new Label();
        _personenlabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _personenlabel.text = "Aantal personen: ";

        _layout.addChild(_personenlabel);

        _personenlabel.x = 30;
        _personenlabel.y = 205;

        _explicitWidth = w;
        _explicitHeight = h;
        //_buttonGroup.x = Math.round((_explicitWidth - _buttonGroup.width) * .5);

        _layout.readjustLayout();

        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        _layout.addChild(_buttonGroup);

        trace("[GelijkMethode] setSize");

    }

    private function berekenPerPersoon():void{

        //geeft een getal terug met 2 decimalen
        //Totaal kan enkele centen verschillen met de som van de personen

        _bedragperpersoon.text = "€ " + Math.round(100 * _appmodel.totaalBedrag / _appmodel.aantalPersonen) / 100;

        /*if(_bedragperpersoon.width > 80){
            _bedragperpersoon.x = w - ( _bedragperpersoon.width + 20);
        }*/
    }


    private function buttonGroupCreationCompleteHandler(event:Event):void {
        setSize(_explicitWidth, _explicitHeight);

        _totaalbedraglabel = new Label();
        _totaalbedraglabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _totaalbedraglabel.text = "Totaalbedrag:";
        _layout.addChild(_totaalbedraglabel);

        _totaalbedraglabel.x = 30;
        _totaalbedraglabel.y = 105;



        this._bedraginput = new TextInput();
        this._bedraginput.prompt = "15.90";
        this._bedraginput.restrict = "0-9.";
        const inputLayoutData:AnchorLayoutData = new AnchorLayoutData();
        this._bedraginput.layoutData = inputLayoutData;
        this.addChild(this._bedraginput);
        this._bedraginput.addEventListener(Event.CHANGE, bedragchangehandler);

        _bedraginput.x = w - 215;
        _bedraginput.y = 100;

        _bedragperpersoonlabel = new Label();
        _bedragperpersoonlabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _bedragperpersoonlabel.text = "Bedrag per persoon: ";
        _layout.addChild(_bedragperpersoonlabel);

        _bedragperpersoonlabel.x = 30;
        _bedragperpersoonlabel.y = 305;

        _bedragperpersoon = new Label();
        _bedragperpersoon.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _layout.addChild(_bedragperpersoon);

        _bedragperpersoon.x = w - 214;
        _bedragperpersoon.y = 305;

        _bedragperpersoon.text = "€ 15.90"

    }

    private function bedragchangehandler(event:Event):void {
        trace(_bedraginput.text);
        _appmodel.totaalBedrag = Number(_bedraginput.text);
        //_totaalbedragwaarde.text = _bedraginput.text + " euro";
        berekenPerPersoon();


    }




}
}
