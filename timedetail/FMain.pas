unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.ComCtrls, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.AppEvnts, Vcl.WinXCtrls, Vcl.CategoryButtons, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, CTimeDetailController, DImages,
  FrTimedetailView, FrSettings, Vcl.WinXPanels, System.Sensors,
  System.Sensors.Components;

type
  TfrmMain = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    TrayIcon1: TTrayIcon;
    srcTimeDetails: TDataSource;
    DBNavigator1: TDBNavigator;
    alMain: TActionList;
    actEntriesDay: TAction;
    actSetup: TAction;
    svMain: TSplitView;
    CategoryButtons1: TCategoryButtons;
    pnlMain: TPanel;
    pnlMenue: TPanel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    lblTitle: TLabel;
    actInterfaceTimeular: TAction;
    tsTimedetail: TToggleSwitch;
    actCleanup: TAction;
    actToggle: TAction;
    PopupMenu1: TPopupMenu;
    actToggle1: TMenuItem;
    StatusBar1: TStatusBar;
    cpMain: TCardPanel;
    cEntriesDay: TCard;
    Button1: TButton;
    tmEffect: TTimer;
    cSettings: TCard;
    actExit: TAction;
    Beenden1: TMenuItem;
    actEntriesDays: TAction;
    cEntriesDays: TCard;
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure pnlMenueClick(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actToggleExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure tmEffectTimer(Sender: TObject);
    procedure pnlMenueMouseEnter(Sender: TObject);
    procedure pnlMenueMouseLeave(Sender: TObject);
    procedure actEntriesDayExecute(Sender: TObject);
    procedure actSetupExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actEntriesDaysExecute(Sender: TObject);
  private
    VEffect: (tmFinished, tmClose, tmOpen);
    fraSettings: TfraSettings;
    fraTimeDetailView: TfraTimeDetailView;
    VAllowClose: boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmMain: TfrmMain;

implementation

uses System.DateUtils, DData, CCurrentAppDataWindows;

{$R *.dfm}

procedure TfrmMain.actEntriesDaysExecute(Sender: TObject);
begin
  cpMain.ActiveCard:= cEntriesDays;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  VAllowClose:= true;
  Application.Terminate;
end;

procedure TfrmMain.actSetupExecute(Sender: TObject);
begin
  cpMain.ActiveCard:= cSettings;
end;

procedure TfrmMain.actEntriesDayExecute(Sender: TObject);
begin
  cpMain.ActiveCard:= cEntriesDay;
end;

procedure TfrmMain.actToggleExecute(Sender: TObject);
begin
  actToggle.Checked:= not actToggle.Checked;
  if actToggle.Checked then begin
    TDC.Start;
  end else begin
    TDC.Stop;
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

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= VAllowClose;
  if not CanClose then begin
    ApplicationEvents1Minimize(Sender);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  VAllowClose:= false;
  fraSettings:= TfraSettings.Create(cSettings);
  fraSettings.Parent:= cSettings;
  fraSettings.Align:= alClient;

  fraTimeDetailView:= TfraTimeDetailView.Create(cEntriesDay);
  fraTimeDetailView.Parent:= cEntriesDay;
  fraTimeDetailView.Align:= alClient;

  TDC:= TTimeDetailController.Create(TCurrentAppDataWindows, dmData.NewTimeDetailRecord);
  TDC.ReadSettings;
  fraSettings.ShowSettings;
  if TDC.DoCollect then begin
    TDC.Start;
    actToggle.Checked:= true;
  end else begin
    TDC.Stop;
    actToggle.Checked:= false;
  end;

  if TDC.MinimizedStart then ApplicationEvents1Minimize(Sender);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  TDC.WriteSettings;
  TDC.Stop;
  dmData.Cleanup(TDC.CleanupDays);
  TDC.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  cpMain.ActiveCard:= cEntriesDay;
end;

procedure TfrmMain.pnlMenueClick(Sender: TObject);
begin
  if svMain.Opened then
    svMain.Close
  else
    svMain.Open;
end;

procedure TfrmMain.pnlMenueMouseEnter(Sender: TObject);
begin
  VEffect:= tmClose;
end;

procedure TfrmMain.pnlMenueMouseLeave(Sender: TObject);
begin
  VEffect:= tmOpen;
end;

procedure TfrmMain.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlMenueClick(Sender);
end;

procedure TfrmMain.tmEffectTimer(Sender: TObject);
begin
  case VEffect of
    tmFinished: ;
    tmClose: begin
      Shape1.Top:= Shape1.Top+1;
      Shape3.Top:= Shape3.Top-1;
      if Shape1.Top = 15 then begin
        VEffect:= tmFinished;
      end;
    end;
    tmOpen: begin
      Shape1.Top:= Shape1.Top-1;
      Shape3.Top:= Shape3.Top+1;
      if Shape1.Top = 10 then begin
        VEffect:= tmFinished;
      end;
    end;
  end;
end;

procedure TfrmMain.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
