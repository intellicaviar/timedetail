program timedetail;

uses
  Vcl.Forms,
  FMain in 'FMain.pas' {Form2},
  DData in 'DData.pas' {dmData: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  CCurrentAppData in 'classes\CCurrentAppData.pas',
  CCurrentAppDataWindows in 'classes\CCurrentAppDataWindows.pas',
  CTimeDetailController in 'classes\CTimeDetailController.pas',
  DImages in 'DImages.pas' {dmImages: TDataModule};

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= true;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'timedetail';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmImages, dmImages);
  Application.Run;
end.
