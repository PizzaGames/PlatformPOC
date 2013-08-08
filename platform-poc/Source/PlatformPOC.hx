package ;

import br.com.wolfgames.platform.Platform;
import flash.display.Sprite;

class PlatformPOC extends Sprite {

	private var platform:Platform;
    
    public function new() {
    	super();
    	
    	trace("============================================");
    	trace("Platform POC");
    	trace("============================================");
    	
    	platform = Platform.getInstance();
    	
    	trace("");
    	
    }
}