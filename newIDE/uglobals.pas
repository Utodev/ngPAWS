unit UGlobals;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils;

CONST LF = #13#10;
      VK_F1 = $70;

function StrToHex(Str: String) : String;
function HexToStr(Hex: String): String;


resourcestring

  // UMain Messages
  S_QUIT_NOT_SAVED =   'Some changes may have not been saved.'#13#10'Are you sure?';
  S_REPLACE_INTERRUPT_PROCESS = 'There is already another process marked as interrupt process. Marking this one will deactivate the other.'#13#10'Are you sure?';

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

  // UPuzzleWizard
  S_FINISH_MESSAGE = '&Finish';
  S_NEXT_MESSAGE = '&Next >';
  S_WRONG_PUZZLEWIZARD_POSITION = 'Please select an empty zone in the response table or the token of a previous puzzle';

  S_PUZZLE_HR = ';****************************************************************************************************************************';
  S_PUZZLE_TITLE = '; Automatically generated puzzle, please right click the token below and select "Puzzle Wizard" to edit it';
  S_PUZZLE_TITLE2 = '; Don''t delete the token';
  S_PUZZLE_TOKEN = '; TOKEN: [XXXX] TOKEN';
  S_PUZZLE_BOTTOM = '; Please don''t remove the keep the puzzle end mark below. Removing it may lead to code corruption';
  S_PUZZLE_BOTTOM_MARK = '; <ENDPUZZLE>';


implementation

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
end;


end.

