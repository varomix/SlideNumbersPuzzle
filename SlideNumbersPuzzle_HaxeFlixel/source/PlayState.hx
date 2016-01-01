package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;

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

	// we'll use this to save the high score
	public var _saveGame:FlxSave;

	//public var numMoves:Int = 0;
	var movesTxt:FlxText;

	var highScoreTxt:FlxText;
	public var highScoreInt:Int = 0;


	var xOffset = 17;
	var yOffset = 15;
	var tileSize = 128;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		
		_saveGame = new FlxSave();
		_saveGame.bind("gameSaveData");

		// create board group
		boardGrp = new FlxSpriteGroup(17, 15);
		
		// create BG
		var bg:FlxSprite = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/bg.jpg");
		add(bg);

		var title = new FlxText(0, 605, FlxG.width, "Slide Numbers Puzzle", 30);
		title.setFormat("assets/data/LuckiestGuy.ttf", 34, FlxColor.BLACK, "center", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
		add(title);

		movesTxt = new FlxText(30, 550, FlxG.width, "Moves: " + Reg.moves, 30);
		movesTxt.setFormat("assets/data/LuckiestGuy.ttf", 30, FlxColor.BLACK, "left", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
		add(movesTxt);

		// get the previous high Score if exists
		if(_saveGame.data.highscore != null)
		{
			highScoreInt = _saveGame.data.highscore;
			Reg.highScore = _saveGame.data.highscore;
		}

		highScoreTxt = new FlxText(280, 550, FlxG.width, "Hi Score: " + highScoreInt, 30);
		highScoreTxt.setFormat("assets/data/LuckiestGuy.ttf", 30, FlxColor.BLACK, "left", FlxText.BORDER_SHADOW, FlxColor.WHITE, true);
		add(highScoreTxt);


		// shuffle the numbers
		shuffleArray(order);

		// create the board
		createBoard();

		var options = new FlxButton(490, 605, "", options);
		options.loadGraphic("assets/images/settings.png");
		add(options);

		openSubState(new Instructions());
		// openSubState(new Win());


	}

	public function options():Void
	{
		openSubState( new Options() );
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

	    	// add color to odd numbers
	    	if(Std.parseInt(square.label.text) % 2 == 1)
	    	{
	    		square.color = FlxColor.GOLDEN;
	    	}

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
	    // blankSquare.alpha = 0.1;
		blankSquare.visible = false;

	    boardGrp.add(blankSquare);

	    // finally add the board to the stage
	    add(boardGrp);

	}

	var moving:Bool = false;

	public function moveNumbers(btn:FlxButton):Void
	{
		// store original coordinates
		var posX = btn.x;
		var posY = btn.y;

		var up = false;
		var right = false;
		var down = false;
		var left = false;

		// move the button to find the open spot

		var col:Int = 0;
		var row:Int = 0;
		
		// move UP
		btn.y += -20;
		// check if we're overlaping with the button with ID = 0
	    for (i in 0 ... boardGrp.length)
	    {
	    	var other:FlxButton = cast (boardGrp.members[i], FlxButton);

			if(FlxG.overlap(btn, other))
			{
				if (other.ID == 0)
				{
					up = true;
				}
			}

	    	col++;
	    	if(col >= 4)
	    	{
	    		col = 0;
	    		row++;
	    	}
	    }
	    // reset position
	    btn.x = posX;
	    btn.y = posY;

	    // move DOWN
		btn.y += 20;
		// check if we're overlaping with the button with ID = 0
	    for (i in 0 ... boardGrp.length)
	    {
	    	var other:FlxButton = cast (boardGrp.members[i], FlxButton);

			if(FlxG.overlap(btn, other))
			{
				if (other.ID == 0)
				{
					down = true;
				}
			}

	    	col++;
	    	if(col >= 4)
	    	{
	    		col = 0;
	    		row++;
	    	}
	    }
	    // reset position
	    btn.x = posX;
	    btn.y = posY;

	     // move LEFT
		btn.x += -20;
		// check if we're overlaping with the button with ID = 0
	    for (i in 0 ... boardGrp.length)
	    {
	    	var other:FlxButton = cast (boardGrp.members[i], FlxButton);

			if(FlxG.overlap(btn, other))
			{
				if (other.ID == 0)
				{
					left = true;
				}
			}

	    	col++;
	    	if(col >= 4)
	    	{
	    		col = 0;
	    		row++;
	    	}
	    }
	    // reset position
	    btn.x = posX;
	    btn.y = posY;

	    var other:FlxButton = new FlxButton();
	     // move RIGHT
		btn.x += 20;
		// check if we're overlaping with the button with ID = 0
	    for (i in 0 ... boardGrp.length)
	    {
	    	other = cast (boardGrp.members[i], FlxButton);

			if(FlxG.overlap(btn, other))
			{
				if (other.ID == 0)
				{
					right = true;
				}
			}

	    	col++;
	    	if(col >= 4)
	    	{
	    		col = 0;
	    		row++;
	    	}
	    }
	    // reset position
	    btn.x = posX;
	    btn.y = posY;


	    // trace("up: " + up );
	    // trace("right: " + right );
	    // trace("down: " + down );
	    // trace("left: " + left );

	    var speed = 0.15;

	    /// NOW WE CAN MOVE THEM
	    if(up)
	    {
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x, btn.y - 128, speed, true, {complete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x, other.y + 128, speed, true);
	    }
	     if(down)
	    {
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x, btn.y + 128, speed, true, {complete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x, other.y - 128, speed, true);
	    }
	     if(left)
	    {
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x - 128, btn.y, speed, true, {complete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x + 128, other.y, speed, true);
	    }
	     if(right)
	    {
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x + 128, btn.y, speed, true, {complete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x - 128, other.y, speed, true);
	    }
	}

	var winOrder_pattern01:String = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0,";
	var currentOrder:String;
	var col:Int = 0;
	var row:Int = 0;
	var btn:FlxButton;
	public function checkWin(_)
	{
		moving = false;
		
		currentOrder = "";  //so we don't get null, initialize it

		col = 0;
		row = 0;
		for (i in 0 ... 16)
	    {
	    	

	    	btn = getTile(col,row);
	    	currentOrder += btn.label.text + ",";

	    	col++;
	    	if(col >= 4)
	    	{
	    		col = 0;
	    		row++;
	    	}
	    }

	    // trace("current order: " + currentOrder + "  win pattern: " + winOrder_pattern01);
	    if(currentOrder == winOrder_pattern01)
	    {
	    	trace("Pattern one you WIN!!");

	    	// check for the high score 
	    	if(Reg.moves < Std.parseInt(_saveGame.data.highscore) || highScoreInt == 0)
	    	{
	    		highScoreInt = Reg.moves;
	    		trace(" new HIGH SCORE ");
	    		_saveGame.data.highscore = Reg.moves;
	    		_saveGame.flush(); // save the data
	    	}

	    	// show win substate after a 2 sec pause
	    	new FlxTimer(0.5, function(_)
	    	{
	    		FlxG.camera.fade(FlxColor.WHITE, 1, true);
	    		openSubState(new Win());
	    	});
	    }
	    else
	    {
	    	// if we didn't win add one to the moves count
			Reg.moves++;
			// and update the moves text
			movesTxt.text = "Moves: " + Reg.moves;

	    }
	}

	var btnTile:FlxButton = new FlxButton();
	public function getTile(X:Int, Y:Int):FlxButton
	{
		
		for (i in 0 ... boardGrp.length)
		{
			btnTile = cast (boardGrp.members[i], FlxButton);

			if(btnTile.x == (X  * 128) + xOffset && btnTile.y == (Y * 128) + yOffset )
			{
				return btnTile;
			}
		}
		return btnTile;
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

	var btnClick:FlxButton;
	override public function update():Void
	{
		super.update();

		// clicking on the buttons
		if(FlxG.mouse.justPressed)
		{
			for (i in 0 ... boardGrp.length)
			{
				btnClick = cast (boardGrp.members[i], FlxButton);

				if (btnClick.status == FlxButton.PRESSED)
				{
					if(moving == false)  // Only move if a piece is not moving
					{
						moveNumbers(btnClick);
					}
				}

			}
		}
	}	
}