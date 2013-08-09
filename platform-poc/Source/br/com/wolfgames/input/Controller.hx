package br.com.wolfgames.input;
import br.com.wolfgames.platform.LinuxPlatform;

/**
 * Represents a controller
 */
class Controller {
	
	private var playerNumber: Int;
	public var nativeController: Dynamic; //FIXME nativeController must only be seen by inherited class
	
	public var a:Bool;
	public var b:Bool;
	public var x:Bool;
	public var y:Bool;
	
	public var lb:Bool;
	public var rb:Bool;
	
	public var l3:Bool;
	public var r3:Bool;
	
	public var start:Bool;
	public var back:Bool;
	
	public var up:Bool;
	public var down:Bool;
	public var left:Bool;
	public var right:Bool;
	
	public var lx:Float;
	public var ly:Float;
	
	public var rx:Float;
	public var ry:Float;
	
	public var lt:Float;
	public var rt:Float;

	public function new(_playerNumber: Int, _nativeController: Dynamic) {
		playerNumber = _playerNumber;
		nativeController = _nativeController;
	}
	
	public function poll():Void {
	}
	
}