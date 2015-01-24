unit UMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterAny, SynEdit,
  ExtendedNotebook, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, UConfig, UTXP, types;

type

  { TfMain }

  TfMain = class(TForm)
    BOptions: TSpeedButton;
    BRun: TSpeedButton;
    BCopy: TSpeedButton;
    BReplace: TSpeedButton;
    BPaste: TSpeedButton;
    BCut: TSpeedButton;
    BFind: TSpeedButton;
    BCompile: TSpeedButton;
    BHelp: TSpeedButton;
    BUndo: TSpeedButton;
    BSave: TSpeedButton;
    BRedo: TSpeedButton;
    MainMenu: TMainMenu;
    MEdit: TMenuItem;
    MCompile: TMenuItem;
    MCompileRun: TMenuItem;
    MPuzzleWizard: TMenuItem;
    MAbout: TMenuItem;
    MData: TMenuItem;
    MConnections: TMenuItem;
    MDefinitions: TMenuItem;
    MOpenAllSections: TMenuItem;
    PMCondactHelp: TMenuItem;
    PMPaste: TMenuItem;
    PMCut: TMenuItem;
    PMCopy: TMenuItem;
    PMSeparartor2: TMenuItem;
    PMSmallerFont: TMenuItem;
    PMLargerFont: TMenuItem;
    PMSeparator1: TMenuItem;
    PMInterruptToggle: TMenuItem;
    MMessages: TMenuItem;
    mSystemMessages: TMenuItem;
    MProcesses: TMenuItem;
    MObjectData: TMenuItem;
    MObjectTexts: TMenuItem;
    MLocations: TMenuItem;
    MVocabulary: TMenuItem;
    MSave: TMenuItem;
    MClose: TMenuItem;
    MCopy: TMenuItem;
    MCut: TMenuItem;
    MFindNext: TMenuItem;
    MReplace: TMenuItem;
    MFind: TMenuItem;
    MRedo: TMenuItem;
    MUndo: TMenuItem;
    MPaste: TMenuItem;
    MQuit: TMenuItem;
    MRecentFiles: TMenuItem;
    MNewProcess: TMenuItem;
    MOpenFile: TMenuItem;
    MNew: TMenuItem;
    MHelpContents: TMenuItem;
    MOptions: TMenuItem;
    MTools: TMenuItem;
    MHelp: TMenuItem;
    MProject: TMenuItem;
    MFile: TMenuItem;
    OpenDialog: TOpenDialog;
    PageControl: TPageControl;
    BNew: TSpeedButton;
    MainPopupMenu: TPopupMenu;
    Toolbar: TPanel;
    PanelBackground: TPanel;
    DataHighlighter: TSynAnySyn;
    CodeHighlighter: TSynAnySyn;
    SaveDialog: TSaveDialog;
    BOpen: TSpeedButton;
    VocHighlighter: TSynAnySyn;
    procedure BCompileClick(Sender: TObject);
    procedure BCopyClick(Sender: TObject);
    procedure BCutClick(Sender: TObject);
    procedure BFindClick(Sender: TObject);
    procedure BHelpClick(Sender: TObject);
    procedure BNewClick(Sender: TObject);
    procedure BOpenClick(Sender: TObject);
    procedure BOptionsClick(Sender: TObject);
    procedure BPasteClick(Sender: TObject);
    procedure BRedoClick(Sender: TObject);
    procedure BReplaceClick(Sender: TObject);
    procedure BRunClick(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure BUndoClick(Sender: TObject);
    procedure ControlBarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MainPopupMenuPopup(Sender: TObject);
    procedure MCloseClick(Sender: TObject);
    procedure MConnectionsClick(Sender: TObject);
    procedure MCopyClick(Sender: TObject);
    procedure MCutClick(Sender: TObject);
    procedure MDataClick(Sender: TObject);
    procedure MDefinitionsClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MHelpContentsClick(Sender: TObject);
    procedure MLocationsClick(Sender: TObject);
    procedure MMessagesClick(Sender: TObject);
    procedure MNewClick(Sender: TObject);
    procedure MObjectDataClick(Sender: TObject);
    procedure MObjectTextsClick(Sender: TObject);
    procedure MOpenAllSectionsClick(Sender: TObject);
    procedure MOpenFileClick(Sender: TObject);
    procedure MOptionsClick(Sender: TObject);
    procedure MPasteClick(Sender: TObject);
    procedure MQuitClick(Sender: TObject);
    procedure MRedoClick(Sender: TObject);
    procedure MSaveClick(Sender: TObject);
    procedure mSystemMessagesClick(Sender: TObject);
    procedure MToolsClick(Sender: TObject);
    procedure MUndoClick(Sender: TObject);
    procedure MVocabularyClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PanelBackgroundClick(Sender: TObject);
    procedure MProcessItemClick(Sender: TObject);
    procedure PMCondactHelpClick(Sender: TObject);
    procedure PMCopyClick(Sender: TObject);
    procedure PMCutClick(Sender: TObject);
    procedure PMInterruptToggleClick(Sender: TObject);
    procedure PMPasteClick(Sender: TObject);
    function ShowNotSaveWarning():boolean;
    procedure OpenBrowser(URL: String);



  private
    procedure HelpResponse(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BuildProcessMenu(TXP: TTXP);
    procedure SetEditMode(mode : boolean);
    procedure OpenTab(Section: String; Content: TStringList);
    procedure SynEditKeyPress(Sender: TObject; var Key: Char);
    procedure CloseFile();
    procedure Terminate();
    procedure SaveFile();

    { private declarations }
  public
    Config: TConfig;
    CodeModified : boolean;
    TXP : TTXP;
  end;

var
  fMain: TfMain;

implementation

uses uoptions, UGlobals,lclintf;

{$R *.lfm}

{ TfMain }

procedure TfMain.PanelBackgroundClick(Sender: TObject);
begin

end;

function TfMain.ShowNotSaveWarning: boolean;
begin
  if CodeModified then Result := (MessageDlg(S_QUIT_NOT_SAVED,mtConfirmation,[mbYes,mbNo],0)=mrYes)
  else Result := true;
end;



procedure TfMain.ControlBarClick(Sender: TObject);
begin

end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Config := TConfig.Create();
  Config.LoadConfig();
  if FileExists('CodeHighLight.ini') then CodeHighlighter.LoadHighLighter('CodeHighLight.ini');
  if FileExists('DataHighLight.ini') then DataHighlighter.LoadHighLighter('DataHighLight.ini');
  if FileExists('VocHighLight.ini') then VOCHighlighter.LoadHighLighter('VocHighLight.ini');

end;

procedure TfMain.MainPopupMenuPopup(Sender: TObject);
var Section: String;
    ProcNum : integer;
    MarkAsInterruptVisible: Boolean;
    CondactHelpVisible : Boolean;
begin
  MarkAsInterruptVisible:= true;
  CondactHelpVisible := true;
  Section := TSynEdit(PageControl.ActivePage.Controls[0]).Hint;
  if Copy(Section, 1, 3) <> 'PRO' then MarkAsInterruptVisible:=false
  else
  begin
   ProcNum := TSynEdit(PageControl.ActivePage.Controls[0]).Tag;
   if ProcNum < 3 then MarkAsInterruptVisible:=false;
  end;

  if (Section<>'RESP') and (Copy(Section,1,3)<>'PRO') then CondactHelpVisible:=false;
  PMInterruptToggle.Visible := MarkAsInterruptVisible;
  PMInterruptToggle.Checked := (MarkAsInterruptVisible) and (ProcNum=TXp.InterruptProcessNum);
  PMCondactHelp.Visible := CondactHelpVisible;

end;

procedure TfMain.MCloseClick(Sender: TObject);
begin
  if (CodeModified and (MessageDlg(S_QUIT_NOT_SAVED,mtConfirmation,[mbYes,mbNo],0)=mrYes))
  or (not CodeModified) then CloseFile();
end;

procedure TfMain.CloseFile();
var i : integer;
begin

 for i := PageControl.PageCount - 1 downto 0 do
 begin
   (PageControl.Pages[i].Controls[0] as TSynEdit).Text := '';
   (PageControl.Pages[i].Controls[0] as TSynEdit).Free();
   PageControl.Pages[i].Free();
 end;
 PageControl.Visible:= false;
 for i := MProcesses.Count -1  downto 0 do MProcesses.Items[i].Free();
 if Assigned(TXP) then TXP.Free();
 SetEditMode(false);
 PanelBackground.Caption := S_COPYRIGHT;
 fMain.Caption:= 'ngPAWS';
end;

procedure TfMain.MConnectionsClick(Sender: TObject);
begin
  OpenTab('CON',TXP.Connections);
end;

procedure TfMain.MCopyClick(Sender: TObject);
begin
  if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).CopyToClipboard();
end;

procedure TfMain.MCutClick(Sender: TObject);
begin
    if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).CutToClipboard();

