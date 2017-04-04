class Room_virtual extends Room {
	var synonyms, put, superClassParse, pressEnterCallbackFunc, firstTime, wootness;
	function Room_virtual() {
		super();
		synonyms.push(new Array("go", "dodge", "move", "dash"));
		synonyms.push(new Array("mountain", "mountains", "mountainside", "background"));
		synonyms.push(new Array("strong bad", "sb", "vector strong bad", "vector sb"));
		synonyms.push(new Array("challenge", "fight", "engage", "kill", "play"));
		synonyms.push(new Array("eject button", "eject", "exit button", "exit", "button"));
		synonyms.push(new Array("push", "press"));
		synonyms.push(new Array("talk", "yell", "shout"));
		synonyms.push(new Array("homestar", "homestar runner", "vector homestar", "vector homestar runner",
								"hr", "hs", "hsr", "h*r", "vector hr", "vector hs", "vector hsr",
								"vector h*r"));
		synonyms.push(new Array("left", "l"));
		synonyms.push(new Array("right", "r"));
		synonyms.push(new Array("down", "d"));
		synonyms.push(new Array("up", "u"));
		GameState.lookFriends = true;
	}
	function getName() {
		return ("01010110011010010111001001010010011001010110000101101100");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (GameState.vectorSteps == 1) {
			if ((_loc2.is("dodge left")) || (_loc2.is("left"))) {
				this.put("You move to the left and his first volley of shots miss you.");
				++GameState.vectorSteps;
			} else {
				/* this.put("Before you can react, you get hit by one of Vector Strong Bad's perplexing 3D attacks, and now face certain 3D doom. You a splode in a nice Vector flash.");
				pressEnterCallbackFunc = nowYouReallyDead;
				Game.addPause(); */
				youDeadFoo();
			}
		} else if (GameState.vectorSteps == 2) {
			if ((_loc2.is("dodge left")) || (_loc2.is("left"))) {
				this.put("You move leftwards once more and another shot just grazes you.");
				++GameState.vectorSteps;
			} else {
				youDeadFoo();
			}
		} else if (GameState.vectorSteps == 3) {
			if ((_loc2.is("dodge down")) || (_loc2.is("down"))) {
				this.put("You plop onto the vector floor as a few shots zoom overhead.");
				++GameState.vectorSteps;
			} else {
				youDeadFoo();
			}
		} else if (GameState.vectorSteps == 4) {
			if ((_loc2.is("dodge right")) || (_loc2.is("right"))) {
				this.put("You get up and zip to the right as a shot hits the floor where you had sat.\n\nPAUSEING A REST\n\nVector Strong Bad apparently pauses the game and goes off into the background. You look around and see that you are in a vector field with mountains in the background. Off to the left you see BRODY engaged in foot-to-foot combat against VECTOR HOMESTAR. He doesn't notice you right now. Nearby you see an EJECT BUTTON, that you can push to leave the simulation.");
				Game.scorePoints(1);
				++GameState.vectorSteps;
			} else {
				youDeadFoo();
			}
		} else {
			if (_loc2.isLookAt("background")) {
				this.put("Many green lines!");
				return;
			}
			if (_loc2.isLookAt("sb")) {
				this.put("It\'s a giant floating head that looks vaguely like Stinkoman. This is probably a copy of his training simulator.");
				return;
			}
			if (_loc2.isTake("sb")) {
				this.put("Let\'s not do that, okay? Besides, he\'ll probably splo you up if you touched him.");
				return;
			}
			if (_loc2.isTalk("sb")) {
				if (GameState.talkSB == false) {
					this.put("HELLOES MY BRAIN MAN");
					GameState.talkSB = true;
				} else {
					switch (Math.floor(Math.random()*5)) {
					case 0 :
						this.put("ARE YOU DESIRE TO A SPLODE?");
						break;
					case 1 :
						this.put("I AM IN RESTING MODES");
						break;
					case 2 :
						this.put("WHAT IT IS, MY DOGE?");
						break;
					case 3 :
						this.put("YOUR BRAIN A SPLODE");
						break;
					case 4 :
						this.put("YOUR KIRBY A PLOP");
						break;
					default :
						break;
					}
				}
				return;
			}
			if (((_loc2.isStart("fight")) && (_loc2.isEnd("sb"))) || (_loc2.isUse("sb"))) {
				GameState.exitVirtual = true;
				GameState.yourbrainasplode = 2;
				GameState.exitingRoom = "virtual";
				Game.newRoom("simulate");
				return;
			}
			if (_loc2.isLookAt("eject")) {
				this.put("It\'s a shiny red button just asking to for a PUSH. Doing so will cause you to leave the simulator and go back to reality. You can always come back here though.");
				return;
			}
			if ((_loc2.isUse("eject")) || ((_loc2.isStart("push")) && (_loc2.isEnd("button")))) {
				GameState.exitVirtual = true;
				GameState.yourbrainasplode = 3;
				GameState.exitingRoom = "virtual";
				Game.newRoom("simulate");
				return;
			}
			if ((_loc2.isEnd("brody")) || (_loc2.isEnd("homestar"))) {
				if (GameState.brodyStatus == "none") {
					if ((_loc2.isEnd("brody")) && (!_loc2.isTalk("brody"))) {
						this.put("He\'s busy fighting that green vector guy and appears to be evenly matched. Unfortunately he\'s too focused in his fight to notice you. If only there was a way for you to get his attention...");
					}
					if (_loc2.isTalk("brody")) {
						this.put("You shout to Brody to get his attention, and it works!\n\n\"Huh?\" says Brody, quickly turning to face Tampo. \"How\'s the simulation go--?!\" He gets cut off by a kick to the neck from Vector Homestar. At first he\'s a little surprised, but then he quickly a splodes away. Oops. Way to a splode your friend.");
						GameState.brodyStatus = "exploded";
					}
					if (_loc2.isEnd("homestar")) {
						this.put("He\'s a mean, green, kicking machine. And he\'s currently trying to kick Brody, but appears to be evenly matched. On this level of difficulty anyway. It\'d be best for you to stay out of its way, you legless freak.");
					}
				} else {
					if (_loc2.isEnd("brody")) {
						this.put("He\'s not here anymore. Remember the a sploding?");
					}
					if (_loc2.isEnd("homestar")) {
						this.put("He\'s a mean, green, kicking machine. He\'s currently standing idle and waiting for a challenge, but you and your lack of legs better not try giving him one. You\'ll be clobbered. Maybe you should stick to the floating head challenges.");
					}
				}
				return;
			}
			if (this.superClassParse()) {
				return;
			}
			DontUnderstand.parse(this);
		}
		//trace("Room_virtual parse");
		/* if (GameState.vectorSteps == 5) {
		if (this.superClassParse()) {
		return;
		} else {
		youDeadFoo();
		} 	
		} */
		//DontUnderstand.parse(this);
	}
	function youDeadFoo() {
		this.put("Before you can react, you get hit by one of Vector Strong Bad's perplexing 3D attacks, and now face certain 3D doom. You a splode in a nice vector flash.");
		GameState.exitVirtual = true;
		GameState.yourbrainasplode = 1;
		GameState.vectorSteps = 0;
		GameState.exitingRoom = "virtual";
		Game.newRoom("simulate");
		return;
	}
	function nowYouReallyDead() {
		GameState.exitingRoom = "virtual";
		Game.newRoom("simulate");
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.vectorSteps != 5) {
				this.put("You pop into a vector land. Vector Strong Bad appears from nowhere and starts flashing.\n\nYOU A SPLODE NOW.\n\nHe's firing shots at you! Do you dodge UP, DOWN, LEFT or RIGHT?");
				GameState.vectorSteps = 1;
			} else {
				if (GameState.brodyStatus == "none") {
					this.put("You pop into the training simulator. Vector Strong Bad is just floating around in the distance of this vector mountainside. Off to the left you see BRODY fighting in foot-to-foot combat against VECTOR HOMESTAR, and he doesn\'t see you. Nearby you notice an EJECT BUTTON that you can use to leave.");
				} else {
					this.put("You pop into the training simulator. Vector Strong Bad is just floating around in the distance of this vector mountainside. Off to the left VECTOR HOMESTAR is standing still, waiting for a challenge. Nearby you notice an EJECT BUTTON that you can use to leave.");
				}
				if (GameState.brodyStatus == "party") {
					if (GameState.stlunkoStatus != "party") {
						this.put("\n\nBrody is no longer with you.");
					} else {
						this.put("\n\nBrody and Stlunko are no longer with you.");
						GameState.stlunkoStatus = "away";
						GameState.stlunkoRoom = "simulate";
					}
					GameState.brodyStatus = "away";
				}
			}
			firstTime = false;
		} else {
			if (GameState.vectorSteps == 5) {
				if (GameState.brodyStatus == "none") {
					this.put("Vector Strong Bad is just floating around in the distance of this vector mountainside. Off to the left you see BRODY fighting in foot-to-foot combat against VECTOR HOMESTAR, and he doesn\'t see you. Nearby you notice an EJECT BUTTON that you can use to leave.");
				} else {
					this.put("Vector Strong Bad is just floating around in the distance of this vector mountainside. Off to the left VECTOR HOMESTAR is standing still, waiting for a challenge. Nearby you notice an EJECT BUTTON that you can use to leave.");
				}
			}
		}
		return;
	}
}
