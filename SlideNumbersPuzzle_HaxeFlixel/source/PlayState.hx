package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.FlxSubState;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import openfl.Assets;

#if mobile
import extension.admob.AdMob;
import extension.admob.AdMobListener;
import extension.admob.AdMobGravity;
#end

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

	private var click_snd:FlxSound;
	private var move_snd:FlxSound;
	private var pause_snd:FlxSound;
	private var success_snd:FlxSound;

	public var btTitle:FlxBitmapText;
	public var btMoves:FlxBitmapText;
	public var btScore:FlxBitmapText;

	public static var mute:FlxButton;
	public static var soundfx:Bool;

	public var OptionsSub:Options;

	// we'll use this to save the high score
	public var _saveGame:FlxSave;

	public var highScoreInt:Int = 0;

	var xOffset = 24;
	var yOffset = 188;
	var tileSize = 180;

	// AdMob Ad unit ID
	var bannerId:String = "ca-app-pub-8169263597992779/9767114441";

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		// make it look smooth
		FlxG.camera.antialiasing = true;

		// TODO: get this from settings
		soundfx = true;

		#if mobile
		// admob start
		AdMob.init();
		AdMob.setListener(new AdMobListener());
		AdMob.setBannerPosition(AdMobHorizontalGravity.CENTER, AdMobVerticalGravity.BOTTOM);
		AdMob.refreshBanner(bannerId);
		#end

		// reset moves variable
		Reg.moves = 0;

		FlxG.camera.fade(FlxColor.BLACK, 1, true);

		click_snd = FlxG.sound.load(Reg.SND_CLICK);
		move_snd = FlxG.sound.load(Reg.SND_MOVE);
		pause_snd = FlxG.sound.load(Reg.SND_PAUSE);
		success_snd = FlxG.sound.load(Reg.SND_SUCCESS);

		_saveGame = new FlxSave();
		_saveGame.bind("gameSaveData");

		// create board group
		boardGrp = new FlxSpriteGroup(xOffset, yOffset);

		// create BG
		var bg:FlxSprite = new FlxSprite(0,0);
		bg.loadGraphic("assets/images/board_v03.png");
		add(bg);

		// bitmap font
		var textBytes = Assets.getText("assets/bitmapfont/title-font-export.fnt");
		var XMLData = Xml.parse(textBytes);
		var titleText:FlxBitmapFont = FlxBitmapFont.fromAngelCode("assets/bitmapfont/title-font-export.png", XMLData);

		btTitle = new FlxBitmapText(titleText);
		btTitle.x = 20;
		btTitle.y = 940;
		btTitle.lineSpacing= 5;
		btTitle.text = "SLIDE NUMBERS\n                    PUZZLE";
		add(btTitle);

		// MOVES TEXT
		btMoves = new FlxBitmapText(titleText);
		btMoves.x = 20;
		btMoves.y = 115;
		btMoves.text = "MOVES " + Reg.moves;
		add(btMoves);

		// get the previous high Score if exists
		if(_saveGame.data.highscore != null)
		{
			highScoreInt = _saveGame.data.highscore;
			Reg.highScore = _saveGame.data.highscore;
		}

		// SCORE TEXT
		btScore = new FlxBitmapText(titleText);
		btScore.x = 450;
		btScore.y = 80;
		btScore.text = "HI\nSCORE " + highScoreInt;
		add(btScore);

		// shuffle the numbers
		shuffleArray(order);

		// create the board
		createBoard();

		// Add the tree on top of everything
		var bgTree:FlxSprite = new FlxSprite(490,870);
		bgTree.loadGraphic("assets/images/board_tree.png");
		add(bgTree);

		
		var options = new FlxButton(32, 16, "", options);
		options.loadGraphic("assets/images/settings.png");
		add(options);

		mute = new FlxButton(670, 16, "", MuteSound);
		mute.loadGraphic("assets/images/music_on.png");
		add(mute);

		
		// CREATE SUBSTATES
		// create Instructions Substate
		var InstrucctionsSub:Instructions = new Instructions();
		InstrucctionsSub.closeCallback = StartMusic;   // start music on close
		openSubState(InstrucctionsSub);

	}

	public static function StartMusic():Void
	{
		if(FlxG.sound.music == null)
		{
			// TODO : Check settings to see if the user wants music
			FlxG.sound.playMusic(Reg.MUSIC,1, true);
		}
		else
		{
			FlxG.sound.music.volume = 1;
		}

		#if mobile
		// Show admob banner
		AdMob.showBanner(bannerId);
		#end
	}

	public function options():Void
	{
		click_snd.play();
		// FlxG.sound.music.volume = 0;

		openSubState(new Options());
		// openSubState(OptionsSub);
	}

	public static function MuteSound():Void
	{
		if(FlxG.sound.music.volume == 1)
		{
			FlxG.sound.music.volume = 0;
			mute.loadGraphic("assets/images/music_off.png");
		}
		else
		{
			FlxG.sound.music.volume = 1;
			mute.loadGraphic("assets/images/music_on.png");
		}
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
	    	square = new Square(col * tileSize, row * tileSize, "" + order[i]);

	    	// add color to odd numbers
	    	if(Std.parseInt(square.label.text) % 2 == 1)
	    	{
	    		square.color = 0xffffd700;
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
	    blankSquare = new Square(tileSize * 3, tileSize * 3, "0");
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

	    var speed = 0.15;

	    /// NOW WE CAN MOVE THEM
	    if(up)
	    {
	    	move_snd.play(true);
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x, btn.y - tileSize, speed, true, {onComplete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x, other.y + tileSize, speed, true);
	    }
	     if(down)
	    {
	    	move_snd.play(true);
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x, btn.y + tileSize, speed, true, {onComplete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x, other.y - tileSize, speed, true);
	    }
	     if(left)
	    {
	    	move_snd.play(true);
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x - tileSize, btn.y, speed, true, {onComplete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x + tileSize, other.y, speed, true);
	    }
	     if(right)
	    {
	    	move_snd.play(true);
	    	moving = true;
	    	FlxTween.linearMotion(btn, btn.x, btn.y, btn.x + tileSize, btn.y, speed, true, {onComplete:checkWin});
	    	FlxTween.linearMotion(other, other.x, other.y, other.x - tileSize, other.y, speed, true);
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

	    	FlxG.sound.music.fadeOut(0.25, 0);
	    	success_snd.play();

	    	// check for the high score
	    	if(Reg.moves < Std.parseInt(_saveGame.data.highscore) || highScoreInt == 0)
	    	{
	    		highScoreInt = Reg.moves;
	    		trace(" new HIGH SCORE ");
	    		_saveGame.data.highscore = Reg.moves;
	    		_saveGame.flush(); // save the data
	    	}

	    	// show win substate after a 2 sec pause
	    	var winTimer = new FlxTimer().start(0.5, showWinState, 1);

	    
	    }
	    else
	    {
	    	// if we didn't win add one to the moves count
			Reg.moves++;
			// and update the moves text
			btMoves.text = "MOVES " + Reg.moves;

	    }
	}

	public function showWinState(timer:FlxTimer)
	{
		FlxG.camera.fade(FlxColor.WHITE, 1, true);
		openSubState(new Win());
	}

	var btnTile:FlxButton = new FlxButton();
	public function getTile(X:Int, Y:Int):FlxButton
	{

		for (i in 0 ... boardGrp.length)
		{
			btnTile = cast (boardGrp.members[i], FlxButton);

			if(btnTile.x == (X  * tileSize) + xOffset && btnTile.y == (Y * tileSize) + yOffset )
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
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

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
