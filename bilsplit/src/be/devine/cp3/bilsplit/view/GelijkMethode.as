package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.Button;
import feathers.controls.Label;

import feathers.controls.LayoutGroup;
import feathers.controls.NumericStepper;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.TextureAtlas;

public class GelijkMethode extends Sprite implements IcanBeViewed{

    private var _appmodel:Appmodel;
    /*private var _buttonGroup:LayoutGroup;
    private var _deleteButton:Button;
    private var _addButton:Button;*/
    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;
    //private var _infoLabel:Label;
    private var _personenlabel:Label;
    private var _aantalpersonen:uint = 1;
    private var stepper:NumericStepper;


    public function GelijkMethode() {
        _appmodel = Appmodel.getInstance();


        trace('[gelijkmethode]');

        /*_buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        addChild(_buttonGroup);

        var layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = 50;
        _buttonGroup.layout = layout;
        _buttonGroup.y = 200;

        _deleteButton = new Button();
        _deleteButton.label = "Delete";
        _deleteButton.setSize(150, 50);
        _buttonGroup.addChild(_deleteButton);

        _addButton = new Button();
        _addButton.label = "Add";
        _addButton.setSize(150, 50);
        _buttonGroup.addChild(_addButton);

        _addButton.addEventListener(Event.TRIGGERED, addPersonHandler);
        _deleteButton.addEventListener(Event.TRIGGERED, DeletePersonHandler);*/

        stepper = new NumericStepper();
        stepper.minimum = 1;
        stepper.maximum = 99;
        stepper.value = 1;
        stepper.step = 1;
        addChild( stepper );

        stepper.addEventListener( starling.events.Event.CHANGE, stepper_changeHandler );
        stepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_RIGHT_SIDE_VERTICAL;

        _personenlabel = new Label();
        _personenlabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        _personenlabel.text = "Aantal personen";
        addChild(_personenlabel);


    }

    private function stepper_changeHandler(event:starling.events.Event):void {
        var stepper:NumericStepper = NumericStepper( event.currentTarget );
        _aantalpersonen = stepper.value;
        trace("[gelijkmethode]" + _aantalpersonen);

    }

    public function setSize(w:Number, h:Number):void {
        stepper.x = w/2;

        _explicitWidth = w;
        _explicitHeight = h;
        //_buttonGroup.x = Math.round((_explicitWidth - _buttonGroup.width) * .5);


    }

    /*private function addPersonHandler(event:Event):void {
        trace('[gelijkmethode] add person');
        _appmodel.personen.push("person");
        trace(_appmodel.personen);

        trace(_appmodel.personen.length);

        _infoLabel.text = _appmodel.personen.length.toString();


    }

    private function DeletePersonHandler(event:Event):void {
        trace('[gelijkmethode] add person');
        _appmodel.personen.pop();
        trace(_appmodel.personen);

        trace(_appmodel.personen.length);
        _infoLabel.text = _appmodel.personen.length.toString();

    }

    private function buttonGroupCreationCompleteHandler(event:Event):void {
        setSize(_explicitWidth, _explicitHeight);
        _infoLabel = new Label();
        _infoLabel.nameList.add(Label.ALTERNATE_NAME_HEADING);
        addChild(_infoLabel);

        _infoLabel.setSize(100,100);
        _infoLabel.x = (stage.stageWidth/2) - (_infoLabel.width/2);


    }*/




}
}
