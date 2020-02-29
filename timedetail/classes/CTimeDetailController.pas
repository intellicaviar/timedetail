unit CTimeDetailController;

interface

uses
  CCurrentAppData, System.Classes, System.Sensors, System.Sensors.Components;

type
  TStorageCallback = reference to procedure (_FromDT, _ToDT: TDateTime; const _AppName, _Title, _Device: string; _Address: string);

type
  TCollectorThread = class(TThread)
  private
    VCollector: TCurrentAppData;
    VIdleStored: boolean;
    FTitle: string;
    FAppName: string;
    FStart: TDateTime;
    VStorageCallback: TStorageCallback;
    FDoCollect: boolean;
    procedure SetDoCollect(const Value: boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(_Collector: TCurrentAppDataClass; _StorageCallback: TStorageCallback);
    destructor Destroy; override;
    property DoCollect: boolean read FDoCollect write SetDoCollect;
  end;

  TTimeDetailController = class
  private
    VCollectorThread: TCollectorThread;
    VStorageCallback: TStorageCallback;
    FDoCollect: boolean;
    FAutoStart: boolean;
    FMaxIdleTime: integer;
    FCleanupDays: integer;
    VLocation: TLocationSensor;
    VLocationStr: string;
    FMinimizedStart: boolean;
    procedure LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
    procedure SetDoCollect(const Value: boolean);
    procedure SetAutoStart(const Value: boolean);
    procedure SetMaxIdleTime(const Value: integer);
    procedure SetCleanupDays(const Value: integer);
    procedure NewData(_FromDT, _ToDT: TDateTime; const _AppName, _Title, _Device: string; _Address: string);
    procedure SetMinimizedStart(const Value: boolean);
  public
    constructor Create(_Collector: TCurrentAppDataClass; _StorageCallback: TStorageCallback);
    procedure Start;
    procedure Stop;
    destructor Destroy; override;
    procedure ReadSettings;
    procedure WriteSettings;

  published
    property DoCollect: boolean read FDoCollect write SetDoCollect;
    property AutoStart: boolean read FAutoStart write SetAutoStart;
    property MinimizedStart: boolean read FMinimizedStart write SetMinimizedStart;
    property CleanupDays: integer read FCleanupDays write SetCleanupDays;
    property MaxIdleTime: integer read FMaxIdleTime write SetMaxIdleTime;
  end;


var
  TDC: TTimeDetailController;

implementation

uses
  System.SysUtils, System.Win.Registry, Vcl.Forms;


{ TTimeDetailController }

constructor TTimeDetailController.Create(_Collector: TCurrentAppDataClass; _StorageCallback: TStorageCallback);
begin
  inherited Create;
  VStorageCallBack:= _StorageCallback;
  VCollectorThread:= TCollectorThread.Create(_Collector, NewData);
  VLocation:= TLocationSensor.Create(nil);
  VLocation.OnLocationChanged:= LocationChanged;
end;

destructor TTimeDetailController.Destroy;
begin
  VCollectorThread.Terminate;
  Sleep(333);
  VCollectorThread.Free;
  VLocation.Free;
  inherited;
end;

procedure TTimeDetailController.LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  VLocationStr:= NewLocation.Latitude.ToString+', '+NewLocation.Longitude.ToString;
  {TODO -ophilipp -cGeneral : geocoder einbauen lt beispiel}
end;

procedure TTimeDetailController.NewData(_FromDT, _ToDT: TDateTime;
  const _AppName, _Title, _Device: string;
  _Address: string);
begin
  VStorageCallback(_FromDT, _ToDT, _AppName, _Title, _Device, VLocationStr);
end;

procedure TTimeDetailController.ReadSettings;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create;
  try
    if reg.OpenKey('\SOFTWARE\timedetail\', true) then begin
      if reg.ValueExists('DoCollect') then begin
        FDoCollect:= reg.ReadBool('DoCollect');
      end else begin
        FDoCollect:= true;
      end;
      if reg.ValueExists('MinimizedStart') then begin
        FMinimizedStart:= reg.ReadBool('MinimizedStart');
      end else begin
        FMinimizedStart:= true;
      end;

      if reg.ValueExists('MaxIdleTime') then begin
        FMaxIdleTime:= reg.ReadInteger('MaxIdleTime');
      end else begin
        FMaxIdleTime:= 60;
      end;
      if reg.ValueExists('CleanupDays') then begin
        FCleanupDays:= reg.ReadInteger('CleanupDays');
      end else begin
        FCleanupDays:= 60;
      end;
    end;
    reg.CloseKey;
    if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', false) then begin
      FAutoStart:= reg.ReadString('timedetail') <> '';
    end;
  finally
    reg.Free;
  end;
end;

procedure TTimeDetailController.SetAutoStart(const Value: boolean);
begin
  FAutoStart := Value;
end;

procedure TTimeDetailController.SetCleanupDays(const Value: integer);
begin
  FCleanupDays := Value;
end;

procedure TTimeDetailController.SetDoCollect(const Value: boolean);
begin
  FDoCollect := Value;
end;

procedure TTimeDetailController.SetMaxIdleTime(const Value: integer);
begin
  FMaxIdleTime := Value;
end;

procedure TTimeDetailController.SetMinimizedStart(const Value: boolean);
begin
  FMinimizedStart := Value;
end;

procedure TTimeDetailController.Start;
begin
  ReadSettings;
  VCollectorThread.DoCollect:= true;
  VLocation.Active:= true;
end;

procedure TTimeDetailController.Stop;
begin
  VLocation.Active:= false;
  VCollectorThread.DoCollect:= false;
end;

procedure TTimeDetailController.WriteSettings;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create;
  try
    if reg.OpenKey('\SOFTWARE\timedetail\', true) then begin
      reg.WriteBool('DoCollect', FDoCollect);
      reg.WriteInteger('MaxIdleTime', FMaxIdleTime);
      reg.WriteBool('MinimizedStart', FMinimizedStart);
    end;
    reg.CloseKey;
    if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', false) then begin
      if FAutoStart then begin
        reg.WriteString('timedetail', Application.ExeName);
      end else begin
        if reg.ValueExists('timedetail') then begin
          reg.DeleteValue('timedetail');
        end;
      end;
    end;
    reg.CloseKey;
  finally
    reg.Free;
  end;
end;

{ TCollectorThread }

constructor TCollectorThread.Create(_Collector: TCurrentAppDataClass; _StorageCallback: TStorageCallback);
begin
  inherited Create;
  FreeOnTerminate:= false;
  VCollector:= _Collector.Create;
  VStorageCallback:= _StorageCallback;
  FStart:= now;
end;

destructor TCollectorThread.Destroy;
begin
  VCollector.Free;
  inherited;
end;

procedure TCollectorThread.Execute;
begin
  inherited;
  while not Terminated do begin
    if DoCollect then begin
      if (VCollector.GatherData) then begin
        if (FAppName <> '') and (FTitle <> '') then begin
          VStorageCallback(FStart, Now, FAppName, FTitle, VCollector.DeviceName, '');
          FStart:= now;
        end;
        FAppName:= VCollector.AppName;
        FTitle:= VCollector.Title;
      end;
      if (VCollector.IdleSince > TDC.MaxIdleTime) then begin
        if (FAppName <> '') and (FTitle <> '') and (not VIdleStored) then begin
          VStorageCallback(FStart, Now, FAppName, FTitle, VCollector.DeviceName, '');
          VIdleStored:= true;
        end;
        FStart:= now;
        FAppName:= VCollector.AppName;
        FTitle:= VCollector.Title;
      end else begin
        VIdleStored:= false;
      end;
      Sleep(333);
    end else begin
      FAppName:= '';
      FTitle:= '';
      FStart:= 0;
      sleep(333);
    end;
  end;
end;

procedure TCollectorThread.SetDoCollect(const Value: boolean);
begin
  FDoCollect := Value;
end;

end.
