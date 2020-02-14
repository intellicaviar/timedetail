program timedetail;

uses
  Vcl.Forms,
  FMain in 'FMain.pas' {Form2},
  DData in 'DData.pas' {dmData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
