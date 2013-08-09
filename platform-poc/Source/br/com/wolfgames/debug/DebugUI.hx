package br.com.wolfgames.debug;

import br.com.wolfgames.input.Controller;
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Point;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import hxculture.Culture;
import hxculture.FormatNumber;
import hxculture.cultures.EnUS;
import openfl.Assets;
import flash.display.BitmapData;
import flash.display.Bitmap;
import haxe.Timer;

@:font("Assets/AutourOne-Regular.ttf") class DefaultFont extends Font { }

#if (windows || linux)
@:bitmap("Assets/buttons/a.png") class AImage extends BitmapData { }
@:bitmap("Assets/buttons/b.png") class BImage extends BitmapData { }
@:bitmap("Assets/buttons/x.png") class XImage extends BitmapData { }
@:bitmap("Assets/buttons/y.png") class YImage extends BitmapData { }
@:bitmap("Assets/buttons/back.png") class BackImage extends BitmapData { }
#end

#if android
@:bitmap("Assets/buttons/ouyaO.png") class OuyaOImage extends BitmapData { }
@:bitmap("Assets/buttons/ouyaU.png") class OuyaUImage extends BitmapData { }
@:bitmap("Assets/buttons/ouyaY.png") class OuyaYImage extends BitmapData { }
@:bitmap("Assets/buttons/ouyaA.png") class OuyaAImage extends BitmapData { }
#end

@:bitmap("Assets/buttons/start.png") class StartImage extends BitmapData { }
@:bitmap("Assets/buttons/lb.png") class LBImage extends BitmapData { }
@:bitmap("Assets/buttons/rb.png") class RBImage extends BitmapData { }
@:bitmap("Assets/buttons/up.png") class UpImage extends BitmapData { }
@:bitmap("Assets/buttons/down.png") class DownImage extends BitmapData { }
@:bitmap("Assets/buttons/left.png") class LeftImage extends BitmapData { }
@:bitmap("Assets/buttons/right.png") class RightImage extends BitmapData { }

class DebugUI extends Sprite {
	
	private var platformName:TextField;
	private var controllerConfig:TextField;
	private var buttonsPressed:TextField;
	private var fpsText:TextField;
	private var dbgText:TextField;
	private var culture:Culture;
	
	private var lo:Sprite;
	private var ro:Sprite;
	private var lp:Sprite;
	private var rp:Sprite;
	
	private var lpInitial:Point;
	private var rpInitial:Point;
	
	//TODO include from platform?
	#if (windows || linux)
	private var aButton:Bitmap;
	private var bButton:Bitmap;
	private var xButton:Bitmap;
	private var yButton:Bitmap;
	private var start:Bitmap;
	private var back:Bitmap;
	#end
	
	//TODO include from platform?
	#if android 
	private var oButton:Bitmap;
	private var uButton:Bitmap;
	private var yButton:Bitmap;
	private var aButton:Bitmap;
	private var start:Bitmap;
	#end
	
	private var lb:Bitmap;
	private var rb:Bitmap;
	private var up:Bitmap;
	private var down:Bitmap;
	private var left:Bitmap;
	private var right:Bitmap;
	
	private var los:Sprite;
	private var ros:Sprite;
	
	private var rightTrigger:Sprite;
	private var leftTrigger:Sprite;
	private var rightTriggerSelected:Sprite;
	private var leftTriggerSelected:Sprite;
	
	private var ticks:Int;
	private var tickstart:Float;

