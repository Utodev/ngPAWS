//LIB nmplikeconversation.jsp

// This library implements the base code for supporting the INCLUDE/EXCLUDE condacts, and enter the savegame hooks to save conversation status.
// It is an aproximation to NMP parser style conversations (menu guided)


// Stores the global list of active sentences
var conv_active_sentences = new Array();

// Stores the currently displayed menu, option # and matching sentence #
var conv_current_menu = new Array();

var old_nmpconv_h_saveGame = h_saveGame;

h_saveGame = function(savegame_object)
{
	savegame_object.conv_active_sentences = conv_active_sentences.slice();
	old_nmpconv_h_saveGame(savegame_object);
	return savegame_object;
}

var old_nmpconv_h_restoreGame = h_restoreGame;

h_restoreGame = function(savegame_object)
{
	conv_active_sentences = savegame_object.conv_active_sentences.slice();
	old_nmpconv_h_restoreGame(savegame_object);
}

var old_nmpconv_h_keydown = h_keydown;

h_keydown = function (event)
{
	if (!conv_current_menu.length) return;
	if (!conv_active_conversation_id == null) return;
	if (event.keyCode<49) return;
	if(event.keyCode>57)
	console.log(event.keyCode);
	console.log(conv_current_menu);
	var conv_settings = conv_current_menu[0].split('_');

	var callString = 'responseConv' + conv_settings[0] + '(' + conv_settings[1] + ', ' +   conv_current_menu[event.keyCode - 48] + ')';
	console.log(callString);
	eval (callString);
	old_nmpconv_h_keydown(event);
}


function clearConvOptionsArray()
{
	conv_current_menu = [];
	conv_active_conversation_id = null;
}

function convOptionWrite(conversation_id, option_id, text, convFlag, phrasenum)
{
	conv_current_menu[option_id] = phrasenum;
	conv_current_menu[0] = conversation_id + '_' + convFlag;
	var str = option_id + '.- {CLASS|nmpconvoption|{EXTERN|responseConv' + conversation_id + '(' + convFlag + ',' + phrasenum + ')|' + text + '}}\n';
	//var str = '- {CLASS|nmpconvoption|{EXTERN|responseConv4(' + convFlag + ',' + phrasenum + ')|' + text + '}}\n';
	writeText(str);
}