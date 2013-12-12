/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 11/12/13
 * Time: 21:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import feathers.controls.Slider;

public class PersoonView extends Slider
{
    public static const PROCENTUEEL:String = "procentueel";
    public static const PROPORTIONEEL:String = "proportioneel"

    private var _type:String;
    private var _label:String;
    private var _waarde:Number;

    public function PersoonView(type:String, label:String, waarde:Number = 0)
    {
        _type = type;
        _label = label;
        _waarde = waarde;
        minimum = 0;
        maximum = 100;
        step = 1;
        page = 10;
        value = waarde;
    }
}
}
