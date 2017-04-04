class Room_puzzle_stlunko extends Room {
	var synonyms, put, superClassParse, firstTime, pressEnterCallbackFunc, varsDefined;
	static var buttons, lava, compy, yesOrNo, trivia, question, triviaDone, sequence, door;
	function Room_puzzle_stlunko() {
		super();
		synonyms.push(new Array("lava", "flow", "fall", "falls"));
		synonyms.push(new Array("bomb", "explosive"));
		synonyms.push(new Array("push", "press", "hold"));
		synonyms.push(new Array("body", "base"));
		synonyms.push(new Array("put", "place"));
		synonyms.push(new Array("punch", "attack", "destroy"));
		synonyms.push(new Array("controller", "game", "controler", "nes", "nintendo"));
		synonyms.push(new Array("buttons", "button"));
		synonyms.push(new Array("computer", "screen", "trivia", "machine", "monitor", "compy"));
		synonyms.push(new Array("switch", "lever"));
		synonyms.push(new Array("avatar", "program", "guy", "face", "stan"));
		synonyms.push(new Array("talk", "ask"));
		synonyms.push(new Array("tunnel", "path", "passage", "out"));
		synonyms.push(new Array("press", "push"));
		synonyms.push(new Array("dpad", "d-pad", "d pad"));
		if (varsDefined == undefined) {
			buttons = 0;
			lava = true;
			compy = false;
			yesOrNo = false;
			trivia = false;
			question = 0;
			triviaDone = false;
			sequence = undefined;
			door = false;
			varsDefined = true;
		}
	}
	function getName() {
		return ("\\/1|?|_|5 |>|?150|\\|");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.is("inv")) {
			this.put("You are stowing the broken BOMB with you, and can pull it out at any time.");
			return;
		}
		if ((_loc2.isStart("eat")) || (_loc2.isStart("drink"))) {
			this.put("Eating and drinking are for more primitive beings. Plus you do not have the guts.");
			return;
		}
		if ((_loc2.isStart("shoot")) || (_loc2.isStart("use laserball"))) {
			this.put("You do not have Tampo's laserball powers, but you do possess HANDS that can do all sorts of things.");
			return;
		}
		if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko"))) {
			this.put("Dump that prefix, you do not need it.");
			return;
		}
		if ((_loc2.contains("'re")) || (_loc2.contains("n't")) || (_loc2.contains("he's")) || (_loc2.contains("it's"))) {
			this.put("Ahh! A contraction! Burn it! BURN IT WITH FIRE!!!");
			return;
		}
		if (_loc2.isLookAt("bomb")) {
			this.put("You pull out the broken BOMB you had stored earlier. It will not explode anymore, but it makes a fine paperweight.");
			return;
		}
		if (lava) {
			if ((_loc2.isStart("push")) && (_loc2.contains("buttons")) && (!_loc2.isEnd("body")) && (!_loc2.isEnd("bomb"))) {
				if (buttons == 0) {
					this.put("You push down one of the buttons down with one of your hands. It does not do anything, so you assume that all four must be pushed simultaneously. Try using your other hand as well.");
					buttons = 1;
				} else if (buttons == 1) {
					this.put("You use your remaining hand to push down another button. Nothing happens though. It seems you need to push down the rest of the buttons.");
					buttons = 2;
				} else if (buttons<4) {
					this.put("With what? Your BODY? You are all out of hands.");
				} else {
					this.put("They are clicked in place. You do not need to hold them down any more.");
				}
				return;
			}
			if ((_loc2.isStart("push")) && (_loc2.contains("buttons")) && (_loc2.isEnd("body"))) {
				if (buttons<2) {
					this.put("Maybe you should try with your HANDS before stooping down to that level.");
				} else if (buttons == 2) {
					this.put("You roll over one more BUTTON and your very heavy heaviness has no problem pushing it down. Unfortunately the buttons are too far apart for you to push down two buttons at once like this. What could push down the last button? You are out of body parts...");
					buttons = 3;
				} else if (buttons == 3) {
					this.put("Your body is already pushing down one of the buttons. The buttons are too far apart to push two at once.");
				} else {
					this.put("They are clicked in place. You do not need to hold them down any more.");
				}
				return;
			}
			if ((_loc2.isLookAt("button")) || (_loc2.isLookAt("buttons"))) {
				this.put("They are like red bulbous sores protruding out of the ground. There are four of them forming a large square across the room.");
				if (buttons == 0) {
					this.put("Currently none are being pushed down.");
				} else if (buttons == 1) {
					this.put("One is being held down by one of your hands.");
				} else if (buttons == 2) {
					this.put("Two are being held down by your hands.");
				} else if (buttons == 3) {
					this.put("Two are being held down by your hands and you are sitting on one.");
				} else {
					this.put("They have all been pushed down and are now locked in place.");
				}
				return;
			}
		}
		if ((_loc2.isStart("use")) && (_loc2.isEnd("bomb"))) {
			if (buttons<4) {
				this.put("How so?");
			} else {
				this.put("You do not need to risk damage to the bomb anymore.");
			}
			return;
		}
		if (((_loc2.isStart("push")) && (_loc2.contains("buttons")) && (_loc2.isEnd("bomb"))) || (((_loc2.isStart("use")) || (_loc2.isStart("put"))) && (_loc2.contains("bomb")) && (_loc2.isEnd("button")))) {
			if (buttons<3) {
				this.put("Placing it down may damage valuable evidence such as fingerprints. You would rather not do that unless you absolutely have to. You still have body parts to use.");
			} else if (buttons == 3) {
				this.put("You place the bomb on the last button and it pushes the button down. With all four held down simutaniously, you hear them click in place. Suddenly a glass casing that was blocking the lava SHOOMPS!! up, giving you full access to the lava. Yay...? Fortunately the LAVA doesn't pour onto you; it is still flowing straight down. You release your hands' hold and put the bomb away.");
				buttons = 4;
			} else {
				this.put("You do not need to risk damage to the bomb anymore.");
			}
			return;
		}
		if ((_loc2.isStart("release")) && (_loc2.isEnd("buttons"))) {
			if (buttons < 4) {
				this.put("You let go of all the buttons.");
				buttons = 0;
			} else {
				this.put("They are now locked into the ground.");
			}
			return;
		}
		/*if (_loc2.is("skip buttons")) {
			this.put("Next command: \"touch lava\"");
			buttons = 4;
			return;
		}*/
		if (_loc2.isLookAt("glass")) {
			if (buttons<4) {
				this.put("This glass is trapping you in a cylinder prison. There is questionable LAVA right on the other side of it. Your scans tell you it is connected to the BUTTONS somehow.");
			} else {
				this.put("It has entirely inserted itself into the ceiling and you can no longer access it.");
			}
			return;
		}
		if ((_loc2.isPunch("glass")) || (((_loc2.isStart("break")) || (_loc2.isStart("shatter"))) && (_loc2.isEnd("glass")))) {
			if (buttons<4) {
				this.put("You give the glass one of your strongest punches, but it does not show any damage. You will have to use a less direct way to get beyond it, like pushing the BUTTONS.");
			} else {
				this.put("It has entirely inserted itself into the ceiling and you can no longer access it.");
			}
			return;
		}
		if (_loc2.contains("falls")) {
			if (lava) {
				if (_loc2.isLookAt("falls")) {
					if (buttons<4) {
						this.put("They are pouring out from the ceiling and straight into the ground. It forms a perfect circle around you. There seems to be some GLASS keeping it out. The lava looks... unnatural.");
					} else {
						this.put("They are pouring out from the ceiling and straight into the ground. It forms a perfect circle around you. It's holding up even without the glass. The lava looks... unnatural.");
					}
					return;
				}
				if ((_loc2.isTake("falls")) || (_loc2.isTouch("falls")) || (_loc2.isGo("falls")) || (_loc2.isUse("falls"))) {
					if (buttons<4) {
						this.put("You cannot reach to the lava, there seems to be some GLASS keeping it out. Probably a good thing, as you are not resistant to the heat of lava. Although you are not getting any heat readings from this lava...");
					} else {
						this.put("It seems phony and you are not getting any heat readings, so you ever-so-slowly and carefully move one of your fingers closer to the lava... It appears to make contact, but it does not hinder your movement at all and you cannot feel it. You push your hand through as if there was nothing but air. It is very similar to a hologram.");
						this.put("\n\nSensing the obstruction, the entire lava flow disappears in a blip. You see that you are in a large rectangular room, with Lava Zone rocks all around but no visible exits. The only things of note is a large computer SCREEN on one side of the room and a... huge video game CONTROLLER on the other. They do not appear to be connected.");
						lava = false;
						Game.scorePoints(1);
					}
					return;
				}
			} else {
				this.put("The holographic lava is all gone now.");
				return;
			}
		}
		if (!lava) {
			if (!yesOrNo) {
				if (!door) {
					if (_loc2.isLookAt("game")) {
						this.put("It is a very large video game controller with its cord simply sticking out of the wall, with its cord not connected to anything. You do some quick research and discover it is a mockup of the Super Nintendo Entertainment System's control pad. It features various BUTTONS: A, B, X, Y, L, R, Start, Select, and the D-Pad. They are all pushable, but it does not seem like it will do anything.");
						return;
					}
					if (_loc2.isLookAt("buttons")) {
						this.put("There are many buttons lining the SNES controller: A, B, X, Y, L, R, Start, Select, and a D-Pad. You do not know how to make them work, as there is no monitor connected to them.");
						return;
					}
					if ((_loc2.isUse("game")) || (_loc2.isTake("game"))) {
						this.put("How do you plan on doing that?");
						return;
					}
					if (_loc2.isLookAt("switch")) {
						this.put("It's a small little switch that should turn the computer SCREEN on and off.");
						return;
					}
					if (_loc2.pressButton("l")) {
						this.put("You give the button on the controller a solid push. You wait a second, but nothing seems to happen.");
						if (triviaDone) {
							if (sequence == "x") {
								sequence = "L";
							} else {
								sequence = "x";
							}
						}
						return;
					}
					if (_loc2.pressButton("r")) {
						this.put("You give the button on the controller a solid push. You wait a second, but nothing seems to happen.");
						if (triviaDone) {
							if (sequence == "L") {
								sequence = "LR";
							} else {
								sequence = "x";
							}
						}
						return;
					}
					if (_loc2.pressButton("a")) {
						this.put("You give the button on the controller a solid push. You wait a second, but nothing seems to happen.");
						if (triviaDone) {
							if (sequence == "LR") {
								sequence = "LRA";
							} else {
								sequence = "x";
							}
						}
						return;
					}
					if (_loc2.pressButton("start")) {
						if (triviaDone) {
							if (sequence == "LRA") {
								this.put("You push and hold down the Start button. As soon as you release, the entire wall in front of you starts rumbling and shaking. It slowly rotates 180 degrees... and somehow on the other side is the entrance to a tunnel out of here! Hooray, you have found the exit to this crazy place.");
								sequence = "LRAStart";
								door = true;
							} else {
								sequence = "x";
								this.put("You give the button on the controller a solid push. You wait a second, but nothing seems to happen.");
							}
						} else {
							this.put("You give the button on the controller a solid push. You wait a second, but nothing seems to happen.");
						}
						return;
					}
					if ((_loc2.pressButton("b")) || (_loc2.pressButton("x")) || (_loc2.pressButton("y")) || (_loc2.pressButton("select")) || (_loc2.pressButton("up")) || (_loc2.pressButton("left")) || (_loc2.pressButton("right")) || (_loc2.pressButton("down")) || (_loc2.pressButton("dpad"))) {
						this.put("You give the button on the controller a solid push. You wait a second, but nothing seems to happen.");
						if (triviaDone) {
							sequence = "x";
						}
						return;
					}
					if ((_loc2.isPush("buttons")) || (_loc2.isUse("buttons"))) {
						this.put("You will need to be more specific. There are many different buttons to choose from.");
						return;
					}
					if (_loc2.isPlay("game")) {
						this.put("There is no screen or game to play with. You are not exactly the video game type anyway.");
						return;
					}
					if (_loc2.isPlay("mario")) {
						this.put("You would rather burn out all of your chips and disrupt your core memory and internal programming than play that horrible, horrible game. It was outlawed in 2095 for a reason.");
						return;
					}
				} else {
					if ((_loc2.contains("game")) || (_loc2.contains("button"))) {
						this.put("The controller is gone now. It has rotated away to somewhere.");
						return;
					}
					if ((_loc2.isLookAt("tunnel")) || (_loc2.isLookAt("exit"))) {
						this.put("It is a physics-defying tunnel that leaves out of here. You should probably go through it.");
						return;
					}
					if ((_loc2.isGo("tunnel")) || (_loc2.contains("leave")) || (_loc2.contains("exit")) || (_loc2.isUse("tunnel"))) {
						Game.scorePoints(3);
						Game.newRoom("end_game");
						return;
					}
				}
				if ((_loc2.isLookAt("walls")) || (_loc2.isLookAt("roof")) || (_loc2.isLookAt("floor"))) {
					this.put("They match the lava zone's walls perfectly in form and texture. Fascinating.");
					return;
				}
				if (_loc2.isLookAt("compy")) {
					if (!compy) {
						this.put("It is a large flat computer monitor protruding out of the wall opposite of the CONTROLLER, to which it is not connected. The screen seems to be turned off, but there is a SWITCH on it that should change that. Other than that, it does not really have any external interface to speak of.");
					} else {
						this.put("It is a large flat computer monitor protruding out of the wall opposite of the CONTROLLER, to which it is not connected. The screen is on and is being occupied by a computer AVATAR.");
					}
					return;
				}
				if (_loc2.isTake("compy")) {
					this.put("You cannot carry it around. Plus you can use it perfectly fine where it is.");
					return;
				}
				if ((_loc2.isTurnOn("compy")) || (_loc2.isUse("lever")) || (_loc2.isFlip("lever")) || (_loc2.isTurnOff("compy"))) {
					if (!compy) {
						if (!_loc2.isTurnOff("compy")) {
							this.put("You push down the switch on the computer. Instantaneously you can hear the machine whirring and booting up. In six-point-three seconds, the screen briefly flashes white. It reverts to black and then a primitive computer AVATAR appears onscreen. Nothing else happens.");
							compy = true;
						} else {
							this.put("It is already off. Work on turning it on.");
						}
					} else {
						if (!_loc2.isTurnOn("compy")) {
							this.put("You flip the switch and the computer turns off. Wow.");
							compy = false;
						} else {
							this.put("It is already on.");
						}
					}
					return;
				}
				if ((_loc2.isUse("compy")) || (_loc2.isUse("stan"))) {
					if (!compy) {
						this.put("It needs to be turned on before you can use it in any efficient way. Try pulling the SWITCH connected to it.");
					} else {
						this.put("There really are not any visible input devices to speak of. How do you plan on communicating with the computer?");
					}
					return;
				}
				if (compy) {
					if (_loc2.isLookAt("stan")) {
						this.put("It appears to be one of those ancient Alpha Stan models of computer avatars. The trivia version, but the looks of it.");
						return;
					}
					if (_loc2.contains("beta clam")) {
						this.put("Unfortunately, this is not the easier-to-use Beta Clam trivia model. It appears you must settle for the second best Alpha Stan variety.");
						return;
					}
				}
				if ((_loc2.isTalk("compy")) || (_loc2.isTalk("stan"))) {
					if (!compy) {
						this.put("It needs to be turned on before you can use it in any efficient way. Try pulling the SWITCH connected to it.");
					} else {
						this.put("\"I am Stlunko. Can I use this computer?\" you say to the computer avatar.");
						this.put("\n\nIt recognises the voice command. It speaks in a simple two-frame animation with the text appearing below it. \"Welcome, "+GameState.dungeonName+", to the Alpha Stan 2.0 Trivia Edition. Do you wish to start a game?\"");
						this.put("\n\nYES or NO?");
						yesOrNo = true;
					}
					return;
				}
			} else {
				if (!trivia) {
					if ((_loc2.is("no")) || (_loc2.is("n"))) {
						this.put("\"Very well,\" the computer avatar says, \"Shutting down systems.\" The computer turns off with a powering down noise.");
						yesOrNo = false;
						compy = false;
						return;
					} else if ((_loc2.is("yes")) || (_loc2.is("y"))) {
						this.put("\"Affirmative,\" the computer states. \"You will be asked five questions on Tampo's recent actions and those of his friends. First you will be given a brief moment to review his adventure. Be sure to memorize all you can.\"");
						this.put("\n\nYou ask the computer to start the memorization process.");
						pressEnterCallbackFunc = postStartTrivia;
						Game.addPause();
						return;
					} else {
						this.put("Please decide if you want to play a trivia game first. YES or NO?");
						return;
					}
				} else {
					if (question == 1) {
						if ((_loc2.is("a")) || (_loc2.is("c")) || (_loc2.is("d"))) {
							wrongAnswer();
						} else if (_loc2.is("b")) {
							this.put("\"That is correct, Frotzers are very knowledgeable and friendly. Second question:\"");
							this.put("\n\nIn what room was the missing virtual reality headset misplaced?");
							this.put("\nA - Saargtsson's Lair");
							this.put("\nB - Your Personal Chamber");
							this.put("\nC - Gokul Feeding Chamber");
							this.put("\nD - Simulation Room");
							question = 2;
						} else {
							this.put("\"That is not a recognized command or file name. Please input A, B, C, or D.\"");
							this.put("\n\nWhat species of minion helped Tampo know what room Brody was playing in?");
							this.put("\nA - Gaspeau");
							this.put("\nB - Frotzer");
							this.put("\nC - Gokul");
							this.put("\nD - Pink Cham Cham");
						}
					} else if (question == 2) {
						if ((_loc2.is("a")) || (_loc2.is("b")) || (_loc2.is("d"))) {
							wrongAnswer();
						} else if (_loc2.is("c")) {
							this.put("\"Very good. It was placed on the machine that feeds the Gokuls. Now presenting the third question.\"");
							this.put("\n\nIn what sort of place did the deactivated bomb wind up before being retrieved by you? It was a...");
							this.put("\nA - Camouflet");
							this.put("\nB - Caldera");
							this.put("\nC - Cirque");
							this.put("\nD - What?!");
							question = 3;
						} else {
							this.put("\"That is not a recognized command or file name. Please input A, B, C, or D.\"");
							this.put("\n\nIn what room was the missing virtual reality headset misplaced?");
							this.put("\nA - Saargtsson's Lair");
							this.put("\nB - Your Personal Chamber");
							this.put("\nC - Gokul Feeding Chamber");
							this.put("\nD - Simulation Room");
						}
					} else if (question == 3) {
						if ((_loc2.is("a")) || (_loc2.is("c")) || (_loc2.is("d"))) {
							wrongAnswer();
						} else if (_loc2.is("b")) {
							this.put("\"That is correct: A crater caused by an exploding volcano. Question number four:\"");
							this.put("\n\nHow fast did the virus download after being released? In increments of...");
							this.put("\nA - 10 percent");
							this.put("\nB - 5 percent");
							this.put("\nC - 2 percent");
							this.put("\nD - 80 percent");
							question = 4;
						} else {
							this.put("\"That is not a recognized command or file name. Please input A, B, C, or D.\"");
							this.put("\n\nIn what room was the missing virtual reality headset misplaced?");
							this.put("\nA - Saargtsson's Lair");
							this.put("\nB - Your Personal Chamber");
							this.put("\nC - Gokul Feeding Chamber");
							this.put("\nD - Simulation Room");
						}
					} else if (question == 4) {
						if ((_loc2.is("a")) || (_loc2.is("c")) || (_loc2.is("d"))) {
							wrongAnswer();
						} else if (_loc2.is("b")) {
							this.put("\"Correct. That is a rough average of its downloading speed. Here is the fifth question.\"");
							this.put("\n\nWhat colour is Saargtsson?");
							this.put("\nA - Red");
							this.put("\nB - Brown");
							this.put("\nC - Lava");
							this.put("\nD - Blue");
							question = 5;
						} else {
							this.put("\"That is not a recognized command or file name. Please input A, B, C, or D.\"");
							this.put("\n\nHow fast did the virus download after being released? In increments of...");
							this.put("\nA - 10 percent");
							this.put("\nB - 5 percent");
							this.put("\nC - 2 percent");
							this.put("\nD - 80 percent");
						}
					} else if (question == 5) {
						if ((_loc2.is("a")) || (_loc2.is("b")) || (_loc2.is("c"))) {
							wrongAnswer();
						} else if (_loc2.is("d")) {
							this.put("\"Yes, he is currently blue due to a sickness. Congradiations, you made it to a two-punch bonus round! Bonus question one:\"");
							this.put("\n\nHow does one escape this virus prison?");
							this.put("\nA - Using the SNES controller");
							this.put("\nB - Passing the trivia program");
							this.put("\nC - Pulling back up the buttons");
							this.put("\nD - By believing in yourself");
							question = 6;
						} else {
							this.put("\"That is not a recognized command or file name. Please input A, B, C, or D.\"");
							this.put("\n\nWhat colour is Saargtsson?");
							this.put("\nA - Red");
							this.put("\nB - Brown");
							this.put("\nC - Lava");
							this.put("\nD - Blue");
						}
					} else if (question == 6) {
						if ((_loc2.is("b")) || (_loc2.is("c")) || (_loc2.is("d"))) {
							wrongAnswer();
						} else if (_loc2.is("a")) {
							this.put("\"That is correct. You are at the final bonus question. Good work.\"");
							this.put("\n\nHow do you activate the powers of the controller?");
							this.put("\nA - Smash it against a wall");
							this.put("\nB - Push L, R, A, and Start");
							this.put("\nC - Buy a game guide");
							this.put("\nD - Spell B-A-B-Y L-A-R-D");
							question = 7;
						} else {
							this.put("\"That is not a recognized command or file name. Please input A, B, C, or D.\"");
							this.put("\n\nHow does one escape this virus prison?");
							this.put("\nA - Using the SNES controller");
							this.put("\nB - Passing the trivia program");
							this.put("\nC - Pulling back up the buttons");
							this.put("\nD - By believing in yourself");
						}
					} else if (question == 7) {
						if ((_loc2.is("a")) || (_loc2.is("c")) || (_loc2.is("d"))) {
							wrongAnswer();
						} else if (_loc2.is("b")) {
							this.put("\"Hooray, you beat the game! You are a true winner.\"");
							this.put("\n\nAlpha Stan is replaced with a scarcely animated trophy with the phrase \"YOU'RE WINNER!\" over it. This is displayed onscreen for about ten seconds before the computer turns itself off.");
							if (!triviaDone) {
								this.put("\n\nSuddenly the controller lets out a beep, as if it is now ready for something. You know what you must do.");
								Game.scorePoints(1);
								triviaDone = true;
							}
							yesOrNo = false;
							trivia = false;
							compy = false;
							sequence = "x";
						} else {
							this.put("\"That is not a recognized command or file name. Please input A, B, C, or D.\"");
							this.put("\n\nHow do you activate the powers of the controller?");
							this.put("\nA - Smash it against a wall");
							this.put("\nB - Push L, R, A, and Start");
							this.put("\nC - Buy a game guide");
							this.put("\nD - Spell B-A-B-Y L-A-R-D");
						}
					}
					return;
				}
			}
		}
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function look() {
		if (firstTime == undefined) {
			this.put("You, as Stlunko, slowly spin around as you observe your surroundings. You seem to be encased in some sort of virtual reality shining right around your anti-viral hardware, which you quickly turn up to a stronger level. In this virtual virus world, you appear to be trapped in on all sides by flowing LAVA FALLS, forming a complete circle around you, pouring in from the rocky ceiling and out straight through the stone floor.");
			this.put("\n\nThe only other things in the room are four large BUTTONS sticking out of the floor, forming something of a large square inside the trap. You should probably push them or something.");
			firstTime = false;
		} else {
			if (lava) {
				this.put("In this virtual reality world, you appear to be trapped in on all sides by flowing LAVA FALLS, forming a complete circle around you, pouring in from the rocky ceiling and out straight through the stone floor. The only other things in the room are four large BUTTONS sticking out of the floor, forming something of a large square inside the trap. You should probably push them or something.");
			} else {
				this.put("You are in a large rectangular room with Lava Zone-like rocks all around, making up the floor, roof and walls.");
				if (!compy) {
					this.put("Along one wall is a large computer SCREEN, currently turned off.");
				} else {
					this.put("Along one wall is a large computer SCREEN, currently turned on with a basic AVATAR displayed on it.");
				}
				if (!door) {
					if (!triviaDone) {
						this.put("Along the other wall seems to be a large game CONTROLLER for some unknown purpose. It is not connected to the opposing screen.");
					} else {
						this.put("Along the other wall seems to be a large game CONTROLLER. It is not connected to the opposing screen.");
					}
				} else {
					this.put("In the other wall is a TUNNEL that leads out of your virtual prison.");
				}
			}
		}
		return;
	}
	function postStartTrivia() {
		Game.scrollText();
		pressEnterCallbackFunc = postTriviaText;
		Game.addPause();
		return;
	}
	function postTriviaText() {
		trivia = true;
		question = 1;
		this.put("\"Paragraph memorised,\" Stlunko reports.");
		this.put("\n\n\"Then it is time for your first question. Please read the piece of trivia and choose answer A, B, C, or D.\"");
		this.put("\n\nWhat species of minion helped Tampo know what room Brody was playing in?");
		this.put("\nA - Gaspeau");
		this.put("\nB - Frotzer");
		this.put("\nC - Gokul");
		this.put("\nD - Pink Cham Cham");
		return;
	}
	function wrongAnswer() {
		this.put("\"I am sorry, but that answer is incorrect,\" the computer avatar says right before shutting down. Looks like you will have to try again.");
		question = 0;
		trivia = false;
		yesOrNo = false;
		compy = false;
		return;
	}
}
