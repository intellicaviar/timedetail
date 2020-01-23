object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Timedetail'
  ClientHeight = 428
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 403
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 37
      Width = 68
      Height = 13
      Caption = 'Max. Idle time'
    end
    object ckbActive: TCheckBox
      Left = 8
      Top = 14
      Width = 137
      Height = 17
      Caption = 'Timedetail active'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = ckbActiveClick
    end
    object edtMaxIdleTime: TEdit
      Left = 8
      Top = 56
      Width = 145
      Height = 21
      NumbersOnly = True
      TabOrder = 1
      Text = '60'
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 403
    Width = 823
    Height = 25
    DataSource = srcTimeDetails
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    Align = alBottom
    Flat = True
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 161
    Top = 0
    Width = 662
    Height = 403
    Align = alClient
    DataSource = srcTimeDetails
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object tmMain: TTimer
    OnTimer = tmMainTimer
    Left = 16
    Top = 224
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    OnMinimize = ApplicationEvents1Minimize
    Left = 80
    Top = 160
  end
  object TrayIcon1: TTrayIcon
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 16
    Top = 160
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'DataBase=timedetail.s3db')
    LoginPrompt = False
    Left = 80
    Top = 232
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 96
    Top = 288
  end
  object tblTimeDetails: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'timedetail'
    TableName = 'timedetail'
    Left = 80
    Top = 352
    object tblTimeDetailsFrom: TDateTimeField
      FieldName = 'From'
    end
    object tblTimeDetailsTo: TDateTimeField
      FieldName = 'To'
    end
    object tblTimeDetailsTitle: TStringField
      FieldName = 'Title'
      Size = 255
    end
    object tblTimeDetailsApplication: TStringField
      FieldName = 'Application'
      Size = 255
    end
    object tblTimeDetailsMachine: TStringField
      FieldName = 'Machine'
      Size = 255
    end
  end
  object srcTimeDetails: TDataSource
    DataSet = tblTimeDetails
    Left = 24
    Top = 312
  end
end
