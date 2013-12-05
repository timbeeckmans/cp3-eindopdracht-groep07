/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 1/12/13
 * Time: 13:19
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.ButtonGroup;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import starling.display.Sprite;
import starling.events.Event;

import flash.events.Event;

public class StartScherm extends Sprite
{
    private var _buttons:ButtonGroup;
    private var _appmodel:Appmodel;

    public function StartScherm()
    {
        _appmodel = Appmodel.getInstance();

        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Nieuwe rekening", triggered: nieuw_clickhandler},
                    { label: "Oude rekening laden", triggered: oud_clickhandler},
                    { label: "Instructies", triggered: instructie_clickhandler}
                ]);
        _appmodel.addEventListener(Appmodel.STAGE_RESIZED_EVENT, draw);
        draw();
    }

    public function draw(event:flash.events.Event = null):void{
        _buttons.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);
        this.addChild(_buttons);
    }

    private function buttonCreatedHandler(event:starling.events.Event):void
    {
        _buttons.removeEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);
        _buttons.x = _appmodel.stageWidth/2 - _buttons.width / 2;
        _buttons.y = 500;

    }

    function nieuw_clickhandler( event:starling.events.Event ):void
    {
        _appmodel.huidigScherm = "deelMethode";
    }

    function oud_clickhandler( event:starling.events.Event ):void
    {
        //_appmodel.huidigScherm =
    }

    function instructie_clickhandler( event:starling.events.Event ):void
    {
        //_appmodel.huidigScherm =
    }

}
}
