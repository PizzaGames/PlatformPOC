package br.com.wolfgames.platformpoc.sprites;

import aze.display.TileClip;
import aze.display.TileLayer;

class GenericSprite extends TileClip {
	
	public static var _layer:TileLayer;
	
	public var groundY:Int;
	public var gravity:Float;
	public var jumping:Bool;
	public var velY:Float;

	public function new(type:String) {
		super(_layer, type);
		//r = 1;
		//g = 1; 
		b = 0.1;
		
		gravity = 1;
		velY = 0;
	}
	
}