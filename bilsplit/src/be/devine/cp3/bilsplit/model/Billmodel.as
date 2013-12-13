/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 12/12/13
 * Time: 16:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.model
{
import flash.events.Event;
import flash.events.EventDispatcher;

public class Billmodel extends EventDispatcher
{
    private var _personen:Array;
    private var _aantalPersonen:uint;
    private var _totaalBedrag:Number;
    public static const PERSONEN_CHANGED_EVENT:String = "personenChanged";
    public static const AANTALPERSONEN_CHANGED_EVENT:String = "aantalPersonenChanged";
    public static const VOORWERPEN_CHANGED_EVENT:String = "voorwerpenChanged";
    public static const TOTAALBEDRAG_CHANGED_EVENT:String = "totaalBedragChanged";

    public function Billmodel()
    {
        personen = [];
        aantalPersonen = 0;
        totaalBedrag = 0;
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
        dispatchEvent(new Event(PERSONEN_CHANGED_EVENT));
    }

    [Bindable(event="aantalPersonenChanged")]
    public function get aantalPersonen():uint
    {
        return _aantalPersonen;
    }

    public function set aantalPersonen(value:uint):void
    {
        if (_aantalPersonen == value) return;
        _aantalPersonen = value;
        dispatchEvent(new Event(AANTALPERSONEN_CHANGED_EVENT));
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


    public override function toString():String
    {
        return super.toString() + "{_personen=" + String(_personen) + ",_aantalPersonen=" + String(_aantalPersonen) + ",_totaalBedrag=" + String(_totaalBedrag) + "}";
    }
}
}
