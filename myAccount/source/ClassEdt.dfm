object classFrm: TclassFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #25910#20837'/'#25903#20986#39033#30446#31649#29702
  ClientHeight = 299
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object groupbox1: TGroupBox
    Left = 8
    Top = 8
    Width = 161
    Height = 283
    Caption = #25903#20986#39033#30446
    TabOrder = 0
    object outListBox: TListBox
      Left = 16
      Top = 24
      Width = 129
      Height = 216
      ItemHeight = 13
      TabOrder = 0
    end
    object outBtnAdd: TBitBtn
      Left = 16
      Top = 246
      Width = 41
      Height = 25
      Caption = #26032#22686
      TabOrder = 1
      OnClick = outBtnAddClick
    end
    object outBtnEdt: TBitBtn
      Left = 60
      Top = 246
      Width = 41
      Height = 25
      Caption = #20462#25913
      TabOrder = 2
      OnClick = outBtnEdtClick
    end
    object outBtnDel: TBitBtn
      Left = 104
      Top = 246
      Width = 41
      Height = 25
      Caption = #21024#38500
      TabOrder = 3
      OnClick = outBtnDelClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 200
    Top = 8
    Width = 161
    Height = 283
    Caption = #25910#20837#39033#30446
    TabOrder = 1
    object inListBox: TListBox
      Left = 16
      Top = 24
      Width = 129
      Height = 216
      ItemHeight = 13
      TabOrder = 0
    end
    object inBtnAdd: TBitBtn
      Left = 16
      Top = 246
      Width = 41
      Height = 25
      Caption = #26032#22686
      TabOrder = 1
      OnClick = inBtnAddClick
    end
    object inBtnEdt: TBitBtn
      Left = 60
      Top = 246
      Width = 41
      Height = 25
      Caption = #20462#25913
      TabOrder = 2
      OnClick = inBtnEdtClick
    end
    object inBtnDel: TBitBtn
      Left = 104
      Top = 246
      Width = 41
      Height = 25
      Caption = #21024#38500
      TabOrder = 3
      OnClick = inBtnDelClick
    end
  end
end
