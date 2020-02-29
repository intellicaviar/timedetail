unit FrTimedetailView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, VCL.Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, Vcl.Controls, Vcl.ExtCtrls, VCLTee.TeEngine,
  VCLTee.TeeFunci, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  VCLTee.TeeDBCrossTab, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.WinXCalendars, Vcl.StdCtrls, Vcl.WinXCtrls, System.Classes;

type
  TfraTimeDetailView = class(TFrame)
    quTimedetail: TFDQuery;
    dsTDQU: TDataSource;
    quTimedetailFROMDT: TDateTimeField;
    quTimedetailTODT: TDateTimeField;
    quTimedetailTITLE: TStringField;
    quTimedetailAPPLICATION: TStringField;
    quTimedetailMACHINE: TStringField;
    quTimedetailDURATION: TIntegerField;
    quTimedetailLOCATION: TStringField;
    GridPanel1: TGridPanel;
    sbText: TSearchBox;
    cpDate: TCalendarPicker;
    DBCrossTabSource1: TDBCrossTabSource;
    Panel1: TPanel;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DBChart1: TDBChart;
    Series1: TPieSeries;
    TeeFunction1: TAddTeeFunction;
    Splitter1: TSplitter;
    procedure cpDateChange(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure quTimedetailAPPLICATIONGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure sbTextInvokeSearch(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure Refresh;
    { Public-Deklarationen }
  end;

implementation

uses
  System.DateUtils;

{$R *.dfm}

procedure TfraTimeDetailView.cpDateChange(Sender: TObject);
begin
  Refresh;
end;

procedure TfraTimeDetailView.FrameEnter(Sender: TObject);
begin
  cpDate.Date:= Date;
  sbText.Text:= '';
  Refresh;
end;

procedure TfraTimeDetailView.quTimedetailAPPLICATIONGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if DisplayText then begin
    Text:= ExtractFileName(quTimedetailAPPLICATION.Value);
  end else begin
    Text:= quTimedetailAPPLICATION.Value;
  end;
end;

procedure TfraTimeDetailView.Refresh;
begin
  with quTimedetail do begin
    if sbText.Text = '' then begin
      quTimedetail.ParamByName('TXT').AsString:= '%';
    end else begin
      quTimedetail.ParamByName('TXT').AsString:= '%'+sbText.Text+'%';
    end;
    quTimedetail.ParamByName('MINDT').AsDateTime:= StartOfTheDay(cpDate.Date);
    quTimedetail.ParamByName('MAXDT').AsDateTime:= EndOfTheDay(cpDate.Date);
    if Active then begin
      Refresh;
      DBChart1.RefreshData;
    end else begin
      Open;
    end;
  end;
end;

procedure TfraTimeDetailView.sbTextInvokeSearch(Sender: TObject);
begin
  Refresh;
end;

end.
