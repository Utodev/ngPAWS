unit UMain;

{$mode objfpc}{$H+}

interface

uses
   {$IFDEF Windows}windows,{$endif} Classes, SysUtils, FileUtil, SynHighlighterAny,
   SynEdit, ExtendedNotebook, Forms, Controls, Graphics, Dialogs, Menus,
   ExtCtrls, ComCtrls, StdCtrls, Buttons, UConfig, UTXP, UAbout, SynEditTypes,
   SynCompletion, Clipbrd, LCLTranslator, types, LCLType;

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
    CompileOutputListBox: TListBox;
    MainMenu: TMainMenu;
    MEdit: TMenuItem;
    MCompile: TMenuItem;
    MCompileRun: TMenuItem;
    MCloseCompilerOutput: TMenuItem;
    MCopyAll: TMenuItem;
    PMPuzzleWizard: TMenuItem;
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
    PopupMenuCompilerOutput: TPopupMenu;
    SynCompletion: TSynCompletion;
    Timer: TTimer;
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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MAboutClick(Sender: TObject);
    procedure MainPopupMenuPopup(Sender: TObject);
    procedure MCloseClick(Sender: TObject);
    procedure MCloseCompilerOutputClick(Sender: TObject);
    procedure MCompileClick(Sender: TObject);
    procedure MCompileRunClick(Sender: TObject);
    procedure MConnectionsClick(Sender: TObject);
    procedure MCopyAllClick(Sender: TObject);
    procedure MCopyClick(Sender: TObject);
    procedure MCutClick(Sender: TObject);
    procedure MDataClick(Sender: TObject);
    procedure MDefinitionsClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MFindClick(Sender: TObject);
    procedure MFindNextClick(Sender: TObject);
    procedure MHelpContentsClick(Sender: TObject);
    procedure MLocationsClick(Sender: TObject);
    procedure MMessagesClick(Sender: TObject);
    procedure MNewClick(Sender: TObject);
    procedure MNewProcessClick(Sender: TObject);
    procedure MObjectDataClick(Sender: TObject);
    procedure MObjectTextsClick(Sender: TObject);
    procedure MOpenAllSectionsClick(Sender: TObject);
    procedure MOpenFileClick(Sender: TObject);
    procedure MOptionsClick(Sender: TObject);
    procedure MPasteClick(Sender: TObject);
    procedure MQuitClick(Sender: TObject);
    procedure MRedoClick(Sender: TObject);
    procedure MReplaceClick(Sender: TObject);
    procedure MSaveClick(Sender: TObject);
    procedure mSystemMessagesClick(Sender: TObject);
    procedure MToolsClick(Sender: TObject);
    procedure MUndoClick(Sender: TObject);
    procedure MVocabularyClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PanelBackgroundClick(Sender: TObject);
    procedure MProcessItemClick(Sender: TObject);
    procedure PMCondactHelpClick(Sender: TObject);
    procedure PMCopyClick(Sender: TObject);
    procedure PMCutClick(Sender: TObject);
    procedure PMInterruptToggleClick(Sender: TObject);
    procedure PMLargerFontClick(Sender: TObject);
    procedure PMPasteClick(Sender: TObject);
    procedure PMPuzzleWizardClick(Sender: TObject);
    procedure PMSmallerFontClick(Sender: TObject);
    function ShowNotSaveWarning():boolean;
    procedure OpenBrowser(URL: String);
    procedure MRecentFilesClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);


  private
    procedure DoSearchReplace(SynEdit : TSynEdit; SearchText, ReplaceText: String; Options: TSynSearchOptions);
    procedure OpenFile(Filename: String);
    procedure CheckPaths();
    procedure HelpResponse(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BuildProcessMenu(TXP: TTXP);
    function CreateNewGame(Filename: String):boolean;
    procedure BuildRecentFilesMenu();
    procedure SetEditMode(mode : boolean);
    procedure OpenTab(Section: String; Content: TStringList; SetCursorToLine: integer = -1);
    procedure SynEditKeyPress(Sender: TObject; var Key: Char);
    procedure CloseFile();
    procedure Terminate();
    procedure SaveFile(FileName : String; WithDebugInfo: boolean = false);
    procedure SetEditorsFont();
    function Compile():Boolean;
    procedure DeleteTempFiles(FileName : String);
    function CheckError(ErrorLineCandidate: String;IsPreprocessor:Boolean;DebugFileName:String) : Boolean;
    procedure GotoLine(ErrorLineCandidate:String; IsPreprocessor: Boolean;DebugFileName:String);
    procedure ShowSearchReplaceDialog(IsReplaceDialog: boolean);


    { private declarations }
  public
    Config: TConfig;
    CodeModified : boolean;
    EditMode : boolean;
    TXP : TTXP;
    LastSearchText : String;
    AutoCompleteBaseList: TStringList;

  end;

var
  fMain: TfMain;

implementation

uses uoptions, UGlobals,URunShell, USearchReplace,  lclintf, UPuzzleWizard;

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


procedure TfMain.BuildRecentFilesMenu();
var i:integer;
    MenuItem : TMenuItem;
begin
  MRecentFiles.Clear();

  for i:= 0 to 9 do if Config.GetRecentFile(i)<> '' then
  begin
    MenuItem := TMenuItem.Create(self);
    MenuItem.Caption:=Config.GetRecentFile(i);
    MenuItem.OnClick:=@MRecentFilesClick;
    MRecentFiles.Add(MenuItem);
  end;
  MRecentFiles.Visible :=  (MRecentFiles.Count >0);

end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Config := TConfig.Create();
  Config.LoadConfig();
  if FileExists('CodeHighLight.ini') then CodeHighlighter.LoadHighLighter('CodeHighLight.ini');
  if FileExists('DataHighLight.ini') then DataHighlighter.LoadHighLighter('DataHighLight.ini');
  if FileExists('VocHighLight.ini') then VOCHighlighter.LoadHighLighter('VocHighLight.ini');
  AutoCompleteBaseList := TStringList.Create();
  AutoCompleteBaseList.AddStrings(CodeHighlighter.Objects);
  AutoCompleteBaseList.AddStrings(CodeHighlighter.KeyWords);
  AutoCompleteBaseList.AddStrings(CodeHighlighter.Constants);
  AutoCompleteBaseList.AddStrings(VocHighlighter.Objects);
  BuildRecentFilesMenu();
  CompileOutputListBox.Font.Size:=Config.EditorFontSize;
  LastSearchText:='';
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  Toolbar.Visible:=Config.ShowToolBar;
  if Config.Lang<>'' then SetDefaultLang(Config.Lang);
  CheckPaths();
end;

procedure TfMain.MAboutClick(Sender: TObject);
begin
  fAbout.ShowModal();
end;


procedure TfMain.MRecentFilesClick(Sender: TObject);
begin
  OpenFile(TMenuItem(Sender).Caption);
end;



procedure TfMain.TimerTimer(Sender: TObject);
begin
 {$iFDEF Windows}
 LockWindowUpdate(0);
 Timer.Enabled:=false;
 {$ENDIF}
end;

procedure TfMain.MainPopupMenuPopup(Sender: TObject);
var Section: String;
    ProcNum : integer;
    MarkAsInterruptVisible: Boolean;
    CondactHelpVisible : Boolean;
    PuzzleWizardVisible : Boolean;

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
  PuzzleWizardVisible:= Section='RESP';



  PMInterruptToggle.Visible := MarkAsInterruptVisible;
  PMInterruptToggle.Checked := (MarkAsInterruptVisible) and (ProcNum=TXp.InterruptProcessNum);
  PMCondactHelp.Visible := CondactHelpVisible;
  PMPuzzleWizard.Visible:= PuzzleWizardVisible;
  PMSeparator1.Visible := CondactHelpVisible or MarkAsInterruptVisible or PuzzleWizardVisible;

end;

procedure TfMain.MCloseClick(Sender: TObject);
begin
  if (CodeModified and (MessageDlg(S_QUIT_NOT_SAVED,mtConfirmation,[mbYes,mbNo],0)=mrYes))
  or (not CodeModified) then CloseFile();
end;

procedure TfMain.MCloseCompilerOutputClick(Sender: TObject);
begin
  CompileOutputListBox.Visible:=false;
end;

procedure TfMain.MCompileClick(Sender: TObject);
begin
  Compile();
end;

procedure TfMain.MCompileRunClick(Sender: TObject);
begin
  if (Compile()) then
  begin
   CompileOutputListBox.Visible:=false;
   if (not FileExists(ExtractFilePath(TXP.FilePath) + 'index.html')) then ShowMessage(S_INDEX_NOT_FOUND)
      else OpenBrowser(ExtractFilePath(TXP.FilePath) + 'index.html');
  end;
end;

function TfMain.Compile():Boolean;
var TXPTempFile :String;
    SCETempFile :String;
    Output : TStringList;
    i : integer;
begin
  Result := false;
  try
    if Config.SaveBeforeRun then SaveFile(''); // Save the source code if requested
    TXPTempFile := ChangeFileExt(TXP.FilePath,'.tmp');
    SaveFile(TXPTempFile, true); // Save a temporary copy for compiling with debug info
    CompileOutputListBox.Clear();
    CompileOutputListBox.Visible := true;

    if not FileExists(Config.PreprocessorPath) then
    begin
     ShowMessage(S_PREPROCESSOR_NOT_FOUND);
     Exit();
    end;
    CompileOutputListBox.Items.Add(S_STARTING_PREPROCESSOR);
    // txpaws is run using the TXP file folder as work directory, to be able to add the "dat" folder to search path without having to deal with paths with spaces
    Output := RunShell( Config.PreprocessorPath ,  Config.PreprocessorParameters +  ' -Idat'+ DirectorySeparator +' ' + QuotePath(TXPTempFile) + '', ExtractFilePath(TXPTempFile));
    CompileOutputListBox.Items.Text:=CompileOutputListBox.Items.Text + Output.Text;
    CompileOutputListBox.Selected[CompileOutputListBox.Items.Count-1] := true;
    for i :=0 to CompileOutputListBox.Items.Count-1 do // Errors in preprocessor may appear in any line
      if CheckError(CompileOutputListBox.Items[i], True, ChangeFileExt(TXPTempFile, '.dbg')) then Exit;

    SCETempFile:=ChangeFileExt(TXP.FilePath,'.sce');

    if (not FileExists(SCETempFile)) then Exit;

    if not FileExists(Config.CompilerPath) then
    begin
      ShowMessage(S_COMPILER_NOT_FOUND);
      Exit()
    end;
    CompileOutputListBox.Items.Add(S_STARTING_COMPILER);
    Output := RunShell(Config.CompilerPath,  QuotePath(SCETempFile));
    CompileOutputListBox.Items.Text:=CompileOutputListBox.Items.Text + Output.Text;
    CompileOutputListBox.Selected[CompileOutputListBox.Items.Count-1] := true;
    // Errors in compiler appear in last output line
    if CheckError(CompileOutputListBox.Items[CompileOutputListBox.Items.count-1], False, ChangeFileExt(TXPTempFile, '.dbg')) then Exit;

    CompileOutputListBox.Items.Add(S_COMPILE_OK);
    CompileOutputListBox.Selected[CompileOutputListBox.Items.Count-1] := true;

  finally
    if Config.DeleteTempFiles then DeleteTempFiles(TXP.FilePath);
  end;
  Result := true;
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
  if Editmode then OpenTab('CON',TXP.CON);
end;

procedure TfMain.MCopyAllClick(Sender: TObject);
begin
  Clipboard.AsText:=CompileOutputListBox.Items.Text;

end;

procedure TfMain.MCopyClick(Sender: TObject);
begin
  if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).CopyToClipboard()
     else ShowMessage(S_NO_SECTION_OPEN);
