class GameState {
	static var virusPart, nameEnter, dungeonName, blueberry, hardware, inv, key, inControl, puzzleMode, islandFlipped, showMessage, guardsBrod, magnetUsed, lavaIslandPull, guardsYell, guardsTalk, guardsRush, guardsLook, lairEnter, score, discussion, allowedToWarp, gameMode, continuing, virus, virusUpload, stlunkoRoom, triedSwitch, lookMicrowave, lookFriends, lookedNorth, brodyRoom, brodyStatus, maxScore, stlunkoStatus, caledraEntrance, stlunkoApart, stlunkoTalk, lookedLava, stlunkoInParty, bombPushed, compyState, invItems, clean, doorState, exitingRoom, congestion, yourbrainasplode, brodyApart, exitVirtual, brodySplode, talkSB, vectorSteps, headsetUsed, rested, talkPoorbt, gotHeadset, seenShortcut, jibney, bonusStage, seenGokulFeed, seenGokul, gokulExplode, seenSnake, talkFrotzer, talkGaspeau1, talkGaspeau2, firstTimeSpikes, death, brodyInParty, friendsChamber, dungeonLocation, dungeonDoorOpen; 
	//static var tiedWithRopes, takenDongrel, takenBone, takenBird, takenCorn, takenCoins, takenStein, givenStein, escapedMonk, trollKilled, askedBarkeep, takenBlood, bloodOnSelf, wallsJammed, woodsLost, wearingGlove, shoppeGuyAlterted, warpingOutOfDungeon, startingSeconds, spikeCounter, boilCountdown, woodsCounter, hag1answer, hag2answer, hag3answer, kigAttrib, kigAttrib2;
	function GameState() {
	}
	static function clear() {
		inv = new Object();		// What do you have on your brainy self?
		score = 0;				// What's your current score? (duh)
		maxScore = 50;			// What's the total amount of points you can get?
		seenGokul = false;		// Have you seen the Gokul in the microwave?
		gokulExplode = false;	// Have you exploded the poor Gokul?
		//seenSnake = false;	// Have you seen Saargtsson?
		talkFrotzer = false;	// Have you talked to that Frotzer yet?
		talkGaspeau1 = false;	// Have you talked to that Gaspeau yet?
		talkGaspeau2 = false;	// Have you talked to that Gaspeau once but not twice?
		firstTimeSpikes = true;	// Is this your first time in your personal chamber?
		death = undefined;		// Are you tempting fate by typing "die" or "quit"?
		friendsChamber = true;	// Have you left your chamber yet?
		seenShortcut = false;	// Do you know where the shortcut is?
		seenGokulFeed = false;	// Do you know where the Gokul Feeding Chamber is?
		jibney = false;			// Have you said "Jibney"?
		bonusStage = false;		// Have you said "Bonus Stage"?
		//invItems = 0;			// How many items do you have in your inventory?
		talkPoorbt = false;		// Have you talked to that Poorbt yet?
		gotHeadset = false;		// Have you obtaininated the headset yet?
		rested = false;			// Have you already had a rest?
		headsetUsed = false;	// Have you used the headset yet?
		vectorSteps = 0;		// What part of the vector battle are you up to?
		talkSB = false;			// Have you talked to Vector Strong Bad?
		exitVirtual = false;	// Did you just come out of Virtual Reality?
		yourbrainasplode = 0;	// How did you exit Virtual Reality?
		congestion = true;		// Is the congestion still there?
		exitingRoom = undefined;// What room did you just come out of?
		doorState = "hidden";	// What's the state of the lava lake shortcut door?
		clean = false;			// Has Brody cleaned up the Gokul?
		compyState = "off";		// Is the Saargtscreen on or what?
		caledraEntrance = 0;	// How many times have you entered the caledra?
		brodyStatus = "none";	// A daring new variable to simplify the Brody process.
		stlunkoStatus = "none";	// So daring, the comments aren't even questions!
		lookedNorth = false;	// Have you looked north from your personal chamber?
		brodyRoom = undefined;	// What room did you leave Brody in?
		lookFriends = false;	// Have you gone "look friends" yet?
		lookMicrowave = false;	// Have you looked at the microwave yet?
		triedSwitch = false;	// Have you attempted to open the door in the corridor?
		stlunkoRoom = undefined;// Where did you leave Stlunko?
		gameMode = "regular";	// Are we in regular, e-mail checking or virus game mode?
		virusUpload = 0;		// How much has the virus uploaded?
		allowedToWarp = true;	// Are you allowed to "continute to virus"?
		continuing = false;		// Did you just continute?
		discussion = false;		// Have you talked to Saargtsson yet?
		lairEnter = false;		// Have you gone to the entrance of Saargtsson's chamber?
		guardsTalk = false;		// Have you talked to Saargtsson's guards?
		guardsRush = false;		// Have you attempted to rush into Saargtsson's chamber?
		guardsLook = false;		// Are you aware that Saargtsson's guards can hurt you?
		guardsYell = false;		// Have you tried to get Saargtsson's attention?
		guardsBrod = false;		// Has Brody tried to rush into Saargtsson's chamber?
		lavaIslandPull = false;	// Has Stlunko attempted to flip the island in the Caldera?		
		islandFlipped = false;	// Is the entrance to the Secret Lab open?
		//showMessage = true;	// Should the virus upload status message be shown?
		magnetUsed = false;		// Have you zapped the secret lab electromagnet?
		hardware = false;		// Do you has the anti-viral hardware?
		puzzleMode = false;		// Are you in the puzzle-solving mode?
		inControl = "tampo";	// Who are you currently controlling?
		key = false;			// Do you has the key from Tampo's prison?
		blueberry = false;		// Are the blueberries under your command?
		nameEnter = true;		// Will the next command entered be your name?
		dungeonName = undefined;// What is thou dungeon name?
	}
	static function getInvString() {
		var _loc1 = "";
		GameState.invItems = 0;
		if (GameState.gokulExplode && !GameState.puzzleMode) {
			_loc1 = _loc1+"heat-resistant Gokul armor, ";
			//GameState.invItems += 1;
		}
		if (GameState.gotHeadset && !GameState.headsetUsed) {
			_loc1 = _loc1+"a virtual reality headset, ";
			//GameState.invItems += 1;
		}
		if (GameState.hardware) {
			_loc1 = _loc1+"anti-viral hardware, ";
		}
		if (GameState.key) {
			_loc1 = _loc1+"a filthy key, ";
		}
		if (GameState.blueberry) {
			_loc1 = _loc1+"an army of blueberries, ";
		}
		if (_loc1 == "") {
			_loc1 = "You\'re a brain. What exactly do you suppose you\'d have?";
		} else {
			_loc1 = "You have "+_loc1;
			var _loc2 = Math.floor(Math.random()*4);
			switch (_loc2) {
			case 0 :
				_loc1 = _loc1+"and an imaginary inner Homsar.";
				break;
			case 1 :
				_loc1 = _loc1+"and your usual pink blobbiness.";
				break;
			case 2 :
				_loc1 = _loc1+"and still no lungs.";
				break;
			case 3 :
				_loc1 = _loc1+"and a Super Sam-esque hatred of Bonus Stage.";
				break;
			/* case 4 :
				if (GameState.invItems == 1) {
					_loc1 = _loc1+"and it is asking for a challenge.";
				} else {
					_loc1 = _loc1+"and they are asking for a challenge.";
				} */
			}
			
		}
		//trace("GameState.getInvString "+_loc1);
		return (_loc1);
	}
	static function traceVal() {
		//trace("GameState::traceVal()------------");
		for (var _loc1 in eval(GameState)) {
			//trace("traceVal ,"+_loc1+","+GameState[_loc1]);
		}
	}
	static function getAllObjects() {
		var _loc1 = new Object();
		for (var _loc2 in eval(GameState)) {
			_loc1[_loc2] = GameState[_loc2];
		}
		return (_loc1);
	}
}
/*
Possible brodyStatus values:
 none:		hasn't been interacted with yet
 exploded:	asploded out of the simulation
 party:		in your party and with you
 away:		in your party, but not with you

Possible stlunkoStatus values:
 none:		hasn't been interacted with yet
 talked:	talked to once, asked to get bomb
 bomb:		has the bomb
 party:		in your party and with you
 away:		in your party, but not with you
 
Possible compyState values:
 off:		turned off
 untried:	turned on, haven't tried to check email yet
 tried:		turned on, email checking has been attempted
 
Possible doorState values:
 hidden:	cave-in is blocking door
 closed:	cave-in is gone, but door is closed
 open:		cave-in is gone and door is open
 
Possible gameMode values:
 regular:	standard game; what the majority of the game is
 email:		finally ready to check email
 virus:		virus is uploading and will soon destroy everything
 puzzle:	currently figuring out the puzzles
*/