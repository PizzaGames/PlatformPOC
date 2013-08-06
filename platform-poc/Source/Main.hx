
import br.com.wolfteam.pocs.platformpoc.Controller;
import flash.display.Sprite;
import br.com.wolfteam.pocs.platformpoc.debug.DebugUI;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Matrix;
import hxculture.Culture;
import hxculture.cultures.EnUS;
import hxculture.FormatNumber;
import openfl.Assets;

#if android
import openfl.utils.JNI;
import tv.ouya.console.api.OuyaController;
#end

#if windows
import com.furusystems.openfl.input.xinput.*;
#end

@:bitmap("Assets/haxe.png") class Image extends BitmapData { }
@:bitmap("Assets/logo.png") class LogoImage extends BitmapData { }
@:bitmap("Assets/sprites/mario.png") class MarioImage extends BitmapData { }
@:bitmap("Assets/sprites/bg.png") class FloorImage extends BitmapData { }
@:bitmap("Assets/sprites/sky.png") class SkyImage extends BitmapData { }

class Main extends Sprite {
	
	private var controllerConnected:Bool;
	private var debugUI:DebugUI;
	private var logo:Bitmap;
	
	private var incX:Int;
	private var incY:Int;
	
	public var controller:Controller;
	
	private var xLogo:Int;
	private var yLogo:Int;
	
	private var hw:Float;
	private var hh:Float;
	
	private var mario:Sprite;
	private var bg:Sprite;
	private var sky:Sprite;
	
	private var logoHeight:Float;
	private var logoWidth:Float;
	
	public function new() {
		super();
		
		debugUI = new DebugUI(stage);
		
		#if linux 
		debugUI.setPlatformName("Linux");
		#end
		
		// initializing windows controller
		#if windows 
		debugUI.setPlatformName("Windows");
		var xboxControllerConnected = XBox360Controller.isControllerConnected(0);
		if (xboxControllerConnected) {
			var nativeController = new XBox360Controller(0);
			
			nativeController.leftStick.deadZoneNorm = 0.2; 
			nativeController.rightStick.deadZoneNorm = 0.2;
			nativeController.triggerDeadzone = 30;
			
			debugUI.setControllerConfig("Controller configured correctly!");
			
			controller = new Controller(1, nativeController);
			controllerConnected = true;
		} else {
			
			debugUI.setControllerConfig("No controller (using keyboard)!");
			
			controller = new Controller(1, null);
			controllerConnected = true;
			
			controller.bindListeners(stage);
		}
		#end
		
		#if linux 
		debugUI.setControllerConfig("No controller (using keyboard)!");
			
  	controller = new Controller(1, null);
		controllerConnected = true;
		
		controller.bindListeners(stage);
		#end
		
		#if android 
		//TODO: detect generic androids
		//TODO: detect ouya
		debugUI.setPlatformName("OUYA");
		
		var getContext = JNI.createStaticMethod ("org.haxe.nme.GameActivity", "getContext", "()Landroid/content/Context;", true);
		OuyaController.init(getContext());
		var nativeController = OuyaController.getControllerByPlayer(1);
		controllerConnected = nativeController != null;
		
		controller = new Controller(1, nativeController);
		controller.bindListeners(stage);
		
		debugUI.setControllerConfig("Controller not connected properly!");
		#end
		
		var bitmap = new Bitmap (new Image (0, 0));
		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2;
		
		logo = new Bitmap(new LogoImage(0, 0));// Assets.getMovieClip("library:Haxe");
		xLogo = 0;
		yLogo = 0;
		
		logo.x = xLogo;
		logo.y = yLogo;
		
		mario = new Sprite();
		mario.addChild(new Bitmap(new MarioImage(0, 0)));
		
		bg = new Sprite();
		bg.addChild(new Bitmap(new FloorImage(0, 0)));
		
		sky = new Sprite();
		sky.addChild(new Bitmap(new SkyImage(0, 0)));
		
		addChild(sky);
		addChild(mario);
		addChild(bg);
		
		addChild(logo);
		addChild(bitmap);
		
		incX = 5;
		incY = 5;
		
		logoWidth = logo.width;
		logoHeight = logo.height;
		hw = logoWidth / 2;
		hh = logoHeight / 2;
		
		addChild(debugUI);
		
		addEventListener(Event.ENTER_FRAME, function(evt:Event):Void {
			update();
		});		
	}
	
	private var angle:Int = 0;
	private var xpos:Float = 0;
	
	private function update() {
		#if windows
		//TODO: avoid repaint UI
		if (controllerConnected) {
			controller.poll(); // check for button pressed on controller
			debugUI.updateControllerInfo(controller);
		}
		
		#end
		
		#if android
		debugUI.updateControllerInfo(controller);
		#end
		
		debugUI.updateFPS();
		
		
		var speed = 10;
		xLogo = Std.int(Math.max(0, Math.min(controller.rx * speed + xLogo, stage.stageWidth - logo.width)));
		yLogo = Std.int(Math.max(0, Math.min(-controller.ry * speed + yLogo, stage.stageHeight - logo.height)));
		
		//angle = angle + Std.int(controller.lx * 3);
		
		var pivotX = xLogo + hw;
		var pivotY = yLogo + hh;
		
		var center = stage.stageWidth / 2;
		
		
		var marioSpeed = (controller.x || controller.u ? 10 : 5);
		
		var movement = controller.lx;
		
	  //logoMatrix.translate(xLogo + hw, yLogo + hh);
		
		
		xpos = Math.min(bg.width - mario.width - 10, Math.max(10, xpos + movement * marioSpeed));
		
		var hm = mario.width / 2;
		
		if (controller.l) {
			mario.x = 0;
			bg.x = 0;
			xpos = 0;
		}
		
		debugUI.setDebugMessage("xpos: " + xpos + "; bg.x:" + bg.x + "; mario.x: " + mario.x);
		
		
		if (xpos + hm >= center) {
			if (xpos + hm + center > bg.width) {
				mario.x = xpos + bg.x;
			} else {
				mario.x = center - hm;
				bg.x = -(xpos - mario.x);
			}
		} else {
			bg.x = 0;
			mario.x = xpos;
		}
		
		angle = angle + Std.int(controller.lx * marioSpeed/1.5);
		
		var logoMatrix:Matrix = new Matrix();
		logoMatrix.translate(-hw, -hh);
		logoMatrix.rotate((angle * Math.PI) / 180);
		logoMatrix.translate(mario.x - logoWidth - 30 + hw, bg.y - logoHeight - 10 + hh);
		logo.transform.matrix = logoMatrix;
		
		bg.y = stage.stageHeight - bg.height;
		mario.y = bg.y - mario.height;
		
		if (movement >= 0) {
		    //mario.transform
		    mario.scaleX = 1;
		} else {
  		  mario.scaleX = -1;
  		  mario.x = mario.x + mario.width;
		}
		
	}
}
