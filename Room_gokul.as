class Room_gokul extends Room {
	var synonyms, put, superClassParse, firstTime, pressEnterCallbackFunc;
	function Room_gokul() {
		super();
		synonyms.push(new Array("game", "tic-tac-toe", "tic tac toe"));
		synonyms.push(new Array("lava", "lava pool", "lake", "lava lake", "pool"));
		synonyms.push(new Array("camera", "security camera", "cameras", "security cameras"));
		synonyms.push(new Array("frotzers", "frotzer", "gaspeaus", "gaspeau"));
		//synonyms.push(new Array("use", "activate", "turn on"));
		synonyms.push(new Array("north", "north-ish", "northish"));
		synonyms.push(new Array("buttons", "button", "control panel", "controls", "panel"));
		synonyms.push(new Array("lava island", "island"));
		synonyms.push(new Array("take", "get"));
	}
	function getName() {
		return ("Gokul Feeding Chamber");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (GameState.gameMode == "regular") {
			if ((_loc2.isGo("island")) || (_loc2.isSit("island")) || (_loc2.isUse("island")) || (_loc2.isRest("island"))) {
				if (!GameState.gokulExplode) {
					this.put("You float over the island. As you slowly float down to it, the approaching heat stings a little, like when you first go into a hot bath. Unlike a bath however, you burst into flames. Oopsie.");
					Game.die();
				} else {
					if (!GameState.rested) {
						this.put("You float over and rest on the island. It's just your size. Ahhhh... the rising steam from the lava envelopes your body in warmth that is just the right temperature. Eventually you decide to get up from your heat bed, rather refreshed. You needed something like that. Bonus point for you!");
						Game.scorePoints(1);
						GameState.rested = true;
					} else {
						this.put("You\'ve rested enough. You have a job to do, so get back to work.");
					}
				}
				return;
			}
			if (_loc2.isTake("headset")) {
				if (!GameState.gotHeadset) {
					this.put("You plop down upon the virtual reality headset and slowly absorb it in a wrinkle. It's very uncomfortable, but you'll be able to carry it around until you need it.");
					Game.scorePoints(1);
					GameState.gotHeadset = true;
				} else {
					this.put("You already did. Can't you feel it scratching the insides of your innards?");
				}
				return;
			}
			if (_loc2.isLookAt("headset")) {
				if (!GameState.gotHeadset) {
					this.put("Well it looks like a small hi-tech helmet, but it really is just a fancily-dressed sentience cable that'll upload your consciousness into simulators. Works on pretty much everything with a consciousness to upload, including floating brains. You'd have to take it to a SIMULATOR ROOM, though.");
				} else {
					this.put("There is no headset of any kind laying around here.");
				}
				return;
			}
			if (_loc2.isLookAt("cameras")) {
				this.put("They\'re watching you... O_O");
				return;
			}
			if (_loc2.isLookAt("poorbt")) {
				this.put("He\'s just sitting there, playing a GAME in the dirt with his GOKUL friend. He apparently has some free time on his hands, although it looks like something\'s troubling him.");
				return;
			}
			if (_loc2.isLookAt("protection")) {
				if (!GameState.gokulExplode) {
					this.put("There\'s a nice fresh GOKUL lying around here, but this is too much of a public place to safely sacrifice him for heat protection. You\'ll have to find a Gokul somewhere else... but where?");
				} else {
					this.put("Ah yes, an inconspicuous light coating of Gokul guts. Good thing these little minions don't notice it.");
				}
				return;
			}
			if ((_loc2.isStart("talk")) && (_loc2.isEnd("gokul"))) {
				this.put("It squeals with glee.");
				return;
			}
			if ((_loc2.isStart("talk")) && (_loc2.isEnd("poorbt"))) {
				if (!GameState.talkPoorbt) {
					this.put("You manage to start up a light conversation with the Poorbt. The topic quickly shifts to what\'s bothering him. He says that his GOKUL friend\'s highly explorative brother was last seen crawling into your PERSONAL CHAMBER, which is off-limits for minions like him.");
					if (!GameState.gokulExplode) {
						this.put("You assure him that you\'ll keep an eye out for the li\'l brudder.");
					} else {
						this.put("Err...");
						pressEnterCallbackFunc = postPoorbt;
						Game.addPause();
					}
					GameState.talkPoorbt = true;
				} else {
					if (!GameState.gokulExplode) {
						this.put("He reminds you to keep an eye for the GOKUL friend who got lost in your PERSONAL CHAMBER.");
					} else {
						this.put("You decide against talking to the Poorbt again in fear of him discovering you accidentally killed his other GOKUL friend.");
					}
				}
				return;
			}
			if (((_loc2.isStart("play")) && (_loc2.isEnd("game"))) || (_loc2.isUse("game"))) {
				this.put("The Gokul quickly finishes up its current game, and is ready to verse you. You\'re O for olive. The Gokul makes the first move, followed by you, and it continues in this fashion until you are beaten. Wow, you suck at this game. That\'s probably why you hate it so much.");
				return;
			}
			if (_loc2.isLookAt("game")) {
				this.put("Tic-Tac-Toe. Laaaame.");
				return;
			}
			if (_loc2.isTake("game")) {
				this.put("You attempt to take the game, but the Gokul jumps up and bites you... somehow. He slides back down and continues playing.");
				return;
			}
			if (_loc2.isLookAt("gokul")) {
				this.put("It looks happy and is playing a GAME with his POORBT friend. Although he can\'t actually make his moves, he seems to be able to tell his friend where he chooses to go with his squeaks and vibrations. Apparently they know each other well enough to communicate.");
				return;
			}
			if (_loc2.isEnd("poorbts")) {
				this.put("There\'s only one.");
				return;
			}
			if (_loc2.isEnd("gaspeau")) {
				this.put("That type of minion isn\'t here in this room.");
				return;
			}
			if ((_loc2.isLookAt("lava")) || (_loc2.isLookAt("pool"))) {
				this.put("It's a moderately sized pool of boiling lava, where most of the GOKULS live and play. Occassionally you can see one break the surface for a few seconds before sinking back down into the yellow and red liquid. In the middle of the pool is a bare ISLAND.");
				return;
			}
			if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
				this.put("You head towards the lava flow and decide to sit in it. You feel warmth as it flows over your soft, gooey brain. You then remember that you can\'t survive in lava. For a brain, you aren\'t very smart. You die.");
				Game.die();
				return;
			}
			if (_loc2.is("rest")) {
				this.put("With what? That toasty ISLAND over there? It\'s too hot; you\'d burn up or something. Unless you had some sort of PROTECTION from the heat... then it could actually be very relaxing, like a sauna or something.");
				return;
			}
			if (_loc2.isLookAt("minions")) {
				this.put("Other than the Gokuls swimming around in the LAVA POOL, there\'s just a POORBT and his single GOKUL friend hanging around.");
				return;
			}
			if ((_loc2.isTake("minions")) || (_loc2.isTalk("minions"))) {
				this.put("Please be more specific.");
				return;
			}
			if (_loc2.isEnd("personal chamber")) {
				this.put("It\'s quite a ways off.");
				return;
			}
			if (_loc2.isUse("machine")) {
				this.put("You don\'t need to feed to Gokuls right now. Firstly, it\'s not a designated feeding time, and secondly, the longer you don\'t have to work, the better. In fact, a nice REST could do you good right now. And lastly, the machine seems to be password protected by Saargtsson.");
				return;
			}
			if (_loc2.isTake("machine")) {
				this.put("It\'s much too large and heavy to move. If you want to use it, you\'ll have to do so right here.");
				return;
			}
			if (_loc2.isLookAt("machine")) {
				this.put("It\'s a large mechanism with lots of funnels and tubes for the processing and transferring of Gokul feed. It is turned off, but it sports several large and shiny BUTTONS on a control panel.");
				if (!GameState.gotHeadset) {
					this.put("On top of it sits a misplaced virtual reality HEADSET.");
				}
				return;
			}
			if (_loc2.isEnd("gokuls")) {
				this.put("Most of them are swimming around in the LAVA POOL, out of reach from you. There is that one GOKUL who\'s playing out of the lava, though.");
				return;
			}
			if ((_loc2.isTake("gokul")) || (_loc2.isTake("protection")) || (_loc2.isUse("gokul")) || (_loc2.isUse("protection")) || (((_loc2.isStart("sacrifice")) || (_loc2.isStart("zap"))) && (_loc2.isEnd("gokul")))) {
				if (!GameState.gokulExplode) {
					this.put("If you want to use a Gokul for protection from the heat, you\'ll have to sacrifice one in a more private place, like your PERSONAL CHAMBER. But this Gokul doesn\'t look like he\'s going anywhere. Even if you take out the exposed Gokul\'s POORBT bodyguard, there are security cameras about and the minions will discover and punish your treachery. They\'re very violent when threatened, you know.");
				} else {
					this.put("One sacrifice is enough.");
				}
				return;
			}
			if (_loc2.isGo("north")) {
				Game.newRoom("center_west");
			}
			if (_loc2.isLookAt("north")) {
				this.put("It leads back out to the maze of Lava Zone chambers.");
				return;
			}
			if ((_loc2.isUse("buttons")) || (_loc2.isTouch("buttons")) || (_loc2.isPush("buttons"))) {
				this.put("Do not touch.");
				return;
			}
			if (_loc2.isLookAt("buttons")) {
				this.put("There are six colorful buttons on the control panel. You have no idea what they do, as you have never seen anybody use these particular buttons before. They\'ve just been sitting there, taunting you with their mysteriousness. They\'re big enough for you to press with your flabby sides, but there's a \"Do not touch.\" label beneath them.");
				return;
			}
			if (_loc2.isLookAt("island")) {
				this.put("Hmm... there is a perfectly formed island in the center of the LAVA POOL that looks too square to be natural. There\'s no Gokuls on it and looks like it could make a very comfortable perch for a relaxing sauna... although it might be a bit too hot to USE without some sort of PROTECTION from the heat.");
				return;
			}
			if (_loc2.isUse("headset")) {
				this.put("You\'ll have to take it to a Training Simulator. Otherwise it\'s useless.");
				return;
			}
			if (((_loc2.contains("flip")) || (_loc2.contains("open"))) && (_loc2.contains("island"))) {
				this.put("That's a crazy idea.");
				return;
			}
		} else {
			if (_loc2.contains("rest")) {
				this.put("How can you even think about resting at a time like this?!");
				return;
			}
			if (_loc2.isLookAt("machine")) {
				this.put("It's a large mechanism with lots of funnels and tubes for the processing and transferring of Gokul feed. It is turned off, but it sports several large and shiny BUTTONS on a control panel. But seriously, leave it alone for now.");
				return;
			}
			if (_loc2.isTake("machine")) {
				this.put("It's much too large and heavy to move. If you want to use it, you'll have to do so right here.");
				return;
			}
			if ((_loc2.isUse("machine")) || (_loc2.isActivate("machine"))) {
				this.put("You don't need to feed the Gokuls right now. Get back to saving the world!");
				return;
			}
			if (_loc2.isLookAt("buttons")) {
				this.put("There are six colorful buttons on the control panel. You have no idea what they do, as you have never seen anybody use these particular buttons before. They've just been sitting there, taunting you with their mysteriousness. They're big enough for you to press with your flabby sides, but there's a \"Do not touch.\" label beneath them.");
				return;
			}
			if ((_loc2.isUse("buttons")) || (_loc2.isPush("buttons")) || (_loc2.isPress("buttons")) || (_loc2.isTouch("buttons"))) {
				this.put("Do not touch.");
				return;
			}
			if ((_loc2.contains("minions")) || (_loc2.contains("gokul")) || (_loc2.contains("poorbt"))) {
				if (_loc2.isLookAt("minions")) {
					this.put("There aren't any here! Even the Gokuls swimming in the LAVA POOL are gone!");
				} else {
					this.put("All of the Gokuls, as well as the Poorbt, are mysteriously absent. There are no other minions here either.");
				}
				return;
			}
			if (_loc2.isLookAt("camera")) {
				this.put("They're watching you... O_O");
				return;
			}
			if (_loc2.contains("game")) {
				this.put("It's been taken away, apparently. It not here no more.");
				return;
			}
			if (_loc2.isLookAt("north")) {
				this.put("It leads back out to the maze of Lava Zone chambers.");
				return;
			}
			if (_loc2.isGo("north")) {
				if (!GameState.islandFlipped) {
					Game.newRoom("center_west");
				} else {
					this.put("That's a really stupid idea. Go DOWN into that secret lab, fool!");
				}
				return;
			}
			if ((_loc2.isLookAt("lava")) || (_loc2.isLookAt("pool"))) {
				if (!GameState.islandFlipped) {
					this.put("It's a moderately sized pool of boiling lava, with a large perfectly square PLATFORM in the middle of it. It probably leads to Saargtsson's secret lab, so why don't you HAVE someone with far-reaching hands FLIP off its top?");
				} else {
					this.put("It's a moderately sized pool of boiling lava, with a large perfectly square PLATFORM in the middle of it. There's a passageway going DOWN the center of the platform, so why don't you hurry up in there?");
				}
				return;
			}
			if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
				this.put("You head towards the lava flow and decide to sit in it. You feel warmth as it flows over your soft, gooey brain. You then remember that you can\'t survive in lava. For a brain, you aren\'t very smart. You die.");
				Game.die();
				return;
			}
			if (_loc2.isLookAt("island")) {
				if (!GameState.islandFlipped) {
					this.put("Hmm... there is a perfectly formed island in the center of the LAVA POOL that looks too square to be natural. It looks like the place Saargtsson described. HAVE someone FLIP off its top to reveal some sort of passageway to a hidden lab.");
				} else {
					this.put("It's open now, and you can float DOWN to a hidden lab below.");
				}
				return;
			}
			if ((_loc2.isUse("island")) || (_loc2.isFlip("island")) || (_loc2.isOpen("island"))) {
				if (!GameState.islandFlipped) {
					this.put("You can't do it yourself. You need someone with really strong hands to do it for you!");
				} else {
					this.put("It's already open.");
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && ((_loc2.contains("flip")) || (_loc2.contains("open"))) && (_loc2.isEnd("island"))) {
				if (!GameState.islandFlipped) {
					this.put("It's in the middle of a boiling pool of LAVA. He'd surely die!");
				} else {
					this.put("It's already open.");
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && ((_loc2.contains("flip")) || (_loc2.contains("open"))) && (_loc2.isEnd("island"))) {
				if (!GameState.islandFlipped) {
					this.put("You give the order and Stlunko unhesitantly reaches across the lake and clutches the edges of the island. He then starts to push upward and the whole top of the island seems to fly backwards as if on hinges. With the rock door now open, you can easily see a passageway DOWN the center of the rock island. It must lead to Saargtsson's secret lab, so get going!");
					GameState.islandFlipped = true;
					Game.scorePoints(1);
				} else {
					this.put("It's already open.");
				}
				return;
			}
			if ((_loc2.isLookAt("down")) || (_loc2.isLookAt("hole")) || (_loc2.isLookAt("lab"))) {
				if (!GameState.islandFlipped) {
					this.put("Stop wasting time. Try and FLIP the ISLAND or something.");
				} else {
					this.put("It's goes straight down into the island and clearly leads into an under-lava room: The secret lab. There's no way Brody or Stlunko will be able to fit, so you'll be on your own in there. Now hurry and GO DOWN into it!");
				}
			}
			if (_loc2.isGoNS("down")) {
				if (!GameState.islandFlipped) {
					this.put("Stop wasting time. Try and FLIP the ISLAND or something.");
				} else {
					GameState.brodyStatus = "away";
					GameState.stlunkoStatus = "away";
					GameState.brodyRoom = "gokul";
					GameState.stlunkoRoom = "gokul";
					Game.newRoom("secret_lab");
				}
				return;
			}
		}
		//trace("Room_gokul parse");
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function postPoorbt() {
		this.put("Nervously glancing at your slightly red gokul coating and hoping the Poorbt won\'t notice, you say you\'ll keep an eye out for him. The Poorbt eventually turns back to his game. Whew...");
		return;
	}
	function look() {
		if (GameState.gameMode == "regular") {
			if (firstTime == undefined) {
				this.put("You enter the south-ish Gokul Feeding Chamber, where you\'ve spent hours upon hours feeding the always-hungry blobs. The large GOKUL FEEDING MACHINE sits along a wall. It won\'t be feeding time for a couple of hours, so it's turned off. The only minions near it (besides you) are a POORBT and his GOKUL friend (or pet) who are playing together. Several yards away lies a LAVA POOL where most of the Gokuls live, and in the middle of it is a square ISLAND. The exit is back NORTH.");
				firstTime = false;
			} else {
				this.put("You are in the Gokul Feeding Chamber, the room where Gokuls are fed. The large GOKUL FEEDING MACHINE sits along a wall. It won\'t be feeding time for a couple of hours, so it\'s turned off. The only minions near it (besides you) are a POORBT and his GOKUL friend, playing a game. Several yards away lies a LAVA POOL where most of the Gokuls live, and in the middle of it is a square ISLAND. The exit is back NORTH.");
			}
		} else if (GameState.gameMode == "virus") {
			if (firstTime == undefined) {
				this.put("You enter the south-ish Gokul Feeding Chamber, the place famous for its most evil GOKUL FEEDING MACHINE. But that thing's not important right now. The POORBT and GOKUL who were playing here seem to be missing like everyone else, but they're hardly important either. Several yards away lies a LAVA POOL where most of the Gokuls live, and in the middle of it is a square ISLAND. This looks like the place! Go have Stlunko FLIP that thing!");
				firstTime = false;
			} else {
				if (!GameState.islandFlipped) {
					this.put("You are in the Gokul Feeding Chamber, the room where Gokuls are fed. The MACHINE is still here, but the MINIONS playing a game here are not. But neither are important, as the nearby LAVA POOL features a perfectly square ISLAND! But if for you want to leave for some raisin, the exit is back NORTH.");
				} else {
					this.put("You are in the Gokul Feeding Chamber, the room where Gokuls are fed. The MACHINE is still here, but the MINIONS playing a game here are not. But neither are important, as the nearby LAVA POOL features a perfectly square ISLAND! And the island has been opened and now you can squeeze DOWN into the secret lab beneath.");
				}
			}
		} else {
			this.put("You float right out of the island's secret passage with the anti-viral hardware in tow. You quickly take them across the lake and to your two friends on the shore. Without missing a beat, Stlunko grabs all three and simutaniously starts pushing buttons and orders into all of them. In a matter of seconds, each of hardware units float right above a member of the boss trio and encircle them with an anti-viral shield. Those viruses won't be able to effect you now, so you'll stand a chance fighting back!");
			this.put("\n[PRESS ENTER]");
			pressEnterCallbackFunc = postHardwareOne;
			Game.addPause();
		}
		return;
	}
	function postHardwareOne() {
		this.put("Just as you start getting the hang of moving around with these things, the virus upload reaches 100% and quickly starts spreading out from your computer. It's only a matter of seconds until your entire room is glitchified. The walls flash repeatedly, the lava lake turns into pepperoni juice and the Gokul feeding machine is now... a butt. Fortunately the hardware stops it from changing you three into useless glitches, but as the only immune creatures nearby, you are on your own.");
		this.put("\n\nSo to save the day from the virus and exterminate it for good, you'll have to get to and fight him somehow. But just when you three start heading back to your personal chamber, the virus sends three large glitchy virus cubes and entraps each of you in one of them. Oh noes! All three of you will have to escape seperately if you want to face and beat the final boss! And Tampo's first...");
		pressEnterCallbackFunc = postHardwareTwo;
		Game.addPause();
		return;
	}
	function postHardwareTwo() {
		GameState.puzzleMode = true;
		Game.newRoom("puzzle_tampo");
		return;
	}
}