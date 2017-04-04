class Room_secret_lab extends Room {
	var synonyms, put, superClassParse, firstTime, pressEnterCallbackFunc;
	function Room_secret_lab() {
		super();
		synonyms.push(new Array("computer", "computers", "cpu", "cpus", "keyboard", "keyboards", "mouse", "mice"));
		synonyms.push(new Array("doors", "door"));
		synonyms.push(new Array("left", "right"));
		synonyms.push(new Array("up", "exit", "hole", "entryway"));
		synonyms.push(new Array("junk", "pile", "gadgets", "gizmos", "crap"));
		synonyms.push(new Array("disk", "disc", "magnet", "electromagnet", "electro-magnet"));
		//synonyms.push(new Array("hardware", "anti-virus", "antivirus"));
		synonyms.push(new Array("porthole", "window"));
	}
	function getName() {
		return ("Secret Laboratory");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (!GameState.hardware) {
			if ((_loc2.isLookAt("computer")) || (_loc2.isLookAt("desk"))) {
				this.put("On the desk lie several computer monitors, all turned off. They appear to be retro in appearance, relatively small monitors with seperate CPUs, keyboards, and... are those computer mice? You haven't seen those in ages. Unfortunately you are totally unable to use them due to your lack of hands. Ah, well. Saargtsson must have some high ranking Poorbts use them. Or maybe he uses his tail.");
				return;
			}
			if ((_loc2.isTake("computer")) || (_loc2.isActivate("computer")) || (_loc2.isUse("computer"))) {
				this.put("Thou cannot doest that, thou handless blob.");
				return;
			}
			if ((_loc2.isShoot("computer")) || (_loc2.useLaserball("computer"))) {
				this.put("You zap a computer and it explodes. Oopsie.");
				return;
			}
			if ((_loc2.isLookAt("doors")) || (_loc2.isLookAt("left"))) {
				this.put("The metal doors have red lights over them as they are very much locked. It doesn't look like you'll be getting access. Just try to find your crazy crap in this room, okay?");
				return;
			}
			if ((_loc2.isOpen("doors")) || (_loc2.isActivate("doors")) || (_loc2.use("doors")) || (_loc2.go("doors")) || (_loc2.isGo("left")) || (_loc2.isUnlock("doors"))) {
				this.put("You try for about a minute, but it's no use. The doors are locked good. You'll have to search in here.");
				return;
			}
			if ((_loc2.isLookAt("up")) && (!_loc2.isEnd("porthole"))) {
				this.put("There's a hole in the roof about the size of the magnetic DISK. You came down through it, but you can't go back up with the anti-viral HARDWARE.");
				return;
			}
			if (((_loc2.isGoNS("up")) || (_loc2.isGoNS("feeding chamber"))) && (!_loc2.isEnd("porthole"))) {
				this.put("Not without the anti-viral HARDWARE, you're not.");
				return;
			}
			if (_loc2.isLookAt("junk")) {
				if (!GameState.magnetUsed) {
					this.put("It's a large pile of useless gizmos and gadgets made from metal all thrown together in a heap. There's no way you'll be able to dig around in it fast enough, expecially with your lack of appendages. If only you can get it moved with that large magnetic DISK hanging overhead...");
				} else {
					this.put("It's all hanging onto the magnetic DISK now. Well, except for the HARDWARE you need. It's waiting for you, attached to the wall. Sure is convenient, eh?");
				}
				return;
			}
			if ((_loc2.isTake("junk")) || (_loc2.isUse("junk")) || (_loc2.isSearch("junk"))) {
				this.put("No. There's too much of it, and you don't even know what most of this stuff does.");
				return;
			}
			if (_loc2.isLookAt("disc")) {
				if (!GameState.magnetUsed) {
					this.put("It's a large disk hanging from the wall right over the pile of JUNK. You soon realize that it's a magnetic lift, probably what Saargtsson uses to go in and out of this place. Right now it's deactivated, but you should be able to change that if you could just awaken it with a charge of electricity.");
				} else {
					this.put("The magnetic disk is activated and is currently holding a bunch of crazy crap. Leave it alone now.");
				}
				return;
			}
			if (_loc2.isTake("disc")) {
				this.put("No can do, brainguy. It's much too big and you don't really know how to work it well.");
				return;
			}
			if (_loc2.isUse("disc")) {
				if (!GameState.magnetUsed) {
					this.put("How so? It requires electricity... see if you can give it some.");
				} else {
					this.put("It's already in use, mister.");
				}
				return;
			}
			if ((_loc2.isShoot("disc")) || (_loc2.useLaserball("disc"))) {
				if (!GameState.magnetUsed) {
					this.put("You fire a laserball at the magnet and it happily receives the electric spark. With a whir it activates and starts magnetizing. Soon all the JUNK below feels the pull and flies up right onto the disk. All that's left behind are three ever-so-convenient pieces of anti-viral HARDWARE that you needed. They seem to be attached to the nearby wall and thus didn't fly up with all the other loose crap. Hooray, now you just need to GET them!");
					GameState.magnetUsed = true;
				} else {
					this.put("It's doing it's job. Leave it alone.");
				}
				return;
			}
			if (_loc2.isLookAt("hardware")) {
				if (!GameState.magnetUsed) {
					this.put("Where could it be?");
				} else {
					this.put("It's right there attached to the wall that used to be hidden behind the pile of junk. Now go GET them!");
				}
				return;
			}
			if ((_loc2.isUse("hardware")) || (_loc2.isTake("hardware"))) {
				if (!GameState.magnetUsed) {
					this.put("You'll have to find it first.");
				} else {
					this.put("You go up to the hardware and quickly push a big button on top of it. Soon all three pieces detatch from the wall and start following you around by hovering. You hurriedly take them away from the pull of the magnet and into the center of the room. Good work! Now all you need to do is get them back to Stlunko so he can put them in use...");
					GameState.hardware = true;
					Game.scorePoints(1);
				}
				return;
			}
			if ((_loc2.isShoot("hardware")) || (_loc2.useLaserball("hardware"))) {
				if (!GameState.magnetUsed) {
					this.put("You'll have to find it first.");
				} else {
					this.put("You don't have to do that. Simply USE it.");
				}
				return;
			}
			if (_loc2.isLookAt("porthole")) {
				this.put("It's red with lava outside. It's murky so you can't see far.");
				return;
			}
			if (_loc2.isShoot("porthole")) {
				this.put("That's about one of the dumbest things you could do right now.");
				return;
			}
			if (this.superClassParse()) {
				return;
			}
			DontUnderstand.parse(this);
		} else {
			if (((_loc2.isGoNS("up")) || (_loc2.isGoNS("feeding chamber")) ) && (!_loc2.isEnd("porthole"))) {
				GameState.gameMode = "puzzle";
				Game.newRoom("gokul");
			} else if (_loc2.is("inv")) {
				this.put(GameState.getInvString());
			} else {
				this.put("What do you think you're doing? Hurry and GO back UP to Stlunko before it's too late!");
			}
		}
	}
	function look() {
		if (firstTime == undefined) {
			this.put("You float down the hole in the platform, which is near verticle and just barely big enough for you. Neither of your friends can fit. How does Saargtsson climb up and down this thing?! Anyway, it soon opens up into a large metal room. Judging by a porthole, this room is actually submerged entirely in the lava pit. Wow.");
			this.put("\n\nBut anyway, you need to focus on the mission. There should be some anti-viral HARDWARE somewhere in here. Along the back wall there is a large desk with many COMPUTERS on it, all turned off. Next to it lies a large pile of mechanical JUNK, and over it hanging from the ceiling is a large metalic DISK. Besides that the room is empty, but there are two doors going out left and right with red lights overhead. As in, locked.");
			firstTime = false;
		} else {
			if (!GameState.magnetUsed) {
				this.put("You are now floating in Saargtsson's secret lab underneath a lake of lava. There are a bunch of deactivated COMPUTERS lying around. Next to them lies a large pile of metal JUNK. Just random gizmos and gadgets made from metal all thrown together in a heap. Directly above them is a hanging metal DISK, that appears to be one of those magnetic lifts, although turned off. There are two doors to the left and right, but they appear locked. Your only exit is straight UP, but you don't need to leave yet.");
			} else {
				this.put("You are in Saargtsson's lair. Next to the row of deactivated COMPUTERS lies three anti-viral HARDWARE units, which appear to be locked in place to the wall. Above them is a bunch of JUNK attached to a magnetic disk. Now hurry and GET that hardware!");
			}
		}
		return;
	}
}