end;

procedure TfMain.MDataClick(Sender: TObject);
begin

end;

procedure TfMain.MDefinitionsClick(Sender: TObject);
begin
  OpenTab('DEF',TXP.Definitions);
end;

procedure TfMain.Memo1Change(Sender: TObject);
begin

end;

procedure TfMain.MHelpContentsClick(Sender: TObject);
var URL : String;
begin
  URL := config.HelpBaseURL;
  if config.Lang='ES' then URL:= URL + '/Inicio';
  OpenBrowser(URL);
end;

procedure TfMain.MLocationsClick(Sender: TObject);
begin
  OpenTab('LTX',TXP.LocationTexts);
end;

procedure TfMain.MMessagesClick(Sender: TObject);
begin
    OpenTab('MTX',TXP.UsrMess);
end;

procedure TfMain.BOpenClick(Sender: TObject);
begin
  MOpenFile.click();
end;

procedure TfMain.BOptionsClick(Sender: TObject);
begin
  MOptions.Click();
end;

procedure TfMain.BPasteClick(Sender: TObject);
begin
  MPaste.Click();
end;

procedure TfMain.BRedoClick(Sender: TObject);
begin
  MRedo.Click();
end;

procedure TfMain.BReplaceClick(Sender: TObject);
begin
  MReplace.Click();
