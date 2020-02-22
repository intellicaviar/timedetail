object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 376
  Width = 361
  object conMaster: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'DataBase=timedetail.s3db')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 40
    Top = 22
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 232
    Top = 22
  end
  object tblTimeDetails: TFDTable
    Connection = conMaster
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'timedetail'
    TableName = 'timedetail'
    Left = 208
    Top = 142
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
  object FDTransaction1: TFDTransaction
    Connection = conMaster
    Left = 64
    Top = 104
  end
end
