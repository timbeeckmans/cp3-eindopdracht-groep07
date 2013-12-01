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

public class StartScreen extends Sprite implements ICanBeViewed
{
    private var _buttons:ButtonGroup;
    private var _appmodel:Appmodel;

    static const NIEUW_CLICKED:String = "nieuwClicked";
    static const OUD_CLICKED:String = "oudClicked";
    static const INSTRUCTIE_CLICKED:String = "instructieClicked";

    public function StartScreen(appmodel:Appmodel)
    {
        _appmodel = appmodel;

        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Nieuwe rekening", triggered: nieuw_clickhandler},
                    { label: "Oude rekening laden", triggered: oud_clickhandler},
                    { label: "Instructies", triggered: instructie_clickhandler}
                ]);
        draw();
    }

    public function draw():void{
        this.addChild(_buttons);
    }

    function nieuw_clickhandler( event:Event ):void
    {
        dispatchEvent(new Event(NIEUW_CLICKED));
    }

    function oud_clickhandler( event:Event ):void
    {
        dispatchEvent(new Event(OUD_CLICKED));
    }

    function instructie_clickhandler( event:Event ):void
    {
        dispatchEvent(new Event(INSTRUCTIE_CLICKED));
    }
}
}
