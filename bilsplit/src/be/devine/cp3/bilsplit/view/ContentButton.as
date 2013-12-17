/**
 * Created with IntelliJ IDEA.
 * User: Tim
 * Date: 14/12/13
 * Time: 12:10
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.bilsplit.view {
import feathers.controls.Button;
import feathers.controls.Label;
import feathers.core.FeathersControl;
import feathers.core.IFocusDisplayObject;

import starling.events.Event;

public class ContentButton extends FeathersControl implements IFocusDisplayObject
{

    protected static const INVALIDATION_FLAG_DELETE_BUTTON_FACTORY:String = "deleteButtonFactory";

    protected static const INVALIDATION_FLAG_LOAD_BUTTON_FACTORY:String = "loadButtonFactory";

    protected static const INVALIDATION_FLAG_CONTENT_LABEL_FACTORY:String = "contentLabelFactory";

    public static const LOADBUTTON_PRESSED:String = "loadButtonPressed";

    public static const DELETEBUTTON_PRESSED:String = "deleteButtonPressed";


    protected static function defaultDeleteButtonFactory():Button
    {
        return new Button();
    }

    protected static function defaultLoadButtonFactory():Button
    {
        return new Button();
    }

    protected static function defaultContentLabelFactory():Label
    {
        return new Label();
    }

    public function ContentButton()
    {
        //default
        deleteButtonLabel = "X";
        loadButtonLabel = "Bekijken";

    }

    protected var deleteButton:Button;

    protected var loadButton:Button;

    protected var contentLabel:Label;

    private var _contentText:String;

    private var _padding:Number = 30;

    public function get padding():Number
    {
        return _padding;
    }

    public function set padding(value:Number):void
    {
        _padding = value;
    }

    public function get contentText():String
    {
        return _contentText;
    }

    public function set contentText(value:String):void
    {
        if(value == _contentText)return;
        _contentText = value;

        if(contentLabel){
            contentLabel.text = value;
        }
    }

    private var _content:Object;

    public function get content():Object
    {
        return _content;
    }

    public function set content(value:Object):void
    {
        _content = value;
    }

    private var _deleteButtonLabel:String = null;

    public function get deleteButtonLabel():String
    {
        return _deleteButtonLabel;
    }

    public function set deleteButtonLabel(value:String):void
    {
        if(value == _deleteButtonLabel)return;
        _deleteButtonLabel = value;
        if(deleteButton){
            deleteButton.label = value;
        }
    }

    private var _loadButtonLabel:String = null;

    public function get loadButtonLabel():String
    {
        return _loadButtonLabel;
    }

    public function set loadButtonLabel(value:String):void
    {
        if(value == _loadButtonLabel)return;
        _loadButtonLabel = value;

        if(loadButton){
            loadButton.label = value;
        }

    }

    override protected function draw():void{

        var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
        const stateInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STATE);
        const deleteButtonFactoryInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DELETE_BUTTON_FACTORY);
        const loadButtonFactoryInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_LOAD_BUTTON_FACTORY);
        const contentLabelFactoryInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_CONTENT_LABEL_FACTORY);

        if(deleteButtonFactoryInvalid)
        {
            this.createDeleteButton();
        }

        if(loadButtonFactoryInvalid)
        {
            this.createLoadButton();
        }

        if(contentLabelFactoryInvalid){
            this.createcontentLabel();
        }

        if(deleteButtonFactoryInvalid || stateInvalid)
        {
            this.deleteButton.isEnabled = this._isEnabled;
        }

        if(loadButtonFactoryInvalid || stateInvalid)
        {
            this.loadButton.isEnabled = this._isEnabled;
        }

        if(deleteButtonFactoryInvalid || loadButtonFactoryInvalid || sizeInvalid || contentLabelFactoryInvalid)
        {
            this.layoutChildren();
        }

    }

    protected function loadContent():void
    {
        dispatchEvent(new Event(LOADBUTTON_PRESSED));
    }

    protected function deleteContent():void
    {
        dispatchEvent(new Event(DELETEBUTTON_PRESSED));
    }

    protected function createDeleteButton():void
    {
        if(this.deleteButton)
        {
            this.deleteButton.removeFromParent(true);
            this.deleteButton = null;
        }


        this.deleteButton = Button(defaultDeleteButtonFactory());
        this.deleteButton.label = deleteButtonLabel;
        this.deleteButton.addEventListener(Event.TRIGGERED, deleteButton_touchHandler);
        this.addChild(this.deleteButton);
    }

    protected function createLoadButton():void
    {
        if(this.loadButton)
        {
            this.loadButton.removeFromParent(true);
            this.loadButton = null;
        }

        this.loadButton = Button(defaultLoadButtonFactory());
        this.loadButton.label = loadButtonLabel;
        this.loadButton.padding = 50;
        this.loadButton.width = 300;
        this.loadButton.addEventListener(Event.TRIGGERED, loadButton_touchHandler);
        this.addChild(this.loadButton);

    }

    protected function createcontentLabel():void
    {
        if(this.contentLabel)
        {
            this.contentLabel.removeFromParent(true);
            this.contentLabel = null;
        }


        this.contentLabel = Label(defaultContentLabelFactory());
        this.contentLabel.text = contentText;
        this.addChild(this.contentLabel);

    }

    protected function layoutChildren():void
    {

        //TODO: layouting

        this.contentLabel.x = 0;
        this.contentLabel.y = 0;
        this.contentLabel.validate();

        this.loadButton.y = contentLabel.height + padding/2;
        this.loadButton.validate();

        this.deleteButton.y = loadButton.y;
        this.deleteButton.validate();

        this.deleteButton.x = loadButton.width + padding;
        this.loadButton.x = 0;

    }

    protected function deleteButton_touchHandler(event:Event):void
    {
        deleteContent();
    }

    protected function loadButton_touchHandler(event:Event):void
    {
        loadContent();
    }



}
}
