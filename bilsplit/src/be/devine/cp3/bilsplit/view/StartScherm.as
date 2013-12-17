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
import be.devine.cp3.bilsplit.model.Billmodel;

import feathers.controls.ButtonGroup;
import feathers.controls.LayoutGroup;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

    public class StartScherm extends Sprite implements IcanBeViewed
{
    private var w:Number;
    private var h:Number;

    private var _layout:LayoutGroup;
    private var _buttons:ButtonGroup;
    private var _appmodel:Appmodel;

    [Embed(source = "/../assets/images/billsplitterlogogroot.png")]
    private static const Background:Class;
    [Embed(source = "/../assets/images/billsplitterlogoklein.png")]
    private static const Logo:Class;


    public function StartScherm()
    {

        _layout = new LayoutGroup();




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

        _layout = new LayoutGroup();

        var topColor:uint = 0xbb670d; // blue
        var bottomColor:uint = 0xf5c089; // red

        var quad:Quad = new Quad(w, h);
        quad.setVertexColor(0, topColor);
        quad.setVertexColor(1, topColor);
        quad.setVertexColor(2, bottomColor);
        quad.setVertexColor(3, bottomColor);
        _layout.addChild(quad);

        var background:Image = Image.fromBitmap(new Background());
        background.x = ( w / 2 ) - ( background.width / 2 );
        _layout.addChild(background);


        this.w = w;
        this.h = h;

        _buttons.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);



        _layout.addChild(_buttons);
        addChild(_layout);

    }

    private function nieuw_clickhandler( event:Event ):void
    {
        _appmodel.huidigScherm = "deelMethode";
    }

    private function oud_clickhandler( event:Event ):void
    {
        _appmodel.huidigScherm = "laden";
    }

    private function instructie_clickhandler( event:Event ):void
    {
        //_appmodel.huidigScherm =
    }

}
}
