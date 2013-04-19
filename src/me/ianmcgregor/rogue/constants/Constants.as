package me.ianmcgregor.rogue.constants {
	/**
	 * @author ianmcgregor
	 */
	public final class Constants {
		public static const NULL : String = null;
		public static const TILE_SIZE : Number = 32;
		public static const HALF_TILE_SIZE : Number = TILE_SIZE * 0.5;
		public static const TILE_ATLAS : String = "tiles32";
		// textures
		public static const TEXTURE_MONSTER : String = "3-11";
		public static const TEXTURE_BAT : String = "7-10";
		public static const TEXTURE_TREASURE : String = "4-11";
		public static const TEXTURE_PLAYER_1 : String = "4-0";
		public static const TEXTURE_PLAYER_2 : String = "4-1";
		public static const TEXTURE_GROUND : String = "3-12";
		public static const TEXTURE_WALL : String = "3-6";
		public static const TEXTURE_FOOD : String = "8-12";
		public static const TEXTURE_KEY : String = "2-2";
		public static const TEXTURE_EXIT : String = "4-4";
		public static const TEXTURE_EXIT_LOCKED : String = "4-5";
		public static const TEXTURE_ENTRANCE : String = "2-6";
		public static const TEXTURE_SWORD : String = "3-0";
		public static const TEXTURE_SPATTER : String = "spatter";
		public static const TEXTURE_ENEMY_BULLET : String = "enemybullet";
		public static const TEXTURE_TRAP : String = "0-10";
		public static const TEXTURE_TRAP_SPRUNG : String = "0-11";
		public static const TEXTURE_MOVEABLE : String = "4-7";
		public static const TEXTURE_POTION : String = "9-4";
		public static const TEXTURE_MAN : String = "0-14";
		public static const TEXTURE_TREE_MONSTER : String = "1-10";
		public static const TEXTURE_EXIT_LOCKED_2 : String = "1-3";
		// monsters
		
		public static const MONSTER_SNAKE : String = "enemyspawner";
		public static const MONSTER_MAN : String = "man";
		public static const MONSTER_TREE : String = "treemonster";
		// items
		public static const ITEM_TREASURE : String = "treasure";
		public static const ITEM_FOOD : String = "food";
		public static const ITEM_KEY : String = "key";
		public static const ITEM_POTION : String = "potion";
		public static const ITEM_EXIT : String = "exit";
		public static const ITEM_EXIT_GAP : String = "exitgap";
		public static const ITEM_EXIT_LOCKED : String = "exitlocked";
		public static const ITEM_EXIT_UNLOCKING : String = "exitunlocking";
		public static const ITEM_ENTRANCE : String = "entrance";
		public static const ITEM_ENTRANCE_GAP : String = "entrancegap";
		public static const ITEM_TRAP : String = "trap";
		public static const ITEM_TRAP_SPRUNG : String = "trapSprung";
		public static const ITEM_SWORD : String = "sword";
		public static const ITEM_MOVEABLE : String = "moveable";
		public static const ITEM_EXIT_LOCKED_2 : String = "exitlocked2";
		public static const ITEM_DOOR_2 : String = "door2";
		
		public static const ITEM_TEXTURES : Object = new Object();
		ITEM_TEXTURES[ITEM_TREASURE] = TEXTURE_TREASURE;
		ITEM_TEXTURES[ITEM_FOOD] = TEXTURE_FOOD;
		ITEM_TEXTURES[ITEM_KEY] = TEXTURE_KEY;
		ITEM_TEXTURES[ITEM_EXIT] = TEXTURE_EXIT;
		ITEM_TEXTURES[ITEM_EXIT_LOCKED] = TEXTURE_EXIT_LOCKED;
		ITEM_TEXTURES[ITEM_ENTRANCE] = TEXTURE_ENTRANCE;
		ITEM_TEXTURES[ITEM_TRAP] = TEXTURE_TRAP;
		ITEM_TEXTURES[ITEM_TRAP_SPRUNG] = TEXTURE_TRAP_SPRUNG;
		ITEM_TEXTURES[ITEM_MOVEABLE] = TEXTURE_MOVEABLE;
		ITEM_TEXTURES[ITEM_POTION] = TEXTURE_POTION;
		ITEM_TEXTURES[ITEM_SWORD] = TEXTURE_SWORD;
//		ITEM_TEXTURES[MONSTER_SNAKE] = TEXTURE_MAN;
//		ITEM_TEXTURES[MONSTER_MAN] = TEXTURE_MAN;
//		ITEM_TEXTURES[MONSTER_TREE] = TEXTURE_TREE_MONSTER;
		ITEM_TEXTURES[ITEM_EXIT_LOCKED_2] = TEXTURE_EXIT_LOCKED_2;
		
		// game vars
		public static const PLAYER_VELOCITY : Number = 15;
		public static const PLAYER_VELOCITY_DAMPENING : Number = 10;
		public static const MONSTER_COLLISION_DAMAGE : Number = 0.05;
		public static const MONSTER_HIT_DAMAGE : Number = 0.1;
		public static const FOOD_HEALTH_RESTORE : Number = 0.2;
		public static const BULLET_DAMAGE : Number = 0.01;
		public static const DEFAULT_MESSAGE_LIFETIME : Number = 2;
		public static const MIN_INTERSECTION_ITEM : Number = 0.5;
		
		// attack
		public static const ATTACK_READY : int = -1;
		public static const ATTACK_GO : int = 0;
		public static const ATTACK_PROGRESS : int = 1;
		// death
		public static const DEATH_NONE : int = -1;
		public static const DEATH_GO : int = 0;
		public static const DEATH_PROGRESS : int = 1;
		
		// messages
		public static const MESSAGE_HELLO : String = "Hello";
		public static const MESSAGE_LOCKED : String = "It's locked";
		public static const MESSAGE_KILLED_MONSTER : String = "Ha!";
		public static const MESSAGE_HIT_MONSTER : String = "Take that!";
		public static const MESSAGE_ATE_FOOD : String = "Om nom nom";
		public static const MESSAGE_GOT_WEAPON : String = "Yes!";
		public static const MESSAGE_HURT : String = "Ouch!";
	}
}
