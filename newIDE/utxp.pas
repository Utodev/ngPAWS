unit UTXP;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type TTXP = class
  private
    FDEF : TStringList;
    FCTL : TStringList;
    FVOC : TStringList;
    FSTX : TStringList;
    FMTX : TStringList;
    FOTX : TStringList;
    FLTX : TStringList;
    FOBJ : TStringList;
    FCON : TStringList;
    FProcesses : array[0..255] of  TStringList;
    FFilePath : String;

    FInterruptProcesNum : integer;
    FLastProcess : integer;

    function GetProcess(i:longint) : TStringList;
    function AddBlock(NameTag : String; Content: TStringList; Header: String):boolean;


   public
    property DEF : TStringList read FDEF write FDEF;
    property CTL : TStringList read FCTL write FCTL;
    property VOC : TStringList read FVOC write FVOC;
    property STX : TStringList read FSTX write FSTX;
    property MTX : TStringList read FMTX write FMTX;
    property OTX : TStringList read FOTX write FOTX;
    property LTX : TStringList read FLTX write FLTX;
    property OBJ : TStringList read FOBJ write FOBJ;
    property CON : TStringList read FCON write FCON;
    property Processes [i: longint] : TStringList read GetProcess;
    property InterruptProcessNum : integer read FInterruptProcesNum write FInterruptProcesNum;
    property LastProcess : integer read FLastProcess write FLastProcess;
    property FilePath : String read FFilePath;


    constructor Create();
    procedure Free();

    function LoadTXP(Filename: String):boolean;
    procedure SaveTXP(Filename: String; WidthDebugInfo: Boolean = false);
    function AddProcess():boolean;
    function SetInterruptProcess(ProcessID: Byte):boolean;
    procedure SetProcessCode(i: longint; Value: String);
    function getIdentifierList():TStringList;

end;

implementation

uses UGlobals, StrUtils, LConvEncoding, Dialogs;

const BlockNames :  array [0..9] of String = ('DEF','CTL','VOC','STX','MTX','OTX','LTX','CON','OBJ','PRO');



constructor TTXP.Create();
var i : integer;
begin
    FDEF := TStringList.Create();
    FCTL := TStringList.Create();
    FVOC := TStringList.Create();
    FSTX := TStringList.Create();
    FMTX := TStringList.Create();
    FOTX := TStringList.Create();
    FLTX := TStringList.Create();
    FOBJ := TStringList.Create();
    FCON := TStringList.Create();
    FInterruptProcesNum:= -1;
    FLastProcess:=-1;
end;

procedure TTXP.Free();
var i : byte;
begin
 FDEF.Free();
 FVOC.Free();
 FSTX.Free();
 FMTX.Free();
 FOTX.Free();
 FLTX.Free();
 FOBJ.Free();
 FCON.Free();
 for i:= 0 to 255 do if (Assigned(FProcesses[i])) then  FProcesses[i].Free();
end;

function TTXP.LoadTXP(Filename: String):boolean;
var FileContents: TStringList;  // Whole File
    CurrentBlock : TStringList; // The current block contents
    CurrentBlockName : String; // Current block name tag (i.e. DEF, CTL, VOC, PRO, OTX, etc.)
    CurrentBlockHeader : String; // Current block whole header (i.e "\DEF", "\CTL", "\CTL ; CTL", "\PRO 4", "\PRO INTERRUPT 4; Proc Int", etc.)
    ptr : longint;
    CurrentLine : String;
    BlockBeingProcessed :  String;
    BlockNameCandidate : String;
    IsBlockStart : Boolean;
begin
  FFilePath:=Filename;
  FileContents := TStringList.Create();
  CurrentBlock := TStringList.Create();
  if (not FileExists(Filename)) then
  begin
    ShowMessage(S_FILE_NOT_FOUND);
    Result := false;
    Exit;
  end;
  FileContents.LoadFromFile(Filename);
  {$ifdef ANSI}
  FileContents.Text:= AnsiToUtf8(FileContents.Text);
  {$endif}
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
        if (Pos(' ',CurrentLine)=0) then BlockNameCandidate := Copy(CurrentLine, 2, 3)
                                    else BlockNameCandidate:= Copy(CurrentLine,2,Pos(' ',CurrentLine)-2);
         if AnsiMatchText(BlockNameCandidate, BlockNames) then
         begin
              if not AddBlock(CurrentBlockName, CurrentBlock, CurrentBlockHeader) then
              begin
                Result := false;
                Exit();
              end;
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
  Result := true;
end;


procedure TTXP.SaveTXP(Filename: String; WidthDebugInfo: Boolean = false);
var FileContents: TStringList;
    DebugFileContents : TStringList;
    i,j : integer;
    AuxStr : string;
