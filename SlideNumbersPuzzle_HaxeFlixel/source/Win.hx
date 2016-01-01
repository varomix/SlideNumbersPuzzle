package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxSubState;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class Win extends FlxSubState
{
	override public function create():Void
	{	
	 	bgColor = 0xCC112222;

	 	var title = new FlxText(0, 	50, FlxG.width, "\nYou Win!", 50);
		title.setFormat("assets/data/LuckiestGuy.ttf", 60, FlxColor.GOLDENROD, "center", 0, 0, true);
		title.borderSize = 15;
		title.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 2);
		add(title);

	 	var moves = new FlxText(140, 170, FlxG.width, "\nMoves:  " + Reg.moves, 50);
	 	moves.setFormat("assets/data/LuckiestGuy.ttf", 50, FlxColor.WHITE, "left", FlxText.BORDER_SHADOW, FlxColor.BLACK, true);
	 	add(moves);

	 	var bestScore = new FlxText(30, 270, FlxG.width, "\nBest Score:  " + Reg.highScore, 50);
	 	bestScore.setFormat("assets/data/LuckiestGuy.ttf", 50, FlxColor.WHITE, "lef
	 		t", FlxText.BORDER_SHADOW, FlxColor.BLACK, true);
	 	add(bestScore);

		var playAgainBtn = new FlxButton(FlxG.width/2 -100, 480, "Play\nagain", restart);
		playAgainBtn.loadGraphic("assets/images/playblock.png");
		playAgainBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 40, FlxColor.BLACK, "center", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
	    playAgainBtn.labelOffsets[0].y = 15;
	    playAgainBtn.labelOffsets[1].y = 10;
	    playAgainBtn.labelOffsets[2].y = 20;
		add(playAgainBtn);

	}

	public function restart():Void
	{
		FlxG.switchState( new PlayState());
	}
	
}