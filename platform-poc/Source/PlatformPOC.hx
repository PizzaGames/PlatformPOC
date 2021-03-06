package ;

import br.com.wolfgames.debug.DebugUI;
import br.com.wolfgames.display.RepeatedTileGroup;
import br.com.wolfgames.platform.Platform;
import br.com.wolfgames.platformpoc.sprites.MarioSprite;
import flash.display.InterpolationMethod;
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
	
	var backgroundsSheetData:String;
	var backgroundsLayer:TileLayer;
	
	var marioNormal:TileSprite;
	var marioWalking:TileClip;
	var marioRunning:TileClip;
	var marioCrouched:TileSprite;
	var marioJumping:TileSprite;
	var marioJumpingFast:TileSprite;
	
	var floorTop:RepeatedTileGroup;
	var floorBottom :RepeatedTileGroup;
	var front:RepeatedTileGroup;
	
	var parallaxBackgrounds:List<RepeatedTileGroup>;
	
	var initialMarioPos:Int = 30;
	
	private var xpos:Float = 0;
    
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
		
		backgroundsSheetData = Assets.getText("Assets/sprites/backgrounds.xml");
		var backgroundsSheet:SparrowTilesheet = new SparrowTilesheet(Assets.getBitmapData("Assets/sprites/backgrounds.png"), backgroundsSheetData);
		backgroundsLayer = new TileLayer(backgroundsSheet);
		addChild(backgroundsLayer.view);
		
		marioSheetData = Assets.getText("Assets/sprites/mario.xml");
		var tileSheetMario:SparrowTilesheet = new SparrowTilesheet(Assets.getBitmapData("Assets/sprites/mario.png"), marioSheetData);
		marioLayer = new TileLayer(tileSheetMario);
		addChild(marioLayer.view);
		
		objectsSheetData = Assets.getText("Assets/sprites/objects.xml");
		var objectsSheet:SparrowTilesheet = new SparrowTilesheet(Assets.getBitmapData("Assets/sprites/objects.png"), objectsSheetData);
		objectsLayer = new TileLayer(objectsSheet);
		addChild(objectsLayer.view);
		
		var repeatX = 200;
		
		var sky1 = new RepeatedTileGroup(backgroundsLayer, "sky_01", repeatX, 1, stageWidth, stageHeight);
		sky1.x = 0;
		sky1.y = 0;
		backgroundsLayer.addChild(sky1);
		
		var sky2 = new RepeatedTileGroup(backgroundsLayer, "sky_02", repeatX, 40, stageWidth, stageHeight);
		sky2.x = 0;
		sky2.y = sky1.y + sky1.height;
		backgroundsLayer.addChild(sky2);
		
		parallaxBackgrounds = new List<RepeatedTileGroup>();
		
		function getBackground(layer:TileLayer, tileName:String, xRepeat:Int, yRepeat:Int, x:Int, y:Int):RepeatedTileGroup {
			var bg = new RepeatedTileGroup(backgroundsLayer, tileName, xRepeat, yRepeat, stageWidth, stageHeight);
			bg.x = x;
			if (y != 0) {
				bg.y = y - bg.height;
			}
			layer.addChild(bg);
			return bg;
		}
		
		floorTop = new RepeatedTileGroup(objectsLayer, "floor", repeatX, 1, stageWidth, stageHeight);
		objectsLayer.addChild(floorTop);
		
		floorBottom = new RepeatedTileGroup(objectsLayer, "floor2", repeatX, 1, stageWidth, stageHeight);
		objectsLayer.addChild(floorBottom);
		
		
		front = getBackground(objectsLayer, "backgrounds_65", repeatX, 1, 0, 0);
		front.y = stage.stageHeight - front.height;
		
		floorTop.y = stage.stageHeight - floorBottom.height - floorTop.height;
		floorBottom.y = floorTop.y + floorTop.height;
		
		parallaxBackgrounds.add(getBackground(backgroundsLayer, "clouds", repeatX, 1, 0, 0));
		parallaxBackgrounds.add(getBackground(backgroundsLayer, "backgrounds_59", repeatX, 1, 0, Std.int(floorTop.y - 50)));
		parallaxBackgrounds.add(getBackground(backgroundsLayer, "backgrounds_57", repeatX, 1, 0, Std.int(floorTop.y - 40)));
		parallaxBackgrounds.add(getBackground(backgroundsLayer, "backgrounds_43", repeatX, 1, 0, Std.int(floorTop.y + 80)));
		
		floorMarioY = floorTop.y - floorTop.height;
		
		marioWalking = new TileClip(marioLayer, "mario_walk");
		marioWalking.x = initialMarioPos;
		marioWalking.y = floorMarioY;
		marioLayer.addChild(marioWalking);
		
		marioNormal = new TileSprite(marioLayer, "mario_normal");
		marioNormal.x = initialMarioPos;
		marioNormal.y = floorMarioY;
		marioLayer.addChild(marioNormal);
		
		marioRunning = new TileClip(marioLayer, "mario_run");
		marioRunning.x = initialMarioPos;
		marioRunning.y = floorMarioY;
		marioLayer.addChild(marioRunning);
		
		marioCrouched = new TileSprite(marioLayer, "mario_crouched");
		marioCrouched.x = initialMarioPos;
		marioCrouched.y = floorMarioY;
		marioLayer.addChild(marioCrouched);
		
		marioJumping = new TileSprite(marioLayer, "mario_jumping");
		marioJumping.x = initialMarioPos;
		marioJumping.y = floorMarioY;
		marioLayer.addChild(marioJumping);
		
		marioJumpingFast = new TileSprite(marioLayer, "mario_jumping_fast");
		marioJumpingFast.x = initialMarioPos;
		marioJumpingFast.y = floorMarioY;
		marioLayer.addChild(marioJumpingFast);
		
		debug = new DebugUI(stage);
		addChild(debug);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);		
	}
	
	var floorMarioY:Float;
	
	private function onEnterFrame(event:Event):Void {
		var controller = platform.getController(1);
		controller.poll();
		
		debug.update();
		
		var run = 6;
		var walk = 4;
		var marioSpeed = (controller.x ? run : walk); 
		var center = stage.stageWidth / 2; 
		
		var crouching = controller.down || controller.ly == -1;
		var movement = (crouching) ? 0 : controller.lx; 
		
		var mario;
		if (crouching) {
			marioNormal.visible = false;
			marioWalking.visible = false;
			marioRunning.visible = false;
			marioJumping.visible = false;
			marioCrouched.visible = true;
			mario = marioCrouched;
		} else if (movement == 0) {
			marioNormal.visible = !jumping;
			marioWalking.visible = false;
			marioRunning.visible = false;
			marioCrouched.visible = false;
			marioJumping.visible = jumping;
			marioJumpingFast.visible = false;
			mario = jumping ? marioJumping : marioNormal;
		} else {
			marioNormal.visible = false;
			marioWalking.visible = marioSpeed == walk;
			marioRunning.visible = marioSpeed == run;
			marioCrouched.visible = false;
			marioJumping.visible = false;
			marioJumpingFast.visible = false;
			var running = marioSpeed == run;
			mario = (running) ? marioRunning : marioWalking;
		}
		
		
		
		var lastXpos = xpos;
		xpos = Math.min(floorTop.width - mario.width - 10, Math.max(10, xpos + movement * marioSpeed)); 
		
		var hm = mario.width / 2; 
		if (controller.lb) {
			mario.x = initialMarioPos;
			floorTop.x = 0;
			floorBottom.x = 0;
			xpos = 0;
		}
		
		if (xpos + hm >= center) {
			if (xpos + hm + center > floorTop.width) { // after middle screen and bg has no more place to move
				mario.x = xpos + floorTop.x;
				var i = 0;
			} else {
				mario.x = center - hm;
				floorTop.x = -(xpos - mario.x);
				floorBottom.x = -(xpos - mario.x);
			}
		} else {
			floorTop.x = 0;
			floorBottom.x = 0;
			mario.x = xpos;
		}
		
		var i = 0;
		
		for (bg in parallaxBackgrounds) {
			i++;
			bg.x = Std.int(floorBottom.x * (i / 6));
		}
		
		front.x = Std.int(floorBottom.x / 1.5);
		
		if (lastXpos != xpos) { // TODO test on dpad or keyboard
			if (lastXpos - xpos > 0) {
				mario.mirror = 1;
			} else if (lastXpos - xpos < 0) {
				mario.mirror = 0;
			}
		}
		
		var limit = 200;
		var marioY = floorMarioY;
		var jumpInc:Float = 3.5;
		
		//60*(4*sqrt(x)/sqrt(200+x))
		//200*(1*sqrt(x)/sqrt(200+x))
		function func(x:Float):Float {
			//return 200 * (1 * Math.sqrt(x) / Math.sqrt(200 + x));
			return x;
		}
		
		jumping = !endingJump && controller.a;
		endingJump = endingJump || !controller.a;
		
		if (jumping && !endingJump && !releasedA) {
			if (jumpY >= limit) {
				endingJump = true;
				jumping = false;
			} 
			if (!(jumpY >= limit) && (!endingJump)) {
				jumpY += jumpInc;
			}
		} 
		
		if (endingJump || (!jumping)) {
			if (jumpY + marioY > floorMarioY) {
				jumpY -= jumpInc * 1.5;
			}
			if (jumpY <= 0) {
				endingJump = false;
				jumpY = 0;
				releasedA = controller.a;
			}
		}
		
		marioY = floorMarioY - func(jumpY);
		mario.y = marioY;
		
		
		marioLayer.render();
		objectsLayer.render();
		backgroundsLayer.render();
		
	}
	
	var releasedA = false;
	var endingJump:Bool;
	var jumping:Bool;
	var jumpY:Float = 0;
}