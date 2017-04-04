class Room_puzzle_brody extends Room {
	var synonyms, put, superClassParse, firstTime, pressEnterCallbackFunc, varsDefined;
	static var room, river, bomb, countdown, breath, rivercount, tv, lamp, light, forcefield, lever, knock;
	static var window, jump, seenwater, seenwater2, power, down, lighten, lightCut, justExploded;
	function Room_puzzle_brody() {
		super();
		synonyms.push(new Array("kick", "attack", "destroy"));
		synonyms.push(new Array("ground", "grass", "yard", "lawn"));
		synonyms.push(new Array("walkway", "sidewalk"));
		synonyms.push(new Array("driveway", "garage"));
		synonyms.push(new Array("house", "building", "home"));
		synonyms.push(new Array("window", "glass", "pane", "panes"));
		synonyms.push(new Array("bomb", "explosive"));
		synonyms.push(new Array("package", "mail"));
		synonyms.push(new Array("timer", "clock", "time", "countdown"));
		synonyms.push(new Array("swim", "struggle"));
		synonyms.push(new Array("jump", "leap"));
		synonyms.push(new Array("deeper", "depths", "further", "farther"));
		synonyms.push(new Array("bedroom", "bedroom door"));
		synonyms.push(new Array("sofa", "couch"));
		synonyms.push(new Array("patch", "tape"));
		synonyms.push(new Array("tv", "television"));
		synonyms.push(new Array("lay", "lie"));
		synonyms.push(new Array("device", "forcefield"));
		synonyms.push(new Array("cupboard", "cupboards"));
		synonyms.push(new Array("fridge", "refridgerator", "freezer"));
		synonyms.push(new Array("light", "lamp"));
		synonyms.push(new Array("sink", "faucet"));
		synonyms.push(new Array("staircase", "stairs"));
		synonyms.push(new Array("bulb", "globe"));
		synonyms.push(new Array("cliff", "edge"));
		if (varsDefined == undefined) {
			room = "outside";
			river = "inside";
			bomb = "inactive";
			countdown = 10;
			breath = 4;
			rivercount = 3;
			tv = false;
			lamp = false;
			light = false;
			forcefield = true;
			lever = false;
			knock = false;
			window = false;
			jump = false;
			seenwater = false;
			seenwater2 = false;
			power = 3;
			down = false;
			lighten = false;
			lightCut = false;
			justExploded = false;
			varsDefined = true;
		}
	}
	function getName() {
		return ("V1RU5 PR150N - Front Lawn");
	}
	function parse() {
		var _loc2 = Game.tp;
		if (bomb == "active" && countdown>0) {
			--countdown;
		}
		if (room == "living" && river == "inside" && breath>0) {
			--breath;
		}
		if (river == "outside" && rivercount>0) {
			--rivercount;
		}
		if (_loc2.is("var bomb")) {
			this.put("bomb = "+bomb);
			return;
		}
		if (_loc2.is("var countdown")) {
			this.put("countdown = "+countdown);
			return;
		}
		if (room == "living" && river == "inside" && bomb == "active") {
			if ((_loc2.isUse("door")) || (_loc2.isGoNS("door")) || (_loc2.isGoNS("out")) || (_loc2.isLeave("door")) || (_loc2.isLeave("room"))) {
				room = "outside";
				breath = 3;
				Game.changeRoomName("V1RU5 PR150N - Front Lawn");
				if (countdown != 0) {
					this.put("You swim out through the front door and collapse onto the ground. You do not like water very much. The door shuts itself behind you. The lawn is just as it was when you left it.");
				} else {
					this.put("You swim out through the front door and collapse onto the ground. You do not like water very much. The door shuts itself behind you. Unfortunately before you can do anything else, the bomb goes off, as bombs usually do. The explosion, while not as strong as the real bomb would have been, is still strong enough to damage pretty much everything in the area, including you. You are now quite dead. I s'pose this means the world is doomed. Or at very least, it's not the happy ending we want.");
					Game.die();
				}
				return;
			}
		}
		if (bomb && countdown == 0) {
			if (room == "outside") {
				if ((_loc2.isPull("door")) || (_loc2.isOpen("door")) || (_loc2.isGoNS("door")) || (_loc2.isUse("door")) || (_loc2.isEnter("door")) || (_loc2.isUnlock("door")) || (_loc2.isEnter("house")) || (_loc2.isGoNS("house")) || (_loc2.isVisit("house")) || (_loc2.isGoNS("inside"))) {
					this.put("You quickly jump into the house and find yourself suspended in water. You don't worry too much, as the door slams behind you and you prepare for the explosion.");
					this.put("\n\nSuddenly an explosion is heard and the entire room bubbles and foams and shakes. You are startled, even though you were expecting it. And the good news is that you are still very much alive and unharmed! But what sort of state will the lawn be after that detonation?");
					Game.scorePoints(1);
					--countdown;
					bomb = "gone";
					justExploded = true;
					++breath;
					room = "living";
					Game.changeRoomName("V1RU5 PR150N - Living Room");
				} else {
					this.put("Unfortunately before you can do anything else, the bomb goes off, as bombs usually do. The explosion, while not as strong as the real bomb would have been, is still strong enough to damage pretty much everything in the area, including you. You are now quite dead. I s'pose this means the world is doomed. Or at very least, it's not the happy ending we want.");
					Game.die("brody");
				}
			} else {
				this.put("Suddenly an explosion is heard and the entire room bubbles and foams and shakes. You are startled, even though you know it was just the bomb. And the good news is that you are still very much alive and unharmed! But what sort of state will the lawn be after that detonation?");
				Game.scorePoints(1);
				--countdown;
				bomb = "gone";
				justExploded = true;
				++breath;
			}
			return;
		}
		if (room == "living" && river == "inside" && breath == 0 && (!_loc2.isUse("door")) && (!_loc2.isGoNS("door")) && (!_loc2.isGoNS("out")) && (!_loc2.isLeave("door")) || (_loc2.isLeave("room"))) {
			this.put("You start choking and gasping under the water. Everything goes black and your lungs helplessly scream out for air. But it's too late, consciousness is lost, and now you will drift around in the watery grave for eternity...");
			Game.die("brody");
			return;
		}
		if (_loc2.is("inv")) {
			this.put("You got nothin'.");
			return;
		}
		if ((_loc2.isStart("eat")) || (_loc2.isStart("drink"))) {
			this.put("Now is not the time for food!");
			return;
		}
		if ((_loc2.isStart("shoot")) || (_loc2.isStart("use laserball"))) {
			this.put("You have no laserballs, o feathered one. Maybe you should try KICKing things instead?");
			return;
		}
		if ((_loc2.brodyDoSomething()) && (_loc2.contains("brody"))) {
			this.put("You *are* Brody. You don't need that crazy prefix to do stuff anymore!");
			return;
		}
		/*if (_loc2.is("1525")) {
			this.put(synonyms);
			return;
		}*/
		if (room == "outside") {
			if (river != "outside") {
				if (lever) {
					if (_loc2.isLookAt("portal")) {
						this.put("Swirly Photoshopped magic! It's a rotating swirl of purple and blue. Jumping into it should release you from this virus prison.");
						return;
					}
					if ((_loc2.isStart("jump")) || (_loc2.isGoNS("portal")) || (_loc2.isGoNS("edge"))) {
						this.put("You study the angle and distance for a bit, take a running start, and then jump off the edge into the portal. You fall right into it, as if in slow motion. Lightning flashes and purple clouds follow and the next thing you know you're tumbling all over Tampo in the still glitched up lava zone, near the personal chamber.");
						this.put("Now Stlunko just needs to get out, you can't fight the virus guy without him...");
						Game.scorePoints(3);
						pressEnterCallbackFunc = postExit;
						Game.addPause();
						return;
					}
				}
				if (_loc2.isLookAt("fence")) {
					if (bomb != "gone") {
						this.put("It's a white picket fence that guards most of the edge opposite of the HOUSE. It doesn't look very strong, but it does make you feel a little bit safer. It opens in the middle for the walkway and MAILBOX.");
					} else {
						this.put("It's nothing more than some black shards of wood sticking out of the ground. Stupid bomb.");
					}
					return;
				}
				if (_loc2.isKick("fence")) {
					if (bomb != "gone") {
						this.put("Don't hurt it; the fence isn't doing anything wrong.");
					} else {
						this.put("There's nothing left of the fence to attack.");
					}
					return;
				}
				if (_loc2.isLookAt("grass")) {
					if (bomb == "inactive") {
						this.put("It's very grassy and soft. It feels good under your feet. It's been a while since you've felt grass like this... you need to get out of the Lava Zone more often.");
					} else if (bomb == "active") {
						this.put("It's very grassy and soft. There is currently a BOMB resting on it which may prove to be a problem.");
					} else {
						if (river == "inside") {
							this.put("The grass seems to be mostly okay, just covered in a little ash burned off from other objects. The part where the bomb once lied is entirely bare though.");
						} else if (river == "gone") {
							this.put("The grass is completely dry, without even a trace of moisture.");
						}
					}
					return;
				}
				if (_loc2.isLookAt("sidewalk")) {
					if (bomb != "gone") {
						this.put("It's a pretty paved sidewalk leading beyond the MAILBOX to the HOUSE. Nothing too fancy or important.");
					} else {
						this.put("It's a pretty paved sidewalk leading beyond the MAILBOX to the HOUSE. The part near the bomb's explosion is blackened and missing a rock, but otherwise it seems fine.");
					}
					return;
				}
				if (_loc2.contains("garage")) {
					this.put("There is none.");
					return;
				}
				if (_loc2.isLookAt("house")) {
					if (bomb != "gone") {
						this.put("It looks like a quaint little old-fashioned home. You're pretty sure you've seen a few like this waaaay out in the suburbs. Well, those were a little bit more hi-tech than this, but still. It has yella paint on front along with a DOOR and a WINDOW. The inside through the window is dark and blue, and you can't see anything specific. You can't go around it as it gets cut off by an edge of the world.");
					} else {
						if (river != "gone") {
							this.put("Its front has been partially damaged in the explosion, but it still seems structurally sound. Just a flesh wood, I guess. The yellow paint on its DOOR has been blown off, but the DOOR is still holding strong. The WINDOW is the only thing that might be having problems, as it looks cracked and ready to give. All you can see through the fractured glass is the murky blue room on the other side.");
						} else {
							this.put("Its front has been partially damaged in the explosion and subsequent washing, but it still seems structurally sound. Just a flesh wood, I guess. The DOOR held through the rushing rapids. The WINDOW however is almost entirely shattered and washed away, only a few glass shards around the edges remain.");
						}
					}
					return;
				}
				if (_loc2.isKick("house")) {
					if (bomb != "gone") {
						this.put("For whatever reason you give the house a solid kick. It kind of hurts your foot. And this house isn't falling down for you. It's too big.");
					} else {
						if (river != "gone") {
							this.put("Even after being damaged, the house still holds strong to your foot's kick. It's WINDOW looks severely weakened... maybe you should focus attacks on that instead.");
						} else {
							this.put("Even after being damaged, the house still holds strong to your foot's kick. Well, except for the window. That looks pretty dead.");
						}
					}
					return;
				}
				if (_loc2.isUse("house")) {
					this.put("If you want to use the house, why don't you GO through the front DOOR? It doesn't look locked.");
					return;
				}
				if (_loc2.isLookAt("window")) {
					if (bomb != "gone") {
						this.put("It appears to be one of those multi-paned windows, solid and locked tight. You can't see much on the other side because it's all a murky dark blue.");
					} else {
						if (river != "gone") {
							this.put("The explosion caused the glass to become fractured and cracked heavily, it looks likes it's about to give way. Through it you can see nothing but dark blue water.");
						} else {
							this.put("It's been completely wiped out. The edges are lined with some small sharp pieces of glass, but that's it. The rest is gone. Through it you can see a pretty generic living room, completely devoid of water.");
						}
					}
					return;
				}
				if ((_loc2.isOpen("window")) || (_loc2.isUnlock("window"))) {
					if (bomb != "gone") {
						this.put("It's holding fast. Probably locked from the inside.");
					} else {
						if (river != "gone") {
							this.put("Even this damaged, its lock is still holding strong. Try being more physical.");
						} else {
							this.put("It's as open as it'll ever be.");
						}
					}
					return;
				}
				if ((_loc2.isKick("window")) || (_loc2.isBreak("window"))) {
					if (bomb != "gone") {
						if (!seenwater) {
							this.put("What are you, a burglar? Well, you give it a kick but it's entirely ineffectual and you just end up hurting yourself. Must be some of that reinforced glass you've heard about on the Discovery Channel.");
						} else {
							this.put("You try to break the window open with a solid kick so the water can come out, but its too strong and you just end up hurting yourself. Must be some of that reinforced glass you've heard about on the Discovery Channel.");
						}
					} else {
						if (river != "gone") {
							this.put("You give the weakened glass a solid kick, and as soon as you put your foot away the glass begins to implode and shatters outward, the shards just missing you. The giant mass of water in the house suddenly splashes through the opening and completely engulfs you. You are now wading through a huge stream of water flowing from the house, across the yard and over the cliff on the other side. And the bad news is you aren't strong enough to fight the water for long and quickly lose your footing!");
							this.put("\n\nYou better hurry up and GRAB ON TO SOMETHING before you're washed off the edge!");
							river = "outside";
						} else {
							this.put("There's nothing left of the window to kick.");
						}
					}
					return;
				}
				if (_loc2.isLookAt("door")) {
					if (bomb != "gone") {
						this.put("It's a nice blue door, and matches the yellow walls well. You'll easily fit through and doesn't seemed locked, so you should be able to GO right IN. There's a doorbell right next to it.");
					} else {
						this.put("It's a nice blue door, and although it's slightly darkened after the bomb blast, it seems no worse for wear. You could fit through easily, and it doesn't appear to be locked.");
					}
					return;
				}
				if ((_loc2.isRing("bell")) || (_loc2.isUse("bell")) || (_loc2.isPush("bell"))) {
					this.put("You ring the doorbell. Isn't that polite of you? However no one seems to be responding.");
					return;
				}
				if (_loc2.isKnock("door")) {
					if (!knock) {
						this.put("Knock knock.");
						pressEnterCallbackFunc = knockOne;
						Game.addPause();
					} else {
						this.put("Your brain is still bleeding from the first time.");
					}
					return;
				}
				if (_loc2.isKick("door")) {
					if (bomb != "gone") {
						this.put("You try kicking the door down. It holds fast. Pull, don't push?");
					} else {
						this.put("You try kicking the door down, but it's still solid, even after the explosion. Try kicking some weaker things.");
					}
					return;
				}
				// Living room    
				if ((_loc2.isPull("door")) || (_loc2.isOpen("door")) || (_loc2.isGoNS("door")) || (_loc2.isUse("door")) || (_loc2.isEnter("door")) || (_loc2.isUnlock("door")) || (_loc2.isEnter("house")) || (_loc2.isGoNS("house")) || (_loc2.isVisit("house")) || (_loc2.isGoNS("inside"))) {
					if (!lever) {
						room = "living";
						Game.changeRoomName("V1RU5 PR150N - Living Room");
						if (river == "inside") {
							if (!seenwater) {
								this.put("You open the door. It's dark blue and liquidy inside, and there appears to be some sort of plastic wrap completely covering the entrance through the door. When you touch it though, your wing goes right through it, so it must be some sort of forcefield you can phase through. Soon you simply jump right in through the door.");
								pressEnterCallbackFunc = postEnter;
								Game.addPause();
							} else {
								this.put("You jump through the door and easily pierce its force field, landing back in the water. It's too dark and murky to see anything but the DOOR and the WINDOW, as you can't see the other edges of the room. You aren't a very good swimmer so there's no way you'll be able to explore with it flooded like this. If only there were some way to drain it...");
							}
							breath = 4;
						} else {
							if (!seenwater2) {
								this.put("You go into the house again, now that the water's been drained out. It's completely dry, even the carpet, as if the water was never here. On one side of the room is a SOFA and a LAMP, with a TELEVISION facing them on the opposite wall. Both electronics are off. But more interesting is some sort of DEVICE on a corner of the room that is projecting some sort of forcefield over the small section of the house, through which you cannot see. It features three glowing red LIGHTS, and you obviously must get past it.");
								this.put("\n\nBesides the DOOR and WINDOW to the lawn that you know and love, there are other passages lining this room, all conveniently marked with overhead signs. It looks like you can go to a BEDROOM, a KITCHEN, and a BASEMENT.");
								seenwater2 = true;
							} else {
								if (forcefield) {
									this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. There is a DEVICE with three glowing red LIGHTS, emitting a powerful forcefield over a corner of the room. How can you deactivate it? There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
								} else {
									this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. The forcefield DEVICE has been deactivated, and a LEVER can be seen in the corner it had guarded. There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
								}
							}
						}
					} else {
						this.put("You don't need to go back inside. The PORTAL is out here.");
					}
					return;
				}
				if ((_loc2.isGoNS("window")) || (_loc2.isEnter("window"))) {
					if (river == "gone") {
						if (!window) {
							this.put("With all that shattered glass, you'd hurt yourself pretty badly. Just use the DOOR, it's perfectly safe.");
							window = true;
						} else {
							this.put("You insist on going through the window, so you painfully edge your way through. The window isn't really that big, so it takes a little while, but you eventually make it through. You stand up triumphantly, but than collapse from major blood loss. What a dumb way to die.");
							Game.die("brody");
						}
					} else {
						DontUnderstand.parse(this);
					}
					return;
				}
				if (_loc2.isLookAt("mailbox")) {
					if (bomb == "inactive") {
						this.put("It's a pretty standard ol' mailbox. It's flag is up so there's probably something inside. You go up and look through the door, and you see a PACKAGE. Why not get it out?");
					} else if (bomb == "active") {
						this.put("It's a pretty standard old-fashioned mailbox. It's currently open and empty, now that it's ejected his hazardous cargo.");
					} else {
						if (river != "gone") {
							this.put("It's a pretty standard old-fashioned mailbox. It's currently and open and empty, and has been darkened by the bomb's explosion, but otherwise seems to be in good shape.");
						} else {
							this.put("Even after all that abuse, it's still standing. It's a survivor.");
						}
					}
					return;
				}
				if (_loc2.isUse("mailbox")) {
					if (bomb == "inactive") {
						this.put("The mailbox is already being used. Try getting out the PACKAGE that's inside.");
					} else {
						this.put("It's already been opened. There's nothing more inside.");
					}
					return;
				}
				if ((_loc2.isTake("package")) || (_loc2.isOpen("mailbox"))) {
					if (bomb == "inactive") {
						this.put("You open the mailbox to retrieve whatever is inside. As soon as the door clicks fully open, a heavy brown package shoots out and almost knocks you off your feet. As the mailbox closes and its flag drops, the package lands somewhat softly on the grassy lawn, a few feet from the mailbox.");
						this.put("\n\nAs you look at it curiously, the package unwraps itself and appears to be some sort of rectangular device... a BOMB!! It looks just like the one Stlunko had on him, except this one has a clock on it and is ticking! Oh, crap. This can't be good. It appears that you only have about 10 turns before it goes off, so you better get somewhere sheltered before it does!");
						bomb = "active";
					} else {
						if (_loc2.isTake("package")) {
							this.put("You already got all the mail out of the mailbox, and what an evil little package it was.");
						} else if (_loc2.isOpen("mailbox")) {
							this.put("It's already very much open and empty.");
						}
					}
					return;
				}
				if ((_loc2.isJump("cliff")) || (_loc2.isLeave("cliff")) || (_loc2.isGoNS("cliff")) || (_loc2.is("exit"))) {
					if (!lever) {
						if (!jump) {
							this.put("That bottomless black pit you're floating in looks very dangerous to fall in, expecially since you can't fly. You might die of starvation falling down there! It's probably best to stay on your safe little lawn.");
							jump = true;
						} else {
							this.put("Very well, you gather your courage and jump right off the edge of this little world. You fly down the seemingly-endless blackness like a rag doll before finally seeing something below... It's the house and lawn floating in space, just the way you left it. You must have warped back above.");
							this.put("Unfortunately your body is not built for slamming into ground after such a long fall. You hit the lawn hard, breaking every bone in your body and dying somewhat painfully.");
							Game.die("brody");
						}
					} else {
						this.put("You study the angle and distance for a bit, take a running start, and then jump off the edge into the portal. You fall right into it, as if in slow motion. Lightning flashes and purple clouds follow and the next thing you know you're tumbling all over Tampo in the still glitched up lava zone, near the personal chamber.");
						this.put("Now Stlunko just needs to get out, you can't fight the virus guy without him...");
						Game.scorePoints(3);
						pressEnterCallbackFunc = postExit;
						Game.addPause();						
					}
					return;
				}
				if (bomb == "inactive") {
					if (_loc2.isLookAt("package")) {
						this.put("The flag on the mailbox is up, so there's probably something inside. Through a tiny slit on its door you think you see a brown rectangular package.");
						return;
					}
				} else if (bomb == "active") {
					if ((_loc2.isLookAt("bomb")) || (_loc2.isLookAt("package"))) {
						this.put("It's the rectangular type of bomb with wires and stuff you are now familiar with since you helped diffuse one of them several weeks ago. You're sure that they are very potent and you need to seek some sort of protection or shelter before it goes off and hope for the best. Stlunko said that these things very easily can be fatal. The only thing differentiating this one from the one Stlunko currently has is its timer, which says you have about "+countdown+" turns left before detonation.");
						return;
					}
					if (_loc2.isLookAt("timer")) {
						this.put("It says you have around "+countdown+" turns left before the bomb explodes in a very violent manner.");
						return;
					}
					if (_loc2.isTake("bomb")) {
						this.put("Carrying the bomb with you would be very dumb.");
						return;
					}
					if ((_loc2.isKick("bomb")) || (_loc2.isDeactivate("bomb")) || (_loc2.isDestroy("bomb")) || (_loc2.isThrow("bomb")) || (((_loc2.isStart("kick")) || (_loc2.isStart("throw"))) && (_loc2.contains("bomb")) && (_loc2.isEnd("edge")))) {
						this.put("You kick, stomp and smash the bomb around, but it seems impervious to your attacks. In desperation, you kick it right off the edge of your small little world here. It falls down out of sight... did you get rid of it?");
						this.put("No! The bomb comes careening from above and smashes down on the ground right next to you, completely undamaged and still very much active and potent. Aw crap, attacking isn't working. Time to go on the defensive.");
						return;
					}
				} else {
					if (((_loc2.contains("bomb")) || (_loc2.contains("package"))) && (!_loc2.contains("mailbox"))) {
						this.put("The bomb is no more.");
						return;
					}
				}
				if (_loc2.isLookAt("edge")) {
					this.put("Your house and lawn seems to be floating in an endless black void. You probably don't want to fall off the edge.");
					return;
				}
			} else {
				if ((rivercount == 0) && (!_loc2.isGrab("mailbox"))) {
					this.put("Reaching for everything but grasping nothing, but stream of river carries you right over the edge of the world. You fall down the bottomless fit with water splashing and pouring all around.");
					this.put("\n\nSuddenly the water disappears. You find yourself way above the front yard, through which all the water has passed. It now appears to be dry, but still damaged from that explosion. You fall down, down, down... right back on the lawn. Unfortunately your body is not built for slamming into ground after such a long fall. You hit the lawn hard, breaking every bone in your body and dying somewhat painfully.");
					Game.die("brody");
					return;
				} else {
					if (_loc2.isStart("grab")) {
						if ((_loc2.isGrab("house")) || (_loc2.isGrab("door")) || (_loc2.isGrab("window"))) {
							this.put("It's too far away. You've been washed into the lawn. You'll have to grab on to something on the other side.");
						} else if (_loc2.isGrab("fence")) {
							this.put("It was destroyed in the explosion, remember? There's nothing left to grab.");
						} else if (_loc2.isGrab("mailbox")) {
							this.put("You grab onto the mailbox right before flying off the edge. You hang on tight as the water continues to pour and flow. Finally it stops and all the water is gone. All of it. As you let go of the mailbox, you realize that the ground isn't wet at all. Other than the completely destroyed window, there's no sign a raging stream poured through here.");
							Game.scorePoints(1);
							river = "gone";
							rivercount = 0;
						} else if (_loc2.isGrab("grass")) {
							this.put("You quickly duck under water and attempt to stop yourself by grabbing onto the lawn, but all the blades of grass are too small and slippery to get a good hold on.");
						} else if (_loc2.isGrab("walkway")) {
							this.put("You can't reach it, and the water's too fast to swim over there.");
						} else {
							this.put("Grab onto what?!");
						}
						return;
					}
					if (_loc2.contains("swim")) {
						this.put("The water's too strong, you're getting washed away! You never were a very good swimmer.");
						return;
					}
				}
			}
		} else if (room == "living") {
			if (river == "inside") {
				if (((_loc2.isStart("look")) || (_loc2.isStart("go")) || (_loc2.isStart("explore")) || (_loc2.isStart("swim"))) && ((_loc2.isEnd("deeper")) || (_loc2.isEnd("room")) || (_loc2.isEnd("water")))) {
					this.put("You aren't a very good swimmer and you can't hold your breath very long. There's no way you're leaving the safety of the open DOOR out of here until the water is drained.");
					return;
				}
				if (_loc2.isLookAt("door")) {
					this.put("It's wide open, but some sort of forcefield is keeping the water from flowing out. You can use the door to leave this watery place and get some air.");
					return;
				}
				if (_loc2.isLookAt("window")) {
					this.put("You can vaguely see the lawn through its glass. It doesn't feature a forcefield like the door does, so if it could be opened the water would probably pour out, which would be nice.");
					return;
				}
				if ((_loc2.isOpen("window")) || (_loc2.isUse("window")) || (_loc2.isUnlock("window"))) {
					this.put("Unfortunately you can't seem to find any lock on the window for unlocking, so it's still closed hard. You're completely incapable of forcing the window open from inside here.");
					return;
				}
				if (_loc2.isLookAt("forcefield")) {
					this.put("It's transparent and you can go through it like the water's surface tension. However the water seems to be completely held back by it. It completely covers the open DOOR, but the WINDOW has no such protection.");
					return;
				}
				// Lawn room    
				if ((_loc2.isGoNS("door")) || (_loc2.isUse("door")) || (_loc2.isLeave("door")) || (_loc2.isGoNS("lawn")) || (_loc2.isUse("lawn")) || (_loc2.isLeave("lawn")) || (_loc2.isLeave("house")) || (_loc2.isGoNS("out")) || (_loc2.is("leave"))) {
					room = "outside";
					breath = 3;
					Game.changeRoomName("V1RU5 PR150N - Front Lawn");
					if (countdown == 0) {
						this.put("You swim out through the front door and collapse onto the ground. You do not like water very much. The door shuts itself behind you. Unfortunately before you can do anything else, the bomb goes off, as bombs usually do. The explosion, while not as strong as the real bomb would have been, is still strong enough to damage pretty much everything in the area, including you. You are now quite dead. I s'pose this means the world is doomed. Or at very least, it's not the happy ending we want.");
					} else {
						if (!justExploded) {
							this.put("You swim out through the front door and collapse onto the ground. You do not like water very much. The door shuts itself behind you. The lawn is just as you left it.");
						} else {
							this.put("You swim out through the front door and collapse onto the ground. You do not like water very much. The door shuts itself behind you. Everything has been darkened by the bomb's explosion, the bomb itself is no more than some ash on the lawn and the picket fence has been blasted to shreds, but apart from that, nothing seems to be damaged.");
							justExploded = false;
						}
					}
					return;
				}
			} else {
				if ((_loc2.contains("door")) && (!_loc2.contains("lawn")) && (!_loc2.contains("kitchen")) && (!_loc2.contains("bedroom")) && (!_loc2.contains("basement"))) {
					this.put("There be many doors around here. Pick one to focus your command on: LAWN, BEDROOM, BASEMENT or KITCHEN.");
					return;
				}
				if ((_loc2.isLookAt("window")) || (_loc2.isUse("window"))) {
					this.put("It's just as broken from the inside as the out.");
					return;
				}
				// Lawn room    
				if ((_loc2.isGoNS("lawn door")) || (_loc2.isUse("lawn door")) || (_loc2.isLeave("lawn door")) || (_loc2.isGoNS("lawn")) || (_loc2.isUse("lawn")) || (_loc2.isLeave("lawn")) || (_loc2.isLeave("house"))) {
					room = "outside";
					breath = 3;
					Game.changeRoomName("V1RU5 PR150N - Front Lawn");
					if (!lever) {
						this.put("You leave the house and walk onto the front lawn suspended in space. Everything is damaged from the bomb's explosion, but perfectly dry with no trace of the river. On one side of the yard, the picket FENCE is nothing more than a few splinters, while the sturdy MAILBOX is darkened but otherwise fully intact. The HOUSE and its DOOR seem relatively fine, but the WINDOW is completely shattered. The bomb and river are no more.");
					} else {
						this.put("You leave the house and walk onto the front lawn suspected in space. Everything seems fine, except... Aha! There's a PORTAL right off the edge of one of the sides, just waiting to be jumped in. Ready to give a leap of faith?");
					}
					return;
				}
				if (_loc2.isLookAt("lawn")) {
					this.put("It's straight through the LAWN DOOR.");
					return;
				}
				if (_loc2.isLookAt("lawn door")) {
					this.put("That door will take you back outside. The forcefield it used to have seems to be completely gone now. Or at least you can't see or feel it anymore.");
					return;
				}
				if (_loc2.isLookAt("bedroom")) {
					this.put("It's a wooden door, and it appears to be locked on the inside.");
					return;
				}
				if ((_loc2.isOpen("bedroom")) || (_loc2.isGoNS("bedroom")) || (_loc2.isUnlock("bedroom"))) {
					this.put("It's locked tight. You can't get in.");
					return;
				}
				if ((_loc2.isLookAt("kitchen")) || (_loc2.isLookAt("kitchen door"))) {
					this.put("There isn't actually a door obstructing your way to the kitchen, it's more of just an opening in the wall. You can usually go through.");
					return;
				}
				// Kitchen room    
				if ((_loc2.isGoNS("kitchen")) || (_loc2.isGoNS("kitchen door"))) {
					room = "kitchen";
					Game.changeRoomName("V1RU5 PR150N - Kitchen");
					this.put("You walk through the entryway into the small tiled kitchen. It seems very bare, with a bunch of closed cupboards. Besides them, all that's here is a FRIDGE and a SINK. Nothing of much value, it seems. You can exit back to the LIVING ROOM.");
					return;
				}
				if ((_loc2.isLookAt("basement")) || (_loc2.isLookAt("basement door"))) {
					this.put("It should take you downstairs to whatever is below this room.");
					return;
				}
				// Basement room    
				if ((_loc2.isGoNS("basement")) || (_loc2.isGoNS("basement door"))) {
					room = "basement";
					Game.changeRoomName("V14U5 PR150N - Basement");
					if (!light) {
						this.put("You walk onto the basement's staircase and the door shuts behind you by itself. You go down a few steps before stopping, as it is pitch black. You probably shouldn't go down into the room until you can see...");
					} else {
						this.put("You walk down the basement's staircase as the door shuts itself behind you. It cuts off into a bottomless pit at the end, so you only go halfway. Besides the doorway back to the LIVING ROOM, the only thing of note is the light switch and the light bulb it effects.");
					}
					return;
				}
				if (_loc2.isLookAt("sofa")) {
					this.put("It's an orange sofa facing a TELEVISION across the room. Next to it stands one of those tall office LAMPS. The sofa looks comfortable and relaxing. Its only blemish is a duct tape patch on one side.");
					return;
				}
				if (_loc2.isLookAt("patch")) {
					this.put("Smells like doodoo meat.");
					return;
				}
				if ((_loc2.isUse("sofa")) || (_loc2.isRest("sofa")) || (_loc2.isSit("sofa")) || (_loc2.isLay("sofa")) || (_loc2.isGoNS("sofa"))) {
					this.put("You sit down in the sofa and just rest for a minute. It's very comfortable.");
					return;
				}
				if (_loc2.isTurnOn("sofa")) {
					this.put("It doesn't use electricity, mister.");
					return;
				}
				if ((_loc2.isLookAt("lamp")) || (_loc2.isLookAt("light"))) {
					this.put("It's a tall metallic office light. You know, the ones with the bendable neck.");
					if (!lamp) {
						this.put("It has a little stick that can be rotated to turn it on, as it's currently off.");
					} else {
						this.put("It has a little stick that can be rotated to turn it off, as it's currently on.");
					}
					return;
				}
				if ((_loc2.isUse("lamp")) || (_loc2.isTurnOn("lamp")) || (_loc2.isUse("light")) || (_loc2.isTurnOn("light"))) {
					if (!lamp) {
						this.put("You rotate the small switch on the lamp and soon it turns on with a click. It brightens up the room a little, although it doesn't do much as the room was already light to begin with.");
						lamp = true;
						powerCut();
					} else {
						this.put("It's already on, shining with all its might.");
					}
					return;
				}
				if ((_loc2.isTurnOff("lamp")) || (_loc2.isTurnOff("light"))) {
					if (lamp) {
						this.put("Nah, there's no point in that.");
					} else {
						this.put("It's already off.");
					}
					return;
				}
				if (_loc2.isLookAt("tv")) {
					if (!tv) {
						this.put("It is one of those tube televisions, not the flat Plasmas you're used to. It features an on/off button, and the device is currently off.");
					} else {
						this.put("It is one of those tube televisions, not the flat Plasmas you're used to. It's on, but it's all static. It is not getting a reception, apparently.");
					}
					return;
				}
				if ((_loc2.isUse("tv")) || (_loc2.isTurnOn("tv"))) {
					if (!tv) {
						this.put("There's no TV remote lying around, so you go up to the television and push a button on it. It flashes on, but is nothing but static. You go up and down a few channels, but the reception never gets better. Ah, it's what you'd expect in a virus house floating in a black void.");
						tv = true;
						powerCut();
					} else {
						this.put("It's already turned on, and you can't get rid of the static.");
					}
					return;
				}
				if (_loc2.isTurnOff("tv")) {
					if (tv) {
						this.put("No, you shouldn't do that. It's draining energy from the forcefield DEVICE.");
					} else {
						this.put("It's already off.");
					}
					return;
				}
				if (_loc2.isLookAt("device")) {
					if (forcefield) {
						this.put("It's shaped like an arch, with three LIGHTS on top of it. It is emitting a strong forcefield over its corner; you can't see through or penetrate it. You need a way to turn it off... but it lacks any visible switches or buttons.");
					} else {
						this.put("It's shaped like an arch, with three LIGHTS on top of it. The entirely thing is turned off, drained of power. You can see a LEVER on the wall it once hid.");
					}
					return;
				}
				if (_loc2.isTurnOff("device")) {
					if (forcefield) {
						this.put("How do plan on doing that exactly?");
					} else {
						this.put("You already did. Good job.");
					}
					return;
				}
				if (_loc2.isTurnOn("device")) {
					if (forcefield) {
						this.put("It's already in use. You need to make it stop.");
					} else {
						this.put("No, that's a terrible idea.");
					}
					return;
				}
				if (_loc2.isKick("device")) {
					this.put("That's not a very smart idea. These things usually have defence mechanisms or painful aftereffects.");
					return;
				}
				if (_loc2.isLookAt("lights")) {
					this.put("They are three red bulbous lights lining the top of the forcefield device. They seem to be monitoring the device's energy.");
					if (power == 3) {
						this.put("Currently all three are shining brightly.");
					} else if (power == 2) {
						this.put("Currently one light is off, while the other two are shining brightly.");
					} else if (power == 1) {
						this.put("Currently two lights are off, while the remaining light is shining brightly.");
					} else {
						this.put("They are all off, showing that the device is out of power.");
					}
					return;
				}
				if (_loc2.isLookAt("lever")) {
					if (forcefield) {
						DontUnderstand.parse(this);
					} else {
						if (!lever) {
							this.put("It's one of those large levers you see on big machines sometimes. It currently needs to be pulled.");
						} else {
							this.put("It's one of those large levers you see on big machines sometimes. It's already been activated and supposedly opened a portal somewhere.");
						}
					}
					return;
				}
				if ((_loc2.isPull("lever")) || (_loc2.isUse("lever")) || (_loc2.isTurnOn("lever"))) {
					if (forcefield) {
						DontUnderstand.parse(this);
					} else {
						if (!lever) {
							this.put("You grab the lever and push it down with all your might. It easily slides across and clicks into place. You hear a robotic voice from the ceiling say, \"Exit portal opened.\", and some weird noises. However, after everything quiets down, you can't see the portal. Where is it?");
							lever = true;
						} else {
							if (!_loc2.isTurnOn("lever")) {
								this.put("It's already been pushed into the on position, and it'd be pointless to turn it off.");
							} else {
								this.put("It's already in the on position.");
							}
						}
						return;
					}
				}
				if (_loc2.isTurnOff("lever")) {
					if (forcefield) {
						DontUnderstand.parse(this);
					} else {
						if (!lever) {
							this.put("It's already in the off position. You need to TURN it ON.");
						} else {
							this.put("It's already been pushed into the on position, and it'd be pointless to turn it off.");
						}
						return;
					}
				}
			}
		} else if (room == "kitchen") {
			if ((_loc2.isLookAt("cupboard")) || (_loc2.isOpen("cupboard")) || (_loc2.isUse("cupboard")) || (_loc2.isCheck("cupboard"))) {
				this.put("They are wooden and plentiful, but you can't seem to open them at all. Maybe they're fake?");
				return;
			}
			if ((_loc2.isLookAt("fridge")) || (_loc2.isOpen("fridge")) || (_loc2.isUse("fridge")) || (_loc2.isCheck("fridge"))) {
				this.put("The fridge is white and has two separate doors, a large lower one for the main compartment and a smaller higher one, which is probably a freezer. However, neither door can be opened no matter how hard you try. How strange.");
				return;
			}
			if ((_loc2.isTurnOn("fridge")) || (_loc2.isTurnOff("fridge"))) {
				this.put("It might be on already, but you can't check since it won't open. If it isn't, you wouldn't know how to turn it back on anyway.");
				return;
			}
			if ((_loc2.isTurnOn("light")) || (_loc2.isTurnOn("switch")) || (_loc2.isUse("light")) || (_loc2.isUse("switch")) || (_loc2.isFlip("switch"))) {
				this.put("There isn't any light switch here, but it's light enough for you to see fine as it is.");
				return;
			}
			if ((_loc2.isTurnOn("sink")) || (_loc2.isTurnOn("water")) || (_loc2.isUse("sink")) || (_loc2.isUse("water")) || (_loc2.isLookAt("sink"))) {
				this.put("You try to turn on the water faucet, but nothing comes out. Perhaps ALL the water poured out of the house earlier.");
				return;
			}
			// Living room    
			if ((_loc2.isGoNS("living room")) || (_loc2.isGoNS("door")) || (_loc2.isGoNS("back")) || (_loc2.isExit("door")) || (_loc2.isExit("living room"))) {
				room = "living";
				Game.changeRoomName("V1RU5 PR150N - Living Room");
				if (forcefield) {
					this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. There is a DEVICE with three glowing red LIGHTS, emitting a powerful forcefield over a corner of the room. How can you deactivate it? There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
				} else {
					this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. The forcefield DEVICE has been deactivated, and a LEVER can be seen in the corner it had guarded. There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
				}
				return;
			}
		} else if (room == "basement") {
			if ((_loc2.isGoNS("further")) || (_loc2.isGoNS("down")) || (_loc2.isGoNS("deeper")) || (_loc2.isGoNS("downstairs")) || (_loc2.isGoNS("basement"))) {
				if (!light) {
					if (!down) {
						this.put("That's probably not a good idea. It could be hazardous going down there without some light.");
						down = true;
					} else {
						this.put("You continue walking down in pitch darkness anyway. Once you reach the part where the bottom floor should be, you slip and fall off the staircase. But you never hit the ground. You just keep falling, falling through the blackness... Eventually you see something. It's the house and lawn floating in space! You must have warped back above them.");
						this.put("\n\nUnfortunately your body is not built for slamming into ground after such a long fall. You hit the lawn hard, breaking every bone in your body and dying somewhat painfully.");
						Game.die("brody");
					}
				} else {
					this.put("No, not even you are that stupid.");
				}
				return;
			}
			if (_loc2.isLookAt("stairs")) {
				if (!light) {
					this.put("Well, you're standing on it. It leads up to the LIVING ROOM and down to the... basement?");
				} else {
					this.put("Well, you're standing on it. It leads up to the LIVING ROOM and down to a never-ending darkness. Stay away.");
				}
				return;
			}
			if ((_loc2.isLookAt("light")) || (_loc2.isLookAt("lights")) || (_loc2.isLookAt("switch")) || (_loc2.isLookAt("bulb"))) {
				if (!light) {
					this.put("You wish there was some light in here... maybe there's a light switch somewhere.");
				} else {
					this.put("The light bulb is lighting up the place well enough.");
				}
				return;
			}
			// Living room  
			if ((_loc2.isGoNS("up")) || (_loc2.isGoNS("out")) || (_loc2.contains("leave")) || (_loc2.isGoNS("upstairs")) || (_loc2.isGoNS("living room")) || (_loc2.isGoNS("door")) || (_loc2.isGoNS("back")) || (_loc2.isLeave("up")) || (_loc2.isLeave("upstairs")) || (_loc2.isLeave("living room")) || (_loc2.isLeave("door")) || (_loc2.isLeave("back")) || (_loc2.isClimb("up")) || (_loc2.isClimb("upstairs")) || (_loc2.isClimb("living room")) || (_loc2.isClimb("door")) || (_loc2.isClimb("back")) || ((_loc2.isStart("open")) && (_loc2.contains("door"))) || ((_loc2.isStart("use")) && (_loc2.contains("door"))) || ((_loc2.isStart("lighten")) && (_loc2.contains("door"))) || ((_loc2.isStart("brighten")) && (_loc2.contains("door")))) {
				if (!lighten) {
					if ((_loc2.isGoNS("up")) || (_loc2.isGoNS("out")) || (_loc2.contains("leave")) || (_loc2.isGoNS("upstairs")) || (_loc2.isGoNS("living room")) || (_loc2.isGoNS("door")) || (_loc2.isGoNS("back")) || (_loc2.isLeave("up")) || (_loc2.isLeave("upstairs")) || (_loc2.isLeave("living room")) || (_loc2.isLeave("door")) || (_loc2.isLeave("back")) || (_loc2.isClimb("up")) || (_loc2.isClimb("upstairs")) || (_loc2.isClimb("living room")) || (_loc2.isClimb("door")) || (_loc2.isClimb("back"))) {
						room = "living";
						Game.changeRoomName("V1RU5 PR150N - Living Room");
						if (forcefield) {
							this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. There is a DEVICE with three glowing red LIGHTS, emitting a powerful forcefield over a corner of the room. How can you deactivate it? There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
						} else {
							this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. The forcefield DEVICE has been deactivated, and a LEVER can be seen in the corner it had guarded. There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
						}
						if (light && !lightCut) {
							powerCut();
							lightCut = true;
						}
					}
					if (((_loc2.isStart("open")) && (_loc2.contains("door"))) || ((_loc2.isStart("use")) && (_loc2.contains("door"))) || ((_loc2.isStart("lighten")) && (_loc2.contains("door"))) || ((_loc2.isStart("brighten")) && (_loc2.contains("door")))) {
						this.put("You climb back up and open the door to illuminate the staircase with light from upstairs. It doesn't work so well, but you can at least see something now. As you climb back down, the door shuts behind you, cutting off all light again. Drat. Well, you think you saw a LIGHT SWITCH anyway. Try finding that.");
						lighten = true;
					}
				} else {
					if ((_loc2.isGoNS("up")) || (_loc2.isGoNS("out")) || (_loc2.contains("leave")) || (_loc2.isGoNS("upstairs")) || (_loc2.isGoNS("living room")) || (_loc2.isGoNS("door")) || (_loc2.isGoNS("back")) || (_loc2.isLeave("up")) || (_loc2.isLeave("upstairs")) || (_loc2.isLeave("living room")) || (_loc2.isLeave("door")) || (_loc2.isLeave("back")) || (_loc2.isClimb("up")) || (_loc2.isClimb("upstairs")) || (_loc2.isClimb("living room")) || (_loc2.isClimb("door")) || (_loc2.isClimb("back")) || (_loc2.isOpen("door")) || (_loc2.isUse("door"))) {
						room = "living";
						Game.changeRoomName("V1RU5 PR150N - Living Room");
						if (forcefield) {
							this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. There is a DEVICE with three glowing red LIGHTS, emitting a powerful forcefield over a corner of the room. How can you deactivate it? There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
						} else {
							this.put("You walk back into the living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. The forcefield DEVICE has been deactivated, and a LEVER can be seen in the corner it had guarded. There are exits to the LAWN, a BEDROOM, a BASEMENT, and a KITCHEN.");
						}
						if (light && !lightCut) {
							powerCut();
							lightCut = true;
						}
					} else {
						DontUnderstand.parse(this);
					}
				}
				return;
			}
			if (((_loc2.isStart("open")) && (_loc2.contains("door"))) || ((_loc2.isStart("use")) && (_loc2.contains("door"))) || ((_loc2.isStart("lighten")) && (_loc2.contains("door"))) || ((_loc2.isStart("brighten")) && (_loc2.contains("door")))) {
				this.put("You climb back up and open the door to illuminate the staircase with light from upstairs. It doesn't work so well, but you can at least see something now. As you climb back down, the door shuts behind you, cutting off all light again. Drat. Well, you think you saw a LIGHT SWITCH anyway. Try finding that.");
				return;
			}
			if ((_loc2.isTurnOff("lights")) || (_loc2.isTurnOff("light"))) {
				if (!light) {
					this.put("You attempt to turn off the lights even more than they are now, but fail miserably. Mental note: turn on lights on before turning them off.");
				} else {
					this.put("No, you don't want to do that.");
				}
				return;
			}
			if ((_loc2.isUse("light")) || (_loc2.isUse("lights")) || (_loc2.isUse("switch")) || (_loc2.isUse("bulb")) || (_loc2.isFlip("switch")) || (_loc2.isTurnOn("light")) || (_loc2.isTurnOn("lights")) || (_loc2.isTurnOn("switch")) || (_loc2.isTurnOn("bulb")) || (_loc2.isFind("light")) || (_loc2.isFind("lights")) || (_loc2.isFind("switch")) || (_loc2.isFind("bulb"))) {
				if (!light) {
					this.put("You grope around the wall until you finally find a switch near the base. Relieved, you flip it, and a single overhead light bulb turns on and pierces the darkness. You jump back as you realise that there is no basement! Beyond the staircase is nothing but the black nothingness you saw around you outside. It's a good thing you didn't fall!");
					light = true;
				} else {
					this.put("It's already on and doing its job.");
				}
				return;
			}
		}
		if (this.superClassParse()) {
			return;
		}
		DontUnderstand.parse(this);
	}
	function look() {
		if (firstTime == undefined) {
			this.put("You are now a humble BRODY chicken. You appear to be... on a front lawn of a twentieth-century house? Hmm... everything must be really big because you appear human-sized in comparison. The ground below you is mostly grass, except for a walkway leading from the HOUSE behind you to edge of the yard. And instead of a road... it seems to be the edge of this small square of a world. In fact, all sides of the lawn seem to end at an edge. Beyond the edge appears to be black infinity and doesn't look too inviting.");
			this.put("\n\nAcross the house and next to the edge is a MAILBOX next to a small picket FENCE. Wonder if you have any mail. The house features a WINDOW and a DOOR, but you can't see what's inside. It's all too... dark and blue.");
			firstTime = false;
		} else {
			if (room == "outside") {
				if (bomb == "inactive") {
					this.put("You are on a grassy square lawn suspended in black space. There are dangerous edges on three sides, with the front of a HOUSE on the other. The house features a DOOR and a WINDOW, but inside is just dark and blue. A walkway leads from the door across the lawn and to the other side, where a MAILBOX lies just waiting to be opened. Next to it is a small picket FENCE that makes you feel a little bit safer from falling off.");
				} else if (bomb == "active") {
					this.put("You are on a grassy square lawn suspended in black space. There are dangerous edges on three sides, with the front of a HOUSE on the other. The house features a DOOR and a WINDOW, but inside is just dark and blue. A walkway leads from the door across the lawn and to the other side, where a MAILBOX lies next to a small picket FENCE. Near the mailbox sits a BOMB that is probably going to explode real soon.");
				} else {
					if (river == "inside") {
						this.put("You are on a grassy square lawn suspended in black space, and everything is darkened and damaged from the bomb's explosion. On one side of the yard, the picket FENCE is nothing more than a few charred splinters, while the MAILBOX is darkened but otherwise fully intact. The HOUSE and its DOOR are a little charred and chipped, but otherwise seem fine. The WINDOW however looks cracked all over and ready to break. The bomb itself is no more.");
					} else if (river == "outside") {
						this.put("You are currently in the middle of a roaring stream coming out of the house. If you don't GRAB ON TO SOMETHING soon, you'll get washed right off the edge of this world!");
					} else {
						if (!lever) {
							this.put("You are on a grassy square lawn suspended in black space. Everything is damaged from the bomb's explosion, but perfectly dry with no trace of the river. On one side of the yard, the picket FENCE is nothing more than a few splinters, while the sturdy MAILBOX is darkened but otherwise fully intact. The HOUSE and its DOOR seem relatively fine, but the WINDOW is completely shattered. The bomb and river are no more.");
						} else {
							this.put("You leave the house and walk onto the front lawn suspected in space. There is a PORTAL waiting for you right off one of the edges. Elsewhere, everything is damaged from the bomb's explosion, but perfectly dry with no trace of the river. On one side of the yard, the picket FENCE is nothing more than a few splinters, while the sturdy MAILBOX is darkened but otherwise fully intact. The HOUSE and its DOOR seem relatively fine, but the WINDOW is completely shattered. The bomb and river are no more.");
						}
					}
				}
			} else if (room == "living") {
				if (river == "inside") {
					this.put("You are floating in a dark murky room full of water. You can't see any deeper into it, and you aren't a good enough swimmer to explore. All you can see is the open DOOR, which features some sort of anti-water forcefield, and the WINDOW, which is just using its glass to keep the water in.");
				} else {
					if (forcefield) {
						this.put("You are in the perfectly dry living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION.");
						if (!lamp && !tv) {
							this.put("The lamp and TV are both off.");
						} else if (lamp && !tv) {
							this.put("The lamp is on, but the television is off.");
						} else if (!lamp && tv) {
							this.put("The lamp is off, but the television is on.");
						} else {
							this.put("Both the lamp and the TV are on.");
						}
						this.put("There is a DEVICE with three glowing red LIGHTS, emitting a powerful forcefield over a corner of the room. How can you deactivate it?");
						this.put("\n\nThere are doors to the LAWN, a BEDROOM, a BASEMENT and a KITCHEN. You can try checking those out.");
					} else {
						this.put("You are in the perfectly dry living room of the house. Along the walls are a SOFA, a LAMP and a TELEVISION. The lamp and TV are both on. The forcefield-emitting device is now deactivated, and there is a LEVER visible in its corner of the room. Along the walls are doors leading to the LAWN, a BEDROOM, a BASEMENT and a KITCHEN.");
					}
				}
			} else if (room == "kitchen") {
				this.put("You are in a small tiled kitchen. It seems very bare, with a bunch of closed cupboards. Besides them, all that's here is a FRIDGE and a SINK. Nothing of much value, it seems. You can exit back to the LIVING ROOM.");
			} else if (room == "basement") {
				if (!light) {
					this.put("Supposedly you are on a staircase leading down to the basement, but you can't see anything as it's pitch black. To get out you can use the DOOR back up to the living room to get out, as you shouldn't continue down without some light.");
				} else {
					this.put("You are standing in the middle of a staircase, illuminated by a single bulb hanging overhead. Up leads back to the LIVING ROOM, while down will drop you off into a bottomless pit of death.");
				}
			}
		}
		return;
	}
	function knockOne() {
		this.put("Who's there?");
		pressEnterCallbackFunc = knockTwo;
		Game.addPause();
	}
	function knockTwo() {
		this.put("Squeaky.");
		pressEnterCallbackFunc = knockThree;
		Game.addPause();
	}
	function knockThree() {
		this.put("Squeaky who?");
		pressEnterCallbackFunc = knockFour;
		Game.addPause();
	}
	function knockFour() {
		this.put("NOBODY EXPECTS THE SQUEAKY INQUISITION!");
		pressEnterCallbackFunc = knockFive;
		Game.addPause();
	}
	function knockFive() {
		this.put("Uh, yeah. I don't think anybody's home. Don't do that again.");
		knock = true;
		return;
	}
	function postEnter() {
		this.put("You never do hit the floor inside the house. You're floating now... surrounded in dark blue... unable to breathe. You quickly realize that the entire room is flooded with dark murky water, and you're swimming right in the middle of it. You aren't a very good swimmer and you can't hold your breath very long, so the water makes you feel uncomfortable. Fortunately the DOOR remains open and you can easily jump back out through it to get some more air.");
		this.put("\n\nOther than the door, you can't really see much of anything. The room spreads out into darkness and you can't see the edge or anything else in it. Next to the door lies the WINDOW, which seems to lack any anti-water forcefield. That's really the only other thing you notice.");
		seenwater = true;
		return;
	}
	function powerCut() {
		--power;
		if (power == 2) {
			this.put("\n\nSuddenly one of the LIGHTS on the forcefield device flickers off. You must be draining electricity from it or something!");
		} else if (power == 1) {
			this.put("\n\nAnother one of the forcefield device's LIGHTS turns off due to its power being drained. Just one more to go!");
		} else {
			this.put("\n\nThe last light on the forcefield device flickers, and soon the entire thing deactivates. The concealed corner is revealed, showing a LEVER built into the wall. Pull it!");
			Game.scorePoints(1);
			forcefield = false;
		}
		return;
	}
	function postExit() {
		GameState.inControl = "stlunko";
		Game.newRoom("puzzle_stlunko");
		return;
	}
}
	