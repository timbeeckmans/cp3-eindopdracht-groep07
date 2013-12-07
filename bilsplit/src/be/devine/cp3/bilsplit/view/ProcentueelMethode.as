package be.devine.cp3.bilsplit.view {
import be.devine.cp3.bilsplit.model.Appmodel;
import be.devine.cp3.bilsplit.model.PersoonData;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;

import starling.display.Sprite;
import starling.events.Event;

public class ProcentueelMethode extends Sprite implements IcanBeViewed {

    private var _appmodel:Appmodel;
    private var _addPersoon:Button;
    private var _removePersoon:Button;
    private var _layout:LayoutGroup;

    public function ProcentueelMethode() {
        _appmodel = Appmodel.getInstance();
        var eerstePersoon:PersoonData = new PersoonData("ik");
        eerstePersoon.procentTeBetalen = 100;
        _appmodel.addPersoon(eerstePersoon);

        _addPersoon = new Button();
        _addPersoon.label = "voeg een persoon toe.";
        _addPersoon.addEventListener(Event.TRIGGERED, addPersoon_triggeredHandler);

        _removePersoon = new Button();
        _removePersoon.label = "verwijder een persoon.";
        _removePersoon.addEventListener(Event.TRIGGERED, removePersoon_triggeredHandler);
    }

    public function setSize(w:Number, h:Number):void{
        _layout = new LayoutGroup();
        _removePersoon.y = 70;
        _layout.addChild(_addPersoon);
        _layout.addChild(_removePersoon);
        addChild(_layout);

    }

    private function addPersoon_triggeredHandler(e:Event):void
    {
        trace("[procentueelmethode] add persoon");
        var nieuwPersoon:PersoonData = new PersoonData("persoon " + _appmodel.aantalPersonen);
        _appmodel.addPersoon(nieuwPersoon);
    }

    private function removePersoon_triggeredHandler(event:Event):void
    {
        trace("[procentueelmethode] remove persoon");
        var oudPersoon:PersoonData = _appmodel.personen[0];
        //voorlopig: verwijderd de eerste persoon
        _appmodel.removePersoon(oudPersoon);
    }
}
}
