class Room_center_west extends Room {
	var synonyms, put, superClassParse, firstTime, attack, pressEnterCallbackFunc;
	function Room_center_west() {
		super();
		synonyms.push(new Array("north", "private chamber"));
		synonyms.push(new Array("frotzer", "frotzers", "gaspeau", "gaspeaus", "poorbt", "poorbts"));
		synonyms.push(new Array("gokul", "gokuls"));
		//synonyms.push(new Array("gaspeau", "gaspeaus"));
		//synonyms.push(new Array("poorbt", "poorbts"));
		synonyms.push(new Array("pink cham cham", "cham cham", "cham", "coconut"));
		//synonyms.push(new Array("minions", "minion", "underling"));
		synonyms.push(new Array("rooms", "caverns", "cavern", "passageways", "passageway", "corridors", "corridor", "caves", "cave"));
		synonyms.push(new Array("northeast", "north-east", "north east", "shortcut", "short-cut", "short cut", "shortest of cuts"));
		synonyms.push(new Array("southish", "south-ish"));
		synonyms.push(new Array("personal chamber", "saargtsson\'s chamber", "saargtsson\'s throneroom", "saargtsson\'s lair"));
	}
	function getName() {
		return ("Lava Zone Center (West)");
	}
	function parse() {
		var _loc2 = Game.tp;
		if ((_loc2.isGo("east")) && (!_loc2.contains("north"))) {
			if (GameState.congestion) {
				this.put("A minion CONGESTION is blocking your path that way; you can't get past it.");
			} else {
				Game.newRoom("center_east");
			}
			return;
		}
		if ((_loc2.isStart("go")) && (_loc2.isEnd("east")) && (!_loc2.contains("north"))) {
			if (GameState.congestion) {
				this.put("The main artery to the east is clogged by a large CONGESTION of minions. If you want to get through it, you\'ll have to clear them out somehow. There are other unclogged eastern paths, but they don\'t lead anywhere important. Forget about \'em.");
			} else {
				Game.newRoom("center_east");
			}
			return;
		}
		if ((_loc2.isStart("look")) && (_loc2.isEnd("east")) && (!_loc2.contains("north"))) {
			this.put("There are quite a few paths spreading out in that direction.");
			if (GameState.congestion) {
				this.put("One of the more cramped ones is full of a crowd of MINIONS making a large CONGESTION in the tunnel.");
			} else {
				if (GameState.gameMode == "regular") {
					this.put("One of the main ones has a few minions dispersing from it. There are two broken lasers on the ground.");
				} else {
					this.put("Oddly enough, all of them appear to be void of minions.");
				}
			}
			return;
		}
		if (_loc2.isGo("west")) {
			Game.newRoom("crossroads");
		}
		if (_loc2.isLookAt("west")) {
			this.put("There\'s only one westward path, and it\'ll take you away from all the excitement and crowds of the center of this underground city. Well, away from most of it.");
			return;
		}
		if (_loc2.isLookAt("north")) {
			this.put("There are quite a few paths spreading out in that direction. You can\'t see anything noteworthy, though.");
			return;
		}
		if (_loc2.isLookAt("south")) {
			this.put("There are quite a few paths spread out in that direction, including the one to the GOKUL FEEDING CHAMBER. That's always an interesting place to visit.");
			GameState.seenGokulFeed = true;
			return;
		}
		if ((_loc2.isGo("south")) || (_loc2.isGo("north"))) {
			this.put("There are too many choices in those directions. You\'ll have to GO TO a more specific room.");
			return;
		}
		if (_loc2.isLookAt("lava")) {
			this.put("It flows through the walls... flowing omninously... flowing... just waiting to spill out and kill you in some sort of agonizing way.");
			return;
		}
		if ((_loc2.isLookAt("minions")) || (_loc2.isLookAt("frotzer"))) {
			if (GameState.gameMode == "regular") {
				this.put("All three types of mobile minions are scurrying about; this is a very busy place.");
				if (GameState.congestion) {
					this.put("A lot of them seem to be making a CONGESTION in a certain corridor, but you can\'t tell what it\'s about from here.");
				}
			} else {
				this.put("There aren't any here...");
			}
			return;
		}
		if ((_loc2.isStart("talk")) && ((_loc2.isEnd("minions")) || (_loc2.isEnd("frotzer")))) {
			if (GameState.gameMode == "regular") {
				this.put("The minions that are running around on errands are a bit too busy and numerous for you to get their attention long enough to ask a question. You better go back WEST to those calmer minion passageways if you have anything to ask them.");
			} else {
				this.put("There aren't any here...");
			}
			return;
		}
		if ((_loc2.isTake("minions")) || (_loc2.isTake("poorbt")) || (_loc2.isTake("gaspeau")) || (_loc2.isTake("frotzer"))) {
			if (GameState.gameMode == "regular") {
				this.put("They\'re almost too busy to stop and chat with you. There\'s no way they\'ll join your party, or guild, or whatever you want to call it.");
			} else {
				this.put("There aren't any here...");
			}
			return;
		}
		if (((_loc2.isStart("shoot")) || (_loc2.isStart("kill"))) && ((_loc2.isEnd("minions")) || (_loc2.isEnd("poorbt")) || (_loc2.isEnd("gaspeau")) || (_loc2.isEnd("frotzer")))) {
			if (GameState.gameMode == "regular") {
				if (attack == undefined) {
					this.put("That\'s a bad idea. They\'re strong in numbers and will fight to kill if you purposely hurt them. You should probably try zapping things with less fatal consequences.");
					attack = true;
				} else {
					this.put("Alright, fine. You shoot a lowly minion anyway. Oh look, now they\'re all jumping on you for betrayal and stuff. Hey, is that your hypothalamus being flung over there? Ouch. You're almost definitely dead now.");
					Game.die();
				}
			} else {
				this.put("There aren't any here...");
			}
			return;
		}
		if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
			this.put("There isn\'t any lava pool to sit in here. If you want to BURN and DIE so badly, try somewhere else.");
			return;
		}
		if (_loc2.isLookAt("caves")) {
			this.put("Ahead of you is a winding maze of these cavers. Fortunately you\'ve been living here long enough to know where almost everything is.");
			return;
		}
		if /*(*/ (_loc2.isGo("caves")) {
			/* || ((_loc2.isStart("head to")) && (_loc2.isEnd("caves")))) */
			this.put("Uh... you\'ll have to be a bit more specific than that.");
			return;
		}
		if (_loc2.isGo("congestion")) {
			if (GameState.congestion) {
				this.put("You go up to the congestion of minions. The ground and air are so full of minions, there\'s no way you can get through to see what its about. And unless you can get more intimidating, they aren\'t moving out of your way.");
			} else {
				this.put("There\'s no congestion here anymore.");
			}
			return;
		}
		if (_loc2.isLookAt("congestion")) {
			if (GameState.congestion) {
				this.put("All three types of mobile minions are crowding around something, and you can\'t get through to see what it is. If only you could ask the congestion what it's all about...");
			} else {
				this.put("There\'s no congestion here anymore.");
			}
			return;
		}
		if (((_loc2.isStart("talk")) || (_loc2.isStart("ask"))) && (_loc2.isEnd("congestion"))) {
			if (GameState.congestion) {
				this.put("You ask some questions to the minions causing the congestion. A Frotzer actually stops to tell you that they're all trying to see a PINK CHAM CHAM that was just discovered. This is the only known specimen of a species once thought extinct: green laser-shooting blob-shaped minions that taste like delicious coconut. This is certainly a great day for the Lava Zone.");
			} else {
				this.put("There\'s no congestion here anymore.");
			}
			return;
		}
		if (_loc2.is("go")) {
			this.put("You fire a weak laserball harmlessly at a wall to get rid of the electrical charge building up inside of you. Ahhhhh... sweet relief.");
			this.put("\n\nYeah, uh, you should probably point out a location to go to if you want to visit anywhere.");
			return;
		}
		if (_loc2.isEnd("cham cham")) {
			if (GameState.congestion) {
				if (_loc2.isStart("eat")) {
					this.put("You can\'t get to it through the crowds, and you couldn\'t eat the tasty creature even if you could reach it. Floating brain, remember? If only you had a FRIEND to share it with. Or... steal it with.");
				} else {
					this.put("You can\'t even get close to it with this CONGESTION of minions in the way.");
				}
			} else {
				this.put("Brody ate it. It\'s gone to shreds.");
			}
			return;
		}
		if (_loc2.isLookAt("shortcut")) {
			if (!GameState.seenShortcut) {
				this.put("Shortcut? What shortcut?");
			} else {
				if (GameState.gameMode == "regular") {
					this.put("Ah yes, the trusty shortcut. It\'ll take you around all those busy main roads. It\'s precisely NORTHEAST of here.");
				} else {
					this.put("Ah yes, the trusty shortcut. It'll take you around all those now not-so-busy main roads. It\'s precisely NORTHEAST of here.");
				}
				return;
			}
		}
		if (((_loc2.isStart("go")) && (_loc2.isEnd("northeast"))) || (((_loc2.isStart("take")) || (_loc2.isStart("go")) || (_loc2.isStart("use"))) && (_loc2.isEnd("shortcut")))) {
			if (!GameState.seenShortcut) {
				this.put("Shortcut? What shortcut?");
			} else {
				GameState.exitingRoom = "center_west";
				Game.newRoom("shortcut");
			}
			return;
		}
		if ((_loc2.contains("gokul")) && (!_loc2.contains("gokul feed"))) {
			this.put("There appears to be none here. >_>");
			return;
		}
		if (_loc2.isLookAt("south-ish")) {
			this.put("Hmm... that\'s the way to the infamous Gokul Feeding Chamber.");
			GameState.seenGokulFeed = true;
			return;
		}
		if ((_loc2.isTake("minions")) || (_loc2.isTake("poorbt"))) {
			if (GameState.gameMode == "regular") {
				this.put("They\'re almost too busy to stop and chat with you. There\'s no way they\'ll join your party, or guild, or whatever you want to call it.");
			} else {
				this.put("There aren't any here...");
			}
			return;
		}
		if (((_loc2.isStart("shoot")) || (_loc2.isStart("kill"))) && ((_loc2.isEnd("minions")) || (_loc2.isEnd("poorbt")) || (_loc2.isEnd("gaspeau")) || (_loc2.isEnd("frotzer")))) {
			if (GameState.gameMode == "regular") {
				if (attack == undefined) {
					this.put("That\'s a bad idea. They\'re strong in numbers and will fight to kill if you purposely hurt them. You should probably try zapping things with less fatal consequences.");
					attack = true;
				} else {
					this.put("Alright, fine. You shoot a lowly minion anyway. Oh look, now they\'re all jumping on you for betrayal and stuff. Hey, is that your hypothalamus being flung over there? Ouch. You're almost definitely dead now.");
					Game.die();
				}
			} else {
				this.put("There aren't any here...");
			}
			return;
		}
		if (_loc2.isGo("personal chamber")) {
			this.put("That place would be back WEST, not here.");
			return;
		}
		if (((_loc2.isStart("go")) || (_loc2.isStart("look"))) && (_loc2.contains("simulator"))) {
			if (!GameState.talkFrotzer) {
				this.put("Why would you want to go there? Stop trying to play and get back to the task at hand.");
			} else {
				this.put("Hmm... you remember seeing the new simulation room earlier... now where was it? Ah, yes. Crap. It\'s right across the CONGESTION of minions to the EAST. What a coincidence!! Fortunately you know of a little SHORTCUT to the NORTHEAST that you can try taking. It'll go around the crowd and take you right where you want to be.");
				GameState.seenShortcut = true;
			}
			return;
		}
		if ((_loc2.isStart("go")) && (_loc2.contains("gokul feed"))) {
			if (!GameState.seenGokulFeed) {
				this.put("You can\'t remember where that is. Perhaps you should LOOK for it?");
			} else {
				Game.newRoom("gokul");
			}
			return;
		}
		if (_loc2.isGo("southish")) {
			if (!GameState.seenGokulFeed) {
				this.put("You don\'t even know what\'s down there. Perhaps you should LOOK down there first?");
			} else {
				Game.newRoom("gokul");
			}
			return;
		}
		if ((_loc2.isStart("look")) && (_loc2.contains("gokul feed"))) {
			this.put("Ah yes, the famed Gokul Feeding Chamber. If you want to get there, the entrance is SOUTH-ISH of your current location.");
			GameState.seenGokulFeed = true;
			return;
		}
		if ((_loc2.isStart("go")) && (!_loc2.is("go"))) {
			this.put("You ain\'t going there, mister. Try somewhere else.");
			return;
		}
		if (_loc2.isLookAt("southish")) {
			this.put("Ah, now you remember. The famed Gokul Feeding Chamber is down this SOUTH-ISH path.");
			GameState.seenGokulFeed = true;
			return;
		}
		//trace("Room_center_west parse");
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.gameMode == "regular") {
				this.put("You enter the western side of what is known as the Lava Zone's center.");
				if (GameState.congestion) {
					this.put("Most of the MINIONS live their lives here and are always squirming about, but right now there seems to be a large CONGESTION of them in a nearby path.");
				} else {
					this.put("There were a bunch of MINIONS here before, but they seem to have dispersed for the most part.");
				}
				this.put("There are so many different rooms and caverns here that you could wander around them for days unless you know specifically where to GO. The minion-filled passageway that you\'re very familiar with lies back to the WEST.");
			} else {
				this.put("You enter the western side of what is known as the Lava Zone's center. There used to be a bunch of MINIONS around here, but they're all gone. The rather empty passageway that you\'re very familiar with lies back to the WEST, your shortcut to the NORTHEAST, and the Gokul Feeding Chamber is SOUTH-ISH.");
			}
			if ((GameState.brodyStatus == "away") && (GameState.brodyRoom == "center_east")) {
				if (GameState.congestion) {
					this.put("\n\nBrody appears to be stuck on the other side of the congestion.");
				} else {
					if (GameState.stlunkoRoom != "center_east") {
						this.put("\n\nBrody spots you from the other side of the cavern and walks up to you. He rejoins your party.");
					} else {
						this.put("\n\nBrody and Stlunko spot you from the other side of the cavern and come up to you. They rejoin your party.");
						GameState.stlunkoStatus = "party";
						GameState.stlunkoRoom = undefined;
					}
					GameState.brodyStatus = "party";
					GameState.brodyRoom = undefined;
				}
				GameState.exitingRoom = undefined;
			} else if ((GameState.brodyStatus == "away") && (GameState.brodyRoom == "center_west")) {
				if (GameState.stlunkoRoom != "center_west") {
					this.put("\n\nBrody walks up to you and rejoins your party.");
				} else {
					this.put("\n\nBrody and Stlunko come up to you and rejoin your party.");
					GameState.stlunkoStatus = "party";
					GameState.stlunkoRoom = undefined;
				}
				GameState.brodyStatus = "party";
				GameState.exitingRoom = undefined;
				GameState.brodyRoom = undefined;
			}
			firstTime = false;
		} else {
			if (GameState.gameMode == "regular") {
				this.put("You are floating in the western side of what is known as the Lava Zone's center.");
				if (GameState.congestion) {
					this.put("There are several types of MINIONS scurrying about, and there is a large CONGESTION of them in a nearby path.");
				} else {
					this.put("There are several types of MINIONS scurrying about.");
				}
				this.put("There are lots of different ROOMS and CAVERNS that lead in all directions, and you could easily wander around in them for days if you don't know exactly where to GO. The minion-filled passageway you frequently pass through is back WEST.");
			} else {
				this.put("You are floating in the western half of the Lava Zone's center, now lacking in any minions. The passageway is back WEST, while your shortcut is to the NORTHEAST and the Gokul Feeding Chamber is SOUTH.");
			}
		}
		return;
	}
}
