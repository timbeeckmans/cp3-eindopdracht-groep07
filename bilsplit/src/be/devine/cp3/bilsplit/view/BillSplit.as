/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 28/11/13
 * Time: 15:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;

import starling.display.Sprite;

public class BillSplit extends Sprite
{
    private var _appmodel:Appmodel;

    public function BillSplit(appmodel:Appmodel)
    {
        _appmodel = appmodel;
    }
}
}
