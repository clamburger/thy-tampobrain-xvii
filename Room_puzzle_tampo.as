class Room_puzzle_tampo extends Room {
	var blueberry, synonyms, put, superClassParse, firstTime, pressEnterCallbackFunc, wordStatus, nose, loincloth, key, letter1, letter2, crate, curMode, door, nameEnter, dungeonName, bread, escaped;
	//static var blueberry;
	function Room_puzzle_tampo() {
		super();
		synonyms.push(new Array("wall", "room", "prism", "walls", "prison"));
		synonyms.push(new Array("engraving", "brain", "tampo", "carving", "picture", "engravings"));
		synonyms.push(new Array("rectangles", "squares", "rectangle", "square"));
		synonyms.push(new Array("letters", "letter", "alphabet"));
		synonyms.push(new Array("hole", "holes"));
		synonyms.push(new Array("blueberries", "blueberry", "blue-berry", "blue-berries"));
		synonyms.push(new Array("talk", "argue", "bargain", "order"));
		synonyms.push(new Array("crate", "box", "block"));
		synonyms.push(new Array("break", "force"));
		synonyms.push(new Array("stop", "cease", "rest", "halt"));
		synonyms.push(new Array("down", "hole", "square", "Stop poking around in my code, buttface."));
	}
	function getName() {
		return ("Virus Prison");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("armor")) {
			this.put("It appears that the anti-viral hardware has cleaned off the Gokul armor. Bummer.");
			return;
		}
		if (_loc2.isLookAt("hardware")) {
			this.put("Your personal piece of anti-viral hardware is still floating right above you, protecting you in a now-transparent forcefield. It's being entirely unobtrusive while still protecting you from being mutated from the virus. It's current state should allow you to safely interact with virus-infested objects.");
			return;
		}
		if (curMode == "start") {
			if (_loc2.isLookAt("blueberry")) {
				if (blueberry == "angry") {
					this.put("They are relatively large blueberries that appear sentient and evil, with glowing red eyes. They float around quickly in a large inpenetrable swarm, coming out of the 'O' hole and into the 'L' hole, blocking access to both. While they don't seem to mind your pressence, you should probably exercise caution near them.");
				} else if (blueberry == "happy") {
					this.put("They are relatively large blueberries that appear happy now, with glowing green eyes. They float around quickly in a large inpenetrable swarm, coming out of the 'O' hole and into the 'L' hole, blocking access to both. While they don't seem to mind your presence, you should probably exercise caution near them.");
				} else {
					this.put("They are relatively large blueberries that appear happy now, with glowing green eyes. They're scattered all around the room, and are generally avoiding you per your orders. You can probably leave them alone for now.");
				}
				return;
			}
			if ((_loc2.isMove("blueberry")) || (_loc2.isPush("blueberry"))) {
				if (blueberry != "team") {
					this.put("That's a terrible idea.");
				} else {
					this.put("That's not nice.");
				}
				return;
			}
			if ((_loc2.isUse("blueberry")) || (_loc2.isTake("blueberry"))) {
				if (blueberry != "team") {
					this.put("How? Talking to them?");
				} else {
					this.put("It seems like they'll follow you around and do what you ask. You must have reprogrammed them. But you don't really have anything for them to do at the moment.");
				}
				return;
			}
			if ((_loc2.isOrder("blueberry")) || (_loc2.isOrder("blueberries"))) {
				if (blueberry == "angry") {
					this.put("You try to talk to them but they don't respond at all. If only there was some way you could get their attention... through force maybe?");
				} else if (blueberry == "happy") {
					this.put("You utter a word at the green-eyed blueberries and they all suddenly stop and face you. They start beeping at each other in a robotic tongue. You cautiously tell them to get out of the way and they disperse all around the room and avoid you, so as to do your bidding. Horray, you unclogged the holes and now have an army of blueberry minions following you around to do your bidding!");
					Game.scorePoints(1);
					blueberry = "team";
				} else {
					this.put("You have nothing for them to do right now.");
				}
				return;
			}
			if (_loc2.isShoot("blueberry")) {
				if (blueberry == "angry") {
					this.put("You fire a laserball at the group and suddenly they all freeze. The electricty fizzes around the entire frozen swarm. They each beep, one by one, and their red evil eyes suddenly change to green and happy. That has to be good! But then they all resume their endless path just like before. How can you get them to stop?");
					blueberry = "happy";
					GameState.blueberry = true;
				} else {
					this.put("No, you don't want them to switch back into the red-eye mode.");
				}
				return;
			}
			if (_loc2.isLookAt("prism")) {
				this.put("The triangular room is yellow with many black holes. A slice of Swiss cheese?");
				return;
			}
			if (_loc2.isLookAt("brain")) {
				this.put("It's a nondescript human brain picture, and could very easily be yourself. It appears to be just an engraving though, nothing special. Below it are five RECTANGLES that look interesting.");
				return;
			}
			if (_loc2.isLookAt("rectangles")) {
				this.put("There are five rectangle carvings sitting along the wall right below the BRAIN picture.");
				if (wordStatus === undefined) {
					this.put("How do you suppose they work?");
				} else if (wordStatus === "") {
					this.put("They are all currently blank.");
				} else if (wordStatus == "T") {
					this.put("They currently spell T _ _ _ _.");
				} else if (wordStatus == "TA") {
					this.put("They currently spell T-A _ _ _.");
				} else if (wordStatus == "TAM") {
					this.put("They currently spell T-A-M _ _.");
				} else if (wordStatus == "TAMP") {
					this.put("They currently spell T-A-M-P _.");
				} else {
					this.put("They currently spell DNG-ROY-THE-3RD-TRD.");
				}
				return;
			}
			// DEBUG COMMAND - REMOVE BEFORE RELEASE
			/*if (_loc2.is("skip letters")) {
				wordStatus = "TAMP";
				blueberry = "team";
				this.put("Next command: \"go l\"");
				return;
			}*/
			if (_loc2.isLookAt("letters")) {
				this.put("A, B, C, D, E, F, G. H, I, J, K, L-M-N-O-P! Q, R, S; T, U, V; W, X, Y and Z! Now I know my A-B-Cs, next time won't you sing with me?");
				return;
			}
			if ((_loc2.isShoot("engraving")) || (_loc2.isShoot("rectangles")) || (_loc2.useLaserball("engraving")) || (_loc2.useLaserball("rectangles"))) {
				this.put("You fire a laserball at the engravings but it doesn't seem to do anything. Meh.");
				return;
			}
			if (_loc2.isLookAt("hole")) {
				this.put("Other than the individual LETTER marking each of them, they all look identical. Maybe you could try to GO in one?");
				return;
			}
			if ((_loc2.is("go hole")) || (_loc2.is("go holes")) || (_loc2.is("use hole")) || (_loc2.is("use holes"))) {
				this.put("There are twenty-six different holes, so you'll have to be more specific. Say \"GO IN ? HOLE\", but replace the ? with the letter of your choice.");
				return;
			}
			/*if (_loc2.is("var wordstatus")) {
				this.put("wordStatus = \""+wordStatus+"\"");
				return;
			}*/
			if ((_loc2.goHole("a")) || (_loc2.goHole("b")) || (_loc2.goHole("c")) || (_loc2.goHole("d")) || (_loc2.goHole("e")) || (_loc2.goHole("f")) || (_loc2.goHole("g")) || (_loc2.goHole("h")) || (_loc2.goHole("i")) || (_loc2.goHole("j")) || (_loc2.goHole("k")) || (_loc2.goHole("l")) || (_loc2.goHole("m")) || (_loc2.goHole("n")) || (_loc2.goHole("o")) || (_loc2.goHole("p")) || (_loc2.goHole("q")) || (_loc2.goHole("r")) || (_loc2.goHole("s")) || (_loc2.goHole("t")) || (_loc2.goHole("u")) || (_loc2.goHole("v")) || (_loc2.goHole("w")) || (_loc2.goHole("x")) || (_loc2.goHole("y")) || (_loc2.goHole("z"))) {
				if ((blueberry != "team") && ((_loc2.goHole("l")) || (_loc2.goHole("o")))) {
					this.put("You can't go down that hole. It's being obstructed by an endless stream of evil BLUEBERRIES flowing through it, and you dare not touch them.");
				} else {
					if (_loc2.goHole("a")) {
						letter1 = "A";
						letter2 = "Z";
					} else if (_loc2.goHole("b")) {
						letter1 = "B";
						letter2 = "Y";
					} else if (_loc2.goHole("c")) {
						letter1 = "C";
						letter2 = "X";
					} else if (_loc2.goHole("d")) {
						letter1 = "D";
						letter2 = "W";
					} else if (_loc2.goHole("e")) {
						letter1 = "E";
						letter2 = "V";
					} else if (_loc2.goHole("f")) {
						letter1 = "F";
						letter2 = "U";
					} else if (_loc2.goHole("g")) {
						letter1 = "G";
						letter2 = "T";
					} else if (_loc2.goHole("h")) {
						letter1 = "H";
						letter2 = "S";
					} else if (_loc2.goHole("i")) {
						letter1 = "I";
						letter2 = "R";
					} else if (_loc2.goHole("j")) {
						letter1 = "J";
						letter2 = "Q";
					} else if (_loc2.goHole("k")) {
						letter1 = "K";
						letter2 = "P";
					} else if (_loc2.goHole("l")) {
						letter1 = "L";
						letter2 = "O";
					} else if (_loc2.goHole("m")) {
						letter1 = "M";
						letter2 = "N";
					} else if (_loc2.goHole("n")) {
						letter1 = "N";
						letter2 = "M";
					} else if (_loc2.goHole("o")) {
						letter1 = "O";
						letter2 = "L";
					} else if (_loc2.goHole("p")) {
						letter1 = "P";
						letter2 = "K";
					} else if (_loc2.goHole("q")) {
						letter1 = "Q";
						letter2 = "J";
					} else if (_loc2.goHole("r")) {
						letter1 = "R";
						letter2 = "I";
					} else if (_loc2.goHole("s")) {
						letter1 = "S";
						letter2 = "H";
					} else if (_loc2.goHole("t")) {
						letter1 = "T";
						letter2 = "G";
					} else if (_loc2.goHole("u")) {
						letter1 = "U";
						letter2 = "F";
					} else if (_loc2.goHole("v")) {
						letter1 = "V";
						letter2 = "E";
					} else if (_loc2.goHole("w")) {
						letter1 = "W";
						letter2 = "D";
					} else if (_loc2.goHole("x")) {
						letter1 = "X";
						letter2 = "C";
					} else if (_loc2.goHole("y")) {
						letter1 = "Y";
						letter2 = "B";
					} else if (_loc2.goHole("z")) {
						letter1 = "Z";
						letter2 = "A";
					}
					if ((wordStatus == "") || (wordStatus == undefined)) {
						if (_loc2.goHole("g")) {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a 'ding' noise is heard. It must have been the right letter, because the "+letter2+" is now in one of the RECTANGLES below the brain picture. But there's still more empty rectangles... what letter should fill in the next one?");
							wordStatus = "T";
						} else {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a buzzer sounds. Apparently you didn't choose the right hole.");
						}
					} else if (wordStatus == "T") {
						if (_loc2.goHole("z")) {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a 'ding' noise is heard. It must have been the right letter, because the "+letter2+" is now in one of the RECTANGLES below the brain picture. But there's still more empty rectangles... what letter should fill in the next one?");
							wordStatus = "TA";
						} else {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a buzzer sounds. The letters spelled out in the RECTANGLES disappear. Apparently you didn't choose the right hole.");
							wordStatus = "";
						}
					} else if (wordStatus == "TA") {
						if (_loc2.goHole("n")) {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a 'ding' noise is heard. It must have been the right letter, because the "+letter2+" is now in one of the RECTANGLES below the brain picture. But there's still more empty rectangles... what letter should fill in the next one?");
							wordStatus = "TAM";
						} else {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a buzzer sounds. The letters spelled out in the RECTANGLES disappear. Apparently you didn't choose the right hole.");
							wordStatus = "";
						}
					} else if (wordStatus == "TAM") {
						if (_loc2.goHole("k")) {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a 'ding' noise is heard. It must have been the right letter, because the "+letter2+" is now in one of the RECTANGLES below the brain picture. But there's still more empty rectangles... what letter should fill in the next one?");
							wordStatus = "TAMP";
						} else {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a buzzer sounds. The letters spelled out in the RECTANGLES disappear. Apparently you didn't choose the right hole.");
							wordStatus = "";
						}
					} else if (wordStatus == "TAMP") {
						if (_loc2.goHole("l")) {
							this.put("You go down the hole marked with the letter L. After a moment of wandering in pitch darkness, you find yourself reentering the room through the O hole. The O letter flashes briefly, but then it stops as a 'ding' noise is heard. The rectangles now spell T-A-M-P-O. Congratulations, you got that puzzle beat!");
							this.put("\n\nThe engravings of the brain and the rectangles now glow all rainbow like, and then flip around to reveal a new hole, this one unmarked. But suddenly a rumbling noise is heard all around as the room begins to quake. All the little blueberry guys seem alarmed and start beeping nervously. Suddenly the walls, floor and roof begin to close in on you all as the room begins to shrink. Before it's too late, you zip through the new hole and pierce the darkness through it.");
							wordStatus = "TAMPO";
							curMode = "room";
							Game.scorePoints(1);
							pressEnterCallbackFunc = postTampo;
							Game.addPause();
						} else {
							this.put("You go down the hole marked with the letter "+letter1+". After a moment of wandering in pitch darkness, you find yourself reentering the room through the "+letter2+" hole. The "+letter2+" letter flashes briefly, but then it stops as a buzzer sounds. The letters spelled out in the RECTANGLES disappear. Apparently you didn't choose the right hole.");
							wordStatus = "";
						}
					}
				}
				return;
			}
		} else if (curMode == "room") {
			if (_loc2.isLookAt("door")) {
				this.put("It's one of those large ones you see often in a warehouse. It doesn't look like you'll be getting through with a key for its KEYHOLE. Too bad though, as it's marked with an 'EXIT' sign.");
				return;
			}
			if (_loc2.isLookAt("keyhole")) {
				this.put("Looks like one of those old fashioned keyholes that you need those toothed keys to use. Where will you get one of those to match?");
				return;
			}
			if ((_loc2.isUse("keyhole")) || (_loc2.isUse("key"))) {
				if (!key) {
					this.put("You have to get the KEY first, mister.");
				} else {
					this.put("You heard to the keyhole and the key automatically floats right in the lock, turns, and releases the door. The door opens slowly and now it's just waiting for you to GO NORTH...");
					door = true;
				}
				return;
			}
			if (_loc2.isLookAt("cheese")) {
				this.put("It's a slice of Swiss cheese laying on the floor. Nothing of interest any more.");
				return;
			}
			if (_loc2.isEat("cheese")) {
				this.put("a) You're a brain. Eating is not an activity that brains partake in.");
				this.put("\nb) It's probably not the best idea to eat the physics-defying cheese. Just let it be.");
				return;
			}
			if (_loc2.isOpen("door")) {
				if (door) {
					this.put("It's already opened. Just GO NORTH.");
				} else {
					if (!key) {
						this.put("No can do. It's fortified with the power of the virus. The only way you'll be going through is with a key.");
					} else {
						this.put("How about you try using the KEYHOLE, hmm?");
					}
				}
				return;
			}
			if (_loc2.isGo("north")) {
				if (door) {
					this.put("You excitedly hurry north and out of the prison. Soon you are free to explore the messed up caverns of the lava zone! And look, your personal chamber is just ahead. It must have warped you here. But right behind you are two more large glitchy prisons where your two friends must be locked up. Can they get out?");
					this.put("\n\nWell, they have to. Let's try with Brody now...");
					GameState.key = false;
					Game.scorePoints(3);
					pressEnterCallbackFunc = postExit;
					Game.addPause();
				} else {
					if (!key) {
						this.put("No can do. It's fortified with the power of the virus. The only way you'll be going through is with a key.");
					} else {
						this.put("How about you try using the KEYHOLE, hmm?");
					}
				}
				return;
			}
			if ((_loc2.isUse("door")) || (_loc2.isShoot("door")) || (_loc2.useLaserball("door")) || (_loc2.isForce("door"))) {
				if (door) {
					this.put("Stop worrying about the door. It's open. Just GO NORTH.");
				} else {
					if (!key) {
						this.put("How about you try using the KEYHOLE, hmm?");
					} else {
						this.put("No can do. It's fortified with the power of the virus. The only way you'll be going through is with a key.");
					}
				}
				return;
			}
			if ((_loc2.isTake("cheese")) || (_loc2.isUse("cheese"))) {
				this.put("Nah, it's smelly.");
				return;
			}
			if ((_loc2.contains("crate")) && (!_loc2.contains("blueberries"))) {
				if (crate == "moved") {
					this.put("The blueberry-stained crate is lying harmlessly against a side of the room. You can leave it alone now.");
				} else {
					if (_loc2.isLookAt("crate")) {
						this.put("It's one of those large wooden crates. Goes with the warehouse theme maybe? It's about your size and looks very heavy, but something on the inside tells you it needs to be moved. Maybe you should try to PUSH it?");
						return;
					} else if ((_loc2.isUse("crate")) || (_loc2.isOpen("crate"))) {
						this.put("You can't seem to find a way to open it, so you can't really use it for storing things.");
						return;
					} else if (_loc2.isTake("crate")) {
						this.put("You can barely move it, much less carry it around.");
						return;
					} else if (_loc2.isShoot("crate")) {
						this.put("That won't work.");
						return;
					} else if ((_loc2.isPush("crate")) || (_loc2.isMove("crate"))) {
						if (blueberry != "pushing") {
							this.put("You go up to it and start pushing the crate with all you got, but it simply is too heavy. It stays firmly in place. You just need more manpower... or whatever you want to call those BLUEBERRY things.");
						} else {
							this.put("You join your blueberry minions with pushing. You close your eyes and shove with all your might. It's very hard, but after a few seconds of brain-breaking effort, it starts to slide sideways. With newfound strength, you manage to push the crate several yards before stopping.");
							this.put("\n\nBut when you open your eyes you make a terrible discovery. There are blueberry stains all over the crate! Have all of your blueberry minions sacrificed themselves trying to follow through on your crazy commands? There aren't any floating around... Too bad for them.");
							pressEnterCallbackFunc = postCrate;
							Game.addPause();
						}
					} else {
						DontUnderstand.parse(this);
					}
				}
				return;
			}
			if ((_loc2.contains("blueberries")) || (_loc2.contains("minions"))) {
				if (blueberry == "dead") {
					this.put("They are nothing but stains splattered against the crate, I'm afraid.");
				} else {
					if (_loc2.isLookAt("blueberries")) {
						if (blueberry == "team") {
							this.put("They're your happy green-eyed BLUEBERRY minions that seem almost too eager to obey you. Right now they're just floating in an upper corner of the room. Maybe you should give them an ORDER?");
						} else if (blueberry == "pushing") {
							this.put("They're your happy green-eyed BLUEBERRY minions that seem almost too eager to obey you. Right now they're all trying to push the CRATE out of the way, but it seems that they need a little help.");
						} else {
							this.put("They are nothing but stains splattered against the crate, I'm afraid.");
						}
					} else if ((_loc2.isMove("blueberries")) || (_loc2.isPush("blueberries"))) {
						this.put("That's not nice.");
					} else if ((_loc2.isUse("blueberries")) || (_loc2.isTake("blueberries")) || (_loc2.isArgue("blueberries"))) {
						this.put("They seem eager to serve, but your going to have to specifically ORDER them to do something. Just like you ordered Brody and Stlunko earlier!");
					} else if (_loc2.isShoot("blueberries")) {
						this.put("No, you don't want them to switch back into the red-eye mode.");
					} else if (_loc2.haveBlueberries()) {
						if ((blueberry == "pushing") && (!_loc2.contains("stop"))) {
							this.put("They are currently preoccupied in trying to move the CRATE. You’ll have to tell them to STOP before they can do anything else.");
						} else {
							if ((_loc2.haveBlueberries()) && ((_loc2.contains("open")) || (_loc2.contains("push")) || (_loc2.contains("unlock")) || (_loc2.contains("use"))) && ((_loc2.isEnd("door")) || (_loc2.isEnd("keyhole")))) {
								this.put("They float towards the door and try to open it with all their might, by physically pushing it up and by picking the lock with their blobbiness. But it's not working. When one of them pops trying to pick the lock, you call them off.");
							} else if ((_loc2.haveBlueberries()) && (_loc2.isEnd("cheese"))) {
								this.put("They don't seem interested in the cheese at all. In fact, they seem to be slightly scared of it. I guess almost getting squished scarred them a little.");
							} else if ((_loc2.haveBlueberries()) && ((_loc2.contains("push")) || (_loc2.contains("move"))) && (_loc2.isEnd("crate"))) {
								if (blueberry == "team") {
									this.put("You order all the BLUEBERRY flavoured blobs to start pushing the crate. They all get on one side and start pushing together with all their might. They're just barely not strong enough. They need a little help.");
									blueberry = "pushing";
								} else {
									this.put("They're already pushing the crate.");
								}
							} else if ((_loc2.haveBlueberries()) && (_loc2.contains("stop"))) {
								if (blueberry == "pushing") {
									this.put("You tell them to stop and they all let go with a sigh. They happily float back to their little corner.");
									blueberry = "team";
								} else {
									this.put("Maybe you should get them to do something before get them to stop doing whatever it is you're trying to get them to stop do before they start doing it. Oop.");
								}
							} else if (((_loc2.isStart("order")) || (_loc2.isStart("tell")) || (_loc2.isStart("command")) || (_loc2.isStart("have")) || (_loc2.isStart("make"))) && ((_loc2.isEnd("blueberries")) || (_loc2.isEnd("minions")))) {
								this.put("Pick a specific task, dood.");
							} else {
								this.put("They can't do that. Try something else.");
							}
						}
					} else if (_loc2.isHelp("blueberries")) {
						if (blueberry == "pushing") {
							this.put("You join your blueberry minions with pushing. You close your eyes and shove with all your might. It's very hard, but after a few seconds of brain-breaking effort, it starts to slide sideways. With newfound strength, you manage to push the crate several yards before stopping.");
							this.put("\n\nBut when you open your eyes you make a terrible discovery. There are blueberry stains all over the crate! Have all of your blueberry minions sacrificed themselves trying to follow through on your crazy commands? There aren't any floating around... Too bad for them.");
							pressEnterCallbackFunc = postCrate;
							Game.addPause();
						} else {
							DontUnderstand.parse(this);
						}
					} else {
						DontUnderstand.parse(this);
					}
				}
				return;
			}
			if (_loc2.contains("down")) {
				if (!escaped) {
					if ((_loc2.isGo("down")) || (_loc2.isExplore("down"))) {
						if (crate == "moved") {
							this.put("You go down the hole and everything is pitch black. Suddenly, to your horror, the opening above slams shut. That can't be good! You turn around and see a glowing green fog approaching and it soon overtakes you. It makes everything foggy and groggy... are you falling asleep?");
							pressEnterCallbackFunc = postHole;
							Game.addPause();
						} else {
							DontUnderstand.parse(this);
						}
					} else if (_loc2.isLookAt("down")) {
						if (crate == "moved") {
							this.put("Much like the cheese-holes, it's pitch black, and you can't see a thing. Guess you'll have to GO DOWN and see for yourself.");
						} else {
							DontUnderstand.parse(this);
						}
					} else {
						DontUnderstand.parse(this);
					}
				} else {
					this.put("It is very much closed. Guess you won't have to go down that weird thing again.");
				}
				return;
			}
			if (_loc2.isLookAt("key")) {
				if (!key) {
					this.put("That would make things so much easier, wouldn't it? Go embrace your lack of key elsewhere.");
				} else {
					this.put("It's one of those metal toothed keys. Perfect!");
				}
				return;
			}
			if (_loc2.isTake("key")) {
				if (!key) {
					this.put("Didn't you read the instructions? This is not a game for babies and sucklings!");
				} else {
					this.put("You already got it, brainiac.");
				}
				return;
			}
		} else if (curMode == "dungeon") {
			if (nameEnter) {
				if (_loc2.is("tampo")) {
					this.put("Nay, not ye maiden name. We need to knowst thou DUNGEONNAME!");
				} else {
					this.put("Ah, yes. "+GameState.dungeonName+". A ploppy name. (>.-.)> Anyhoo. Like I mentionedeth: a Cell.");
					nameEnter = false;
					GameState.nameEnter = false;
				}
				return;
			} else {
				if (_loc2.is("self")) {
					this.put(GameState.dungeonName + ":");
					if (!loincloth) {
						this.put("\n\nThou are unduly naked.");
					}
					this.put("\n\nThy hitpoints are 1.");
					if (nose) {
						this.put("\n\nThou art holding thy nose quite firmly.");
					}
					this.put("\n\nThy score is "+GameState.score+" out of a possible "+GameState.maxScore+".");
				} else if (_loc2.is("help")) {
					this.put("Type LOOK to see thy surroundings. Type INVENTORY to see thy worldly possessions. Type SELF to check thy status.");
				} else if (_loc2.is("dan")) {
					this.put("Dan's okay. He's goin back to junior college in the fall. Maybe get a job. Then who knows.");
				} else if (_loc2.is("dance")) {
					this.put("Ye puts thine point on ye floor and just grooves it.");
				} else if (_loc2.is("dennis")) {
					this.put("Ye hasn't seen Dennis in a fortmoonnast. Maybe luck is on your side.");
				} else if (_loc2.is("die")) {
					this.put("That wasn't very smart.");
					GameState.score = -100;
					Game.updateScoreString();
					Game.die();
				} else if (_loc2.isStart("go")) {
					this.put("Nah. Ye've been there already. The rides are boring and the lines are long.");
				} else if ((_loc2.isStart("get")) || (_loc2.isStart("take"))) {
					if ((_loc2.is("get dagger")) || (_loc2.is("take dagger"))) {
						this.put("Not this thyme, friend.");
					} else if ((_loc2.is("get flask")) || (_loc2.is("get ye flask")) || (_loc2.is("take flask")) || (_loc2.is("take ye flask"))) {
						this.put("Ye wish. If there was a flask in this game, we wouldst know about it.");
					} else if ((_loc2.is("get pot")) || (_loc2.is("get chamber pot"))) {
						if (key) {
							this.put("There is nothing left to discover here. Thou must trust us on this one.");
						} else {
							this.put("You pluck it up and its contents slosh around in a foul manner. You hear the TINKLE of metal inside it. The odor grosses thou out so you put the chamber pot back down.");
						}
					} else if (_loc2.is("get hay")) {
						if (bread) {
							this.put("If thou only hadst a brain, thou would remember searching it quite thoroughly already.");
						} else {
							this.put("You decideth to get some hay and grabs ye a handful. What ho! Within the handful of hay lies a spot of MOLDY BREAD. You discard the hay and gently slide the moldy bread into your loin-cheese cloth. Eww.");
							Game.scorePoints(0);
							bread = true;
						}
					} else if (_loc2.is("get tinkle")) {
						if ((nose) && (!key)) {
							this.put("Grody. You reacheth into someone else's filth and pilfer out a small KEY. Drat. You were hoping it was a spare gilderupee.");
							Game.scorePoints(1);
							key = true;
							GameState.key = true;
						} else if ((!nose) && (!key)) {
							this.put("No way. It stinketh so bad. Perhaps if you couldn't smell of it...");
						} else if (key) {
							this.put("Thou already has the contents of the pot. Let's not make matters worse.");
						}
					} else if ((_loc2.is("take off cloth")) || (_loc2.is("take off loincloth")) || (_loc2.is("take off cheesecloth")) || (_loc2.is("remove cloth")) || (_loc2.is("remove loincloth")) || (_loc2.is("remove cheesecloth")) || (_loc2.is("take off clothes")) || (_loc2.is("remove clothes")) || (_loc2.isStart("undress"))) {
						if (loincloth) {
							this.put("Thou art as naked as the day God made thee.");
							loincloth = false;
						} else {
							this.put("A grand idea but for that thou hast already removed the loin-cheesecloth.");
						}
					} else {
						this.put("That's not something we want you to get. You'll break it.");
					}
				} else if (_loc2.isStart("give")) {
					this.put("Just like ye to giveth away something thou doesn't have. And ye STILL has my Gameboy.");
				} else if (_loc2.is("pwd")) {
					this.put("~dungeonman/DUNGEON/thydungeon");
				} else if (_loc2.isStart("talk")) {
					this.put("You wish thou person was here. God, that's all ye ever talketh about anymore.");
				} else if (_loc2.isStart("look")) {
					if (_loc2.is("look")) {
						this.put("Ye find yeself in yon cell. There ist a barred WINDOW, a firmly shut DOOR, some HAY, and a CHAMBER POT.");
					} else if (_loc2.is("look door")) {
						this.put("Barred shut. Looks like thou will have to open it to get out, at the very least.");
					} else if (_loc2.is("look hay")) {
						this.put("Boooring!");
					} else if (_loc2.is("look window")) {
						this.put("You make up what's out there. We already told thou it's barred. Giveth us a break, huh?");
					} else if ((_loc2.is("look chamber pot")) || (_loc2.is("look pot"))) {
						this.put("Looks like an old mustard pot. Or MAYBE mustard pots look like old chamber pots! Zounds! You stoppeth this line of thought as thou art a big mustard eater.");
					} else if ((_loc2.is("look cloth")) || (_loc2.is("look loincloth")) || (_loc2.is("look cheesecloth"))) {
						if (loincloth) {
							this.put("Eww. It smelleth as though it could use a good washing. It's keeping thee warm and ... well, warm at least.");
						} else {
							this.put("Eww. It smelleth as though it could use a good washing. I hope it does not alarm thou to mention that thou art not actually wearing it, friend.");
						}
					} else if (_loc2.is("look key")) {
						if (!key) {
							this.put("Clever, but no. You don't have one.");
						} else {
							this.put("It is key-shaped. Ye supposeth something could be unlocked with it. Thou wert always the clever dungeonman.");
						}
					} else {
						this.put("Dunno what that is. Thou liveth in thine own fantasy world.");
					}
				} else if ((_loc2.is("breathe")) || (_loc2.is("release nose")) || (_loc2.is("let go of nose")) || (_loc2.is("unplug nose")) || (_loc2.is("smell"))) {
					if (nose) {
						this.put("Phew! You let thy nostrils open forthwith and breatheth in the dungeon dankeries. Mmmm. Good dankeries!");
						nose = false;
					} else {
						this.put("A splendid idea, my good steward, were thou indeed holding thy nose.");
					}
				} else if ((_loc2.is("hold nose")) || (_loc2.is("hold breath"))) {
					if (nose) {
						this.put("Thou art already holding thy nose. Thou art running out of hands.");
					} else {
						this.put("Thou holds thy nostrils shut. Now all thou smells is the innards of thy nose. Smells like mutton.");
						nose = true;
					}
				} else if ((_loc2.is("put on clothes")) || (_loc2.is("put on cloth")) || (_loc2.is("put on loincloth")) || (_loc2.is("put on cheesecloth")) || (_loc2.is("wear cloth")) || (_loc2.is("wear loincloth")) || (_loc2.is("wear cheesecloth")) || (_loc2.is("wear clothes")) || (_loc2.isStart("dress"))) {
					if (loincloth) {
						this.put("Playing dress-up again? Thou art already wearing it.");
					} else {
						this.put("A good idea for now. The draught is withering.");
						loincloth = true;
					}
				} else if (_loc2.is("sniff")) {
					if (nose) {
						this.put("Not with thy nose held. Garbage in, garbage out.");
					} else {
						this.put("Art thou wearing Wumpus, the new fragrance by Monarch?");
					}
				} else if ((_loc2.is("open door")) || (_loc2.is("unlock door"))) {
					if (key) {
						this.put("Ye unlock the door and step outside thy dungeon cell... Everything is going foggy all around! It's as if ye very world is a blur...");
						pressEnterCallbackFunc = postEscape;
						Game.addPause();
					} else {
						this.put("It appears to be very locked. Bizarre.");
					}
				} else if (_loc2.is("inv")) {
					if ((!key) && (!bread) && (!loincloth)) {
						this.put("Thou has nothing.");
					} else {
						if (bread) {
							this.put("Thou has moldy BREAD.\n\n");
						}
						if (key) {
							this.put("Thou has a filthy KEY.\n\n");
						}
						if (loincloth) {
							this.put("Thou has thy loin-cheese CLOTH.");
						}
					}
				} else {
					this.put("That does not computeth. Type HELP is thou needs of it.");
				}
			}
			return;
		}
		if (curMode != "dungeon") {
			if (this.superClassParse()) {
				return;
			}
			DontUnderstand.parse(this);
		}
	}
	function look() {
		if (firstTime == undefined) {
			this.put("You, as Tampo, suddenly find yourself in a yellow room covered in black HOLES. The room is shaped like a large triangular prism, and you can't see anyway out other than the holes. They're completely black so you can't see anything out of them, and they are just your size. They are each marked with a LETTER of the alphabet, from A to Z. Maybe you should try to GO in one?");
			this.put("\n\nBesides the holes, there is a section of the wall which features an engraving of a human BRAIN. Maybe it's yourself? Right below it are five RECTANGLES side-by-side. And there is a steady stream of small evil looking BLUEBERRIES, all with glowing red eyes, going out of the 'O' hole and into the 'L' hole. They don't seem to acknowledge your presence though.");
			this.put("\n\nHow mysterious of a puzzle. Time to figure it out!");
			firstTime = false;
			wordStatus = undefined;
			letter1 = undefined;
			letter2 = undefined;
			blueberry = "angry";
			curMode = "start";
			crate = "hole";
			key = false;
			door = false;
			escaped = false;
		} else {
			if (curMode == "start") {
				if (blueberry == "angry") {
					this.put("You are in a yellow triangular room littered with twenty-six black HOLES, each of which are marked with a different LETTER of the alphabet. A steady stream of evil red-eyed BLUEBERRIES is flowing out of the 'O' hole and into the 'L' hole. Along a wall is engraved a picture of a human BRAIN with five rectangles beneath it. You can try going through the holes, as they seem to be your only way out.");
				} else if (blueberry == "happy") {
					this.put("You are in a yellow triangular room littered with twenty-six black HOLES, each of which are marked with a different LETTER of the alphabet. A steady stream of happy green-eyed BLUEBERRIES is flowing out of the 'O' hole and into the 'L' hole. Along a wall is engraved a picture of a human BRAIN with five rectangles beneath it. You can try going through the holes, as they seem to be your only way out.");
				} else {
					this.put("You are in a yellow triangular room littered with twenty-six black HOLES, each of which are marked with a different LETTER of the alphabet. The BLUEBERRIES are scattered about and now appear to be loyal to you. Along a wall is engraved a picture of a human BRAIN with five rectangles beneath it. You can try going through the holes, as they seem to be your only way out.");
				}
			} else if (curMode == "room") {
				if (crate == "hole") {
					this.put("You're now in a large metal room. To the NORTH is a large warehouse DOOR with a keyhole and exit sign. Besides that there is the piece of CHEESE lying around that you used to be trapped in, and a large heavy wooden CRATE in the middle of the room that obviously needs moving. Your BLUEBERRY minions are waiting for orders in a corner of the room. What now?");
				} else if (crate == "push") {
					this.put("You're now in a large metal room. To the NORTH is a large warehouse DOOR with a keyhole and exit sign. Besides that there is the piece of CHEESE lying around that you used to be trapped in, and a large heavy wooden CRATE in the middle of the room that obviously needs moving. Your BLUEBERRY minions are trying to push the crate across the room, but making little progress.");
				} else if (crate == "moved") {
					this.put("You're now in a large metal room. To the NORTH is a large warehouse DOOR with a keyhole and exit sign. Besides that there is the piece of CHEESE lying around that you used to be trapped in. There's also the large blueberry-stained CRATE in the side of the room that you managed to move. There is now a mysterious HOLE lying in the center of the room that you can fit through.");
				}
			}
		}
		return;
	}
	function postTampo() {
		this.put("You pop out in a large metal box of a room. All around you are identical-looking gray walls of metalic textures. The only thing really noteworthy is a large warehouse DOOR on the NORTH side. It features a keyhole and a red \"EXIT\" sign. Alright, looks like you'll have to find a key to leave this challenge. Surprising, no?");
		this.put("\n\nElsewhere around the room is your old yellow prison, of which all the BLUEBERRY guys are hurriedly leaving as it continues to shrink. Soon all of them are out and floating about in a corner, and the old room is nothing more than a bite-size morsel lying on the floor. Turns out it was just a slice of Swiss cheese all along!");
		this.put("Oh, and there's a large heavy wooden CRATE in the very middle of the room. You might want to try moving that.");
		return;
	}
	function postExit() {
		GameState.inControl = "brody";
		Game.newRoom("puzzle_brody");
		return;
	}
	function postCrate() {
		this.put("Where the crate used to lie is now a large square HOLE right in the ground, with yellow and black stripes bordering it. You'll be able to fit, so why don't you GO DOWN there and check it out? Maybe you'll find the key.");
		crate = "moved";
		blueberry = "dead";
		return;
	}
	function postHole() {
		curMode = "dungeon";
		this.put("Thou awake in a dungeon. There ist a barred WINDOW and a DOOR, some HAY and a CHAMBER POT. Thou wearest only a loincloth made of cheesecloth. It is a loin-cheese cloth. Thou rememberest little other than thine own name. By the way, what ist thy name again?");
		nameEnter = true;
		GameState.nameEnter = true;
		nose = false;
		loincloth = true;
		key = false;
		bread = false;
	}
	function postEscape() {
		curMode = "room";
		escaped = true;
		this.put("You suddenly wake up. You're back in the metal room. What was that? Was it all a dream? Hmm... the room appears to be just as you left it, except the hole in the ground is closed. Oh, what's this? The key you found in your dream is circling around you! It wasn't a dream! Okay, time to unlock that KEYHOLE...");
	}
}
