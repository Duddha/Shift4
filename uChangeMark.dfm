object frmChangeMark: TfrmChangeMark
  Left = 497
  Top = 224
  BorderStyle = bsDialog
  Caption = #1047#1072#1084#1077#1085#1072' '#1086#1090#1084#1077#1090#1082#1080
  ClientHeight = 362
  ClientWidth = 313
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
  object Label1: TLabel
    Left = 6
    Top = 55
    Width = 93
    Height = 13
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1086#1090#1084#1077#1090#1082#1091
  end
  object lbPrevMark: TLabel
    Left = 102
    Top = 52
    Width = 34
    Height = 19
    Alignment = taCenter
    Caption = #1046#1046
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 139
    Top = 55
    Width = 12
    Height = 13
    Caption = #1085#1072
  end
  object Label3: TLabel
    Left = 6
    Top = 9
    Width = 30
    Height = 13
    Caption = #1044#1072#1090#1072':'
  end
  object Label4: TLabel
    Left = 6
    Top = 32
    Width = 35
    Height = 13
    Caption = #1057#1084#1077#1085#1072':'
  end
  object lbDate: TLabel
    Left = 46
    Top = 6
    Width = 54
    Height = 19
    Caption = 'lbDate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbShift: TLabel
    Left = 46
    Top = 29
    Width = 53
    Height = 19
    Caption = 'lbShift'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bitbtnOk: TBitBtn
    Left = 82
    Top = 331
    Width = 125
    Height = 25
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = bitbtnOkClick
    Kind = bkRetry
  end
  object bitbtnCancel: TBitBtn
    Left = 211
    Top = 331
    Width = 95
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = bitbtnCancelClick
    Kind = bkCancel
  end
  object lstboxMarks: TListBox
    Left = 6
    Top = 74
    Width = 300
    Height = 200
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
    OnDblClick = lstboxMarksDblClick
  end
  object chkboxRecalculateWorktime: TCheckBox
    Left = 6
    Top = 308
    Width = 200
    Height = 17
    Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099' '#1089#1084#1077#1085#1099
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object bitbtnNewMark: TBitBtn
    Left = 111
    Top = 278
    Width = 195
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1090#1084#1077#1090#1082#1091' '#1074' '#1089#1087#1080#1089#1086#1082
    TabOrder = 1
    OnClick = bitbtnNewMarkClick
  end
end
