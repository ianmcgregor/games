package me.ianmcgregor.racer.constants {
	import flash.display.Sprite;

	/**
	 * @author McFamily
	 */
	public class Tracks extends Sprite {

		public static const BLANK_TRACK: Array = ['Lorem Ipsum', 3, [[0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]]];
		
		public static const TRACK_MAPS : Array = [
			['Iggy\'s Track', 10, [ 
			
			[6,3,3,29,31,3,3,8], 
			[2,0,0,0,0,0,0,1], 
			[2,0,0,0,0,0,0,1], 
			[25,0,0,0,0,0,0,1], 
			[2,0,0,0,0,0,0,1], 
			[2,0,0,0,0,0,0,1], 
			[2,0,0,0,0,0,0,13], 
			[11,4,4,30,4,32,4,9] 
			
			]],
			['Collision Course', 3, [[0,0,0,6,3,8,0,0], [0,0,42,2,0,1,0,0], [0,0,0,2,0,1,0,0], [5,28,4,26,4,41,4,7], [1,0,6,10,0,1,0,2], [12,3,10,0,0,1,0,2], [0,0,0,0,0,12,3,10], [0,0,0,42,0,0,0,0]]],
			['Braking Good', 3, [[0,0,5,32,4,7,0,0], [0,0,1,34,0,19,0,0], [0,44,1,0,0,2,0,0], [6,8,1,0,0,2,0,0], [11,26,9,0,0,2,0,0], [0,1,0,0,0,14,0,0], [0,12,3,3,3,10,0,0], [0,0,0,0,0,0,0,0]]],
			['Round the Bend', 3, [[0,0,6,8,0,0,0,0], [0,0,2,1,0,0,0,0], [0,6,10,12,3,3,8,0], [0,2,0,0,0,0,1,0], [0,2,5,4,4,4,9,0], [0,2,12,3,3,3,8,0], [0,11,28,4,4,4,9,0], [0,0,0,0,0,0,0,0]]],
			['Changing Lanes', 3, [[0,6,3,8,0,0,0,0], [0,14,0,1,0,0,0,0], [0,2,0,12,3,3,8,0], [0,18,0,0,0,0,17,0], [0,2,0,5,4,4,9,0], [0,2,0,1,0,0,0,0], [0,11,4,9,42,0,0,0], [0,0,0,0,0,0,0,0]]],
			['To Infinity', 8, [[0,0,0,0,0,0,0,0], [0,0,0,5,4,4,7,0], [0,42,0,1,0,0,2,0], [0,6,33,26,3,33,10,0], [0,2,0,1,0,0,0,0], [0,2,0,13,0,0,0,0], [0,11,4,9,42,0,0,0], [0,0,0,0,0,0,0,0]]]
			
		];
		/*	,
			['Deja Vu', 3, [[0,0,5,4,7,0,0,0], [0,0,1,42,25,0,0,0], [6,3,31,3,23,8,42,0], [2,42,20,0,21,1,0,0], [11,4,26,7,2,15,0,0], [0,0,1,2,2,1,0,0], [0,0,13,2,2,1,0,0], [0,0,12,10,11,9,0,0]]],
			['Grand Tree', 2, [[0,0,0,5,4,7,0,0], [0,0,0,15,42,11,7,0], [0,0,42,1,6,3,10,0], [0,0,0,1,18,0,0,0], [42,5,4,9,14,0,0,42], [0,1,0,0,2,0,0,0], [0,12,3,3,10,0,0,0], [0,0,0,0,42,0,0,0]]],
			['Bush Tops', 3, [[0,0,0,0,5,7,0,0], [0,5,30,4,9,2,0,0], [5,9,6,3,3,10,0,0], [13,0,11,40,44,4,7,0], [1,0,6,8,0,0,2,0], [12,8,2,1,0,0,18,0], [0,12,10,12,3,3,10,0], [0,0,0,0,0,0,0,0]]],
			['Siete Arboles', 2, [[0,0,0,43,0,0,0,0], [0,43,6,3,3,8,0,0], [0,0,2,6,8,1,43,0], [6,3,10,16,1,17,0,0], [2,43,0,2,1,1,0,0], [11,4,32,26,9,13,0,43], [0,0,43,11,4,9,0,0], [0,0,0,0,43,0,0,0]]],
			['Ad Infinitum', 3, [[0,0,0,5,4,7,0,0], [0,0,0,15,0,11,7,0], [0,0,43,1,0,0,11,7], [0,6,3,1,35,3,3,10], [0,2,43,13,0,0,0,0], [0,2,0,17,0,0,0,0], [0,11,7,1,0,0,0,0], [0,0,11,9,0,0,0,0]]],
			['Moebius', 3, [[0,0,5,4,4,7,0,0], [0,0,1,0,0,25,0,0], [5,40,15,33,4,4,32,7], [1,0,1,44,44,21,0,2], [1,0,24,44,44,2,0,2], [12,29,3,3,27,10,6,10], [0,0,20,0,0,6,10,0], [0,0,12,3,3,10,0,0]]],
			['The Dogs', 3, [[0,0,5,4,4,7,0,0], [0,5,9,5,7,11,7,0], [5,9,43,1,25,42,2,0], [1,6,3,26,23,3,10,0], [13,11,30,9,21,42,0,0], [12,29,3,3,26,3,8,0], [0,5,40,44,26,4,9,0], [0,12,29,31,10,0,0,0]]],
			['Keneval', 3, [[0,0,0,5,4,7,0,0], [6,3,29,26,33,10,0,0], [11,4,40,44,36,4,32,7], [6,3,39,44,35,3,27,10], [2,0,42,20,0,0,0,0], [11,7,0,15,0,0,0,0], [0,11,7,15,0,42,0,0], [0,0,11,9,0,0,0,0]]],
			['Fruitbat', 3, [[0,5,4,4,4,7,0,0], [5,26,4,7,43,25,0,0], [17,1,0,2,6,3,8,0], [1,1,43,2,14,2,1,0], [1,12,8,2,2,11,9,0], [12,8,12,10,2,43,0,0], [0,12,8,0,2,0,0,0], [0,0,12,3,10,0,0,0]]],
			['Le Monk', 3, [[0,0,0,0,0,42,0,0], [0,0,42,6,3,8,0,0], [0,0,0,18,0,1,0,0], [5,28,33,26,4,30,7,0], [1,0,6,10,0,20,2,0], [12,3,10,0,0,1,2,0], [0,0,0,0,0,12,10,0], [0,0,0,42,0,0,0,0]]],
			['Knotty', 3, [[0,0,5,32,4,7,0,0], [0,0,1,34,0,19,0,0], [0,44,1,0,0,2,0,0], [6,8,1,0,0,2,0,0], [11,26,9,0,0,2,0,0], [0,1,0,0,0,14,0,0], [0,12,3,3,3,10,0,0], [0,0,0,0,0,0,0,0]]],
			['Wood for the trees', 3, [[0,42,42,6,3,8,42,0], [42,6,3,10,42,12,8,42], [42,16,42,6,8,42,1,42], [6,10,42,2,1,42,1,42], [11,33,40,38,38,36,26,7], [42,6,3,16,13,35,26,10], [42,11,7,11,41,4,9,0], [0,0,11,32,9,42,0,0]]],
			['Le Boulevard', 3, [[0,0,0,5,32,7,0,0], [6,3,8,1,44,14,44,0], [2,34,1,1,44,19,44,0], [11,4,26,9,44,2,44,0], [0,0,15,0,44,2,44,0], [0,0,1,0,44,18,44,0], [0,0,1,0,44,2,44,0], [0,0,12,3,3,10,0,0]]],
			['Slippery Snake', 3, [[0,0,5,7,43,42,0,0], [0,0,12,26,3,8,43,0], [0,0,0,25,42,1,43,42], [0,5,4,23,4,9,5,7], [6,26,3,23,27,33,26,10], [11,26,7,21,5,7,15,0], [0,15,2,2,1,2,17,0], [0,12,10,11,9,11,9,0]]],
			['Collision Course', 3, [[0,0,6,31,27,8,0,0], [0,43,18,6,8,12,8,0], [6,3,10,18,1,0,12,8], [2,6,31,10,24,0,0,1], [2,11,4,40,41,36,4,9], [11,7,0,0,20,0,0,0], [0,11,32,4,26,7,0,5], [0,0,0,0,12,10,0,0]]],
			['Manhattan', 3, [[0,43,43,6,3,8,0,0], [43,43,5,26,4,26,4,7], [43,5,9,25,34,1,34,2], [5,26,30,23,4,26,7,2], [17,17,0,21,0,17,18,18], [12,26,29,26,27,41,26,10], [0,1,34,2,0,12,10,0], [0,12,29,10,0,43,0,0]]],
			['Speed Freak', 3, [[0,0,0,5,4,4,7,0], [0,0,0,17,0,42,2,0], [0,42,0,1,0,0,2,0], [6,29,33,26,3,33,10,0], [2,0,0,13,0,0,0,0], [2,0,0,19,0,0,0,0], [11,4,7,19,42,0,0,0], [0,0,11,9,0,0,0,0]]],
			['The Ribcage', 3, [[0,5,7,6,8,5,7,0], [0,15,2,2,1,15,2,0], [42,24,25,14,24,24,2,42], [5,22,23,26,22,22,26,7], [15,20,21,2,20,20,18,2], [12,26,26,10,1,12,26,10], [0,12,26,39,37,35,10,0], [0,0,11,4,9,42,0,0]]],
			['Swindon', 3, [[0,44,5,7,5,7,0,0], [0,6,26,10,12,26,8,34], [44,11,26,4,28,26,9,0], [5,4,26,7,5,26,7,44], [12,8,12,10,12,10,18,34], [6,26,3,8,6,3,10,0], [11,9,6,26,26,8,44,0], [0,0,11,9,11,9,0,0]]],
			['Slap Hatch', 3, [[0,0,5,4,4,7,0,0], [5,4,26,7,42,11,7,0], [1,42,15,25,6,8,11,7], [12,3,26,23,26,1,35,10], [0,0,1,21,2,15,0,0], [0,42,12,26,10,1,0,0], [0,0,0,18,0,13,0,0], [0,0,0,11,4,9,0,0]]],
			['Death Valley', 3, [[0,5,4,7,0,6,8,0], [6,26,3,10,0,16,1,44], [16,24,0,0,0,2,24,42], [18,20,0,0,0,25,20,42], [11,26,28,7,5,23,9,43], [42,24,0,11,9,21,43,42], [43,20,0,0,0,16,42,0], [0,12,3,3,3,10,0,0]]],
			['Assault Course', 3, [[0,6,8,35,8,0,0,0], [0,2,1,43,19,6,34,0], [0,14,1,6,3,10,43,0], [43,2,1,11,4,32,7,0], [0,2,12,3,3,8,2,43], [0,2,43,0,20,1,2,0], [0,2,0,0,19,12,10,0], [0,11,33,4,9,0,0,0]]],
			['Lost Highway', 3, [[0,6,3,3,3,8,0,0], [0,25,43,6,3,15,35,8], [6,23,39,37,35,41,8,1], [2,21,43,25,43,1,1,1], [2,2,5,23,7,1,13,1], [2,11,9,21,11,26,26,9], [11,4,40,38,36,9,1,0], [0,0,43,11,4,4,9,0]]],
			['Nightmare on Elm lane', 3, [[0,0,0,0,0,43,0,0], [0,6,3,44,35,3,8,0], [0,2,34,0,5,7,1,0], [5,26,4,40,17,26,9,0], [13,11,4,4,9,2,0,0], [1,6,8,0,34,2,0,42], [12,10,12,39,35,10,0,0], [0,0,43,0,0,0,0,0]]],
			['Magical Mystery Tour', 3, [[0,0,5,4,7,43,6,8], [6,3,29,8,19,0,16,15], [2,43,24,1,14,43,25,19], [2,5,4,9,2,5,4,9], [2,1,20,6,10,12,3,20], [2,12,26,10,5,32,23,9], [11,4,26,4,9,6,10,20], [0,43,12,33,3,10,11,9]]],
			['Congratulations!', 3, [[5,33,40,6,27,44,7,0], [1,3,8,19,5,4,2,0], [1,4,9,19,12,3,2,0], [1,5,7,19,4,4,2,0], [1,12,10,19,3,8,2,0], [1,41,4,19,4,26,2,0], [1,9,0,25,4,9,2,0], [12,3,3,3,3,3,10,0]]]
			*/
		public static const TILE_DEFINITIONS : Array = [
			{type:TileType.OFF_ROAD, texture:"00_offroad", direction:Direction.NONE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.STRAIGHT, texture:"01_straight", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.STRAIGHT, texture:"01_straight", direction:Direction.SW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.STRAIGHT, texture:"02_straight", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.STRAIGHT, texture:"02_straight", direction:Direction.SE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CURVE, texture:"03_curve", direction:Direction.NE, curveTo:7, cornerA:0.5, cornerB:0.5, climb:-1},
			{type:TileType.CURVE, texture:"03_curve", direction:Direction.NW, curveTo:5, cornerA:0.5, cornerB:0.5, climb:-1},
			{type:TileType.CURVE, texture:"04_curve", direction:Direction.SE, curveTo:5, cornerA:0.5, cornerB:-0.5, climb:-1},
			{type:TileType.CURVE, texture:"04_curve", direction:Direction.NE, curveTo:3, cornerA:0.5, cornerB:-0.5, climb:-1},
			{type:TileType.CURVE, texture:"05_curve", direction:Direction.SE, curveTo:1, cornerA:-0.5, cornerB:-0.5, climb:-1},
			{type:TileType.CURVE, texture:"05_curve", direction:Direction.SW, curveTo:3, cornerA:-0.5, cornerB:-0.5, climb:-1},
			{type:TileType.CURVE, texture:"06_curve", direction:Direction.SW, curveTo:7, cornerA:-0.5, cornerB:0.5, climb:-1},
			{type:TileType.CURVE, texture:"06_curve", direction:Direction.NW, curveTo:1, cornerA:-0.5, cornerB:0.5, climb:-1},
			{type:TileType.START_GRID, texture:"07_start", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.START_GRID, texture:"07_start", direction:Direction.SW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHICANE, texture:"09_chicane", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHICANE, texture:"09_chicane", direction:Direction.SW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHANGE_LANE, texture:"11_changelane", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHANGE_LANE, texture:"11_changelane", direction:Direction.SW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.OIL, texture:"01_straight", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.RAMP, texture:"13_ramp", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:1},
			{type:TileType.RAMP, texture:"13_ramp", direction:Direction.SW, curveTo:-1, cornerA:0, cornerB:0, climb:0},
			{type:TileType.BRIDGE, texture:"02_straight", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.BRIDGE, texture:"02_straight", direction:Direction.SW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.RAMP, texture:"14_ramp", direction:Direction.NE, curveTo:-1, cornerA:0, cornerB:0, climb:0},
			{type:TileType.RAMP, texture:"14_ramp", direction:Direction.SW, curveTo:-1, cornerA:0, cornerB:0, climb:1},
			{type:TileType.CROSS_ROADS, texture:"17_crossroads", direction:Direction.NONE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.START_GRID, texture:"08_start", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.START_GRID, texture:"08_start", direction:Direction.SE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHICANE, texture:"10_chicane", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHICANE, texture:"10_chicane", direction:Direction.SE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHANGE_LANE, texture:"12_changelane", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.CHANGE_LANE, texture:"12_changelane", direction:Direction.SE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.OIL, texture:"02_straight", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.OBSTACLE, texture:"00_offroad", direction:Direction.NONE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.RAMP, texture:"15_ramp", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:1},
			{type:TileType.RAMP, texture:"15_ramp", direction:Direction.SE, curveTo:-1, cornerA:0, cornerB:0, climb:0},
			{type:TileType.BRIDGE, texture:"01_straight", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.BRIDGE, texture:"01_straight", direction:Direction.SE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.RAMP, texture:"16_ramp", direction:Direction.NW, curveTo:-1, cornerA:0, cornerB:0, climb:0},
			{type:TileType.RAMP, texture:"16_ramp", direction:Direction.SE, curveTo:-1, cornerA:0, cornerB:0, climb:1},
			{type:TileType.CROSS_ROADS, texture:"17_crossroads", direction:Direction.NONE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.OBSTACLE, texture:"00_offroad", direction:Direction.NONE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.OBSTACLE, texture:"00_offroad", direction:Direction.NONE, curveTo:-1, cornerA:0, cornerB:0, climb:-1},
			{type:TileType.LOW_OBSTACLE, texture:"00_offroad", direction:Direction.NONE, curveTo:-1, cornerA:0, cornerB:0, climb:-1}
		];
		
	}
}
