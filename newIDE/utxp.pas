unit UTXP;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type TTXP = class
  private
    FDefinitions : TStringList;
    FControl : TStringList;
    FVocabulary : TStringList;
    FSysMess : TStringList;
    FUsrMess : TStringList;
    FObjectTexts : TStringList;
    FLocationTexts : TStringList;
    FObjectData : TStringList;
    FConnections : TStringList;
    FProcesses : array[0..255] of  TStringList;
    FProcessesNames : array [0..255] of String;

    FInterruptProcesNum : integer;
    FLastProcess : integer;

    procedure SetProcess(i: longint; Value: TStringList);
    function GetProcess(i:longint) : TStringList;
    procedure AddBlock(NameTag : String; Content: TStringList; Header: String);


   public
    property Definitions : TStringList read FDefinitions write FDefinitions;
    property Control : TStringList read FControl write FControl;
    property Vocabulary : TStringList read FVocabulary write FVocabulary;
    property SysMess : TStringList read FSysMess write FSysMess;
    property UsrMess : TStringList read FUsrMess write FUsrMess;
    property ObjectTexts : TStringList read FObjectTexts write FObjectTexts;
    property LocationTexts : TStringList read FLocationTexts write FLocationTexts;
    property ObjectData : TStringList read FObjectData write FObjectData;
    property Connections : TStringList read FConnections write FConnections;
    property Processes [i: longint] : TStringList read GetProcess write SetProcess;
    property InterruptProcessNum : integer read FInterruptProcesNum write FInterruptProcesNum;
    property LastProcess : integer read FLastProcess write FLastProcess;


    constructor Create();
    procedure Free();

    procedure LoadTXP(Filename: String);
    procedure SaveTXP(Filename: String);
    function AddProcess():boolean;
    function SetInterruptProcess(ProcessID: Byte):boolean;


end;

implementation

uses UGlobals, StrUtils, LConvEncoding;

const BlockNames :  array [0..9] of String = ('DEF','CTL','VOC','STX','MTX','OTX','LTX','CON','OBJ','PRO');



constructor TTXP.Create();
var i : integer;
begin
    FDefinitions := TStringList.Create();
    FControl := TStringList.Create();
    FVocabulary := TStringList.Create();
    FSysMess := TStringList.Create();
    FUsrMess := TStringList.Create();
    FObjectTexts := TStringList.Create();
    FLocationTexts := TStringList.Create();
    FObjectData := TStringList.Create();
    FConnections := TStringList.Create();
    FInterruptProcesNum:= -1;
    FLastProcess:=-1;
end;

procedure TTXP.Free();
var i : byte;
begin
 FDefinitions.Free();
 FVocabulary.Free();
 FSysMess.Free();
 FUsrMess.Free();
 FObjectTexts.Free();
 FLocationTexts.Free();
 FObjectData.Free();
 FConnections.Free();
 for i:= 0 to 255 do if (FProcesses[i]<>nil) then  FProcesses[i].Free();
end;

procedure TTXP.LoadTXP(Filename: String);
var FileContents: TStringList;  // Whole File
    CurrentBlock : TStringList; // The current block contents
    CurrentBlockName : String; // Current block name tag (i.e. DEF, CTL, VOC, PRO, OTX, etc.)
    CurrentBlockHeader : String; // Current block whole header (i.e "\DEF", "\CTL", "\CTL ; Control", "\PRO 4", "\PRO INTERRUPT 4; Proc Int", etc.)
    ptr : longint;
    CurrentLine : String;
    BlockBeingProcessed :  String;
    BlockNameCandidate : String;
    IsBlockStart : Boolean;
