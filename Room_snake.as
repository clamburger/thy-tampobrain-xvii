class Room_snake extends Room {
	var synonyms, put, superClassParse, firstTime, attack;
	function Room_snake () {
		super();
		synonyms.push(new Array("arches", "arch"));
		synonyms.push(new Array("minion", "minions"));
		synonyms.push(new Array("frotzer", "frotzers", "gaspeau", "gaspeaus"));
		synonyms.push(new Array("poorbt", "poorbts"));
		synonyms.push(new Array("guard", "guards"));
		synonyms.push(new Array("shout", "scream", "yell"));
		synonyms.push(new Array("bargain", "beg", "plead", "explain"));
		synonyms.push(new Array("force", "rush", "burst", "push", "charge"));
 	}
	function getName() {
		return ("Saargtsson's Lair");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("arches")) {
			this.put("Very roman arches! Apparently they make Saargtsoon feel special. Plus they're even safer than the norm.");
			return;
		}
		if (_loc2.isTake("guards")) {
			this.put("No.");
			return;
		}
		if (((_loc2.isUse("guards")) || ((_loc2.isStart("order")) && (_loc2.isEnd("guards"))) || (_loc2.isStart("order guards"))) && (!_loc2.contains("laserball"))) {
			this.put("I don't think they'll obey you. At all.");
			return;
		}
		if (_loc2.isLookAt("north")) {
			this.put("That way will take you back to the minion-filled intersection.");
			return;
		}
		if (_loc2.isGo("north")) {
			Game.newRoom("crossroads");
			return;
		}
		if ((_loc2.isLookAt("south")) || (_loc2.isLookAt("entrance"))) {
			this.put("SAARGTSSON lies right behind a small cramped \"doorway\" which is currently being blocked by two Poorbt GUARDS. It looks like you won't be going that way easily.");
			return;
		}
		if (_loc2.isLookAt("snake")) {
			this.put("He's right past this guarded entrance in a SOUTHwards direction. He should be in earshot if you want to try getting his attention. Apparently he's sick, so he probably won't like being disturbed. Hence the orders he gave the GUARDS.");
			return;
		}
		if ((_loc2.isGet("snake")) || (_loc2.isUse("snake")) || (_loc2.isShoot("snake"))) {
			this.put("You can't. He's being protected by GUARDS, remember?");
			return;
		}
		if ((_loc2.isShoot("guards")) || ((_loc2.isStart("use")) && (_loc2.contains("laserball")) && (_loc2.isEnd("guards")))) {
			this.put("Violence is not always the answer. At least not the fatal kind. Killing those things would probably cause your next conversation with Saargtsson to go very, very badly.");
			return;
		}
		if (GameState.gameMode == "regular") {
			if ((_loc2.isTalk("snake")) || ((_loc2.isStart("shout")) && (_loc2.isEnd("snake")))) {
				if (!GameState.guardsYell) {
					this.put("You decide to yell to get Saargtsson's attention in the other room, but you barely let out a single syllable before you're konked on the red part by one of the Poorbt guards' fists. Ouch.");
					GameState.guardsYell = true;
				} else {
					this.put("No, the guards won't permit any of that nonsense. And you don't need another hit where it counts.");
				}
				return;
			}
			if (_loc2.isLookAt("minions")) {
				this.put("Aside from the two Poorbt GUARDS blocking the entrance, all the minions here are scurrying in and out of Saargtsson's private lair. This place is a beehive of activity.");
				return;
			}
			if (_loc2.isLookAt("frotzers")) {
				this.put("They're just walking along.");
				return;
			}
			if (_loc2.isLookAt("poorbts")) {
				this.put("There are many of uninteresting Poorbts walking around. The only two you should care about are the GUARDS blocking your way SOUTH to Saargtsson.");
				return;
			}
			if ((_loc2.isTalk("minions")) || (_loc2.isTalk("frotzer"))) {
				this.put("They seem much too intent on their jobs to talk to you. Maybe you should try a little farther away from SAARGTSSON to talk to them, like perhaps the intersection directly NORTH?");
				return;
			}
			if (_loc2.isTalk("poorbts")) {
				this.put("There are many random Poorbts walking around. Did you mean the two Poorbt GUARDS?");
				return;
			}
			if (_loc2.isLookAt("guards")) {
				this.put("They're just two ordinary Poorbts blocking your passage SOUTH to Saargtsson. They seem pretty determined to do their job, which is to keep you and your friends out. You can't sneak or rush past them because of how cramped the tunnel they guard is. You may be able to BARGAIN with them, or you can try your luck of forcing your way past them by simply trying to GO SOUTH anyway.");
				GameState.guardsLook = true;
				return;
			}
			if ((_loc2.isTalk("guards")) || ((_loc2.isStart("beg")) && (_loc2.isEnd("guards")))) {
				if (!GameState.guardsTalk) {
					this.put("You try to convince the guards to let you pass, with all sorts of beggary, bribery, flattery and excuses. They finally end up shooting you in the noggin with one of their fists. Bonk!");
					GameState.guardsTalk = true;
				} else {
					this.put("It won't work. They're much too loyal to Saargtsson.");
				}
				return;
			}
			if (((_loc2.isStart("force")) && ((_loc2.isEnd("guards")) || (_loc2.isEnd("south")))) || (_loc2.isGo("south"))) {
				if (!GameState.guardsRush) {
					if (!GameState.guardsLook) {
						this.put("Are you sure you want to try to force your way pass the GUARDS? I mean, they probably can't kill you, but they won't let you pass easily. Well, go ahead and try if you want.");
						GameState.guardsLook = true;
					} else {
						this.put("You decide to just charge through anyway, and they without hesitating start rapid-firing their fists right at you, and they keep on regrowing more. It doesn't take long before you're subdued and nothing but a blobby pained heap on the ground, no closer than when you started. The Poorbt guards then go right back into formation and the stream of minions continue as usual, as if nothing even happened. You soon recover enough to get airborne again.");
						pressEnterCallbackFunc = postCharge;
						Game.addPause();
					}
				} else {
					this.put("It's not worth the pain. Really.");
				}
				return;
			}
			if (((_loc2.isStart("shoot")) || (_loc2.isStart("kill"))) && ((_loc2.isEnd("minions")) || (_loc2.isEnd("poorbt")) || (_loc2.isEnd("gaspeau")) || (_loc2.isEnd("frotzer")))) {
				if (attack == undefined) {
					this.put("That\'s a bad idea. They\'re strong in numbers and will fight to kill if you purposely hurt them. You should probably try zapping things with less fatal consequences.");
					attack = true;
				} else {
					this.put("Alright, fine. You shoot a lowly minion anyway. Oh look, now they\'re all jumping on you for betrayal and stuff. Hey, is that your hypothalamus being flung over there? Ouch. You're almost definitely dead now.");
					Game.die();
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && ((_loc2.contains("go")) || (_loc2.contains("force"))) && ((_loc2.isEnd("south")) || (_loc2.isEnd("guards")))) {
				if (GameState.brodyStatus != "party") {
					this.put("Alas, poor Brody is not with ye.");
				} else {
					if (!GameState.guardsBrod) {
						this.put("You tell Brody to give those guards whats-for and open a way past, but unfortunately his powerful size and stature is useless because he has to bend over to even fit through the entryway. In this much more prone position, he is very quickly clobbered by the guards and has to retreat.");
						GameState.guardsBrod = true;
					} else {
						this.put("He doesn't seem to want to try again. Looks like it's up to STLUNKO.");
					}
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && ((_loc2.contains("go")) || (_loc2.contains("force"))) && ((_loc2.isEnd("south")) || (_loc2.isEnd("guards")))) {
				if (GameState.stlunkoStatus != "party") {
					this.put("There's a big flaw in your plan, my friend. You see, Stlunko isn't with you. Yeah.");
				} else {
					this.put("He says he respects Saargtsson and won't do it unless he absolutely has to. Oh noes, he's been corrupted!");
				}
				return;
			}
		} else if ((GameState.gameMode == "virus") && (!GameState.discussion)) {
			if (_loc2.isLookAt("minions")) {
				this.put("Aside from the two Poorbt GUARDS blocking the entrance, they seem to all be gone. Maybe it's lunch break?");
				return;
			}
			if (_loc2.contains("frotzer")) {
				this.put("They're gone! They're all gone!");
				return;
			}
			if (_loc2.isTalk("minions")) {
				this.put("Who, the GUARDS? They're the only ones here.");
				return;
			}
			if (_loc2.isLookAt("poorbts")) {
				this.put("The only Poorbts here are those two GUARDS blocking your way SOUTH.");
				return;
			}
			if (((_loc2.contains("explain")) || (_loc2.contains("talk"))) && (_loc2.isEnd("guards"))) {
				this.put("You and your friends simultaneously try to explain what the problem is and why you simply have to see Saargtsson right now. It doesn't take long before they start shooting their fists at you guys. Soon you all just shut up. It isn't working.");
				return;
			}
			if (_loc2.isLookAt("guards")) {
				this.put("They're just two ordinary Poorbts blocking your passage SOUTH to Saargtsson. They seem pretty determined to do their job, which is to keep you and your friends out. You can't sneak or rush past them because of how cramped the tunnel they guard is. You may be able to BARGAIN with them, or you can try your luck of forcing your way past them by simply trying to GO SOUTH anyway.");
				GameState.guardsLook = true;
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && ((_loc2.contains("go")) || (_loc2.contains("force"))) && ((_loc2.isEnd("south")) || (_loc2.isEnd("guards")))) {
				if (!GameState.guardsBrod) {
					this.put("You tell Brody to give those guards whats-for and open a way past, but unfortunately his powerful size and stature is useless because he has to bend over to even fit through the entryway. In this much more prone position, he is very quickly clobbered by the guards and has to retreat.");
					GameState.guardsBrod = true;
				} else {
					this.put("He doesn't seem to want to try again. Looks like it's up to STLUNKO.");
				}
				return;
			}
			if ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && ((_loc2.contains("go")) || (_loc2.contains("force"))) && ((_loc2.isEnd("south")) || (_loc2.isEnd("guards")))) {
				this.put("\"I am sorry, fellow minions, but it must be done.\"");
				this.put("\n\nStlunko starts bulldozing straight through the entryway and almost into the guards, who start shooting their fists off frantically at him. The fists have very little effect of Stlunko's metal exterior and soon the guards have to retreat back into Saargtsson's personal space. The path is now clear for you and Brody to go through, which you do right behind Stlunko.");
				Game.scorePoints(2);
				pressEnterCallbackFunc = postSnakeOne;
				Game.addPause();
				return;
			}
			if ((_loc2.isTalk("snake")) || ((_loc2.isStart("shout")) && (_loc2.isEnd("snake")))) {
				if (!GameState.guardsYell) {
					this.put("You decide to yell to get Saargtsson's attention in the other room, but you barely let out a single syllable before you're konked on the red part by one of the Poorbt guards' fists. Ouch.");
					GameState.guardsYell = true;
				} else {
					this.put("No, the guards won't permit any of that nonsense. And you don't need another hit where it counts.");
				}
				return;
			}			
			if (((_loc2.isStart("force")) && ((_loc2.isEnd("guards")) || (_loc2.isEnd("south")))) || (_loc2.isGo("south"))) {
				if (!GameState.guardsRush) {
					if (!GameState.guardsLook) {
						this.put("Are you sure you want to try to force your way pass the GUARDS? I mean, they probably can't kill you, but they won't let you pass easily. Well, go ahead and try if you want.");
						GameState.guardsLook = true;
					} else {
						this.put("You decide to just charge through anyway, and they without hesitating start rapid-firing their fists right at you, and they keep on regrowing more. It doesn't take long before you're subdued and nothing but a blobby pained heap on the ground, no closer than when you started. The Poorbt guards then go right back into formation and the stream of minions continue as usual, as if nothing even happened. You soon recover enough to get airborne again.");
						GameState.showMessage = false;
						pressEnterCallbackFunc = postCharge;
						Game.addPause();
					}
				} else {
					this.put("It's not worth the pain. Really.");
				}
				return;
			}
		} else {
			if ((_loc2.isTalk("snake")) || ((_loc2.isStart("shout")) && (_loc2.isEnd("snake")))) {
				this.put("He's sick. Just let him rest, okay? You can save the world by yourself. Just get to that secret lab of his.");
				return;
			}
			if (((_loc2.brodyDoSomething()) && (_loc2.contains("brody")) && ((_loc2.contains("talk")) || (_loc2.contains("explain"))) && (_loc2.isEnd("guards"))) || ((_loc2.brodyDoSomething()) && (_loc2.contains("stlunko")) && ((_loc2.contains("talk")) || (_loc2.contains("explain"))) && (_loc2.isEnd("guards"))) || ((_loc2.isStart("talk")) || ((_loc2.isStart("explain")) && (_loc2.isEnd("guards"))))) {
				this.put("You don't need to try talking to these freaks anymore.");
				return;
			}
			if (_loc2.isLookAt("guard")) {
				this.put("They're just two ordinary Poorbts blocking your passage SOUTH to Saargtsson. They still seem to be following orders even though they just failed earlier. Let's leave them alone, shall we?");
				return;
			}
			if (((_loc2.contains("go")) || (_loc2.contains("charge"))) && (_loc2.isEnd("south"))) {
				this.put("No need to do that anymore. Just let them be.");
				return;
			}
			if (_loc2.isLook("minions")) {
				this.put("Aside from the two Poorbt GUARDS blocking the entrance, they seem to all be gone. Maybe it's lunch break?");
				return;
			}
			if (_loc2.contains("frotzer")) {
				this.put("They're gone! They're all gone!");
				return;
			}
			if (_loc2.isTalk("minions")) {
				this.put("Who, the GUARDS? They're the only ones here.");
				return;
			}
			if (_loc2.isLookAt("poorbts")) {
				this.put("The only Poorbts here are those two GUARDS blocking your way SOUTH.");
				return;
			}
		}
		//trace("Room_snake parse"); 
		if (this.superClassParse()) {
			return;
		}
		
		DontUnderstand.parse(this);
	}
	function postCharge() {
		this.put("You get an E for effort or whatever the saying is. I'll give you a bonus point so you don't feel as bad. But it looks like if you want to get past you'll have to HAVE a friend GO SOUTH through them. They're a bit more solid than your squishy self.");
		Game.scorePoints(1);
		GameState.guardsRush = true;
		return;
	}
	function postSnakeOne() {
		this.put("As the guards sort of slink off to a corner, Brody, Stlunko and you approach Saargtsson, who much to your surprise is blue. He looks cold and sick, and he's an icy blue color. And he doesn't look happy to see you. He's on his little throne and is being constantly monitored and attended to by a few select minions.");
		this.put("\n\n\"What isss it?\" he asks in a stuffed up voice. He doesn't seem very pleased at all. As you can tell from some papers lying around, he caught a cold while monitoring the recently frozen passageway's defrosting.");
		this.put("\n\n\"We, uh... need to get to your anti-viral hardware. For that reality bending virus,\" you say.");
		this.put("\n\n\"RealityBendX,\" Stlunko adds.");
		pressEnterCallbackFunc = postSnakeTwo;
		Game.addPause();
		return;
	}
	function postSnakeTwo() {
		this.put("\"Whatevvver... You ssshould be able to fffind sssome offf what you need in my lab. Jussst get out of here and pull the lid offffff offf thhhe perfffectly sssquare isssland. Thhhat brain guy ssshould be able to fffit inssside.\"");
		this.put("\n\n\"Thank you, Saargtsson. We will be leaving now,\" Stlunko says. He exits, and you and Brody quickly follow. The guards, now pretty worthless, still go back to their post after you leave.");
		pressEnterCallbackFunc = postSnakeThree;
		Game.addPause();
		return;
	}
	function postSnakeThree() {
		this.put("You're back outside the entrance to Saargtsson's lair. The two GUARDS are back in their positions, but you should leave them alone for now. You need to leave NORTH and fine a perfect square island and... flip off its lid, I guess. If you know where that is, you should head there right now. If not, you might have to waste some time THINKing about it.");
		GameState.discussion = true;
		return;
	}
	function look() {
		if (firstTime == undefined) {
			if (GameState.gameMode == "regular") {
				if (!GameState.lairEnter) {
					this.put("Against your better judgement, you head down the path to Saargtsson's Lair. Soon the normal rough caverns begin to become much more arched and regal in appearance. A steady stream of MINIONS goes in and out of it. As you approach the entrance, the path becomes much more low and cramped, and two Poorbt GUARDS suddenly stop you from continuing further SOUTH.");
					this.put("\n\n\"Hold it right there!\" the guards shout together. \"Saargtsson is not feeling well today and he has pointed out specifically that he does want to be bothered by you or your two friends.\"");
					this.put("\n\nWell, that's not so bad is it? It's probably a good idea to let sleeping snakes lie. Going NORTH will take you out of here.");
					GameState.lairEnter = true;
				} else {
					this.put("You go south down the regal arched corridors to Saargtsson's personal lair, but are stopped just at the entrance by two Poorbt GUARDS who aren't letting you pass through the cramped entryway SOUTH to the apparently sick SAARGTSSON. As you stand there, plenty of smaller MINIONS walk in and out of Saargtsson's home. Apparently he isn't too sick to keep the Lava Zone running smoothly. You are allowed to go back NORTH.");
				}
			} else if ((GameState.gameMode == "virus") && (!GameState.discussion)) {
				if (!GameState.lairEnter) {
					this.put("You zip down the regal arched corridors that lead to Saargtsson's personal lair. Right when you almost make it to SAARGTSSON himself, you are stopped at the cramped entryway by two Poorbt GUARDS. They are the only minions around, and they aren't letting you continue SOUTH.");
					this.put("\n\n\"Hold it right there!\" the guards shout together. \"Saargtsson is not feeling well today and he has pointed out specifically that he does want to be bothered by you or your two friends.\"");
					this.put("\n\nUgh, you don't have time for this. Should you try to TALK to them or should you just try to FORCE yourself south past them?");
					GameState.lairEnter = true;
				} else {
					this.put("You zip down the regal arched corridors that lead to Saargtsson's personal lair. Right when you almost make it to SAARGTSSON himself, you are stopped at the cramped entryway by those two Poorbt GUARDS. They say that Saagtsson is sick and doesn't want to be visited by you, Brody or Stlunko. Besides them and yourselves, the room is void of minions.");
					this.put("\n\nWell you definitely don't have much time to deal with these Poorbts. Should you try to TALK things over or just FORCE your way past?");
				}
			} else {
				this.put("You go to the entrance of Saargtsson's lair. The two GUARDS are still in their positions stopping you from going SOUTH to Saargtsson. You should leave them alone and go back NORTH.");
			}
			firstTime = false;
		} else {
			if (GameState.gameMode == "regular") {
				this.put("You are in the regal-looking arched entrance to Saargtsson's Lair. Blocking your way SOUTH through the cramped \"doorway\" to SAARGTSSON himself are two POORBT guards who apparently have orders to not let you pass. Below you are many MINIONS walking in and out of the lair. The way out is due NORTH.");
			} else if ((GameState.gameMode == "virus") && (!GameState.discussion)) {
				this.put("You are in the regal-looking arched entrance to Saargtsson's Lair. Blocking your way SOUTH through the cramped \"doorway\" to SAARGTSSON himself are two POORBT guards who apparently have orders to not let you pass. Besides them there are no little minions here. The way out is due NORTH.");
			} else {
				this.put("You're currently outside the entrance to Saargtsson's lair. The two GUARDS are back in their positions SOUTH, but you should leave them alone for now. The only open exit is NORTH.");
			}
		}
		return;
	}
}