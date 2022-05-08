//CND LISTSAVEDGAMES A 0 0 0 0
//listsavedgames (i/o) v1.0

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
            writeText(filterText(" {EXTERN|exportgame('" + gameName + "')|<sub>[↧]}</sub>"));
            writelnText(gameName);
            numberofgames++;
        }
    }
    if (numberofgames == 0) 
    {
        if (getLang()=='EN') writelnText("No saved games found."); else writelnText("No hay ninguna partida guardada.");
    }
    else writeText(STR_NEWLINE); // End list with a new line

    if (getLang()=='EN') writelnText(filterText("You could also {EXTERN|importgame()|import} a saved game")); else writelnText(filterText("También se puede {EXTERN|importgame()|importar} una partida"));
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

//LIB EXPORTGAME

function exportgame(gametitle) 	
{
    filename = gametitle;
	var json_str;
	if (filename == null) filename = prompt(getSysMessageText(SYSMESS_LOADFILE),'');
    json_str = localStorage.getItem('ngpaws_savegame_' + filename.toUpperCase());
	if (json_str)
	{
        var blob = new Blob([json_str], {type:"application/json;charset=utf-8"});
        var url = URL.createObjectURL( blob );
        var link = document.createElement( 'a' );
        link.setAttribute( 'href', url );
        link.setAttribute( 'download', filename + '.json' );
        var event = document.createEvent( 'MouseEvents' );
        event.initMouseEvent( 'click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
        link.dispatchEvent( event );
	}
	else
	{
		writeSysMessage(SYSMESS_FILENOTFOUND);
		ACCnewline();
		done_flag = true;
	}
	focusInput();
}

//LIB IMPORTGAME

function importgame()
{
    var link = document.createElement('input');
    link.setAttribute('type', 'file');
    link.setAttribute('id', 'inputjson');
    link.setAttribute('onchange', 'readJSONFile(this.files[0])');
    var event = document.createEvent( 'MouseEvents' );
    event.initMouseEvent('click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
    link.dispatchEvent(event);
}

async function readJSONFile(file) {
    let fileReader = new FileReader();
    fileReader.addEventListener("load", e => {
        try {
            var gameObject = JSON.parse(fileReader.result);
            restoreSaveGameObject(gameObject);
            if (getLang()=='EN') writelnText("Saved game imported. Loading"); else writelnText("Saved game importado. Cargando");
            ACCanykey();    //TODO: Fix this workaround to make ACCdesc to work
    		ACCdesc();
    		focusInput();
        }
        catch (e) {
            if (getLang()=='EN') writelnText("Couldn't read json information. Wrong format?"); else writelnText("No se ha podido leer el json. ¿Error de formato?");
            console.log("Error loading saved game json", e); 
        }
    });
    fileReader.readAsText(file);
}

