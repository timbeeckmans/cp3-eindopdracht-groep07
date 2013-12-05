/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 28/11/13
 * Time: 15:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit
{
import be.devine.cp3.bilsplit.view.*;
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.LayoutGroup;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.themes.MinimalMobileTheme;

import flash.events.MouseEvent;

import starling.display.Sprite;

import flash.events.Event;

import starling.events.Event;
import starling.events.ResizeEvent;

public class BillSplit extends Sprite
{
    private var _appmodel:Appmodel;
    private var _navigator:ScreenNavigator;
    private var _schermen:Array;
    private var _hoofdMenu:Menu;

    public function BillSplit()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, init);
    }

    private function prepareNavigator():void
    {
        _navigator = new ScreenNavigator();
        _hoofdMenu = new Menu();
        _schermen = [

                ["start", new ScreenNavigatorItem(StartScherm)],
                ["deelMethode", new ScreenNavigatorItem(DeelmethodeSelectie)],
                ["gelijkMethode", new ScreenNavigatorItem(GelijkMethode)],
                ["procentueelMethode", new ScreenNavigatorItem(ProcentueelMethode)],
                ["proportioneelMethode", new ScreenNavigatorItem(ProportioneelMethode)]

                //["naam"], new ScreenNavigator(new Klassenaam),

        ];

        var schermen:Array = [];

        for each(var scherm:Array in _schermen){
            scherm.push(scherm[0]);
            _navigator.addScreen(scherm[0], scherm[1]);
        }

        _appmodel.schermen = schermen;
    }

    private function nieuwSchermHandler(event:flash.events.Event):void
    {
        _navigator.showScreen(_appmodel.huidigScherm);
        resizeHandler();
        addChild(_navigator);

    }

    private function init(event:starling.events.Event):void
    {
        this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, init);
        new MinimalMobileTheme();
        _appmodel = Appmodel.getInstance();
        prepareNavigator();
        addChild(_hoofdMenu);
        _appmodel.addEventListener(Appmodel.HUIDIGSCHERM_CHANGED_EVENT, nieuwSchermHandler);
        _appmodel.huidigScherm = "start";
        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);
    }

    private function resizeHandler(event:starling.events.Event = null):void
    {
        var w:Number = stage.stageWidth;
        var h:Number = stage.stageHeight;
        var huidigScherm:IcanBeViewed = _navigator.activeScreen as IcanBeViewed;
        huidigScherm.setSize(w,h);
        _hoofdMenu.setSize(w, h);
    }
}
}
