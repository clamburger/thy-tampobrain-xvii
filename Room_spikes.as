class Room_spikes extends Room {
	var synonyms, put, superClassParse, pressEnterCallbackFunc, firstTime, temptingFate;
	function Room_spikes() {
		super();
		Game.input_mc.input.text = "";
		//GameState.friendsChamber = true;
		synonyms.push(new Array("saargtscreen", "saargtscreen ii", "saargtscreen 2", "saargtscreen", "screen", "computer", "compy"));
		synonyms.push(new Array("microwave", "microwave oven", "oven"));
		//synonyms.push(new Array("guts", "gokul guts", "mess"));
		//synonyms.push(new Array("shoot", "fire", "zap"));
		//synonyms.push(new Array("laserball", "laserballs", "laser beam", "laser", "energy", "electricity"));
		synonyms.push(new Array("circuits", "exposed circuits", "circuit panel", "circuit", "curcuits", "wires"));
		//synonyms.push(new Array("lava flow", "lava", "magma", "magma flow"));
		synonyms.push(new Array("switch", "on switch"));
		synonyms.push(new Array("email", "e-mail"));
		//synonyms.push(new Array("get", "grab", "take"));
		synonyms.push(new Array("talk", "speak"));
		synonyms.push(new Array("clean", "wash"));
		//synonyms.push(new Array("stones", "floor", "rocks", "ceiling"));
		synonyms.push(new Array("wall", "walls"));
		synonyms.push(new Array("saargtsson", "snake"));
		synonyms.push(new Array("turn on", "activate"));
		synonyms.push(new Array("go", "walk", "float"));
		synonyms.push(new Array("north", "tunnel", "lava tunnel"));
		synonyms.push(new Array("shut down", "turn off"));
		if (GameState.gokulExplode) {
			synonyms.push(new Array("gokul", "guts", "gokul guts", "mess"));
		}
		synonyms.push(new Array("fix", "repair"));
	}
	function getName() {
		return ("Personal Chamber");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (GameState.gameMode == "regular") {
			if ((_loc2.isLookAt("compy")) || ((_loc2.isStart("examine")) && (_loc2.isEnd("compy")))) {
				if (GameState.compyState == "off") {
					this.put("It\'s your not-quite-brand new SaargtScreen II! You know, that thing with the MICROWAVE. And the computer. Together for some reason.");
					if (GameState.clean) {
						this.put("The computer half is deactiveted right now. It needs its ON SWITCH flipped.");
						this.put("The microwave half is currently turned on. It has some fried circuits, but at least it's squeaky clean!");
					} else if (GameState.gokulExplode) {
						this.put("The computer half is deactivated right now. It needs its ON SWITCH flipped.");
						this.put("The microwave half is currently turned on and is messy with GOKUL GUTS. Eww.");
					} else if (GameState.seenGokul) {
						this.put("It appears entirely deactivated right now. It needs its ON SWITCH flipped.");
						this.put("There is a GOKUL in the microwave for some raisin.");
					} else {
						this.put("It appears entirely deactivated right now. It needs its ON SWITCH flipped.");
					}
				} else if ((GameState.compyState == "untried") || (GameState.compyState == "tried")) {
					this.put("It\'s your not-quite-brand new SaargtScreen II! You know, that thing with the MICROWAVE. And the computer. Together for some reason. It\'s been turned on, and the screen is currently blank with nothing but a bare C:\\>.");
					if (GameState.clean) {
						this.put("The microwave half is sorta fried. At least it\'s squeaky clean!");
					} else if (GameState.gokulExplode) {
						this.put("The microwave half is currently turned on and is messy with GOKUL GUTS. Eww.");
					} else if (GameState.seenGokul) {
						this.put("There is a GOKUL in the microwave for some raisin.");
					}
				}
				return;
			}
			if ((((_loc2.isStart("use")) || (_loc2.isStart("turn on"))) && (_loc2.isEnd("compy"))) || (((_loc2.isStart("use")) || (_loc2.isStart("flip"))) && (_loc2.isEnd("switch"))) || (((_loc2.contains("brody")) || (_loc2.contains("stlunko"))) && ((_loc2.contains("turn on") && (_loc2.isEnd("compy"))) || (((_loc2.contains("use")) || (_loc2.contains("flip"))) && (_loc2.isEnd("switch")))))) {
				if (_loc2.contains("stlunko")) {
					this.put("No. Get STLUNKO over here first.");
				} else {
					if (GameState.brodyStatus != "party") {
						if (((_loc2.isStart("use")) || (_loc2.isStart("turn on"))) && (_loc2.isEnd("compy"))) {
							this.put("You go over to the deactivated computer and attempt to flip the ON SWITCH. It is too small and stiff. Your flabby pink sides can't bring up enough force to flip it. Looks like you'll be needing help from BRODY or STLUNKO and their stupid hands.");
						} else if (((_loc2.isStart("use")) || (_loc2.isStart("flip"))) && (_loc2.isEnd("switch"))) {
							this.put("You need hands, dangit!");
						} else if (_loc2.contains("brody")) {
							this.put("No. Get BRODY over here first.");
						}
					} else {
						if (GameState.compyState == "off") {
							if (_loc2.contains("brody")) {
								this.put("You tell Brody that you need help flipping the on switch to activate the computer, and he does so with one of his wings. In a few minutes, the SaargtScreen II is all booted up with the text C:\\>.");
								Game.scorePoints(1);
								GameState.compyState = "untried";
							} else {
								if (GameState.stlunkoStatus != "party") {
									this.put("That isn't a task for the hand-less. You'll have to get BRODY to do it for you.");
								} else {
									this.put("That isn't a task for the hand-less. You'll have to get BRODY or STLUNKO to do it for you.");
								}
							}
						} else {
							if (_loc2.contains("turn on")) {
								this.put("It\'s already on, stupid.");
							} else if (_loc2.isEnd("switch")) {
								if ((_loc2.contains("brody")) || (_loc2.contains("stlunko"))) {
									DontUnderstand.parse(this);
								} else {
									this.put("Not a good idea. It\'s much safer to SHUT DOWN the computer first.");
								}
							} else if ((_loc2.isStart("use")) && (_loc2.isEnd("compy"))) {
								this.put("You can use a computer for lots of things. Try a more specific function.");
							}
						}
					}
				}
				return;
			}
			if (_loc2.isLookAt("switch")) {
				if (GameState.brodyStatus != "party") {
					this.put("Stupid switches. Why can\'t you have big red buttons? Big red buttons are pushable!");
				} else {
					this.put("With Brody by your side, these switches have no more authority over you!");
				}
				return;
			}
			if ((_loc2.isLookAt("email")) || (((_loc2.isStart("check")) || (_loc2.isStart("turn on")) || (_loc2.isStart("use"))) && (_loc2.isEnd("email"))) || ((_loc2.isStart("input")) && (_loc2.isEnd("code"))) || ((_loc2.contains("brody")) && (_loc2.contains("check")) && (_loc2.contains("email")))) {
				if (GameState.brodyStatus != "party") {
					this.put("You stare at the blank screen. Turns out the computer needs to be on.");
				} else {
					if (_loc2.isLookAt("email")) {
						if (GameState.compyState == "off") {
							this.put("The screen is blank - Brody will have to flick the ON SWITCH in order to turn it on.");
						} else if (GameState.compyState == "untried") {
							this.put("There\'s no email on the computer to look at. The message C:\\> tells you that you need to have Brody INPUT a CODE. You want to check an email!");
						} else if (GameState.compyState == "tried") {
							this.put("There\'s no email on the computer to look at. You\'ll have to find Stlunko and get him to install your email program.");
						}
					} else {
						if (GameState.compyState == "off") {
							this.put("Brody types some stuff on the keyboard, but to no avail. Apparently, computers need to be turned on in order to work.");
						} else if (GameState.compyState == "untried") {
							this.put("\"Alright, Brody. Let\'s see if we can check-a some email,\" you say to your friend. He goes to the keyboard and enters in the familiar command, but gets an unfamiliar response.");
							this.put("\n\nC:\\>RUN tampo_email.exe\nBad command or file name.");
							this.put("\n\nC:\\>");
							pressEnterCallbackFunc = postCompy;
							Game.addPause();
						} else if (GameState.compyState == "tried") {
							this.put("Your normal command doesn\'t work. You\'re gonna need your more technical buddy STLUNKO.");
						}
					}
				}
				return;
			}
			if ((_loc2.isTake("compy")) || ((_loc2.isStart("absorb")) && (_loc2.isEnd("compy")))) {
				this.put("It\'s nearly as big as you are and firmly stuck in the ground. You sit on it anyway but you can\'t absorb it very well.");
				return;
			}
			if (_loc2.isLookAt("microwave")) {
				if (!GameState.gokulExplode) {
					if (!GameState.talkPoorbt) {
						if (!GameState.lookMicrowave) {
							this.put("The door is closed and it isn't cooking. It has some exposed CIRCUITS that are obviously asking for a challenge. What the-- Is that a GOKUL in there?! How the crap did that thing trap itself in your microwave? You\'ll have to activate the microwave to get the door open.");
						} else {
							this.put("The door is closed and it isn’t cooking. There appears to be a GOKUL trapped inside, and he wants to get out. It has BUTTONS, but they are too small for you to use. To the side there is a break in the outer casing revealing some CIRCUITS underneath.");
						}
					} else {
						if (!GameState.lookMicrowave) {
							this.put("The door is closed and it isn't cooking. It has some exposed CIRCUITS that are obviously asking for a challenge. What the-- Is that a GOKUL in there?! It must be the brother of that Gokul you saw in the Gokul Feeding Chamber! Can you rescue him? To open the door, you'll have to activate the microwave...");
						} else {
							this.put("The door is closed and it isn’t cooking. There appears to be a GOKUL trapped inside, who has friends waiting for him in the Gokul Feeding Chamber. It has BUTTONS, but they are too small for you to use. To the side there is a break in the outer casing revealing some CIRCUITS underneath.");
						}
					}
					GameState.seenGokul = true;
				} else if (!GameState.clean) {
					this.put("The microwave door is wide open and there are plenty of Gokul guts splattered inside. Whoopee.");
				} else {
					this.put("Sparkly clean!");
				}
				GameState.lookMicrowave = true;
				return;
			}
			if (((_loc2.isStart("use")) || (_loc2.isStart("activate")) || (_loc2.isStart("turn on"))) && (_loc2.isEnd("microwave"))) {
				if (!GameState.seenGokul) {
					this.put("Microwave? How does one know about a microwave if you have not yet seen one?");
				} else if (GameState.brodyStatus != "party") {
					this.put("The buttons are much too small for you to push. Meh.");
				} else {
					this.put("It doesn\'t seem to work with those wires all burnt out. I wouldn\'t worry about it.");
				}
				return;
			}
			if (_loc2.isLookAt("circuits")) {
				if (!GameState.seenGokul) {
					this.put("You seem to have misplaced your circuits. What sort of APPLIANCE would have circuits?");
				} else if (!GameState.gokulExplode) {
					this.put("Looks like someone left the circuit panel open. Lots of wires are visible and are just asking to be ZAPPED.");
				} else {
					this.put("They look all zapped out. Stlunko will probably have to do some minor repairs.");
				}
				return;
			}
			if (((_loc2.isStart("shoot")) && (_loc2.isEnd("circuits"))) || ((_loc2.isStart("use laserball")) && (_loc2.isEnd("circuits")))) {
				if (!GameState.seenGokul) {
					this.put("How are you supposed to zap the circuts if you haven\'t even seen them?");
				} else if (!GameState.gokulExplode) {
					this.put("You fire a laserball at the exposed circuits, hoping to activate the microwave and open the door. Freedom to the Gokul! The electricity fizzles around amoungst the wires and suddenly the microwave half of the SaargtsScreen II activates. But to your horror, rather than the door popping open, the microwave timer sets itself to 15 seconds and starts cooking the poor squealing thing.");
					pressEnterCallbackFunc = postGokulOne;
					Game.addPause();
				} else {
					this.put("Nah. Once is enough.");
				}
				return;
			}
			if (_loc2.isStart("clean")) {
				if (GameState.brodyStatus != "party") {
					if ((GameState.gokulExplode) && (_loc2.isEnd("cornea"))) {
						this.put("Heck no at all.");
					} else if (GameState.gokulExplode) {
						this.put("With what? Your cornea?");
					} else if (GameState.seenGokul) {
						this.put("This room is perfectly clean, apart from the GOKUL in the MICROWAVE, which you should probably get out.");
					} else {
						this.put("This room is perfectly clean. Saargtsson will probably give you a clean up job soon anyway.");
					}
				} else {
					if ((GameState.gokulExplode) && (_loc2.isEnd("cornea"))) {
						this.put("Heck no at all. Use your nice helpful friend's cornea.");
					} else if (GameState.clean) {
						this.put("There\'s nothing left to clean.");
					} else if (GameState.gokulExplode) {
						this.put("Well, you can\'t. But maybe a nice helpful friend of yours can... HAVE him CLEAN it.");
					} else if (GameState.seenGokul) {
						this.put("This room is perfectly clean, apart from the GOKUL in the MICROWAVE, which you should probably get out.");
					} else {
						this.put("This room is perfectly clean. Saargtsson will probably give you a clean up job soon anyway.");
					}
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && (_loc2.contains("clean")) && ((_loc2.isEnd("microwave")) || (_loc2.isEnd("guts")))) {
				if (!GameState.clean) {
					this.put("You tell Brody what happened and order him to clean it. He releases a small mumble, but otherwise follows your order faithfully. He produces a large napkin from... somewhere... and cleans it all up. Yay, your room is now sparkly clean! You won\'t have to worry about Saargtsson whining about it anytime soon. Bonus point for you.");
					Game.scorePoints(1);
					GameState.clean = true;
				} else {
					this.put("There\'s nothing left to clean.");
				}
				return;
			}
			if ((_loc2.isStart("clean")) && (_loc2.isEnd("cornea"))) {
				this.put("Heck no at all!");
			}
			if ((_loc2.isStart("talk")) && ((_loc2.isEnd("compy")) || (_loc2.isEnd("microwave")))) {
				this.put("That\'s just sad.");
				return;
			}
			if ((_loc2.isGo("south")) || (_loc2.is("leave south"))) {
				Game.newRoom("crossroads");
				GameState.friendsChamber = false;
			}
			if /*(*/ (_loc2.isGo("north")) {
				/* || ((_loc2.isStart("head")) && (_loc2.isEnd("north")))) */
				if (GameState.lookedNorth) {
					if (GameState.gokulExplode) {
						GameState.friendsChamber = false;
						GameState.exitingRoom = "spikes";
						if (GameState.brodyStatus == "party") {
							GameState.brodyRoom = "spikes";
						}
						Game.newRoom("lavalake");
					} else {
						this.put("You float into the lava tunnel, wondering where it could lead. Unfortunately the intense heat of the nearby lava causes you to pass out. They never find your body.");
						Game.die();
					}
				} else {
					this.put("Err... there's no real exits in that direction. Actually, there is the tunnel that the lava's flowing out of. It's big enough for you to go through, but it looks very hot in there. Do you really think you should go in?");
					GameState.lookedNorth = true;
				}
				return;
			}
			if (_loc2.isLookAt("appliance")) {
				this.put("The only appliance here is your computer, the SAARGTSCREEN II.");
				return;
			}
			if ((_loc2.isStart("shut down")) && (_loc2.isEnd("compy"))) {
				if (GameState.compyState == "off") {
					this.put("Getting a bit ahead of yourself, don't you think? Turn it on first.");
				} else {
					if (temptingFate == undefined) {
						this.put("It took you long enough to turn it on. Are you sure you want to turn off your computer?");
						temptingFate = 1;
					} else if (temptingFate == 1) {
						this.put("No seriously, don\'t. You\'ll just be wasting everyone\'s time.");
						temptingFate = 2;
					} else if (temptingFate == 2) {
						this.put("Oh, fine. Since you are so desperate to turn off your computer, you ram the screen as hard as you can several times, knocking off bits of your brainy self. You are slightly dumber. And slightly less alive.");
						Game.die();
					}
				}
				return;
			}
		} else if (GameState.gameMode == "email") {
			if ((_loc2.isGo("south")) || (_loc2.isGo("north"))) {
				this.put("Don't leave right now. It's finally time to check your email!");
				return;
			}
			if (_loc2.isLookAt("bomb")) {
				this.put("It's sitting there by the computer, plugged in with some wires. Who knows what Stlunko plans to do with it.");
				return;
			}
			if ((_loc2.isUse("bomb")) || (_loc2.isShoot("bomb")) || (_loc2.isGet("bomb")) || (_loc2.is("get bomb"))) {
				this.put("Leave it alone, Stlunko wouldn't like you messing with it.");
				return;
			}
			if ((((_loc2.isStart("use")) || (_loc2.isStart("turn on"))) && (_loc2.isEnd("compy"))) || (((_loc2.isStart("use")) || (_loc2.isStart("flip"))) && (_loc2.isEnd("switch"))) || (((_loc2.contains("brody")) || (_loc2.contains("stlunko"))) && ((_loc2.contains("turn on") && (_loc2.isEnd("compy"))) || (((_loc2.contains("use")) || (_loc2.contains("flip"))) && (_loc2.isEnd("switch")))))) {
				if (GameState.compyState == "off") {
					if (_loc2.contains("brody")) {
						this.put("You tell Brody that you need help flipping the on switch to activate the computer, and he does so with one of his wings. In a few minutes, the SaargtScreen II is all booted up with the text C:\\>.");
						Game.scorePoints(1);
						GameState.compyState = "untried";
					} else if (_loc2.contains("stlunko")) {
						this.put("You tell Stlunko to go ahead and boot up the computer, and he obeys by flipping the switch. In a few minutes, the SaargtScreen II is all booted up with the text C:\\>.");
						Game.scorePoints(1);
						GameState.compyState = "untried";
					} else {
						if (GameState.stlunkoStatus != "party") {
							this.put("That isn't a task for the hand-less. You'll have to get BRODY to do it for you.");
						} else {
							this.put("That isn't a task for the hand-less. You'll have to get BRODY or STLUNKO to do it for you.");
						}
					}
				} else {
					if (_loc2.contains("turn on")) {
						this.put("It\'s already on, stupid.");
					} else if (_loc2.isEnd("switch")) {
						if ((_loc2.contains("brody")) || (_loc2.contains("stlunko"))) {
							DontUnderstand.parse(this);
						} else {
							this.put("Not a good idea. It\'s much safer to SHUT DOWN the computer first.");
						}
					} else if ((_loc2.isStart("use")) && (_loc2.isEnd("compy"))) {
						this.put("You can use a computer for lots of things. Try a more specific function.");
					}
				}
				return;
			}
			if (_loc2.isLookAt("switch")) {
				this.put("With Brody and Stlunko by your side, these switches have no more authority over you!");
				return;
			}
			if (_loc2.isLookAt("email")) {
				if (GameState.compyState == "off") {
					this.put("You, Brody and Stlunko just stare at the blank screen. Turns out it needs to be on.");
				} else {
					this.put("There's no email on the computer to look at. The message C:\> tells you that you need to have Stlunko INPUT a CODE. Like, right now.");
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && (_loc2.contains("fix")) && ((_loc2.isEnd("wires")) || (_loc2.isEnd("microwave")))) {
				this.put("He doesn't want to at the moment.");
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && (_loc2.contains("clean")) && ((_loc2.isEnd("microwave")) || (_loc2.isEnd("guts")))) {
				if (!GameState.clean) {
					this.put("Nah, you don't need to make Stlunko do that. Why don't you HAVE BRODY do it instead? He has more free time on his hands.");
				} else {
					this.put("There\'s nothing left to clean.");
				}
				return;
			}
			if ((((_loc2.isStart("check")) || (_loc2.isStart("turn on")) || (_loc2.isStart("use"))) && (_loc2.isEnd("email"))) || ((_loc2.isStart("input")) && (_loc2.isEnd("code"))) || (((_loc2.contains("brody")) || (_loc2.contains("stlunko"))) && (_loc2.contains("check")) && (_loc2.contains("email")))) {
				if (_loc2.contains("brody")) {
					this.put("Let STLUNKO do it - he's the computer guy.");
				} else {
					if (GameState.compyState == "off") {
						this.put("Stlunko types some stuff on the keyboard, but to no avail. Apparently, computers need to be turned on in order to work.");
					} else {
						this.put("\"Alright, Stlunko. It's time to check that email!\" you shout.");
						this.put("\n\nAs Stlunko begins to do all the nessecary typing, you do your email rap.");
						this.put("\n\n\"Tampo Emails are finally back in action, so let's check it with all satisfaction!\" You think you're so cool, but you're not.");
						this.put("\n\nAs your email rap ends, Stlunko finishes typing the last command. All he has to do now is...");
						Game.scorePoints(3);
						pressEnterCallbackFunc = postEmailOne;
						Game.addPause();
					}
				}
				return;
			}
			if ((_loc2.isLookAt("compy")) || ((_loc2.isStart("examine")) && (_loc2.isEnd("compy")))) {
				if (GameState.compyState == "off") {
					this.put("It\'s your not-quite-brand new SaargtScreen II! You know, that thing with the MICROWAVE. And the computer. Together for some reason.");
					if (GameState.clean) {
						this.put("The computer half is deactiveted right now. It needs its ON SWITCH flipped.");
						this.put("The microwave half is currently turned on. It has some fried circuits, but at least it's squeaky clean!");
					} else if (GameState.gokulExplode) {
						this.put("The computer half is deactivated right now. It needs its ON SWITCH flipped.");
						this.put("The microwave half is currently turned on and is messy with GOKUL GUTS. Eww.");
					} else if (GameState.seenGokul) {
						this.put("It appears entirely deactivated right now. It needs its ON SWITCH flipped.");
						this.put("There is a GOKUL in the microwave for some raisin.");
					} else {
						this.put("It appears entirely deactivated right now. It needs its ON SWITCH flipped.");
					}
				} else if ((GameState.compyState == "untried") || (GameState.compyState == "tried")) {
					this.put("It\'s your not-quite-brand new SaargtScreen II! You know, that thing with the MICROWAVE. And the computer. Together for some reason. It\'s been turned on, and the screen is currently blank with nothing but a bare C:\\>.");
					if (GameState.clean) {
						this.put("The microwave half is sorta fried. At least it\'s squeaky clean!");
					} else if (GameState.gokulExplode) {
						this.put("The microwave half is currently turned on and is messy with GOKUL GUTS. Eww.");
					} else if (GameState.seenGokul) {
						this.put("There is a GOKUL in the microwave for some raisin.");
					}
				}
				return;
			}
			if ((_loc2.isTake("compy")) || ((_loc2.isStart("absorb")) && (_loc2.isEnd("compy")))) {
				this.put("It\'s nearly as big as you are and firmly stuck in the ground. You sit on it anyway but you can\'t absorb it very well.");
				return;
			}
			if (_loc2.isLookAt("microwave")) {
				if (!GameState.gokulExplode) {
					if (!GameState.talkPoorbt) {
						if (!GameState.lookMicrowave) {
							this.put("The door is closed and it isn't cooking. It has some exposed CIRCUITS that are obviously asking for a challenge. What the-- Is that a GOKUL in there?! How the crap did that thing trap itself in your microwave? You\'ll have to activate the microwave to get the door open.");
						} else {
							this.put("The door is closed and it isn’t cooking. There appears to be a GOKUL trapped inside, and he wants to get out. It has BUTTONS, but they are too small for you to use. To the side there is a break in the outer casing revealing some CIRCUITS underneath.");
						}
					} else {
						if (!GameState.lookMicrowave) {
							this.put("The door is closed and it isn't cooking. It has some exposed CIRCUITS that are obviously asking for a challenge. What the-- Is that a GOKUL in there?! It must be the brother of that Gokul you saw in the Gokul Feeding Chamber! Can you rescue him? To open the door, you'll have to activate the microwave...");
						} else {
							this.put("The door is closed and it isn’t cooking. There appears to be a GOKUL trapped inside, who has friends waiting for him in the Gokul Feeding Chamber. It has BUTTONS, but they are too small for you to use. To the side there is a break in the outer casing revealing some CIRCUITS underneath.");
						}
					}
					GameState.seenGokul = true;
				} else if (!GameState.clean) {
					this.put("The microwave door is wide open and there are plenty of Gokul guts splattered inside. Whoopee.");
				} else {
					this.put("Sparkly clean!");
				}
				GameState.lookMicrowave = true;
				return;
			}
			if (((_loc2.isStart("use")) || (_loc2.isStart("activate")) || (_loc2.isStart("turn on"))) && (_loc2.isEnd("microwave"))) {
				if (!GameState.seenGokul) {
					this.put("Microwave? How does one know about a microwave if you have not yet seen one?");
				} else if (GameState.brodyStatus != "party") {
					this.put("The buttons are much too small for you to push. Meh.");
				} else {
					this.put("It doesn\'t seem to work with those wires all burnt out. I wouldn\'t worry about it.");
				}
				return;
			}
			if (_loc2.isLookAt("circuits")) {
				if (!GameState.seenGokul) {
					this.put("You seem to have misplaced your circuits. What sort of APPLIANCE would have circuits?");
				} else if (!GameState.gokulExplode) {
					this.put("Looks like someone left the circuit panel open. Lots of wires are visible and are just asking to be ZAPPED.");
				} else {
					this.put("They look all zapped out. Stlunko will probably have to do some minor repairs.");
				}
				return;
			}
			if (((_loc2.isStart("shoot")) && (_loc2.isEnd("circuits"))) || ((_loc2.isStart("use laserball")) && (_loc2.isEnd("circuits")))) {
				if (!GameState.seenGokul) {
					this.put("How are you supposed to zap the circuts if you haven\'t even seen them?");
				} else if (!GameState.gokulExplode) {
					this.put("You fire a laserball at the exposed circuits, hoping to activate the microwave and open the door. Freedom to the Gokul! The electricity fizzles around amoungst the wires and suddenly the microwave half of the SaargtsScreen II activates. But to your horror, rather than the door popping open, the microwave timer sets itself to 15 seconds and starts cooking the poor squealing thing.");
					pressEnterCallbackFunc = postGokulOne;
					Game.addPause();
				} else {
					this.put("Nah. Once is enough.");
				}
				return;
			}
			if (_loc2.isStart("clean")) {
				if (GameState.brodyStatus != "party") {
					if ((GameState.gokulExplode) && (_loc2.isEnd("cornea"))) {
						this.put("Heck no at all.");
					} else if (GameState.gokulExplode) {
						this.put("With what? Your cornea?");
					} else if (GameState.seenGokul) {
						this.put("This room is perfectly clean, apart from the GOKUL in the MICROWAVE, which you should probably get out.");
					} else {
						this.put("This room is perfectly clean. Saargtsson will probably give you a clean up job soon anyway.");
					}
				} else {
					if ((GameState.gokulExplode) && (_loc2.isEnd("cornea"))) {
						this.put("Heck no at all. Use your nice helpful friend's cornea.");
					} else if (GameState.clean) {
						this.put("There\'s nothing left to clean.");
					} else if (GameState.gokulExplode) {
						this.put("Well, you can\'t. But maybe a nice helpful friend of yours can... HAVE him CLEAN it.");
					} else if (GameState.seenGokul) {
						this.put("This room is perfectly clean, apart from the GOKUL in the MICROWAVE, which you should probably get out.");
					} else {
						this.put("This room is perfectly clean. Saargtsson will probably give you a clean up job soon anyway.");
					}
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && (_loc2.contains("clean")) && ((_loc2.isEnd("microwave")) || (_loc2.isEnd("guts")))) {
				if (!GameState.clean) {
					this.put("You tell Brody what happened and order him to clean it. He releases a small mumble, but otherwise follows your order faithfully. He produces a large napkin from... somewhere... and cleans it all up. Yay, your room is now sparkly clean! You won\'t have to worry about Saargtsson whining about it anytime soon. Bonus point for you.");
					Game.scorePoints(1);
					GameState.clean = true;
				} else {
					this.put("There\'s nothing left to clean.");
				}
				return;
			}
			if ((_loc2.isStart("clean")) && (_loc2.isEnd("cornea"))) {
				this.put("Heck no at all!");
			}
			if ((_loc2.isStart("talk")) && ((_loc2.isEnd("compy")) || (_loc2.isEnd("microwave")))) {
				this.put("That\'s just sad.");
				return;
			}
			if (_loc2.isLookAt("appliance")) {
				this.put("The only appliance here is your computer, the SAARGTSCREEN II.");
				return;
			}
			if ((_loc2.isStart("shut down")) && (_loc2.isEnd("compy"))) {
				if (GameState.compyState == "off") {
					this.put("Getting a bit ahead of yourself, don't you think? Turn it on first.");
				} else {
					if (temptingFate == undefined) {
						this.put("It took you long enough to turn it on. Are you sure you want to turn off your computer?");
						temptingFate = 1;
					} else if (temptingFate == 1) {
						this.put("No seriously, don\'t. You\'ll just be wasting everyone\'s time.");
						temptingFate = 2;
					} else if (temptingFate == 2) {
						this.put("Oh, fine. Since you are so desperate to turn off your computer, you ram the screen as hard as you can several times, knocking off bits of your brainy self. You are slightly dumber. And slightly less alive.");
						Game.die();
					}
				}
				return;
			}
		} else if (GameState.gameMode == "virus") {
			if (_loc2.isLookAt("compy")) {
				this.put("The VIRUS guy is uploading himself into it. Once it's complete, your precious little computer will be the base of the world's demise.");
				return;
			}
			if (((_loc2.contains("compy")) || (_loc2.contains("virus"))) && (!_loc2.isStart("look"))) {
				this.put("One of the first things this kind of VIRUS does is lock down its host computer. You aren't going to be able to do anything to stop him.");
				return;
			}
			if (_loc2.isLookAt("switch")) {
				this.put("Stop worrying about switches and start worrying about the VIRUS.");
				return;
			}
			if (_loc2.contains("microwave")) {
				this.put("Leave the microwave out of this.");
				return;
			}
			if (_loc2.contains("clean")) {
				this.put("How can you be thinking of cleaning at a time like this?!");
				return;
			}
			if (_loc2.isLookAt("virus")) {
				this.put("It's the avatar of the evil RealityBendX virus, which literally glitches up the entire world. His appearance features the body of the Atari Dragon, a black fiery head, purple arms and muscular legs. He also brandishes a dangerously sharp sword. You're going to need special anti-virus hardware if you want to kill him.");
				return;
			}
			if (_loc2.contains("bomb")) {
				this.put("And here we were thinking this bomb was no longer dangerous. Well, it's back inside Stlunko now, but the damage has been done.");
				return;
			}
			if (_loc2.is("robots")) {
				this.put("As well as it worked the first time, I don't think that's gonna cut it this time around.");
				return;
			}
			if (_loc2.contains("trevor")) {
				this.put("That's a good idea - he got rid of it the first time. Unfortunately, he doesn't seem to be in this universe, so that's sort of a hindrance.");
				return;
			}
			if (_loc2.is("boorst")) {
				this.put("Are you trying to get yourself killed or something?");
				return;
			}
			if (_loc2.isGo("north")) {
				if (!GameState.discussion) {
					this.put("\"Hey, where do you think you're going, Tampo?\" Stlunko asks. \"Saargtsson is this other way!\"");
				} else {
					GameState.exitingRoom = "spikes";
					Game.newRoom("lavalake");
				}
				return;
			}
			if (_loc2.is("check email")) {
				this.put("Somehow I don't think it's going to work out today.");
				return;
			}
			if (_loc2.isGo("south")) {
				Game.newRoom("crossroads");
				return;
			}
		}
		if (_loc2.isLookAt("gokul")) {
			if (!GameState.seenGokul) {
				this.put("What Gokul? <(\'-\'<)");
			} else if (!GameState.gokulExplode) {
				if (!GameState.talkPoorbt) {
					this.put("It looks like it wants out.");
				} else {
					this.put("It's the brother of another Gokul who you said you'd help rescue. Its friends are waiting in the GOKUL FEEDING CHAMBER. But right now, this Gokul looks like it wants out.");
				}
			} else if (!GameState.clean) {
				this.put("Uh... Brody will clean that up.");
			} else {
				this.put("He\'s all gone now.");
			}
			return;
		}
		if ((_loc2.isStart("talk")) && (_loc2.isEnd("gokul"))) {
			if (!GameState.seenGokul) {
				this.put("What Gokul? <(\'-\'<)");
			} else if (!GameState.gokulExplode) {
				this.put("You ask the Gokul how it got in there, not really expecting to understand the answer. The squishy things can't really talk, you know. It notices you and starts squealing and squirming for help. It's definitely trapped in there. You tell it everything's going to be fine, but it continues to squeal and squeal anyway.");
				pressEnterCallbackFunc = postGokulThree;
				Game.addPause();
			} else if (!GameState.clean) {
				this.put("Well, it stopped squealing anyway. Poor guy.");
			} else {
				this.put("He\'s all gone now.");
			}
			return;
		}
		if ((_loc2.isTake("gokul")) && (!_loc2.contains("brody"))) {
			if (!GameState.seenGokul) {
				this.put("What Gokul? <(\'-\'<)");
			} else if (!GameState.gokulExplode) {
				this.put("You can\'t, there's a glass door in the way. You probably wouldn't want to absorb that squiggly thing anyway.");
			} else if (!GameState.clean) {
				this.put("Uh... you have enough of him on you already.");
			} else {
				this.put("He\'s all gone now.");
			}
			return;
		}
		if (_loc2.isLookAt("lava")) {
			this.put("It boils and bubbles and is placed ever-so-conveniently on the far side of the room. It continues to flow in from a TUNNEL in the NORTH of the room, but that tunnel looks freakin\' hot. It disappears under a rock slab to the south. Anyone for a lava bath?");
			return;
		}
		if ((_loc2.isStart("talk")) && (_loc2.isEnd("lava"))) {
			this.put("\"Lava nice day.\"");
			return;
		}
		if (_loc2.isLookAt("north")) {
			this.put("It\'s a cramped tunnel to the NORTH with a LAVA FLOW passing along the floor. You can\'t see what\'s on the other side. Being covered in lava and having almost no ventilation, it looks extremely hot. Even more so than most of these toasty caverns. Enter at your own risk.");
			GameState.lookedNorth = true;
			return;
		}
		if (_loc2.isLookAt("south")) {
			this.put("The exit you always take to get out of here is on the SOUTH side of the room. Beyond it lies random Lava Zone-style passageways and corridors full of minions. What fun.");
			return;
		}
		if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
			this.put("You head towards the lava flow and decide to sit in it. You feel warmth as it flows over your soft, gooey brain. You then remember that you can\'t survive in lava. For a brain, you aren\'t very smart. You die.");
			Game.die();
			return;
		}
		//trace("Room_spikes parse");
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function look() {
		if (GameState.continuing) {
			this.put("You skip to the checkpoint. Whoo.");
			this.put("\n\nYou are in your personal chamber with BRODY and STLUNKO. A very evil VIRUS guy has begun uploading itself into your computer, and you have to get to SAARGTSSON and his anti-viral hardware before he does. Now get moving before it's too late!");
			//this.put("\n\nThe virus upload is currently at 0%.");
			firstTime = false;
			GameState.continuing = false;
		} else {
			if (GameState.gameMode != "virus") {
				if (GameState.firstTimeSpikes == true) {
					this.put("You are in your personal chamber. You face the SAARGTSCREEN II, which sits in the middle of the room, turned off. This seems like a good time to check your EMAIL, something you haven\'t gotten to do in a while. There is a LAVA FLOW along the far side of the room, and your exit is SOUTH. Your two FRIENDS are mysteriously absent... Where could they be?");
					GameState.firstTimeSpikes = false;
					Game.input_mc.input.text = "";
				} else {
					if (firstTime == undefined) {
						if (GameState.exitingRoom == "lavalake") {
							this.put("You go back through the tunnel and eventually reach your personal chamber. Your SAARGTSCREEN II still sits in the center of the room. The normal exit is SOUTH, while the way you just entered along the lava flow is NORTH.");
							if (GameState.doorState == "open") {
								this.put("\n\nWhile you casually go down the path, Brody and Stlunko run across the long way and enter your Personal Chamber as soon as you do. It's almost as if they never left!");
							} else {
								if (((GameState.brodyStatus == "away") && (GameState.brodyRoom == "spikes")) && (GameState.stlunkoStatus == "party")) {
									this.put("\n\nBrody has rejoined your party, but Stlunko got left behind. Aw.");
									GameState.stlunkoStatus = "away";
									GameState.brodyStatus = "party";
								} else if (((GameState.brodyStatus == "away") && (GameState.brodyRoom == "spikes")) && (GameState.stlunkoStatus != "party")) {
									this.put("\n\nBrody has rejoined your party.");
									GameState.brodyStatus = "party";
									GameState.brodyRoom = undefined;
									//} else if ((GameState.brodyStatus != "away") && (GameState.stlunkoStatus == "party")) {
								} else if (GameState.stlunkoStatus == "party") {
									this.put("\n\nStlunko can't get through the lava, so he'll be waiting in the Caldera.");
									GameState.stlunkoStatus = "away";
								}
							}
						} else {
							if (GameState.compyState == "off") {
								this.put("You float into your personal chamber. In the center of the room sits your deactivated SAARGTSCREEN II, on which you need to check your EMAIL. There is a LAVA FLOW to the far side of the room, and the main exit is SOUTH.");
							} else {
								this.put("You float into your personal chamber. In the center of the room sits your SAARGTSCREEN II, which is currently activated. There is a LAVA FLOW to the far side of the room, and the main exit is SOUTH.");
							}
							//this.put("\n\nYour two FRIENDS are nowhere to be seen.");
						}
						GameState.exitingRoom = undefined;
						firstTime = false;
						if (GameState.stlunkoStatus == "party") {
							this.put("\n[PRESS ENTER]");
							pressEnterCallbackFunc = postStlunko;
							Game.addPause();
						}
					} else {
						if (GameState.compyState == "off") {
							this.put("You are floating in your personal chamber. In the center of the room sits your deactivated SAARGTSCREEN II, on which you need to check your EMAIL. There is a LAVA FLOW to the far side of the room, and the main exit is SOUTH.");
						} else {
							this.put("You are floating in your personal chamber. In the center of the room sits your SAARGTSCREEN II, which is currently activated. There is a LAVA FLOW to the far side of the room, and the main exit is SOUTH.");
						}
						if (GameState.clean) {
							this.put("The MICROWAVE looks all shiny and clean.");
						} else if (GameState.gokulExplode) {
							this.put("There are some GOKUL GUTS splattered around, making a rather big mess.");
						} else if (GameState.seenGokul) {
							this.put("There is a GOKUL in the MICROWAVE.");
						}
					}
				}
			} else {
				if (firstTime == undefined) {
					if (GameState.exitingRoom == "lavalake") {
						this.put("You float through the tunnel and back into your personal chamber. A very evil VIRUS guy has begun uploading itself into your COMPUTER, so you should probably be doing something about that. There is still a LAVA FLOW nearby and the usual SOUTH exit.");
					} else {
						this.put("You float into your personal chamber. A very evil VIRUS guy has begun uploading itself into your COMPUTER, so you should probably be doing something about that. There is still a LAVA FLOW nearby and the usual SOUTH exit.");
					}
					firstTime = false;
				} else {
					this.put("You are floating in your personal chamber. A very evil VIRUS guy has begun uploading itself into your COMPUTER, so you should probably be doing something about that. There is still a LAVA FLOW nearby and the usual SOUTH exit.");
				}
			}
		}
		return;
	}
	/*	function postIntro() {
	
	return;
	} */
	function postGokulOne() {
		this.put("Ding! The microwave door automatically opens after cooking the Gokul for a few seconds. The irradiated Gokul is all vibrating and squealing. When you realise what's going to happen, it's too late. The Gokul explodes and his innards and guts make a terrible mess all over the microwave and you. It feels toasty.");
		pressEnterCallbackFunc = postGokulTwo;
		Game.addPause();
	}
	function postGokulTwo() {
		this.put("The guts that land on you start absorbing inside. It\'s very gross indeed, but it appears to have a beneficial side effect. It seems to be lightly coating your exterior in heat-resistant Gokul particles. You can now handle extreme heat, but lava is probably still fatal to the touch.");
		GameState.seenGokul = true;
		GameState.gokulExplode = true;
		GameState.invItems = GameState.invItems+1;
		Game.scorePoints(1);
		synonyms.push(new Array("gokul", "guts", "gokul guts"));
	}
	function postGokulThree() {
		this.put("It\'s sort of getting annoying...");
	}
	function postCompy() {
		this.put("\"Aw crap,\" you blurt. \"Stlunko hasn\'t installed it onto this new computer yet. Can you access my emails manually?\"");
		this.put("\n\n\"Nope, that\'s all I got,\" Brody replies.");
		this.put("\n\n\"Guess we\'ll have to get Stlunko then. No biggie,\" you conclude.");
		GameState.compyState = "tried";
	}
	function postStlunko() {
		this.put("Stlunko goes over to the computer and takes out the BOMB while saying, \"Now it is time for me to do some deeper scans with this bomb.\" He places the bomb gently on the floor and pulls out some wires from somewhere, and plugs the bomb into the SAARGTSCREEN II.");
		this.put("\n\n\"Wait Stlunko, can't I check my email first? I've been waiting for so long...\" you ask.");
		this.put("\n\n\"Very well,\" Stlunko says, \"Let us do it.\"");
		GameState.gameMode = "email";
	}
	function postEmailOne() {
		this.put("He presses enter and the SaargtScreen II beeps and starts loading it up. But suddenly it fizzes and crackles, startling everyone in the room, even Stlunko. The BOMB on the ground starts sparkling and shaking, and then a large spark can be seen moving across the wire and into the computer.");
		this.put("\n\n\"What's going on?\" Brody asks nervously.");
		this.put("\n\nBefore anyone can reply, the SaargtScreen's monitor blips open with a picture of a creature. He has an Atari Dragon body, a flaming black head, purple arms and muscular legs. \"Yes, finally! I am free of that accursed prison, and now you all will be my slaves!\" he shouts from the screen.");
		this.put("\n\nAt first you can't remember where you've seen him, but then it clicks.");
		this.put("\n\n\"That's the virus guy who tried taking over our world in that email of ours way back when!\" you shout.");
		pressEnterCallbackFunc = postEmailTwo;
		Game.addPause();
	}
	function postEmailTwo() {
		this.put("\"Yes,\" the virus confirms. \"When I was destroyed, a few strains of my coding were sent spiraling away. And they happened to wind up in a microchip that would be used in that bomb. A terrible prison, it was. But now, as soon as my upload is complete, I will once again rule the world, and this time no one will stop me!!!\"");
		this.put("\n\n\"Uh oh, this is bad,\" Brody states.");
		this.put("\n\nStlunko takes control. \"Come, we must alert Saargtsson of this menace. He must have some virus-control hardware somewhere. We need to get to him fast!\" As he says his, he quickly unplugs the bomb and stores it back inside him. Doing so doesn't seem to phase the virus at all though.");
		pressEnterCallbackFunc = postEmailThree;
		Game.addPause();
	}
	function postEmailThree() {
		this.put("Okay, so you need to get to Saargtsson. You're still in control, but just don't take too long. Also, Stlunko might not like you wandering off. If that virus finishes uploading and you aren't prepared, you're done for! And so will the rest of the world.");
		this.put("\n\nOn the plus side, you have just reached the CHECKPOINT of the game. Congratulations! Should you reach an unfortunate demise, restart and enter the command 'CONTINUTE AT VIRUS' exactly like that (including the Engrish typo). It must be done as your first command, before you do anything else. You'll then be warped right up to this point. Unfortunately you'll lose any bonus points you've already earned.");
		this.put("\n\nThe virus upload is currently at 0%.");
		GameState.gameMode = "virus";
		return;
	}
}
