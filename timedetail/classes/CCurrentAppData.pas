unit CCurrentAppData;

interface

type
  TCurrentAppData = class abstract(TObject)
  private
    FTitle: string;
    FAppName: string;
    FIdleSince: TDateTime;
    FDeviceName: string;
    procedure SetAppName(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetIdleSince(const Value: TDateTime);
    procedure SetDeviceName(const Value: string);
  protected
    FGDTitle: string;
    FGDAppName: string;
  public
    function GatherData: boolean; virtual;
    property Title: string read FTitle write SetTitle;
    property AppName: string read FAppName write SetAppName;
    property IdleSince: TDateTime read FIdleSince write SetIdleSince;
    property DeviceName: string read FDeviceName write SetDeviceName;
  end;

  TCurrentAppDataClass = class of TCurrentAppData;

implementation

{ TCurrentAppData }

function TCurrentAppData.GatherData: boolean;
begin
  if (FGDTitle <> FTitle) or
     (FGDAppName <> FAppName) then begin
    FTitle:= FGDTitle;
    FAppName:= FGDAppName;
    Result:= true;
  end else begin
    Result:= false;
  end;
end;

procedure TCurrentAppData.SetAppName(const Value: string);
begin
  FAppName := Value;
end;

procedure TCurrentAppData.SetDeviceName(const Value: string);
begin
  FDeviceName := Value;
end;

procedure TCurrentAppData.SetIdleSince(const Value: TDateTime);
begin
  FIdleSince := Value;
end;

procedure TCurrentAppData.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

end.
