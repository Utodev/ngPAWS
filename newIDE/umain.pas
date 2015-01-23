unit UMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynMemo, SynHighlighterAny, SynEdit,
  ExtendedNotebook, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, UConfig, UTXP, types;

type

  { TfMain }

  TfMain = class(TForm)
    MainMenu: TMainMenu;
    MEdit: TMenuItem;
    MCompile: TMenuItem;
    MCompileRun: TMenuItem;
    MPuzzleWizard: TMenuItem;
    MAbout: TMenuItem;
    MData: TMenuItem;
    MConnections: TMenuItem;
    MDefinitions: TMenuItem;
    MOpenAll: TMenuItem;
    PMCondactHelp: TMenuItem;
    PMPaste: TMenuItem;
    PMCut: TMenuItem;
    PMCopy: TMenuItem;
    PMSeparartor2: TMenuItem;
    PMSmallerFont: TMenuItem;
    PMLargerFont: TMenuItem;
    PMSeparator1: TMenuItem;
    PMInterrupt: TMenuItem;
    PMCloseTab: TMenuItem;
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
    MSaveAs: TMenuItem;
    MOpen: TMenuItem;
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
    procedure BNewClick(Sender: TObject);
    procedure BOpenClick(Sender: TObject);
    procedure ControlBarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MConnectionsClick(Sender: TObject);
    procedure MDataClick(Sender: TObject);
    procedure MDefinitionsClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MLocationsClick(Sender: TObject);
    procedure MMessagesClick(Sender: TObject);
    procedure MNewClick(Sender: TObject);
    procedure MObjectDataClick(Sender: TObject);
    procedure MObjectTextsClick(Sender: TObject);
    procedure MOpenAllClick(Sender: TObject);
    procedure MOpenClick(Sender: TObject);
    procedure MOptionsClick(Sender: TObject);
    procedure MQuitClick(Sender: TObject);
    procedure mSystemMessagesClick(Sender: TObject);
    procedure MToolsClick(Sender: TObject);
    procedure MVocabularyClick(Sender: TObject);
    procedure PanelBackgroundClick(Sender: TObject);
    procedure MProcessItemClick(Sender: TObject);
    function ShowNotSaveWarning():boolean;
    procedure OpenBrowser(URL: String);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);



  private
    procedure HelpResponse(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure BuildProcessMenu(TXP: TTXP);
    procedure SetEditMode(mode : boolean);
    procedure OpenTab(Section: String; Content: TStringList);
    procedure SynMemoKeyPress(Sender: TObject; var Key: Char);
    procedure SynMemoClick(Sender: TObject);

    { private declarations }
  public
    Config: TConfig;
    CodeModified : boolean;
    TXP : TTXP;
  end;

var
  fMain: TfMain;

implementation

uses uoptions, UGlobals;

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

procedure TfMain.MConnectionsClick(Sender: TObject);
begin
  OpenTab('CON',TXP.Connections);
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
  MOpen.click();
end;

procedure TfMain.BNewClick(Sender: TObject);
var TabSheet : TTabSheet;
begin
  MNew.click();
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

procedure TfMain.MOpenAllClick(Sender: TObject);
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
   MOpen.Enabled := not mode;
   MNew.Enabled := not mode;
   MRecentFiles.Enabled:= not mode;

   MClose.Enabled:= mode;
   MProcesses.Enabled := mode;
   MData.Enabled := mode;
   MSave.Enabled := mode;
   MSaveAs.Enabled := mode;
   MClose.Enabled := mode;
   MPuzzleWizard.Enabled := mode;
   MEdit.Enabled := mode;
   MProject.Enabled := mode;
end;

procedure TfMain.MOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    TXP := TTXP.Create();
    TXP.LoadTXP(OpenDialog.FileName);
    SetEditMode(true);
    if  Config.OpenAllTabs then MOpenAll.Click() else
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


procedure TfMain.MOptionsClick(Sender: TObject);
begin
  if fOptions.ShowModal = mrOK then
  begin
    fOptions.SaveToConfig(Config);
    Config.SaveConfig();
  end;
end;

procedure TfMain.MQuitClick(Sender: TObject);
begin
  if ShowNotSaveWarning() then Halt(0);
end;

procedure TfMain.mSystemMessagesClick(Sender: TObject);
begin
    OpenTab('STX',TXP.SysMess);
end;

procedure TfMain.MToolsClick(Sender: TObject);
begin

end;

procedure TfMain.MVocabularyClick(Sender: TObject);
begin
  OpenTab('VOC',TXP.Vocabulary);
end;

procedure TfMain.OpenTab(Section: String; Content: TStringList);
var found : boolean;
    i : integer;
    SynEdit : TSynMemo;
    TabSheet : TTabSheet;
begin
  if not PageControl.Visible then PageControl.Visible:= true;
  if (Section = 'PRO 0') then Section:= 'RESP';
  found := false;
  i := 0;
  while ((not found) and (i< PageControl.PageCount)) do
   begin
    if (TSynMemo(PageControl.Pages[i].Controls[0]).Hint = Section) then
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
 TabSheet.Font.Color := clWhite;
 TabSheet.Hint:=Section;
 TabSheet.ShowHint:=false;
 TabSheet.Caption:=Section;
 SynEdit := TSynMemo.Create(TabSheet);
 SynEdit.Parent := TabSheet;
 SynEdit.Align:=alClient;
 SynEdit.OnKeyPress := @SynMemoKeyPress;
 SynEdit.OnClick := @SynMemoClick;
 SynEdit.OnKeyDown := @HelpResponse;
 SynEdit.Font.Color := clWhite;
 SynEdit.Color:=$222827;
 SynEdit.ScrollBars := ssVertical;
 SynEdit.Gutter.Visible := false;
 SynEdit.Font.Size := 13;
 SynEdit.PopupMenu := MainPopupMenu;
 SynEdit.ScrollBars := ssBoth;
 SynEdit.Options := SynEdit.Options + [eoSmartTabDelete, eoSmartTabs, eoAutoIndent];
 SynEdit.WantTabs := true;
 SynEdit.ShowHint:= false;
 SynEdit.Hint := Section;
 SynEdit.RightEdge:=0;

 if (Section = 'VOC') then SynEdit.Highlighter := VocHighlighter else
 if (Section = 'CTL') then begin end else
 if (Copy(Section,1,3) = 'PRO') then SynEdit.Highlighter := CodeHighlighter else
 SynEdit.Highlighter := DataHighlighter;

 SynEdit.Text:=Content.Text;
 PageControl.ActivePage := PageControl.Pages[PageControl.PageCount-1];
 SynEdit.SetFocus();
end;


procedure TfMain.SynMemoKeyPress(Sender: TObject; var Key: Char);
begin
 CodeModified:=true;
end;

procedure TfMain.HelpResponse(Sender: TObject; var Key: Word;  Shift: TShiftState);
var Sel, SelLine, URL:String;
    i : integer;
    CurrentLine: integer;
begin
  { TODO 1 -cREVISAR : No se por qué estaba esta linea en el codigo de Delphi }
  //(PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynMemo).ActiveLineColor := $333333;
 if key <> $70 then exit; // F1


 CurrentLine :=(PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynMemo).CaretY -1;
 SelLine := (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynMemo).Lines[CurrentLine];
 if SelLine = '' then
 begin
   MHelpContents.Click();
  Exit
 end;

 Sel := '';
 i := (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynMemo).CaretX;
 while (i>=1) and (SelLine[i]<>' ') do
  begin
   Sel := SelLine[i] + Sel;
   I := i - 1;
  end;
 i := (PageControl.Pages[PageControl.ActivePageIndex].Controls[0] as TSynMemo).CaretX + 1;
 while (i<=Length(SelLine)) and (SelLine[i]<>' ') do
  begin
   Sel :=   Sel + SelLine[i];
   I := i + 1;
  end;

   URL := Config.HelpBaseURL;
   if NOT (Config.HelpBaseURL[Length(Config.HelpBaseURL)] in ['/','\']) then URL := URL + '/';
   URL := URL + AnsiUpperCase(Sel);
   if (Config.Lang='ES') then URL := URL + '_ES';
    if FileExists(Config.InterpreterPath) then OpenBrowser(URL)
                                          else ShowMessage(S_BROWSER_NOT_FOUND);
end;


procedure TfMain.SynMemoClick(Sender: TObject);
begin
 { TODO : ¿Que pasa con el ActiveLineColor? }
//  (Sender as TSynMemo).ActiveLineColor := $333333;
end;

procedure TfMain.OpenBrowser(URL: String);
begin
 { TODO : Falta el procedimiento de lanzar el navegador }
end;

procedure TfMain.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;


end.

