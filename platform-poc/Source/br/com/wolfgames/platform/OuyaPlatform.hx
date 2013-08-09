package br.com.wolfgames.platform;
import br.com.wolfgames.input.Controller;
import br.com.wolfgames.platform.ouya.OuyaWrapperController;
import flash.display.Stage;

import openfl.utils.JNI;
import tv.ouya.console.api.OuyaController;

/**
 * Ouya platform specific 
 */
class OuyaPlatform extends Platform {
	
	public function new(stage:Stage) {
		super(stage);
	}		

	override public function getPlatformName():String {
		return "Ouya";
	}
	
	override public function getController(playerNumber:Int):Controller {
		var controller = controllers[playerNumber - 1];
		if (controller == null) {
			var c = new OuyaWrapperController(playerNumber, getNativeController(playerNumber));
			c.bindListeners(mainStage);
			
			controller = c;
			controllers[playerNumber - 1] = controller;
		}
		
		return controller;
	}
	
	override public function prepareEnviroment():Void {
		
	}
	
	private function getNativeController(playerNumber:Int):OuyaController {
		var getContext = JNI.createStaticMethod ("org.haxe.nme.GameActivity", "getContext", "()Landroid/content/Context;", true);
		OuyaController.init(getContext());
		return OuyaController.getControllerByPlayer(playerNumber);
	}

}
