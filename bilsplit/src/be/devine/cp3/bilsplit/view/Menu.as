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
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

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

        if(_appmodel.huidigScherm = 'start'){
            removeChild(_backButton);
        }
    }

    private function triggerHandler(event:Event):void
    {
        switch (_appmodel.huidigScherm){

            case 'start':
                trace('[menu] start');
                break;

            case 'deelMethode':
                _appmodel.huidigScherm = 'start';
                break;

            case 'gelijkMethode':
                _appmodel.huidigScherm = 'deelMethode';
                break;

            case 'procentueelMethode':
                _appmodel.huidigScherm = 'deelMethode';
                break;

            case 'proportioneelMethode':
                _appmodel.huidigScherm = 'deelMethode';
                break;

            case 'laden':
                _appmodel.huidigScherm = 'start';
                break;

        }

    }

    public function checkVisible():void{
        _backButton.visible = !(_appmodel.huidigScherm == 'start');
        trace(_appmodel.huidigScherm);
        trace(_backButton.visible);

    }
}
}
