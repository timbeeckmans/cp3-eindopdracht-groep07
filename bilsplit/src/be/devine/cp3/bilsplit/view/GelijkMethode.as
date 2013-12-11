package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.Button;

import feathers.controls.Label;

import feathers.controls.LayoutGroup;
import feathers.controls.NumericStepper;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;

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


    public function GelijkMethode() {
        _appmodel = Appmodel.getInstance();

        _appmodel.totaalBedrag = 50;
        _appmodel.aantalPersonen = 1;

        trace('[gelijkmethode]');

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        addChild(_buttonGroup);


        stepper = new NumericStepper();

        stepper.minimum = 1;
        stepper.maximum = 99;
        stepper.value = _appmodel.aantalPersonen;
        stepper.step = 1;
        //niet goed leesbaar... ander theme mss?
        addChild( stepper );

        stepper.addEventListener( Event.CHANGE, stepper_changeHandler );


    }

    private function stepper_changeHandler(event:Event):void {
        var stepper:NumericStepper = NumericStepper( event.currentTarget );
        _appmodel.aantalPersonen = stepper.value;
        berekenPerPersoon();

    }

    public function setSize(w:Number, h:Number):void {
        stepper.x = w/2;
        stepper.x = 30;
        stepper.y = 250;

        _personenlabel = new Label();
        _personenlabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _personenlabel.text = "Aantal personen: ";
        addChild(_personenlabel);

        _personenlabel.x = 30;
        _personenlabel.y = 200;

        _explicitWidth = w;
        _explicitHeight = h;
        //_buttonGroup.x = Math.round((_explicitWidth - _buttonGroup.width) * .5);


    }

    private function berekenPerPersoon():void{

        //geeft een getal terug met 2 decimalen
        //Totaal kan enkele centen verschillen met de som van de personen

        _bedragperpersoon.text =  Math.round(100 * _appmodel.totaalBedrag / _appmodel.aantalPersonen) / 100 + " euro";
    }


    private function buttonGroupCreationCompleteHandler(event:Event):void {
        setSize(_explicitWidth, _explicitHeight);

        _totaalbedraglabel = new Label();
        _totaalbedraglabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _totaalbedraglabel.text = "Totaalbedrag: ";
        addChild(_totaalbedraglabel);

        _totaalbedraglabel.setSize(100,100);
        _totaalbedraglabel.x = 30;
        _totaalbedraglabel.y = 100;

        //var myTextInput:TextInput = new TextInput();
        //addChild(myTextInput);

        _totaalbedragwaarde = new Label();
        _totaalbedragwaarde.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _totaalbedragwaarde.text = _appmodel.totaalBedrag + " euro";
        addChild(_totaalbedragwaarde);

        _totaalbedragwaarde.setSize(100,100);
        _totaalbedragwaarde.x = 250;
        _totaalbedragwaarde.y = 100;

        _bedragperpersoonlabel = new Label();
        _bedragperpersoonlabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _bedragperpersoonlabel.text = "Bedrag per persoon: ";
        addChild(_bedragperpersoonlabel);

        _bedragperpersoonlabel.setSize(100,100);
        _bedragperpersoonlabel.x = 30;
        _bedragperpersoonlabel.y = 300;

        _bedragperpersoon = new Label();
        _bedragperpersoon.nameList.add(Label.ALTERNATE_NAME_HEADING);
        addChild(_bedragperpersoon);

        _bedragperpersoon.setSize(100,100);
        _bedragperpersoon.x = 350;
        _bedragperpersoon.y = 300;

        berekenPerPersoon();
    }




}
}
