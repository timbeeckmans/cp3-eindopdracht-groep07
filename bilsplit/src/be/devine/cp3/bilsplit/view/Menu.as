/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 5/12/13
 * Time: 17:06
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.Button;
import feathers.events.FeathersEventType;

import starling.display.Sprite;
import starling.events.Event;

public class Menu extends Sprite
{
    private var w:Number;
    private var h:Number;
    private var _appmodel:Appmodel;

    private var _backButton:Button;

    public function Menu()
    {
        trace("[Menu] construct");

        _appmodel = Appmodel.getInstance();

        _backButton = new Button();
        _backButton.label = "terug";
        _backButton.addEventListener(Event.TRIGGERED, triggerHandler);
    }

    public function setSize(w:Number, h:Number):void{

        this.h = h;
        this.w = w;
        _backButton.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);
        addChild(_backButton);
    }

    private function buttonCreatedHandler(event:Event):void
    {
        _backButton.removeEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);
        _backButton.x = w -(_backButton.width + 10);
        _backButton.y = 10;
    }

    private function triggerHandler(event:Event):void
    {
        _appmodel.huidigScherm = "start";
    }
}
}
