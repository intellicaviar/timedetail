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
    tblTimeDetailsLocation: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public

    procedure NewTimeDetailRecord(_F, _T: TDateTime; const _App, _Title, _Device: string; _Address: string);
    procedure Cleanup(_OlderThan: integer);
    { Public-Deklarationen }
  end;



var
  dmData: TdmData;
  dataroot: string;

implementation

uses
  System.IOUtils;

{$R *.dfm}

procedure TdmData.Cleanup(_OlderThan: integer);
begin
  conMaster.ExecSQL('delete from timedetail where '+
  'FromDT < DATE('+quotedstr('now')+','+QuotedStr('-'+_olderthan.ToString+' day+')+') '+
  ' or FromDT is null or ToDT is null'+
  ' or FromDT = 0 or ToDT = 0'
  );
end;

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
end;

procedure TdmData.NewTimeDetailRecord(_F, _T: TDateTime; const _App, _Title, _Device: string; _Address: string);
begin
  tblTimeDetails.Insert;
  try
    tblTimeDetailsTitle.Value:= _Title;
    tblTimeDetailsApplication.Value:= _App;
    if _F = 0 then begin
      _F:= _T;
    end;
    tblTimeDetailsFrom.Value:= _F;
    tblTimeDetailsTo.Value:= _T;
    tblTimeDetailsDuration.Value:= SecondsBetween(_F, _T);
    tblTimeDetailsMachine.Value:= _Device;
    tblTimeDetailsLocation.Value:= _Address;
  finally
    tblTimeDetails.Post;
  end;
end;

end.
