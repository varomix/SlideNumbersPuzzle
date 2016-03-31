package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

using flixel.util.FlxSpriteUtil;


class Instructions extends FlxSubState
{

	var click_snd:FlxSound;


	override public function create():Void
	{

		click_snd = FlxG.sound.load(Reg.SND_CLICK);

	 	bgColor = 0xEE112222;
	
		var title2 = new FlxText(0, -50, FlxG.width, "\nSlide Numbers Puzzle", 50);
		title2.setFormat("assets/data/LuckiestGuy.ttf", 100, 0xffdaa520, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, 0xff464646, true);
		title2.borderSize = 15;
		add(title2);

	 	var title = new FlxText(0, -50, FlxG.width, "\nSlide Numbers Puzzle", 50);
		title.setFormat("assets/data/LuckiestGuy.ttf", 100, 0xffdaa520, FlxTextAlign.CENTER);
		title.borderSize = 15;
		title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		add(title);

		var inst = new FlxText(0, 380, FlxG.width, "Put the numbers in order\nin the least moves possible");
		inst.setFormat("assets/data/LuckiestGuy.ttf", 30, FlxColor.WHITE, FlxTextAlign.CENTER);
		// inst.screenCenter(true, false);
		add(inst);


		var playBtn = new FlxButton(FlxG.width/2 - 100, 480, "PLAY", function(){ click_snd.play(); close(); } );
		playBtn.loadGraphic("assets/images/playblock.png");
		playBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 70, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, FlxColor.WHITE, true);
	    playBtn.labelOffsets[0].y = 20;
	    playBtn.labelOffsets[1].y = 15;
	    playBtn.labelOffsets[2].y = 25;
		add(playBtn);
	}
	
}