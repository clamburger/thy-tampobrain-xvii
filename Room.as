class Room {
	var synonyms, r, pressEnterCallbackFunc, jibney, dancemonkey, plop;
	function Room() {
		synonyms = new Array();
		synonyms.push(new Array("shoot", "fire", "zap"));
		synonyms.push(new Array("laserball", "laserballs", "laser beam", "laser", "energy", "electricity"));
		synonyms.push(new Array("wall", "walls"));
		synonyms.push(new Array("talk", "speak"));
		synonyms.push(new Array("stones", "floor", "rocks", "ceiling"));
		synonyms.push(new Array("saargtsson", "sargtsson", "saargston", "sargston", "snake"));
		synonyms.push(new Array("go", "walk", "float", "head"));
		synonyms.push(new Array("turn on", "activate"));
		if (Game.curRoomName != "lavalake") {
			synonyms.push(new Array("lava flow", "lava", "magma", "magma flow"));
		}
		synonyms.push(new Array("lava", "magma"));
		synonyms.push(new Array("gokul armor", "armor", "heat armor"));
		synonyms.push(new Array("friend", "friends"));
		synonyms.push(new Array("leave north", "exit north"));
		synonyms.push(new Array("leave south", "exit south"));
		synonyms.push(new Array("leave east", "exit east"));
		synonyms.push(new Array("leave west", "exit west"));
		//synonyms.push(new Array("simulation room", "simulation chamber", "training simulator", "training simulater"));
		synonyms.push(new Array("simulation", "simulator", "simulater"));
		synonyms.push(new Array("minions", "minion", "underling"));
		synonyms.push(new Array("helmet", "headset", "headsets", "helmets"));
		synonyms.push(new Array("take", "get", "grab"));
		synonyms.push(new Array("kill", "challenge", "fight", "destroy"));
		synonyms.push(new Array("credit", "credits"));
		synonyms.push(new Array("caledra", "caldera"));
		synonyms.push(new Array("help", "instructions", "help!"));
		synonyms.push(new Array("southish", "south-ish"));
		synonyms.push(new Array("pants", "shorts"));
		synonyms.push(new Array("nyjole", "shadow scythe"));
		synonyms.push(new Array("\'continute at virus\'", "continute at virus"));
		synonyms.push(new Array("lab", "laboratory"));
		synonyms.push(new Array("hardware", "anti-virus", "antivirus"));
		synonyms.push(new Array("push", "shove"));
		synonyms.push(new Array("leave", "exit"));
		synonyms.push(new Array("turn off", "switch off", "deactivate"));
		synonyms.push(new Array("turn on", "switch on", "activate"));
		r = "";
		this.look();
	}
	function postParse() {
		if ((GameState.gameMode == "virus") && (!Game.dead)) {
			if (GameState.virusUpload<=90) {
				GameState.virusUpload += 5;
			} else {
				GameState.virusUpload += 1;
			}
			if (GameState.virusUpload<=99) {
				this.put("\n\nThe virus upload is currently at "+GameState.virusUpload+"%.");
			}
		}
		GameState.allowedToWarp = false;
		if (Room_puzzle_brody.countdown == 5) {
			this.put("\n\nRemember, that bomb is ticking. You should probably make sure you're somewhere sheltered before it blows any minute now.");
		}
		if (Room_puzzle_brody.breath == 2) {
			this.put("\n\nYou are starting to feel the need to breathe.");
		}
		if (Room_puzzle_brody.breath == 1) {
			this.put("\n\nYour lungs are starting to burn. You should probably GO OUT to get a breathe of air now.");
		}
	}
	function parse() {
		r = "";
	}
	function superClassParse() {
		if (GameState.gameMode == "virus") {
			if (GameState.virusUpload>=99) {
				this.put("The virus upload has now reached 100%.");
				this.put("\n\nIn a matter of seconds, the Lava Zone and everyone in it is overtaken by a wave of the reality-altering virus, and you and everything else have been mutated by the virus. As it spreads across the globe, it will be nigh-impossible for anyone to stop it. I hope you enjoyed your old reality while it lasted, because now everything is zany, random and under the virus' control. Basically, it sucks. You don't exactly die, but you lose just the same.");
				Game.die();
				return (true);
			}
		}
		var _loc2 = Game.tp;
		//trace("Room:superClassParse = "+_loc2.is("look"));
		/*if (_loc2.is("loc")) {
		this.put("You are here: "+Game.curRoom.getName());
		}*/
		if (_loc2.is("look")) {
			this.look();
			return (true);
		}
		if (_loc2.isStart("warp")) {
			/*if (_loc2.is("warp sim")) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.talkPoorbt = true;
				GameState.gotHeadset = true;
				Game.newRoom("simulate");
			} else if (_loc2.is("warp brody")) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.talkPoorbt = true;
				GameState.gotHeadset = true;
				GameState.headsetUsed = true;
				GameState.vectorSteps = 5;
				GameState.brodyStatus = "party";
				Game.newRoom("center_east");
			} else if (_loc2.is("warp compy")) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.talkPoorbt = true;
				GameState.gotHeadset = true;
				GameState.headsetUsed = true;
				GameState.vectorSteps = 5;
				GameState.brodyStatus = "party";
				GameState.congestion = false;
				Game.newRoom("spikes");
			} else if (_loc2.is("warp stlunko")) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.talkPoorbt = true;
				GameState.gotHeadset = true;
				GameState.headsetUsed = true;
				GameState.vectorSteps = 5;
				GameState.brodyStatus = "away";
				GameState.brodyRoom = "spikes";
				GameState.congestion = false;
				GameState.lookedNorth = true;
				GameState.caledraEntrance = 1;
				GameState.stlunkoStatus = "party";
				GameState.doorState = "closed";
				Game.newRoom("lavalake");
			} else if (_loc2.is("warp virus")) {
				warpVirus();
			} else if (_loc2.is("warp gokul")) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.firstTimeSpikes = false;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.gotHeadset = true;
				GameState.headsetUsed = true;
				GameState.vectorSteps = 5;
				GameState.congestion = false;
				GameState.doorState = "open";
				GameState.compyState = "virus";
				GameState.caledraEntrance = 1;
				GameState.brodyStatus = "party";
				GameState.stlunkoStatus = "party";
				GameState.lookedNorth = true;
				GameState.lookMicrowave = true;
				GameState.triedSwitch = true;
				GameState.gameMode = "virus";
				GameState.allowedToWarp = false;
				GameState.discussion = true;
				GameState.lairEnter = true;
				Game.newRoom("gokul");
			} else if ((_loc2.is("warp prison t")) || (_loc2.is("warp tampo prison"))) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.firstTimeSpikes = false;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.gotHeadset = true;
				GameState.headsetUsed = true;
				GameState.vectorSteps = 5;
				GameState.congestion = false;
				GameState.doorState = "open";
				GameState.compyState = "virus";
				GameState.caledraEntrance = 1;
				GameState.brodyStatus = "away";
				GameState.stlunkoStatus = "away";
				GameState.lookedNorth = true;
				GameState.lookMicrowave = true;
				GameState.triedSwitch = true;
				GameState.gameMode = "puzzle";
				GameState.allowedToWarp = false;
				GameState.discussion = true;
				GameState.lairEnter = true;
				GameState.islandFlipped = true;
				GameState.magnetUsed = true;
				GameState.hardware = true;
				GameState.puzzleMode = true;
				Game.newRoom("puzzle_tampo");
			} else if ((_loc2.is("warp prison b")) || (_loc2.is("warp brody prison"))) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.firstTimeSpikes = false;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.gotHeadset = true;
				GameState.headsetUsed = true;
				GameState.vectorSteps = 5;
				GameState.congestion = false;
				GameState.doorState = "open";
				GameState.compyState = "virus";
				GameState.caledraEntrance = 1;
				GameState.brodyStatus = "away";
				GameState.stlunkoStatus = "away";
				GameState.lookedNorth = true;
				GameState.lookMicrowave = true;
				GameState.triedSwitch = true;
				GameState.gameMode = "puzzle";
				GameState.allowedToWarp = false;
				GameState.discussion = true;
				GameState.lairEnter = true;
				GameState.islandFlipped = true;
				GameState.magnetUsed = true;
				GameState.hardware = true;
				GameState.puzzleMode = true;
				GameState.inControl = "brody";
				Game.newRoom("puzzle_brody");
			} else if ((_loc2.is("warp prison s")) || (_loc2.is("warp stlunko prison"))) {
				GameState.seenGokul = true;
				GameState.gokulExplode = true;
				GameState.talkFrotzer = true;
				GameState.firstTimeSpikes = false;
				GameState.friendsChamber = false;
				GameState.seenShortcut = true;
				GameState.seenGokulFeed = true;
				GameState.gotHeadset = true;
				GameState.headsetUsed = true;
				GameState.vectorSteps = 5;
				GameState.congestion = false;
				GameState.doorState = "open";
				GameState.compyState = "virus";
				GameState.caledraEntrance = 1;
				GameState.brodyStatus = "away";
				GameState.stlunkoStatus = "away";
				GameState.lookedNorth = true;
				GameState.lookMicrowave = true;
				GameState.triedSwitch = true;
				GameState.gameMode = "puzzle";
				GameState.allowedToWarp = false;
				GameState.discussion = true;
				GameState.lairEnter = true;
				GameState.islandFlipped = true;
				GameState.magnetUsed = true;
				GameState.hardware = true;
				GameState.puzzleMode = true;
				GameState.inControl = "stlunko";
				Game.newRoom("puzzle_stlunko");
			} else if (_loc2.is("warp end")) {
				Game.newRoom("end_game");
			} else if (_loc2.is("warp game")) {
				Game.flaskGameStart();
				return (true);
			} else { */
				this.put("You don\'t get to warp anywhere, ya little cheater.");
				return (true);
			//}
			//Game._mc.score_txt.text = "Wah! You cheat! Disqualified, I say!";
		}
		/* if (_loc2.contains("stinkoman")) {
		this.put("Man, you hate him so much...");
		return (true);
		} */ 
		if (((_loc2.isStart("shoot")) || (_loc2.isStart("use"))) && (_loc2.isEnd("laserball"))) {
			this.put("You fire a laserball at the wall. Aren't you clever?");
			return (true);
		}
		if (GameState.inControl) {
			if (_loc2.isLookAt("laserball")) {
				this.put("They\'re shiny, they zap stuff, and you have an endless amount. What more do you need in life?");
				return (true);
			}
		}
		if (!GameState.puzzleMode) {
			if (_loc2.isLookAt("wall")) {
				this.put("Everything around you is pretty rocks! Boring old rocks. You could probably use some wallpaper.");
				return (true);
			}
			if (((_loc2.isStart("use")) || (_loc2.isStart("put on")) || (_loc2.isStart("put up"))) && (_loc2.isEnd("wallpaper"))) {
				this.put("No. Twas a joke. Boring old rocks are fine.");
				return (true);
			}
		}
		if ((_loc2.isStart("talk")) && (_loc2.isEnd("wall"))) {
			if (GameState.inControl != "stlunko") {
				this.put("You aren\'t that bored yet.");
			} else {
				this.put("You are not that bored yet.");
			}
			return (true);
		}
		if ((_loc2.contains("boop")) || (_loc2.contains("preow"))) {
			this.put("Wah!");
			return (true);
		}
		if (_loc2.contains("jibney")) {
			if (!GameState.jibney) {
				this.put("JIBNEY!! You speak the word of unlimited evil. Suddenly darkness engulfs your entire being, torturing your entire soul in misery and despair. The blood in your veins turns to acid, causing intense and unlimited pain in your state of semi-consciousness. The pain suddenly disappears, as all is gone... Never say that evil word again.");
				GameState.jibney = true;
			} else {
				this.put("You dare speak the word of unlimited evil once again. The terrible darkness and pain return tenfold, and you die a slow and torturous death. The agony");
				if (GameState.inControl != "stlunko") {
					this.put("isn\'t");
				} else {
					this.put("is not");
				}
				this.put("over until your lifeless body falls to the ground...");
				if (GameState.inControl == "tampo") {
					Game.die();
				} else {
					Game.die(GameState.inControl);
				}
			}
			return (true);
		}
		if (_loc2.contains("sticklyman")) {
			if (GameState.inControl != "stlunko") {
				this.put("GASPEAU! YOU JUST SAID THE MASTER\'S NAME!! THAT\'S HERESY! HERESY!!! YOU DIE FROM DEATH!!!!!!");
			} else {
				this.put("GASPEAU! YOU JUST SAID THE MASTER\'S NAME!! THAT IS HERESY! HERESY!!! YOU DIE FROM DEATH!!!!!!");
			}
			if (GameState.inControl == "tampo") {
				Game.die();
			} else {
				Game.die(GameState.inControl);
			}
			return (true);
		}
		if (_loc2.contains("bonus stage")) {
			if (!GameState.bonusStage) {
				if (GameState.inControl != "stlunko") {
					this.put("If it was up to Super Sam, you would very die. But it\'s not up to Super Sam, so instead, I\'ll just tell you that Bonus Stage is teh sukkage. It\'s just plain evil. What kind of sick man would watch Bonus Stage?! Well, I suppose this message is long enough now (maybes), so I\'ll let you go, TampoBrain. <(.-.<)");
				} else {
					this.put("If it was up to Super Sam, you would very die. But it is not up to Super Sam, so instead, I will just tell you that Bonus Stage is teh sukkage. It is just plain evil. What kind of sick man would watch Bonus Stage?! Well, I suppose this message is long enough now (maybes), so I will let you go, TampoBrain. <(.-.<)");
				}
				GameState.bonusStage = true;
			} else {
				if (GameState.inControl != "stlunko") {
					this.put("Actually, it *is* up to Super Sam.\n\n\"You attempt to watch Bonus Stage, but die because it is so evil. You shouldn\'t have pushed your luck!\"\n\nTake *that*, Joshua!");
				} else {
					this.put("Actually, it *is* up to Super Sam.\n\n\"You attempt to watch Bonus Stage, but die because it is so evil. You should not have pushed your luck!\"\n\nTake *that*, Joshua!");
				}
				if (GameState.inControl == "tampo") {
					Game.die();
				} else {
					Game.die(GameState.inControl);
				}
			}
			return (true);
		}
		if (((_loc2.isStart("eat")) || (_loc2.isStart("drink")) || (_loc2.isStart("swallow"))) && (!_loc2.isEnd("cham cham"))) {
			if (_loc2.is("eat cat")) {
				this.put("Where do you suppose you'd find a cat around here? This is the Lava Zone! I think it'd be a little too hot for regular cats down here.");
			} else if (_loc2.is("eat turkey")) {
				this.put("Didn't your mother ever tell you about the lack of turkeys in the Lava Zone?");
			} else {
				this.put("You\'re a floating brain. You don\'t eat or drink, you absorb. Digestive systems are for losers.");
			}
			return (true);
		}
		if (_loc2.contains("zyves")) {
			this.put("Eh, Zyves is out of town on some sort of errand that has nothing to do with this plot. You best be forgetting about him. Besides, he got his limelight in \"bomb squad\".");
			return (true);
		}
		if (GameState.gameMode != "puzzle") {
			if (_loc2.isLookAt("snake")) {
				if (GameState.gameMode != "virus") {
					this.put("He ain't here. Fortunately.");
				} else {
					if (!GameState.discussion) {
						this.put("He should be lying in his lair to the SOUTH. You better hurry up and get to him!");
					} else {
						this.put("Leave him alone for now, okay?");
					}
				}
				return (true);
			}
			if (((_loc2.isStart("talk")) || (_loc2.isStart("call"))) && (_loc2.isEnd("snake"))) {
				if (GameState.gameMode != "virus") {
					this.put("Nah. With all the chores he\'s been giving you lately, the longer he\'s out of contact, the better.");
				} else {
					if (!GameState.discussion) {
						this.put("He should be lying in his lair to the SOUTH. You better hurry up and get to him!");
					} else {
						this.put("Leave him alone for now, okay?");
					}
				}
				return (true);
			}
		}
		if ((_loc2.is("get ye flask")) || (_loc2.is("get flask"))) {
			if (GameState.inControl != "stlunko") {
				this.put("No. That\'s just stupid. Get back to work.");
			} else {
				this.put("No. That is just stupid. Get back to work.");
			}
			return (true);
		}
		if ((_loc2.isStart("use")) && ((_loc2.isEnd("armor")) || (_loc2.isEnd("gokul")) || (_loc2.isEnd("guts")))) {
			if (!GameState.puzzleMode) {
				if (GameState.gokulExplode) {
					this.put("Oh, it\'s splattered all over you. You\'ll be using it constantly until you take a bath.");
				} else {
					this.put("Use it? You don\'t even have it!");
				}
			} else {
				if (GameState.inControl == "tampo") {
					this.put("It's worn off. Aw.");
				} else {
					DontUnderstand.parse(this);
				}
			}
			return (true);
		}
		/* if ((_loc2.isStart("take")) && (_loc2.isEnd("bath")) && (!_loc2.contains("lava"))) {
		this.put("The only bath you\'ll be able to take is a LAVA BATH. In fact, I dare you to take one! Bwahahaha...");
		return (true);
		} */ 
		if (_loc2.isEnd("focus")) {
			if (GameState.inControl != "stlunko") {
				this.put("You can\'t do that. You have none.");
			} else {
				this.put("You cannot do that. You have none.");
			}
			return (true);
		}
		/* if (_loc2.is("`")) {
		Game.newRoom("debug");
		} */ 
		if ((GameState.inControl == "tampo") || (GameState.inControl == "stlunko")) {
			if (_loc2.isLookAt("brody")) {
				if (GameState.puzzleMode) {
					if (GameState.inControl == "tampo") {
						this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
					} else {
						this.put("He is not here with you. You are pretty sure he got locked up in his own virusy prison.");
					}
				} else {
					if (GameState.brodyStatus == "none") {
						this.put("He seems to not be around. Bummer.");
					} else if (GameState.brodyStatus == "away") {
						this.put("You seem to have gotten seperated from him. He\'s probably waiting where you left him last.");
					} else {
						this.put("His feet are orange feet.");
					}
				}
				return (true);
			}
			if (_loc2.isTalk("brody")) {
				if (GameState.puzzleMode) {
					if (GameState.inControl == "tampo") {
						this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
					} else {
						this.put("He is not here with you. You are pretty sure he got locked up in his own virusy prison.");
					}
				} else {
					if (GameState.brodyStatus == "none") {
						this.put("He appears to be missing from the room. You call out for him but get no response.");
					} else if (GameState.brodyStatus == "away") {
						this.put("You seem to have gotten seperated from him. He\'s probably waiting where you left him last.");
					} else {
						if (GameState.gameMode != "virus") {
							this.put("You try to start up a conversation with Brody, but fail miserably. I blame your stupid lack of FOCUS.");
						} else {
							this.put("He's not in the mood to talk.");
						}
					}
				}
				return (true);
			}
			if (_loc2.isTake("brody")) {
				if (GameState.puzzleMode) {
					if (GameState.inControl == "tampo") {
						this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
					} else {
						this.put("He is not here with you. You are pretty sure he got locked up in his own virusy prison.");
					}
				} else {
					if (GameState.brodyStatus == "none") {
						/* && _loc2.is("get brody"))*/
						this.put("It\'s not going to be that easy, dude. Getting him is clearly part of your quest!");
					} else if (GameState.brodyStatus == "away") {
						this.put("You seem to have gotten seperated from him. He\'s probably waiting where you left him last.");
					} else {
						this.put("He\'s already following you around. Like a puppy or something.");
					}
				}
				return (true);
			}
			if (_loc2.isUse("brody")) {
				if (GameState.puzzleMode) {
					if (GameState.inControl == "tampo") {
						this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
					} else {
						this.put("He is not here with you. You are pretty sure he got locked up in his own virusy prison.");
					}
				} else {
					if (GameState.brodyStatus == "none") {
						this.put("He isn\'t here. You need to FOCUS more, foo.");
					} else if (GameState.brodyStatus == "away") {
						this.put("You seem to have gotten seperated from him. He\'s probably waiting where you left him last.");
					} else {
						this.put("Yes, you'll no doubt be using your friend all over the place. But you'll have to be a bit more specific.");
					}
				}
				return (true);
			}
			if (((_loc2.isStart("shoot")) || (_loc2.isStart("challenge"))) && (_loc2.isEnd("brody"))) {
				if (GameState.puzzleMode) {
					this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
				} else {
					if (GameState.brodyStatus == "party") {
						this.put("You fire a laser ball at Brody and it hits him in his lower leg. He starts jumping around on one foot screaming in pain, as he always does. What fun. Unfortunately, he doesn't seem to think so as the pain lightens up.\n\nHis head turns all red and he starts yelling, \"What the heck was that for?! Screw you, I\'m getting some food!\"\n\nHe stomps off angrily, saying \"Ow.\" with every other step.");
						pressEnterCallbackFunc = postShootBrody;
						Game.addPause();
						return (true);
					} else {
						return (false);
					}
				}
			}
		}
		/* if (_loc2.isLookAt("stlunko")) {
		if (!GameState.seenStlunko) {
		this.put("He seems to not be around. Bummer.");
		return (true);
		}
		else {
		this.put("Some day you\'ll be able to get him to say a contraction.");
		} 
		}
		if ((_loc2.isStart("talk")) && (_loc2.isEnd("stlunko"))) {
		if (!GameState.seenStlunko) {
		this.put("He appears to be missing from the room. You call out for him but get no response.");
		return (true);
		} else {
		this.put("His contraction-free speech is much too boring to be worth listening to.");
		}
		}
		if (_loc2.is("get stlunko")) {
		this.put("It\'s not going to be that easy, dude. Getting him is clearly part of your quest!");
		return (true);
		} */ 
		if (_loc2.is("<('-'<)")) {
			this.put("<(.-.<)\nKirby plopped.");
			return (true);
		}
		if (_loc2.is("(>'-')>")) {
			this.put("(>.-.)>\nKirby plopped.");
			return (true);
		}
		if (_loc2.contains("credits")) {
			this.put("Script wroten by the awexome JOSHUA.\nCoded by SOUPY SAM using some code from that Johnathon guy.\nUbercool graphix courtesy of SUPERB SAMUEL.\nEbil bugs decimated by JOSHBURGER.");
			return (true);
		}
		if ((!_loc2.is("die")) && (!_loc2.is("quit"))) {
			if (GameState.death>0) {
				if (GameState.death == 1) {
					GameState.death = undefined;
				} else {
					--GameState.death;
				}
			}
		}
		if ((_loc2.is("die")) || (_loc2.is("quit"))) {
			if (GameState.death == undefined) {
				if (_loc2.is("die")) {
					this.put("Only liars and thieves type \'die\' to quit... and those people go to prison. Just ask The Cheat.");
				} else {
					this.put("Only liars and thieves type \'quit\' to die... and those people go to prison. Just ask The Cheat.");
				}
				if (GameState.inControl != "stlunko") {
					this.put("\n\nNow don\'t be trying that again, y\'hear? I'm serious. You\'ll plop and it won\'t be pretty.");
				} else {
					this.put("\n\nNow do not be trying that again, you hear? I am serious. You will plop and it will not be pretty.");
				}
				GameState.death = 3;
			} else {
				this.put("Alright, if you say so. *plop*");
				if (GameState.inControl == "tampo") {
					Game.die();
				} else {
					Game.die(GameState.inControl);
				}
			}
			return (true);
		}
		if (_loc2.is("burn")) {
			if (GameState.inControl == "tampo") {
				this.put("Sorry, but Tampos aren't very combustable. At least not spontaneously so.");
			} else if (GameState.inControl == "brody") {
				this.put("Sorry, but Brodys aren't very combustable. At least not spontaneously so.");
			} else {
				this.put("Sorry, but Stlunkos are not very combustable. At least not spontaneously so.");
			}
			return (true);
		}
		if (_loc2.isStart("save")) {
			if (GameState.inControl != "stlunko") {
				this.put("Yeah, you *wish* you could save a game. You aren\'t getting through Thy TampoBrain that easy.");
			} else {
				this.put("Yeah, you *wish* you could save a game. You are not getting through Thy TampoBrain that easy.");
			}
			return (true);
		}
		if (_loc2.isStart("load")) {
			if (GameState.inControl != "stlunko") {
				this.put("Yeah, you *wish* you could load a game. You aren\'t getting through Thy TampoBrain that easy.");
			} else {
				this.put("Yeah, you *wish* you could load a game. You are not getting through Thy TampoBrain that easy.");
			}
			return (true);
		}
		if (_loc2.isLookAt("friends")) {
			if (GameState.friendsChamber == true) {
				this.put("Eh, your two friends BRODY and STLUNKO aren't here. That\'s strange, they usually sleep in a little. Saargtsson must have given them early chores or something, right? I mean, there\'s no way they've been kidnapped or anything. That\'s just absurd.");
			} else {
				if (GameState.puzzleMode) {
					if (GameState.inControl != "stlunko") {
						this.put("They're not in this virus prison with you. You are seperated!");
					} else {
						this.put("They are not in this virus prison with you. You are seperated!");
					}
				} else {
					if ((GameState.brodyStatus != "party") && (GameState.stlunkoStatus != "party")) {
						plop = Game.curRoomName;
						if ((plop == "virtual") && (GameState.brodyStatus == "none")) {
							this.put("BRODY is over there fighting VECTOR HOMESTAR, but STLUNKO is elsewhere.");
						} else if ((plop == "simulate") && (GameState.brodyStatus == "none")) {
							this.put("BRODY is currently plugged into the simulator, but STLUNKO is elsewhere.");
						} else if ((plop == "simulate") && (GameState.brodyStatus == "exploded")) {
							this.put("BRODY is standing in the room with you, but STLUNKO is elsewhere.");
						} else if ((plop == "lavalake") && ((GameState.stlunkoStatus == "none") || (GameState.stlunkoStatus == "talked") || (GameState.stlunkoStatus == "bomb"))) {
							this.put("STLUNKO is here in the Caldera with you, but BRODY is elsewhere.");
						} else {
							if (GameState.lookFriends == false) {
								this.put("Your two friends BRODY and STLUNKO aren\'t here. They have to be somewhere in this Lava Zone...");
							} else {
								this.put("Your two friends BRODY and STLUNKO aren't here.");
							}
						}
						//this.put("\n\n"+plop);
					} else if ((GameState.brodyStatus == "party") && (GameState.stlunkoStatus != "party")) {
						this.put("Your large chickeny friend BRODY is with you, but STLUNKO is elsewhere.");
					} else if ((GameState.brodyStatus != "party") && (GameState.stlunkoStatus == "party")) {
						this.put("Your shiny robot friend STLUNKO is with you, but BRODY is elsewhere.");
					} else {
						this.put("Tampo, Brody and Stlunko, the whole team! You'll be able to create more collateral damage when you're together.");
					}
					GameState.lookFriends = true;
				}
			}
			return (true);
		}
		if (_loc2.contains("wii")) {
			if (GameState.inControl != "stlunko") {
				this.put("You don\'t have any Wiii to play with.");
			} else {
				this.put("You do not have any Wiii to play with.");
			}
			return (true);
		}
		/* if (_loc2.isLookAt("headset")) {
		if (GameState.gotHeadset) {
		this.put("There is no headset of any kind laying around here.");
		return (true);
		}
		} */ 
		if ((_loc2.contains("really")) || (_loc2.contains("rly"))) {
			this.put("YA RLY");
			return (true);
		}
		/* if (_loc2.isUse("headset")) {
		if (GameState.gotHeadset) {
		if (!GameState.headsetUsed) {
		this.put("You\'ll have to take it to a Training Simulator. Otherwise it\'s useless.");
		return (true);
		}
		} else {
		this.put("You don\'t have one of those.");
		return (true);
		}
		} */ 
		/* if (_loc2.is("boorst")) {
		this.put("xyYYZUozo OIJO  <>.<---().____<< waASddsticAOp  ppdd gameState.see$$$%%a %56%30$var ()RetRRN cLFUNC ddAasdE SS$%% 454 s = tr {{ } syntaxError ssD DDDD soim><.... ||xË sss");
		Game.die();
		} */
		if (_loc2.is("my eyes!")) {
			this.put("THE GOGGLES DO NOTHING!");
			return (true);
		}
		/*if (_loc2.is("var brodystatus")) {
			this.put("brodyStatus = "+GameState.brodyStatus);
			return (true);
		}
		if (_loc2.is("var stlunkostatus")) {
			this.put("stlunkoStatus = "+GameState.stlunkoStatus);
			return (true);
		}
		if (_loc2.is("var congestion")) {
			this.put("congestion = "+GameState.congestion);
			return (true);
		}
		if (_loc2.is("var exitingroom")) {
			this.put("exitingRoom = "+GameState.exitingRoom);
			return (true);
		}
		if (_loc2.is("var brodyroom")) {
			this.put("brodyRoom = "+GameState.brodyRoom);
			return (true);
		}
		if (_loc2.is("var gokulexplode")) {
			this.put("gokulExplode = "+GameState.gokulExplode);
			return (true);
		}
		if (_loc2.is("var talkpoorbt")) {
			this.put("talkPoorbt = "+GameState.talkPoorbt);
			return (true);
		}
		if (_loc2.is("var virusupload")) {
			this.put("virusUpload = "+GameState.virusUpload);
			return (true);
		}*/
		if (_loc2.isTake("joshua")) {
			this.put("You are one disturbing person.");
			return (true);
		}
		if ((_loc2.isLookAt("joshua")) || (_loc2.is("joshua"))) {
			this.put("He appears to have some sort of bird nest on his hand. How intelligent.");
			return (true);
		}
		if (_loc2.isTalk("joshua")) {
			if (GameState.inControl != "stlunko") {
				this.put("I wouldn\'t try that if I were you. Joshua could talk down a politician.");
			} else {
				this.put("I would not try that if I were you. Joshua could talk down a politician.");
			}
			return (true);
		}
		if (_loc2.contains("aldi")) {
			switch (random(2)) {
			case 0 :
				this.put("SUPER SAM: Driving two hours to your nearest Aldi store is clearly worth the experience.");
				break;
			case 1 :
				this.put("JOSHUA: Aldi is obviously a myth. Unless you have some sort of blurry photographic evidence to prove it.");
				break;
			}
			return (true);
		}
		if (_loc2.contains("oranjuice")) {
			this.put("\"It'll make your lungs fall out!\" -ALDI");
			return (true);
		}
		if (_loc2.contains("stunks")) {
			if (GameState.inControl == "tampo") {
				this.put("No deal, Tamps.");
			} else if (GameState.inControl == "brody") {
				this.put("No deal, Brods.");
			} else {
				this.put("You have erased that name from your memory banks. It would be best for everybody if it stayed that way.");
			}
			return (true);
		}
		if (_loc2.isEnd("party")) {
			if (!GameState.puzzleMode) {
				if (((GameState.brodyStatus == "party") || (GameState.brodyStatus == "away")) && ((GameState.stlunkoStatus == "party") || (GameState.stlunkoStatus == "away"))) {
					this.put("Your party consists of Brody, Stlunko and yourself.");
					dancemonkey = "tbs";
				} else if (((GameState.brodyStatus == "party") || (GameState.brodyStatus == "away")) && ((GameState.stlunkoStatus != "party") && (GameState.stlunkoStatus != "away"))) {
					this.put("Your party consists of Brody and yourself.");
					dancemonkey = "tb";
				} else if (((GameState.brodyStatus != "party") && (GameState.brodyStatus != "away")) && ((GameState.stlunkoStatus == "party") || (GameState.stlunkoStatus == "away"))) {
					this.put("Your party consists of Stlunko and yourself.");
					dancemonkey = "ts";
				} else if (((GameState.brodyStatus != "party") && (GameState.brodyStatus != "away")) && ((GameState.stlunkoStatus != "party") && (GameState.stlunkoStatus != "away"))) {
					this.put("Your party consists of only yourself.");
					dancemonkey = "t";
				} else {
					this.put("Joshua, Super Sam and yourself.");
				}
				this.put("\n\nYou're TAMPO the floating brain. Your relatively small size and floating powers will allow you to squeeze through where others cannot. Plus you can ZAP things with your endless supply of laserballs. On the down side, you ain't got no hands.");
				if ((dancemonkey == "tbs") || (dancemonkey == "tb")) {
					this.put("\n\nBRODY is your very loyal giant chicken friend. Although he can't fit through every corridor there is, he has powerful feet that can KICK stuff for you. Plus he has small hand-like WINGS and a sturdy BEAK that may help you as well.");
					if (GameState.brodyStatus == "away") {
						this.put("He is currently seperated from you.");
					}
				}
				if ((dancemonkey == "tbs") || (dancemonkey == "ts")) {
					this.put("\n\nSTLUNKO is your robotic sidekick-type who has really useful HANDS that can do all sorts of things. But his knowledge may even be more helpful, as he knows practically everything. However he isn't very manuverible, so he may be left behind at places.");
					if (GameState.stlunkoStatus == "away") {
						this.put("He is currently seperated from you.");
					}
				}
			} else {
				this.put("Your party consists of only yourself.");
				if (GameState.inControl == "tampo") {
					this.put("\n\nYou're TAMPO the floating brain. Your relatively small size and floating powers will allow you to squeeze through where others cannot. Plus you can ZAP things with your endless supply of laserballs. On the down side, you ain't got no hands.");
				} else if (GameState.inControl == "brody") {
					this.put("\n\nYou're BRODY the giant chicken. Although you can't fit through every corridor there is, you have powerful feet that can KICK stuff. Plus you have small hand-like WINGS and a sturdy BEAK that may help as well.");
				} else if (GameState.inControl == "stlunko") {
					this.put("\n\nYou are STLUNKO, the robotic sidekick-type who has really useful HANDS that can do all sorts of things. But your knowledge may even be more helpful, as you know practically everything. However, you are not very manuverible, so you may be left behind at places.");
				}
			}
			return (true);
		}
		if (_loc2.is("pwd")) {
			this.put("C:\\Documents and Settings\\Sam\\Desktop\\Thy Tampoman 3\\~thyDungeonman3.swf\\"+Game.curRoom.getName());
			return (true);
		}
		if ((GameState.inControl == "brody") || (GameState.inControl == "stlunko")) {
			if (_loc2.isEnd("tampo")) {
				if (GameState.inControl == "brody") {
					this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
				} else {
					this.put("He is not here with you. You are pretty sure he got locked up in his own virusy prison.");
				}
				return (true);
			}
		}
		if ((GameState.inControl == "tampo") || (GameState.inControl == "brody")) {
			if (_loc2.isLookAt("stlunko")) {
				if (GameState.puzzleMode) {
					this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
				} else {
					if (GameState.stlunkoStatus == "none") {
						this.put("He seems to not be around. Bummer.");
					} else if (GameState.stlunkoStatus == "away") {
						this.put("He's not here, so you must've left him somewhere. Check back where you last saw him.");
					} else {
						this.put("Lookit that shiny metallic finish. You wish you had one of those.");
					}
				}
				return (true);
			}
			
			if (_loc2.isTalk("stlunko")) {
				if (GameState.puzzleMode) {
					this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
				} else {
					if (GameState.stlunkoStatus == "none") {
						this.put("\"Hello? Contraction guy?\"\n\nNope, no response. Looks like you'll have to find him the hard way.");
					} else if (GameState.stlunkoStatus == "away") {
						this.put("He's not here, so you must've left him somewhere. Check back where you last saw him.");
					} else {
						if (GameState.gameMode != "virus") {
							this.put("You ask Stlunko \"What's up?\" and he starts to babble about the metaphysics of the universe and the capacities it holds to expand onward and how he cannot give definite and exact answer to what is \"up\". That's our Stlunko!");
						} else {
							if (!GameState.discussion) {
								this.put("He reminds you to go SOUTH to Saargtsson so you can stop the virus. So get going, you!");
							} else {
								if (!GameState.islandFlipped) {
									askStlunko();
								} else {
									this.put("Get down there!");
								}
							}
						}
					}
				}
				return (true);
			}
			if (_loc2.isTake("stlunko")) {
				if (GameState.puzzleMode) {
					this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
				} else {
					if (GameState.stlunkoStatus == "none") {
						/*&& _loc2.is("get stlunko"))*/
						this.put("It\'s not going to be that easy, dude. Getting him is clearly part of your quest!");
					} else if (GameState.stlunkoStatus == "away") {
						this.put("He's not here, so you must've left him somewhere. Check back where you last saw him.");
					} else {
						this.put("\"Get your cerebral fluids away from my chrome finish. It took me a long capacity of time to polish all of my metal.\"");
					}
				}
				return (true);
			}
			if (_loc2.isUse("stlunko")) {
				if (GameState.puzzleMode) {
					this.put("He isn't here with you. You're pretty sure he got locked up in his own virusy prison.");
				} else {
					if (GameState.stlunkoStatus == "none") {
						this.put("He may be somewhere, but he ain't here.");
					} else if (GameState.stlunkoStatus == "away") {
						this.put("He's not here, so you must've left him somewhere. Check back where you last saw him.");
					} else {
						this.put("He may be a robot, but he isn't one of those \"program to do stuff and play with\" robots. He's been upgraded since then.");
					}
				}
				return (true);
			}
		}
		if (_loc2.isEnd("help")) {
			this.put("inv - what do you has? This command will find out!");
			this.put("\nparty - find out who is stalking you!");
			this.put("\nlook - discover your surroundings! Tranquility awaits!");
			this.put("\nget - take things at will!");
			this.put("\ntalk - first class interactivity! Realtime AI functionality!");
			this.put("\nuse - try to use and abuse everything you meet!");
			if (GameState.inControl != "stlunko") {
				this.put("\ngo - don't be a brainy nerd! Leave your computer for once.");
			} else {
				this.put("\ngo - do not be a nerd! Leave your computer for once.");
			}
			this.put("\nhave [somebody] [something] - let them do the dirty work!");
			return (true);
		}
		if ((_loc2.contains("crystals")) && (_loc2.contains("cliche"))) {
			this.put("No, there are no Crystals of Clicheness here. However, if you were to find some, you would probably end up battling some evil gem boss, and you would probably end up learning that the true power is in yourself or something equally as dumb.");
			return (true);
		}
		if (_loc2.contains("pants")) {
			this.put("Your pants/shorts/long pants are as non-existant as Super Sam's.");
			return (true);
		}
		if (_loc2.contains("nyjole")) {
			this.put("Nyjole: \"I beat Super Sam's Super Secret game already. It lacked any easter eggs at all! Oh, wait- {static}\"");
			return (true);
		}
		/* if (_loc2.is("p")) {
		Game.scorePoints(3);
		return (true);
		} */ 
		if (_loc2.isStart("continute")) {
			if (_loc2.is("continute at virus")) {
				if (GameState.allowedToWarp) {
					warpVirus();
				} else {
					if (GameState.inControl != "stlunko") {
						this.put("Sorry, palbert. You're only allowed to CONTINUTE if it's the very first command you do - you'll have to DIE and restart.");
					} else {
						this.put("Sorry, palbert. You are only allowed to CONTINUTE if it is the very first command you do - you will have to DIE and restart.");
					}
				}
			} else {
				this.put("No continute for you. Go play the old fashioned way.");
			}
			return (true);
		}
		if (_loc2.contains("think")) {
			if ((GameState.discussion) && (!GameState.islandFlipped)) {
				this.put("Hmm... you think about where the secret lab is. Saargtsson said you had to flip off the lid of a perfectly square island. So that means it'd have to be in a place with a LAVA LAKE. But do you remember where the lava lakes are, and which one has a square island? If not, you better just ASK STLUNKO and not waste any more time.");
				return (true);
			} else {
				return (false);
			}
		}
		if (_loc2.isStart("ask stlunko")) {
			if ((GameState.discussion) && (!GameState.islandFlipped)) {
				askStlunko();
			} else {
				return (false);
			}
		}
		if (_loc2.isStart("ask brody")) {
			if ((GameState.discussion) && (!GameState.islandFlipped)) {
				this.put("Why him? He don't know much. STLUNKO is the smart one here.");
				return (true);
			} else {
				return (false);
			}
		}
		if (_loc2.isStart("ask joshua")) {
			if ((GameState.discussion) && (!GameState.islandFlipped)) {
				this.put("Why him? He don't know much. SUPER SAM is the smart one here.");
				return (true);
			} else {
				return (false);
			}
		}
		if (_loc2.contains("super sam")) {
			if (_loc2.isStart("ask super sam")) {
				if ((GameState.discussion) && (!GameState.islandFlipped)) {
					this.put("You ain't getting any info from him. Go suck a lemon.");
				} else {
					this.put("Yeah, he\'s pretty much the coolest.");
				}
			} else {
				if (GameState.inControl != "stlunko") {
					this.put("Yeah, he\'s pretty much the coolest.");
				} else {
					this.put("Yeah, he is pretty much the coolest.");
				}
			}
			return (true);
		}
		if (_loc2.is("get a job")) {
			if (GameState.inControl != "stlunko") {
				this.put("With today's economy and unemployment rates, coupled with your lack of experience in... well, everything, you'd be lucky to get a job at Jayden Productions.");
			} else {
				this.put("With today's economy and unemployment rates, coupled with your lack of experience in... well, everything, you would be lucky to get a job at Jayden Productions.");
			}
			return (true);
		}
		if (_loc2.is("dance")) {
			switch (Math.floor(Math.random()*3)) {
			case 0 :
				if (GameState.inControl != "stlunko") {
					this.put("You obviously can't dance. Try something else.");
				} else {
					this.put("You obviously cannot dance. Try something else.");
				}
				break;
			case 1 :
				this.put("That dance move made my stummy hurt. Keep try.");
				break;
			case 2 :
				if (GameState.inControl != "stlunko") {
					this.put("That's a stupid dance. Try something else.");
				} else {
					this.put("That is a stupid dance. Try something else.");
				}
				break;
			default :
				break;
			}
			return (true);
		}
		if (_loc2.isGoNS("dennis")) {
			this.put("You find some girl at a computer designing new versions of Trevor. Creepy.");
			return (true);
		}
		return (false);
	}
	function postShootBrody() {
		this.put("As you float around absent-mindedly contemplating on why you just shot your friend for no reason, you accidentally float right into a nearby lava flow along a wall. How convenient!");
		Game.die();
		return (true);
	}
	function look() {
		r = "hi";
	}
	function keyPressed(num) {
	}
	function displayItems() {
	}
	function hideItems() {
	}
	function put(stuff) {
		if (r.length>0) {
			r = r+" ";
		}
		r = r+stuff;
	}
	/*function postParse() {
	}*/
	function getName() {
		return ("");
	}
	function pressEnterCallback() {
		this.pressEnterCallbackFunc();
	}
	function undoCounter() {
	}
	function warpVirus() {
		GameState.seenGokul = true;
		GameState.gokulExplode = true;
		GameState.talkFrotzer = true;
		GameState.firstTimeSpikes = false;
		GameState.friendsChamber = false;
		GameState.seenShortcut = true;
		GameState.seenGokulFeed = true;
		GameState.gotHeadset = true;
		GameState.headsetUsed = true;
		GameState.vectorSteps = 5;
		GameState.congestion = false;
		GameState.doorState = "open";
		GameState.compyState = "virus";
		GameState.caledraEntrance = 1;
		GameState.brodyStatus = "party";
		GameState.stlunkoStatus = "party";
		GameState.lookedNorth = true;
		GameState.lookMicrowave = true;
		GameState.triedSwitch = true;
		GameState.gameMode = "virus";
		GameState.virusUpload = -5;
		GameState.allowedToWarp = false;
		GameState.score = 18;
		Game.scorePoints(3);
		GameState.continuing = true;
		Game.newRoom("spikes");
	}
	function askStlunko() {
		this.put("You ask Stlunko about the square island, and he says the only one he knows of is in the GOKUL FEEDING CHAMBER. Get going!");
		return (true);
	}
}
