package br.com.wolfgames.platform;
import br.com.wolfgames.input.Controller;
import flash.display.Stage;

/**
 * Linux platform specific things
 * @author Marcelo Frau
 */
class LinuxPlatform extends Platform {
	
	public function new(stage:Stage) {
		super(stage);	
	}	
	
	override public function prepareEnviroment():Void {
		
	}
	
	override public function getPlatformName():String {
		return "Linux";
	}
	
	override public function getController(playerNumber:Int):Controller {
		var controller = controllers[playerNumber - 1];
		
		if (controller == null) {
			controller = new Controller(playerNumber, null); //TODO implement controller support on linux
			controllers[playerNumber - 1] = controller;
		}
		
		return controller;
	}

}
