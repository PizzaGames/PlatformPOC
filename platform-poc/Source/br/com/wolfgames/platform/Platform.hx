package br.com.wolfgames.platform;

/**
 * 
 * @author Marcelo Frau
 */
class Platform {

	private static var instance: Platform;
	
	
	public var platformName: String;
	
	public function new() {
	}
	
	public function getPlatformName(): String { return null; } //TODO: ver como faz metodo abstrato
	public function prepareEnviroment(): Void {}
	
	public static function getInstance(): Platform {
		if (instance == null) {
			#if windows
				instance = new WindowsPlatform();
			#elseif linux 
				instance = new LinuxPlatform();
			#elseif android
				instance = new OuyaPlatform();
			#else 
				#error
			#end
		}
		return instance;
	}

}
