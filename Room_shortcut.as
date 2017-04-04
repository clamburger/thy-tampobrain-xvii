class Room_shortcut extends Room {
	var synonyms, put, superClassParse, firstTime;
	function Room_shortcut() {
		super();
		synonyms.push(new Array("frotzer", "frotzers", "gaspeau", "gaspeaus", "poorbt", "poorbts", "minions"));
		synonyms.push(new Array("gokul", "gokuls"));
		synonyms.push(new Array("south-east", "south east", "southeast", "se"));
		synonyms.push(new Array("south-west", "south west", "southwest", "sw"));
		synonyms.push(new Array("cross", "go across", "pass"));
	}
	function getName() {
		return ("The Shortest of Cuts");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (_loc2.isLookAt("protection")) {
			if (!GameState.gokulExplode) {
				this.put("Hmm... Gokuls are extremely heat-resistant. If you could just find one willing to sacrifice itself, you could coat yourself in its guts to give you protection to cross this heat trap. Yeah... it\'s pretty gross. But it\'s the only way you know, unless you want to go into town and buy some expensive crap that costs money you don't have. But where would you find a dispensable GOKUL? Maybe in the GOKUL FEEDING CHAMBER.");
			} else {
				this.put("Oh, you already have it. Yeah, those gokul guts will protect you good.");
			}
			return;
		}
		if (_loc2.isTake("protection")) {
			if (!GameState.gokulExplode) {
				this.put(".....................");
			} else {
				this.put("You already got it, genius.");
			}
			return;
		}
		if (_loc2.isLookAt("lava")) {
			this.put("It flows across the path in its typical molten hot fashion. Some lava vein must have burst nearby, and now its spreading out here. As a floating brain, you could just fly over it, but you'll need some sort of PROTECTION from the extreme heat involved. It\'s blocking your way SOUTHEAST.");
			return;
		}
		if ((((_loc2.isStart("have")) || (_loc2.isStart("take"))) && (_loc2.isEnd("lava bath"))) || (((_loc2.isStart("sit")) || (_loc2.isStart("touch")) || (_loc2.isStart("go in"))) && (_loc2.isEnd("lava"))) || (_loc2.isGet("lava"))) {
			this.put("You head towards the lava flow and decide to sit in it. You feel warmth as it flows over your soft, gooey brain. You then remember that you can\'t survive in lava. For a brain, you aren\'t very smart. You die.");
			Game.die();
			return;
		}
		if (_loc2.isEnd("minions")) {
			this.put("There aren\'t any here. You\'ll have to look elsewhere.");
			return;
		}
		if ((_loc2.contains("gokul")) && (!_loc2.contains("gokul feed"))) {
			this.put("There appears to be none here. >_>");
			return;
		}
		if (_loc2.contains("gokul feed")) {
			this.put("You\'re in a cramped two-way tunnel. You\'ll have to go back SOUTHWEST to the open chamber in the Lava Zone\'s center to head to the south-ish Gokul Feeding Chamber.");
			return;
		}
		if (_loc2.isGo("southwest")) {
			GameState.exitingRoom = "shortcut";
			Game.newRoom("center_west");
		}
		if ((_loc2.isGo("southeast")) || (((_loc2.isStart("cross")) || (_loc2.isStart("go to"))) && (_loc2.isEnd("lava")))) {
			if (!GameState.gokulExplode) {
				this.put("You try to cross the lava flow without protection, but halfway through a fresh wave of heat hits you and you burn and die. It\'s quite painful.");
				Game.die();
			} else {
				GameState.exitingRoom = "shortcut";
				Game.newRoom("center_east");
			}
			return;
		}
		if (_loc2.isLookAt("southwest")) {
			this.put("It leads back to the western side of the Lava Zone's center. Whoo.");
			return;
		}
		if (_loc2.isLookAt("southeast")) {
			this.put("Over the lava and through the chamber, to the Simulation Room we go...");
			return;
		}
		if (_loc2.contains("simulator")) {
			this.put("You\'ll have to get out of this cramped tunnel first.");
			return;
		}
		//trace("Room_shortcut parse");
		if (this.superClassParse()) {
			return;
		}
		
		DontUnderstand.parse(this);
	}
	function look() {
		if (firstTime == undefined) {
			if (!GameState.gokulExplode) {
				this.put("You enter the cramped shortcut through the lava chambers to get around the congestion. The walls are tight, but it\'s completely empty of any minions. Just when you thought everything was going fine, you float right up to a LAVA FLOW cutting through the path. Evil lava. You know it wasn\'t there before! In this cramped chamber, there\'s no way you\'ll be able to safely cross the boiling lava without some sort of PROTECTION. Across the lava, your destination is SOUTHEAST. To backtrack to safety, you need to go SOUTHWEST.");
			} else {
				this.put("You enter the cramped shortcut through the lava chambers to get around the congestion. The walls are tight, but it\'s completely empty of any minions. Just when you thought everything was going fine, you float right up to a LAVA FLOW cutting through the path, which you swear wasn't there earlier. Fortunately your armor of Gokul guts will protect you from its extreme heat, allowing you to cross the lava and go to your");
				if (GameState.exitingRoom == "center_west") {
					this.put("SOUTHEAST destination. If you want to backtrack, head back SOUTHWEST.");
				} else if (GameState.exitingRoom == "center_east") {
					this.put("SOUTHWEST destination. If you want to backtrack, head back SOUTHEAST.");
				} else {
					this.put("CLAMBUGER destination. (dances)");
				}
			}
			if (GameState.brodyStatus == "party") {
				if (GameState.stlunkoStatus != "party") {
					this.put("\n\nBrody's too fat to squeeze through here, and even if he could fit, he'd probably burn up anyways. He'll stay back and wait for you.");
				} else {
					this.put("\n\nBrody and Stlunko can't fit through, so they're staying back.");
					GameState.stlunkoStatus = "away";
					GameState.stlunkoRoom = GameState.exitingRoom;
				}
				GameState.brodyStatus = "away";
				GameState.brodyRoom = GameState.exitingRoom;
			}
			firstTime = false;
		} else {
			this.put("You are in your cramped shortcut to pass by the crowded main rooms. There are no minions of any kind in here, but there is a LAVA FLOW spreading across the path. You'll need some sort of PROTECTION to cross it safely and continue out of the shortcut in a");
			if (GameState.exitingRoom == "center_west") {
				this.put("SOUTHEAST direction. You can backtrack to the SOUTHWEST.");
			} else if (GameState.exitingRoom == "center_east") {
				this.put("SOUTHWEST direction. You can backtrack to the SOUTHEAST.");
			} else {
				this.put("CLAMBURGER direction. (dances)");
			}
		}
		return;
	}
}
