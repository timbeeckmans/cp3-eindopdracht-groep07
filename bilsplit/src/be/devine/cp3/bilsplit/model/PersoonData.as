/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 7/12/13
 * Time: 20:26
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.model
{
public class PersoonData
{
    private var _naam:String;
    private var _procentTeBetalen:Number;

    public function PersoonData(naam:String)
    {
        _naam = naam;
        _procentTeBetalen = 0;
    }

    public function toString():String
    {
        return "PersoonData{ naam = " + String(_naam) + " }";
    }

    public function get naam():String
    {
        return _naam;
    }

    public function set naam(value:String):void
    {
        _naam = value;
    }

    public function get procentTeBetalen():Number
    {
        return _procentTeBetalen;
    }

    public function set procentTeBetalen(value:Number):void
    {
        _procentTeBetalen = value;
    }
}
}
