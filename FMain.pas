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
  JvExDBGrids, JvDBGrid;

type
//  TTimeDetailOptions = class(TOptionen)
//  private
//    FMaxIdleTime: TOptionInteger;
//    FDatafile: TOptionFileName;
//    procedure SetDatafile(const Value: TOptionFileName);
//    procedure SetMaxIdleTime(const Value: TOptionInteger);
//  public
//    procedure SetDefault; override;
//  published
//    property MaxIdleTime: TOptionInteger read FMaxIdleTime write SetMaxIdleTime;
//    property Datafile: TOptionFileName read FDatafile write SetDatafile;
//
//  end;


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
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    tblTimeDetails: TFDTable;
    tblTimeDetailsFrom: TDateTimeField;
    tblTimeDetailsTo: TDateTimeField;
    tblTimeDetailsTitle: TStringField;
    srcTimeDetails: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    tblTimeDetailsApplication: TStringField;
    tblTimeDetailsMachine: TStringField;
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ckbActiveClick(Sender: TObject);
    procedure tmMainTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
  private
    FCurrentTitle: string;
    FIdleSince: integer;
    FCurrentTitleSince: TDateTime;
//    VOptions: TTimeDetailOptions;
    FCurrentApplication: string;
    procedure SetCurrentTitle(const Value: string);
    procedure SetIdleSince(const Value: integer);
    procedure SetCurrentTitleSince(const Value: TDateTime);
    procedure ItemChanged(_Title: string; _Since: TDateTime);
    procedure NewTimeDetailRecord(_Title: string; _F: TDateTime; _T: TDateTime);
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

procedure TfrmMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
//  TLogger<TLogEntry>.Instance.Log('TfrmMain.ApplicationEvents1Exception', E);
end;

procedure TfrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon1.Visible := True;
end;

procedure TfrmMain.ckbActiveClick(Sender: TObject);
begin
  ckbActive.Checked:= not  ckbActive.Checked;
  tmMain.Enabled:= ckbActive.Checked;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
//  FDConnection1.DriverName := 'SQLite';
//  FDConnection1.Params.Values['Database'] :=  'timedetails.s3db';
  FDConnection1.Open;
  try
    tblTimeDetails.CreateTable(false, [tpTable]);
  except

  end;
  tblTimeDetails.Active:= true;
end;

procedure TfrmMain.ItemChanged(_Title: string; _Since: TDateTime);
var
  nw: TDateTime;
begin
  if (_Title <> '') and (_Since > 0) then begin
    nw:= Now;
    NewTimeDetailRecord(_Title, _Since, nw);
    _Title:= '';
    _Since:= 0;
  end;
end;

procedure TfrmMain.NewTimeDetailRecord;
var
  x: TTimeDetailRecord;
begin
  x.Title:= _Title;
  x.FromDT:= _F;
  x.ToDT:= _T;

  tblTimeDetails.Insert;
  try
    x.Title:= _Title;
    x.FromDT:= _F;
    x.ToDT:= _T;
  finally
    tblTimeDetails.Post;
  end;
end;

procedure TfrmMain.SetCurrentApplication(const Value: string);
begin
  if FCurrentApplication <> Value then begin
    ItemChanged(FCurrentTitle, FCurrentTitleSince);
    FCurrentApplication := Value;
  end;
end;

procedure TfrmMain.SetCurrentTitle(const Value: string);
begin
  if FCurrentTitle <> Value then begin
    ItemChanged(FCurrentTitle, FCurrentTitleSince);
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
  if FIdleSince > StrToInt(edtMaxIdleTime.Text) then begin
    ItemChanged(FCurrentTitle, FCurrentTitleSince);
  end;
end;

procedure TfrmMain.tmMainTimer(Sender: TObject);
var
  hwndForeground: HWND;
  titleLength: Integer;
  title: string;
  liInfo: TLastInputInfo;
  pid     : DWORD;
  hProcess: THandle;
  path    : array[0..4095] of Char;
begin

  hwndForeground := GetForegroundWindow();
  titleLength := GetWindowTextLength(hwndForeground);
  if titleLength > 0 then begin
    SetLength(title, titleLength);
    GetWindowText(hwndForeground, PChar(title), titleLength + 1);
    CurrentTitle := PChar(title);
  end;


  liInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(liInfo);
  IdleSince := (GetTickCount - liInfo.dwTime) DIV 1000;

  GetWindowThreadProcessId(hwndForeground, pid);
//  GetWindowModuleFileName(hwndForeground, )
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, FALSE, pid);
  if hProcess <> 0 then
    try
      GetModuleFileNameEx(hProcess, 0, @path[0], Length(path));
      CurrentApplication := path;

    finally
      CloseHandle(hProcess);
    end
  else

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
