unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  JvExDBGrids, JvDBGrid, DData;

type
  TTimeDetailRecord = record
    Title: string;
    FromDT: TDateTime;
    ToDT: TDateTime;
  end;

  TfrmMain = class(TForm)
    tmMain: TTimer;
    ApplicationEvents1: TApplicationEvents;
    Panel1: TPanel;
    ckbActive: TCheckBox;
    edtMaxIdleTime: TEdit;
    Label1: TLabel;
    TrayIcon1: TTrayIcon;
    srcTimeDetails: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    procedure ckbActiveClick(Sender: TObject);
    procedure tmMainTimer(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
  private
    FCurrentTitle: string;
    FIdleSince: integer;
    FCurrentTitleSince: TDateTime;
    FCurrentApplication: string;
    procedure SetCurrentTitle(const Value: string);
    procedure SetIdleSince(const Value: integer);
    procedure SetCurrentTitleSince(const Value: TDateTime);
    procedure ItemChanged;

    procedure SetCurrentApplication(const Value: string);
    { Private-Deklarationen }
  public
    property CurrentTitle: string read FCurrentTitle write SetCurrentTitle;
    property CurrentApplication: string read FCurrentApplication write SetCurrentApplication;
    property CurrentTitleSince: TDateTime read FCurrentTitleSince write SetCurrentTitleSince;
    property IdleSince: integer read FIdleSince write SetIdleSince;
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

uses System.DateUtils, Winapi.PsAPI;

{$R *.dfm}

procedure TfrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon1.Visible := True;
end;

procedure TfrmMain.ckbActiveClick(Sender: TObject);
begin
  ckbActive.Checked:= not ckbActive.Checked;
  tmMain.Enabled:= ckbActive.Checked;
end;

procedure TfrmMain.ItemChanged;
begin
  if (CurrentTitle <> '') and (CurrentTitleSince > 0) then begin
    dmData.NewTimeDetailRecord(CurrentTitle, CurrentApplication, CurrentTitleSince, Now);
    FCurrentTitle:= '';
    FCurrentApplication:= '';
    FCurrentTitleSince:= 0;
  end;
end;

procedure TfrmMain.SetCurrentApplication(const Value: string);
begin
  if FCurrentApplication <> Value then begin
    FCurrentApplication := Value;
  end;
end;

procedure TfrmMain.SetCurrentTitle(const Value: string);
begin
  if FCurrentTitle <> Value then begin
    FCurrentTitle := Value;
    FCurrentTitleSince:= now;
  end;
end;

procedure TfrmMain.SetCurrentTitleSince(const Value: TDateTime);
begin
  FCurrentTitleSince := Value;
end;

procedure TfrmMain.SetIdleSince(const Value: integer);
begin
  FIdleSince := Value;
end;

procedure TfrmMain.tmMainTimer(Sender: TObject);
var
  hwndForeground: HWND;
  titleLength: Integer;
  path, title: string;
  liInfo: TLastInputInfo;
  pid     : DWORD;
  hProcess: THandle;
  patha    : array[0..4095] of Char;
begin
  hwndForeground := GetForegroundWindow();
  titleLength := GetWindowTextLength(hwndForeground);
  if titleLength > 0 then begin
    SetLength(title, titleLength);
    GetWindowText(hwndForeground, PChar(title), titleLength + 1);
  end;


  liInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(liInfo);
  IdleSince := (GetTickCount - liInfo.dwTime) DIV 1000;

  GetWindowThreadProcessId(hwndForeground, pid);
//  GetWindowModuleFileName(hwndForeground, )
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, FALSE, pid);
  if hProcess <> 0 then begin
    try
      GetModuleFileNameEx(hProcess, 0, @patha[0], Length(patha));
      path := patha;
    finally
      CloseHandle(hProcess);
    end
  end else begin

  end;

  if (path <> CurrentApplication) or
     (title <> CurrentTitle) or
     (FIdleSince > StrToInt(edtMaxIdleTime.Text)) then begin
    ItemChanged;
    CurrentApplication:= path;
    CurrentTitle:= title;

  end;


end;

procedure TfrmMain.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

{ TTimeDetailOptions }

//procedure TTimeDetailOptions.SetDatafile(const Value: TOptionFileName);
//begin
//  FDatafile := Value;
//end;
//
//procedure TTimeDetailOptions.SetDefault;
//begin
//  inherited;
//
//end;
//
//procedure TTimeDetailOptions.SetMaxIdleTime(const Value: TOptionInteger);
//begin
//  FMaxIdleTime := Value;
//end;

end.
