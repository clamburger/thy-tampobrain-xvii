class Room_end_game extends Room {
	var synonyms, put, superClassParse, firstTime, pressEnterCallbackFunc;
	function Room_end_game() {
		super();
	}
	function getName() {
		return ("Mnonion Pssgjwai");
	}
	function parse() {
		// No commands should ever be sent in this room!
	}
	function look() {
		endGameOne();
	}
	function endGameOne() {
		this.put("Excited to leave this room, you roll down the tunnel as fast as your conveyer belt will let you. Before you know it, you crash into Tampo and Brody, who had just escaped from their own prisons. Shaken up, you all regain your composure...");
		this.put("\n[PRESS ENTER]");
		pressEnterCallbackFunc = endGameTwo;
		Game.addPause();
		return;
	}
	function endGameTwo() {
		this.put("Alright Tampo, let's do this. You're right outside of your personal chamber, and you can't quite see the main virus from this angle. But it also can't see you. Stlunko sets all your anti-viral shield to maximum. Then he reaches for Brody's and starts inputting special commands into it.");
		this.put("\n\n\"Uh... Stlunko, what are you doing?\" Brody asks nervously.");
		this.put("\n\nStlunko replies, \"Do not worry, Brody. Everything will be all right. But I need this right now.\"");
		this.put("\n\nYou audibly gasp when Brody's anti-virus forcefield suddenly deactivates. In a split second, he is transformed by the virus into thousands of tiny winged Terrells which are blown away as if by wind.");
		pressEnterCallbackFunc = endGameThree;
		Game.addPause();
		return;
	}
	function endGameThree() {
		this.put("\"Stlunko, what did you just do?!\"");
		this.put("\n\n\"He will be fine, I am sure. Now listen carefully. Your version of anti-viral software is incompatible with ours, so I will have to use mine with Brody's to build the weapon.\"");
		this.put("\n\n\"You mean...\"");
		this.put("\n\n\"Yes, you will be on your own. But this will turn into a ray gun that should connect to you telekinetically. Use it to defeat the virus headmaster, and everything will be fine.\"");
		this.put("\n\n\"I guess... I can do that.\"");
		pressEnterCallbackFunc = endGameFour;
		Game.addPause();
		return;
	}
	function endGameFour() {
		this.put("Stlunko programs some commands into his own. Suddenly, with the push of a final button, his forcefield deactivates. He changes into a still-frame \"The Castlefunnies\" caricature and starts spewing out commas. Or apostrophes. At any rate, he's pretty creepy looking.");
		this.put("\n\nThe two anti-virus devices combine into each other and become what looks like a remote with lights on it. You soon find yourself able to control it by thought and after some brief practice shots, you think you've got the hand of it. Gathering your courage, you prepare to burst into your room and take down that virus guy...");
		this.put("\n\nCHAAARRRRGGEE!!!!!");
		pressEnterCallbackFunc = endGameFive;
		Game.addPause();
		return;
	}
	function endGameFive() {
		Game.flaskGameStart();
		return;
	}
}