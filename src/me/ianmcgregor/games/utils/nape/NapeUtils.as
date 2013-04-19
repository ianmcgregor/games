package me.ianmcgregor.games.utils.nape {
	import nape.geom.Vec2;
	import nape.phys.Body;

	/**
	 * @author ianmcgregor
	 */
	public final class NapeUtils {
		static public function scaleBody(body : Body, scaleX : Number, scaleY : Number = NaN): void {
			if( isNaN(scaleY) ) scaleY = scaleX;
			body.scaleShapes(scaleX, scaleY);
		}
		
		static public function rotateBodyAboutPoint(body:Body, anchor:Vec2, angle:Number): void {
		    var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
		    var dx:Number = body.position.x - anchor.x;
			var dy:Number = body.position.y - anchor.y;
		
		    body.rotation += angle;
		    body.position.x = anchor.x + cos * dx - sin * dy;
		    body.position.y = anchor.y + sin * dx + cos * dy;
		}
	}
}
