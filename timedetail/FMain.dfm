object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'timedetail'
  ClientHeight = 596
  ClientWidth = 829
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 256
    Top = 527
    Width = 500
    Height = 25
    DataSource = srcTimeDetails
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    Flat = True
    TabOrder = 0
  end
  object svMain: TSplitView
    Left = 0
    Top = 50
    Width = 200
    Height = 527
    CompactWidth = 200
    OpenedWidth = 200
    Placement = svpLeft
    TabOrder = 1
    object CategoryButtons1: TCategoryButtons
      Left = 0
      Top = 0
      Width = 200
      Height = 527
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      ButtonFlow = cbfVertical
      ButtonHeight = 64
      ButtonWidth = 150
      ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions]
      Categories = <
        item
          Caption = 'Eintr'#228'ge'
          Color = 16771818
          Collapsed = False
          Items = <
            item
              Action = actEntriesDay
            end
            item
              Action = actEntriesDays
            end
            item
              Action = actExit
            end>
        end
        item
          Caption = 'Einstellungen'
          Color = 15400959
          Collapsed = False
          Items = <
            item
              Action = actSetup
            end
            item
              Action = actInterfaceTimeular
            end
            item
              Action = actCleanup
            end>
        end>
      Images = dmImages.im32
      RegularButtonColor = clWhite
      SelectedButtonColor = 15132390
      TabOrder = 0
      ExplicitLeft = -6
      ExplicitTop = -6
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblTitle: TLabel
      Left = 69
      Top = 12
      Width = 82
      Height = 21
      Caption = 'Timedetail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlMenue: TPanel
      Left = 0
      Top = 0
      Width = 50
      Height = 50
      Align = alLeft
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      OnClick = pnlMenueClick
      OnMouseEnter = pnlMenueMouseEnter
      OnMouseLeave = pnlMenueMouseLeave
      object Label2: TLabel
        Left = 68
        Top = 12
        Width = 82
        Height = 21
        Caption = 'Timedetail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape1: TShape
        Left = 10
        Top = 10
        Width = 30
        Height = 5
        Pen.Color = clWhite
        OnMouseUp = Shape1MouseUp
      end
      object Shape2: TShape
        Left = 10
        Top = 20
        Width = 30
        Height = 5
        Pen.Color = clWhite
        OnMouseUp = Shape1MouseUp
      end
      object Shape3: TShape
        Left = 10
        Top = 30
        Width = 30
        Height = 5
        Pen.Color = clWhite
        OnMouseUp = Shape1MouseUp
      end
    end
    object tsTimedetail: TToggleSwitch
      Left = 169
      Top = 13
      Width = 50
      Height = 20
      Action = actToggle
      ShowStateCaption = False
      TabOrder = 1
    end
    object Button1: TButton
      Left = 304
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 2
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 577
    Width = 829
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object cpMain: TCardPanel
    Left = 200
    Top = 50
    Width = 629
    Height = 527
    Align = alClient
    ActiveCard = cEntriesDays
    BevelOuter = bvNone
    Caption = 'cpMain'
    TabOrder = 4
    object cEntriesDay: TCard
      Left = 0
      Top = 0
      Width = 629
      Height = 527
      Caption = 'cEntriesDay'
      CardIndex = 0
      TabOrder = 0
    end
    object cSettings: TCard
      Left = 0
      Top = 0
      Width = 629
      Height = 527
      Caption = 'cSettings'
      CardIndex = 1
      TabOrder = 1
      ExplicitLeft = 6
      ExplicitTop = -6
    end
    object cEntriesDays: TCard
      Left = 0
      Top = 0
      Width = 629
      Height = 527
      Caption = 'cEntriesDays'
      CardIndex = 2
      TabOrder = 2
      ExplicitWidth = 185
      ExplicitHeight = 41
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    OnMinimize = ApplicationEvents1Minimize
    Left = 536
    Top = 8
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 672
    Top = 16
  end
  object srcTimeDetails: TDataSource
    Left = 352
    Top = 8
  end
  object alMain: TActionList
    Images = dmImages.im32
    Left = 728
    Top = 120
    object actEntriesDays: TAction
      Caption = 'Tages'#252'bersicht'
      OnExecute = actEntriesDaysExecute
    end
    object actEntriesDay: TAction
      Caption = 'Tag-'#220'bersicht'
      ImageIndex = 7
      OnExecute = actEntriesDayExecute
    end
    object actSetup: TAction
      Caption = 'Einstellungen'
      Checked = True
      ImageIndex = 20
      OnExecute = actSetupExecute
    end
    object actInterfaceTimeular: TAction
      Caption = 'actInterfaceTimeular'
    end
    object actCleanup: TAction
      Caption = 'actCleanup'
    end
    object actToggle: TAction
      Caption = 'Daten sammeln'
      OnExecute = actToggleExecute
    end
    object actExit: TAction
      Caption = 'Beenden'
      OnExecute = actExitExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 744
    Top = 16
    object actToggle1: TMenuItem
      Action = actToggle
    end
    object Beenden1: TMenuItem
      Action = actExit
    end
  end
  object tmEffect: TTimer
    Enabled = False
    Interval = 44
    OnTimer = tmEffectTimer
    Left = 264
    Top = 8
  end
end
