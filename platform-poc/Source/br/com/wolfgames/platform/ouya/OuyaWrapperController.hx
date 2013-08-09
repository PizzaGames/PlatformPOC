package br.com.wolfgames.platform.ouya;
import br.com.wolfgames.input.Controller;
import flash.display.Stage;
import openfl.events.JoystickEvent;
import tv.ouya.console.api.OuyaController;

/**
 * ...
 * @author ...
 */
class OuyaWrapperController extends Controller {
	
	public function new(_playerNumber:Int, _nativeController:OuyaController) {
		super(_playerNumber, _nativeController);
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
			case OuyaController.BUTTON_O: a = false; return;
			case OuyaController.BUTTON_U: x = false; return;
			case OuyaController.BUTTON_Y: b = false; return;
			case OuyaController.BUTTON_A: y = false; return;
			case OuyaController.BUTTON_L1: lb = false; return;
			case OuyaController.BUTTON_R1: rb = false; return;
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
			case OuyaController.BUTTON_O: a = true; return;
			case OuyaController.BUTTON_U: x = true; return;
			case OuyaController.BUTTON_Y: y = true; return;
			case OuyaController.BUTTON_A: b = true; return;
			case OuyaController.BUTTON_L1: lb = true; return;
			case OuyaController.BUTTON_R1: rb = true; return;
			case OuyaController.BUTTON_L3: l3 = true; return;
			case OuyaController.BUTTON_R3: r3 = true; return;
			case OuyaController.BUTTON_DPAD_DOWN: down = true; return;
			case OuyaController.BUTTON_DPAD_LEFT: left = true; return;
			case OuyaController.BUTTON_DPAD_RIGHT: right = true; return;
			case OuyaController.BUTTON_DPAD_UP: up = true; return;
			case OuyaController.BUTTON_MENU: start = true; return;
		}
	}
	
}