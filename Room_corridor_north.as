class Room_corridor_north extends Room {
	var synonyms, put, superClassParse, firstTime, plop;
	function Room_corridor_north () {
		super();
		synonyms.push(new Array("cavein", "cave-in", "cave in", "rubble", "rocks"));
		synonyms.push(new Array("shoot", "attack", "challenge"));
		synonyms.push(new Array("control panel", "controls", "panel", "knob", "switch"));
		synonyms.push(new Array("punch", "hit", "bash"));
		synonyms.push(new Array("flip", "turn", "activate"));
	}
	function getName() {
		return ("Abandoned Lava Corridor");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.contains("cave-in")) {
			if (GameState.doorState != "open") {
				this.put("No, genius. It's on the other side of the door. Go take the long way around if you want to see it so badly.");
			} else {
				this.put("The wall of caved-in rocks is nothing but a small pile of rubble now.");
			}
			return;
		}
		if (_loc2.isEnd("door")) {
			if (GameState.doorState != "open") {
				if (_loc2.isLookAt("door")) {
					this.put("It's big, flat, and metalic. It has some of that yellow police tape stretching along it. It appears to be connected to that nearby open/close SWITCH. Maybe you should get it flipped?");
				} else if ((_loc2.isUse("door")) || (_loc2.isOpen("door"))) {
					this.put("You can't open it directly. Use the nearby SWITCH.");
				} else if ((_loc2.isShoot("door")) || ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && (_loc2.contains("punch")) && (_loc2.isEnd("door")))) {
					this.put("It's inpenetrable, your attacks ain't gonna fade it. This thing was clearly built to last. Try to use that open/close SWITCH, 'kay?");
				} else if ((_loc2.contains("knock")) && (_loc2.isEnd("door"))) {
					this.put("No. There is no way we're doing a crappy knock knock joke.");
				} else {
					DontUnderstand.parse(this);
				}
			} else {
				this.put("It's gone now. It slid up and is now part of the ceiling. Let's leave it there, shall we?");
			}
			return;
		}
		if (_loc2.isEnd("switch")) {
			if (GameState.doorState != "open") {
				if (_loc2.isLookAt("switch")) {
					this.put("It's a control panel clearly connected to the big door. All that's on it is that open/close switch, really. Nothing fancy.");
				} else if (_loc2.isShoot("switch")) {
					this.put("Those laser balls aren't the solution to everything, you trigger-happy freak. >_>");
				} else if ((_loc2.isUse("switch")) || ((_loc2.isStart("flip")) && (_loc2.isEnd("switch")))) {
					if (GameState.stlunkoStatus != "party") {
						this.put("You try. You really do. But your flabby pink sides just aren't good enough. You need someone with hands by your side, then you could HAVE him FLIP it.");
					} else {
						this.put("You need to HAVE STLUNKO FLIP SWITCH. Capeesh?");
					}
				} else if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && ((_loc2.contains("flip")) || (_loc2.contains("use"))) && (_loc2.isEnd("switch"))) {
					if (GameState.stlunkoStatus != "party") {
						this.put("You != Stlunko");
					} else {
						if (!GameState.triedSwitch) {
							if (GameState.doorState == "closed") {
								this.put("You give the order and Stlunko flips the switch to the open position. Slowly, with a very noisy grating sound, the DOOR rises open to allow access. Hooray, Stlunko can now get back to the main chambers of the Lava Zone! He confirms that this was the path he used to get here.");
								this.put("\n\nBrody enters from the south corridor and rejoins your party. Apparently he heard the door open and knew what was going on. Hooray, you three are reunited at last!");
								GameState.doorState = "open";
								GameState.brodyStatus = "party";
								GameState.brodyRoom = undefined;
								Game.scorePoints(1);
							} else {
								this.put("You give the order and Stlunko flips the switch to the open position. There is a large rumbling sound as the door begins to shake. But try as it might, the door can't open, and Stlunko eventually flips the switch back.");
								this.put("\n\n\"What's the matter?\" you ask.");
								this.put("\n\n\"Something is keeping the door down. I am pretty sure I heard a CAVE-IN on the other side after entering here, and it must be jamming the door. See if you can go around and break it off,\" he replies.");
								this.put("Sounds like another jorb! Go git 'er done!");
							}
							GameState.triedSwitch = true;
						} else {
							if (GameState.doorState == "hidden") {
								this.put("You tell Stlunko to try it again, but it still doesn't work. You'll have to go around and get rid of the CAVE-IN jamming the door on the other side");
							} else {
								this.put("The cave-in gone, you tell Stlunko to give it another try. He does so and slowly, with a very noisy grating sound, the DOOR rises open to allow access. Hooray, Stlunko can now get back to the main chambers of the Lava Zone! Isn't that great?");
								this.put("\n\nBrody enters from the south corridor and rejoins your party. Apparently he heard the door open and knew what was going on. Hooray, you three are reunited at last!");
								GameState.doorState = "open";
								GameState.brodyStatus = "party";
								GameState.brodyRoom = undefined;
								Game.scorePoints(1);
							}
						}
					}
				} else {
					DontUnderstand.parse(this);
				}
			} else {
				this.put("The switch has done its job. Now let it be.");
			}
			return;
		}
		if (_loc2.isLookAt("north")) {
			this.put("It'll take you to that vast caldera you seem to love so much.");
			return;
		}
		if (_loc2.isGo("north")) {
			GameState.exitingRoom = "corridor";
			Game.newRoom("lavalake");
			return;
		}
		if (_loc2.isLookAt("south")) {
			if (GameState.doorState != "open") {
				this.put("There's a big DOOR stopping you from going that way. It can only be opened with that open/close SWITCH.");
			} else {
				this.put("It's clear all the way to the minion-filled passageways!");
			}
			return;
		}
		if (_loc2.isGo("south")) {
			if (GameState.doorState != "open") {
				this.put("There's a big DOOR stopping you from going that way. That's too bad.");
			} else {
				Game.newRoom("crossroads");
			}
			return;
		}
		if (this.superClassParse()) {
			return;
		}			
		DontUnderstand.parse(this);
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.doorState != "open") {
				this.put("You go down the sole westward corridor. It turns south and you notice that it looks real worn down and old. You keep on going until you reach a rock solid DOOR completely blocking the path SOUTH. Although it's perfectly smooth, you can see a small control panel nearby, which pretty much consists of an open/close SWITCH. The way back to the caldera is NORTH.");
			} else {
				this.put("You carefully walk through the abandoned passageway and hope the ceiling doesn't cave in on you. The path is mostly nondescript now, besides the currently unneeded open/close switch for the opened door. From this point you can go NORTH and then east to the large caldera, or SOUTH and then east to the familiar minion-filled passageways.");
			}
			firstTime = false;
		} else {
			if (GameState.doorState != "open") {
				this.put("You're in an old abandoned passageway. The path going south has ended at a large metal DOOR with an open/close SWITCH that needs flipping. You can still go back NORTH to get to the vast caldera.");
			} else {
				this.put("You are floating in the middle of the nondescript path between the main passageways and a large caldera. The roof is unstable so try not to make any loud noises. Going NORTH will take you to the caldera while SOUTH leads to the minion-filled passageways.");
			}
		}
		return;
	}
}