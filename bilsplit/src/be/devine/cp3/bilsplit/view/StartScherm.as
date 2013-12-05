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
import feathers.controls.LayoutGroup;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;

import starling.display.Sprite;
import starling.events.Event;

public class StartScherm extends Sprite implements IcanBeViewed
{
    private var w:Number;
    private var h:Number;

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

    }

    private function buttonCreatedHandler(event:Event):void
    {
        _buttons.removeEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);
        _buttons.x = w/2 - _buttons.width / 2;
        _buttons.y = h - (_buttons.height + 50);

    }

    public function setSize(w:Number, h:Number):void{
        this.w = w;
        this.h = h;
        _buttons.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);

        addChild(_buttons);

    }

    function nieuw_clickhandler( event:Event ):void
    {
        _appmodel.huidigScherm = "deelMethode";
    }

    function oud_clickhandler( event:Event ):void
    {
        //_appmodel.huidigScherm =
    }

    function instructie_clickhandler( event:Event ):void
    {
        //_appmodel.huidigScherm =
    }

}
}