begin
  FileContents := TStringList.Create();
  CurrentBlock := TStringList.Create();
  if (not FileExists(Filename)) then  raise Exception.Create(S_FILE_NOT_FOUND);
  FileContents.LoadFromFile(Filename);
  ptr := 0;
  CurrentBlockName := BlockNames[0]; // DEF
  CurrentBlockHeader := CurrentBlockName;
  while ptr<FileContents.Count do
  begin
    CurrentLine := FileContents[ptr];
    IsBlockStart := false;
    // Check if another block starts
    if (Length(CurrentLine)>3) and (CurrentLine[1] ='/') then
    begin
        BlockNameCandidate := Copy(CurrentLine, 2, 3);
         if AnsiMatchText(BlockNameCandidate, BlockNames) then
         begin
              AddBlock(CurrentBlockName, CurrentBlock, CurrentBlockHeader);
              CurrentBlockName := BlockNameCandidate;
              CurrentBlockHeader := CurrentLine;
              CurrentBlock.Text := '';
              IsBlockStart:=true;

         end
    end;
    if (not IsBlockStart) then CurrentBlock.Add(CurrentLine);
    ptr := ptr + 1;
  end;
  AddBlock(CurrentBlockName, CurrentBlock, CurrentBlockHeader);
end;

procedure TTXP.SaveTXP(Filename: String);
begin


end;


procedure TTXP.AddBlock(NameTag : String; Content: TStringList; Header: String);
var StrAux : String;
    ProcNum :   integer;
    MarkAsInterrupt :Boolean;
begin
 ConvertEncoding(Content.Text, 'Ansi', 'UTF-8');
 if (NameTag = 'DEF') then FDefinitions.Text := Content.Text else
 if (NameTag = 'CTL') then FControl.Text := Content.Text else
 if (NameTag = 'VOC') then FVocabulary.Text := Content.Text else
 if (NameTag = 'STX') then FSysMess.Text := Content.Text else
 if (NameTag = 'MTX') then FUsrMess.Text := Content.Text else
 if (NameTag = 'LTX') then FLocationTexts.Text := Content.Text else
 if (NameTag = 'OTX') then FObjectTexts.Text := Content.Text else
 if (NameTag = 'CON') then FConnections.Text := Content.Text else
 if (NameTag = 'OBJ') then FObjectData.Text := Content.Text else
 if (NameTag = 'PRO') then
 begin
      MarkAsInterrupt := false;
      if ((Length(Header)<6) or (Header[5]<>' ')) then raise Exception.Create(S_INVALID_FORMAT);
      StrAux := Copy(Header, 6,255);
      if (Pos(';', StrAux)<>0) then StrAux := Copy(StrAux, 1, Pos(';', StrAux) -1);
      if (Copy(StrAux,1,9)='INTERRUPT') then
      begin
        StrAux := Copy(StrAux, 11, 255);
        MarkAsInterrupt := true;
      end;
      try
       Procnum := StrToInt(Trim(StrAux));
      except
       Procnum := -1;
      end;
      if ProcNum < FLastProcess then raise Exception.Create(S_INVALID_PROCESS_NUMBER);
      if MarkAsInterrupt then FInterruptProcesNum := ProcNum;
      if (FProcesses[ProcNum]<>nil) or (Procnum>255) or (ProcNum<0) then raise Exception.Create(S_INVALID_PROCESS_NUMBER);
      FProcesses[ProcNum] := TStringList.Create();
      FProcesses[ProcNum].Text := Content.Text;
      FLastProcess:=ProcNum;
 end
 else raise Exception.Create(S_INVALID_SECTION);
end;

procedure TTXP.SetProcess(i: longint; Value: TStringList);
begin
  if (FProcesses[i] = nil) then FProcesses[i] := TStringList.Create();
  FProcesses[i].Text:= Value.Text;
end;

function TTXP.GetProcess(i:longint) : TStringList;
begin
 Result := TStringList.Create();
 if (FProcesses[i] = nil) then Result.Text := '' else Result.Text :=  FProcesses[i].Text;
end;


function TTXP.AddProcess():boolean;
var num : integer;
begin
 num := FLastProcess + 1;
 if (num <256) then
 begin
      FProcesses[num] := TStringList.Create();
      FProcesses[num].Text := '; ** New ngPAWS Process ' + IntToStr(num+1) + LF;
      FLastProcess := FLastProcess + 1;
      Result := true;
 end else Result := false;
end;

function TTXP.SetInterruptProcess(ProcessID: Byte):boolean;
begin
 if (ProcessID > 2) then
 begin
   FInterruptProcesNum := ProcessID;
   Result := true;
 end
 else Result := false;
end;

end.

