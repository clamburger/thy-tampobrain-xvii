class Game {
	static var _mc, photo_mc, output_mc, input_mc, tw, tp, dead, continuePlease, curRoomName, curRoom, inputMode, responses, waitForEnter, dontHideItemThisTurn, responseIndex, dt, keyListener, flaskGm, scrapbookMode, acceptInput, waitForEnterCallback, item_mc, deathGuy;
	function Game() {
	}
	static function init(p_mc) {
		_mc = p_mc;
		photo_mc = Game._mc.photo_mc;
		output_mc = Game._mc.output_mc;
		input_mc = Game._mc.input_mc;
		tw = new TextWriter(Game.output_mc.output, Game.output_mc, 3);
		tp = new TextParser();
		dead = false;
		SoundFX.init();
		playingFlaskGame = false;
		if (Game.continuePlease == true) {
			GameState.clear();
			//SaveGame.load(0);
			continuePlease = false;
		} else {
			GameState.clear();
			curRoomName = "spikes";
		}
		Game.setAcceptInput(false);
		//		Game.setScanlines("gameplay");
		Game.createRoomObject();
		Game.doneFadingRoomOut();
		Game._mc.youAreHere_txt.text = Game.curRoom.getName();
		Game.output(Game.curRoom.r);
		inputMode = "free";
		responses = new Array();
		waitForEnter = false;
		Game.initKeyboardInput();
		Game.updateScoreString();
	}
	static function scrollText() {
		Game._mc.scrollText.play();
	}	
	static function createRoomObject(roomname) {
		delete Game.curRoom;
		if (roomname != undefined) {
			curRoomName = roomname;
		}
		switch (Game.curRoomName) {
		case "spikes" :
			curRoom = new Room_spikes();
			break;
		case "crossroads" :
			curRoom = new Room_crossroads();
			break;
		case "center_west" :
			curRoom = new Room_center_west();
			break;
		case "shortcut" :
			curRoom = new Room_shortcut();
			break;
		case "gokul" :
			curRoom = new Room_gokul();
			break;
		case "center_east" :
			curRoom = new Room_center_east();
			break;
		case "simulate" :
			curRoom = new Room_simulate();
			break;
		case "virtual" :
			curRoom = new Room_virtual();
			break;
		case "corridor_north" :
			curRoom = new Room_corridor_north();
			break;
		case "corridor_south" :
			curRoom = new Room_corridor_south();
			break;
		case "lavalake" :
			curRoom = new Room_lavalake();
			break;
		case "snake" :
			curRoom = new Room_snake();
			break;
		case "secret_lab" :
			curRoom = new Room_secret_lab();
			break;
		case "puzzle_tampo" :
			curRoom = new Room_puzzle_tampo();
			break;
		case "puzzle_brody" :
			curRoom = new Room_puzzle_brody();
			break;
		case "puzzle_stlunko" :
			curRoom = new Room_puzzle_stlunko();
			break;
		case "end_game" :
			curRoom = new Room_end_game();
			break;
		default :
			Game.die();
			break;
		}
	}
	static function output(text) {
		Game.tw.set(text);
	}
	static function inputSubmitted() {
		dontHideItemThisTurn = false;
		var _loc1 = Game.curRoom.getName();
		Game.addCycleResponse(Game.input_mc.input.text);
		responseIndex = Game.responses.length;
		Game.tp.set(Game.input_mc.input.text);
		Game.setAcceptInput(false);
		//trace("inputSubmitted(): curRoom.r = "+Game.curRoom.r);
		Game.input_mc.input.text = "";
		Game.curRoom.r = "";
		Game.curRoom.parse();
		Game.curRoom.postParse();
		Game.hideItem();
		if (!Game.playingFlaskGame) {
			Game.tw.set(Game.curRoom.r);
		}
	}
	static function newRoom(roomname) {
		if (GameState.virusUpload<99) {
			//trace("Game::newRoom "+roomname);
			dontHideItemThisTurn = true;
			Game.createRoomObject(roomname);
			Game._mc.youAreHere_txt.text = Game.curRoom.getName();
			Game.dt.startOut(Game.doneFadingRoomOut);
			//SaveGame.save(0);
		} else {
			Game.curRoom.put("The virus upload has now reached 100%.");
			Game.curRoom.put("\n\nIn a matter of seconds, the Lava Zone and everyone in it is overtaken by a wave of the reality-altering virus, and you and everything else have been mutated by the virus. As it spreads across the globe, it will be nigh-impossible for anyone to stop it. I hope you enjoyed your old reality while it lasted, because now everything is zany, random and under the virus' control. Basically, it sucks. You don't exactly die, but you lose just the same.");
			Game.die();
			return (true);
		}
	}
	static function changeRoomName(roomname) {
		Game._mc.youAreHere_txt.text = roomname;
		//trace("Game::changeRoomName "+roomname);
	}
	static function woodsFade() {
		Game.dt.startOut(Game.doneFadingRoomOut);
	}
	static function doneFadingRoomOut() {
		//trace("Game::doneFadingRoomOut()");
		//		Game.photo_mc.attachMovie("room_"+Game.curRoomName, "roomPhoto_mc", 1);
		Game.curRoom.hideItems();
		Game.centerPhoto();
		delete Game.dt;
		//		dt = new DissolveTransition(Game.photo_mc, 6, 200);
		Game.dt.startIn();
		dontHideItemThisTurn = false;
		Game.hideItem();
	}
	static function doneFadingRoomIn() {
		//trace("doneFadingRoomIn()");
		Game.curRoom.displayItems();
	}
	static function clearPicture() {
		Game.photo_mc.roomPhoto_mc.removeMovieClip();
	}
	static function addCycleResponse(strToAdd) {
		if (strToAdd == "\n") {
			return;
		}
		if (strToAdd == "") {
			return;
		}
		Game.responses.push(strToAdd);
		if (Game.responses.length>30) {
			Game.responses.splice(0, 1);
		}
	}
	static function cycleResponses(up) {
		//trace("Game::cycleResponses()");
		if (up) {
			responseIndex = --Game.responseIndex;
		} else {
			responseIndex = ++Game.responseIndex;
		}
		if (Game.responseIndex>=Game.responses.length) {
			Game.input_mc.input.text = "";
			responseIndex = Game.responses.length;
			return;
		}
		if (Game.responseIndex<0) {
			responseIndex = 0;
		}
		Game.input_mc.input.text = Game.responses[Game.responseIndex];
	}
	static function initKeyboardInput() {
		Key.removeListener(Game.keyListener);
		keyListener = new Object();
		Game.keyListener.onKeyDown = function() {
			Game.keyPressed();
		};
		Key.addListener(Game.keyListener);
	}
	static function keyPressed() {
		var _loc1 = String.fromCharCode(Key.getAscii());
		var _loc2 = Key.getCode();
		if (_loc2 == 13 && Game.playingFlaskGame && !Game.dead) {
			Game.flaskGm.enterPressed();
			return;
		}
		if (Game.scrapbookMode && _loc2 == 13) {
			Game.inputSubmitted();
			return;
		}
		if (_loc2 == 13) {
			/* if (GameState.nameEnter) {
				GameState.dungeonName = Game.input_mc.input.text;
				GameState.nameEnter = false;
			} */
			if (!Game.tw.done) {
				_loc1 = "";
				Game.tw.skipToEnd();
			} else if (Game.waitForEnter) {
				_loc1 = "";
				Game.input_mc.input.text = "";
				Game.curRoom.r = "";
				waitForEnter = false;
				//trace("Game::keyPressed() before "+Game.curRoom.r+" = r");
				if (Game.dead) {
					Game.postDead();
				} else {
					Game.curRoom.pressEnterCallback();
				}
				//trace("Game::keyPressed() after "+Game.curRoom.r+" = r");
				Game.tw.set(Game.curRoom.r);
			} else if (Game.acceptInput) {
				if (Game.input_mc.input.text == "") {
					_loc1 = "";
				} else if (Game.input_mc.input.text.length>0) {
					Game.inputSubmitted();
				}
			}
		}
		if (_loc2 == 38 && Game.acceptInput) {
			Game.cycleResponses(true);
		}
		if (_loc2 == 40 && Game.acceptInput) {
			Game.cycleResponses(false);
		}
		if (_loc2 == 8 || _loc2 == 46 || _loc2 == 37) {
			Game.input_mc.input.text = Game.input_mc.input.text.slice(0, Game.input_mc.input.text.length-1);
			return;
		}
		if (Game.acceptInput) {
			Game.input_mc.input.text = Game.input_mc.input.text+_loc1;
		}
	}
	static function centerPhoto() {
		Game.photo_mc._x = Game.STAGE_WIDTH/2-Game.photo_mc._width/2;
	}
	static function setAcceptInput(val) {
		if (Game.scrapbookMode) {
			val = false;
		}
		if (Game.inputMode == "yn") {
			Game.input_mc.question_txt.text = "Yes or no:";
		} else if (Game.inputMode == "talk") {
			Game.input_mc.question_txt.text = "What will you do?";
		} else {
			Game.input_mc.question_txt.text = "What will you do?";
		}
		acceptInput = val;
		Game.input_mc._visible = val;
	}
	static function doneTextWriting() {
		if (!Game.waitForEnter && !Game.dead) {
			Game.setAcceptInput(true);
		}
	}
	static function die(person) {
		//trace("Game::die("+person+"): You dead!");
		Game.changeRoomName("My stummy hurts...");
		deathGuy = person;
		dead = true;
		Game.addPause(Game.postDead);
		Game.photo_mc.roomPhoto_mc.counter = 0;
		Game.photo_mc.roomPhoto_mc.onEnterFrame = function() {
			++Game.photo_mc.roomPhoto_mc.counter;
			if (Game.photo_mc.roomPhoto_mc.counter == 12) {
				Game.photo_mc._alpha = Game.photo_mc._alpha-10;
				Game.photo_mc.roomPhoto_mc.counter = 0;
				if (Game.photo_mc._alpha<=0) {
					delete Game.photo_mc.roomPhoto_mc.onEnterFrame;
				}
			}
		};
	}
	static function postDead() {
		//trace("post Dead called!");
		Game._mc.gotoAndPlay("gameOver");
		if (deathGuy == "brody" || deathGuy == "stlunko") {
			Game._mc.characters.gotoAndStop(deathGuy);
		}
		//Game.setScanlines("full");
		SoundFX.stopAll();
	}
	static function addPause(callback) {
		//trace("Game:: addPause called");
		waitForEnter = true;
		waitForEnterCallback = callback;
		Game.curRoom.put("\n[PRESS ENTER]");
	}
	static function photoAlbumMode() {
	}
	static function hideItem() {
		if (Game.dontHideItemThisTurn) {
			return;
		}
		Game.item_mc.removeMovieClip();
	}
	static function updateScoreString() {
		Game._mc.score_txt.text = "Score: "+GameState.score+"/"+GameState.maxScore;
	}
	static function scorePoints(num) {
		if (num>=1) {
			GameState.score = GameState.score+num;
		}
		switch (num) {
		case 0.3 :
		case 3 :
			SoundFX.play("happy.wav");
			break;
		case 0.2 :
		case 2 :
			SoundFX.play("happy_2pt.wav");
			break;
		case 0.1 :
		case 0 :
		case 1 :
			SoundFX.play("happy_1pt.wav");
			break;
		case 4 :
			break;
		default :
			SoundFX.play("happy.wav");
			break;
		}
		Game.updateScoreString();
	}
	static function flaskGameStart() {
		Game._mc.gotoAndStop("flaskGame");
		flaskGm = new FlaskGame(Game._mc.flaskAttach_mc);
		playingFlaskGame = true;
	}
	static function getWinText() {
		var _loc1 = "And so, with the RealityBendX Virus’s source destroyed, the Lava Zone quickly reverted back to normal and all the glitches disappeared. Brody and Stlunko, both completely cured, found their way back to Tampo, who was resting next to the good-as-ever SaargtScreen II. Stlunko quickly did some sort of radio frequency jam to ensure that the virus never comes back. Although the day is nearly over, Tampo is still determined to check that email soon enough. Expect more adventures soon!";
		return (_loc1);
	}
	static function getFinalScore() {
		var _loc2 = "Congratulations, you got "+GameState.score+" out of a possible "+GameState.maxScore+" points!\nPress 'ENTER' to restart.";
		return (_loc2);
	}
	static function setScanlines(frameLabel) {
		//		Game._mc.scanlines_mc.gotoAndStop(frameLabel);
	}
	static var STAGE_WIDTH = 550;
	static var playingFlaskGame = false;
}