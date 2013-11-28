/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 27/11/13
 * Time: 22:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit
{
import starling.display.Quad;
import starling.display.Sprite;

public class App extends Sprite
{
    public function App()
    {
        var testQuad:Quad = new Quad(100,100,0xAA0000);
        testQuad.x = testQuad.y = 50;
        addChild(testQuad);
    }
}
}
