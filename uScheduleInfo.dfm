object frmScheduleInfo: TfrmScheduleInfo
  Left = 232
  Top = 165
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1075#1088#1072#1092#1080#1082#1072
  ClientHeight = 550
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 60
    Width = 65
    Height = 13
    Caption = #1058#1080#1087' '#1075#1088#1072#1092#1080#1082#1072
  end
  object Label2: TLabel
    Left = 6
    Top = 106
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label3: TLabel
    Left = 6
    Top = 142
    Width = 102
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' ('#1091#1082#1088')'
  end
  object Label4: TLabel
    Left = 6
    Top = 188
    Width = 26
    Height = 13
    Caption = #1062#1080#1082#1083
  end
  object Label5: TLabel
    Left = 6
    Top = 238
    Width = 94
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1076#1085#1077#1081' '#1094#1080#1082#1083#1072
  end
  object Label6: TLabel
    Left = 6
    Top = 292
    Width = 63
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1089#1084#1077#1085
  end
  object Label7: TLabel
    Left = 6
    Top = 332
    Width = 109
    Height = 13
    Caption = #1056#1077#1082#1094#1080#1103' '#1085#1072' '#1087#1088#1072#1079#1076#1085#1080#1082#1080
  end
  object Label9: TLabel
    Left = 10
    Top = 367
    Width = 44
    Height = 13
    Caption = #1054#1090#1084#1077#1090#1082#1080
  end
  object edScheduleType: TEdit
    Left = 139
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'edScheduleType'
  end
  object edNameU: TEdit
    Left = 139
    Top = 102
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edNameU'
  end
  object edNameR: TEdit
    Left = 139
    Top = 134
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edNameR'
  end
  object edCycle: TEdit
    Left = 139
    Top = 180
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'edCycle'
  end
  object spnedNumOfDays: TSpinEdit
    Left = 139
    Top = 238
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object spnedNumOfShifts: TSpinEdit
    Left = 139
    Top = 274
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object cboxHollidayType: TComboBox
    Left = 139
    Top = 328
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = 'cboxHollidayType'
  end
  object edMarks: TEdit
    Left = 139
    Top = 363
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'edMarks'
  end
end
