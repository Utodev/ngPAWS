//CND LISTSAVEDGAMES A 0 0 0 0
//listsavedgames v1.1

function ACClistsavedgames()
{
    var numberofgames = 0;
    for(var savedgames in localStorage)
    {
        gamePrefix = savedgames.substring(0,16); // takes out ngpaws_savegame_
        if (gamePrefix == "ngpaws_savegame_")
        {
            gameName = savedgames.substring(16);
            if (numberofgames > 0) writeText(", "); // add a coma if needed
            writeText(filterText("{EXTERN|loadgame('" + gameName + "')|" + gameName + "}"));
            writelnText(gameName);
            numberofgames++;
        }
    }
    if (numberofgames == 0) 
    {
        if (getLang()=='EN') writelnText("No saved games found."); else writelnText("No hay ninguna partida guardada.");
    }
    else writeText(STR_NEWLINE); // End list with a new line
}

//LIB LOADGAME

function loadgame(gametitle) 	
{
    filename = gametitle;
    var json_str;
    if (filename == null) filename = prompt(getSysMessageText(SYSMESS_LOADFILE),'');
    json_str = localStorage.getItem('ngpaws_savegame_' + filename.toUpperCase());
    if (json_str)
	{
		savegame_object = JSON.parse(json_str.trim());
		restoreSaveGameObject(savegame_object);
        ACCanykey();    //TODO: Fix this workaround to make ACCdesc to work
		ACCdesc();
	}
	else
	{
		writeSysMessage(SYSMESS_FILENOTFOUND);
		ACCnewline();
		done_flag = true;
	}
	focusInput();
}
