/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 1/12/13
 * Time: 22:28
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view
{
import be.devine.cp3.bilsplit.model.Appmodel;

import starling.display.Sprite;

public class DeelmethodeSelectie extends Sprite
{

    private var _appmodel:Appmodel;

    public function DeelmethodeSelectie(appmodel:Appmodel)
    {
        _appmodel = appmodel;
        draw();
    }

    public function draw():void{

    }
}
}