end;

procedure TfMain.MCutClick(Sender: TObject);
begin
    if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).CutToClipboard()
     else ShowMessage(S_NO_SECTION_OPEN);

end;

procedure TfMain.MDataClick(Sender: TObject);
begin

end;

procedure TfMain.MDefinitionsClick(Sender: TObject);
begin
  if Editmode then OpenTab('DEF',TXP.DEF);
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
  if Editmode then OpenTab('LTX',TXP.LTX);
end;

procedure TfMain.MMessagesClick(Sender: TObject);
begin
  if Editmode then OpenTab('MTX',TXP.MTX);
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
  SaveDialog.FileName:=S_DEFAULT_FILENAME;

  if (SaveDialog.Execute) then if (CreateNewGame(SaveDialog.FileName)) then OpenFile(SaveDialog.FileName);
end;

procedure TfMain.MNewProcessClick(Sender: TObject);
begin
  if TXP.AddProcess() then
  begin
    BuildProcessMenu(TXP);
    OpenTab('PRO ' + IntToStr(TXP.LastProcess), TXP.Processes[TXP.LastProcess])
  end else ShowMessage(S_TOO_MANY_PROCESS);
end;

procedure TfMain.MObjectDataClick(Sender: TObject);
begin
    if Editmode then OpenTab('OBJ',TXP.OBJ);
