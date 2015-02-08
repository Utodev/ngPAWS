unit UPuzzleWizard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls;

type

  { TfPuzzleWizard }

  TfPuzzleWizard = class(TForm)
    ButtonNext: TButton;
    ButtonPrev: TButton;
    CheckBoxLinkedToLocation: TCheckBox;
    CheckBoxRequiresAdject2: TCheckBox;
    CheckBoxRequiresNoun2: TCheckBox;
    CheckBoxRequiresNoun: TCheckBox;
    CheckBoxRequiresPreposition: TCheckBox;
    CheckBoxRequiresAdject1: TCheckBox;
    CheckBoxRequiresAdverb: TCheckBox;
    EditLocation: TEdit;
    EditAdject2: TEdit;
    EditLocationTOF: TEdit;
    EditNoun2: TEdit;
    EditPrep: TEdit;
    EditAdject1: TEdit;
    EditAdverb: TEdit;
    EditVerb: TEdit;
    EditNoun: TEdit;
    GroupBoxLoc: TGroupBox;
    GroupBoxVoc: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    PageControlWizard: TPageControl;
    SynEditCodeGen: TSynEdit;
    TabSheetCodeGen: TTabSheet;
    TabSheetActions: TTabSheet;
    TabSheetVocLoc: TTabSheet;
    TabSheetConditions: TTabSheet;
    procedure ButtonNextClick(Sender: TObject);
    procedure ButtonPrevClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SynEditCodeGenChange(Sender: TObject);
  private
    { private declarations }
    procedure GeneratePuzzle();
    function PuzzleToHEX():String;
    function HEXToPuzzle(HEX: String):Boolean;
    function PuzzleToXML():String;
    function XMLToPuzzle(XML: String):Boolean;
  public
    function SetupPuzzle(Token: String):boolean;
    procedure ClearPuzzle();
    { public declarations }
  end;

var
  fPuzzleWizard: TfPuzzleWizard;

implementation

uses UGlobals;

{$R *.lfm}

{ TfPuzzleWizard }

procedure TfPuzzleWizard.SynEditCodeGenChange(Sender: TObject);
begin

end;

procedure TfPuzzleWizard.ButtonNextClick(Sender: TObject);
begin
  if (PageControlWizard.ActivePageIndex < PageControlWizard.PageCount-1) then
     PageControlWizard.ActivePageIndex := PageControlWizard.ActivePageIndex + 1;

   if PageControlWizard.ActivePageIndex = PageControlWizard.PageCount-1 then
   begin
     ButtonNext.ModalResult:= mrOk;
     ButtonNext.Caption := S_FINISH_MESSAGE;
   end
   else
   begin
     ButtonNext.ModalResult:= mrNone;
     ButtonNext.Caption := S_NEXT_MESSAGE;
   end;



end;

procedure TfPuzzleWizard.ButtonPrevClick(Sender: TObject);
begin
  if PageControlWizard.ActivePageIndex > 0 then PageControlWizard.ActivePageIndex := PageControlWizard.ActivePageIndex -1;
  if PageControlWizard.ActivePageIndex = PageControlWizard.PageCount-1 then
  begin
    ButtonNext.ModalResult:= mrOk;
    ButtonNext.Caption := S_FINISH_MESSAGE;
  end
  else
  begin
    ButtonNext.ModalResult:= mrNone;
    ButtonNext.Caption := S_NEXT_MESSAGE;
  end;
end;

procedure TfPuzzleWizard.FormShow(Sender: TObject);
begin
  PageControlWizard.ActivePageIndex:=0;
  ButtonNext.ModalResult:= mrNone;
  ButtonNext.Caption := S_NEXT_MESSAGE;
end;

function TfPuzzleWizard.SetupPuzzle(Token: String):boolean;
begin
  //
  Result := true;
end;

procedure TfPuzzleWizard.ClearPuzzle();
begin
  //
end;

procedure TfPuzzleWizard.GeneratePuzzle();
var Code : TStringList;
begin
  Code:= TStringList.Create();
  Code.Add(S_PUZZLE_HR);
  Code.Add(S_PUZZLE_TITLE);
  Code.Add( StringReplace(S_PUZZLE_TOKEN,'XXXX', PuzzleToHEX(),[]));
  Code.Add(S_PUZZLE_HR);




  Code.Add(S_PUZZLE_HR);
  Code.Add(S_PUZZLE_BOTTOM);
  Code.Add(S_PUZZLE_BOTTOM_MARK);
  Code.Add(S_PUZZLE_HR);
  SynEditCodeGen.Text:=Code.Text;
  Code.Free();
end;

function TfPuzzleWizard.PuzzleToHEX():String;
var XML : String;
begin
   XML := PuzzleToXML();
   Result := StrToHex(XML);
end;


function TfPuzzleWizard.HEXToPuzzle(HEX: String):Boolean;
var XML : String;
begin
  if (Length(HEX) mod 2 = 0) then // HEX string length must be even
  begin
   HEX := Copy(Hex, 2, Length(HEX)-2); // Remove leading and trailing chars < >
   XML := HexToStr(HEX);
   Result := XMLToPuzzle(XML);
  end else Result := false;
end;

function TfPuzzleWizard.PuzzleToXML():String;
begin
  //
end;

function TfPuzzleWizard.XMLToPuzzle(XML: String):Boolean;
begin
  //
   Result := true;
end;




end.

