package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxSubState;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;


class Instructions extends FlxSubState
{
	override public function create():Void
	{
	 	bgColor = 0xEE112222;
	
		var title2 = new FlxText(0, -50, FlxG.width, "\nSlide Numbers Puzzle", 50);
		title2.setFormat("assets/data/LuckiestGuy.ttf", 100, FlxColor.GOLDENROD, "center", FlxText.BORDER_SHADOW, FlxColor.CHARCOAL, true);
		title2.borderSize = 15;
		add(title2);

	 	var title = new FlxText(0, -50, FlxG.width, "\nSlide Numbers Puzzle", 50);
		title.setFormat("assets/data/LuckiestGuy.ttf", 100, FlxColor.GOLDENROD, "center", null, null, true);
		title.borderSize = 15;
		title.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 2);
		add(title);

		var inst = new FlxText(0, 380, FlxG.width, "Put the numbers in order\nin the least moves possible");
		inst.setFormat("assets/data/LuckiestGuy.ttf", 30, FlxColor.WHITE, "center");
		// inst.screenCenter(true, false);
		add(inst);


		var playBtn = new FlxButton(FlxG.width/2 - 100, 480, "PLAY", function(){ close(); } );
		playBtn.loadGraphic("assets/images/playblock.png");
		playBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 70, FlxColor.BLACK, "center", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
	    playBtn.labelOffsets[0].y = 20;
	    playBtn.labelOffsets[1].y = 15;
	    playBtn.labelOffsets[2].y = 25;
		add(playBtn);
	}
	
}