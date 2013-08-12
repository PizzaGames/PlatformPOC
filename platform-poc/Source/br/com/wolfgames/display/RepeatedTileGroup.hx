package br.com.wolfgames.display;

import aze.display.TileGroup;
import aze.display.TileSprite;
import aze.display.TileLayer;
import aze.display.TileClip;
import flash.geom.Point;
import format.swf.timeline.Layer;

class RepeatedTileGroup extends TileGroup {
	
	private var tileName:String;
	private var xRepeatTimes:Int;
	private var yRepeatTimes:Int;
	private var mainLayer:TileLayer;
	
	private var screenWidth:Float;
	private var screenHeight:Float;
	
	private var spriteWidth:Float;
	private var spriteHeight:Float;
	
	private var _width:Float;
	private var _height:Float;
	
	private var sprites:Array<TileSprite>;
	
	override function get_height():Float {
		return _height;
	}
	
	override function get_width():Float {
		return _width;
	}
	
	var unusedSprites:Map<TileSprite, Bool>;
	
	override function set_x(new_x:Float):Float {	
		if (sprites != null) {
			var x = get_x();
			var x2 = x + _width;
			
			var firstX = x2;
			var lastX2:Float = 0;
			
			for (sprite in sprites) {
				var spritex = x + sprite.x;
				
				var i = 0;
				if ((spritex + sprite.width) < 0) {
					unusedSprites.set(sprite, true);
				} else if (spritex > screenWidth) { 
					unusedSprites.set(sprite, true);
				} else {
					if (sprite.x < firstX) {
						firstX = sprite.x;
					} 
					if (sprite.x + spriteWidth > lastX2) {
						lastX2 = sprite.x + spriteWidth;
					}
					unusedSprites.remove(sprite);
				}
			}
			var x2 = x + super.get_width() - firstX;
			var dx = (x + firstX);
			for (sprite in unusedSprites.keys()) {
				if (x2 < screenWidth) {
					sprite.x = lastX2;
					unusedSprites.remove(sprite);
				}
				if (dx >= 0) {
					sprite.x = firstX - spriteWidth;
					unusedSprites.remove(sprite);
				}
			}
		}
		
		
		return super.set_x(new_x);
	}
	override function set_y(new_y:Float):Float {
		return super.set_y(new_y);
	}
	
	public function new(layer:TileLayer, tileName:String, xRepeatTimes:Int, ?yRepeatTimes:Int = 1, ?sw:Int = 1920, ?sh:Int = 1080) { // better x, y repeat name
		super(layer);
		
		unusedSprites = new Map<TileSprite, Bool>();
		
		this.mainLayer = layer;
		this.tileName = tileName;
		this.xRepeatTimes = xRepeatTimes;
		this.yRepeatTimes = yRepeatTimes;
		
		var sprite = new TileSprite(layer, tileName); // initial sprite
		spriteWidth = sprite.width;
		spriteHeight = sprite.height;
		
		
		this.screenWidth = (sw * 1.2);
		this.screenHeight = (sh * 1.2);
		
		_width = spriteWidth * xRepeatTimes;
		_height = spriteHeight * yRepeatTimes;
		
		sprite.offset = new Point(-spriteWidth / 2, -spriteHeight / 2);
		sprite.x = 0;
		sprite.y = 0;
		
		var xSpritesSize = xRepeatTimes * spriteWidth;
		var ySpritesSize = yRepeatTimes * spriteHeight;
		
		sprites = new Array<TileSprite>();// (Std.int((xSpritesSize / screenWidth) * 1.5)); //list is one and a half screenSize of sprites
		sprites.insert(0, sprite);
		
		var x:Float = 0;
		for (i in 0 ... xRepeatTimes) {
			if (i * spriteWidth >= screenWidth + spriteWidth) {
				break;
			}
			
			var lastWidth:Int = 0;
			var y:Float = 0;
			
			for (j in 0 ... yRepeatTimes) {
				if (j * spriteHeight >= screenHeight + spriteHeight) {
					break;
				}
				
				var s = i + j == 0 ? sprite : new TileSprite(mainLayer, tileName);
				s.x = x;
				s.y = y;
				s.offset = sprite.offset;
				
				y += spriteHeight;
				sprites.insert(i + j, s);
				addChild(s);
			}
			x += spriteWidth;
		}
	}
	
}