//CND LISTSAVEDGAMES A 0 0 0 0

function ACClistsavedgames()
{
  for(var savedgames in localStorage)
  {
    gamePrefix = savedgames.substring(0,16); // takes out ngpaws_savegame_
    if (gamePrefix == "ngpaws_savegame_")
    {
      gameName = savedgames.substring(16);
      writelnText(gameName);
    }
  }
}

