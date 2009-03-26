object userForm: TuserForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #27880#20876#29992#25143
  ClientHeight = 231
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 215
    Caption = #27880#20876#26032#29992#25143
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 34
      Width = 36
      Height = 13
      Caption = #24080#21495#65306
    end
    object Label2: TLabel
      Left = 36
      Top = 66
      Width = 48
      Height = 13
      Caption = #26087#23494#30721#65306
    end
    object Label3: TLabel
      Left = 36
      Top = 98
      Width = 48
      Height = 13
      Caption = #26032#23494#30721#65306
    end
    object Label4: TLabel
      Left = 24
      Top = 127
      Width = 60
      Height = 13
      Caption = #30830#35748#23494#30721#65306
    end
    object Label5: TLabel
      Left = 24
      Top = 154
      Width = 60
      Height = 13
      Caption = #23494#30721#25552#31034#65306
    end
    object muser: TEdit
      Left = 90
      Top = 31
      Width = 75
      Height = 21
      TabOrder = 0
      Text = 'muser'
    end
    object mpass: TEdit
      Left = 90
      Top = 63
      Width = 121
      Height = 21
      PasswordChar = '#'
      TabOrder = 1
      Text = 'mpass'
    end
    object mpass0: TEdit
      Left = 90
      Top = 95
      Width = 121
      Height = 21
      PasswordChar = '#'
      TabOrder = 2
      Text = 'mpass0'
    end
    object mpass1: TEdit
      Left = 90
      Top = 122
      Width = 121
      Height = 21
      PasswordChar = '#'
      TabOrder = 3
      Text = 'mpass1'
    end
    object BitBtn1: TBitBtn
      Left = 90
      Top = 178
      Width = 75
      Height = 25
      Caption = #30830#23450
      Default = True
      TabOrder = 4
      OnClick = BitBtn1Click
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
    object mtips: TEdit
      Left = 90
      Top = 149
      Width = 143
      Height = 21
      TabOrder = 5
    end
  end
end
