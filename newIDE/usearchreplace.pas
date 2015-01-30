unit USearchReplace;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfSearchReplace }

  TfSearchReplace = class(TForm)
    bOk: TButton;
    bCancel: TButton;
    checkReplace: TCheckBox;
    checkCaseSensitive: TCheckBox;
    checkWholeWordsOnly: TCheckBox;
    checkOnlyFromCursor: TCheckBox;
    checkOnlyInSelection: TCheckBox;
    EditSearch: TEdit;
    EditReplace: TEdit;
    LabelSearch: TLabel;
    procedure checkReplaceChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fSearchReplace: TfSearchReplace;

implementation

{$R *.lfm}



{ TfSearchReplace }

procedure TfSearchReplace.checkReplaceChange(Sender: TObject);
begin
  EditReplace.Enabled := checkReplace.Checked;
  if not EditReplace.Enabled then EditReplace.Text:='';

end;

procedure TfSearchReplace.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TfSearchReplace.FormKeyPress(Sender: TObject; var Key: char);
begin
  if (key = #27) then Close();
  if (key = #13) then bOk.Click();
end;

procedure TfSearchReplace.FormShow(Sender: TObject);
begin
  EditSearch.SetFocus();
end;

end.

