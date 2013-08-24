package me.ianmcgregor.fight.spatials {
	import me.ianmcgregor.fight.components.AvatarComponent;
	import me.ianmcgregor.fight.components.HUDComponent;
	import me.ianmcgregor.fight.constants.Constants;
	import me.ianmcgregor.fight.constants.EntityTag;
	import me.ianmcgregor.fight.spatials.gfx.HUDGfx;
	import me.ianmcgregor.games.artemis.components.TransformComponent;
	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;

	import starling.textures.TextureAtlas;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author ianmcgregor
	 */
	public final class HUDSpatial extends Spatial {
		/**
		 * components 
		 */
		private var _transform : TransformComponent;
		/**
		 * _hudComponent 
		 */
		private var _hudComponent : HUDComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : HUDGfx;
		
		
		/**
		 * HUDSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function HUDSpatial(world : World, owner : Entity) {
			super(world, owner);
		}
		
		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g : GameContainer) : void {
			/**
			 * transformMapper 
			 */
			var transformMapper : ComponentMapper = new ComponentMapper(TransformComponent, _world);
			_transform = transformMapper.get(_owner);
			/**
			 * titlesMapper 
			 */
			var hudMapper : ComponentMapper = new ComponentMapper(HUDComponent, _world);
			_hudComponent = hudMapper.get(_owner);
			/**
			 * isTwoPlayer
			 */
			var p1 : Entity = _world.getTagManager().getEntity(EntityTag.PLAYER_1);
			var avatar1 : AvatarComponent = p1.getComponent(AvatarComponent);
			
			var avatar2 : AvatarComponent;
			var p2 : Entity = _world.getTagManager().getEntity(EntityTag.PLAYER_2);
			if(p2) avatar2 = p2.getComponent(AvatarComponent);
			
			var isTwoPlayer : Boolean = p2 != null;
			/**
			 * _gfx
			 */
			var textureAtlas: TextureAtlas = g.assets.getTextureAtlas(Constants.SPRITES);
			_gfx = new HUDGfx(g.getWidth(), g.getHeight(), textureAtlas, isTwoPlayer, avatar1, avatar2);
			g.addChild(_gfx);
		}

		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			g;
			_gfx.x = _transform.x;
			_gfx.y = _transform.y;
			
			_gfx.update(1, _hudComponent.player[1].health, _hudComponent.player[1].score);
			_gfx.update(2, _hudComponent.player[2].health, _hudComponent.player[2].score);
			_gfx.updateBadGuy(1, _hudComponent.badGuy[1].active, _hudComponent.badGuy[1].name, _hudComponent.badGuy[1].health);
			_gfx.updateBadGuy(2, _hudComponent.badGuy[2].active, _hudComponent.badGuy[2].name, _hudComponent.badGuy[2].health);
		}
		
		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
			if(g.contains(_gfx)) {
				g.removeChild(_gfx);
			}
		}
	}
}