end;

procedure TfMain.MObjectTextsClick(Sender: TObject);
begin
    if Editmode then OpenTab('OTX',TXP.OTX);
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
  MProcesses.Clear();
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
   EditMode:=mode;

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
   MEdit.Enabled := mode;
   MProject.Enabled := mode;
end;

procedure TfMain.OpenFile(Filename: String);
begin
  TXP := TTXP.Create();
  if (TXP.LoadTXP(Filename)) then
  begin
       fMain.Caption:= 'ngPAWS - ' + ExtractFileName(FileName);
       Config.AddRecentFile(FileName);
       BuildRecentFilesMenu();
       SetEditMode(true);
       if  Config.OpenAllTabs then MOpenAllSections.Click() else
       begin
            PanelBackground.Caption := S_FILE_LOADED_WARNING;
            PanelBackground.Font.Color:= clWhite;
       end;
   end;
end;


procedure TfMain.MOpenFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then OpenFile(OpenDialog.FileName);
end;

procedure TfMain.MProcessItemClick(Sender: TObject);
begin
  if Editmode then OpenTab('PRO ' + IntToStr(TMenuItem(Sender).Tag), TXP.Processes[TMenuItem(Sender).Tag]);
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

procedure TfMain.PMLargerFontClick(Sender: TObject);
begin
  Config.EditorFontSize:=Config.EditorFontSize + 1;
  Config.SaveConfig();
  SetEditorsFont();