	public function new(mainStage:Stage) {
		super();
		
		culture = EnUS.culture;
		
		// Registering font
		Font.registerFont(DefaultFont);
		
		var format = new TextFormat("Autour One", 11, 0x000000);
		
		lo = Assets.getMovieClip("library:Oval");
		lo.width = 100;
		lo.height = 100;
		lo.x = 10;
		lo.y = mainStage.stageHeight - lo.height - 10;
		
		lp = Assets.getMovieClip("library:SmallOval");
		lp.width = 10;
		lp.height = 10;
		lp.x = lo.x + (lo.width / 2) - (lp.width / 2);
		lp.y = lo.y + (lo.height / 2) - (lp.height / 2);
		
		ro = Assets.getMovieClip("library:Oval");
		ro.width = 100;
		ro.height = 100;
		ro.x = mainStage.stageWidth - lo.width - 10;
		ro.y = mainStage.stageHeight - lo.height - 10;
		
		ros = Assets.getMovieClip("library:OvalSelected");
		ros.x = ro.x;
		ros.y = ro.y;
		ros.width = ro.width;
		ros.height = ro.height;
		
		los = Assets.getMovieClip("library:OvalSelected");
		los.x = lo.x;
		los.y = lo.y;
		los.width = lo.width;
		los.height = lo.height;
		
		rp = Assets.getMovieClip("library:SmallOval");
		rp.width = 10;
		rp.height = 10;
		rp.x = ro.x + (ro.width / 2) - (rp.width / 2);
		rp.y = ro.y + (ro.height / 2) - (rp.height / 2);
		
		lpInitial = new Point(lp.x, lp.y);
		rpInitial = new Point(rp.x, rp.y);
		
		var x = Std.int(lo.x + lo.width + 10);
		var y = Std.int(lo.y);
		platformName = buildTextField(format, x, y, 500);
		y = y + 15;
		controllerConfig = buildTextField(format, x, y, 500);
		y = y + 15;
		buttonsPressed = buildTextField(format, x, y, 500);
		y = y + 15;
		fpsText = buildTextField(format, x, y, 200);
		y = y + 15;
		dbgText = buildTextField(format, x, y, 500);
		
		addChild(platformName);
		addChild(controllerConfig);
		addChild(buttonsPressed);
		addChild(fpsText);
		addChild(dbgText);
		
		addChild(lo);
		addChild(los);
		addChild(ro);
		addChild(ros);
		addChild(lp);
		addChild(rp);
		
		#if (windows || linux)
		aButton = new Bitmap(new AImage(0, 0));
		bButton = new Bitmap(new BImage(0, 0));
		xButton = new Bitmap(new XImage(0, 0));
		yButton = new Bitmap(new YImage(0, 0));
		start = new Bitmap(new StartImage(0, 0));
		back = new Bitmap(new BackImage(0, 0));
		
		yButton.y = lo.y + 15;
		yButton.x = ro.x - yButton.width - (aButton.width / 2) - 30; 
		
		bButton.x = yButton.x + (aButton.width / 2) + 15;
		bButton.y = yButton.y + yButton.height - 15;
		
		aButton.x = yButton.x;
		aButton.y = bButton.y + (aButton.height / 2);
		
		xButton.y = bButton.y;
		xButton.x = yButton.x - (xButton.width / 2) - 15;
		
		rb.y = yButton.y;
		rb.x = xButton.x - rb.width - 5;
		
		lb.y = yButton.y;
		lb.x = rb.x - lb.width - 5;
		
		start.x = rb.x;
		start.y = rb.y + rb.height + 5;
		
		back.x = start.x - back.width - 5;
		back.y = start.y;
		
		#end
		
		#if android
		oButton = new Bitmap(new OuyaOImage(0, 0));
		uButton = new Bitmap(new OuyaUImage(0, 0));
		yButton = new Bitmap(new OuyaYImage(0, 0));
		aButton = new Bitmap(new OuyaAImage(0, 0));
		start = new Bitmap(new StartImage(0, 0));
		
		yButton.y = lo.y + 15;
		yButton.x = ro.x - yButton.width - (aButton.width / 2) - 30; 
		
		aButton.x = yButton.x + (aButton.width / 2) + 15;
		aButton.y = yButton.y + yButton.height - 15;
		
		oButton.x = yButton.x;
		oButton.y = aButton.y + (aButton.height / 2);
		
		uButton.y = aButton.y;
		uButton.x = yButton.x - (uButton.width / 2) - 15;
		
		rb.y = yButton.y;
		rb.x = uButton.x - rb.width - 5;
		
		lb.y = yButton.y;
		lb.x = rb.x - lb.width - 5;
		
		start.x = rb.x;
		start.y = rb.y + rb.height + 5;
		#end
		
		up.x = lb.x - up.width - 5;
		up.y = lb.y;
		
		down.x = up.x;
		down.y = up.y;
		
		left.x = up.x;
		left.y = up.y;
		
		right.x = up.x;
		right.y = up.y;
		
		lb = new Bitmap(new LBImage(0, 0));
		rb = new Bitmap(new RBImage(0, 0));
		up = new Bitmap(new UpImage(0, 0));
		down = new Bitmap(new DownImage(0, 0));
		left = new Bitmap(new LeftImage(0, 0));
		right = new Bitmap(new RightImage(0, 0));
		
		
		#if (windows || linux)
		addChild(aButton);
		addChild(bButton);
		addChild(xButton);
		addChild(yButton);
		addChild(back);
		addChild(start);
		#end
		
		#if android 
		addChild(oButton);
		addChild(uButton);
		addChild(yButton);
		addChild(aButton);
		addChild(start);
		#end
		
		addChild(lb);
		addChild(rb);
		
		addChild(up);
		addChild(down);
		addChild(left);
		addChild(right);
		
		leftTrigger = Assets.getMovieClip("library:Rect");
		leftTrigger.width = 20;
		leftTrigger.height = lo.height;
		leftTrigger.x = up.x - leftTrigger.width - 5;
		leftTrigger.y = lo.y;
		
		rightTrigger = Assets.getMovieClip("library:Rect");
		rightTrigger.width = 20;
		rightTrigger.height = lo.height;
		rightTrigger.x = leftTrigger.x - rightTrigger.width - 5;
		rightTrigger.y = leftTrigger.y;
		
		leftTriggerSelected = Assets.getMovieClip("library:RectSelected");
		leftTriggerSelected.width = 20;
		leftTriggerSelected.height = 10;
		leftTriggerSelected.x = leftTrigger.x;
		leftTriggerSelected.y = leftTrigger.y;
		
		rightTriggerSelected = Assets.getMovieClip("library:RectSelected");
		rightTriggerSelected.width = 20;
		rightTriggerSelected.height = 10;
		rightTriggerSelected.x = rightTrigger.x;
		rightTriggerSelected.y = rightTrigger.y;
		
		
		addChild(leftTrigger);
		addChild(leftTriggerSelected);
		addChild(rightTrigger);
		addChild(rightTriggerSelected);
		
		leftTrigger.visible = false;
		rightTrigger.visible = false;
		
		right.visible = false;
		left.visible = false;
		up.visible = false;
		down.visible = false;
		rb.visible = false;
		lb.visible = false;
		
		#if (windows || linux)
		back.visible = false;
		aButton.visible = false;
		bButton.visible = false;
		xButton.visible = false;
		yButton.visible = false;
		start.visible = false;
		#end
		
		#if android 
		oButton.visible = false;
		uButton.visible = false;
		yButton.visible = false;
		aButton.visible = false;
		start.visible = false;
		#end
		
		los.visible = false;
		ros.visible = false;
		lo.visible = false;
		ro.visible = false;
		lp.visible = false;
		rp.visible = false;
		
		leftTriggerSelected.visible = false;
		rightTriggerSelected.visible = false;
		
		
		ticks = 0;
		tickstart = Timer.stamp();
		
	}
	
