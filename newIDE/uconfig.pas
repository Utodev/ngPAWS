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
 FUsePreprocessor : Boolean;
 FDeleteTempFiles : Boolean;
 FSaveBeforeRun : Boolean;
 FWordWrap : Boolean;
 FShowToolBar : Boolean;
 FOpenAllTabs : Boolean;
 FLang : String;
public
 property CompilerPath : String read FCompilerPath write FCompilerPath;
 property PreprocessorPath : String read FPreprocessorPath write FPreprocessorPath;
 property StartDatabasePath : String read FStartDatabasePath write FStartDatabasePath;
 property PreprocessorParameters : String read FPreprocessorParameters write FPreprocessorParameters;
 property HelpBaseURL : String read FHelpBaseURL write FHelpBaseURL;

 property UsePreprocessor : Boolean read FUsePreprocessor write FUsePreprocessor;
 property DeleteTempFiles : Boolean read FDeleteTempFiles write FDeleteTempFiles;
 property SaveBeforeRun : Boolean read FSaveBeforeRun write FSaveBeforeRun;
 property WordWrap : Boolean read FWordWrap write FWordWrap;
 property ShowToolBar : Boolean read FShowToolBar write FShowToolBar;
 property OpenAllTabs : Boolean read  FOpenAllTabs write  FOpenAllTabs;

 property Lang: String read FLang write FLang;

 procedure LoadConfig();
 procedure SaveConfig();
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
  FWordWrap := IniFile.ReadBool('Options','WordWrap',false);
  FSaveBeforeRun := IniFile.ReadBool('Options','SaveBeforeRun',true);
  FUsePreprocessor := IniFile.ReadBool('Options','UsePreprocessor',true);
  FShowToolBar :=  IniFile.ReadBool('Options','ShowToolBar',true);
  FOpenAllTabs :=  IniFile.ReadBool('Options','OpenAllTabs',false);

  FLang :=  IniFile.ReadString('Lang','Lang','EN');
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
  IniFile.WriteBool('Options','WordWrap', FWordWrap);
  IniFile.WriteBool('Options','SaveBeforeRun', FSaveBeforeRun);
  IniFile.WriteBool('Options','UsePreprocessor', FUsePreprocessor);
  IniFile.WriteBool('Options','ShowToolBar', FShowToolBar);
  IniFile.WriteBool('Options','OpenAllTabs', FOpenAllTabs);

  IniFile.WriteString('Lang','Lang', FLang);
end;


end.

