package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	// sounds
	public static inline var SND_CLICK:String = "assets/sounds/click2.ogg";
	public static inline var SND_PAUSE:String = "assets/sounds/pause.wav";
	public static inline var SND_MOVE:String = "assets/sounds/move.wav";
	public static inline var SND_SUCCESS:String = "assets/sounds/success.ogg";

	// Music
	public static inline var MUSIC:String = "assets/music/chiptune.ogg";

	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;

	public static var moves:Int = 0;

	public static var highScore:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}