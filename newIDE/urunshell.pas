unit URunShell;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, Process, UGlobals {$IFNDEF Windows}, BaseUnix {$ENDIF} ;

const
  READ_BYTES = 2048;


function RunShell(Executable: String; Parameters: String;WorkDir:String=''):TStringList;

implementation

function RunShell(Executable: String; Parameters: String;WorkDir:String=''):TStringList;
var aProcess : TProcess;
    bytesRead: Longint;
    aMemStream :TMemoryStream;
    aOutputStringList : TStringList;
    NumBytes: LongInt;
    NextParameter : String;
    inQuotes: Boolean;
    i : integer;
    ngPAWSLIBPATH : String;
    isEscaped : Boolean;
begin
  {$IFNDEF Windows}
  ngPAWSLIBPATH := GetEnvironmentVariable('NGPAWS_LIBPATH');
  if (ngPAWSLIBPATH) = '' then ngPAWSLIBPATH:=ExtractFilePath(fpReadLink('/proc/self/exe'));
  {$ENDIF}

  aMemStream := TMemoryStream.Create();
  bytesRead := 0;
  aProcess := TProcess.Create(nil);
  {$IFNDEF Windows}
  aProcess.Environment.Add('NGPAWS_LIBPATH=' + ngPAWSLIBPATH);
  {$ENDIF}
  aProcess.Executable:=Executable;
  if (WorkDir<>'') then aProcess.CurrentDirectory:=WorkDir;
  inQuotes:= false;
  isEscaped := falsE;
  NextParameter:='';
  for i:=1 to Length(Parameters) do
   begin
    if (Parameters[i]='"') then inQuotes := not inQuotes;
    if (Parameters[i] = ' ') and (not inQuotes) and (not isEscaped) then
    begin
      if NextParameter<>'' then begin aProcess.Parameters.Add(NextParameter);  end;
      NextParameter := '';
    end else NextParameter := NextParameter + Parameters[i];
   end;
   isEscaped:=false;
   if (Parameters[i]='\') then isEscaped := true;
  if NextParameter<>'' then begin aProcess.Parameters.Add(NextParameter); end;

  aProcess.Options := aProcess.Options + [poUsePipes, poNoConsole,poStderrToOutPut];
  aProcess.Execute;
  while True do
    begin
      aMemStream.SetSize(BytesRead + READ_BYTES);
      NumBytes := aProcess.Output.Read((aMemStream.Memory + BytesRead)^, READ_BYTES);
      if NumBytes > 0
      then Inc(BytesRead, NumBytes) else break;
    end;
  aMemStream.SetSize(BytesRead);
  aOutputStringList := TStringList.Create();
  aOutputStringList.LoadFromStream(aMemStream);
  aOutputStringList.Insert(0,Executable + ' ' + Parameters + LF);
  aMemStream.Free();
  aProcess.Free;
  Result := aOutputStringList;
end;

end.
