class FlaskGame {
	var _mc, pausing, homeY, round, nextPosCounter, delays, messages, won, output_mc, tw, ammo, pressEnterCallbackFunc;
	function FlaskGame(p_mc) {
		_mc = p_mc.attachMovie("flaskGame_mc", "flaskGame_mc", 1);
		Game.setScanlines("full");
		var thisGame = this;
		_mc.onEnterFrame = function() {
			thisGame.update();
		};
		pausing = false;
		homeY = _mc.glove_mc._y;
		round = 1;
		ammo = 100;
		nextPosCounter = 10;
		delays = new Array(11, 9, 7, 5, 3);
		messages = new Array();
		/*messages.push("Oh noes, it's still alive! KILL IT! (or the Clambuger equivalent)");
		messages.push("That virus is gonna get hurting real soon. Punch it again!");
		messages.push("Lookit that laser beam go! It hurt virus guy! Use this to your advantage!");
		messages.push("It's on its last legs! Or feet! Or whatever those things are! Zap it till you can ZAP NO MORE!");
		messages.push("Yay! Bye-bye, scary virus man. YOU HAVE DEFEATED THY TAMPOMONKEY!\n[MASH ENTER]");*/
		messages.push("Oh noes, it's still alive. KILL IT DEAD!! Just don't run out of fuel. That'd be unfortunate.");
		messages.push("Lookit him shimmy and shake! Successful shots don't seem to drain fuel. So hit him again!");
		messages.push("Check out that laser beam! It hurts the virus guy! Use this to your advantage!");
		messages.push("It's on its last legs! Or feet! Or whatever those things are! Zap it till you can ZAP NO MORE!!");
		messages.push("Yay! Bye-bye, scary virus man. He is OBLITERATORED!!! Things can only go uphill from here.\n[MASH ENTER]");
		won = false;
		this.moveGlove();
		output_mc = p_mc._parent.output2_mc;
		//trace("output_mc: "+output_mc._name);
		tw = new TextWriter(output_mc.output, output_mc, 3);
		tw.set("Here we go! Use the ENTER key to wham that virus guy right on the noggin with your beam of JUSTICE!!");
		//trace("output_mc: "+output_mc.output.text);
	}
	function update() {
		if (_mc.glove_mc._y<homeY) {
			++_mc.glove_mc._y;
		}
		--nextPosCounter;
		if (nextPosCounter<0) {
			//trace ("FlaskGame::update() nextPosCounter" + nextPosCounter);
			//trace("FlaskGame::update() flask_mc._x = \""+_mc.flask_mc._x+"\"");
			if (pausing) {
			} else {
				_mc.glove_mc._y = homeY;
				this.moveGlove();
				nextPosCounter = delays[round-1];
			}
			if ((_mc.glove_mc._currentframe>=6) && (_mc.glove_mc._currentframe<=9)) {
				if (this.gloveFlaskGrabbable()) {
					this.virusHit();
				}
			}
		}
	}
	function enterPressed() {
		if (!won && !pausing) {
			//trace("FlaskGame::enterPressed()"+this.gloveFlaskGrabbable());
			if ((_mc.glove_mc._currentframe<6) && (ammo>0)) {
				if (this.gloveFlaskGrabbable()) {
					this.virusHit();
				} else {
					_mc.glove_mc.gotoAndPlay("closed");
				}
				ammo -= 5;
				_mc._txt.text = "Laser Energy: "+ammo+"%";
				if (ammo<=0) {
					_mc._parent._parent.gotoAndPlay("flaskGameDeath");
					//_mc.glove_mc.gotoAndStop("empty");
					round = 0;
					tw.set("Uh oh. You're all out of anti-viral lasers. Looks like the virus is gonna take over the world after all.\nPress 'R' to retry final battle for great justice! Or 'Q' to give up and die.");
				}
			}
		} else if (won) {
			_mc._parent._parent.gotoAndStop("endGame");
			SoundFX.stopAll();
			_mc._parent.attachMovie("winner_mc", "winner_mc", 1);
			false;
		}
	}
	function endGame() {
		//trace("endGame");
		_mc.glove_mc.gotoAndStop("closed");
		//_mc.glove_mc._x = 196;
		//_mc.glove_mc._y = 8;
		won = true;
		delete _mc.onEnterFrame;
		_mc.flask_mc.gotoAndPlay("death");
	}
	function moveGlove() {
		/*_mc.gloveMask_mc.gotoAndPlay(2);
		        var _loc2 = Math.floor(Math.random() * 10);
		        if (_loc2 == 0) {
		            _mc.glove_mc._x = 220;
		        } else if (_loc2 < 5) {
		            _mc.glove_mc._x = Math.random() * 60 + 4;
		        } else {
		            _mc.glove_mc._x = Math.random() * 60 + 270;
		        }*/
		var _loc2 = Math.floor(Math.random()*10);
		if (_loc2 == 0) {
			_mc.flask_mc._x = 220;
		} else if (_loc2<5) {
			_mc.flask_mc._x = Math.random()*60+4;
		} else {
			_mc.flask_mc._x = Math.random()*60+270;
		}
	}
	function gloveFlaskGrabbable() {
		return ((_mc.flask_mc._x>=210) && (_mc.flask_mc._x<=250));
	}
	function virusHit() {
		//_mc.glove_mc._x = 196;
		//_mc.glove_mc._y = 8;
		//_mc.gloveMask_mc.gotoAndStop(1);
		nextPosCounter = delays[round-1];
		tw.set(messages[round-1]);
		//Game.scorePoints(round);
		++round;
		ammo += 5;
		if (round == 6) {
			_mc._txt.text = "WIN!";
			_mc.gloveMask_mc.gotoAndStop(1);
			this.endGame();
		} else {
			_mc.glove_mc.gotoAndPlay("closed");
			_mc.flask_mc.gotoAndPlay("hit");
		}
		_mc._health.text = (6-round);
		switch (round) {
		case 2 :
		case 3 :
			Game.scorePoints(0.1);
			break;
		case 4 :
		case 5 :
			Game.scorePoints(0.2);
			break;
		case 6 :
			Game.scorePoints(4);
			break;
		default :
			break;
		}
	}
}
