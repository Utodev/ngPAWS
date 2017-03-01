program ngpaws;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, UMain, uoptions, urunshell, UConfig, UTXP, UGlobals,
  uabout, upuzzlewizard, USearchReplace;



{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfOptions, fOptions);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfSearchReplace, fSearchReplace);
  Application.CreateForm(TfPuzzleWizard, fPuzzleWizard);
  Application.Run;
end.