end;

procedure TfMain.BRunClick(Sender: TObject);
begin
  MCompileRun.Click();
end;

procedure TfMain.BSaveClick(Sender: TObject);
begin
  MSave.Click();
end;

procedure TfMain.BUndoClick(Sender: TObject);
begin
  MUndo.Click();
end;

procedure TfMain.BNewClick(Sender: TObject);
var TabSheet : TTabSheet;
begin
  MNew.click();
end;

procedure TfMain.BCutClick(Sender: TObject);
begin
  MCut.Click();
end;

procedure TfMain.BFindClick(Sender: TObject);
begin
  MFind.Click();
end;

procedure TfMain.BHelpClick(Sender: TObject);
begin
  MHelpContents.Click();
end;

procedure TfMain.BCopyClick(Sender: TObject);
begin
  MCopy.Click();
end;

procedure TfMain.BCompileClick(Sender: TObject);
begin
  MCompile.Click();
end;

procedure TfMain.MNewClick(Sender: TObject);
begin

end;

procedure TfMain.MObjectDataClick(Sender: TObject);
begin
    OpenTab('OBJ',TXP.ObjectData);
end;

procedure TfMain.MObjectTextsClick(Sender: TObject);
begin
    OpenTab('OTX',TXP.ObjectTexts);
end;

procedure TfMain.MOpenAllSectionsClick(Sender: TObject);
var i : integer;
begin
  for i:= 0 to MData.Count - 1 do  MData.Items[i].Click();
  for i:= 0 to MProcesses.Count - 1 do  MProcesses.Items[i].Click();
end;

procedure TfMain.BuildProcessMenu(TXP: TTXP);
var Item : TMenuItem;
    i : integer;
begin
  for i:= 0 to TXP.LastProcess do
  if  Assigned(TXP.Processes[i])  then
    begin
      Item := TMenuItem.Create(self);
      if (i=0) then Item.Caption := S_MENUITEM_RESPONSE else Item.Caption := S_MENUITEM_PROCESS + intToStr(i);
      Item.Name := 'MProcess'  + IntToStr(i);
      Item.Tag := i;
      Item.OnClick := @MProcessItemClick;
      if (i<9) then Item.ShortCut := $8000 + 48 +i;
      if (i=0) then Item.ShortCut := $8000 + byte('R');
      MProcesses.Add(Item);
    end;


end;

procedure TfMain.SetEditMode(mode : boolean);
begin
   if mode then BuildProcessMenu(TXP);
   BOpen.Visible:=not mode;
   BNew.Visible := not mode;
   MOpenFile.Enabled := not mode;
   MNew.Enabled := not mode;
   MRecentFiles.Enabled:= not mode;

   BSave.Visible := mode;
   BCopy.Visible := mode;
   BCut.Visible := mode;
   BPaste.Visible := mode;
   BUndo.Visible := mode;
   BRedo.Visible := mode;
   BCompile.Visible := mode;
   BRun.Visible := mode;
   BFind.Visible := mode;
   BReplace.Visible := mode;
   MClose.Enabled:= mode;
   MProcesses.Enabled := mode;
   MData.Enabled := mode;
   MSave.Enabled := mode;
   MClose.Enabled := mode;
   MPuzzleWizard.Enabled := mode;
   MEdit.Enabled := mode;
   MProject.Enabled := mode;
end;

