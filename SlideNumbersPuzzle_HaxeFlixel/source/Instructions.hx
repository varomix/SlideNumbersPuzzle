package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import openfl.Assets;

using flixel.util.FlxSpriteUtil;

class Instructions extends FlxSubState
{

	var click_snd:FlxSound;

	public var btTitle:FlxBitmapText;

	override public function create():Void
	{

		click_snd = FlxG.sound.load(Reg.SND_CLICK);

	 	bgColor = 0xEE222222;

		// TITLE bitmap font
		var textBytes = Assets.getText("assets/bitmapfont/title-font_big-export.fnt");
		var XMLData = Xml.parse(textBytes);
		var titleText:FlxBitmapFont = FlxBitmapFont.fromAngelCode("assets/bitmapfont/title-font_big-export.png", XMLData);

		btTitle = new FlxBitmapText(titleText);
		btTitle.alignment = FlxTextAlign.CENTER;
		btTitle.lineSpacing= 5;
		btTitle.text = "SLIDE\nNUMBERS\nPUZZLE";
		btTitle.screenCenter();
		btTitle.y = 150;
		add(btTitle);

		var inst = new FlxText(0, 480, FlxG.width, "Put the numbers\nin order in the least\nmoves possible.\n\nGood luck!!");
		inst.setFormat("assets/data/LuckiestGuy.ttf", 50, FlxColor.WHITE, FlxTextAlign.CENTER);
		// inst.screenCenter(true, false);
		add(inst);


		var playBtn = new FlxButton(FlxG.width/2 - 100, 900, "PLAY", function(){ click_snd.play(); close(); } );
		playBtn.loadGraphic("assets/images/playblock.png");
		playBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 70, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, FlxColor.WHITE, true);
	    playBtn.labelOffsets[0].y = 20;
	    playBtn.labelOffsets[1].y = 15;
	    playBtn.labelOffsets[2].y = 25;
		add(playBtn);

	}

	
}