end;

procedure TfMain.PMPasteClick(Sender: TObject);
begin
  MPaste.Click();
end;

procedure TfMain.PMPuzzleWizardClick(Sender: TObject);
var Selection, SelectedLine : string;
    i : integer;
    CurrentLine: integer;
    StartLine, EndLine : integer;
    SynEdit : TSynEdit;
begin
 SynEdit :=  (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit);
 CurrentLine :=SynEdit.CaretY -1;
 SelectedLine := SynEdit.Lines[CurrentLine];
 if SelectedLine = '' then
 begin
   fPuzzleWizard.ClearPuzzle();
   if (fPuzzleWizard.ShowModal() = mrOK) then
   begin
     fPuzzleWizard.SynEditCodeGen.SelectAll();
     fPuzzleWizard.SynEditCodeGen.CopyToClipboard();
     SynEdit.PasteFromClipboard();
   end;
  Exit
 end;

 Selection := '';
 i := SynEdit.CaretX;
 while (i>=1) and (SelectedLine[i]<>'[') do
  begin
   Selection := SelectedLine[i] + Selection;
   i := i - 1;
  end;
 i := SynEdit.CaretX + 1;
 while (i<=Length(SelectedLine)) and (SelectedLine[i]<>']') do
  begin
   Selection :=   Selection + SelectedLine[i];
   i := i + 1;
  end;

 // Try to find a puzzle in selection
  if (Length(Selection)>2) then
 begin
   if (fPuzzleWizard.SetupPuzzle(Selection)) then // if Valid Token
   begin
     if (fPuzzleWizard.ShowModal() = mrOK) then
     begin
       // Remove old code
       StartLine :=SynEdit.CaretY - 3;
       if StartLine < 0 then StartLine:=0;
       EndLine := StartLine;
       while (EndLine<SynEdit.Lines.Count) and (SynEdit.Lines[EndLine]<> S_PUZZLE_BOTTOM_MARK) do
         EndLine := EndLine + 1;

       if (SynEdit.Lines[EndLine] =  S_PUZZLE_BOTTOM_MARK) then
       begin
         EndLine := EndLine + 1;
         while EndLine >= SynEdit.Lines.Count do EndLine:= EndLine - 1;
         for i := EndLine downto StartLine do SynEdit.Lines.Delete(i);
         SynEdit.CaretY:= StartLine + 1;
         SynEdit.CaretX:= 0;
         fPuzzleWizard.SynEditCodeGen.SelectAll();
         fPuzzleWizard.SynEditCodeGen.CopyToClipboard();
         SynEdit.PasteFromClipboard();
       end else ShowMessage(S_NO_END_OF_PUZZLE);


     end;
     Exit();
   end;
 end;