procedure TfMain.MOpenFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    TXP := TTXP.Create();
    TXP.LoadTXP(OpenDialog.FileName);
    fMain.Caption:= 'ngPAWS - ' + ExtractFileName(OpenDialog.FileName);
    SetEditMode(true);
    if  Config.OpenAllTabs then MOpenAllSections.Click() else
     begin
       PanelBackground.Caption := S_FILE_LOADED_WARNING;
       PanelBackground.Font.Color:= clWhite;
     end;
  end;
end;

procedure TfMain.MProcessItemClick(Sender: TObject);
begin
  OpenTab('PRO ' + IntToStr(TMenuItem(Sender).Tag), TXP.Processes[TMenuItem(Sender).Tag]);
end;

procedure TfMain.PMCondactHelpClick(Sender: TObject);
var Key : Word;
begin
  Key := VK_F1;
  HelpResponse(PageControl.ActivePage.Controls[0],Key,[]);
end;

procedure TfMain.PMCopyClick(Sender: TObject);
begin
  MCopy.Click();
end;

procedure TfMain.PMCutClick(Sender: TObject);
begin
  MCut.Click();
end;

procedure TfMain.PMInterruptToggleClick(Sender: TObject);
var SynEdit: TSynEdit;
begin
   SynEdit := TSynEdit(PageControl.ActivePage.Controls[0]);
   if (Copy(SynEdit.Hint, 1,3) = 'PRO')  and (SynEdit.Tag >= 3) then
   begin
        if (TXP.InterruptProcessNum = SynEdit.Tag) then TXP.InterruptProcessNum:=-1
        else
        if (TXP.InterruptProcessNum= -1) or (MessageDlg(S_REPLACE_INTERRUPT_PROCESS,mtConfirmation,[mbYes,mbNo],0)=mrYes)
           then TXP.InterruptProcessNum := SynEdit.Tag;
   end;

end;

procedure TfMain.PMPasteClick(Sender: TObject);
begin
  MPaste.Click();
end;


procedure TfMain.MOptionsClick(Sender: TObject);
begin
  if fOptions.ShowModal = mrOK then
  begin
    fOptions.SaveToConfig(Config);
    Config.SaveConfig();
  end;
end;

procedure TfMain.MPasteClick(Sender: TObject);
begin
   if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).PasteFromClipboard();

end;

procedure TfMain.Terminate();
begin
   Halt(0);
end;

procedure TfMain.MQuitClick(Sender: TObject);
begin
  if ShowNotSaveWarning() then
  begin
   Terminate();
  end;
end;

procedure TfMain.MRedoClick(Sender: TObject);
begin
    if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).Redo();
end;

procedure TfMain.MSaveClick(Sender: TObject);
begin
  SaveFile();
end;

procedure TfMain.mSystemMessagesClick(Sender: TObject);
begin
    OpenTab('STX',TXP.SysMess);
end;

procedure TfMain.MToolsClick(Sender: TObject);
begin

end;

procedure TfMain.MUndoClick(Sender: TObject);
begin
    if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).Undo();
end;

procedure TfMain.MVocabularyClick(Sender: TObject);
begin
  OpenTab('VOC',TXP.Vocabulary);
end;

procedure TfMain.PageControlChange(Sender: TObject);
begin
  TSynEdit(PageControl.ActivePage.Controls[0]).SetFocus();
end;

procedure TfMain.OpenTab(Section: String; Content: TStringList);
var found : boolean;
    i : integer;
    SynEdit : TSynEdit;
    TabSheet : TTabSheet;

