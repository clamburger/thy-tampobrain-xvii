class Room_corridor_south extends Room {
	var synonyms, put, superClassParse, firstTime, plop;
	function Room_corridor_south () {
		super();
		synonyms.push(new Array("wall", "cavein", "cave-in", "cave in", "rubble", "rocks"));
		synonyms.push(new Array("shoot", "attack", "challenge"));
		synonyms.push(new Array("switch", "control panel", "controls", "panel", "knob"));
	}
	function getName() {
		return ("Abandoned Lava Corridor");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("south")) {
			this.put("It leads back to the minion-filled main passageways of the Lava Zone.");
			return;
		}
		if (_loc2.isGo("south")) {
			Game.newRoom("crossroads");
		}
		if (_loc2.isLookAt("north")) {
			if (GameState.doorState == "hidden") {
				this.put("A big WALL of caved-in rubble is blocking your way north.");
			} else if (GameState.doorState == "closed") {
				this.put("Now there's a big DOOR stopping you from going that way, and there's no visible way to open it from here.");
			} else {
				this.put("The path is clear and leads right to the vast caldera.");
			}
			return;
		}
		if (_loc2.isGo("north")) {
			if (GameState.doorState == "hidden") {
				this.put("A big WALL of caved-in rubble is blocking your way north.");
			} else if (GameState.doorState == "closed") {
				this.put("Now there's a big DOOR stopping you from going that way, and there's no visible way to open it from here.");
			} else {
				GameState.exitingRoom = "corridor";
				Game.newRoom("lavalake");
			}
			return;
		}
		if (_loc2.isEnd("cavein")) {
			if (GameState.doorState == "hidden") {
				//if (_loc2.isLookAt("wall")) {
				if (_loc2.isLookAt("cavein")) {
					this.put("It actually looks like yet another of those pesky little cave-ins. You know, like a bunch of rocks tumpled into a pile completely obstructing the way forward. They sure are inconveniant! How will you get past this one? You obviously need to. Maybe a laser ball ZAP will do the trick...");
				} else if (_loc2.isUse("cavein")) {
					this.put("I think you've got this confused. You need to use an attack on the wall. Yeah.");
				} else if (_loc2.isShoot("cavein")) {
 					this.put("You zap the wall with a fully charged laser ball, but it barely effects it at all. It's going to need a more physical attack such as a KICK to come a-tumbling down.");
				} else if (_loc2.isKick("cavein")) {
					this.put("Don't get ahead of yourself, you legless blob. If only you had a bipedal friend with you, you could HAVE him KICK the wall.");
				//} else if (((_loc2.isStart("make")) || (_loc2.isStart("get")) || (_loc2.isStart("tell")) || (_loc2.isStart("have"))) && (_loc2.contains("brody")) && (_loc2.contains("kick")) && ((_loc2.isEnd("wall")))) {
				} else if ( (_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && (_loc2.contains("kick")) && (_loc2.isEnd("cavein")) ) {
					if (GameState.brodyStatus != "party") {
						this.put("What are you, some crap-for-brains? You have to get Brody first.");
					} else {
						this.put("You give the command and Brody then gives the cave-in a solid kick in the grill. It crumples down into rubble at his feet. The path is clear of boulders! Whee...\n\nUnfortunately there appears to be a big metal door clogging the path, with no apparent way to open or activate. Looks like you\'re still stuck. Nothing you can do from this end anymore.");
						Game.scorePoints(1);
						GameState.doorState = "closed";
					}
				} else {
					DontUnderstand.parse(this);
					return(false);
				}
			} else {
				this.put("The wall of caved-in rocks is nothing but a small pile of rubble now.");
			}
			return;
		}
		if (_loc2.isEnd("door")) {
			if (GameState.doorState == "hidden") {
				DontUnderstand.parse(this);
			} else if (GameState.doorState == "closed") {
				if (_loc2.isLookAt("door")) {
					this.put("It's big, flat, and metalic. It has some of that yellow police tape stretching along it. There's no visible knob or control panel or anything, so you aren't getting past it at the moment.");
				} else if ((_loc2.isUse("door")) || (_loc2.isOpen("door"))) {
					this.put("No can do.");
				//} else if ((_loc2.isShoot("door")) || ((_loc2.isStart("make")) || (_loc2.isStart("get")) || (_loc2.isStart("tell")) || (_loc2.isStart("have"))) && (_loc2.contains("brody")) && (!_loc2.isEnd("brody")) && (_loc2.isEnd("kick door"))) {
				} else if ((_loc2.isShoot("door")) || ((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && (_loc2.contains("kick")) && (_loc2.isEnd("door")))) {
					this.put("It\'s inpenetrable, and your attacks ain\'t gonna fade it. Probably a good thing too, as it appears to be a load-bearing door.");
				} else if ((_loc2.contains("knock")) && (_loc2.isEnd("door"))) {
					this.put("No. There is no way we're doing a crappy knock knock joke.");
				} else {
					DontUnderstand.parse(this);
				}
			} else if (GameState.doorState == "open") {
				this.put("It's gone now. It slid up and is now part of the ceiling. Let's leave it there, shall we?");
			}
			return;
		}
		if (_loc2.contains("control panel")) {
			if (GameState.doorState != "open") {
				this.put("There doesn't appear to be any here. At least not that you can see.");
			} else {
				this.put("The switch has done its job. Now let it be.");
			}
			return;
		}
		if (this.superClassParse()) {
			return;
		}			
		
		//if (parse != true) {
			DontUnderstand.parse(this);
		//} else {
		//	plop = false;
		//}
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.doorState == "hidden") {
				this.put("You go down the lonely vacant passageway. You quickly realise that it\'s one of the older weaker lava tunnels that have actually been closed off. You continue anyway, and make a northward turn, but then you float right into a WALL. There\'s no other paths, except the way back SOUTH and then east.");
			} else if (GameState.doorState == "closed") {
				this.put("You go down the empty passwageway that\'s supposed to be closed off due to age and misuse. Ignoring the warning signs, you keep on going until you reach a DOOR. You still can\'t see a way to open it from here though.");
			} else {
				this.put("You carefully walk through the abandoned passageway and hope the ceiling doesn\'t cave in on you. The path is mostly nondescript now. From this point, you can go NORTH to the lake of lava, or SOUTH to the familiar minion-filled passageways.");
			}
			firstTime = false;
		} else {
			if (GameState.doorState == "hidden") {
				this.put("You're in an old abandoned passageway. The path going north has ended abruptly with a WALL. The only way out is back SOUTH and then east.");
			} else if (GameState.doorState == "closed") {
				this.put("You're in an old abandoned passageway. There is some rubble on the ground from the cave-in. A knobless, panelless DOOR blocks your path onward north. The path SOUTH is currently your only way out.");
			} else {
				this.put("You are floating in the middle of the nondescript path between the main passageways and a large caldera. The roof is unstable so try not to make any loud noises. Going NORTH will take you to the caldera while SOUTH leads to the minion-filled passageways.");
			}
		}
		return;
	}
}