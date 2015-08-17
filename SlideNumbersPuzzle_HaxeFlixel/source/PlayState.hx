package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var square:Square;
	private var blankSquare:Square;
	private var boardGrp:FlxSpriteGroup;
	var order:Array<Int> = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		// create board group
		boardGrp = new FlxSpriteGroup(17, 15);
		
		// create BG
		var bg:FlxSprite = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/bg.jpg");
		add(bg);

		var title = new FlxText(0, 550, FlxG.width, "Slide Numbers Puzzle", 30);
		title.setFormat("assets/data/LuckiestGuy.ttf", 45, FlxColor.BLACK, "center", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
		add(title);

		// shuffle the numbers
		shuffleArray(order);
		
		// create the board
		createBoard();

	}

	public function shuffleArray(arr:Array<Int>)
	{
	    var tmp:Int, j:Int, i:Int=arr.length;
	    while( i > 0 )
	    {
	    	j = Std.int(Math.random() * i);
	    	tmp = arr[--i];
	    	arr[i] = arr[j];
	    	arr[j] = tmp;
	    }
	}

	public function createBoard():Void
	{
		var col:Int = 0;
		var row:Int = 0;

	    for (i in 0 ... 15)
	    {
	    	square = new Square(col * 128, row * 128, "" + order[i]);
	    	// add(square);
	    	boardGrp.add(square);


	    	col++;
	    	if(col >= 4)
	    	{
	    		col = 0;
	    		row++;
	    	}
	    }

	    // add the blank square
	    blankSquare = new Square(384, 384, "0");
	    blankSquare.ID = 0;
	    boardGrp.add(blankSquare);

	    // finally add the board to the stage
	    add(boardGrp);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}