program timedetail;

uses
  Vcl.Forms,
  FMain in 'FMain.pas' {fmMain},
  DData in 'DData.pas' {dmData: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  JclAppInst,
  CCurrentAppData in 'classes\CCurrentAppData.pas',
  CCurrentAppDataWindows in 'classes\CCurrentAppDataWindows.pas',
  CTimeDetailController in 'classes\CTimeDetailController.pas',
  DImages in 'DImages.pas' {dmImages: TDataModule},
  FrSettings in 'frames\FrSettings.pas' {fraSettings: TFrame},
  FrTimedetailView in 'frames\FrTimedetailView.pas' {fraTimeDetailView: TFrame},
  FrToday in 'frames\FrToday.pas' {Frame1: TFrame};

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= true;
{$ENDIF}
  JclAppInstances.CheckSingleInstance;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'timedetail';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TdmImages, dmImages);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
