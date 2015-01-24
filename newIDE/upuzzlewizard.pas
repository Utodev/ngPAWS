unit UPuzzleWizard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfPuzzleWizard }

  TfPuzzleWizard = class(TForm)
    Memo1: TMemo;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fPuzzleWizard: TfPuzzleWizard;

implementation

{$R *.lfm}

end.

