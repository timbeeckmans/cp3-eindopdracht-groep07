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

public class DeelmethodeSelectie extends Sprite implements IcanBeViewed
{
    private var w:Number;
    private var h:Number;
    private var _layout:LayoutGroup;

    private var _appmodel:Appmodel;
    private var _buttons:ButtonGroup;

    [Embed(source = "/../assets/images/billsplitterlogogrootmethodesel.png")]
    private static const Background:Class;


    public function DeelmethodeSelectie()
    {
        _layout = new LayoutGroup();

        _appmodel = Appmodel.getInstance();
        _buttons = new ButtonGroup();
        _buttons.dataProvider = new ListCollection(
                [
                    { label: "Gelijk verdeeld", triggered: GelijkMethode_clickhandler},
                    { label: "Procentueel verdeeld", triggered: ProcentueelMethode_clickhandler},
                    { label: "Proportioneel verdeeld", triggered: ProportioneelMethode_clickhandler}
                ]);


    }

    public function setSize(w:Number, h:Number):void{

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
        background.y = 200;
        _layout.addChild(background);

        this.h = h;
        this.w = w;

        _buttons.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);

        _layout.addChild(_buttons);
        addChild(_layout);
    }


    private function GelijkMethode_clickhandler( event:Event ):void
    {
        _appmodel.huidigeBill = new Billmodel();
        _appmodel.huidigeBill.type = "gelijkMethode";
        _appmodel.huidigScherm = "gelijkMethode";
    }

    private function ProcentueelMethode_clickhandler( event:Event ):void
    {
        _appmodel.huidigeBill = new Billmodel();
        _appmodel.huidigeBill.type = "procentueelMethode";
        _appmodel.huidigScherm = "procentueelMethode";
    }

    private function ProportioneelMethode_clickhandler( event:Event ):void
    {
        _appmodel.huidigeBill = new Billmodel();
        _appmodel.huidigeBill.type = "proportioneelMethode";
        _appmodel.huidigScherm = "proportioneelMethode";
    }

    private function buttonCreatedHandler(event:Event = null):void
    {
        _buttons.removeEventListener(FeathersEventType.CREATION_COMPLETE, buttonCreatedHandler);

        _buttons.x = w/2 - _buttons.width / 2;
        _buttons.y = h - (_buttons.height + 50);

    }

}
}
