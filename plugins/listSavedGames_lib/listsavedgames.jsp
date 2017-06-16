//CND LISTSAVEDGAMES A 0 0 0 0

function ACClistsavedgames()
{
  var numberofgames = 0;
  for(var savedgames in localStorage)
  {
    gamePrefix = savedgames.substring(0,16); // takes out ngpaws_savegame_
    if (gamePrefix == "ngpaws_savegame_")
    {
      gameName = savedgames.substring(16);
      writelnText(gameName);
      numberofgames++;
    }
  }
  if (numberofgames == 0) 
  {
     if (getLang()=='EN') writelnText("No saved games found."); else writelnText("No hay ninguna partida guardada.");
  }
}

