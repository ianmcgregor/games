package me.ianmcgregor.games.input {
	/**
	 * @author ian
	 */
	public interface IKeyListener {
		/**
		 * keyPressed 
		 * 
		 * @param key 
		 * @param c 
		 * 
		 * @return 
		 */
		function keyPressed(key : uint, c : String) : void;

		/**
		 * keyReleased 
		 * 
		 * @param key 
		 * @param c 
		 * 
		 * @return 
		 */
		function keyReleased(key : uint, c : String) : void;

		/**
		 * inputEnded 
		 * 
		 * @return 
		 */
		function inputEnded() : void;

		/**
		 * inputStarted 
		 * 
		 * @return 
		 */
		function inputStarted() : void;

		/**
		 * isAcceptingInput 
		 * 
		 * @return 
		 */
		function isAcceptingInput() : Boolean;

		/**
		 * setInput 
		 * 
		 * @param input 
		 * 
		 * @return 
		 */
		function setInput(input : IKeyInput) : void;
	}
}
