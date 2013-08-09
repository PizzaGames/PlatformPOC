package br.com.wolfgames.platform.linux;

import br.com.wolfgames.input.Controller;
import flash.display.Stage;
import flash.events.KeyboardEvent;

/**
 */
class LinuxController extends Controller{

	public function new(_playerNumber:Int, _nativeController:Dynamic) {
		super(_playerNumber, _nativeController);
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
	
}