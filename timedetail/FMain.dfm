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
  Touch.GestureManager = GestureManager1
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnGesture = FormGesture
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 224
    Top = 112
    Width = 161
    Height = 303
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 37
      Width = 68
      Height = 13
      Caption = 'Max. Idle time'
    end
    object ckbActive: TCheckBox
      Left = -8
      Top = 14
      Width = 137
      Height = 17
      Caption = 'Timedetail active'
      Checked = True
      State = cbChecked
      TabOrder = 0
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
    Left = 256
    Top = 527
    Width = 500
    Height = 25
    DataSource = srcTimeDetails
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    Flat = True
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 391
    Top = 58
    Width = 662
    Height = 403
    DataSource = srcTimeDetails
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object svMain: TSplitView
    Left = 0
    Top = 52
    Width = 200
    Height = 525
    CompactWidth = 200
    OpenedWidth = 200
    Placement = svpLeft
    TabOrder = 3
    Touch.GestureManager = GestureManager1
    ExplicitHeight = 508
    object CategoryButtons1: TCategoryButtons
      Left = 0
      Top = 0
      Width = 200
      Height = 525
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      ButtonFlow = cbfVertical
      ButtonWidth = 150
      ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions]
      Categories = <
        item
          Caption = 'Eintr'#228'ge'
          Color = 16771818
          Collapsed = False
          Items = <
            item
              Action = actToday
            end
            item
              Action = actLastSevenDays
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
      RegularButtonColor = clWhite
      SelectedButtonColor = 15132390
      TabOrder = 0
      Touch.GestureManager = GestureManager1
      ExplicitHeight = 508
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 829
    Height = 52
    Align = alTop
    TabOrder = 4
    ExplicitWidth = 823
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
      Left = 1
      Top = 1
      Width = 50
      Height = 50
      Align = alLeft
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      OnClick = pnlMenueClick
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
      object Shape4: TShape
        Left = 248
        Top = 10
        Width = 30
        Height = 5
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape5: TShape
        Left = 248
        Top = 20
        Width = 30
        Height = 5
        Pen.Style = psClear
        Pen.Width = 0
      end
      object Shape6: TShape
        Left = 248
        Top = 30
        Width = 30
        Height = 5
        Pen.Style = psClear
        Pen.Width = 0
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
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 577
    Width = 829
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 344
    ExplicitTop = 488
    ExplicitWidth = 0
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    OnMinimize = ApplicationEvents1Minimize
    Left = 120
    Top = 456
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 136
    Top = 368
  end
  object srcTimeDetails: TDataSource
    DataSet = dmData.quTimeDetail
    Left = 352
    Top = 8
  end
  object alMain: TActionList
    Images = dmImages.im32
    Left = 256
    Top = 456
    object actToday: TAction
      Caption = 'Heute'
      ImageIndex = 16
    end
    object actLastSevenDays: TAction
      Caption = '-7 Tage'
    end
    object actSetup: TAction
      Caption = 'Einstellungen'
      Checked = True
      ImageIndex = 20
    end
    object actInterfaceTimeular: TAction
      Caption = 'actInterfaceTimeular'
    end
    object actCleanup: TAction
      Caption = 'actCleanup'
    end
    object actToggle: TAction
      Caption = 'actToggle'
      OnExecute = actToggleExecute
    end
  end
  object GestureManager1: TGestureManager
    Left = 440
    Top = 8
    GestureData = <
      item
        Control = Owner
        Collection = <
          item
            GestureID = sgiDown
          end>
      end
      item
        Control = svMain
        Collection = <>
      end
      item
        Control = CategoryButtons1
        Collection = <>
      end>
  end
  object PopupMenu1: TPopupMenu
    Left = 424
    Top = 352
    object actToggle1: TMenuItem
      Action = actToggle
    end
  end
end
