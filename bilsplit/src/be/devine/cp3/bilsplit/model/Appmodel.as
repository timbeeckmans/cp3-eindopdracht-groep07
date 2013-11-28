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
    private var _voorwerpen:Array;
    private var _totaalBedrag:Number;
    public static const PERSONEN_CHANGED_EVENT:String = "personenChanged";
    public static const VOORWERPEN_CHANGED_EVENT:String = "voorwerpenChanged";
    public static const TOTAALBEDRAG_CHANGED_EVENT:String = "totaalBedragChanged";

    public function Appmodel(){
        _personen = [];
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
        dispatchEvent(new Event(PERSONEN_CHANGED_EVENT));
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
}
}
