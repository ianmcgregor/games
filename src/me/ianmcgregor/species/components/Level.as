package me.ianmcgregor.species.components {
	import me.ianmcgregor.species.assets.Assets;

	import com.artemis.Component;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author McFamily
	 */
	public class Level extends Component {
		
		/**
		 * num 
		 */
		public var num : int;
		/**
		 * map 
		 */
		public var map : Array;
		/**
		 * hero 
		 */
		public var hero : Point;
		/**
		 * enemies 
		 */
		public var enemies : Vector.<Point>;
		/**
		 * exit 
		 */
		public var exit : Rectangle;
		/**
		 * wall 
		 */
		public var wall : Rectangle;
		/**
		 * moustacheEnemies 
		 */
		public var moustacheEnemies : Vector.<Point>;
		/**
		 * friends 
		 */
		public var friends : Vector.<Point>;
		/**
		 * firePits 
		 */
		public var firePits : Vector.<Rectangle>;
		/**
		 * ship 
		 */
		public var ship : Point;

		/**
		 * Level 
		 * 
		 * @param num 
		 * 
		 * @return 
		 */
		public function Level(num : int) {
			this.num = num;
			
			/**
			 * xml 
			 */
			var xml: XML = Assets.getLevel(num);
			if( xml ) parseOgmo(xml);
		}
		
		/**
		 * parseOgmo 
		 * 
		 * @param xml 
		 * 
		 * @return 
		 */
		public function parseOgmo(xml : XML) : void {
			/**
			 * string 
			 */
			var string : String = xml.descendants('Solids').valueOf();
			string = string.replace(/\r\n|\n|\r|\t/g, '');
			/**
			 * array 
			 */
			var array : Array = string.split('');
			
			map =  [];
			/**
			 * row 
			 */
			var row: Array;
			/**
			 * l 
			 */
			var l: int = array.length;
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				if(i % 40 == 0){
//					trace(map.length, ': ',row);
					row = [];
					map[map.length] = row;
				}
				row[row.length] = array[i];
			}
			
			
			/**
			 * heroXML 
			 */
			var heroXML: XML = xml.descendants('Hero')[0];
			hero = new Point(heroXML.@x, heroXML.@y);

			
			/**
			 * exitXML 
			 */
			var exitXML: XML = xml.descendants('Exit')[0];
			exit = exitXML != null ? new Rectangle(exitXML.@x, exitXML.@y, exitXML.@width, exitXML.@height) : null;
			
			/**
			 * xmlList 
			 */
			var xmlList : XMLList;
			/**
			 * node 
			 */
			var node : XML;
			
			enemies = new Vector.<Point>();
			xmlList = xml.descendants('Enemy');
			for each (node in xmlList) {
				enemies[enemies.length] = new Point(node.@x, node.@y);
			}

			moustacheEnemies = new Vector.<Point>();
			xmlList = xml.descendants('EnemyMoustache');
			for each (node in xmlList) {
				moustacheEnemies[moustacheEnemies.length] = new Point(node.@x, node.@y);
			}

			friends = new Vector.<Point>();
			xmlList = xml.descendants('Friend');
			for each (node in xmlList) {
				friends[friends.length] = new Point(node.@x, node.@y);
			}
			
			firePits = new Vector.<Rectangle>();
			xmlList = xml.descendants('FirePit');
			for each (node in xmlList) {
				firePits[firePits.length] = new Rectangle(node.@x, node.@y, node.@width, node.@height);
			}

			/**
			 * shipXML 
			 */
			var shipXML: XML = xml.descendants('Ship')[0];
			ship = shipXML != null ? new Point(shipXML.@x, shipXML.@y) : null;
			
			/**
			 * wallXML 
			 */
			var wallXML: XML = xml.descendants('Wall')[0];
			wall = wallXML != null ? new Rectangle(wallXML.@x, wallXML.@y, wallXML.@width, wallXML.@height) : null;
			
//			<EnemyMoustache id="0" x="528" y="336" />
//    		<EnemyMoustache id="1" x="432" y="384" />
//    		<Hero id="2" x="320" y="0" />
//    		<Exit id="3" x="624" y="112" width="16" height="208" />
		}
		
		/**
		 * collides 
		 * 
		 * @param x 
		 * @param y 
		 * 
		 * @return 
		 */
		public function collides(x: Number, y: Number): Boolean {
			 /**
			  * i 
			  */
			 var i: int = int(y / 16);
			 /**
			  * j 
			  */
			 var j: int = int(x / 16);
			 if(map == null || i < 0 || i > map.length -1) return true;
			 if(j < 0 || j > (map[i] as Array).length -1) return true;
			 return map[i][j] == 1;
		}
	}
}
