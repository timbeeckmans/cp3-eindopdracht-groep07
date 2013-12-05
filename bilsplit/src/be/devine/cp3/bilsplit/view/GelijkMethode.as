package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.ButtonGroup;
import feathers.data.ListCollection;

import starling.display.Sprite;
import starling.events.Event;

public class GelijkMethode extends Sprite implements IcanBeViewed{

    private var _appmodel:Appmodel;
    private var _buttons:ButtonGroup;


    public function GelijkMethode() {
        _appmodel = Appmodel.getInstance();

        trace('[gelijkmethode]');


        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Delete Person", triggered: deletePerson},
                    { label: "Add Person", triggered: addPerson}
                ]);


        addChild(_buttons);

    }

    private function addPerson(event:starling.events.Event):void {

        trace('[gelijkmethode] add person');
        _appmodel.personen.push("person");
        trace(_appmodel.personen);

        trace(_appmodel.personen.length);



    }

    private function deletePerson(event:starling.events.Event):void {

        trace('[gelijkmethode] delete person');

        _appmodel.personen.pop();
        trace(_appmodel.personen);

        trace(_appmodel.personen.length);

    }

    public function setSize(w:Number, h:Number):void{

    }



}
}
