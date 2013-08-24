package me.ianmcgregor.fight.systems {
	import me.ianmcgregor.fight.assets.Assets;
	import me.ianmcgregor.fight.components.CharacterComponent;
	import me.ianmcgregor.fight.components.GameConfigComponent;
	import me.ianmcgregor.fight.components.PhysicsComponent;
	import me.ianmcgregor.fight.components.PlayerComponent;
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.constants.EntityTag;
	import me.ianmcgregor.fight.constants.KeyConstants;
	import me.ianmcgregor.fight.constants.State;
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
			var player : PlayerComponent = _playerMapper.get(e);
			var transform : TransformComponent = _transformMapper.get(e);
			var physics : PhysicsComponent = e.getComponent(PhysicsComponent);
			var character : CharacterComponent = e.getComponent(CharacterComponent);
			
			player.opponent = null;

			var onGround : Boolean = NapeUtils.getOnGround(physics.body, physics.body.userData.feet);

			// player1
			var player1 : Boolean = player.playerNum == 1;
			// left
			var left : Boolean = player1 ? _input.isDown(KeyConstants.LEFT_P1) : _input.isDown(KeyConstants.LEFT_P2);
			// var left : Boolean = _input.isDown(KeyConstants.LEFT_P1) || _input.isDown(KeyConstants.LEFT_P2);
			// right
			var right : Boolean = player1 ? _input.isDown(KeyConstants.RIGHT_P1) : _input.isDown(KeyConstants.RIGHT_P2);
			// var right : Boolean = _input.isDown(KeyConstants.RIGHT_P1) || _input.isDown(KeyConstants.RIGHT_P2);
			// up
			var up : Boolean = player1 ? _input.isDown(KeyConstants.UP_P1) : _input.isDown(KeyConstants.UP_P2);
			// var up : Boolean = _input.isDown(KeyConstants.UP_P1) || _input.isDown(KeyConstants.UP_P2);
			// kick
			var kick : Boolean = player1 ? _input.justPressed(KeyConstants.A_P1) : _input.justPressed(KeyConstants.A_P2);
			// var kick : Boolean = _input.justPressed(KeyConstants.SHOOT_P1) || _input.justPressed(KeyConstants.SHOOT_P2);
			// punch
			var punch : Boolean = player1 ? _input.justPressed(KeyConstants.B_P1) : _input.justPressed(KeyConstants.B_P2);
			// var punch : Boolean = _input.justPressed(KeyConstants.SHOOT_B_P1) || _input.justPressed(KeyConstants.SHOOT_B_P2);

			character.updateTime(_timeNow);

			if (kick) {
				var kicked : Boolean = character.kick();
				if (kicked) Audio.play(Assets.Hit_Hurt28);
			} else if (punch) {
				var punched : Boolean = character.punch();
				if (punched) Audio.play(Assets.Hit_Hurt36);
			}

			/**
			 * movement 
			 */
			const velH : Number = 200;
			if (left) {
				// * _world.getDelta();
				physics.body.velocity.x = -velH;
				character.directionH = -1;
			} else if (right) {
				physics.body.velocity.x = velH;
				character.directionH = 1;
			} else {
				character.directionH = 0;
				if (onGround) physics.body.velocity.x = 0;
				// NapeUtils.dampenVelocity(physics.body, 0.5, _world.getDelta());
			}

			if (up && onGround) {
				physics.body.applyImpulse(Vec2.weak(0, -600));
				character.directionV = -1;
				Audio.play(Assets.Powerup24);
			} else if (onGround) {
				character.directionV = 0;
				// velY > 0 ? 1 : velY < 0 ? -1 : 0;
			}

			var gameConfig : GameConfigComponent = _world.getTagManager().getEntity(EntityTag.GAME_CONFIG).getComponent(GameConfigComponent);
			var l : OgmoLevel = gameConfig.level;
			
			/*
			var direction : int;
			if (left || right) {
				direction = left ? -1 : 1;
				LayoutUtils.scrollCameraX(_g.camera, physics.body.position.x, false, l.width, _g.getWidth() * 0.6, _g.getWidth(), _g.getWidth() * 0.4, direction);
			}
			
			if(up || down) {
				direction = left ? -1 : 1;
				LayoutUtils.scrollCameraY(_g.camera, physics.body.position.y, false, l.height, _g.getHeight() * 0.6, _g.getHeight(), _g.getHeight() * 0.4, direction);
			}
			 */

			// scroll camera to keep up with player
			var scrollX : Number = _g.camera.x + _g.getWidth() * 0.6;
			var posX : Number = physics.body.position.x;
			if (isNaN(posX)) posX = transform.x;
			if (posX > l.width - transform.width) {
				physics.body.velocity.x = 0;
				_g.state = State.NEXT_LEVEL;
				// Audio.play(Assets.chick_tweet_tweet);
				return;
			} else if (posX > scrollX) {
				var scroll : Number = posX - scrollX;
				var maxScroll : Number = _world.getDelta() * 200;
				if (scroll > maxScroll) scroll = maxScroll;

				var maxX : Number = l.width - _g.getWidth();
				if (_g.camera.x + scroll < maxX) {
					_g.camera.x += scroll;
				} else {
					_g.camera.x = maxX;
				}
			} else if (posX < _g.camera.x) {
				physics.body.position.x = _g.camera.x + 2;
				physics.body.velocity.x = 0;
			}

			// fell
			var posY : Number = physics.body.position.y;
			if (posY > _g.getHeight() + 64) {
				var p : OgmoEntity = l.entities.getEntity(Constants.PLAYER_1);
				// back to start
				physics.body.position.x = p.x;
				physics.body.position.y = p.y;
				physics.body.velocity.x = 0;
				physics.body.velocity.y = 0;
				_g.camera.x = l.camera.x;
				_g.camera.y = l.camera.y;

				// Audio.play(Assets.chick_fall);
			}
			//if(isNaN(physics.body.velocity.y)) physics.body.velocity.y = 0;
		}
	}
}
