package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;

import starling.display.Sprite;

public class ProportioneelMethode extends Sprite implements IcanBeViewed {

    private var _appmodel:Appmodel;

    public function ProportioneelMethode() {

        _appmodel = Appmodel.getInstance();

        trace("[proportioneelmethode]");

    }

    public function setSize(w:Number, h:Number):void{

    }

}
}
