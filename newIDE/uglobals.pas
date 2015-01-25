unit UGlobals;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils;

CONST LF = #13#10;
      VK_F1 = $70;


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


implementation

end.

