/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 12/12/13
 * Time: 16:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.model
{
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.events.Event;

import starling.events.EventDispatcher;

public class BillService extends EventDispatcher
{
    public var bills:Array;
    private var _billFile:File;

    public function BillService(){
        trace("[service] construct");
        _billFile = File.applicationStorageDirectory.resolvePath("bills.json");
    }

    public function load():void{
        if(!_billFile.exists) {
            save([
            "something",
                    "something"

            ]);
        }
        var readStream:FileStream = new FileStream();
        readStream.open(_billFile, FileMode.READ);
        var str:String = readStream.readUTFBytes(readStream.bytesAvailable);
        var parsedJSON:Array = JSON.parse(str) as Array;
        readStream.close();
        var bills:Array = [];


        trace("[BillService]",parsedJSON);


        for each(var bill:Object in parsedJSON) {

            trace("[BillService]",bill);

            var billmodel:Billmodel = new Billmodel();
            /*
            billmodel.totaalbedrag = bill.totaalbedrag;
            */
            bills.push(billmodel);
        }
        this.bills = bills;
        dispatchEvent(new Event(Event.COMPLETE));
    }

    public function save(array:Array):void{
        var writeStream:FileStream = new FileStream();
        writeStream.open(_billFile, FileMode.WRITE);
        writeStream.writeUTFBytes(JSON.stringify(array));
        writeStream.close();
    }
}
}
