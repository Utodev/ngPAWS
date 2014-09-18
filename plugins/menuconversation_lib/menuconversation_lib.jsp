//LIB menuconversation_lib.jsp

var conversation_sentences = [];

var old_menuconversation_h_restart = h_restart;

var h_restart = function() 
{
conversation_sentences = [];
}

var old_menuconversation_h_saveGame = h_saveGame;

var h_saveGame = function(savegame_object)
{
	savegame_object.conversation_sentences = conversation_sentences.slice();
	old_menuconversation_h_saveGame(savegame_object);
	return savegame_object;
}

var old_menuconversation_h_restoreGame = h_restoreGame;

var h_restoreGame = function(savegame_object)
{
	conversation_sentences = savegame_object.conversation_sentences.slice();
	old_menuconversation_h_restoreGame(savegame_object);
}

