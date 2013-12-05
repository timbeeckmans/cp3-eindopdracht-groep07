package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;

import starling.display.Sprite;

public class ProcentueelMethode extends Sprite implements IcanBeViewed {

    private var _appmodel:Appmodel;

    public function ProcentueelMethode() {
        _appmodel = Appmodel.getInstance();

        trace("procentueelmethode");

    }

    public function setSize(w:Number, h:Number):void{

    }

}
}