// Wrong place selection
ShowMessage(S_WRONG_PUZZLEWIZARD_POSITION);

end;

procedure TfMain.PMSmallerFontClick(Sender: TObject);
begin
  if Config.EditorFontSize > 7 then
  begin
    Config.EditorFontSize:=Config.EditorFontSize - 1;
    Config.SaveConfig();
    SetEditorsFont();
  end;

end;


procedure TfMain.MOptionsClick(Sender: TObject);
begin
  if fOptions.ShowModal = mrOK then
  begin
    fOptions.SaveToConfig(Config);
    Config.SaveConfig();
    Toolbar.Visible:=Config.ShowToolBar;
    if Config.Lang<>'' then SetDefaultLang(Config.Lang);
  end;
end;

procedure TfMain.MPasteClick(Sender: TObject);
begin
   if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).PasteFromClipboard()
     else ShowMessage(S_NO_SECTION_OPEN);

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
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).Redo()
     else ShowMessage(S_NO_SECTION_OPEN);
end;

procedure TfMain.MFindClick(Sender: TObject);
begin
  if PageControl.PageCount > 0 then ShowSearchReplaceDialog(false) else ShowMessage(S_NO_SECTION_OPEN);
end;



procedure TfMain.MReplaceClick(Sender: TObject);
begin
  if PageControl.PageCount > 0 then ShowSearchReplaceDialog(true) else ShowMessage(S_NO_SECTION_OPEN);
end;

procedure TfMain.MSaveClick(Sender: TObject);
begin
  SaveFile('');
  CodeModified:=false;
end;

procedure TfMain.mSystemMessagesClick(Sender: TObject);
begin
  if Editmode then OpenTab('STX',TXP.STX);
end;

procedure TfMain.MToolsClick(Sender: TObject);
begin

end;

procedure TfMain.MUndoClick(Sender: TObject);
begin
    if PageControl.PageCount > 0 then
     (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynEdit).Undo() else ShowMessage(S_NO_SECTION_OPEN);
end;

procedure TfMain.MVocabularyClick(Sender: TObject);
begin
  if Editmode then OpenTab('VOC',TXP.VOC);
end;

procedure TfMain.PageControlChange(Sender: TObject);
begin
  TSynEdit(PageControl.ActivePage.Controls[0]).SetFocus();
end;

procedure TfMain.PageControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  {$IFDEF Windows}
  if AllowChange then
  begin
    if PageControl.PageCount > 0 then
    begin
      LockWindowUpdate(PageControl.Handle);
      Timer.Enabled := True;
    end;
  end;
  {$ENDIF}
end;

procedure TfMain.OpenTab(Section: String; Content: TStringList; SetCursorToLine: integer = -1);
var found : boolean;
    i : integer;
    SynEdit : TSynEdit;
    TabSheet : TTabSheet;

