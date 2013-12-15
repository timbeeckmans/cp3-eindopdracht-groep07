/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 28/11/13
 * Time: 15:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.model
{

import flash.events.Event;
import flash.events.EventDispatcher;


public class Appmodel extends EventDispatcher
{
    private var _bills:Array;
    private var _huidigeBill:Billmodel;
    private var _bs:BillService;

    /*
    private var _personen:Array;
    private var _aantalPersonen:uint;
    private var _voorwerpen:Array;
    private var _totaalBedrag:Number;
    */

    private var _huidigScherm:String;
    private var _schermen:Array;

    public static const PERSONEN_CHANGED_EVENT:String = "personenChanged";
    public static const VOORWERPEN_CHANGED_EVENT:String = "voorwerpenChanged";
    public static const TOTAALBEDRAG_CHANGED_EVENT:String = "totaalBedragChanged";
    public static const HUIDIGSCHERM_CHANGED_EVENT:String = "huidigSchermChanged";

    static private var instance:Appmodel;
    public static const BILLS_CHANGED_EVENT:String = "billsChanged";
    static public function getInstance():Appmodel{
        if (instance == null){
            instance = new Appmodel(new Enforcer());
        }
        return instance;
    }

    public function Appmodel(e:Enforcer){

        if(e == null){
            throw new Error("Appmodel is a singleton");
        }
        _bs = new BillService()
    }

    [Bindable(event="personenChanged")]
    public function get personen():Array
    {
        return _huidigeBill.personen;
    }

    public function set personen(value:Array):void
    {
        if (_huidigeBill.personen == value) return;
        _huidigeBill.personen = value;
        aantalPersonen = value.length;
        dispatchEvent(new Event(PERSONEN_CHANGED_EVENT));
    }

    public function addPersoon(value:PersoonData):void{
        personen.push(value);
        aantalPersonen ++;
    }

    public function removePersoon(value:PersoonData):void{
        if(personen.length == 0) return;
        var newarray:Array = personen;
        newarray.splice(newarray.indexOf(value),1);
        personen = newarray;
        aantalPersonen --;
    }

    [Bindable(event="totaalBedragChanged")]
    public function get totaalBedrag():Number
    {
        return _huidigeBill.totaalBedrag;
    }

    public function set totaalBedrag(value:Number):void
    {
        if (_huidigeBill.totaalBedrag == value) return;
        _huidigeBill.totaalBedrag = value;
        dispatchEvent(new Event(TOTAALBEDRAG_CHANGED_EVENT));
    }

    [Bindable(event="huidigSchermChanged")]
    public function get huidigScherm():String
    {
        return _huidigScherm;
    }

    public function set huidigScherm(value:String):void
    {
        if (_huidigScherm == value) return;
        _huidigScherm = value;
        dispatchEvent(new Event(HUIDIGSCHERM_CHANGED_EVENT));
        trace("[Appmodel] huidigscherm:", _huidigScherm);
    }

    public function get schermen():Array
    {
        return _schermen;
    }

    public function set schermen(value:Array):void
    {
        _schermen = value;
    }

    public function get aantalPersonen():uint
    {
        return _huidigeBill.aantalPersonen;
    }

    public function set aantalPersonen(value:uint):void
    {
        _huidigeBill.aantalPersonen = value;
    }


    [Bindable(event="billsChanged")]
    public function get bills():Array
    {
        return _bills;
    }

    public function set bills(value:Array):void
    {
        if (_bills == value) return;
        _bills = value;
        trace("get in there");
        dispatchEvent(new Event(BILLS_CHANGED_EVENT));
    }

    public function addBill(bill:Billmodel):void{
        var array:Array = bills.concat();
        array.push(bill);
        bills = array;
        _bs.save(bills);
    }

    public function deleteBill(bill:Billmodel):void{
        if(bills.length == 0) return;
        var newarray:Array = bills.concat();
        newarray.splice(newarray.indexOf(bill),1);
        bills = newarray;
        _bs.save(bills);
    }

    public function get huidigeBill():Billmodel
    {
        return _huidigeBill;
    }

    public function set huidigeBill(value:Billmodel):void
    {
        _huidigeBill = value;
    }
}
}
internal class Enforcer{}
