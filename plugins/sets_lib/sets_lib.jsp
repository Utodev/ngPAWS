//LIB sets_lib.jsp

// This library implements the base code for supporting the sets condacts. It uses hooks to make sure sets are saved into the savegames


MAX_SETS = 4;

var sets;

var old_sets_h_saveGame = h_saveGame;

var h_saveGame = function(savegame_object)
{
	savegame_object.sets = sets.slice();
	old_sets_h_saveGame(savegame_object);
	return savegame_object;
}

var old_sets_h_restoreGame = h_restoreGame;

var h_restoreGame = function(savegame_object)
{
	sets = savegame_object.sets.slice();
	old_sets_h_restoreGame(savegame_object);
}