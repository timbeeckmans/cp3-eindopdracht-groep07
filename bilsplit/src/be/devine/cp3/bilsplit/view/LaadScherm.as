/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 12/12/13
 * Time: 20:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.BillService;
import be.devine.cp3.bilsplit.model.Billmodel;

import flash.events.Event;
import starling.events.Event;

import starling.display.Sprite;

public class LaadScherm extends Sprite implements IcanBeViewed
{
    private var _appmodel:Appmodel;
    private var _bs:BillService;
    private var w:Number;
    private var h:Number;
    private var bills:Array;

    public function LaadScherm()
    {
        _appmodel = Appmodel.getInstance();
        _appmodel.addEventListener(Appmodel.BILLS_CHANGED_EVENT, appmodel_billsChangedHandler);

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

        var array:Array = [];

        var i:uint = 0;

        for each(var bill:ContentButton in bills){
            bill.y = i;
            addChild(bill);
            i += 100;
        }
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

    }

    private function contentButton_deleteButtonPressedHandler(event:starling.events.Event):void
    {
        var button:ContentButton = event.currentTarget as ContentButton;
        trace("delete: ", button.content);
    }

    private function contentButton_loadButtonPressedHandler(event:starling.events.Event):void
    {
        var button:ContentButton = event.currentTarget as ContentButton;
        trace("load: ", button.content);
    }
}
}
