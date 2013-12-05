package be.devine.cp3.bilsplit.view
{


import be.devine.cp3.bilsplit.model.Appmodel;

import feathers.controls.ButtonGroup;
import feathers.data.ListCollection;

import starling.display.Sprite;
import starling.events.Event;

public class DeelmethodeSelectie extends Sprite
{

    private var _appmodel:Appmodel;
    private var _buttons:ButtonGroup;

    public function DeelmethodeSelectie()
    {
        _appmodel = Appmodel.getInstance();
        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Gelijk verdeeld", triggered: _clickhandler},
                    { label: "Procentueel verdeeld", triggered: _clickhandler},
                    { label: "Proportioneel verdeeld", triggered: _clickhandler}
                ]);

        _appmodel.addEventListener(Appmodel.STAGE_RESIZED_EVENT, draw);
        draw();
    }

    public function draw():void{
        //zou moeten centraal staan, maar _buttons.width geeft 0 terug...
        //_buttons.x = _appmodel.stageWidth/2 - _buttons.width / 2;

        //voorlopig:
        _buttons.y = 500;
        _buttons.x = 24;
        this.addChild(_buttons);




    }

    function _clickhandler( event:Event ):void
    {
        _appmodel.huidigScherm = "deelMethode";
    }
}
}