begin
  if not PageControl.Visible then PageControl.Visible:= true;
  if (Section = 'PRO 0') then Section:= 'RESP';
  found := false;
  i := 0;
  while ((not found) and (i< PageControl.PageCount)) do
   begin
    if (TSynEdit(PageControl.Pages[i].Controls[0]).Hint = Section) then
    begin
      PageControl.ActivePage := PageControl.Pages[i];
      Exit;
    end;
    i := i + 1;
   end;
 //Create new tab
 TabSheet := TTabSheet.Create(PageControl);
 TabSheet.PageControl := PageControl;
 TabSheet.Color := $222827;
 TabSheet.BorderWidth:=0;
 TabSheet.Font.Color := clWhite;
 TabSheet.ShowHint:=false;
 TabSheet.Caption:=Section;
 TabSheet.BorderWidth:=0;
 SynEdit := TSynEdit.Create(TabSheet);
 SynEdit.Parent := TabSheet;
 SynEdit.BorderStyle:= bsNone;
 SynEdit.Align:=alClient;
 SynEdit.OnKeyPress := @SynEditKeyPress;
 SynEdit.OnKeyDown := @HelpResponse;
 SynEdit.Color:=$222827;
 SynEdit.Font.Color := clWhite;
 SynEdit.ScrollBars := ssVertical;
 SynEdit.Font.Size := 13;
 SynEdit.PopupMenu := MainPopupMenu;
 SynEdit.ScrollBars := ssBoth;
 SynEdit.Options := SynEdit.Options + [eoSmartTabDelete, eoSmartTabs, eoAutoIndent];
 SynEdit.WantTabs := true;
 SynEdit.ShowHint:= false;
 SynEdit.Hint := Section;    // We use the hint property of SynEdit component to store the block real name
 SynEdit.RightEdge:=1024;
 SynEdit.ScrollBars:= ssAutoBoth;
 SynEdit.Gutter.Visible:=true;

 SynEdit.Gutter.Parts.Part[1].Visible := false;
 SynEdit.Gutter.Parts.Part[4].MarkupInfo.Background:= $222827;

 SynEdit.Gutter.Parts.Part[0].Visible:= false;
 SynEdit.Gutter.Parts.Part[2].Visible:= false;
 SynEdit.Gutter.Parts.Part[3].Visible:= false;
 SynEdit.LineHighlightColor.Background:= $333333;

 if (Copy(Section,1,3) = 'PRO') then SynEdit.Tag := StrToInt(Copy(Section,5,255));     // Por processes we also store the process number in the tag property of SynEdit component

 if (Section = 'VOC') then SynEdit.Highlighter := VocHighlighter else
 if (Section = 'CTL') then begin end else
 if (Copy(Section,1,3) = 'PRO') then SynEdit.Highlighter := CodeHighlighter else
 if (Section = 'RESP') then SynEdit.Highlighter := CodeHighlighter else
 SynEdit.Highlighter := DataHighlighter;

 SynEdit.Text:= Content.Text;
 PageControl.ActivePage := PageControl.Pages[PageControl.PageCount-1];
 SynEdit.SetFocus();
end;


procedure TfMain.SynEditKeyPress(Sender: TObject; var Key: Char);
begin
 CodeModified:=true;
end;

procedure TfMain.HelpResponse(Sender: TObject; var Key: Word;  Shift: TShiftState);
var Selection, SelectedLine, URL : string;
    i : integer;
    CurrentLine: integer;
begin
 if key <> VK_F1 then exit;

 CurrentLine :=(PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).CaretY -1;
 SelectedLine := (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).Lines[CurrentLine];
 if SelectedLine = '' then
 begin
   MHelpContents.Click();
  Exit
 end;

 Selection := '';
 i := (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).CaretX;
 while (i>=1) and (SelectedLine[i]<>' ') do
  begin
   Selection := SelectedLine[i] + Selection;
   I := i - 1;
  end;
 i := (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).CaretX + 1;
 while (i<=Length(SelectedLine)) and (SelectedLine[i]<>' ') do
  begin
   Selection :=   Selection + SelectedLine[i];
   I := i + 1;
  end;

 URL := Config.HelpBaseURL;
 if NOT (Config.HelpBaseURL[Length(Config.HelpBaseURL)] in ['/','\']) then URL := URL + '/';
 URL := URL + AnsiUpperCase(Selection);
 if (Config.Lang='ES') then URL := URL + '_ES';
 OpenBrowser(URL);
end;



procedure TfMain.OpenBrowser(URL: String);
begin
if not OpenURL(URL) then ShowMessage(S_BROWSER_NOT_FOUND);
end;


procedure TfMain.SaveFile();
var ProcNum , i : integer;
    Section: string;

begin
  for i:= 0 to PageControl.PageCount - 1 do
  begin
    Section := TSynEdit(PageControl.Pages[i].Controls[0]).Hint;
    if (Section = 'DEF') then TXP.Definitions.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'CTL') then TXP.Control.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'VOC') then TXP.Vocabulary.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'STX') then TXP.SysMess.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'MTX') then TXP.UsrMess.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'LTX') then TXP.LocationTexts.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'OTX') then TXP.ObjectTexts.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'OBJ') then TXP.ObjectData.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'CON') then TXP.Connections.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'RESP') then TXP.SetProcessCode(0,TSynEdit(PageControl.Pages[i].Controls[0]).Text) else
    if (copy(Section, 1, 3) = 'PRO') then
    begin
     ProcNum :=  TSynEdit(PageControl.Pages[i].Controls[0]).Tag;
     TXP.SetProcessCode(ProcNum, TSynEdit(PageControl.Pages[i].Controls[0]).Lines.Text);
    end;
  end;
  TXP.SaveTXP('');
end;

end.

