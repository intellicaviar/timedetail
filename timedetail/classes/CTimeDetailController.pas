unit CTimeDetailController;

interface

uses
  CCurrentAppData, System.Classes;

type
  TStorageCallback = reference to procedure (const _FromDT, _ToDT: TDateTime; const _AppName, _Title: string);

type
  TCollectorThread = class(TThread)
  private
    VCollector: TCurrentAppData;
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
  public
    constructor Create(_Collector: TCurrentAppDataClass; _StorageCallback: TStorageCallback);
    procedure Start;
    procedure Stop;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;


{ TTimeDetailController }

constructor TTimeDetailController.Create(_Collector: TCurrentAppDataClass; _StorageCallback: TStorageCallback);
begin
  VCollectorThread:= TCollectorThread.Create(_Collector, _StorageCallback)
end;

destructor TTimeDetailController.Destroy;
begin
  VCollectorThread.Terminate;
  Sleep(333);
  VCollectorThread.Free;
  inherited;
end;

procedure TTimeDetailController.Start;
begin
  VCollectorThread.DoCollect:= true;
end;

procedure TTimeDetailController.Stop;
begin
  VCollectorThread.DoCollect:= false;
end;

{ TCollectorThread }

constructor TCollectorThread.Create(_Collector: TCurrentAppDataClass; _StorageCallback: TStorageCallback);
begin
  inherited Create;
  FreeOnTerminate:= false;
  VCollector:= _Collector.Create;
  VStorageCallback:= _StorageCallback;
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
      if VCollector.GatherData then begin
        if (FAppName <> '') and (FTitle <> '') then begin
          VStorageCallback(FStart, Now, FAppName, FTitle);
          FStart:= now;
        end;
        FAppName:= VCollector.AppName;
        FTitle:= VCollector.Title;
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
