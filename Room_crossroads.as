class Room_crossroads extends Room {
	var synonyms, put, superClassParse, firstTime, attack, pressEnterCallbackFunc;
	function Room_crossroads() {
		super();
		synonyms.push(new Array("north", "private chamber"));
		synonyms.push(new Array("south", "throne", "troneroom", "private throneroom"));
		synonyms.push(new Array("west", "path", "empty path"));
		synonyms.push(new Array("frotzer", "frotzers"));
		synonyms.push(new Array("gokul", "gokuls"));
		synonyms.push(new Array("gaspeau", "gaspeaus"));
		synonyms.push(new Array("poorbt", "poorbts"));
		synonyms.push(new Array("minions", "minion", "underling"));
	}
	function getName() {
		return ("Minion Passageway");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("east")) {
			this.put("To the east is the heart of the Lava Zone, a winding maze of paths where all the cool locations like the famed GOKUL FEEDING CHAMBER are found. You gotta love overfeeding those Gokuls.");
			return;
		}
		if (_loc2.isLookAt("lava")) {
			this.put("It flows through the walls... flowing omninously... flowing... just waiting to spill out and kill you in some sort of agonizing way.");
			return;
		}
		if (_loc2.isGo("north")) {
			GameState.exitingRoom = "minion_passageway";
			Game.newRoom("spikes");
		}
		if (_loc2.isLookAt("north")) {
			this.put("Northward lies the entrance to your private chamber. It\'s actually not that bad of a place compared to the cramped living quarters of most of these minions.");
			return;
		}
		if (_loc2.isGo("south")) {
			Game.newRoom("snake");
		}
		if (_loc2.isLookAt("south")) {
			this.put("That path leads to Saargtsson\'s private throneroom. You don\'t want to go there without a good reason, unless you want to be working all night long.");
			return;
		}
		if (_loc2.isLookAt("west")) {
			this.put("Hmm... this path seems pretty empty. You can\'t recall really exploring it much either. How suspicious.");
			return;
		}
		if (GameState.gameMode == "regular") {
			if (_loc2.isGo("west")) {
				Game.newRoom("corridor_south");
			}
			if (_loc2.isGo("east")) {
				Game.newRoom("center_west");
			}
			if (_loc2.isLookAt("minions")) {
				this.put("There are quite a few bubbly GASPEAUS, friendly FROTZERS and hardworking POORBTS scurrying about, doing who-knows-what. No matter what Saargtsson says, you know you are not equal to these dispensable insectoids and... minionoids. They get around a lot though, so they could be helpful in gaining information. Maybe you should try talking to some of them.");
				return;
			}
			if ((_loc2.isStart("talk")) && (_loc2.isEnd("minions"))) {
				this.put("Eh... they scurry around to much for you to get all their attention. Maybe you should focus in on a single group.");
				return;
			}
			if (_loc2.isLookAt("frotzers")) {
				this.put("These red floaters fly around doing small old jobs with the heat energy they can create and store. They are somewhat intelligent and have a full vocabulary, and tend to be friendly and social. At least, that\'s what Stlunko had told you. You\'ve never really studied them yourself.");
				return;
			}
			if (_loc2.isLookAt("gaspeaus")) {
				this.put("These bubbly blue guys can control moderate cold powers, which can occasionally prove handy in such a heat-based world. But they are a bit too playful for their own good. They can speak rather fluent English though, if you can somehow get them to take you seriously.");
				return;
			}
			if (_loc2.isLookAt("poorbts")) {
				this.put("Poorbts... Hardworking little humanoids who have screens for heads. They're very loyal and determined and stuff. Plus they have hands. That makes them special!");
				return;
			}
			if ((_loc2.isStart("talk")) && (_loc2.isEnd("poorbts"))) {
				if ((GameState.stlunkoStatus == "party") && (GameState.brodyStatus == "party")) {
					this.put("You have nothing more to ask them.");
				} else {
					if (GameState.brodyStatus != "party") {
						this.put("You try to get their attention, but they're much too into their jobs to stop to chat with a mere fellow minion like you.");
					} else {
						this.put("You ask them about Stlunko, but they completely ignore you. Brody stomps the ground once to get their attention, and it works. One of them steps forth and tells you that he saw Stlunko going down the WEST corridor earlier today and hasn\'t seen him since. So mysterious!");
					}
				}
				return;
			}
			if (_loc2.contains("gokul")) {
				this.put("There appears to be none here. >_>");
				return;
			}
			if ((_loc2.isStart("talk")) && (_loc2.isEnd("frotzers"))) {
				if ((GameState.stlunkoStatus == "party") && (GameState.brodyStatus == "party")) {
					this.put("You have nothing more to ask them.");
				} else {
					if (!GameState.talkFrotzer) {
						this.put("You stop a small group of Frotzers and ask them if they\'ve seen Brody or Stlunko about. They all look at each other and reply that they hadn\'t, until one of them pipes up and says he saw Brody enter the SIMULATION ROOM they had recently bootlegged and installed. \"Saargtsson made us do it! Please don\'t tell the cops!\" he yells as the group continues on its way.");
						Game.scorePoints(1);
						GameState.talkFrotzer = true;
					} else if (GameState.brodyStatus != "party") {
						this.put("You learned that Brody is in the new SIMULATION ROOM. You don't need to bug these guys anymore.");
					} else {
						this.put("You ask them about Stlunko, but none of them remember seeing him today. Oh, well. Maybe you should try asking another minion type.");
					}
				}
				return;
			}
			if ((_loc2.isStart("talk")) && (_loc2.isEnd("gaspeaus"))) {
				if ((GameState.stlunkoStatus == "party") && (GameState.brodyStatus == "party")) {
					this.put("You have nothing more to ask them.");
				} else {
					if (!GameState.talkGaspeau1) {
						this.put("You try to a Gaspeau if he had seen your friends. \"Enjoying your day off?\" the Gaspeau says playfully. Right, that\'s why Saargtsson hadn't called you yet today. It\'s a brief vacation time to recharge... You really ought to keep better track of the minion calendar. You thank the Gaspeau for the reminder, but he just repeats himself in the same tone, \"Enjoying your day off?\" Ugh. Oh well, you get a bonus point for learning stuff. Knowledge is power!");
						Game.scorePoints(1);
						GameState.talkGaspeau1 = true;
					} else if (!GameState.talkGaspeau2) {
						this.put("You stop a new Gaspeau and ask him if he\'s seen Stlunko. \"Enjoying your day off?\" is the reply. Stupid little boogers. Have they made a coordinated effort to annoy you?");
						GameState.talkGaspeau2 = true;
					} else {
						this.put("\"Enjoying your day off?\"");
					}
				}
				return;
			}
			if ((_loc2.isTake("minions")) || (_loc2.isTake("poorbt")) || (_loc2.isTake("gaspeau")) || (_loc2.isTake("frotzer"))) {
				this.put("They\'re almost too busy to stop and chat with you. There\'s no way they\'ll join your party, or guild, or whatever you want to call it.");
				return;
			}
			if (((_loc2.isStart("shoot")) || (_loc2.isStart("kill"))) && ((_loc2.isEnd("minions")) || (_loc2.isEnd("poorbt")) || (_loc2.isEnd("gaspeau")) || (_loc2.isEnd("frotzer")))) {
				if (attack == undefined) {
					this.put("That\'s a bad idea. They\'re strong in numbers and will fight to kill if you purposely hurt them. You should probably try zapping things with less fatal consequences.");
					attack = true;
				} else {
					this.put("Alright, fine. You shoot a lowly minion anyway. Oh look, now they\'re all jumping on you for betrayal and stuff. Hey, is that your hypothalamus being flung over there? Ouch. You're almost definitely dead now.");
					Game.die();
				}
				return;
			}
		} else {
			if ((_loc2.isGo("east")) || (_loc2.isGo("west"))) {
				if (!GameState.discussion) {
					this.put("\"Hey, where do you think you're going, Tampo?\" Stlunko asks. \"Saargtsson is this other way!\"");
				} else {
					if (_loc2.isGo("east")) {
						Game.newRoom("center_west");
					} else {
						Game.newRoom("corridor_south");
					}
				}
				return;
			}
			if ((_loc2.isTalk("minions")) || (_loc2.isTalk("poorbts")) || (_loc2.isTalk("frotzers")) || (_loc2.isTalk("gaspeau"))) {
				this.put("There are none here to talk to.");
				return;
			}
			if ((_loc2.isLookAt("minions")) || (_loc2.isLookAt("poorbts")) || (_loc2.isLookAt("frotzers")) || (_loc2.isLookAt("gaspeau"))) {
				this.put("They seem to have all left this place. Huh.");
				return;
			}
			if (_loc2.contains("gokul")) {
				this.put("There appears to be none here. But that's not unusual, there generally aren't any in this area anyway.");
				return;
			}
		}
		if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
			this.put("There isn\'t any lava pool to sit in here. If you want to BURN and DIE so badly, try somewhere else.");
			return;
		}
		//trace("Room_crossroads parse");
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.gameMode == "regular") {
				this.put("You enter a four way passageway close to the entrance of private chamber. There are a quite a few MINIONS walking about, but other than them these lava-lined corridors are nondescript. Paths spread out in all four directions of the compass. The minions are traveling to and from Saargtsson's lair somewhere to the SOUTH and the Lava Zone's center EAST of here. Your private chamber lies to the NORTH nearby. The WEST path is vacant.");
			} else {
				this.put("You three quickly rush into the four way passageway close to the entrance of private chamber. All of the minions usually here seem to be missing... how strange. But they're not important right now. Paths spread out in all four directions of the compass. The Lava Zone's center lies EAST, the path to the caldera is WEST, and your personal chamber is directly NORTH. Meanwhile Saargtsson and his lair are beyond the SOUTH-heading corridor.");
			}
			firstTime = false;
		} else {
			if (GameState.gameMode == "regular") {
				this.put("You are currently in a four-way passageway. There are a quite a few MINIONS walking about these lava-lined corridors. Your private chamber is to the NORTH, while Saargtsson's personal lair lies conveniently nearby in a SOUTH-ward path. The Lava Zone's center is EAST of here, where most of the work and recreation is done. The WEST path is mysteriously vacant.");
			} else {
				this.put("You are floating in a four-way passageway. All the MINIONS that used to hang out here seem to be missing. The Lava Zone's center lies EAST, the path to the caldera is WEST, and your personal chamber is directly NORTH. Meanwhile Saargtsson and his lair are beyond the SOUTH-heading corridor.");
			}
		}
		return;
	}
}