	private function buildTextField(format:TextFormat, x:Int, y:Int, width:Int) {
		var textField = new TextField();
		
		textField.defaultTextFormat = format;
		textField.embedFonts = true;
		textField.selectable = false;
		
		textField.x = x;
		textField.y = y;
		textField.width = width;
		
		return textField;
	}
	
	public function setPlatformName(name:String) {
		platformName.text = "Platform name: " + name;
	}
	
	public function setControllerConfig(text:String) {
		controllerConfig.text = text;
	}
	
	public function setButtonsPressed(text:String) {
		buttonsPressed.text = "Buttons pressed: " + text;
	}
	
	public function updateControllerInfo(controller:Controller):Void {
		setButtonsPressed(
			(controller.a ? " A" : "") +
			(controller.b ? " B" : "") +
			(controller.x ? " X" : "") +
			(controller.y ? " Y" : "") +
			(controller.lb ? " LB" : "") +
			(controller.rb ? " RB" : "") +
			(controller.start ? " Start" : "") +
			(controller.back ? " Back" : "") +
			(controller.up ? " UP" : "") +
			(controller.down ? " Down" : "") +
			(controller.left ? " Left" : "") +
			(controller.right ? " Right" : "") +
			" RT: " + FormatNumber.decimal(controller.rt, culture) + 
			" LT: " + FormatNumber.decimal(controller.lt, culture)
		);
		
		
		var ltm = controller.lt;
		var rtm = controller.rt;
		
		leftTriggerSelected.visible = leftTrigger.visible = ltm > 0;
		rightTriggerSelected.visible = rightTrigger.visible = rtm > 0;
		
		var ltt = leftTrigger.height;
		
		var ltd = ltt * ltm;
		leftTriggerSelected.height = ltd;
		var rtt = rightTrigger.height;
		var rtd = rtt * rtm;
		rightTriggerSelected.height = rtd;
		
		var lxt = ((lo.width / 2) - (lp.width / 2)); //max distance between lo and lp 
		var lxm = controller.lx; // leftStick x movement 
		var ldx = lxm * lxt; // left distance in x
		lp.x = lpInitial.x + ldx;
		
		var lyt = ((lo.height / 2) - (lp.height / 2));
		var lym = controller.ly;
		var ldy = lym * lyt;
		lp.y = lpInitial.y - ldy;
		
		var rxt = ((ro.width / 2) - (rp.width / 2)); //max distance between lo and lp 
		var rxm = controller.rx; // leftStick x movement 
		var rdx = rxm * rxt; // left distance in x
		rp.x = rpInitial.x + rdx;
		
		var ryt = ((ro.height / 2) - (rp.height / 2));
		var rym = controller.ry;
		var rdy = rym * ryt;
		rp.y = rpInitial.y - rdy;
		
		lp.visible = lo.visible = lym != 0 || lxm != 0;
		rp.visible = ro.visible = rym != 0 || rxm != 0;
		
		#if (windows || linux)
		bButton.visible = controller.b;
		aButton.visible = controller.a;
		xButton.visible = controller.x;
		yButton.visible = controller.y;
		start.visible = controller.start;
		back.visible = controller.back;
		#end
		
		#if android
		oButton.visible = controller.a;
		uButton.visible = controller.x;
		yButton.visible = controller.y;
		aButton.visible = controller.b;
		start.visible = controller.start;
		#end
		
		lb.visible = controller.lb;
		rb.visible = controller.rb;
		
		ros.visible = controller.r3;
		los.visible = controller.l3;
		
		up.visible = controller.up;
		down.visible = controller.down;
		left.visible = controller.left;
		right.visible = controller.right;
		
	}
	
	public function updateFPS() {
		ticks++;
		fpsText.text = "FPS: " + Std.int(ticks / (Timer.stamp() - tickstart));
	}
	
	public function setDebugMessage(s:String) {
		dbgText.text = s;
	}
	
}