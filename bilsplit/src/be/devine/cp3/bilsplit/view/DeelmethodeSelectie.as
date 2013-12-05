package be.devine.cp3.bilsplit.view
{


import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.view.GelijkMethode;

import feathers.controls.ButtonGroup;
import feathers.controls.NumericStepper;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;

import starling.display.Sprite;
import starling.events.Event;

public class DeelmethodeSelectie extends Sprite implements IcanBeViewed
{
    private var w:Number;
    private var h:Number;

    private var _appmodel:Appmodel;
    private var _buttons:ButtonGroup;

    public function DeelmethodeSelectie()
    {
        _appmodel = Appmodel.getInstance();
        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Gelijk verdeeld", triggered: GelijkMethode_clickhandler},
                    { label: "Procentueel verdeeld", triggered: _clickhandler},
                    { label: "Proportioneel verdeeld", triggered: _clickhandler}
                ]);


    }

    public function setSize(w:Number, h:Number):void{
        this.h = h;
        this.w = w;

        _buttons.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);
        this.addChild(_buttons);
    }






    function GelijkMethode_clickhandler( event:Event ):void
    {
        _appmodel.huidigScherm = "gelijkMethode";
    }

    private function buttonCreatedHandler(event:starling.events.Event):void
    {
        _buttons.removeEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);
        _buttons.x = w/2 - _buttons.width / 2;
        _buttons.y = h - (_buttons.height + 50);

    }

    function _clickhandler( event:Event ):void
    {
    }

}
}
