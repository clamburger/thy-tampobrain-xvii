class Room_simulate extends Room {
	var synonyms, put, superClassParse, pressEnterCallbackFunc, firstTime, plop;
	function Room_simulate() {
		super();
		synonyms.push(new Array("simulator", "machine"));
		synonyms.push(new Array("socket", "sockets", "plug", "plugs"));
		synonyms.push(new Array("minion", "minions", "frotzer", "frotzers", "gaspeau", "gaspeaus", "poorbt", "poorbts"));
		synonyms.push(new Array("book", "manual", "guide"));
	}
	function getName() {
		return ("Simulation Room");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("machine")) {
			if (GameState.brodyStatus == "none") {
				this.put("The training simulator is a large machine which uploads your consciousness and allows you to play and train in a virtual enviroment. Apparently the programming was stolen from somewhere. It has many SOCKETS, but only two are currently activated.");
				if (!GameState.headsetUsed) {
					this.put("One of them is being used by BRODY, and the other is missing its HEADSET. The machine appears to have a TRACKER to locate missing equipment, which could come in handy.");
				} else {
					this.put("One of them is being used by BRODY, and the other is open and ready for you to use. The machine appears to have a TRACKER to locate missing equipment, but you don't need to use it anymore.");
				}
			} else {
				this.put("The training simulator is a large machine which uploads your consciousness and allows you to play and train in a virtual enviroment. Apparently the programming was stolen from Stinkoman. It has many SOCKETS, but only two are currently activated. One of them equipped with a HEADSET, and can be used at any time. The machine also appears to have a TRACKER to locate missing equipment.");
			}
			return;
		}
		if (_loc2.isUse("machine")) {
			if (!GameState.gotHeadset) {
				this.put("You\'ll need a virtual reality HEADSET, and BRODY is currently using the only one in the room. Its equipment TRACKER appears active and ready for use though.");
			} else if (!GameState.headsetUsed) {
				this.put("You\'ll have to use that virtual reality HEADSET you brought.");
			} else {
				if (GameState.gameMode == "regular") {
					Game.newRoom("virtual");
				} else {
					this.put("This is not the time to be playing games!");
				}
			}
			return;
		}
		if ((_loc2.isUse("tracker")) || (_loc2.isLookAt("tracker"))) {
			if (!GameState.gotHeadset) {
				this.put("According to the data on the tracker, the missing HEADSET for the empty activated socket is SOUTH-ISH from the Lava Zone\'s Center back WEST.");
			} else if (!GameState.headsetUsed) {
				this.put("The tracker says that the missing HEADSET is actually in this room. Or more accurately, in you.");
			} else {
				this.put("There is nothing it needs to track.");
			}
			return;
		}
		if (_loc2.isGo("west")) {
			if (GameState.brodyStatus == "none") {
				Game.newRoom("center_east");
			} else if (GameState.brodyStatus == "exploded") {
				this.put("Don\'t just leave Brody like that, man.");
			} else {
				Game.newRoom("center_east");
			}
			return;
		}
		if (_loc2.isLookAt("west")) {
			this.put("That way leads out of the room and back to the Lava Zone\'s center.");
			return;
		}
		if (_loc2.isLookAt("minions")) {
			if (GameState.brodyStatus == "none") {
				this.put("There aren't any minions here, besides you and BRODY.");
			} else {
				this.put("There aren\'t any little minions here.");
			}
			return;
		}
		if ((_loc2.isLookAt("brody")) || (_loc2.isTake("brody")) || (_loc2.isUse("brody"))) {
			if (GameState.brodyStatus == "none") {
				this.put("Alright, you found him! He doesn\'t appear to be in any trouble at all. Unfortunately he\'s plugged into the game so you can't get his attention. You can't take the headset off his head because it's locked on him, and for a good reason: Removal while in use could be fatal. If only you could plug yourself into a SOCKET to join him... then you could talk to him.");
			} else {
				this.put("Your tall yellow-feathered friend is standing in the middle of the cavern, no longer playing the game. He\'s done for now and won\'t be going back in soon.");
				if (GameState.brodyStatus == "exploded") {
					this.put("He seems to just be waiting for you to TALK to him and tell him what this is all about.");
				} else {
					this.put("He seems to just be waiting for you to do something or go somewhere.");
				}
			}
			return;
		}
		if ((_loc2.isLookAt("book")) || (_loc2.isUse("book")) || (_loc2.isTake("book")) || ((_loc2.isStart("read")) && (_loc2.isEnd("book")))) {
			this.put("It\'s a small player\'s guide for whatever game is in the simulator. Because it\'s upside down you can\'t see much of it, except for the text \"Dodge left, left, down, then right.\"");
			return;
		}
		if (_loc2.isLookAt("socket")) {
			if(GameState.brodyStatus == "none") {
				if(!GameState.headsetUsed) {
					this.put("They are plugs for the virtual reality HEADSETS. Of the two activated ones, one is in use by BRODY and the other is missing its corresponding HEADSET.");
				} else {
					this.put("They are plugs for the virtual reality HEADSETS. There are two that are activated: one is being used by BRODY and the other is open.");
				}
			} else {
				this.put("They are plugs for the virtual reality HEADSETS. Only two of them are currently active with their corresponding equipment, and they are both open for you to use.");
			}
			return;
		}
		if (_loc2.isLookAt("headset")) {
			if (GameState.brodyStatus == "none") {
				if (!GameState.gotHeadset) {
					this.put("One of them is being hogged by BRODY. The other one isn\'t here, but there is a TRACKER on the machine to help you locate it.");
				} else if (!GameState.headsetUsed) {
					this.put("One of them is being hogged by BRODY. You\'re holding the other one, which needs to be used with the empty SOCKET.");
				} else {
					this.put("One of them is being hogged by BRODY. The other one is ready for you to use.");
				}
			} else {
				this.put("Two seperate headsets are activated and ready for you to use. But not at the same time.");
			}
			return;
		}
		if ((_loc2.isUse("headset")) || (_loc2.isUse("socket"))) {
			if (GameState.brodyStatus == "none") {
				if (!GameState.gotHeadset) {
					if (_loc2.isUse("headset")) {
						this.put("One of them is being hogged by BRODY. The other one isn\'t here, but there is a TRACKER on the machine to help you locate it.");
					} else if (_loc2.isUse("socket")) {
						this.put("You\'ll need your own virtual reality HEADSET, dude.");
					}
				} else if (!GameState.headsetUsed) {
					this.put("You plop the headset onto the floor beside the empty socket, and the machine senses it. The socket extends and automatically connects to the headset. The machine is now ready for you to USE.");
					Game.scorePoints(2);
					GameState.headsetUsed = true;
				} else {
					if (GameState.gameMode == "regular") {
						Game.newRoom("virtual");
					} else {
						this.put("This is not the time to be playing games!");
					}
				}
			} else if (GameState.brodyStatus == "exploded") {
				this.put("Don\'t just leave Brody like that, man.");
			} else {
				if (GameState.gameMode == "regular") {
					Game.newRoom("virtual");
				} else {
					this.put("This is not the time to be playing games!");
				}
			}
			return;
		}
		if (_loc2.isTalk("brody")) {
			if (GameState.brodyStatus == "none") {
				this.put("You yell and scream and go absolutely nuts to get his attention, but to no avail. His mind is entirely in the game and he simply cannot hear you. You give him a nudge in the side and then he suddenly kicks you into a wall. Apparently he thought you were an opponent or something.");
			} else if (GameState.brodyStatus == "exploded") {
				this.put("Brody begins the brief conversation. \"Was there any particular reason you came into the simulation and made me lose?\"\n\n\"Heh heh... sorry about that. Anyway, uh... yeah, I need you to follow me around to do... stuff.\"");
				pressEnterCallbackFunc = postBrodyOne;
				Game.addPause();
			}
			return;
		}
		//trace("Room_simulate parse");
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function postBrodyOne() {
		this.put("\"Stuff, eh?\"\n\n\"Yep.\"\n\n\"Whatever then. This better be at least remotely important.\"\n\n\"Don't worry, I'm sure it is.\"");
		pressEnterCallbackFunc = postBrodyTwo;
		Game.addPause();
	}
	function postBrodyTwo() {
		this.put("Brody joined your, err... \"party\"! His kicking powers, thumbless wings, and powerful beak may come in handy! Although his large size and lack of floatiness may make him unable to follow you everywhere. If you have to leave him for a bit, he'll just stay put until you can get back.");
		GameState.brodyStatus = "party";
		Game.scorePoints(3);
		return;
	}
		
	function look() {
		if (!GameState.exitVirtual) {
			if (firstTime == undefined) {
				if (GameState.brodyStatus == "none") {
					this.put("You walk into the dark Simulation Room. It\'s a somewhat cramped cave with a large TRAINING SIMULATOR along the back wall. There are no small minions about, but BRODY is indeed here, wearing a helmet and playing something. His mind is in the game.");
					if (!GameState.headsetUsed) {
						this.put("There\'s one other activated SOCKET for a virtual reality HEADSET, but it appears to be missing.");
					} else {
						this.put("There\'s one other activated HEADSET waiting for you to use.");
					}
				} else {
					this.put("You walk into the dark Simulation Room. It\'s a somewhat cramped cave with a large TRAINING SIMULATOR along the back wall. Besides you guys, it\'s completely empty. There\'s an activated HEADSET plugged in the machine waiting for you to use. The exit is still back WEST.");
				}
				this.put("There\'s a small discarded BOOK lying on the ground. The exit is back WEST.");
				firstTime = false;
			} else {
				if (GameState.brodyStatus == "none") {
					this.put("A large TRAINING SIMULATOR is along the back wall of this somewhat dark and cramped cave, which has minimal lighting and no visible lava to provide light. There are no little minions around, but BRODY can be seen playing the game with a helmet on.");
					if (!GameState.headsetUsed) {
						this.put("There\'s one other activated SOCKET for a virtual reality HEADSET, but the helmet appears to be missing.");
					} else {
						this.put("There\'s one other activated SOCKET for a virtual reality HEADSET, which is currently ready for you to use.");
					}
					this.put("There\'s a small discarded BOOK lying on the ground. The exit is back WEST.");
				} else if (GameState.brodyStatus == "exploded") {
					this.put("A large TRAINING SIMULATOR is along the back wall of this somewhat dark and cramped cave, which has minimal lighting and no visible lava to provide light. There are no little minions around. BRODY is standing around and waiting for you to TALK to him. There\'s a virtual reality HEADSET in place, just waiting for you to use. There\'s a small discarded BOOK on the ground, and the exit is obviously still WEST.");
				} else {
					this.put("A large TRAINING SIMULATOR is along the back wall of this somewhat dark and cramped cave, which has minimal lighting and no visible lava to provide light. There are no little minions around. There\'s a virtual reality HEADSET in place, just waiting for you to use. There\'s a small discarded BOOK lying on the ground. The exit is obviously still WEST.");
				}
			}
		} else {
			if (GameState.yourbrainasplode == 1) {
				this.put("Before you can react, you get hit by one of Vector Strong Bad's perplexing 3D attacks, and now face certain 3D doom. You a splode in a nice vector flash.\n\n");
			} else if (GameState.yourbrainasplode == 2){
				this.put("SO YOU ASK FOR CHALLENGE?? LEVEL 2 TIMES\n\nUh oh! You dodge around for a little bit while he fires shots at you. And although you tried your hardest, you just aren't Level 2 material yet. You get hit by a flying blast and never saw it coming. You a splode out of the simulation.\n\n");
			} else if (GameState.yourbrainasplode == 3){
				this.put("You push the big floating button and then disappear in an a splosion.");
			}
			if (GameState.yourbrainasplode != 0) {
				GameState.yourbrainasplode = 0;
			}
			this.put("\n\nYou wake up after being ejected from the Simulation, and the simulator wires unplug themselves and free you from the large TRAINING SIMULATOR sitting along the back wall.");
			if (GameState.brodyStatus == "none") {
				this.put("BRODY is indeed here, wearing a helmet and enjoying the simulation. You can't contact him from here. Your HEADSET is still activated and waiting for you to reuse.");
			} else if (GameState.brodyStatus == "exploded") {
				this.put("BRODY is standing around unplugged from the game, waiting for you to tell him why you came. You should probably TALK to him. Meanwhile, your HEADSET is still activated and waiting for you to reuse.");
			} else {
				this.put("Your HEADSET is still activated and waiting for you to reuse.");
			}
			this.put("There's a small discarded BOOK lying on the ground.");
			if (GameState.brodyStatus == "away") {
				if (GameState.stlunkoStatus == "away") {
					if (GameState.stlunkoRoom == "simulate") {
						this.put("The exit is totally WEST.\n\nBrody and Stlunko rejoin your party.");
						GameState.stlunkoStatus = "party";
						GameState.stlunkoRoom = undefined;
					}
				} else {
					this.put("The exit is totally WEST.\n\nBRODY rejoins your party.");
				}
				GameState.brodyStatus = "party";
			} else {
				this.put("The exit is back WEST.");
			}
			GameState.exitVirtual = false;
			firstTime = false;
		}
		return;
	}
}
