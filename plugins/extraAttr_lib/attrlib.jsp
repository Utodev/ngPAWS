//LIB extra attr

var objExtraAttr = new Object();;

var old_extraattr_h_saveGame = h_saveGame;

h_saveGame = function(savegame_object)
{
	savegame_object.objExtraAttr = objExtraAttrts.slice();
	old_extraattr_h_saveGame(savegame_object);
	return savegame_object;
}

var old_extraattr_h_restoreGame = h_restoreGame;

h_restoreGame = function(savegame_object)
{
	objExtraAttr = savegame_object.objExtraAttr.slice();
	old_extraattr_h_restoreGame(savegame_object);
}