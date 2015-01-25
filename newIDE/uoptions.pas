unit uoptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Menus, UConfig;

type

  { TfOptions }

  TfOptions = class(TForm)
    BBrowseCompiler: TButton;
    BBrowseStartDatabase: TButton;
    BOk: TButton;
    BCancel: TButton;
    BBrowsePreprocessor: TButton;
    checkOpenAllTabs: TCheckBox;
    checkDeleteTempFiles: TCheckBox;
    checkShowToolbar: TCheckBox;
    checkSaveBeforeRun: TCheckBox;
    ComboBoxLang: TComboBox;
    EditPreprocessorParameters: TEdit;
    EditPreprocessor: TEdit;
    EditHelpURL: TEdit;
    EditCompiler: TEdit;
    EditStartDatabase: TEdit;
    LabelPreprocessorParameters: TLabel;
    LabelLang: TLabel;
    LabelCompiler: TLabel;
    LabelPreprocessor: TLabel;
    LabelHelpURL: TLabel;
    LabelStartDatabase: TLabel;
    PageControlOptions: TPageControl;
    TabSheetCompiler: TTabSheet;
    TabSheetEditor: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure SaveToConfig(var Config: TConfig);
  private
    procedure LoadFromConfig();
  public
    { public declarations }
  end;

var
  fOptions: TfOptions;

implementation

{$R *.lfm}

uses UMain;

{ TfOptions }

procedure TfOptions.LoadFromConfig();
begin
 checkShowToolbar.Checked :=  fMain.Config.ShowToolBar;
 checkDeleteTempFiles.Checked:= fMain.Config.DeleteTempFiles;
 checkSaveBeforeRun.Checked:=fMain.Config.SaveBeforeRun;
 checkOpenAllTabs.Checked:=fMain.Config.OpenAllTabs;

 EditCompiler.Text:= fMain.Config.CompilerPath;
 EditHelpURL.Text:= fMain.Config.HelpBaseURL;
 EditPreprocessor.Text:= fMain.Config.PreprocessorPath;
 EditStartDatabase.Text:= fMain.Config.StartDatabasePath;
 EditPreprocessorParameters.Text:=fMain.Config.PreprocessorParameters;

 if fMain.Config.Lang = 'ES' then  ComboBoxLang.ItemIndex := 1 else ComboBoxLang.ItemIndex := 0;

end;

procedure TfOptions.SaveToConfig(var Config: TConfig);
begin
  Config.ShowToolBar := checkShowToolbar.Checked;
  Config.DeleteTempFiles := checkDeleteTempFiles.Checked;
  Config.SaveBeforeRun := checkSaveBeforeRun.Checked;
  Config.OpenAllTabs := checkOpenAllTabs.Checked;



   Config.CompilerPath := EditCompiler.Text;
   Config.HelpBaseURL := EditHelpURL.Text;
   Config.PreprocessorPath := EditPreprocessor.Text;
   Config.StartDatabasePath := EditStartDatabase.Text;
   Config.PreprocessorParameters := EditPreprocessorParameters.Text;

   if (ComboBoxLang.ItemIndex = 1) then Config.Lang := 'ES' else Config.Lang := 'EN';

end;

procedure TfOptions.FormShow(Sender: TObject);
begin
  LoadFromConfig();
end;

end.

