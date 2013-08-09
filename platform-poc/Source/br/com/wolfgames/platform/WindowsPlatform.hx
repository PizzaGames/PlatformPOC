package br.com.wolfgames.platform;

import br.com.wolfgames.input.Controller;
import br.com.wolfgames.platform.windows.WindowsController;
import com.furusystems.openfl.input.xinput.*;
import flash.display.Stage;
import haxe.io.Error;

/**
 * Windows platform specific things
 * @author Marcelo Frau
 */
class WindowsPlatform extends Platform {
	
	public function new(stage:Stage) {
		super(stage);
	}		
	
	override public function getController(playerNumber:Int):Controller {
		var controller = controllers[playerNumber];
		
		if (controller == null) {
			var nativeController = getNativeController(playerNumber);
			
			if (nativeController == null && playerNumber != 1) {
				throw "Opperation not supported";
				
			} else if (nativeController == null) { // if is player 1 and there is no controller connected, use keyboard implementation
				var c = new WindowsController(playerNumber, null);
				c.bindKeyboardListeners(mainStage);
				controller = c;
				
			} else {
				controller = new WindowsController(playerNumber, nativeController); 
			}
			controllers[playerNumber] = controller;
		}
		
		return controller;
	}
	
	override public function getPlatformName():String {
		return "Windows";
	}
	
	override public function prepareEnviroment():Void {
		
	}
	
	private function getNativeController(playerNumber: Int): XBox360Controller {
		if (!XBox360Controller.isControllerConnected(playerNumber - 1)) {
			return null;
		}
		
		var nativeController = new XBox360Controller(playerNumber - 1);
		
		nativeController.leftStick.deadZoneNorm = 0.2; 
		nativeController.rightStick.deadZoneNorm = 0.2;
		nativeController.triggerDeadzone = 30;
		
		return nativeController;
	}

}
