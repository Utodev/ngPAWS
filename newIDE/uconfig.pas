unit UConfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


type TConfig = class
private
 FCompilerPath : String;
 FPreprocessorPath : String;
 FStartDatabasePath: String;
 FPreprocessorParameters : String;
 FHelpBaseURL : String;
 FDeleteTempFiles : Boolean;
 FSaveBeforeRun : Boolean;
 FShowToolBar : Boolean;
 FOpenAllTabs : Boolean;
 FLang : String;
 FRecentFiles: Array[0..9] of string;
 FEditorFontSize: integer;
public
 property CompilerPath : String read FCompilerPath write FCompilerPath;
 property PreprocessorPath : String read FPreprocessorPath write FPreprocessorPath;
 property StartDatabasePath : String read FStartDatabasePath write FStartDatabasePath;
 property PreprocessorParameters : String read FPreprocessorParameters write FPreprocessorParameters;
 property HelpBaseURL : String read FHelpBaseURL write FHelpBaseURL;

 property DeleteTempFiles : Boolean read FDeleteTempFiles write FDeleteTempFiles;
 property SaveBeforeRun : Boolean read FSaveBeforeRun write FSaveBeforeRun;
 property ShowToolBar : Boolean read FShowToolBar write FShowToolBar;
 property OpenAllTabs : Boolean read  FOpenAllTabs write  FOpenAllTabs;

 property Lang: String read FLang write FLang;
 property EditorFontSize: integer read FEditorFontSize write FEditorFontSize;

 procedure LoadConfig();
 procedure SaveConfig();

 procedure LoadRecentFiles();
 procedure SaveRecentFiles();
 function GetRecentFile(i:integer) : string;
 procedure AddRecentFile(Filename:String);
end;



implementation

uses Inifiles;


procedure TConfig.LoadConfig();
var IniFile : TIniFile;
    ConfigFilePath : String;
begin
  ConfigFilePath:= ChangeFileExt(GetAppConfigFile(False), '.ini');
  IniFile := TIniFile.Create(ConfigFilePath);

  FPreprocessorPath := IniFile.ReadString('Paths','PreprocessorPath','txtpaws.exe');
  FCompilerPath := IniFile.ReadString('Paths','CompilerPath','ngpc.exe');
  FStartDatabasePath := IniFile.ReadString('Paths','StartDatabasePath','database.start');;

  FHelpBaseURL :=  IniFile.ReadString('URLS','HelpBaseURL','https://github.com/Utodev/ngPAWS/wiki');

  FPreprocessorParameters := IniFile.ReadString('Paths','PreprocessorParameters','-uk -CLEAN -I"dat"');

  FDeleteTempFiles := IniFile.ReadBool('Options','DeleteTemFiles',true);
  FSaveBeforeRun := IniFile.ReadBool('Options','SaveBeforeRun',true);
  FShowToolBar :=  IniFile.ReadBool('Options','ShowToolBar',true);
  FOpenAllTabs :=  IniFile.ReadBool('Options','OpenAllTabs',false);
  FEditorFontSize :=  IniFile.ReadInteger('Options','EditorFontSize',13);


  FLang :=  IniFile.ReadString('Lang','Lang','EN');
  IniFile.Free();
  LoadRecentFiles();
end;



procedure TConfig.SaveConfig();
var IniFile : TIniFile;
    ConfigFilePath : String;
begin
  ConfigFilePath:= ChangeFileExt(GetAppConfigFile(False), '.ini');
  IniFile := TIniFile.Create(ConfigFilePath);

  IniFile.WriteString('Paths','PreprocessorPath', FPreprocessorPath);
  IniFile.WriteString('Paths','CompilerPath', FCompilerPath);
  IniFile.WriteString('Paths','StartDatabasePath', FStartDatabasePath);

  IniFile.WriteString('URLS','HelpBaseURL', FHelpBaseURL);

  IniFile.WriteString('Paths','PreprocessorParameters',FPreprocessorParameters);

  IniFile.WriteBool('Options','DeleteTempFiles', FDeleteTempFiles);
  IniFile.WriteBool('Options','SaveBeforeRun', FSaveBeforeRun);
  IniFile.WriteBool('Options','ShowToolBar', FShowToolBar);
  IniFile.WriteBool('Options','OpenAllTabs', FOpenAllTabs);

  IniFile.WriteInteger('Options','EditorFontSize',FEditorFontSize);

  IniFile.WriteString('Lang','Lang', FLang);
  IniFile.Free();
  SaveRecentFiles();
end;


procedure TConfig.LoadRecentFiles();
var i : integer;
    IniFile : TIniFile;
    ConfigFilePath : String;
begin
  ConfigFilePath:= ChangeFileExt(GetAppConfigFile(False), '.ini');
  IniFile := TIniFile.Create(ConfigFilePath);
  for i := 0 to 9 do FRecentFiles[i] :=  IniFile.ReadString('Recent files','File' + IntToStr(i), '');
  IniFile.Free();
end;

procedure TConfig.SaveRecentFiles();
var i : integer;
    IniFile : TIniFile;
    ConfigFilePath : String;
begin
  ConfigFilePath:= ChangeFileExt(GetAppConfigFile(False), '.ini');
  IniFile := TIniFile.Create(ConfigFilePath);
  for i := 0 to 9 do IniFile.WriteString('Recent files','File' + IntToStr(i), FRecentFiles[i]);
  IniFile.Free();
end;

function TConfig.GetRecentFile(i:integer) : string;
begin
  Result := FRecentFiles[i];
end;


procedure TConfig.AddRecentFile(Filename:String);
var i,j: integer;
    found : boolean;
begin
  found := false;
  for  i:= 0  to 9 do
   if FRecentFiles[i] = Filename then
    begin
      found := true;
      for j := i downto 1 do FRecentFiles[j] := FRecentFiles[j-1];
      FRecentFiles[0] := Filename;
    end;
  if not found then
   begin
     for i:= 9 downto 1 do FRecentFiles[i] := FRecentFiles[i-1];
     FRecentFiles[0] := Filename;
   end;
  SaveRecentFiles();
end;

end.

