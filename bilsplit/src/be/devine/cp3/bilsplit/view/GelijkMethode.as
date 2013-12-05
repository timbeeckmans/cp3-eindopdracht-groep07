package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.ButtonGroup;
import feathers.data.ListCollection;

import starling.display.Sprite;

public class GelijkMethode extends Sprite implements IcanBeViewed{

    private var _appmodel:Appmodel;
    private var _buttons:ButtonGroup;

    public function GelijkMethode() {
        _appmodel = Appmodel.getInstance();

        trace('glijkmethode');

        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Add person", triggered: _clickhandler}
                ]);
    }

    private function _clickhandler():void {

        trace("add person");


    }

    public function setSize(w:Number, h:Number):void {
        this.addChild(_buttons);
    }

}
}
