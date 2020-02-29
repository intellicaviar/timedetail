unit FrSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.WinXCtrls, Vcl.StdCtrls;

type
  TfraSettings = class(TFrame)
    edtMaxIdleTime: TLabeledEdit;
    tsAutoStart: TToggleSwitch;
    edtCleanupDays: TLabeledEdit;
    tsStartMinimized: TToggleSwitch;
    procedure tsAutoStartClick(Sender: TObject);
    procedure edtMaxIdleTimeChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure ShowSettings;
    { Public-Deklarationen }
  end;

implementation

uses
  CTimeDetailController;

{$R *.dfm}

procedure TfraSettings.edtMaxIdleTimeChange(Sender: TObject);
begin
  TDC.MaxIdleTime:= StrToInt( edtMaxIdleTime.Text );
end;

procedure TfraSettings.ShowSettings;
begin
  edtMaxIdleTime.Text:= TDC.MaxIdleTime.ToString;
  if TDC.AutoStart then begin
    tsAutoStart.State:= tssOn;
  end else begin
    tsAutoStart.State:= tssOff;
  end;
  if TDC.MinimizedStart then begin
    tsStartMinimized.State:= tssOn;
  end else begin
    tsStartMinimized.State:= tssOff;
  end;

end;

procedure TfraSettings.tsAutoStartClick(Sender: TObject);
begin
  TDC.AutoStart:= tsAutoStart.State = tssOn;
end;

end.