begin
 if (Filename = '') then Filename := FFilePath;
 FileContents := TStringList.Create();
 DebugFileContents := TStringList.Create();

 FileContents.AddStrings(FDEF);
 if (WidthDebugInfo) then for i := 0 to FDEF.Count - 1 do DebugFileContents.Add('DEF|' + IntToStr(i));

 FileContents.Add('/CTL');
 FileContents.AddStrings(FCTL);
 if (WidthDebugInfo) then
 begin
   DebugFileContents.Add('/CTL');
   for i := 0 to FCTL.Count - 1 do DebugFileContents.Add('CTL|' + IntToStr(i));
 end;

 FileContents.Add('/VOC');
 FileContents.AddStrings(FVOC);
 if (WidthDebugInfo) then
 begin
   DebugFileContents.Add('/VOC');
   for i := 0 to FVOC.Count - 1 do DebugFileContents.Add('VOC|' + IntToStr(i));
 end;

 FileContents.Add('/STX');
 FileContents.AddStrings(FSTX);
 if (WidthDebugInfo) then
 begin
   DebugFileContents.Add('/STX');
   for i := 0 to FSTX.Count - 1 do DebugFileContents.Add('STX|' + IntToStr(i));
 end;


  FileContents.Add('/MTX');
  FileContents.AddStrings(FMTX);
  if (WidthDebugInfo) then
  begin
    DebugFileContents.Add('/MTX');
    for i := 0 to FMTX.Count - 1 do DebugFileContents.Add('MTX|' + IntToStr(i));
  end;

  FileContents.Add('/OTX');
  FileContents.AddStrings(FOTX);
  if (WidthDebugInfo) then
  begin
    DebugFileContents.Add('/OTX');
    for i := 0 to FOTX.Count - 1 do DebugFileContents.Add('OTX|' + IntToStr(i));
  end;


  FileContents.Add('/LTX');
  FileContents.AddStrings(FLTX);
  if (WidthDebugInfo) then
  begin
    DebugFileContents.Add('/LTX');
    for i := 0 to FLTX.Count - 1 do DebugFileContents.Add('LTX|' + IntToStr(i));
  end;

  FileContents.Add('/CON');
  FileContents.AddStrings(FCON);
  if (WidthDebugInfo) then
  begin
    DebugFileContents.Add('/CON');
    for i := 0 to FCON.Count - 1 do DebugFileContents.Add('CON|' + IntToStr(i));
  end;

  FileContents.Add('/OBJ');
  FileContents.AddStrings(FOBJ);
  if (WidthDebugInfo) then
  begin
    DebugFileContents.Add('/OBJ');
    for i := 0 to FOBJ.Count - 1 do DebugFileContents.Add('OBJ|' + IntToStr(i));
  end;


 for i:= 0 to FLastProcess do
 begin
   AuxStr := '/PRO ';
   if (i = FInterruptProcesNum) then AuxStr := AuxStr + 'INTERRUPT ';
   AuxStr := AuxStr + IntToStr(i);
   FileContents.Add(AuxStr);
   FileContents.AddStrings(FProcesses[i]);
   if (WidthDebugInfo) then
   begin
     DebugFileContents.Add(AuxStr);
     for j := 0 to FProcesses[i].Count - 1 do DebugFileContents.Add('PRO ' + IntToStr(i) + '|' + IntToStr(j));
   end;
 end;
 {$IFDEF ANSI}
 FileContents.text := Utf8ToAnsi(FileContents.Text);
 {$ENDIF}
 FileContents.SaveToFile(Filename);
 FileContents.Free();
 if WidthDebugInfo then
 begin
   DebugFileContents.SaveToFile(ChangeFileExt(Filename,'.dbg'));
   DebugFileContents.Free();;
 end;
end;


function TTXP.AddBlock(NameTag : String; Content: TStringList; Header: String):boolean;
var StrAux : String;
    ProcNum :   integer;
    MarkAsInterrupt :Boolean;
begin
 Result := true;
 NameTag:=AnsiUpperCase(NameTag);
 if (NameTag = 'DEF') then FDEF.Text := Content.Text else
 if (NameTag = 'CTL') then FCTL.Text := Content.Text else
 if (NameTag = 'VOC') then FVOC.Text := Content.Text else
 if (NameTag = 'STX') then FSTX.Text := Content.Text else
 if (NameTag = 'MTX') then FMTX.Text := Content.Text else
 if (NameTag = 'LTX') then FLTX.Text := Content.Text else
 if (NameTag = 'OTX') then FOTX.Text := Content.Text else
 if (NameTag = 'CON') then FCON.Text := Content.Text else
 if (NameTag = 'OBJ') then FOBJ.Text := Content.Text else
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
 else begin
       ShowMessage(S_INVALID_SECTION + ' : ' + NameTag);
       Result := false;
      end;
end;

procedure TTXP.SetProcessCode(i: longint; Value: String);
begin
  if (not  Assigned(FProcesses[i])) then FProcesses[i] := TStringList.Create();
  FProcesses[i].Text:= Value;
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
      FProcesses[num].Text := '; ** New ngPAWS Process ' + IntToStr(num) + LF;
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

function TTXP.getIdentifierList():TStringList;
var List, TempList : TStringList;
    i : integer;
    j : integer;
begin
 List := TStringList.Create();
 List.Sorted:=true;
 List.Duplicates:=dupIgnore;

 TempList := TStringList.Create();
 TempList.Duplicates:=dupIgnore;
 TempList.Sorted:=true;

 ExtractStrings([' '],[],PChar(DEF.Text),TempList);
 for i:= 0 to TempList.Count-1 do
  if (TempList.Strings[i]<>'') and (TempList.Strings[i][1] in ['a'..'z','A'..'Z','#']) then List.Add(TempList.Strings[i]);

 TempList.Clear();
 for j:=0 to FLastProcess do
 begin
  ExtractStrings([' '],[],PChar(Processes[j].Text),TempList);
  for i:= 0 to TempList.Count-1 do
    if (TempList.Strings[i]<>'') and (TempList.Strings[i][1] in ['a'..'z','A'..'Z']) then List.Add(TempList.Strings[i]);
 end;

 TempList.Free();;
 Result := List;
end;

end.

