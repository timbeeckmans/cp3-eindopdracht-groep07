package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.BillService;
import be.devine.cp3.bilsplit.model.Billmodel;

import feathers.controls.LayoutGroup;

import feathers.controls.ScrollContainer;

import flash.events.Event;

import starling.display.Image;
import starling.display.Quad;
import starling.events.Event;

import starling.display.Sprite;

public class LaadScherm extends Sprite implements IcanBeViewed
{
    private var _appmodel:Appmodel;
    private var _bs:BillService;
    private var w:Number;
    private var h:Number;
    private var bills:Array;
    private var _container:ScrollContainer;
    private var _layout:LayoutGroup;

    [Embed(source = "/../assets/images/billsplitterlogoklein.png")]
    private static const Logo:Class;

    public function LaadScherm()
    {
        _appmodel = Appmodel.getInstance();
        _appmodel.addEventListener(Appmodel.BILLS_CHANGED_EVENT, appmodel_billsChangedHandler);
        _layout = new LayoutGroup();
        var i:uint = 0;
        bills = [];

        for each(var item:Billmodel in _appmodel.bills){
            var contentButton:ContentButton = new ContentButton();
            contentButton.contentText = "bill " + i;
            contentButton.content = i;
            contentButton.addEventListener(ContentButton.DELETEBUTTON_PRESSED, contentButton_deleteButtonPressedHandler);
            contentButton.addEventListener(ContentButton.LOADBUTTON_PRESSED, contentButton_loadButtonPressedHandler);

            bills.push(contentButton);
            i++;
        }

    }

    public function setSize(w:Number, h:Number):void{
        this.w = w;
        this.h = h;

        var topColor:uint = 0xbb670d;
        var bottomColor:uint = 0xf5c089;
        var quad:Quad = new Quad(w, h);
        quad.setVertexColor(0, topColor);
        quad.setVertexColor(1, topColor);
        quad.setVertexColor(2, bottomColor);
        quad.setVertexColor(3, bottomColor);
        addChild(quad);

        var i:uint = 0;
        if(_container){
            removeChild(_container);
        }


        _container = new ScrollContainer();
        _container.elasticity = 0.5;
        _container.width = w;
<<<<<<< HEAD
        _container.height = 400;
=======
        _container.height = h - 100;
>>>>>>> changes
        _container.y = 80;
        _container.padding = 10;
        _container.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;

        var quad1:Quad = new Quad(_container.width, _container.height);
        quad1.setVertexColor(0, topColor);
        quad1.setVertexColor(1, topColor);
        quad1.setVertexColor(2, bottomColor);
        quad1.setVertexColor(3, bottomColor);
        addChild(quad);


        for each(var bill:ContentButton in bills){
            bill.y = i;
            bill.x = 20;
            _container.addChild(bill);
            i += 100;
        }

        var logo:Image = Image.fromBitmap(new Logo());
        logo.x = 10;
        logo.y = 10;
        _layout.addChild(logo);
        addChild(_layout);


        _container.backgroundSkin = quad1;
        addChild( _container );
    }

    private function appmodel_billsChangedHandler(event:flash.events.Event):void
    {
        var i:uint = 0;
        bills = [];


        for each(var item:Billmodel in _appmodel.bills){
            var contentButton:ContentButton = new ContentButton();
            contentButton.contentText = "bill " + i;
            contentButton.content = i;
            contentButton.addEventListener(ContentButton.DELETEBUTTON_PRESSED, contentButton_deleteButtonPressedHandler);
            contentButton.addEventListener(ContentButton.LOADBUTTON_PRESSED, contentButton_loadButtonPressedHandler);
            bills.push(contentButton);
            i++;
        }

        setSize(w,h);


    }

    private function contentButton_deleteButtonPressedHandler(event:starling.events.Event):void
    {
        var button:ContentButton = event.currentTarget as ContentButton;
        _appmodel.deleteBill(_appmodel.bills[uint(button.content)]);

    }

    private function contentButton_loadButtonPressedHandler(event:starling.events.Event):void
    {
        var button:ContentButton = event.currentTarget as ContentButton;
        _appmodel.huidigeBill = _appmodel.bills[uint(button.content)];
        trace("[LaadScherm]",_appmodel.huidigeBill);
        _appmodel.huidigScherm = _appmodel.huidigeBill.type;
        trace("[LaadScherm]",_appmodel.huidigeBill);

    }
}
}
