object modify: Tmodify
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #20462#25913
  ClientHeight = 288
  ClientWidth = 180
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object group: TGroupBox
    Left = 4
    Top = 8
    Width = 167
    Height = 273
    Caption = #25903#20986#35760#24405#20462#25913
    Color = clBtnHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Label5: TLabel
      Left = 8
      Top = 25
      Width = 36
      Height = 13
      Caption = #26085#26399#65306
    end
    object Label6: TLabel
      Left = 8
      Top = 55
      Width = 36
      Height = 13
      Caption = #39033#30446#65306
    end
    object Label7: TLabel
      Left = 8
      Top = 86
      Width = 36
      Height = 13
      Caption = #37329#39069#65306
    end
    object Label8: TLabel
      Left = 8
      Top = 113
      Width = 36
      Height = 13
      Caption = #22791#27880#65306
    end
    object Label13: TLabel
      Left = 144
      Top = 86
      Width = 12
      Height = 13
      Caption = #20803
    end
    object mDate: TDateTimePicker
      Left = 55
      Top = 22
      Width = 102
      Height = 21
      Date = 39714.627739976850000000
      Time = 39714.627739976850000000
      TabOrder = 0
    end
    object mClass: TComboBox
      Left = 55
      Top = 52
      Width = 102
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
    object mMoney: TEdit
      Left = 55
      Top = 82
      Width = 82
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object mAbout: TMemo
      Left = 8
      Top = 135
      Width = 150
      Height = 89
      TabOrder = 3
    end
    object BtnMod: TBitBtn
      Left = 32
      Top = 231
      Width = 97
      Height = 33
      Caption = '     '#20462#25913
      Default = True
      TabOrder = 4
      OnClick = BtnModClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
