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

	public function new(X:Float=0, Y:Float=0, name:String)
	{
	    super(X, Y, name);

	    loadGraphic("assets/images/block.png");
	    this.label.setFormat("assets/data/LuckiestGuy.ttf", 70, FlxColor.BLACK, "center", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
	    this.labelOffsets[0].y = 35;
	    this.labelOffsets[1].y = 35;
	    this.labelOffsets[2].y = 35;

	}
	
}