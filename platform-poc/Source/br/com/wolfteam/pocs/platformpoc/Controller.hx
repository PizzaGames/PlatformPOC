package br.com.wolfteam.pocs.platformpoc;

#if android
import flash.display.Stage;
import tv.ouya.console.api.OuyaController;
import openfl.events.JoystickEvent;
#end

#if windows 
import com.furusystems.openfl.input.xinput.XBox360Controller;
import flash.events.KeyboardEvent;
import flash.display.Stage;
#end

#if linux
import flash.events.KeyboardEvent;
import flash.display.Stage;
#end

/**
 * Wrapper class that encapsulate OuyaController and Xbox360Controller
 * @author Marcelo Frau
 */
class Controller {

	public var player:Int;
	public var o:Bool;
	public var u:Bool;
	public var y:Bool;
	public var a:Bool;
	public var x:Bool;
	public var b:Bool;
	
	public var l:Bool;
	public var r:Bool;
	
	public var l3:Bool;
	public var r3:Bool;
	
	public var up:Bool;
	public var down:Bool;
	public var left:Bool;
	public var right:Bool;
	
	public var lx:Float;
	public var ly:Float;
	public var rx:Float;
	public var ry:Float;
	public var rt:Float;
	public var lt:Float;
	
	public var start:Bool;
	public var back:Bool;
	
	#if android
	private var ouyaController:OuyaController;
	
	public function new(playerNumber:Int, controller:OuyaController) {
		ouyaController = controller;
	}
	
	public function bindListeners(stage:Stage) {
		stage.addEventListener(JoystickEvent.BUTTON_UP, onJoystickButtonUp);
		stage.addEventListener(JoystickEvent.BUTTON_DOWN, onJoystickButtonDown);
		stage.addEventListener(JoystickEvent.AXIS_MOVE, onJoystickAxisMove);
		stage.addEventListener(JoystickEvent.HAT_MOVE, onJoystickHatMove);
	}
	
	
	private function onJoystickHatMove(e:JoystickEvent):Void {
		var axis:Array<Float> = e.axis;
		
		var lx = axis[0];
		var ly = axis[1];
		
		if (lx > 0) {
			right = true;
		} else if (lx < 0) {
			left = true;
		} else {
			left = false;
			right = false;
		}
		
		if (ly > 0) {
			down = true;
		} else if (ly < 0) {
			up = true;
		} else {
			up = false;
			down = false;
		}
	}
	private function onJoystickAxisMove(e:JoystickEvent):Void {
		var axis:Array<Float> = e.axis;
		trace(axis);
		lx = axis[0];
		ly = -axis[1];
		
		rx = axis[11];
		ry = -axis[14];
		
		rt = axis[18];
		lt = axis[17];
		
		if (rt != 0) {
			rt = (rt + 1) / 2;
		}
		
		if (lt != 0) {
			lt = (lt + 1) / 2;
		}
	}
	private function onJoystickButtonUp(e:JoystickEvent):Void {
		switch (e.id) {
			case OuyaController.BUTTON_O: o = false; return;
			case OuyaController.BUTTON_U: u = false; return;
			case OuyaController.BUTTON_Y: y = false; return;
			case OuyaController.BUTTON_A: a = false; return;
			case OuyaController.BUTTON_L1: l = false; return;
			case OuyaController.BUTTON_R1: r = false; return;
			case OuyaController.BUTTON_L3: l3 = false; return;
			case OuyaController.BUTTON_R3: r3 = false; return;
			case OuyaController.BUTTON_DPAD_DOWN: down = false; return;
			case OuyaController.BUTTON_DPAD_LEFT: left = false; return;
			case OuyaController.BUTTON_DPAD_RIGHT: right = false; return;
			case OuyaController.BUTTON_DPAD_UP: up = false; return;
			case OuyaController.BUTTON_MENU: start = false; return;
		}
	}
	
	private function onJoystickButtonDown(e:JoystickEvent):Void {
		switch (e.id) {
			case OuyaController.BUTTON_O: o = true; return;
			case OuyaController.BUTTON_U: u = true; return;
			case OuyaController.BUTTON_Y: y = true; return;
			case OuyaController.BUTTON_A: a = true; return;
			case OuyaController.BUTTON_L1: l = true; return;
			case OuyaController.BUTTON_R1: r = true; return;
			case OuyaController.BUTTON_L3: l3 = true; return;
			case OuyaController.BUTTON_R3: r3 = true; return;
			case OuyaController.BUTTON_DPAD_DOWN: down = true; return;
			case OuyaController.BUTTON_DPAD_LEFT: left = true; return;
			case OuyaController.BUTTON_DPAD_RIGHT: right = true; return;
			case OuyaController.BUTTON_DPAD_UP: up = true; return;
			case OuyaController.BUTTON_MENU: start = true; return;
		}
	}
	#end
	