begin
  PageControl.DoubleBuffered:=true;
  if not Assigned(TXP) then Exit();
  if not PageControl.Visible then PageControl.Visible:= true;
  if (Section = 'PRO 0') then Section:= 'RESP';
  found := false;
  i := 0;
  while ((not found) and (i< PageControl.PageCount)) do
   begin
    if (TSynEdit(PageControl.Pages[i].Controls[0]).Hint = Section) then
    begin
      PageControl.ActivePage := PageControl.Pages[i];
      SynCompletion.Editor := TSynEdit(PageControl.ActivePage.Controls[0]);

      if (SetCursorToLine <> -1) then
      begin
            TSynEdit(PageControl.ActivePage.Controls[0]).CaretX := 0;
            TSynEdit(PageControl.ActivePage.Controls[0]).CaretY := SetCursorToLine;
      end;
      Exit;
    end;
    i := i + 1;
   end;
 //Create new tab
 TabSheet := TTabSheet.Create(PageControl);
 TabSheet.DoubleBuffered:=true;
 TabSheet.PageControl := PageControl;
 TabSheet.Color := Config.EditorBackgroundColor;
 TabSheet.Font.Color := clWhite;
 TabSheet.ShowHint:=false;
 TabSheet.Caption:=Section;
 TabSheet.BorderWidth:=0;
 SynEdit := TSynEdit.Create(TabSheet);
 SynEdit.Align:=alClient;
 SynEdit.DoubleBuffered:=true;
 SynEdit.BorderStyle:= bsNone;
 SynEdit.Parent := TabSheet;
 SynEdit.OnKeyPress := @SynEditKeyPress;
 SynEdit.OnKeyDown := @HelpResponse;
 SynEdit.Color:=Config.EditorBackgroundColor;
 SynEdit.Font.Name := Config.EditorFontName;
 SynEdit.Font.Color := clWhite;
 SynEdit.ScrollBars := ssVertical;
 SynEdit.Font.Size := Config.EditorFontSize;
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
 SynEdit.Gutter.Parts.Part[4].MarkupInfo.Background:= Config.EditorBackgroundColor;

 SynEdit.Gutter.Parts.Part[0].Visible:= false;
 SynEdit.Gutter.Parts.Part[2].Visible:= false;
 SynEdit.Gutter.Parts.Part[3].Visible:= false;
 SynEdit.LineHighlightColor.Background:= Config.EditorSelectLineColor;

 SynEdit.Text:= Content.Text;

 SynCompletion.Editor := SynEdit;

  if (Copy(Section,1,3) = 'PRO') then SynEdit.Tag := StrToInt(Copy(Section,5,255));     // Por processes we also store the process number in the tag property of SynEdit component

 if (Section = 'VOC') then
   begin
     SynEdit.Highlighter := VocHighlighter;
   end else
 if ((Copy(Section,1,3) = 'PRO') or (Section = 'RESP')) then
  begin
    SynEdit.Highlighter := CodeHighlighter;
  end else
  if (Section = 'CTL') then begin end else SynEdit.Highlighter := DataHighlighter;




 PageControl.ActivePage := PageControl.Pages[PageControl.PageCount-1];
 if (SetCursorToLine <> -1) then
 begin
       SynEdit.CaretX := 0;
       SynEdit.CaretY := SetCursorToLine;
 end;

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
 if (Config.Lang='es') then URL := URL + '_ES';
 OpenBrowser(URL);
end;



procedure TfMain.OpenBrowser(URL: String);
begin
if not OpenURL(URL) then ShowMessage(S_BROWSER_NOT_FOUND);
end;


procedure TfMain.SaveFile(Filename : String; WithDebugInfo: boolean = false);
var ProcNum , i : integer;
    Section: string;

begin
  for i:= 0 to PageControl.PageCount - 1 do
  begin
    Section := TSynEdit(PageControl.Pages[i].Controls[0]).Hint;
    if (Section = 'DEF') then TXP.DEF.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'CTL') then TXP.CTL.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'VOC') then TXP.VOC.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'STX') then TXP.STX.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'MTX') then TXP.MTX.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'LTX') then TXP.LTX.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'OTX') then TXP.OTX.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'OBJ') then TXP.OBJ.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'CON') then TXP.CON.Text := TSynEdit(PageControl.Pages[i].Controls[0]).Text else
    if (Section = 'RESP') then TXP.SetProcessCode(0,TSynEdit(PageControl.Pages[i].Controls[0]).Text) else
    if (copy(Section, 1, 3) = 'PRO') then
    begin
     ProcNum :=  TSynEdit(PageControl.Pages[i].Controls[0]).Tag;
     TXP.SetProcessCode(ProcNum, TSynEdit(PageControl.Pages[i].Controls[0]).Lines.Text);
    end;
  end;
  TXP.SaveTXP(Filename, WithDebugInfo);
end;

procedure TfMain.SetEditorsFont();
var i : integer;
begin
 for i := 0 to PageControl.PageCount - 1 do
   TSynEdit(PageControl.Pages[i].Controls[0]).Font.Size := Config.EditorFontSize;
 CompileOutputListBox.Font.Size:=Config.EditorFontSize;
end;

procedure TfMain.DeleteTempFiles(FileName : String);
begin
  DeleteFile(ChangeFileExt(FileName,'.tmp'));
  DeleteFile(ChangeFileExt(FileName,'.dbg'));
  DeleteFile(ChangeFileExt(FileName,'.txi'));
  DeleteFile(ChangeFileExt(FileName,'.txi.log'));
  DeleteFile(ChangeFileExt(FileName,'.blc'));
  DeleteFile(ChangeFileExt(FileName,'.xml'));
  DeleteFile(ChangeFileExt(FileName,'.tmp.log'));
  DeleteFile(ChangeFileExt(FileName,'.blc.log'));
end;

