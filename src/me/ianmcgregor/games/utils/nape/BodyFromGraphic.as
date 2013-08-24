package me.ianmcgregor.games.utils.nape {
	import nape.geom.Vec2;
	import nape.phys.Body;

	import flash.display.BitmapData;

	/**
	 *
	 * Sample: Body From Graphic
	 * Author: Luca Deltodesco
	 *
	 * Using MarchingSquares to generate Nape bodies from a BitmapData
	 *
	 */
	public class BodyFromGraphic {
		public static function fromBitmapData(bitmapData : BitmapData, alphaThreshold : Number = 0x80, granularity : Vec2 = null, quality : int = 2, simplification : Number = 1.5) : Body {
			var iso : BitmapDataIso = new BitmapDataIso(bitmapData, alphaThreshold);
			return IsoBody.run(iso, iso.bounds, granularity, quality, simplification);
			
			/*
		var graphicOffset:Vec2 = body.userData.graphicOffset;
        var position:Vec2 = body.localPointToWorld(graphicOffset);
		 */
		}
	}
}
import nape.geom.AABB;
import nape.geom.GeomPoly;
import nape.geom.GeomPolyList;
import nape.geom.IsoFunction;
import nape.geom.MarchingSquares;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.shape.Polygon;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;


class IsoBody {
	public static function run(iso : IsoFunction, bounds : AABB, granularity : Vec2 = null, quality : int = 2, simplification : Number = 1.5) : Body {
		var body : Body = new Body();

		if (granularity == null) granularity = Vec2.weak(8, 8);
		var polys : GeomPolyList = MarchingSquares.run(iso, bounds, granularity, quality);
		var l : int = polys.length;
		for (var i : int = 0; i < l; ++i) {
			var p : GeomPoly = polys.at(i);

			var qolys : GeomPolyList = p.simplify(simplification).convexDecomposition(true);
			var len : int = qolys.length;
			for (var j : int = 0; j < len; ++j) {
				var q : GeomPoly = qolys.at(j);

				body.shapes.add(new Polygon(q));

				// Recycle GeomPoly and its vertices
				q.dispose();
			}
			// Recycle list nodes
			qolys.clear();

			// Recycle GeomPoly and its vertices
			p.dispose();
		}
		// Recycle list nodes
		polys.clear();

		// Align body with its centre of mass.
		// Keeping track of our required graphic offset.
		var pivot : Vec2 = body.localCOM.mul(-1);
		body.translateShapes(pivot);

		body.userData.graphicOffset = pivot;
		
		return body;
	}
}

class BitmapDataIso implements IsoFunction {
	public var bitmap : BitmapData;
	public var alphaThreshold : Number;
	public var bounds : AABB;

	public function BitmapDataIso(bitmap : BitmapData, alphaThreshold : Number = 0x80) : void {
		this.bitmap = bitmap;
		this.alphaThreshold = alphaThreshold;
		bounds = new AABB(0, 0, bitmap.width, bitmap.height);
	}

	public function graphic() : DisplayObject {
		return new Bitmap(bitmap);
	}

	public function iso(x : Number, y : Number) : Number {
		// Take 4 nearest pixels to interpolate linearly.
		// This gives us a smooth iso-function for which
		// we can use a lower quality in MarchingSquares for
		// the root finding.

		var ix : int = int(x);
		var iy : int = int(y);
		// clamp in-case of numerical inaccuracies
		if (ix < 0) ix = 0;
		if (iy < 0) iy = 0;
		if (ix >= bitmap.width) ix = bitmap.width - 1;
		if (iy >= bitmap.height) iy = bitmap.height - 1;

		// iso-function values at each pixel centre.
		var a11 : Number = alphaThreshold - (bitmap.getPixel32(ix, iy) >>> 24);
		var a12 : Number = alphaThreshold - (bitmap.getPixel32(ix + 1, iy) >>> 24);
		var a21 : Number = alphaThreshold - (bitmap.getPixel32(ix, iy + 1) >>> 24);
		var a22 : Number = alphaThreshold - (bitmap.getPixel32(ix + 1, iy + 1) >>> 24);

		// Bilinear interpolation for sample point (x,y)
		var fx : Number = x - ix;
		var fy : Number = y - iy;
		return a11 * (1 - fx) * (1 - fy) + a12 * fx * (1 - fy) + a21 * (1 - fx) * fy + a22 * fx * fy;
	}
}