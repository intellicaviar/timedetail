object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 289
  Width = 247
  object conMaster: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'DataBase=timedetail.s3db')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 22
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 144
    Top = 62
  end
  object tblTimeDetails: TFDTable
    Connection = conMaster
    UpdateOptions.UpdateTableName = 'timedetail'
    TableName = 'timedetail'
    Left = 64
    Top = 206
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
    object tblTimeDetailsDuration: TIntegerField
      FieldName = 'Duration'
    end
  end
end
