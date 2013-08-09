package br.com.wolfgames.platform;
import br.com.wolfgames.input.Controller;
import flash.display.Stage;

/**
 * Represents a generic platform, each platform implemented must extend this class.
 * 
 * This class exists to isolate platform specific code.
 * @author Marcelo Frau
 */
class Platform {

	private static var instance: Platform;
	
	public var controllers:Array<Controller>;
	public var mainStage:Stage;
	
	public function new(stage:Stage) {
		mainStage = stage;
		controllers = new Array();
		prepareEnviroment();
	}
	
	// TODO: ver se tem como deixar os metodos abaixo como abstratos
	public function getPlatformName(): String { return null; } 
	public function prepareEnviroment(): Void { return; } 
	public function getController(playerNumber: Int): Controller { return null; }
	
	public static function getInstance(stage:Stage): Platform {
		if (instance == null) {
			#if windows
				instance = new WindowsPlatform(stage);
			#elseif linux 
				instance = new LinuxPlatform(stage);
			#elseif android
				instance = new OuyaPlatform(stage);
			#else 
				#error
			#end
		}
		return instance;
	}

}
