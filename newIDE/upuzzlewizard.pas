unit UPuzzleWizard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, Menus;

type

  { TfPuzzleWizard }

  TfPuzzleWizard =
    class(TForm)
    ButtonAddCondition: TButton;
    ButtonAddAction: TButton;
    ButtonNext: TButton;
    ButtonPrev: TButton;
    CheckBoxIncludeWordsOnFailure: TCheckBox;
    CheckBoxLinkedToLocation: TCheckBox;
    CheckBoxRequiresAdject2: TCheckBox;
    CheckBoxRequiresNoun2: TCheckBox;
    CheckBoxRequiresNoun: TCheckBox;
    CheckBoxRequiresPreposition: TCheckBox;
    CheckBoxRequiresAdject1: TCheckBox;
    CheckBoxRequiresAdverb: TCheckBox;
    ComboBoxConditionSelect: TComboBox;
    ComboBoxActionSelect: TComboBox;
    EditActionP1: TEdit;
    EditActionP2: TEdit;
    EditConditionTOF: TEdit;
    EditConditionP1: TEdit;
    EditConditionP2: TEdit;
    EditLocation: TEdit;
    EditAdject2: TEdit;
    EditLocationTOF: TEdit;
    EditNoun2: TEdit;
    EditPrep: TEdit;
    EditAdject1: TEdit;
    EditAdverb: TEdit;
    EditTOS: TEdit;
    EditVerb: TEdit;
    EditNoun: TEdit;
    GroupBox1: TGroupBox;
    GroupBoxLoc: TGroupBox;
    GroupBoxVoc: TGroupBox;
    LabelInstructions4: TLabel;
    LabelInstrructions3: TLabel;
    LabelInstructions2: TLabel;
    LabelInstructions1: TLabel;
    LabelTOS: TLabel;
    LabelVerb: TLabel;
    LabelLocationTOF: TLabel;
    LabelActionP1: TLabel;
    LabelActionP2: TLabel;
    LabelCondTOF: TLabel;
    LabelCondP1: TLabel;
    LabelCondP2: TLabel;
    ListBoxConditions: TListBox;
    ListBoxActions: TListBox;
    PMDeleteLine: TMenuItem;
    PMMoveDown: TMenuItem;
    PMMoveUp: TMenuItem;
    PageControlWizard: TPageControl;
    PopupMenuLists: TPopupMenu;
    SynEditCodeGen: TSynEdit;
    TabSheetCodeGen: TTabSheet;
    TabSheetActions: TTabSheet;
    TabSheetVocLoc: TTabSheet;
    TabSheetConditions: TTabSheet;
    procedure ButtonAddActionClick(Sender: TObject);
    procedure ButtonAddConditionClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure ButtonPrevClick(Sender: TObject);
    procedure CheckBoxLinkedToLocationChange(Sender: TObject);
    procedure CheckBoxRequiresAdject1Change(Sender: TObject);
    procedure CheckBoxRequiresAdject2Change(Sender: TObject);
    procedure CheckBoxRequiresAdverbChange(Sender: TObject);
    procedure CheckBoxRequiresNoun2Change(Sender: TObject);
    procedure CheckBoxRequiresNounChange(Sender: TObject);
    procedure CheckBoxRequiresPrepositionChange(Sender: TObject);
    procedure ComboBoxActionSelectChange(Sender: TObject);
    procedure ComboBoxConditionSelectChange(Sender: TObject);
    procedure EditActionKeyPress(Sender: TObject; var Key: char);
    procedure EditConditionKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure PMDeleteLineClick(Sender: TObject);
    procedure PMMoveDownClick(Sender: TObject);
    procedure PMMoveUpClick(Sender: TObject);
    procedure SynEditCodeGenChange(Sender: TObject);
    procedure TabSheetConditionsShow(Sender: TObject);
  private
    { private declarations }
    procedure GeneratePuzzle();
    function getOppositeCondact(S: String): string;
    function getCondact(S: String): string;
    function getTOF(S:String):String;
    function PuzzleToHEX():String;
    function HEXToPuzzle(HEX: String):Boolean;
    function PuzzleToXML():String;
    function XMLToPuzzle(XML: String):Boolean;
    function checkValidData(): boolean;
  public
    function SetupPuzzle(Token: String):boolean;
    procedure ClearPuzzle();
    { public declarations }
  end;

