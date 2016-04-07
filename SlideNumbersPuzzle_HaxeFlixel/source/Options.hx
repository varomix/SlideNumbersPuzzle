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


class Options extends FlxSubState
{
	var click_snd:FlxSound;
	public var btTitle:FlxBitmapText;
	public static var musicBtn:FlxButton;
	public var sfxBtn:FlxButton;
	
	override public function create():Void
	{	

		click_snd = FlxG.sound.load(Reg.SND_CLICK);

	 	bgColor = 0xEE112222;

	 	// TITLE bitmap font
		var textBytes = Assets.getText("assets/bitmapfont/title-font_big-export.fnt");
		var XMLData = Xml.parse(textBytes);
		var titleText:FlxBitmapFont = FlxBitmapFont.fromAngelCode("assets/bitmapfont/title-font_big-export.png", XMLData);

		btTitle = new FlxBitmapText(titleText);
		btTitle.alignment = FlxTextAlign.CENTER;
		btTitle.lineSpacing= 5;
		btTitle.text = "OPTIONS";
		btTitle.screenCenter();
		btTitle.y = 70;
		add(btTitle);

		var restartBtn = new FlxButton(FlxG.width/2 - 235, 200, "Restart\ngame", restart);
		restartBtn.loadGraphic("assets/images/button.png");
		restartBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 80, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, FlxColor.WHITE, true);
	    restartBtn.labelOffsets[0].y = 15;
	    restartBtn.labelOffsets[1].y = 10;
	    restartBtn.labelOffsets[2].y = 20;
		add(restartBtn);

		musicBtn = new FlxButton(FlxG.width/2 - 235, 450, "MUSIC ON", music);
		musicBtn.loadGraphic("assets/images/button.png");
		musicBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 80, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, FlxColor.WHITE, true);
	    musicBtn.labelOffsets[0].y = 50;
	    musicBtn.labelOffsets[1].y = 45;
	    musicBtn.labelOffsets[2].y = 55;
		add(musicBtn);

		sfxBtn = new FlxButton(FlxG.width/2 - 235, 700, "SOUNDS ON", soundfx);
		sfxBtn.loadGraphic("assets/images/button.png");
		sfxBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 80, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, FlxColor.WHITE, true);
	    sfxBtn.labelOffsets[0].y = 50;
	    sfxBtn.labelOffsets[1].y = 45;
	    sfxBtn.labelOffsets[2].y = 55;
		add(sfxBtn);

		var playBtn = new FlxButton(FlxG.width/2 - 235, 950, "RESUME", resume);
		playBtn.loadGraphic("assets/images/button.png");
		playBtn.label.setFormat("assets/data/LuckiestGuy.ttf", 80, FlxColor.BLACK, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, FlxColor.WHITE, true);
	    playBtn.labelOffsets[0].y = 50;
	    playBtn.labelOffsets[1].y = 45;
	    playBtn.labelOffsets[2].y = 55;
		add(playBtn);

	}

	public static function music():Void
	{
	    // turn music on or off
	    PlayState.MuteSound();
	    trace(FlxG.sound.music.volume);
	    if(FlxG.sound.music.volume == 1)
	    {
	    	musicBtn.text = "MUSIC ON";
	    }
	    else
	   	{
	    	musicBtn.text = "MUSIC OFF";
	    }
	}

	public function soundfx():Void
	{
	    // turn sfx on or off
	}

	public function resume():Void
	{
		click_snd.play();
		PlayState.StartMusic();
		close();	
	}

	public function restart():Void
	{
		click_snd.play();
		FlxG.switchState( new PlayState());
	}
	
}