package br.com.wolfgames.display;

import aze.display.TileGroup;
import aze.display.TileSprite;
import aze.display.TileLayer;
import aze.display.TileClip;
import flash.display.Sprite;
import flash.geom.Point;
import format.swf.timeline.Layer;

class RepeatedTileGroup extends TileGroup {
	
	public function new(layer:TileLayer, tileName:String, xRepeatTimes:Int, yRepeatTimes:Int) { // better x, y repeat name
		super(layer);
		
		if (xRepeatTimes >= 1) {
			
			var x:Int = 0;
			for (i in 0 ... xRepeatTimes) {
				if (yRepeatTimes > 1) {
					var y:Int = 0;
					var lastWidth:Int = 0;
					
					for (j in 0 ... yRepeatTimes) {
						var sprite = new TileSprite(layer, tileName);
						sprite.x = x;
						sprite.y = y;
						sprite.offset = new Point(-sprite.width/2, -sprite.height/2);
						lastWidth = Std.int(sprite.width);
						
						y += Std.int(sprite.height);
						addChild(sprite);
					}
					x += Std.int(lastWidth);
				} else {
					var sprite = new TileSprite(layer, tileName);
					sprite.x = x;
					sprite.y = 0;
					sprite.offset = new Point(-sprite.width/2, -sprite.height/2);
					x += Std.int(sprite.width);
					addChild(sprite);
				}
			}
		}
	}
	
}