var
  fPuzzleWizard: TfPuzzleWizard;

implementation

uses UGlobals, DOM, XMLRead ;

{$R *.lfm}

{ TfPuzzleWizard }

procedure TfPuzzleWizard.SynEditCodeGenChange(Sender: TObject);
begin

end;

procedure TfPuzzleWizard.TabSheetConditionsShow(Sender: TObject);
begin
  ComboBoxActionSelect.Items.Text:= S_ACTIONS;
  ComboBoxActionSelect.ItemIndex:=0;
  ComboBoxConditionSelect.Items.Text := S_CONDITIONS;
  ComboBoxConditionSelect.ItemIndex:=0;
end;

procedure TfPuzzleWizard.ButtonNextClick(Sender: TObject);
begin

  if (PageControlWizard.ActivePage = TabSheetActions) then
     if not checkValidData() then Exit;

  if (PageControlWizard.ActivePage = TabSheetActions) then GeneratePuzzle();



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

procedure TfPuzzleWizard.ButtonAddConditionClick(Sender: TObject);
begin
   if (ComboBoxConditionSelect.ItemIndex = 0) then Exit;

   if (EditConditionTOF.Text = '') then
   begin
     ShowMessage(S_PLEASE_FILL_IN_FIELDS);
     Exit();
   end;

  case ComboBoxConditionSelect.ItemIndex of
   1: if (EditConditionP1.Text <> '') then ListBoxConditions.Items.Add('CARRIED ' + EditConditionP1.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   2: if (EditConditionP1.Text <> '') then ListBoxConditions.Items.Add('WORN ' + EditConditionP1.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   3: if (EditConditionP1.Text <> '') then ListBoxConditions.Items.Add('NOTCARR ' + EditConditionP1.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   4: if (EditConditionP1.Text <> '') then ListBoxConditions.Items.Add('PRESENT ' + EditConditionP1.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   5: if (EditConditionP1.Text <> '') then ListBoxConditions.Items.Add('ABSENT ' + EditConditionP1.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   6: if (EditConditionP1.Text <> '') and (EditConditionP2.Text <> '') then ListBoxConditions.Items.Add('ISAT ' + EditConditionP1.Text + ' ' + EditConditionP2.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   7: if (EditConditionP1.Text <> '') and (EditConditionP2.Text <> '') then ListBoxConditions.Items.Add('ISNOTAT ' + EditConditionP1.Text + ' ' + EditConditionP2.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   8: if (EditConditionP1.Text <> '') and (EditConditionP2.Text <> '') then ListBoxConditions.Items.Add('EQ ' + EditConditionP1.Text + ' ' + EditConditionP2.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   9: if (EditConditionP1.Text <> '') and (EditConditionP2.Text <> '') then ListBoxConditions.Items.Add('NOTEQ ' + EditConditionP1.Text + ' ' + EditConditionP2.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
  10: if (EditConditionP1.Text <> '') and (EditConditionP2.Text <> '') then ListBoxConditions.Items.Add('GT ' + EditConditionP1.Text + ' ' + EditConditionP2.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
  11: if (EditConditionP1.Text <> '') and (EditConditionP2.Text <> '') then ListBoxConditions.Items.Add('LT ' + EditConditionP1.Text + ' ' + EditConditionP2.Text + '|' + EditConditionTOF.Text) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
  end;

end;

procedure TfPuzzleWizard.ButtonAddActionClick(Sender: TObject);
begin
   if (ComboBoxActionSelect.ItemIndex = 0) then Exit;


  case ComboBoxActionSelect.ItemIndex of
   1: if (EditActionP1.Text <> '') then ListBoxActions.Items.Add('CREATE ' + EditActionP1.Text)  else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   2: if (EditActionP1.Text <> '') then ListBoxActions.Items.Add('DESTROY ' + EditActionP1.Text)  else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   3: if (EditActionP1.Text <> '') and (EditActionP2.Text <> '') then ListBoxActions.Items.Add('PLACE ' + EditActionP1.Text + ' ' + EditActionP2.Text ) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   4: if (EditActionP1.Text <> '') and (EditActionP2.Text <> '') then ListBoxActions.Items.Add('PLUS ' + EditActionP1.Text + ' ' + EditActionP2.Text ) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   5: if (EditActionP1.Text <> '') and (EditActionP2.Text <> '') then ListBoxActions.Items.Add('MINUS ' + EditActionP1.Text + ' ' + EditActionP2.Text ) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   6: if (EditActionP1.Text <> '') and (EditActionP2.Text <> '') then ListBoxActions.Items.Add('LET ' + EditActionP1.Text + ' ' + EditActionP2.Text ) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   7: if (EditActionP1.Text <> '') then ListBoxActions.Items.Add('CLEAREXIT &&_voc_' + EditActionP1.Text)  else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
   8: if (EditActionP1.Text <> '') and (EditActionP2.Text <> '') then ListBoxActions.Items.Add('SETEXIT &&_voc_' + EditActionP1.Text + ' ' + EditActionP2.Text ) else ShowMessage(S_PLEASE_FILL_IN_FIELDS);
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

procedure TfPuzzleWizard.CheckBoxLinkedToLocationChange(Sender: TObject);
begin
  EditLocation.Enabled:= CheckBoxLinkedToLocation.Checked;
  EditLocationTOF.Enabled := CheckBoxLinkedToLocation.Checked;
end;

procedure TfPuzzleWizard.CheckBoxRequiresAdject1Change(Sender: TObject);
begin
  EditAdject1.Enabled := CheckBoxRequiresAdject1.Checked;
end;

procedure TfPuzzleWizard.CheckBoxRequiresAdject2Change(Sender: TObject);
begin
  EditAdject2.Enabled:=CheckBoxRequiresAdject2.Checked;
end;

procedure TfPuzzleWizard.CheckBoxRequiresAdverbChange(Sender: TObject);
begin
  EditAdverb.Enabled:=CheckBoxRequiresAdverb.Checked;
end;

procedure TfPuzzleWizard.CheckBoxRequiresNoun2Change(Sender: TObject);
begin
  EditNoun2.Enabled:=CheckBoxRequiresNoun2.Checked;
end;

procedure TfPuzzleWizard.CheckBoxRequiresNounChange(Sender: TObject);
begin
  EditNoun.Enabled:= CheckBoxRequiresNoun.Checked;
end;

procedure TfPuzzleWizard.CheckBoxRequiresPrepositionChange(Sender: TObject);
begin
  EditPrep.Enabled:= CheckBoxRequiresPreposition.Checked;
end;

procedure TfPuzzleWizard.ComboBoxActionSelectChange(Sender: TObject);
var numparams : integer;
begin
  numparams := 0;
  LabelActionP1.Visible:=false;
  LabelActionP2.Visible:=false;
  EditActionP1.Visible:=false;
  EditActionP2.Visible:=false;
  EditActionP1.Text:='';
  EditActionP2.Text:='';


  case ComboBoxActionSelect.ItemIndex of
  1,2: begin // CREATE, DESTROY
      numparams := 1;
      LabelActionP1.Caption := S_OBJECT;
      EditActionP1.Hint:= S_OBJECT_HINT;
     end;
  3 : begin // PLACE
         numparams := 2;
         LabelActionP1.Caption := S_OBJECT;
         EditActionP1.Hint:= S_OBJECT_HINT;
         LabelActionP2.Caption := S_LOCATION;
         EditActionP2.Hint:= S_LOCATIONS_HINT;
       end;
  4,5,6: begin   // PLUS, MINUS, LET
         numparams := 2;
         LabelActionP1.Caption := S_FLAG;
         EditActionP1.Hint:= S_FLAG_HINT;
         LabelActionP2.Caption := S_VALUE;
         EditActionP2.Hint:= S_VALUE_HINT;
        end;
  7: begin  // CLEAREXIT
         numparams := 1;
         LabelActionP1.Caption:= S_DIRECTION;
         EditActionP1.Hint := S_DIRECTION_HINT;
     end;
  8: begin // SETEXIT
         numparams := 2;
         LabelActionP1.Caption:= S_DIRECTION;
         EditActionP1.Hint := S_DIRECTION_HINT;
         LabelActionP2.Caption:= S_LOCATION;
         EditActionP2.Hint := S_LOCATIONS_HINT;
     end;


  end;
  if (numparams>0) then
  begin
    LabelActionP1.Visible:=true;
    EditActionP1.Visible:=true;
  end;
  if (numparams>1) then
  begin
    LabelActionP2.Visible:=true;
    EditActionP2.Visible:=true;
  end;


end;

procedure TfPuzzleWizard.ComboBoxConditionSelectChange(Sender: TObject);
var numparams : integer;
begin
  numparams := 0;
  LabelCondP1.Visible:=false;
  LabelCondP2.Visible:=false;
  EditConditionP1.Visible:=false;
  EditConditionP2.Visible:=false;
  EditConditionP1.Text:='';
  EditConditionP2.Text:='';
  LabelCondTOF.Visible:=false;
  EditConditionTOF.Visible:=false;
  EditConditionTOF.Text:='';

  case ComboBoxConditionSelect.ItemIndex of
  1,2,3,4,5: begin // CARRIED, WORN, NOTCARR; PRESENT, ABSENT
      numparams := 1;
      LabelCondP1.Caption := S_OBJECT;
      EditConditionP1.Hint:= S_OBJECT_HINT;
     end;
  6,7 : begin // ISAT, ISNOTAT
         numparams := 2;
         LabelCondP1.Caption := S_OBJECT;
         EditConditionP1.Hint:= S_OBJECT_HINT;
         LabelCondP2.Caption := S_LOCATION;
         EditConditionP2.Hint:= S_LOCATIONS_HINT;
       end;
  8,9,10,11: begin             //EQ, NOTEQ, LT, GT
         numparams := 2;
         LabelCondP1.Caption := S_FLAG;
         EditConditionP1.Hint:= S_FLAG_HINT;
         LabelCondP2.Caption := S_VALUE;
         EditConditionP2.Hint:= S_VALUE_HINT;
        end;
  end;
  if (numparams>0) then
  begin
    LabelCondP1.Visible:=true;
    EditConditionP1.Visible:=true;
    LabelCondTOF.Visible:=true;
    EditConditionTOF.Visible:=true;
  end;
  if (numparams>1) then
  begin
    LabelCondP2.Visible:=true;
    EditConditionP2.Visible:=true;
  end;


end;


procedure TfPuzzleWizard.EditActionKeyPress(Sender: TObject; var Key: char);
begin
  if  Key = #13 then ButtonAddAction.Click();
end;


procedure TfPuzzleWizard.EditConditionKeyPress(Sender: TObject; var Key: char
  );
begin
  if  Key = #13 then ButtonAddCondition.Click();
end;

procedure TfPuzzleWizard.FormShow(Sender: TObject);
begin
  PageControlWizard.ActivePageIndex:=0;
  ButtonNext.ModalResult:= mrNone;
  ButtonNext.Caption := S_NEXT_MESSAGE;
  EditVerb.SetFocus();
end;

procedure TfPuzzleWizard.PMDeleteLineClick(Sender: TObject);
var ListBox: TListBox;
begin
  if (PageControlWizard.ActivePage = TabSheetActions) then ListBox:= ListBoxActions else ListBox := ListBoxConditions;
  if (ListBox.ItemIndex <>-1) then  ListBox.Items.Delete(ListBox.ItemIndex);

end;

procedure TfPuzzleWizard.PMMoveDownClick(Sender: TObject);
var ListBox: TListBox;
    Index : integer;
begin
     if (PageControlWizard.ActivePage = TabSheetActions) then ListBox:= ListBoxActions else ListBox := ListBoxConditions;
     Index := Listbox.ItemIndex;
     if (Index < Listbox.Count - 2 ) then
     begin
      ListBox.Items.Move(Index, Index + 1);
      ListBox.Selected[Index + 1] := true;
     end;
end;

procedure TfPuzzleWizard.PMMoveUpClick(Sender: TObject);
  var ListBox: TListBox;
      Index : integer;
begin
  if (PageControlWizard.ActivePage = TabSheetActions) then ListBox:= ListBoxActions else ListBox := ListBoxConditions;
  Index := Listbox.ItemIndex;
  if (Index > 0) then
  begin
   ListBox.Items.Move(Index, Index - 1);
   ListBox.Selected[Index-1] := true;
  end;
end;

function TfPuzzleWizard.SetupPuzzle(Token: String):boolean;
begin
  Result := XMLToPuzzle(HexToStr(Token));
end;

procedure TfPuzzleWizard.ClearPuzzle();
begin
  EditVerb.Text := '';
  EditNoun.Text := '';
  EditNoun2.Text := '';
  EditAdject1.Text := '';
  EditAdject2.Text := '';
  EditPrep.Text := '';
  EditAdverb.Text := '';
  EditTOS.Text := '';
  EditLocation.Text := '';
  EditLocationTOF.Text := '';
  EditActionP1.Text := '';
  EditActionP2.Text := '';
  EditConditionP1.Text := '';
  EditConditionP2.Text := '';
  ListBoxActions.Clear();
  ListBoxConditions.Clear();
  CheckBoxLinkedToLocation.Checked:= false;
  CheckBoxRequiresNoun.Checked:= false;
  CheckBoxRequiresNoun2.Checked:= false;
  CheckBoxRequiresAdject1.Checked:= false;
  CheckBoxRequiresAdject2.Checked:= false;
  CheckBoxRequiresAdverb.Checked:= false;
  CheckBoxRequiresPreposition.Checked:= false;
  CheckBoxIncludeWordsOnFailure.Checked:= false;
  ComboBoxActionSelect.ItemIndex:=0;
  ComboBoxConditionSelect.ItemIndex:=0;
  ComboBoxActionSelectChange(nil);
  ComboBoxConditionSelectChange(nil);

end;

procedure TfPuzzleWizard.GeneratePuzzle();
var Code : TStringList;
    var verb: String;
    noun: String;
    word_extra_conditions : String;
    location_conditions:  String;
    entry : String;
    i : integer;
begin
  // Get the entry verb+noun
  verb := EditVerb.Text;
  if CheckBoxRequiresNoun.Checked then noun := EditNoun.Text else noun := '_';
  entry := verb + ' ' + noun;

  // Get any additional word requierements
  word_extra_conditions:='';
  if CheckBoxRequiresAdverb.Checked then word_extra_conditions:= word_extra_conditions + ' ADVERB ' + EditAdverb.Text + LF;
  if CheckBoxRequiresPreposition.Checked then word_extra_conditions:= word_extra_conditions + ' PREP ' + EditPrep.Text + LF;
  if CheckBoxRequiresAdject1.Checked then word_extra_conditions:= word_extra_conditions + ' ADJECT1 ' + EditAdject1.Text + LF;
  if CheckBoxRequiresNoun2.Checked then word_extra_conditions:= word_extra_conditions + ' NOUN2 ' + EditNoun2.Text + LF;
  if CheckBoxRequiresAdject2.Checked then word_extra_conditions:= word_extra_conditions + ' ADJECT2 ' + EditAdject2.Text + LF;
  if (word_extra_conditions<>'') and (RightStr(word_extra_conditions, 1)=#10) then word_extra_conditions:= Copy(word_extra_conditions, 1, length(word_extra_conditions) -2);

  // Get location condition
  location_conditions:= '';
  if (CheckBoxLinkedToLocation.Checked) then location_conditions:= ' AT ' + EditLocation.Text;

  Code:= TStringList.Create();
  Code.Add(S_PUZZLE_HR);
  Code.Add(S_PUZZLE_TITLE);
  Code.Add( StringReplace(S_PUZZLE_TOKEN,'XXXX', PuzzleToHEX(),[]));
  Code.Add(S_PUZZLE_HR);
  Code.Add(';');

  // Create the failure entries
  for i := 0 to ListBoxConditions.Count-1 do
   begin
     Code.Add(entry);
     if (CheckBoxIncludeWordsOnFailure.Checked) then Code.Add(word_extra_conditions);
     if (CheckBoxLinkedToLocation.Checked) then Code.Add(location_conditions);
     Code.Add(' ' + GetOppositeCondact(ListBoxConditions.Items[i]));
     Code.Add(' WRITELN "' + GetTOF(ListBoxConditions.Items[i] +'"'));
     Code.Add(' DONE');
     Code.Add(';');
   end;

  // Create the wronf location failure entry
  if (CheckBoxLinkedToLocation.Checked) then
  begin
    Code.Add(Entry);
    Code.Add(' NOTAT ' + EditLocation.Text);
    Code.Add(' WRITELN "'+EditLocationTOF.Text+'"');
    Code.Add(' DONE');
    Code.Add(';');
  end;


 // Create the success entry
  Code.Add(Entry);
  if (CheckBoxIncludeWordsOnFailure.Checked) then Code.Add(word_extra_conditions);
  if (CheckBoxLinkedToLocation.Checked) then Code.Add(location_conditions);
  for i := 0 to ListBoxConditions.Count - 1 do
    Code.Add(' ' + getCondact(ListBoxConditions.Items[i]));
  for i := 0 to ListBoxActions.Count - 1 do
    Code.Add(' ' + ListBoxActions.Items[i]);
  Code.Add(' WRITELN "'+EditTOS.Text+'"');
  Code.Add(' DONE');
  Code.Add(';');

  Code.Add(S_PUZZLE_HR);
  Code.Add(S_PUZZLE_BOTTOM);
  Code.Add(S_PUZZLE_BOTTOM_MARK);
  Code.Add(S_PUZZLE_HR);
  Code.Add(';');

  // Clear empty lines
  for i:= Code.Count - 1 downto 1 do
     if trim(Code.Strings[i]) = '' then Code.Delete(i);
  // And replace lines marked with just ';' with empty line
  for i:= Code.Count - 1 downto 1 do
      if Code.Strings[i] = ';' then Code.Strings[i]:='';

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
var XML :String;
begin
  XML := '<XML>';
  XML :=  XML + '<C><![CDATA['+ListBoxConditions.Items.Text+']]></C>';
  XML :=  XML + '<A><![CDATA['+ListBoxActions.Items.Text+']]></A>';
  XML :=  XML + '<TOS><![CDATA['+EditTOS.Text+']]></TOS>';
  XML :=  XML + '<V><![CDATA['+EditVerb.Text+']]></V>';
  XML :=  XML + '<N><![CDATA['+EditNoun.Text+']]></N>';
  XML :=  XML + '<N2><![CDATA['+EditNoun2.Text+']]></N2>';
  XML :=  XML + '<ADJ><![CDATA['+EditAdject1.Text+']]></ADJ>';
  XML :=  XML + '<ADJ2><![CDATA['+EditAdject2.Text+']]></ADJ2>';
  XML :=  XML + '<ADV><![CDATA['+EditAdverb.Text+']]></ADV>';
  XML :=  XML + '<P><![CDATA['+EditPrep.Text+']]></P>';
  XML := XML + '<CN>'+ IntToStr(integer(CheckBoxRequiresNoun.Checked))+'</CN>';
  XML := XML + '<CN2>'+ IntToStr(integer(CheckBoxRequiresNoun2.Checked))+'</CN2>';
  XML := XML + '<CADJ>'+ IntToStr(integer(CheckBoxRequiresAdject1.Checked))+'</CADJ>';
  XML := XML + '<CADJ2>'+ IntToStr(integer(CheckBoxRequiresAdject2.Checked))+'</CADJ2>';
  XML := XML + '<CP>'+ IntToStr(integer(CheckBoxRequiresPreposition.Checked))+'</CP>';
  XML := XML + '<CADV>'+ IntToStr(integer(CheckBoxRequiresAdverb.Checked))+'</CADV>';
  XML := XML + '<CL>'+ IntToStr(integer(CheckBoxLinkedToLocation.Checked))+'</CL>';
  XML := XML + '<CIW>'+ IntToStr(integer(CheckBoxIncludeWordsOnFailure.Checked))+'</CIW>';
  XML :=  XML + '<L><![CDATA['+EditLocation.Text+']]></L>';
  XML :=  XML + '<LTOF><![CDATA['+EditLocationTOF.Text+']]></LTOF>';
  XML := XML + '</XML>';
  Result := XML;
end;

function TfPuzzleWizard.XMLToPuzzle(XML: String):Boolean;
var DOC : TXMLDocument;
    Stream: TStringStream;
    Node: TDOMNode;
begin
  ClearPuzzle();
  Stream:= TStringStream.Create(XML);
  try try
    Stream.Position:=0;
    Doc := nil;
    ReadXMLFile(DOC, Stream);
  finally
    Stream.Free();
  end;
  except
    Result:= false; Exit();
  end;

  Node :=  Doc.DocumentElement.FindNode('V');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditVerb.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('N');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditNoun.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('N2');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditNoun2.Text:= Node.TextContent;


  Node :=  Doc.DocumentElement.FindNode('ADJ');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditAdject1.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('ADJ2');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditAdject2.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('ADV');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditAdverb.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('P');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditPrep.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('L');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditLocation.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('LTOF');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditLocationTOF.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('TOS');
  if (Node = nil) then begin Result:= false; Exit(); end;
  EditTOS.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('C');
  if (Node = nil) then begin Result:= false; Exit(); end;
  ListBoxConditions.Items.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('A');
  if (Node = nil) then begin Result:= false; Exit(); end;
  ListBoxActions.Items.Text:= Node.TextContent;

  Node :=  Doc.DocumentElement.FindNode('CIW');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxIncludeWordsOnFailure.Checked:= boolean(StrToInt(Node.TextContent));

  Node :=  Doc.DocumentElement.FindNode('CN');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxRequiresNoun.Checked:= boolean(StrToInt(Node.TextContent));
  EditNoun.Enabled:=CheckBoxRequiresNoun.Checked;

  Node :=  Doc.DocumentElement.FindNode('CN2');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxRequiresNoun2.Checked:= boolean(StrToInt(Node.TextContent));
  EditNoun2.Enabled:=CheckBoxRequiresNoun2.Checked;

  Node :=  Doc.DocumentElement.FindNode('CADJ');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxRequiresAdject1.Checked:= boolean(StrToInt(Node.TextContent));
  EditAdject1.Enabled:=CheckBoxRequiresAdject1.Checked;

  Node :=  Doc.DocumentElement.FindNode('CADJ2');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxRequiresAdject2.Checked:= boolean(StrToInt(Node.TextContent));
  EditAdject2.Enabled:=CheckBoxRequiresAdject2.Checked;

  Node :=  Doc.DocumentElement.FindNode('CP');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxRequiresPreposition.Checked:= boolean(StrToInt(Node.TextContent));
  EditPrep.Enabled:=CheckBoxRequiresPreposition.Checked;

  Node :=  Doc.DocumentElement.FindNode('CADV');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxRequiresAdverb.Checked:= boolean(StrToInt(Node.TextContent));
  EditAdverb.Enabled:=CheckBoxRequiresAdverb.Checked;

  Node :=  Doc.DocumentElement.FindNode('CL');
  if (Node = nil) then begin Result:= false; Exit(); end;
  CheckBoxLinkedToLocation.Checked:= boolean(StrToInt(Node.TextContent));
  EditLocation.Enabled:=CheckBoxRequiresNoun.Checked;
  EditLocationTOF.Enabled:=CheckBoxLinkedToLocation.Checked;

  Result := true;
end;


function TfPuzzleWizard.checkValidData(): boolean;
var ErrorStr : String;
begin
  ErrorStr := '';
  if (EditVerb.Text = '') then ErrorStr :=  ErrorStr + S_VERB_MISSING + #13;
  if (CheckBoxRequiresNoun.Checked) and (EditNoun.Text = '') then ErrorStr :=  ErrorStr + S_NOUN_MISSING + #13;
  if (CheckBoxRequiresPreposition.Checked) and (EditPrep.Text = '') then ErrorStr :=  ErrorStr + S_PREP_MISSING + #13;
  if (CheckBoxRequiresAdverb.Checked) and (EditAdverb.Text = '') then ErrorStr :=  ErrorStr + S_ADVERB_MISSING + #13;
  if (CheckBoxRequiresNoun2.Checked) and (EditNoun2.Text = '') then ErrorStr :=  ErrorStr + S_NOUN2_MISSING + #13;
  if (CheckBoxRequiresAdject1.Checked) and (EditAdject1.Text = '') then ErrorStr :=  ErrorStr + S_ADJECT1_MISSING + #13;
  if (CheckBoxRequiresAdject2.Checked) and (EditAdject2.Text = '') then ErrorStr :=  ErrorStr + S_ADJECT2_MISSING + #13;
  if (CheckBoxLinkedToLocation.Checked) and (EditLocation.Text = '') then ErrorStr :=  ErrorStr + S_LOCATION_MISSING + #13;
  if (CheckBoxLinkedToLocation.Checked) and (EditLocationTOF.Text = '') then ErrorStr :=  ErrorStr + S_LOCATION_TOF_MISSING + #13;
  if (EditTOS.Text = '') then ErrorStr :=  ErrorStr + S_TOS_MISSING + #13;
  if (ErrorStr <> '') then
  begin
   ShowMessage(ErrorStr);
   Result := false;
  end else Result := true;
end;


function TfPuzzleWizard.getCondact(S: String): string;
begin
 Result := Copy(S, 1, Pos('|',S)-1);
end;

function TfPuzzleWizard.getOppositeCondact(S: String): string;
var Condact, Params: string;
begin
  S := Copy(S, 1, Pos('|', S)-1);
  Condact := Copy(S, 1, Pos(' ',S)-1);
  Params := Copy(S, Pos(' ', S)+1, 255);
  if (Condact = 'CARRIED') then Condact := 'NOTCARR' else
  if (Condact = 'WORN') then Condact := 'NOTWORN' else
  if (Condact = 'NOTCARR') then Condact := 'CARRIED' else
  if (Condact = 'PRESENT') then Condact := 'ABSENT' else
  if (Condact = 'ABSENT') then Condact := 'PRESENT' else
  if (Condact = 'ISAT') then Condact := 'ISNOTAT' else
  if (Condact = 'ISNOTAT') then Condact := 'ISAT' else
  if (Condact = 'EQ') then Condact := 'NOTEQ' else
  if (Condact = 'NOTEQ') then Condact := 'EQ' else
  if (Condact = 'LT') then Condact := 'GE' else
  if (Condact = 'GT') then Condact := 'LE' else raise Exception.Create(S_UNEXPECTED_CONDITION);

  Result := Condact + ' ' + Params;

end;

function TfPuzzleWizard.getTOF(S:String):String;
begin
  Result := Copy(S, Pos('|',S)+1,10000);
end;

end.

