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

import feathers.themes.MinimalMobileTheme;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;

public class App extends Sprite
{
    private var appmodel:Appmodel;
    private var billSplit:BillSplit;

    public function App()
    {
        new MinimalMobileTheme();
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(event:Event):void
    {
        appmodel = new Appmodel();
        stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
        stage_resizeHandler();

        billSplit = new BillSplit(appmodel);
        addChild(billSplit);
    }

    private function stage_resizeHandler(event:ResizeEvent = null):void
    {
        appmodel.resize(stage.stageWidth, stage.stageHeight);
    }
}
}
