//LIB nmplikeconversation.jsp

// This library implements the base code for supporting the INCLUDE/EXCLUDE condacts, and enter the savegame hooks to save conversation status.
// It is an aproximation to NMP parser style conversations (menu guided)


var conv_list = new Array();
var conv_active_sentences = new Array();


var old_nmpconv_h_saveGame = h_saveGame;

var h_saveGame = function(savegame_object)
{
	savegame_object.conv_active_sentences = conv_active_sentences.slice();
	savegame_object.conv_list = conv_list.slice();
	old_nmpconv_h_saveGame(savegame_object);
	return savegame_object;
}

var old_sets_h_restoreGame = h_restoreGame;

var h_restoreGame = function(savegame_object)
{
	conv_active_sentences = savegame_object.conv_active_sentences.slice();
	conv_list = savegame_object.conv_list.slice();
	old_nmpconv_h_restoreGame(savegame_object);
}