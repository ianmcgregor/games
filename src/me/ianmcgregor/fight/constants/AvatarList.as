package me.ianmcgregor.fight.constants {
	import me.ianmcgregor.fight.components.AvatarComponent;
	/**
	 * @author ianmcgregor
	 */
	public final class AvatarList {
		public static const HEROES : Vector.<AvatarComponent> = new Vector.<AvatarComponent>();
		HEROES[0] = new AvatarComponent("IGGY", "hero3");
		HEROES[1] = new AvatarComponent("IAN", "hero2");
		HEROES[2] = new AvatarComponent("KAREN", "hero");
		
		public static const HERO : Vector.<uint> = new Vector.<uint>(3);
		HERO[1] = 0;
		HERO[2] = 1;
		
		public static function getHeroAvatarComponent(playerNum: uint) : AvatarComponent {
			return HEROES[ HERO[playerNum] ];
		}
	}
}
