package br.com.wolfgames.platform.windows;

import br.com.wolfgames.input.Controller;
import com.furusystems.openfl.input.xinput.XBox360Controller;
import flash.display.Stage;
import flash.events.KeyboardEvent;

class WindowsController extends Controller {

	public function new(_playerNumber:Int, _nativeController:XBox360Controller) {
		super(_playerNumber, _nativeController);
	}
	
	override public function poll():Void {
		super.poll();
		if (nativeController != null) {
			var controller:XBox360Controller = nativeController;
			controller.poll();
			
			a = controller.a.isDown;
			b = controller.b.isDown;
			x = controller.x.isDown;
			y = controller.y.isDown;
			
			lb = controller.leftBumper.isDown;
			rb = controller.rightBumper.isDown;
			
			up = controller.up.isDown;
			down = controller.down.isDown;
			left = controller.left.isDown;
			right = controller.right.isDown;
			
			start = controller.start.isDown;
			back = controller.back.isDown;
			
			l3 = controller.leftThumbButton.isDown;
			r3 = controller.rightThumbButton.isDown;
			
			lt = controller.leftTriggerNorm;
			rt = controller.rightTriggerNorm;
			
			rx = controller.rightStick.xNorm;
			ry = controller.rightStick.yNorm;
			lx = controller.leftStick.xNorm;
			ly = controller.leftStick.yNorm;
		}
	}
	
	public function bindKeyboardListeners(stage:Stage) {
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
			case 81: lb = true; return;
			case 87: rb = true; return;
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
			case 81: lb = false; return;
			case 87: rb = false; return;
			case 192: rt = 0; return;
			case 49: lt = 0; return;
			case 13: start = false; return;
			case 8: back = false; return;
			case 82: r3 = false; return;
			case 69: l3 = false; return;
		}
	}
	
}