package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxSubState;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;


class Options extends FlxSubState
{
	override public function create():Void
	{	
	 	bgColor = 0xEE112222;

	 	var title = new FlxText(0, 	50, FlxG.width, "\nOptions", 50);
		title.setFormat("assets/data/LuckiestGuy.ttf", 60, FlxColor.GOLDENROD, "center", null, null, true);
		title.borderSize = 15;
		title.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BLACK, 2);
		add(title);

		var restartBtn = new FlxButton(20, 100, "Restart", restart);
		add(restartBtn);

		var playBtn = new FlxButton(FlxG.width/2 - 100, 480, "RESUME", function(){ close(); } );
		playBtn.loadGraphic("assets/images/playblock.png");
		playBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 40, FlxColor.BLACK, "center", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
	    playBtn.labelOffsets[0].y = 35;
	    playBtn.labelOffsets[1].y = 30;
	    playBtn.labelOffsets[2].y = 40;
		add(playBtn);

	}

	public function restart():Void
	{
		FlxG.switchState( new PlayState());
	}
	
}