class Room_center_east extends Room {
	var synonyms, put, superClassParse, firstTime, attack, pressEnterCallbackFunc;
	function Room_center_east() {
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
		synonyms.push(new Array("personal chamber", "saargtsson\'s chamber", "saargtsson\'s throneroom", "saargtsson\'s lair", "gokul feed", "gokul feeding chamber", "feeding chamber"));
	}
	function getName() {
		return ("Lava Zone Center (East)");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("east")) {
			this.put("Due east is that Simulation Room, where hours of illegal entertainment and training await!");
			return;
		}
		if ((_loc2.isGo("east")) || ((_loc2.isStart("go")) && (_loc2.contains("simulator")))) {
			Game.newRoom("simulate");
		}
 		if ((_loc2.isGo("west")) && (!_loc2.contains("north"))) {
			if (GameState.congestion) {
				if (GameState.brodyStatus != "party") {
					this.put("A minion CONGESTION is blocking your path that way; you can't get past it.");
				} else {
					this.put("A minion CONGESTION is blocking your path that way; you\'ll have to get rid of it somehow.");
				}
			} else {
				Game.newRoom("center_west");
			}
			return;
		}
		if ((_loc2.isLookAt("west")) && (!_loc2.contains("north"))) {
			if(GameState.congestion) {
				this.put("There\'s really only one important parth in that direction. Unfortunately it is clogged with a CONGESTION of minions blocking your passage back to the Minion Passageway and other rooms nearby that.");
			} else {
				this.put("There\'s really only one important parth in that direction, and it leads back to the Minion Passageway and other rooms near that.");
			}
			return;
		}
		if ((_loc2.isLookAt("south")) || (_loc2.isLookAt("north"))) {
			this.put("There are quite a few paths spreading out in that direction. You can\'t see anything noteworthy, though.");
			return;
		}
		if ((_loc2.isGo("south")) || (_loc2.isGo("north"))) {
			this.put("There are too many choices in those directions. You\'ll have to GO TO a more specific room.");
			return;
		}
		if ((_loc2.isLookAt("minions")) || (_loc2.isLookAt("frotzer"))) {
			if (GameState.congestion) {
				this.put("All three types of mobile minions are scurrying about; this is a very busy place. A lot of them seem to be making a CONGESTION in a certain corridor, but you can\'t tell what it\'s about from here.");
			} else {
				if (GameState.gameMode == "regular") {
					this.put("They\'re just scurrying around harmlessly now.");
				} else {
					this.put("They seem to have all disappeared.");
				}
			}
			return;
		}
		if ((_loc2.isStart("talk")) && ((_loc2.isEnd("minions")) || (_loc2.isEnd("frotzer")))) {
			if (GameState.gameMode == "regular") {
				this.put("The minions that are running around on errands are a bit too busy and numerous for you to get their attention long enough to ask a question. You better go back WEST to those calmer minion passageways if you have anything to ask them.");
			} else {
				this.put("They seem to have all disappeared.");
			}
			return;
		}
		if ((_loc2.isTake("minions")) || (_loc2.isTake("poorbt")) || (_loc2.isTake("gaspeau")) || (_loc2.isTake("frotzer"))) {
			if (GameState.gameMode == "regular") {
				this.put("They\'re almost too busy to stop and chat with you. There\'s no way they\'ll join your party, or guild, or whatever you want to call it.");
			} else {
				this.put("They seem to have all disappeared.");
			}
			return;
		}
		if (_loc2.isLookAt("caves")) {
			this.put("Ahead of you is a winding maze of these cavers. Fortunately you\'ve been living here long enough to know where almost everything is.");
			return;
		}
		if /*(*/(_loc2.isGo("caves")) /* || ((_loc2.isStart("head to")) && (_loc2.isEnd("caves")))) */ {
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
		if ((_loc2.isEnd("cham cham")) && (!_loc2.contains("brody"))) {
			if (GameState.congestion) {
				if (_loc2.isLookAt("cham cham")) {
					this.put("It\'s green with two mechanical laser guns sticking out of the side. Right now it seems to just be sitting there, overwhelmed. They were thought to have been extinct, and you hear they taste like delicious rolled coconut.");
				} else if (_loc2.isTalk("cham cham")) {
					this.put("It\'s like a Gokul. Hardly a good conversationalist.");
				} else if (_loc2.isTake("cham cham")) {
					this.put("If you somehow grabbed it, you\'ll be mobbed with a ton of minions following it around everywhere. So let\'s not do that.");
				} else if (_loc2.isShoot("cham cham")) {
					this.put("You manage to get a big enough clearing to fire a laser ball at the Pink Cham Cham. Whatever you expected that to do didn\'t happen, as it just happily absorbed the energy and fired out two volleys of laser beams harmlessly at the roof.");
				} else if ((_loc2.isStart("eat")) && (_loc2.isEnd("cham cham"))) {
					if (GameState.brodyStatus == "party") {
						this.put("You and your floating pink brain-ness can't eat the tasty morsel creating this congestion. If only you could HAVE SOMEONE ELSE EAT it. Someone with a mouth. And digestive system.");
					} else {
						this.put("You can\'t get to it through the crowds, and you couldn\'t eat the tasty creature even if you could reach it. Floating brain, remember? If only you had a FRIEND to share it with. Or... steal it with.");
					}
				} else {
					this.put("You can\'t even get close to it with this CONGESTION of minions in the way.");
				}
			} else {
				this.put("Sorry, but the Pink Cham Cham is now resting somewhere in Brody\'s stummy. You can\'t do anything with it anymore.");
			}
			return;
		}
		if (_loc2.isLookAt("shortcut")) {
			if(!GameState.seenShortcut) {
				this.put("Shortcut? What shortcut?");
			} else if (GameState.congestion) {
				this.put("Your trusty shortcut will get you right past all those pesky crowds. It's NORTHWEST of here, yo.");
			} else {
				this.put("Your shortcut is NORTHWEST of here, but you don\'t really need it anymore.");
			}
			return;
		}
		if ((_loc2.isGoNS("northwest")) || (((_loc2.isStart("take")) || (_loc2.isStart("go")) || (_loc2.isStart("use"))) && (_loc2.isEnd("shortcut")))) {
			if(!GameState.seenShortcut) {
				this.put("Shortcut? What shortcut?");
			} else {
				GameState.exitingRoom = "center_east";
				Game.newRoom("shortcut");
			}
			return;
		}
		if ((_loc2.contains("gokul")) && (!_loc2.contains("gokul feed"))) {
			this.put("There appears to be none here. >_>");
			return;
		}
		if ((_loc2.isGo("personal chamber")) || (_loc2.isLookAt("personal chamber"))) {
			if(GameState.congestion) {
				this.put("That place would be back WEST, not here.");
			} else {
				this.put("You need to go a bit more to the WEST to get closer. It should be easy now with no congestion in the way.");
			}
			return;
		}
		if /*(*/((_loc2.isStart("go")) /*|| (_loc2.isStart("look")))*/ && (_loc2.contains("simulator"))) {
			if(!GameState.talkFrotzer) {
				this.put("Why would you want to go there? Stop trying to play and get back to the task at hand.");
			} else {
				Game.newRoom("simulate");
			}
			return;
		}
		if (((_loc2.isStart("go")) || (_loc2.isStart("look"))) && ((_loc2.contains("gokul feed")) || (_loc2.contains("southish")) || (_loc2.contains("feeding chamber")))) {
			if (GameState.congestion) {
				this.put("You can\'t get to it... its entrance is past the CONGESTION of minions to the WEST. You\'ll have to get around it first.");
			} else {
				this.put("You can't get to it from here; you'll have to move a little bit to the WEST.");
			}
			return;
		}
		if (_loc2.isLookAt("lava")) {
			this.put("It flows through the walls... flowing omninously... flowing... just waiting to spill out and kill you in some sort of agonizing way.");
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
				this.put("They seem to have all disappeared.");
			}
			return;
		}
		if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
			this.put("There isn\'t any lava pool to sit in here. If you want to BURN and DIE so badly, try somewhere else.");
			return;
		}
		if ((_loc2.isStart("go")) && (!_loc2.is("go"))) {
			this.put("You ain\'t going there, mister. Try somewhere else.");
			return;
		}
		if ( ((_loc2.isStart("have")) || (_loc2.isStart("make")) || (_loc2.isStart("tell"))) && ((_loc2.contains("brody")) && (!_loc2.isStart("brody")) && (!_loc2.isEnd("brody"))) && (_loc2.isEnd("cham cham"))) {
			if (GameState.brodyStatus != "party") {
				this.put("Too bad you aren\'t Brody. You\'ll have to get him with you first.");
			} else {
				if (GameState.congestion) {
					this.put("Before any of the minions know what\'s happening, Brody, on your cue, dives his head down and eats the Pink Cham Cham. \"Mmm... good.\" he says as he chews the coconut-tasting blob. All the minions gasp and look on in horror or surprise. Suddenly a crunching sound is heard as Brody makes a face. He spits out some broken laser beam parts onto the floor. The green stuff is all gone though.");
					pressEnterCallbackFunc = postBrodyEatChamCham;
					Game.addPause();
				} else {
					this.put("He already ate it. He\'s full.");
				}
			}
			return;
		}
		/*if (_loc2.is("info")) {
			this.put("Note to Joshua - everything I included is exactly as you gave me. That includes the fact that look west/look east are switched around, so you\'ll have to tell me which one is correct. I also included most of the other things from the other lava zone center part, so if you want anything else added/removed/changed, let me know. (And yes, this message will be removed by next version, foo.) Have fun looking for non-consensual easter eggs. There are still some you haven't found! (One is room-specific, one isn\'t.)");
			return;
		}*/
		// END OTHER COMMANDS.
		//trace("Room_center_east parse");
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function postBrodyEatChamCham() {
		this.put("The crowds see that the Pink Cham Cham is gone. It takes a while to sink in though. But soon, the disappointed crowds disperse, and the congestion is gone. Congratulations! The way back WEST is clear for both of you to go through now! And Brody did get a free meal...");
		GameState.congestion = false;
		Game.scorePoints(2);
		return;
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.gameMode == "regular") {
				if (GameState.congestion) {
					this.put("You float into the eastern side of the Lava Zone\'s center. A lot of various unimportant MINIONS are busy walking and floating around all over the place. Currently there seems to be a large CONGESTION of them in a nearby path to the WEST, blocking your normal way out to the Minion Passageway. The Simulation Room still lies due EAST. Your trusty shortcut is NORTHWEST.");
				} else {
					if (GameState.brodyStatus == "none") {
						this.put("You float into the eastern side of the Lava Zone\'s center. A lot of various unimportant MINIONS are busy walking and floating around all over the place. The path to the Minion Passageway to the WEST is clear, with a few minions idly standing around. The Simulation Room that you want to visit lies due EAST nearby. Your trusty shortcut is back NORTHWEST.");
					} else {
						this.put("You float into the eastern side of the Lava Zone\'s center. A lot of various unimportant MINIONS are busy walking and floating around all over the place. The path to the Minion Passageway to the WEST is clear, with a few minions idly standing around. The Simulation Room lies due EAST. Your trusty shortcut is back NORTHWEST.");
					}
				}
			} else {
				this.put("You float into the eastern side of the Lava Zone's center. Like all other places in the Lava Zone, there are suspiciously no MINIONS around. The path to the Minion Passageway to the WEST is clear, with a few minions idly standing around. The Simulation Room is EAST, and your shortcut is NORTHWEST.");
			}
			if ((GameState.exitingRoom == "shortcut") && (GameState.brodyRoom == "center_east")) {
				if (GameState.stlunkoRoom != "center_east") {
					this.put("\n\nBrody walks up to you and rejoins your party.");
				} else {
					this.put("\n\nBrody and Stlunko come up to you and rejoin your party.");
					GameState.stlunkoStatus = "party";
					GameState.stlunkoRoom = undefined;
				}
				GameState.brodyStatus = "party";
				GameState.exitingRoom = undefined;
				GameState.brodyRoom = undefined;
			} else if ((GameState.exitingRoom == "shortcut") && (GameState.brodyRoom == "center_west")) {
				if (GameState.stlunkoRoom != "center_west") {
					this.put("\n\nBrody spots you from the other side of the cavern and walks up to you. He rejoins your party.");
				} else {
					this.put("\n\nBrody and Stlunko spot you from the other side of the cavern and come up to you. They rejoin your party.");
					GameState.stlunkoStatus = "party";
					GameState.stlunkoRoom = undefined;
				}
				GameState.brodyStatus = "party";
				GameState.exitingRoom = undefined;
				GameState.brodyRoom = undefined;
			}
			firstTime = false;
		} else {
			if (GameState.brodyStatus != "party") {
				this.put("You are in the eastern side of the Lava Zone\'s center. A big CONGESTION of minions is clogging a nearby path to the WEST. The Simulation Room that you want to visit lies due EAST nearby, and the path to it is clear. Your shortcut around the crowds is NORTHWEST.");
			} else if (GameState.congestion) {
				this.put("You are in the eastern side of the Lava Zone\'s center. A big CONGESTION of minions is clogging a nearby path to the WEST, and BRODY is approaching it, curious. The Simulation Room lies due EAST nearby, and your shortcut around the crowds is NORTHWEST. Unfortunately Brody won\'t be able to fit in it.");
			} else {
				this.put("You are in the eastern side of the Lava Zone\'s center. The Simulation Room is EAST, and your currently obsolete shortcut is NORTHWEST. The path WEST to the more familiar territory is clear enough to easily go through. Brody is standing next to you.");
			}
		}
		return;
	}
}
