/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 27/11/13
 * Time: 22:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit
{
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.view.BillSplit;

import starling.display.Sprite;

public class App extends Sprite
{
    private var appmodel:Appmodel;
    private var billSplit:BillSplit;

    public function App()
    {
        appmodel = new Appmodel();
        billSplit = new BillSplit(appmodel);
        addChild(billSplit);
    }
}
}
