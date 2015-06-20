//LIB loc_attributes.jsp

// This library implements attributes for locations, just like the object attributes


locsAttrLO = [];
locsAttrHI = [];


var old_locattr_h_saveGame = h_saveGame;

h_saveGame = function(savegame_object)
{
	savegame_object.locsAttrLO = locsAttrLO.slice();
	savegame_object.locsAttrHI = locsAttrHI.slice();
	old_locattr_h_saveGame(savegame_object);
	return savegame_object;
}

var old_locattr_h_restoreGame = h_restoreGame;

h_restoreGame = function(savegame_object)
{
	locsAttrLO = savegame_object.locsAttrLO.slice();
	locsAttrHI = savegame_object.locsAttrHI.slice();
	old_locattr_h_restoreGame(savegame_object);
}

// AUX
function locIsAttr(locno, attrno)
{
	if (attrno > 63) return false;
	var attrs = locsAttrLO[locno];
	if (attrno > 31)
	{
		attrs = locsAttrHI[locno];
		attrno = attrno - 32;
	}
	return bittest(attrs, attrno);
}