	#if linux 
	
	public function new(playerNumber:Int, controller:String) {
	}
	
  public function bindListeners(stage:Stage) {
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);	
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void {
		switch (e.keyCode) {
			case 39: right = true; lx = 1; return;
			case 37: left = true; lx = -1; return;
			case 38: up = true; ly = 1; return;
			case 40: down = true; ly = -1; return;
			case 65: x = true; return;
			case 90: a = true; return;
			case 88: b = true; return;
			case 83: y = true; return;
			case 81: l = true; return;
			case 87: r = true; return;
			case 192: rt = 1; return;
			case 49: lt = 1; return;
			case 13: start = true; return;
			case 8: back = true; return;
			case 82: r3 = true; return;
			case 69: l3 = true; return;
		}
	}
	
	private function onKeyUp(e:KeyboardEvent):Void {
		switch (e.keyCode) {
			case 39: right = false; lx = 0; return;
			case 37: left = false; lx = 0; return;
			case 38: up = false; ly = 0; return;
			case 40: down = false; ly = 0; return;
			case 65: x = false; return;
			case 90: a = false; return;
			case 88: b = false; return;
			case 83: y = false; return;
			case 81: l = false; return;
			case 87: r = false; return;
			case 192: rt = 0; return;
			case 49: lt = 0; return;
			case 13: start = false; return;
			case 8: back = false; return;
			case 82: r3 = false; return;
			case 69: l3 = false; return;
		}
	}

	#end
	
	#if windows
	private var xboxController:XBox360Controller;
	
	public function bindListeners(stage:Stage) {
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);	
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void {
		switch (e.keyCode) {
			case 39: right = true; lx = 1; return;
			case 37: left = true; lx = -1; return;
			case 38: up = true; ly = 1; return;
			case 40: down = true; ly = -1; return;
			case 65: x = true; return;
			case 90: a = true; return;
			case 88: b = true; return;
			case 83: y = true; return;
			case 81: l = true; return;
			case 87: r = true; return;
			case 192: rt = 1; return;
			case 49: lt = 1; return;
			case 13: start = true; return;
			case 8: back = true; return;
			case 82: r3 = true; return;
			case 69: l3 = true; return;
		}
	}
	
	private function onKeyUp(e:KeyboardEvent):Void {
		switch (e.keyCode) {
			case 39: right = false; lx = 0; return;
			case 37: left = false; lx = 0; return;
			case 38: up = false; ly = 0; return;
			case 40: down = false; ly = 0; return;
			case 65: x = false; return;
			case 90: a = false; return;
			case 88: b = false; return;
			case 83: y = false; return;
			case 81: l = false; return;
			case 87: r = false; return;
			case 192: rt = 0; return;
			case 49: lt = 0; return;
			case 13: start = false; return;
			case 8: back = false; return;
			case 82: r3 = false; return;
			case 69: l3 = false; return;
		}
	}
	
	public function new(playerNumber:Int, controller:XBox360Controller) {
		xboxController = controller;
	}
	
	public function poll() {
		if (xboxController == null) {
			return;
		}
		xboxController.poll();
		
		a = xboxController.a.isDown;
		b = xboxController.b.isDown;
		x = xboxController.x.isDown;
		y = xboxController.y.isDown;
		r = xboxController.rightBumper.isDown;
		l = xboxController.leftBumper.isDown;
		l3 = xboxController.leftThumbButton.isDown;
		r3 = xboxController.rightThumbButton.isDown;
		start = xboxController.start.isDown;
		back = xboxController.back.isDown;
		up = xboxController.up.isDown;
		down = xboxController.down.isDown;
		left = xboxController.left.isDown;
		right = xboxController.right.isDown;
		
		lt = xboxController.leftTriggerNorm;
		rt = xboxController.rightTriggerNorm;
		
		rx = xboxController.rightStick.xNorm;
		ry = xboxController.rightStick.yNorm;
		lx = xboxController.leftStick.xNorm;
		ly = xboxController.leftStick.yNorm;
	}
	#end
	
}
