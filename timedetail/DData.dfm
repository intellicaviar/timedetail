object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 376
  Width = 361
  object conMaster: TFDConnection
    Params.Strings = (
      'Database=timedetail.db'
      'DateTimeFormat=DateTime'
      'GUIDFormat=Binary'
      'OpenMode=CreateUTF16'
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evDetailCascade]
    FetchOptions.DetailCascade = True
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
    Left = 56
    Top = 190
    object tblTimeDetailsFrom: TDateTimeField
      FieldName = 'FromDT'
    end
    object tblTimeDetailsTo: TDateTimeField
      FieldName = 'ToDT'
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
    object tblTimeDetailsLocation: TStringField
      FieldName = 'Location'
      Size = 40
    end
  end
  object FDTransaction1: TFDTransaction
    Connection = conMaster
    Left = 232
    Top = 80
  end
  object quTimeDetail: TFDQuery
    Connection = conMaster
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'select * from timedetail order by FromDT')
    Left = 136
    Top = 192
  end
end
