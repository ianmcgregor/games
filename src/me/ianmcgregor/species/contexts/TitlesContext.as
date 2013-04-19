package me.ianmcgregor.species.contexts {
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.base.IContext;
	import me.ianmcgregor.games.ui.QuickText;
	import me.ianmcgregor.species.Species;
	import me.ianmcgregor.species.constants.StateConstants;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;

	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public class TitlesContext implements IContext {
		/**
		 * _container 
		 */
		private var _container : GameContainer;
		/**
		 * _menu 
		 */
		private var _menu : Sprite;
		/**
		 * _main 
		 */
		private var _main : Species;
		/**
		 * _title 
		 */
		private var _title : QuickText;
		/**
		 * _body 
		 */
		private var _body : QuickText;
		/**
		 * _button 
		 */
		private var _button : QuickText;

		/**
		 * TitlesState 
		 * 
		 * @param container 
		 * @param main 
		 * 
		 * @return 
		 */
		public function TitlesContext(container : GameContainer, main : Species) {
			super();
			_container = container;
			_main = main;
		}
		/**
		 * init 
		 * 
		 * @return 
		 */
		public function init() : void {
			
			_container.addChild(_menu = new Sprite());
			_menu.addChild(_title = new QuickText(40, 10, "SPECIES"));
			_title.scaleX = _title.scaleY = 6;
			_menu.addChild(_body = new QuickText(200, 100, "Humans have evolved into 2 separate species. The aggressive, dominant species are keeping the good natured species imprisoned underground working for them. \nYou lead the rebellion!"));
			_body.scaleX = _body.scaleY = 2;

			_menu.addChild(_button = new QuickText(200, 50, "PRESS ANY KEY TO START\nUSE ARROW KEYS TO MOVE \n SPACE TO SHOOT"));
			_button.scaleX = _button.scaleY = 2;
			
			_title.x = ( _container.getWidth() - _title.width ) * 0.5;
			_title.y = 40;
			
			_body.x = ( _container.getWidth() - _body.width ) * 0.5;
			_body.y = 90;
			
			_button.x = ( _container.getWidth() - _button.width ) * 0.5;
			_button.y = 270;
			
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onButtonTriggered);
		}

		/**
		 * onButtonTriggered 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onButtonTriggered(event : KeyboardEvent) : void {
			event;
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onButtonTriggered);
			_container.removeChild(_menu);
			_main.changeState(StateConstants.PLAY);
        }
		
		/**
		 * update 
		 * 
		 * @param deltaTime 
		 * 
		 * @return 
		 */
		public function update(deltaTime : Number) : void {
			deltaTime;
		}

		/**
		 * world 
		 */
		public function get world() : World {
			return null;
		}
	}
}
