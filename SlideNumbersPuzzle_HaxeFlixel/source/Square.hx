package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using flixel.util.FlxSpriteUtil;

class Square extends FlxButton
{
	private var _square:FlxButton;

	var fontSize:Int = 100;

	public function new(X:Float=0, Y:Float=0, name:String)
	{
	    super(X, Y, name);

	    loadGraphic("assets/images/block_180.png");
	    this.label.setFormat("assets/data/LuckiestGuy.ttf", fontSize, FlxColor.BLACK, "center", FlxTextBorderStyle.SHADOW, FlxColor.WHITE, true);
	    this.labelOffsets[0].y = fontSize/2;
	    this.labelOffsets[1].y = fontSize/2;
	    this.labelOffsets[2].y = fontSize/2;

	}
	
}