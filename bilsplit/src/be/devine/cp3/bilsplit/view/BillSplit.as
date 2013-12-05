/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 28/11/13
 * Time: 15:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.ButtonGroup;

import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.data.ListCollection;

import flash.events.Event;

import starling.display.DisplayObject;

import starling.display.Sprite;

public class BillSplit extends Sprite
{
    private var _appmodel:Appmodel;
    private var _startscherm:ScreenNavigatorItem;
    private var _nieuwScherm:DisplayObject;
    private var _navigator:ScreenNavigator;
    private var _schermen:Array;
    private var _buttons:ButtonGroup;

    public function BillSplit(appmodel:Appmodel)
    {
        _appmodel = appmodel;
        _appmodel.addEventListener(Appmodel.HUIDIGSCHERM_CHANGED_EVENT, nieuwSchermHandler);

        prepareNavigator();
        _navigator.showScreen("start");
        addChild(_navigator);
    }

    private function prepareNavigator():void
    {
        _navigator = new ScreenNavigator();

        _schermen = [

                ["start", new ScreenNavigatorItem(new StartScherm(_appmodel))],
                ["deelMethode", new ScreenNavigatorItem(new DeelmethodeSelectie(_appmodel))]

        ];

        var schermen:Array = [];

        for each(var scherm:Array in _schermen){
            scherm.push(scherm[0]);
            _navigator.addScreen(scherm[0], scherm[1]);
        }

        _appmodel.schermen = schermen;
    }

    private function nieuwSchermHandler(event:Event):void
    {
        _navigator.showScreen(_appmodel.huidigScherm);
        addChild(_navigator);
        trace("yolo123");


        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Gelijk verdeeld"},
                    { label: "Procentueel verdeeld"},
                    { label: "Proportioneel verdeeld"}
                ]);
        _appmodel.addEventListener(Appmodel.STAGE_RESIZED_EVENT, draw);
        draw();




    }
    
    private function draw():void{
        _buttons.y = 500;
        _buttons.x = 24;
        this.addChild(_buttons);

    }
}
}