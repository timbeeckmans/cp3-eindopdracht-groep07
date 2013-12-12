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
    private var _personen:Array;
    private var _aantalPersonen:uint;
    private var _voorwerpen:Array;
    private var _totaalBedrag:Number;
    private var _huidigScherm:String;
    private var _schermen:Array;

    public static const PERSONEN_CHANGED_EVENT:String = "personenChanged";
    public static const VOORWERPEN_CHANGED_EVENT:String = "voorwerpenChanged";
    public static const TOTAALBEDRAG_CHANGED_EVENT:String = "totaalBedragChanged";
    public static const HUIDIGSCHERM_CHANGED_EVENT:String = "huidigSchermChanged";

    static private var instance:Appmodel;
    static public function getInstance():Appmodel{
        if (instance == null){
            instance = new Appmodel(new Enforcer());
        }
        return instance;
    }

    public function Appmodel(e:Enforcer){

        if(e == null){

        }

        _personen = [];
        _aantalPersonen = 0;
        _voorwerpen = [];
        _totaalBedrag = 0;
    }

    [Bindable(event="personenChanged")]
    public function get personen():Array
    {
        return _personen;
    }

    public function set personen(value:Array):void
    {
        if (_personen == value) return;
        _personen = value;
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

    [Bindable(event="voorwerpenChanged")]
    public function get voorwerpen():Array
    {
        return _voorwerpen;
    }

    public function set voorwerpen(value:Array):void
    {
        if (_voorwerpen == value) return;
        _voorwerpen = value;
        dispatchEvent(new Event(VOORWERPEN_CHANGED_EVENT));
    }

    [Bindable(event="totaalBedragChanged")]
    public function get totaalBedrag():Number
    {
        return _totaalBedrag;
    }

    public function set totaalBedrag(value:Number):void
    {
        if (_totaalBedrag == value) return;
        _totaalBedrag = value;
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
        return _aantalPersonen;
    }

    public function set aantalPersonen(value:uint):void
    {
        _aantalPersonen = value;
    }
}
}
internal class Enforcer{}
