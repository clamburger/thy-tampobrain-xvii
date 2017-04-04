class Room_lavalake extends Room {
	var synonyms, put, superClassParse, pressEnterCallbackFunc, firstTime;
	function Room_lavalake () {
		super();
		synonyms.push(new Array("push", "shove", "nudge", "ram"));
		synonyms.push(new Array("bomb", "explosives", "explosive"));
		synonyms.push(new Array("streams", "stream", "flows", "flow"));
		synonyms.push(new Array("pool", "lake"));
		synonyms.push(new Array("roof", "sky", "up", "forest", "opening"));
		synonyms.push(new Array("platform", "rock", "island"));
		GameState.lookFriends = true;
	}
	function getName() {
		return ("Caldera of Vastness");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("bubbles")) {
			this.put("Bubbly!");
			return;
		}
		if (_loc2.isGoNS("up")) {
			this.put("Against common sense, you go up and out of the Caldera and inevitably get lost in the woods, with the canopy too thick to float out of. You probably die of exhaustion, or paralyzing pain from within, or going insane, or maybe getting eaten by a wild animal. I dunno. At any rate, you're dead.");
			Game.die();
			return;
		}
		if ((_loc2.isEnd("bomb")) && (!_loc2.isStart("look"))) {
			if (GameState.stlunkoStatus == "none") {
				this.put("Err... you should probably TALK to Stlunko about it first before messing with it.");
				return;
			} else if (GameState.stlunkoStatus == "talked") {
				if (_loc2.isUse("bomb")) {
					this.put("Nah. The less exploded the lava zone is, the better. Besides, it's broken.");
					return;
				} else if (_loc2.isPush("bomb")) {
					this.put("Using your vast intelligence, you get down low and carefully push the bomb across the platform and into Stlunko's reach. As soon as it gets in range, Stlunko's hand grabs it and carries it back. Yippie, puzzle solved! Time to go get Stlunko to join you on whatever it is you're doing.");
					GameState.stlunkoStatus = "bomb";
					return;
				} else if (_loc2.isShoot("bomb")) {
					this.put("That doesn't exactly sound like the smartest thing to do to a bomb, but you throw common sense out the window and do it anyway. The electricity fizzes all over the bomb, but fortunately it doesn't go off. Oh that's right, the wires are cut. And possibly even further damaged from the heat.");
					this.put("\n\nIt didn't move very much though. Many you should try a more physical approach like pushing or something.");
					return;
				} else if ((_loc2.isTake("bomb")) || (_loc2.isMove("bomb"))) {
					this.put("How exactly do you plan on doing that? Laserball power?");
					return;
				} else {
					DontUnderstand.parse(this);
					return(false);
				}
			} else {
				this.put("Stlunko's got it now.");
				return;
			}
		}
		if (_loc2.isLookAt("west")) {
			this.put("The lava hasn't filled up this side of the room. There seems to be a path down here. Not a natural one like the lava flows; this one was carved out by someone. And it's big enough for even Stlunko, so it's probably how he got here.");
			return;
		}
		if (_loc2.isPush("stlunko")) {
			this.put("You give Stlunko a good ol' friendly shove in the rear. He then proceeds to accidentally topple into the lava and die. Oopsie.");
			this.put("\n\nYou then die of sadness and misery. Or karma. At any rate, you're dead.");
			Game.die();
			return;
		}
		if (_loc2.isShoot("stlunko")) {
			this.put("For no apparent raisin, you fire a laserball at Stlunko. Unfortunately, it hits his antenna, and he's stunned to the point that he falls in the lava. You decide to dive in after him, but then you realise that lava kills you. Duh.");
			Game.die();
			return;
		}
		if (_loc2.isLookAt("bomb")) {
			if (GameState.stlunkoStatus == "none") {
				this.put("It's the bomb you diffused a few emails back. Didn't that thing burn in the lava? Looks like Stlunko still wants it, but he just can't reach it. It beached itself on the far end of the relatively small platform, and Stlunko's radio can't quite get to it. If only it could be moved to the closer end of the platform...");
			} else if (GameState.stlunkoStatus == "talked") {
				this.put("It's the bomb you diffused a few emails back. Stlunko wants it, but he can't quite reach it. Looks like you'll have to find a way to get it closer...");
			} else if (GameState.stlunkoStatus == "bomb") {
				this.put("Stlunko's closely observing it at the moment. It's still as broken as ever.");
			} else {
				this.put("Stlunko has it invisibly tucked away in one of his compartments.");
			}
			return;
		}
		if (_loc2.isHelp("stlunko")) {
			this.put("You're gonna have to be a bit more specific, palbert.");
			return;
		}
		if (_loc2.isGoNS("streams")) {
			this.put("The only one you're going in is the one you used to get in here. It's due SOUTH, so go there.");
			return;
		}
		if (_loc2.isLookAt("south")) {
			this.put("Many lava tunnels spread out in that direction, particularly yours. That's the only one you'll be going through. Too bad Stlunko won't be able to get in there; he'll have to take another route.");
			return;
		}
		if (_loc2.isLookAt("streams")) {
			this.put("They branch out from the pool and flow SOUTH out of the crater through tunnels in the earth that they probably carved themselves. Most of the crawlspaces are too tiny, but yours happens to be one of the larger ones and you can easily indentify it. And that's the only one you'll be going through. Stlunko won't be able to fit though, so he'll have to take another route.");
			return;
		}
		if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
			this.put("You head towards the lava and decide to sit in it. You feel warmth as it flows over your soft, gooey brain. You then remember that you can\'t survive in lava. For a brain, you aren\'t very smart. You die.");
			Game.die();
			return;
		}
		if (_loc2.isTalk("stlunko")) {
			if (GameState.stlunkoStatus == "none") {
				this.put("***LONG TALK WARNING!***");
				this.put("\n\n\"Hey Stunks, how ya doing?\" you splurt.");
				pressEnterCallbackFunc = postStlunkoOne;
				Game.addPause();
			} else if (GameState.stlunkoStatus == "talked") {
				this.put("What, do you want another point? No more talking for now. Stlunko just needs you to get the BOMB laying on the platform into his hand's range. It shouldn't be that hard, really.");
			} else if (GameState.stlunkoStatus == "bomb") {
				this.put("\"Alright Stlunko, you got your bomb thing. Can you help me... check my email? And possibly have an adventure?\" you say.");
				this.put("\n\n\"Yes. Let us do this. As long as this evidence stays intact,\" he replies, storing the bomb inside one of the compartments in his back.");
				this.put("\n\nStlunko joined your party! Yay! His vast knowledge and strong hands may almost certainly come in handy in your quest thing!");
				GameState.stlunkoStatus = "party";
				Game.scorePoints(3);
			} else {
				this.put("You ask Stlunko \"What's up?\" and he starts to babble about the metaphysics of the universe and the capacities it holds to expand onward and how he cannot give definite and exact answer to what is \"up\". That's our Stlunko!");
			}
			return;
		}
		if (_loc2.isUse("stlunko")) {
			if (GameState.stlunkoStatus != "party") {
				this.put("Nah. Not yet anyway.");
			} else {
				this.put("Specifics, man! General commands don't always work 'round her.");
			}
			return;
		}
		if (_loc2.isLookAt("platform")) {
			if (GameState.gameMode == "regular") {
				if ((GameState.stlunkoStatus == "none") || (GameState.stlunkoStatus == "talked")) {
					this.put("It's conveniently sticking out deep in the lava pool, just barely in Stlunko's reach. Unfortunately the BOMB it holds isn't, and Stlunko just can't grab it. If only it could get closer...");
				} else {
					this.put("It's as naked as you are.");
				}
			} else {
				this.put("It's distinctly un-squarelike. Saargtsson probably didn't build his secret lab under here, but you can HAVE STLUNKO try to OPEN it anyway, just in case.");
			}
			return;
		}
		if (_loc2.isLookAt("stlunko")) {
			if (GameState.stlunkoStatus == "none") {
				this.put("It's your good friend Stlunko. He's on the very edge of the fatal lava lake, and you can only see one of his hands. That's strange... oh wait, there it is. He's straining it as far as the radio signal can go to reach the defused BOMB perched on a platform in the middle of the lake. But it's not good enough, as it can't barely reach it as it lies on the far end of the platform. He sees you and gives you some sort of nod with his eyes.");
			} else if (GameState.stlunkoStatus == "talked") {
				this.put("It's your good friend Stlunko. He's on the very edge of the fatal lava lake, and he seems to be waiting for you to do something for him.");
			} else if (GameState.stlunkoStatus == "bomb") {
				this.put("Well, he's got his bomb. Now he's just studying it carefully and stuff, like detective-types do. You should probably TALK to him and get him to help you check your email.");
			} else {
				this.put("He's wide, shiny and make of metal. It's Stlunko! He has hands. Ain't that great?");
			}
			return;
		}
		if ((_loc2.isLookAt("lake")) || (_loc2.isLookAt("lava"))) {
			if ((GameState.stlunkoStatus == "none") || (GameState.stlunkoStatus == "talked")) {
				this.put("It's bigger than any lava lake you've ever seen, or even the water ones. But then again you haven't seen many. It's the leftover lava from the volcano that exploded, and apparently it's still being fed and it's continously releasing many different streams SOUTH into the lava zone, including the one that flows through your personal chamber. Deep in the lake lies a small platform of rock with the diffused BOMB on it.");
			} else {
				this.put("It's all bubbly and is flowing out in many streams. An empty, small rock platform is on the far side. The many bubbles coming out in the center gives you the idea that this is where all the lava is pumped from Planet K's core and into the Lava Zone. Isn't that amazing?!");
			}
			return;
		}
		if (_loc2.isGo("west")) {
			if (GameState.stlunkoStatus == "bomb") {
				this.put("You should probably get Stlunko to join you first. Go TALK to him.");
			} else {
				Game.newRoom("corridor_north");
			}
			return;
		}
		if ((_loc2.isLookAt("up")) || (_loc2.isLookAt("sky")) || (_loc2.isLookAt("forest"))) {
			this.put("Wow, a lava room in broad daylight. That's a new one. Looks like there used to be a volcano here a long time ago before it exploded in a big fiery ball that was visible from space. So there's no roof, just open sky and sunlight, and beyond that, forest. And if you go the wrong way, paralyzing pain from an implanted chip. It's a bit far from Challenge City. So you don't want to go up there. You'll probably die.");
			return;
		}
		if (_loc2.isGo("south")) {
			if (GameState.stlunkoStatus == "bomb") {
				this.put("You should probably get Stlunko to join you first. Go TALK to him.");
			} else {
				GameState.exitingRoom = "lavalake";
				Game.newRoom("spikes");
			}
			return;
		}
		if (_loc2.isLookAt("caldera")) {
			look();
			return;
		}
		if ((_loc2.isFlip("island")) || (_loc2.isOpen("island")) || (_loc2.isUse("island"))) {
			if (GameState.gameMode == "regular") {
				this.put("I can't possibly imagine why you'd want to do that.");
			} else {
				this.put("That's not really your forte. HAVE STLUNKO do it.");
			}
			return;
		}
		if ((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && ((_loc2.contains("flip")) || (_loc2.contains("open"))) && (_loc2.isEnd("island"))) {
			if (GameState.gameMode == "regular") {
				this.put("I can't possibly imagine why you'd want to do that.");
			} else {
				this.put("It's in the middle of a boiling pool of LAVA. He'd surely die!");
			}
			return;
		}
		if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && ((_loc2.contains("flip")) || (_loc2.contains("open"))) && (_loc2.isEnd("island"))) {
			if (GameState.gameMode == "regular") {
				this.put("I can't possibly imagine why you'd want to do that.");
			} else {
				if (!GameState.lavaIslandPull) {
					this.put("You give the order and Stlunko reaches over and grabs one of the island's edges and gives it a solid push and pull, but it's no use. The island is stuck tight and it's not going to come off for the likes of you. Try a different lava lake, like the one in the GOKUL FEEDING CHAMBER.");
					GameState.lavaIslandPull = true;
				} else {
					this.put("You give the order and Stlunko reaches over and grabs one of the island's edges and gives it a solid push and pull, but it doesn't budge. Stlunko pushes harder, and then the entire platform tilts over and splashes into the lava, creating a very large wave of lava which washes throughout the lava zone, killing most of the minions in some way. Some lava sprays out the top of the caldera and sets the forest on fire, and it eventually burns down. You, Brody and Stlunko are left standing there soaked in lava. It doesn't take long for your (brain?!) to register that you are dead. You die!");
					Game.die();
				}
			}
			return;
		}
		//trace("Room_lavalake parse");
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function postStlunkoOne() {
		this.put("\"Stunks?\" questions Stlunko.");
		this.put("\n\n\"Yup.\"");
		this.put("\n\n\"Oh. Well, right now I am trying to get the deactivated time bomb which nearly destroyed us a few weeks earlier, but I cannot quite reach it. My telekinetic link to my fist just barely does not make it,\" Stlunko says.");
		this.put("\n\n\"And I know you need it to track down whoever made it. So we can kill them, preferably,\" you state. \"But... uh... wasn't it dumped in the lava by Clampo?\"");
		pressEnterCallbackFunc = postStlunkoTwo;
		Game.addPause();
		return;
	}
	function postStlunkoTwo() {
		this.put("\"Strunko, actually,\" corrects your friend, \"But by utilizing my future self's advice, I successfully, to put it simply, tracked the bomb's time/space trail forward to discover it had not actually dissolved in the lava. It is mostly heat proof and got caught in a small backwards lava capillary, where it was brought back up here and washed up on that far platform.\"");
		this.put("\n\n\"I see. So do you need me to get it for you?\" you ask.");
		this.put("\n\n\"You lack the hands nessecary for such a task. But if you could find some way to put it within my range, I would appreciate it. And we would be one step closer in discovering the planter's identity,\" Stlunko says.");
		this.put("\n\n\"That doesn't sound hard,\" you reason.");
		pressEnterCallbackFunc = postStlunkoThree;
		Game.addPause();
		return;
	}
	function postStlunkoThree() {
		this.put("\"And once you get it, will you get out of here and help me check an email and have wacky adventures or whatever?\"");
		this.put("\n\n\"I suppose so. Briefly.\"");
		this.put("\n\n\"Cool.\"");
		this.put("\n\nOkay, the talking is over. Time to get that BOMB into Stlunko's range. And I'll give you a shiny little point for sitting through that.");
		Game.scorePoints(1);
		GameState.stlunkoStatus = "talked";
		return;
	}
	function postEntrance() {
		this.put("It doesn't take too many twists and turns for you to open up to a large exposed caldera. It's basically a large crater where a volcano exploded really badly so that there ain't no volcano no more. The crater's sides are too high and steep to make an easy exit for non-floaty types, but even if you wanted to go up and out of here, it's in the middle of some forest for you to get lost in and most certainly die.");
		this.put("\n\nInside the vast caldera is a large bubbly lava LAKE. Lava is emptying from it in various smallish streams, including the one you followed here, which flows out SOUTH. Maybe this is the source of all the lava in the zone? There is a large section of land to the west of the lake, including some sort of exit to the WEST. By the edge, you can see STLUNKO! Yay, you found him! But how did he get here? And on a far off rock platform in the lava lake is what looks like that BOMB you diffused a while earlier, and it seems that Stlunko's reaching for it.");
		GameState.caledraEntrance = 1;
		return;
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.gameMode == "regular") {
				if (GameState.caledraEntrance == 0) {
					this.put("You float above the winding river of lava. The cramped corridor is very hot, but fortunately the gokul armor keeps it bearable. You can't recall going down here much before, so the mysterious other side is expecially mysterious.");
					if (GameState.brodyStatus == "party") {
						this.put("\n\nBrody is forced to stay behind in the personal chamber.");
						GameState.brodyStatus = "away";
					}
					this.put("\n[PRESS ENTER]");
					pressEnterCallbackFunc = postEntrance;
					Game.addPause();
				} else {
					this.put("You twist and turn through the lava river's corridor before popping up back in the large exposed caldera again. This big crater's sides are high and steep, and there's no reason for you to float up and out as you'd just be stuck in a large forest. You're lucky to still be in that paralyzing chip's range as it is.");
					if ((GameState.stlunkoStatus != "party") && (GameState.stlunkoStatus != "away")) {
						this.put("Inside the vast caldera is a large bubbly lava LAKE. Lava is emptying from it in various smallish streams, including the one you followed here, which flows out SOUTH. There is a large section of land to the west of the lake, including some sort of exit to the WEST. STLUNKO is still hanging out there as well. And there's that rock platform in the lake where the BOMB lies.");
					} else {
						this.put("Inside the vast caldera is a large bubbly lava LAKE. Lava is emptying from it in various smallish streams, including the one you followed here, which flows out SOUTH. There is a large section of land to the west of the lake, including some sort of exit to the WEST. The rock platform on the far side of the lake is now bare.");
					}
					/*if (GameState.brodyStatus == "party") {
						this.put("\n\nBrody is waiting back at your personal chamber.");
						GameState.brodyStatus = "away";
					}*/
					if (GameState.doorState == "open") {
						if (GameState.exitingRoom == "spikes") {
							this.put("\n\nWhile you casually go down the path, Brody and Stlunko run across the long way and enter the Caldera as soon as you do. It's almost as if they never left!");
							GameState.exitingRoom = undefined;
						}
					} else {
						if ((GameState.brodyStatus == "party") && (GameState.stlunkoStatus == "away")) {
							this.put("\n\nStlunko has rejoined your party, but Brody is waiting back at your personal chamber.");
							GameState.stlunkoStatus = "party";
							GameState.brodyStatus = "away";
						} else if ((GameState.brodyStatus == "party") && (GameState.stlunkoStatus != "away")) {
							this.put("\n\nBrody is waiting back at your personal chamber.");
							GameState.brodyStatus = "away";
						} else if ((GameState.brodyStatus != "party") && (GameState.stlunkoStatus == "away")) {
							this.put("\n\nStlunko has rejoined your party.");
							GameState.stlunkoStatus = "party";
						}
					}
				}
			} else {
				this.put("You go up into the caldera of vastness. There's a LAVA LAKE here, but is it the right one? It features a PLATFORM, but it's hardly square. If you want Stlunko to try to OPEN it, go ahead. Besides the lake, there's the open sky straight UP and exits WEST and SOUTH.");
			}
			firstTime = false;
		} else {
			if (GameState.gameMode == "regular") {
				if ((GameState.stlunkoStatus == "none") || (GameState.stlunkoStatus == "talked")) {
					this.put("You are inside a very big Caldera with a large lava LAKE filling up most of the eastern half. The mostly bare WEST half features STLUNKO and the main exit from this place. Across the lake is a small platform of rock where the old diffused BOMB lies, stuck. There are many streams flowing out of the lake, including yours directly SOUTH.");
				} else if (GameState.stlunkoStatus == "bomb") {
					this.put("You are inside a very big Caldera with a large lava LAKE filling up most of the eastern half. The mostly bare WEST half features STLUNKO, who is now holding the bomb, and the main exit from this place. There are many streams flowing out of the lake, including yours directly SOUTH.");
				} else {
					this.put("You are inside a very big Caldera with a large lava LAKE filling up most of the eastern half. The main exit is along the WEST side of the room. There are many streams flowing out of the lake, including yours which lies directly SOUTH.");
				}
			} else {
				this.put("You are inside a very big caldera with a large lava LAKE filling up most of the eastern half. The lake features a PLATFORM that is very much not a square. The main exit is along the WEST side of the room. There are many streams flowing out of the lake, including yours which lies directly SOUTH.");
			}
		}
		return;
	}
}