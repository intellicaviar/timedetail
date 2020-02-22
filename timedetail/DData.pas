unit DData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Dateutils;

type
  TdmData = class(TDataModule)
    conMaster: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    tblTimeDetails: TFDTable;
    tblTimeDetailsFrom: TDateTimeField;
    tblTimeDetailsTo: TDateTimeField;
    tblTimeDetailsTitle: TStringField;
    tblTimeDetailsApplication: TStringField;
    tblTimeDetailsMachine: TStringField;
    tblTimeDetailsDuration: TIntegerField;
    FDTransaction1: TFDTransaction;
    quTimeDetail: TFDQuery;
    tblTimeDetailsLocation: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public

    procedure NewTimeDetailRecord(const _F, _T: TDateTime; const _App, _Title: string);
    { Public-Deklarationen }
  end;



var
  dmData: TdmData;
  dataroot: string;

implementation

uses
  System.IOUtils;

{$R *.dfm}

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  dataroot:= TPath.GetHomePath+TPath.DirectorySeparatorChar+'timedetail'+TPath.DirectorySeparatorChar;
  ForceDirectories(dataroot);
  conMaster.Close;
  conMaster.DriverName:= 'SQLite';
  conMaster.Params.Values['Database']:= dataroot+'timedetail.db';
  conMaster.Open;
  try
    if not tblTimeDetails.Exists then begin
      tblTimeDetails.CreateTable(false, [tpTable, tpPrimaryKey, tpIndexes]);
    end;
  except

  end;
  tblTimeDetails.Active:= true;
  quTimeDetail.Active:= true;
end;

procedure TdmData.NewTimeDetailRecord(const _F, _T: TDateTime; const _App, _Title: string);
begin
  tblTimeDetails.Insert;
  try
    tblTimeDetailsTitle.Value:= _Title;
    tblTimeDetailsApplication.Value:= _App;
    tblTimeDetailsFrom.Value:= _F;
    tblTimeDetailsTo.Value:= _T;
    tblTimeDetailsDuration.Value:= SecondsBetween(_F, _T);
  finally
    tblTimeDetails.Post;
  end;
end;

end.
