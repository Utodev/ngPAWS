//LIB writetexthook_replacement

//-----------------------------------------------------------
//  This is a sample of a function library tha modifies the code hook.
//  Please notice the old_hook is preserved (maybe another 
//	library is hooking this routine). This hook detects if the user typed
//  "version" and outputs text accordingly.
//----------------------------------------------------------

old_ch1_codeHook = h_code;

h_code = function (str)
{
	if (str=='RESPONSE_USER') 
	{
		if (getFlag(33) == 70)  // version
		{
			writeText('A hacked version of ngPAWS ...');
			accDONE();
		}
	}
	old_ch1_codeHook(str);
}


