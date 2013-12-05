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

import starling.display.Sprite;
import starling.events.Event;

public class StartScherm extends Sprite
{
    private var _buttons:ButtonGroup;
    private var _appmodel:Appmodel;

    static const NIEUW_CLICKED:String = "nieuwClicked";
    static const OUD_CLICKED:String = "oudClicked";
    static const INSTRUCTIE_CLICKED:String = "instructieClicked";

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

    public function draw():void{
        //zou moeten centraal staan, maar _buttons.width geeft 0 terug...
        //_buttons.x = _appmodel.stageWidth/2 - _buttons.width / 2;

        //voorlopig:
        _buttons.y = 500;
        _buttons.x = 24;
        this.addChild(_buttons);

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
