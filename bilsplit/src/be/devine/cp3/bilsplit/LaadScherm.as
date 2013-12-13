/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 12/12/13
 * Time: 20:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit
{
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.BillService;
import be.devine.cp3.bilsplit.model.Billmodel;
import be.devine.cp3.bilsplit.view.IcanBeViewed;

import feathers.data.ListCollection;

import flash.events.Event;

import starling.events.Event;

import starling.display.Sprite;

public class LaadScherm extends Sprite implements IcanBeViewed
{
    private var _appmodel:Appmodel;
    private var _bs:BillService;
    private var w:Number;
    private var h:Number;

    public function LaadScherm()
    {
        _appmodel = Appmodel.getInstance();
        _appmodel.addEventListener(Appmodel.BILLS_CHANGED_EVENT, appmodel_billsChangedHandler);

    }

    public function setSize(w:Number, h:Number):void{
        this.w = w;
        this.h = h;
        for each(var item:Billmodel in _appmodel.bills){
            trace("[Laadscherm]", item);
        }
    }

    private function appmodel_billsChangedHandler(event:flash.events.Event):void
    {


    }
}
}
