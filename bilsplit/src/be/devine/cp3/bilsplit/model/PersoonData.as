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
    private var _bedragTeBetalen:Number;

    public function PersoonData(naam:String)
    {
        this.naam = naam;
        _procentTeBetalen = 0;
        _bedragTeBetalen = 0;
    }

    public function get naam():String
    {
        return _naam;
    }

    public function set naam(value:String):void
    {
        _naam = value;
    }

    public function get bedragTeBetalen():Number
    {
        return _bedragTeBetalen;
    }

    public function set bedragTeBetalen(value:Number):void
    {
        _bedragTeBetalen = value;
    }

    public function get procentTeBetalen():Number
    {
        return _procentTeBetalen;
    }

    public function set procentTeBetalen(value:Number):void
    {
        if (_procentTeBetalen == value) return;
        _procentTeBetalen = value;
    }


}
}