function TfMain.CheckError(ErrorLineCandidate: String;IsPreprocessor:Boolean;DebugFileName:String) : Boolean;
begin
  Result := false;
  ErrorLineCandidate := UpperCase(ErrorLineCandidate);
  if Pos('ERROR',ErrorLineCandidate) > 0 then
  begin
      Result := True;
      GoToLine(ErrorLineCandidate, IsPreprocessor, DebugFileName);
  end;
end;


// Once a error line number is found, search the matching section and opens it if possible
procedure TfMain.GotoLine(ErrorLineCandidate:String; IsPreprocessor: Boolean;DebugFileName:String);
var ErrorLineNumber : integer;
    DebugFileContents : TstringList;
    SectionContents : TstringList;
    Descriptor : String;
    Section : String;
    FinalLine : Integer;
    i : integer;
    s : string;

begin
 if not IsPreprocessor then  // Get error ErrorLineNumber number
 begin
     ErrorLineCandidate := Copy(ErrorLineCandidate, Pos('.',ErrorLineCandidate) + 4, MaxLongint);
     i:= 1;
     s := '';
     while (i <= Length(ErrorLineCandidate)) and not (ErrorLineCandidate[i] in ['0'..'9']) do i := i + 1;
     while (i <= Length(ErrorLineCandidate)) and (ErrorLineCandidate[i] in ['0'..'9']) do begin
                                                               s := s + ErrorLineCandidate[i];
                                                               i := i + 1;
                                                              end;
 end
 else
 begin
    ErrorLineCandidate := Copy(ErrorLineCandidate, 1, Pos(',', ErrorLineCandidate) - 1);
    s := trim(ErrorLineCandidate);
 end;

 if s = '' then Exit; // No error line number found, give up
 try
  ErrorLineNumber := StrToInt(s);
 except
    Exit; // wrong error line number found, give up
 end;


 // If 0 returned just exit
 if ErrorLineNumber = 0 then Exit();

 DebugFileContents := TStringList.Create();
 DebugFileContents.LoadFromFile(DebugFileName);

 if ErrorLineNumber >= DebugFileContents.Count then ErrorLineNumber:=DebugFileContents.Count -1;

 Descriptor:= DebugFileContents.Strings[ErrorLineNumber];
 if Pos('|',Descriptor) = -1 then Exit;
 Section:= Copy(Descriptor,1,Pos('|',Descriptor)-1);
 FinalLine:= StrToInt(Copy(Descriptor, Pos('|', Descriptor)+1,255));

 if (Section = 'DEF') then SectionContents:= TXP.DEF else
 if (Section = 'CTL') then SectionContents:=  TXP.CTL else
 if (Section = 'VOC') then SectionContents:=  TXP.VOC else
 if (Section = 'STX') then SectionContents:=  TXP.STX else
 if (Section = 'MTX') then SectionContents:=  TXP.MTX else
 if (Section = 'LTX') then SectionContents:=  TXP.LTX else
 if (Section = 'OTX') then SectionContents:=  TXP.OTX else
 if (Section = 'OBJ') then SectionContents:=  TXP.OBJ else
 if (Section = 'CON') then SectionContents:=  TXP.CON else
 if (copy(Section, 1, 3) = 'PRO') then SectionContents:= TXP.Processes[StrToInt(Copy(Section, 5, 255))];

 OpenTab(Section, SectionContents, FinalLine);
end;


procedure TfMain.ShowSearchReplaceDialog(IsReplaceDialog: boolean);
var SynEdit : TSynEdit;
    SearchText :String;
    ReplaceText :String;
    Options: TSynSearchOptions;
begin
 // Setup Replace field
 if IsReplaceDialog then
 begin
   fSearchReplace.checkReplace.checked := true;
   fSearchReplace.checkReplaceChange(nil);
 end else
 begin
   fSearchReplace.checkReplace.checked := false;
   fSearchReplace.checkReplaceChange(nil);
 end;
 SynEdit := TSynEdit(PageControl.ActivePage.Controls[0]);
 // Find a selection
 SearchText := '';
 if SynEdit.SelAvail and (SynEdit.BlockBegin.y = SynEdit.BlockEnd.y)
      then
        SearchText := SynEdit.SelText
      else
        SearchText := SynEdit.GetWordAtRowCol(SynEdit.CaretXY);
 fSearchReplace.EditSearch.Text := SearchText;

 if (fSearchReplace.ShowModal() = mrOK) then
 begin
   if IsReplaceDialog then Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
                      else Options := [];

   if fSearchReplace.checkCaseSensitive.Checked then Options := Options + [ssoMatchCase];
   if not fSearchReplace.checkOnlyFromCursor.Checked then Options := Options + [ssoEntireScope];
   if fSearchReplace.checkWholeWordsOnly.Checked then Options := Options + [ssoWholeWord];
   if fSearchReplace.checkOnlyInSelection.Checked then Options := Options + [ssoSelectedOnly];
   SearchText:= fSearchReplace.EditSearch.Text;
   ReplaceText:= fSearchReplace.EditReplace.Text;


   DoSearchReplace(SynEdit, SearchText, ReplaceText, Options);

 end;

