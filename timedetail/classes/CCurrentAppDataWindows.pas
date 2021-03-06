unit CCurrentAppDataWindows;

interface

uses
  CCurrentAppData,  Winapi.Windows;

type
  TCurrentAppDataWindows = class(TCurrentAppData)
  private
    hwndForeground: HWND;
    procedure GetTitle;
    procedure GetLastInput;
    procedure GetApp;
    procedure GetDeviceName;
  public
    function GatherData: boolean; override;
  end;


implementation

uses
  Winapi.PsAPI, System.SysUtils;

{ TCurrentAppDataWindows }

function TCurrentAppDataWindows.GatherData: boolean;
begin
  hwndForeground := GetForegroundWindow();
  GetTitle;
  GetLastInput;
  GetApp;
  GetDeviceName;
  Result:= inherited GatherData;
end;

procedure TCurrentAppDataWindows.GetApp;
var
  pid     : DWORD;
  hProcess: THandle;
  patha    : array[0..4095] of Char;
begin
  GetWindowThreadProcessId(hwndForeground, pid);
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, FALSE, pid);
  if hProcess <> 0 then begin
    try
      GetModuleFileNameEx(hProcess, 0, @patha[0], Length(patha));
      FGDAppName:= patha;
    finally
      CloseHandle(hProcess);
    end
  end;
end;

procedure TCurrentAppDataWindows.GetDeviceName;
var
  cln, cpn: string;
begin
  cln:= GetEnvironmentVariable('CLIENTNAME');
  cpn:= GetEnvironmentVariable('COMPUTERNAME');
  if ((cln = cpn) and (cln <> '') and (cpn <> ''))
      or (cln <> '')
      or (cpn <> '') then begin
    Devicename:= cpn;
  end else begin
    Devicename:= cpn+'-'+cln;
  end;
end;

procedure TCurrentAppDataWindows.GetLastInput;
var
  liInfo: TLastInputInfo;
begin
  liInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(liInfo);
  IdleSince := (GetTickCount - liInfo.dwTime) DIV 1000;
end;

procedure TCurrentAppDataWindows.GetTitle;
var
  titleLength: Integer;
begin
  titleLength := GetWindowTextLength(hwndForeground);
  if titleLength > 0 then begin
    SetLength(FGDTitle, titleLength);
    GetWindowText(hwndForeground, PChar(FGDTitle), titleLength + 1);
  end;
end;

end.
