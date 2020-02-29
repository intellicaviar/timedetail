object fraTimeDetailView: TfraTimeDetailView
  Left = 0
  Top = 0
  Width = 816
  Height = 627
  TabOrder = 0
  OnEnter = FrameEnter
  object Splitter1: TSplitter
    Left = 0
    Top = 453
    Width = 816
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 49
    ExplicitWidth = 407
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 816
    Height = 49
    Align = alTop
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = sbText
        Row = 0
      end
      item
        Column = 0
        Control = cpDate
        Row = 0
      end>
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 0
    ExplicitWidth = 715
    object sbText: TSearchBox
      Left = 413
      Top = 11
      Width = 392
      Height = 27
      Align = alClient
      TabOrder = 0
      Text = 'sbText'
      OnInvokeSearch = sbTextInvokeSearch
      ExplicitLeft = 362
      ExplicitWidth = 342
      ExplicitHeight = 21
    end
    object cpDate: TCalendarPicker
      Left = 11
      Top = 11
      Width = 392
      Height = 27
      Align = alClient
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Date = 43890.000000000000000000
      FirstDayOfWeek = dwMonday
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      IsEmpty = False
      OnChange = cpDateChange
      ParentFont = False
      TabOrder = 1
      TextHint = 'Datum ausw'#228'hlen'
      ExplicitWidth = 341
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 456
    Width = 816
    Height = 171
    Align = alBottom
    TabOrder = 1
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 145
      Width = 814
      Height = 25
      DataSource = dsTDQU
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbCancel, nbRefresh]
      Align = alBottom
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 149
      ExplicitWidth = 694
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 814
      Height = 144
      Align = alClient
      DataSource = dsTDQU
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 816
    Height = 404
    Align = alClient
    TabOrder = 2
    ExplicitLeft = -1
    ExplicitTop = 44
    ExplicitHeight = 407
    object DBChart1: TDBChart
      Left = 1
      Top = 1
      Width = 814
      Height = 402
      BackImage.Inside = True
      SubTitle.Visible = False
      Title.Text.Strings = (
        'TDBChart')
      Title.Visible = False
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      View3DWalls = False
      Zoom.FullRepaint = True
      Align = alClient
      TabOrder = 0
      AutoSize = True
      ExplicitLeft = 0
      ExplicitTop = 0
      DefaultCanvas = 'TTeeCanvas3D'
      PrintMargins = (
        15
        25
        15
        25)
      ColorPaletteIndex = 17
      object Series1: TPieSeries
        DataSource = quTimedetail
        Title = 'Gruppiert nach Anwendung'
        XLabelsSource = '#SORTASC#APPLICATION'
        XValues.Order = loNone
        YValues.Name = 'Pie'
        YValues.Order = loNone
        YValues.ValueSource = '#SUM#DURATION'
        Frame.InnerBrush.BackColor = clRed
        Frame.InnerBrush.Gradient.EndColor = clGray
        Frame.InnerBrush.Gradient.MidColor = clWhite
        Frame.InnerBrush.Gradient.StartColor = 4210752
        Frame.InnerBrush.Gradient.Visible = True
        Frame.MiddleBrush.BackColor = clYellow
        Frame.MiddleBrush.Gradient.EndColor = 8553090
        Frame.MiddleBrush.Gradient.MidColor = clWhite
        Frame.MiddleBrush.Gradient.StartColor = clGray
        Frame.MiddleBrush.Gradient.Visible = True
        Frame.OuterBrush.BackColor = clGreen
        Frame.OuterBrush.Gradient.EndColor = 4210752
        Frame.OuterBrush.Gradient.MidColor = clWhite
        Frame.OuterBrush.Gradient.StartColor = clSilver
        Frame.OuterBrush.Gradient.Visible = True
        Frame.Width = 4
        OtherSlice.Value = 10.000000000000000000
        object TeeFunction1: TAddTeeFunction
          CalcByValue = False
        end
      end
    end
  end
  object quTimedetail: TFDQuery
    Connection = dmData.conMaster
    SQL.Strings = (
      'select * from timedetail'
      'where (FromDT between :MinDT and :MaxDT'
      'or ToDT between :MinDT and :MaxDT)'
      'and'
      '('
      'Title like :Txt'
      'or Application like :Txt'
      ')'
      ''
      'order by FromDT'
      '')
    Left = 192
    ParamData = <
      item
        Name = 'MINDT'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MAXDT'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TXT'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object quTimedetailFROMDT: TDateTimeField
      DisplayLabel = 'Von'
      FieldName = 'FROMDT'
      Origin = 'FROMDT'
    end
    object quTimedetailTODT: TDateTimeField
      DisplayLabel = 'Bis'
      FieldName = 'TODT'
      Origin = 'TODT'
    end
    object quTimedetailDURATION: TIntegerField
      DisplayLabel = 'Dauer'
      FieldName = 'DURATION'
      Origin = 'DURATION'
    end
    object quTimedetailTITLE: TStringField
      DisplayLabel = 'Titel'
      DisplayWidth = 40
      FieldName = 'TITLE'
      Origin = 'TITLE'
      Size = 255
    end
    object quTimedetailAPPLICATION: TStringField
      DisplayLabel = 'Anwendung'
      DisplayWidth = 40
      FieldName = 'APPLICATION'
      Origin = 'APPLICATION'
      OnGetText = quTimedetailAPPLICATIONGetText
      Size = 255
    end
    object quTimedetailMACHINE: TStringField
      DisplayLabel = 'Ger'#228't'
      DisplayWidth = 30
      FieldName = 'MACHINE'
      Origin = 'MACHINE'
      Size = 255
    end
    object quTimedetailLOCATION: TStringField
      DisplayLabel = 'Ort'
      DisplayWidth = 30
      FieldName = 'LOCATION'
      Origin = 'LOCATION'
      Size = 40
    end
  end
  object dsTDQU: TDataSource
    DataSet = quTimedetail
    Left = 272
  end
  object DBCrossTabSource1: TDBCrossTabSource
    DataSet = quTimedetail
    Left = 96
  end
end