end;

procedure TfMain.DoSearchReplace(SynEdit : TSynEdit; SearchText, ReplaceText: String; Options: TSynSearchOptions);
begin
 LastSearchText:=SearchText;
 if SynEdit.SearchReplace(SearchText, ReplaceText, Options) = 0
  then ShowMessage('"' + SearchText + '" ' + S_SEARCH_REPLACE_NOT_FOUND)
  else
  begin
     SynEdit.CaretXY := SynEdit.BlockBegin;
     SynEdit.SelectWord;
  end;
end;

procedure TfMain.MFindNextClick(Sender: TObject);
var Options: TSynSearchOptions;

begin
  if PageControl.PageCount = 0 then Exit();
  if LastSearchText='' then MFind.Click()
  else
  begin
    Options := [];
    if fSearchReplace.checkCaseSensitive.Checked then Options := Options + [ssoMatchCase];
    if fSearchReplace.checkWholeWordsOnly.Checked then Options := Options + [ssoWholeWord];
    if fSearchReplace.checkOnlyInSelection.Checked then Options := Options + [ssoSelectedOnly];
    DoSearchReplace(TSynEdit(PageControl.ActivePage.Controls[0]), LastSearchText, LastSearchText, Options);
  end;
end;

procedure TfMain.CheckPaths();
begin
 if (not FileExists(COnfig.CompilerPath) or not FileExists(Config.PreprocessorPath) or not FileExists(COnfig.StartDatabasePath))
  then ShowMessage(S_WRONG_SETTINGS);
end;

function TfMain.CreateNewGame(Filename: String):boolean;
var StringList :TStringList;
    SourcePath : String;
    DestPath :String;
    FileBaseName :String;
    i : integer;
begin
 // Check required files exist

 FileBaseName:= ExtractFileNameOnly(Filename);
 SourcePath:= ExtractFilePath(Config.StartDatabasePath);

 if (not FileExists(Config.StartDatabasePath)) then
 begin
    ShowMessage(S_START_DATABASE_NOT_FOUND);
    Result := false;
    Exit;
 end;

  if (not FileExists(SourcePath + 'index.html')) or
     (not FileExists(SourcePath + 'css.css')) or
     (not FileExists(SourcePath + 'buzz.js')) or
     (not FileExists(SourcePath + 'jquery.js')) then
  begin
    ShowMessage(S_NEWGAME_FILES_NOT_FOUND);
    Result := false;
    Exit;
  end;

  //Create new game
  DestPath := ExtractFilePath(Filename);

  StringList := TStringList.Create();
  StringList.LoadFromFile(Config.StartDatabasePath);
  StringList.SaveToFile(Filename);


  // Copy And Patch the Index File
  StringList.LoadFromFile(SourcePath + 'index.html');
  for i:= 0 to StringList.Count -1 do
       StringList.Strings[i] := StringReplace(StringList.Strings[i],'code.js', FileBaseName + '.js',[rfIgnoreCase]);
  StringList.SaveToFile(DestPath +  'index.html');

  // Copy jquery, buzz and css file
  StringList.LoadFromFile(SourcePath + 'jquery.js');
  StringList.SaveToFile(DestPath + 'jquery.js');
  StringList.LoadFromFile(SourcePath + 'buzz.js');
  StringList.SaveToFile(DestPath + 'buzz.js');
  StringList.LoadFromFile(SourcePath + 'css.css');
  StringList.SaveToFile(DestPath + 'css.css');

  //Create dat folder
  {$I-}
  MkDir(DestPath + 'dat');
  {$I+}
  Result := true;
end;


end.


