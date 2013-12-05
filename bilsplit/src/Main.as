package {

import be.devine.cp3.bilsplit.view.BillSplit;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;

public class Main extends Sprite {

    private var app:Starling;

    public function Main() {

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        app = new Starling(BillSplit, stage);
        app.start();

        stage.addEventListener(Event.RESIZE, resizeHandler);
    }

    private function resizeHandler(event:Event):void {
        trace("[Main] resize");
        app.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        app.stage.stageWidth = stage.stageWidth;
        app.stage.stageHeight = stage.stageHeight;
    }
}
}
