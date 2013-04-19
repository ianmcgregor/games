package me.ianmcgregor.games.input {
	/**
	 * @author ian
	 */
	public interface IKeyInput {
		// queries
		/**
		 * isUp 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		function isUp(keyCode : uint) : Boolean

		/**
		 * justPressed 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		function justPressed(keyCode : uint) : Boolean

		/**
		 * isDown 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		function isDown(keyCode : uint) : Boolean

//		function justReleased(keyCode : uint) : Boolean

		/**
		 * any 
		 * 
		 * @return 
		 */
		function any() : Boolean;

		/**
		 * keyString 
		 */
		function get keyString() : String;

		/**
		 * lastKey 
		 */
		function get lastKey() : uint;
		
		/**
		 * numKeysDown 
		 */
		function get numKeysDown() : uint;

		// commands
		/**
		 * setKeyUp 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		function setKeyUp(keyCode : uint) : void;
		
		/**
		 * setKeyDown 
		 * 
		 * @param keyCode 
		 * 
		 * @return 
		 */
		function setKeyDown(keyCode : uint) : void;
		
		/**
		 * clear 
		 * 
		 * @return 
		 */
		function clear() : void
		
		/**
		 * Syntactic sugar for player controls
		 */
		function up(): Boolean;
		 
		/**
		 * down 
		 * 
		 * @return 
		 */
		function down(): Boolean;
		 
		/**
		 * left 
		 * 
		 * @return 
		 */
		function left(): Boolean;
		 
		/**
		 * right 
		 * 
		 * @return 
		 */
		function right(): Boolean;

//		function getPhase(keyCode : uint) : uint

		// registered key listeners
		/**
		 * addKeyListener 
		 * 
		 * @param keyListener 
		 * 
		 * @return 
		 */
		function addKeyListener(keyListener : IKeyListener) : void;
		/**
		 * keyPressed 
		 * 
		 * @param key 
		 * 
		 * @return 
		 */
		function keyPressed(key : uint) : void;
		/**
		 * keyReleased 
		 * 
		 * @param key 
		 * 
		 * @return 
		 */
		function keyReleased(key : uint) : void;
	}
}
