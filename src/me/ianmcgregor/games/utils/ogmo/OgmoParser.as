package me.ianmcgregor.games.utils.ogmo {
	import avmplus.getQualifiedClassName;

	import me.ianmcgregor.games.utils.astar.Grid;

	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getQualifiedSuperclassName;

	/**
	 * @author ianmcgregor
	 */
	public final class OgmoParser {
		/**
		 * OgmoMap
		 * 
		 * Layers should be named: 
		 * * grid
		 * * tiles
		 * * entities
		 * 
		 */
		private const GRID : String = "grid";
		private const TILES : String = "tiles";
		private const ENTITIES : String = "entities";
		/**
		 * _levels 
		 */
		private const _levelMap : Dictionary = new Dictionary();
		private const _levelList : Vector.<OgmoLevel> = new Vector.<OgmoLevel>();
		
		public function OgmoParser() {
		}

		/**
		 * parse - accepts XMLs and Classes with embedded XML data 
		 * 
		 * @param rawAssets
		 */
		public function parse(...rawAssets) : void {
			for each (var rawAsset : Object in rawAssets) {
//				trace('getQualifiedSuperclassName(rawAsset): ' + (getQualifiedSuperclassName(rawAsset)));
				if (rawAsset is Class && isByteArray(rawAsset)) {
					var name : String = getQualifiedClassName(rawAsset);
					name = name.substr(0, name.indexOf('_'));
					parseXMLClass(name, rawAsset as Class);
				} else if ( rawAsset is Class ) {
					var typeXml : XML = describeType(rawAsset);
					var childNode : XML;

					for each (childNode in typeXml.child("constant").(@type == "Class"))
						parseXMLClass(childNode.@name, rawAsset[childNode.@name]);

					for each (childNode in typeXml.child("variable").(@type == "Class"))
						parseXMLClass(childNode.@name, rawAsset[childNode.@name]);
						
				} else if (rawAsset is XML) {
					parseXML(null, rawAsset as XML);
				}
			}
			
			_levelList.sort(sortBehaviour);
		}
		
		private function sortBehaviour(a: OgmoLevel, b: OgmoLevel) : int {
			return a.name > b.name ? 1 : -1;
		}
		
		/**
		 * isByteArray - helper method to parse XMLs
		 * 
		 * @param rawAsset
		 */
		private function isByteArray(rawAsset : Object) : Boolean {
			var className: String = getQualifiedSuperclassName(rawAsset);
			return className == "mx.core::ByteArrayAsset" || className == "flash.utils::ByteArray";
		}

		/**
		 * parseXMLClass - helper method to instantiate and parse XMLs
		 * 
		 * @param Clazz
		 */
		private function parseXMLClass(name : String, Clazz : Class) : void {
			var inst : Object = new Clazz();
			if ( inst is ByteArray ) {
				parseXML(name, XML(inst));
			}
		}

		/**
		 * parseXML 
		 * 
		 * @param xml 
		 * 
		 * @return 
		 */
		public function parseXML(name : String, xml : XML) : void {
			if (!name) name = xml.localName();
			var level : OgmoLevel = _levelMap[name] = _levelList[_levelList.length] = new OgmoLevel(name);
			level.width = uint(xml.attribute("width"));
			level.height = uint(xml.attribute("height"));
			level.camera = parseCamera(xml);
			level.grid = parseGrid(xml);
			level.tiles = parseTiles(xml);
			level.nodes = parseNodes(level.grid[0].length, level.grid.length);
			var l: int = level.grid.length;
			for (var i : int = 0; i < l; ++i) {
				var len: int = level.grid[i].length;
				for (var j : int = 0; j < len; ++j) {
					level.nodes.setWalkable(j, i, level.grid[i][j]);
//					trace('walkable: ', j, i, level.grid[i][j]);
				}
			}
			level.entities = parseEntities(xml);
			System.disposeXML(xml);
		}

		/**
		 * parseGrid 
		 * 
		 * @param xml 
		 * 
		 * @return Array 
		 */
		private function parseGrid(xml : XML) : Vector.<Vector.<Boolean>> {
			var grid : Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>();
			var s : String = xml.descendants(GRID).valueOf();
			var rows : Array = s.split(/\r\n|\n|\r|\t/g);
			var l : int = rows.length;
			for (var i : int = 0; i < l; ++i) {
				var row : Array = String(rows[i]).split('');
				grid[i] = new Vector.<Boolean>();
				var len : int = row.length;
				for (var j : int = 0; j < len; ++j) {
					grid[i][j] = uint(row[j]) == 0;
				}
			}
			grid.fixed = true;
			return grid;
		}

		/**
		 * parseTiles 
		 * 
		 * @param xml 
		 * 
		 * @return Array 
		 */
		private function parseTiles(xml : XML) : Vector.<Vector.<uint>> {
			var grid : Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
			var s : String = xml.descendants(TILES).valueOf();
			var rows : Array = s.split(/\r\n|\n|\r|\t/g);
			var splitter: String = ',';
			var l : int = rows.length;
			for (var i : int = 0; i < l; ++i) {
				var row : Array = String(rows[i]).split(splitter);
				grid[i] = new Vector.<uint>();
				var len : int = row.length;
				for (var j : int = 0; j < len; ++j) {
					grid[i][j] = uint(row[j]);
				}
			}
			grid.fixed = true;
			return grid;
		}

		/**
		 * parseNodes 
		 * 
		 * @param xml 
		 * 
		 * @return Array 
		 */
		private function parseNodes(numCols : int, numRows : int) : Grid {
			return new Grid(numCols, numRows);
		}

		/**
		 * parseEntities 
		 * 
		 * @param xml 
		 * 
		 * @return Array 
		 */
		private function parseEntities(xml : XML) : OgmoEntityMap {
			var map : OgmoEntityMap = new OgmoEntityMap();
			var entityNode : XML = xml.child(ENTITIES)[0];
			if (!entityNode) return null;
			var entities : XMLList = entityNode.children();
			for each (var node : XML in entities) {
				var entity : OgmoEntity = new OgmoEntity(node.localName());
				var attributes : XMLList = node.attributes();
				for each (var attr : XML in attributes) {
					entity[attr.localName()] = attr.valueOf();
				}
				map.put(entity);
			}
			return map;
		}
		/**
		 * parseCamera 
		 * 
		 * @param xml 
		 * 
		 * @return Point 
		 */
		private function parseCamera(xml : XML) : Point {
			var cam : Point = new Point();
			var cameraNode : XML = xml.child("camera")[0];
			if (!cameraNode) return cam;
			cam.x = uint(cameraNode.attribute("x"));
			cam.y = uint(cameraNode.attribute("y"));
			return cam;
		}

		/**
		 * get
		 * 
		 * @param name
		 * 
		 * @return OgmoLevel
		 */
		public function get(name : String) : OgmoLevel {
			return _levelMap[name];
		}

		/**
		 * at
		 * 
		 * @param index
		 * 
		 * @return OgmoLevel
		 */
		public function at(index : uint) : OgmoLevel {
			return _levelList[index];
		}

		/**
		 * numLevels
		 * 
		 * @return uint
		 */
		public function get numLevels() : uint {
			return _levelList.length;
		}

		/**
		 * get levelMap
		 * 
		 * @return Dictionary
		 */
		public function get levelMap() : Dictionary {
			return _levelMap;
		}

		/**
		 * get levelList
		 * 
		 * @return Vector.<OgmoLevel>
		 */
		public function get levelList() : Vector.<OgmoLevel> {
			return _levelList;
		}
	}
}