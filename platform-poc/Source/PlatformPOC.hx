package ;

import br.com.wolfgames.debug.DebugUI;
import br.com.wolfgames.platform.Platform;
import flash.display.Sprite;
import flash.events.Event;
import haxe.Timer;

/**
 * Main class of the POC
 */
class PlatformPOC extends Sprite {

	private var platform:Platform;
	private var debug:DebugUI;
	
	var stageWidth:Int;
	var stageHeight:Int;
    
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
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);		
	}
	
	private function onEnterFrame(event:Event):Void {
		var controller = platform.getController(1);
		controller.poll();
		
		debug.update();
	}
}