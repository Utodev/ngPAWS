unit UGlobals;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils;

CONST LF = #13#10;
      VK_F1 = $70;

function StrToHex(Str: String) : String;
function HexToStr(Hex: String): String;
function QuotePath(Path:String):String;


resourcestring

  // UMain Messages
  S_QUIT_NOT_SAVED =   'Some changes may have not been saved.'#13#10'Are you sure?';
  S_REPLACE_INTERRUPT_PROCESS = 'There is already another process marked as interrupt process. Marking this one will deactivate the other.'#13#10'Are you sure?';

  S_WRONG_SETTINGS = 'Compiler, Preprocessor and/or start database not found. Please check paths in the "Compiler" tab in Tools/Options menu.';


  S_MENUITEM_PROCESS = 'Process &';
  S_MENUITEM_RESPONSE = '&Response';

  S_BROWSER_NOT_FOUND = 'Browser not found. Please check Tools/Options and set proper path for your favorite browser.';

  S_FILE_LOADED_WARNING = '>> File has been loaded. To open sections use the "Project" menu <<';
  S_COPYRIGHT = 'ngPAWS Editor (C) 2015 Uto';

  S_COMPILER_NOT_FOUND = 'Compiler not found, please check options to set valid path';
  S_PREPROCESSOR_NOT_FOUND = 'Preprocessor not found, please check options to set valid path';
  S_START_DATABASE_NOT_FOUND = 'Start database not found, please check options to set valid path';

  S_STARTING_PREPROCESSOR = 'Running preprocessor...';
  S_STARTING_COMPILER = 'Running compiler...';
  S_COMPILE_OK = 'OK. Ready to run.';

  S_TOO_MANY_PROCESS = 'Too many processes';

  S_NO_SECTION_OPEN = 'Please open some section from the "Project" menu in order to use this feature.';

  S_SEARCH_REPLACE_NOT_FOUND = ' not found.';

  //UTXP Messages
  S_SECTION_DEFINITIONS = 'Definitions';
  S_SECTION_CONTROL = 'Control';
  S_SECTION_VOCABULARY = 'Vocabulary';
  S_SECTION_SYSMESS = 'System Messages';
  S_SECTION_MESS = 'User Messages';
  S_SECTION_OBJMESS = 'Objects';
  S_SECTION_LOCMESS = 'Locations';
  S_SECTION_CONN = 'Connections';
  S_SECTION_OBJDATA = 'Object Data';
  S_SECTION_PROCESS = 'Process';
  S_SECTION_RESPONSE = 'Response';
  S_SECTION_INTERRUPT = '[INT]';

  S_FILE_NOT_FOUND = 'File not found';
  S_INVALID_FORMAT = 'Not a valid TXP/SCE file';
  S_INVALID_PROCESS_NUMBER = 'Invalid Process Number';
  S_INVALID_SECTION = 'Invalid section';

  S_DEFAULT_FILENAME = 'NewAdventure.txp';
  S_NEWGAME_FILES_NOT_FOUND = 'One or more files required to create a new game are missing, please check your installation.';

  //UOptions

  S_LANGUAGES = 'OS Default'#13#10'English'#13#10'Spanish';

  // UPuzzleWizard

  S_ACTIONS = 'Choose an action...'#13#10'Object <....> appears'#13#10'Object <....> disappears'#13#10'Object <....> appears at location <....>'#13#10'Flag <....> is increased by <....>'#13#10'Flag <....> is decreased by <....>'#13#10'Flag <....> value is set to <....>'#13#10'Destroy connection in direction <....>'#13#10'Set connection in direction <....> to location <....>';
  S_CONDITIONS = 'Choose a condition...'#13#10'Player carries object <....>'#13#10'Player wears object <....>'#13#10'Player does not carry object <....>'#13#10'Object <....> is present'#13#10'Object <....> is absent'#13#10'Object <....> is at location <....>'#13#10'Object <....> is not at location <....>'#13#10'Flag <....> value is <....>'#13#10'Flag <....> value is not <....>'#13#10'Flag <....> value is greater than <....>'#13#10'Flag <....> value is less than <....>'#13#10;
  S_FINISH_MESSAGE = '&Finish';
  S_NEXT_MESSAGE = '&Next >';
  S_WRONG_PUZZLEWIZARD_POSITION = 'Please select an empty zone in the response table or the token of a previous puzzle. If you selected a token and you see this message, probably the token was modified.';

  S_PUZZLE_HR = ';****************************************************************************************************************************';
  S_PUZZLE_TITLE = '; Automatically generated puzzle, please right click the token below and select "Puzzle Wizard" to edit it';
  S_PUZZLE_TITLE2 = '; Don''t delete the token';
  S_PUZZLE_TOKEN = '; TOKEN: [XXXX] TOKEN';
  S_PUZZLE_BOTTOM = '; Please don''t remove the ''end of puzzle'' mark below. Removing it may lead to code corruption';
  S_PUZZLE_BOTTOM_MARK = '; <ENDPUZZLE>';
  S_OBJECT = 'Object';
  S_OBJECT_HINT = 'Please enter number or txtpaws label of an object';
  S_FLAG = 'Flag';
  S_FLAG_HINT = 'Please enter number or txtpaws label of a flag';
  S_LOCATION = 'Location';
  S_LOCATIONS_HINT = 'Please enter number or txtpaws label of a location';
  S_VALUE = 'Value';
  S_VALUE_HINT = 'Please enter a integer positive value or zero';

  S_PLEASE_SELECT_CONDITION = 'Please select a condition';

  S_PLEASE_FILL_IN_FIELDS = 'Please fill in fields';

  S_DIRECTION = 'Direction';
  S_DIRECTION_HINT = 'Please enter a valir direction verb';

  S_VERB_MISSING = 'Please specify a verb for player order';
  S_NOUN_MISSING ='Please specify a noun for player order';
  S_NOUN2_MISSING ='Please specify a second noun for player order';
  S_ADVERB_MISSING ='Please specify an adverb for player order';
  S_PREP_MISSING ='Please specify a preposition for player order';
  S_ADJECT1_MISSING ='Please specify an adjetive for player order';
  S_ADJECT2_MISSING ='Please specify an adjetive for second noun player order';
  S_LOCATION_MISSING ='Please specify a location if puzzle is linked to location';
  S_LOCATION_TOF_MISSING ='Please specify a text on failute is player is not at specified location';
  S_TOS_MISSING ='Please specify a text on success';

  S_UNEXPECTED_CONDITION = 'Unexpected condition';

  S_NO_END_OF_PUZZLE = 'Mark of end of puzzle not found.';


implementation

uses lclintf;

function StrToHex(Str: String) : String;
var i : integer;
begin
  result := '';
  for i := 1 to length(Str) do
      result := result + IntToHex(ord(Str[i]),2)
end;

function HexToStr(Hex: String): String;
var i: integer;
begin
  Result:=''; i:=1;
  while i<Length(Hex) do
  begin
    Result:=Result+Chr(StrToIntDef('$'+Copy(Hex,i,2),0));
    i := i+ 2;
  end;
  Result := AnsiToUtf8(Result);
end;

function QuotePath(Path:String):String;
begin
  {$ifdef Windows}
    Path:= StringReplace(Path, '"','\"', []);
    Path := '"' + Path + '"';
  {$else}
    Path:= StringReplace(Path, ' ','\ ', []);
  {$endif}
  Result := Path;
end;


end.

