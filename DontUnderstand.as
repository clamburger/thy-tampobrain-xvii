class DontUnderstand {
	function DontUnderstand() {
	}
	static function parse(rm) {
		var _loc2 = Game.tp;

		if (_loc2.is("inventory")) {
			rm.put(GameState.getInvString());
			return;
		}
		if ((_loc2.isGo("north")) || (_loc2.isGo("south")) || (_loc2.isGo("west")) || (_loc2.isGo("east"))) {
			rm.put("You try to go that way but end up floating into a wall. Bonk.");
			return;
		}

		switch (Math.floor(Math.random()*3)) {
		case 0 :
			if (GameState.inControl != "stlunko") {
				rm.put("You obviously can\'t do that. Try something else.");
			} else {
				rm.put("You obviously cannot do that. Try something else.");
			}
			break;
		case 1 :
			rm.put("That command made my stummy hurt. Keep try.");
			break;
		case 2 :
			if (GameState.inControl != "stlunko") {
				rm.put("That\'s a stupid idea. Try something else.");
			} else {
				rm.put("That is a stupid idea. Try something else.");
			}
			break;
		default :
			break;
		}
	}
}
