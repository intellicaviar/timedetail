object fraSettings: TfraSettings
  Left = 0
  Top = 0
  Width = 366
  Height = 231
  TabOrder = 0
  DesignSize = (
    366
    231)
  object edtMaxIdleTime: TLabeledEdit
    Left = 202
    Top = 78
    Width = 50
    Height = 21
    Alignment = taRightJustify
    Anchors = []
    EditLabel.Width = 145
    EditLabel.Height = 13
    EditLabel.Caption = 'Maximale Inaktivit'#228'tszeit (sek)'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 0
    Text = '60'
    OnChange = edtMaxIdleTimeChange
  end
  object tsAutoStart: TToggleSwitch
    Left = 130
    Top = 20
    Width = 122
    Height = 20
    Alignment = taLeftJustify
    Anchors = []
    StateCaptions.CaptionOn = 'Autostart ein'
    StateCaptions.CaptionOff = 'Autostart aus'
    TabOrder = 1
    OnClick = tsAutoStartClick
  end
  object edtCleanupDays: TLabeledEdit
    Left = 202
    Top = 105
    Width = 50
    Height = 21
    Alignment = taRightJustify
    Anchors = []
    EditLabel.Width = 172
    EditLabel.Height = 13
    EditLabel.Caption = 'Maximales Alter der Eintr'#228'ge (Tage)'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 2
    Text = '60'
    OnChange = edtMaxIdleTimeChange
  end
  object tsStartMinimized: TToggleSwitch
    Left = 116
    Top = 46
    Width = 136
    Height = 20
    Alignment = taLeftJustify
    Anchors = []
    StateCaptions.CaptionOn = 'Minimiert starten'
    StateCaptions.CaptionOff = 'Normal starten'
    TabOrder = 3
    OnClick = tsAutoStartClick
  end
end
