unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls, Vcl.AppEvnts, Vcl.WinXPanels,
  Vcl.Touch.GestureMgr, System.Sensors, System.Sensors.Components;

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
    ActionList1: TActionList;
    actToday: TAction;
    actSetup: TAction;
    svMain: TSplitView;
    CategoryButtons1: TCategoryButtons;
    pnlMain: TPanel;
    pnlMenue: TPanel;
    Label2: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    lblTitle: TLabel;
    CardPanel1: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    Card3: TCard;
    actLastSevenDays: TAction;
    actInterfaceTimeular: TAction;
    GestureManager1: TGestureManager;
    LocationSensor1: TLocationSensor;
    procedure ckbActiveClick(Sender: TObject);
    procedure tmMainTimer(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure pnlMenueClick(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
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

uses System.DateUtils, Winapi.PsAPI, DData;

{$R *.dfm}

procedure TfrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon1.Visible := True;
end;

procedure TfrmMain.ckbActiveClick(Sender: TObject);
begin
  //ckbActive.Checked:= not ckbActive.Checked;
  tmMain.Enabled:= ckbActive.Checked;
end;

procedure TfrmMain.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = sgiDown then begin
    ApplicationEvents1Minimize(Sender);
    Handled:= true;
  end;
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

procedure TfrmMain.pnlMenueClick(Sender: TObject);
begin
  if svMain.Opened then
    svMain.Close
  else
    svMain.Open;
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

procedure TfrmMain.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlMenueClick(Sender);
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
