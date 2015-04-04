//CND ASK W 14 14 1 0

// Global vars for ASK


var inAsk = false;
var ask_responses = null;
var ask_flagno = null;



function ACCask(writeno, writenoOptions, flagno)
{
	inAsk = true;
	writeWriteMessage(writeno);
	ask_responses = getWriteMessageText(writenoOptions);
	ask_flagno = flagno;
}



// hook replacement
var old_ask_h_keydown  = h_keydown;
h_keydown  = function (event)
{
	if (inAsk)
	{
		var keyCodeAsChar = String.fromCharCode(event.keyCode).toLowerCase();
		if (ask_responses.indexOf(keyCodeAsChar)!= -1)
		{
			setFlag(ask_flagno, ask_responses.indexOf(keyCodeAsChar));
			inAsk = false;
			event.preventDefault();
            $('.input').show();
		    $('.input').focus();
		    hideBlock();
			waitKeyCallback();
		};
		return false; // if we are in ASK condact, no keypress should be considered other than ASK response
	} else return old_ask_h_keydown(event);
}
