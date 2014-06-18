//LIB writetexthook_replacement

//-----------------------------------------------------------
//  This is a sample of a function library tha modifies a hook.
//  Please notice the old_hook is preserved (maybe another 
//	library is hooking this routine). This hook routine takes all 
//  text to be written and turns it into uppercase
//----------------------------------------------------------

var old_writeHook = h_writeText;

var h_writeText = function (text)
{
	return text.toUpperCase();
	old_writeHook(text);
}

