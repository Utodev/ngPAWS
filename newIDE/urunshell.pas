unit URunShell;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, Process;

const
  READ_BYTES = 2048;


function RunShell(Executable: String; Parameters: String):TStringList;

implementation

function RunShell(Executable: String; Parameters: String):TStringList;
var aProcess : TProcess;
    bytesRead: Longint;
    aMemStream :TMemoryStream;
    aOutputStringList : TStringList;
    NumBytes: LongInt;
begin
  aMemStream := TMemoryStream.Create();
  bytesRead := 0;
  aProcess := TProcess.Create(nil);
  aProcess.Executable:=Executable;
  aProcess.Parameters.Add(Parameters);
  aProcess.Options := aProcess.Options + [poUsePipes, poNoConsole];
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
  aMemStream.Free();
  aProcess.Free;
  aOutputStringList.Insert(0,Executable + ' ' + Parameters);
  Result := aOutputStringList;
end;

end.

