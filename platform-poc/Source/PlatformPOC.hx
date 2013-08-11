package ;

import br.com.wolfgames.debug.DebugUI;
import br.com.wolfgames.platform.Platform;
import br.com.wolfgames.platformpoc.sprites.MarioSprite;
import flash.display.Sprite;
import flash.events.Event;
import haxe.Timer;

import aze.display.TileGroup;
import aze.display.TileSprite;
import aze.display.TileLayer;
import aze.display.TileClip;
import aze.display.SparrowTilesheet;

import openfl.Assets;

/**
 * Main class of the POC
 */
class PlatformPOC extends Sprite {

	private var platform:Platform;
	private var debug:DebugUI;
	
	var stageWidth:Int;
	var stageHeight:Int;
	
	var marioSheetData:String;
	var marioLayer:TileLayer;
	
	var objectsSheetData:String;
	var objectsLayer:TileLayer;
    
    public function new() {
    	super();
    	
    	trace("============================================");
    	trace("Platform POC");
    	trace("============================================");
    	
    	platform = Platform.getInstance(stage);
		
    	trace("Preparing to run init.");
		Timer.delay(init, 250);
    }
	
	private function init():Void {
		trace("Initializing game");
		
		stageWidth = stage.stageWidth;
		stageHeight = stage.stageHeight;
		
		debug = new DebugUI(stage);
		addChild(debug);
		
		marioSheetData = Assets.getText("Assets/sprites/mario.xml");
		var tileSheetMario:SparrowTilesheet = new SparrowTilesheet(Assets.getBitmapData("Assets/sprites/mario.png"), marioSheetData);
		marioLayer = new TileLayer(tileSheetMario);
		
		var marioWalking:TileClip = new TileClip(marioLayer, "mario_walk");
		marioWalking.x = 200;
		marioWalking.y = 250;
		marioWalking.fps = 10;
		marioLayer.addChild(marioWalking);
		
		objectsSheetData = Assets.getText("Assets/sprites/objects.xml");
		var objectsSheet:SparrowTilesheet = new SparrowTilesheet(Assets.getBitmapData("Assets/sprites/objects.png"), objectsSheetData);
		objectsLayer = new TileLayer(objectsSheet);
		
		
		
		
		addChild(marioLayer.view);
		/*
		var marioNormal = new TileSprite(mario, "mario_normal");
		marioNormal.x = 200;
		marioNormal.y = 250;
		mario.addChild(marioNormal);
		*/
		
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);		
	}
	
	private function onEnterFrame(event:Event):Void {
		var controller = platform.getController(1);
		controller.poll();
		
		debug.update();
		
		
		
		marioLayer.render();
		
	}
}