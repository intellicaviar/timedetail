unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.ComCtrls, Vcl.Menus, Vcl.Touch.GestureMgr, System.Actions, Vcl.ActnList,
  Vcl.AppEvnts, Vcl.WinXCtrls, Vcl.CategoryButtons, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, CTimeDetailController, DImages;

type
  TfrmMain = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    Panel1: TPanel;
    ckbActive: TCheckBox;
    edtMaxIdleTime: TEdit;
    Label1: TLabel;
    TrayIcon1: TTrayIcon;
    srcTimeDetails: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    alMain: TActionList;
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
    actLastSevenDays: TAction;
    actInterfaceTimeular: TAction;
    GestureManager1: TGestureManager;
    tsTimedetail: TToggleSwitch;
    actCleanup: TAction;
    actToggle: TAction;
    PopupMenu1: TPopupMenu;
    actToggle1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure pnlMenueClick(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure actToggleExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    VController: TTimeDetailController;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

uses System.DateUtils, DData, CCurrentAppDataWindows;

{$R *.dfm}

procedure TfrmMain.actToggleExecute(Sender: TObject);
begin
  actToggle.Checked:= not actToggle.Checked;
  if actToggle.Checked then begin
    VController.Start;
  end else begin
    VController.Stop;
  end;
end;

procedure TfrmMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
  StatusBar1.SimpleText:= E.Message;
end;

procedure TfrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon1.Visible := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  VController:= TTimeDetailController.Create(TCurrentAppDataWindows, dmData.NewTimeDetailRecord);
  VController.Start;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  VController.Stop;
  VController.Free;
end;

procedure TfrmMain.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EventInfo.GestureID = sgiDown then begin
    ApplicationEvents1Minimize(Sender);
    Handled:= true;
  end;
end;

procedure TfrmMain.pnlMenueClick(Sender: TObject);
begin
  if svMain.Opened then
    svMain.Close
  else
    svMain.Open;
end;

procedure TfrmMain.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlMenueClick(Sender);
end;

procedure TfrmMain.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
