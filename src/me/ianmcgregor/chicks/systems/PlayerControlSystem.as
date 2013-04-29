package me.ianmcgregor.chicks.systems {
	import me.ianmcgregor.games.utils.math.MathUtils;
	import me.ianmcgregor.chicks.assets.Assets;
	import me.ianmcgregor.chicks.components.GameConfigComponent;
	import me.ianmcgregor.chicks.components.PhysicsComponent;
	import me.ianmcgregor.chicks.components.PlayerComponent;
	import me.ianmcgregor.chicks.constants.Constants;
	import me.ianmcgregor.chicks.constants.EntityTag;
	import me.ianmcgregor.chicks.constants.KeyConstants;
	import me.ianmcgregor.chicks.constants.State;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.components.WeaponComponent;
	import me.ianmcgregor.games.audio.Audio;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.games.input.IKeyInput;
	import me.ianmcgregor.games.utils.nape.NapeUtils;
	import me.ianmcgregor.games.utils.ogmo.OgmoEntity;
	import me.ianmcgregor.games.utils.ogmo.OgmoLevel;

	import nape.geom.Vec2;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	/**
	 * @author ianmcgregor
	 */
	public final class PlayerControlSystem extends EntityProcessingSystem {
		/**
		 * _g 
		 */
		private var _g : GameContainer;
		/**
		 * _input 
		 */
		private var _input : IKeyInput;
		/**
		 * mappers 
		 */
		private var _playerMapper : ComponentMapper;
		private var _weaponMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
//		private var _velocityMapper : ComponentMapper;
		/**
		 * _timeNow
		 */
		private var _timeNow : Number;

		/**
		 * HeroControlSystem 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		public function PlayerControlSystem(g : GameContainer) {
			super(PlayerComponent, []);
			_g = g;
			_input = _g.getInput();
		}

		/**
		 * initialize 
		 * 
		 * @return 
		 */
		override public function initialize() : void {
			_playerMapper = new ComponentMapper(PlayerComponent, _world);
			_transformMapper = new ComponentMapper(TransformComponent, _world);
//			_velocityMapper = new ComponentMapper(VelocityComponent, _world);
			_weaponMapper = new ComponentMapper(WeaponComponent, _world);
		}

		/**
		 * added 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function added(e : Entity) : void {
			super.added(e);
		}

		/**
		 * removed 
		 * 
		 * @param e
		 * 
		 * @return 
		 */
		override protected function removed(e : Entity) : void {
			super.removed(e);
		}

		/**
		 * begin 
		 * 
		 * @return 
		 */
		override protected function begin() : void {
			super.begin();
			_timeNow = _g.getTimeNow();
		}

		/**
		 * processEntity 
		 * 
		 * @param e 
		 * 
		 * @return 
		 */
		override protected function processEntity(e : Entity) : void {
			/**
			 * player 
			 */
			var player: PlayerComponent = _playerMapper.get(e);
			var transform: TransformComponent = _transformMapper.get(e);
			var physics: PhysicsComponent = e.getComponent(PhysicsComponent);
			
			var onGround: Boolean = NapeUtils.getOnGround(physics.body, physics.body.userData.feet);
			
			// player1 
//			var player1: Boolean = player.playerNum == 1;
			// left 
//			var left: Boolean = player1 ? _input.isDown(KeyConstants.LEFT_P1) : _input.isDown(KeyConstants.LEFT_P2);
			var left: Boolean = _input.isDown(KeyConstants.LEFT_P1) || _input.isDown(KeyConstants.LEFT_P2);
			// right 
//			var right: Boolean = player1 ? _input.isDown(KeyConstants.RIGHT_P1) : _input.isDown(KeyConstants.RIGHT_P2);
			var right: Boolean = _input.isDown(KeyConstants.RIGHT_P1) || _input.isDown(KeyConstants.RIGHT_P2);
			// up 
//			var up: Boolean = player1 ? _input.isDown(KeyConstants.UP_P1) : _input.isDown(KeyConstants.UP_P2);
			var up: Boolean = _input.isDown(KeyConstants.UP_P1) || _input.isDown(KeyConstants.UP_P2);
			/**
			 * movement 
			 */
			var impulseX: Number = 0;
			var impulseY: Number = 0;
			
			var vH: Number = MathUtils.abs(physics.body.velocity.x);
//			var impulseStrength: Number = vH == 0 ? 1000 : 220;
			var impulseStrength: Number = 600 - vH;
			if(impulseStrength < 0) impulseStrength = 0;
			
			if (left) {
				impulseX = -impulseStrength * _world.getDelta();
				player.direction = -1;
			} else if (right) {
				impulseX = impulseStrength * _world.getDelta();
				player.direction = 1;
			} else {
				player.direction = 0;
				//NapeUtils.dampenVelocity(physics.body, 0.5, _world.getDelta());
			}
			
			if (up && onGround && physics.body.velocity.y > -1) {
//				impulseY = -10000 * _world.getDelta();
				impulseY = -220;
				Audio.play(Assets.chick_tweet);
			}
			physics.body.applyImpulse(Vec2.weak(impulseX, impulseY));
			if(physics.body.velocity.x < -impulseStrength) physics.body.velocity.x = -impulseStrength;
			if(physics.body.velocity.x > impulseStrength) physics.body.velocity.x = impulseStrength;
			
			var gameConfig: GameConfigComponent = _world.getTagManager().getEntity(EntityTag.GAME_CONFIG).getComponent(GameConfigComponent);
			var l: OgmoLevel = gameConfig.level;
			
			// scroll camera to keep up with player
			
			var scrollX : Number = _g.camera.x + _g.getWidth() * 0.6;
//			trace('scrollX: ' + (scrollX));	
			var posX: Number = physics.body.position.x;
			if(isNaN(posX)) posX = transform.x;
//			trace('posX: ' + (posX));
			if (posX > l.width - transform.width) {
//				physics.body.position.x = l.width - transform.width;
				physics.body.velocity.length = 0;
				_g.state = State.NEXT_LEVEL;
				Audio.play(Assets.chick_tweet_tweet);
				return;
			} else if(posX > scrollX) {
				var scroll: Number = posX - scrollX;
				var maxScroll : Number = _world.getDelta() * 200;
				if(scroll > maxScroll) scroll = maxScroll;

				var maxX : Number = l.width - _g.getWidth();
				if (_g.camera.x + scroll < maxX) {
					_g.camera.x += scroll;
				} else {
					_g.camera.x = maxX;
				}
				
			} else if(posX < _g.camera.x) {
				physics.body.position.x = _g.camera.x + 2;
				physics.body.velocity.length = 0;
			}
			
			
			// fell
			var posY: Number = physics.body.position.y;
			if(posY > _g.getHeight() + 64) {
//				trace('fell');
				var p: OgmoEntity = l.entities.getEntity(Constants.PLAYER_1);
				// back to start
				physics.body.position.x = p.x;
				physics.body.position.y = p.y;
				physics.body.velocity.length = 0;
				_g.camera.x = l.camera.x;
				_g.camera.y = l.camera.y;
				
				Audio.play(Assets.chick_fall);
			}
			
//			trace(physics.body.position.x, physics.body.position.y);
		}
	}
}
