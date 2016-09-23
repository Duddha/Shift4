object frmChangeCurYear: TfrmChangeCurYear
  Left = 415
  Top = 255
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1086#1088' '#1075#1086#1076#1072
  ClientHeight = 109
  ClientWidth = 223
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 6
    Top = 18
    Width = 147
    Height = 13
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1086#1076' '#1080#1079' '#1089#1087#1080#1089#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cboxCurYear: TComboBox
    Left = 158
    Top = 9
    Width = 60
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 6
    Top = 43
    Width = 175
    Height = 17
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1075#1086#1076#1086#1084' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    TabOrder = 1
  end
  object bitbtnOk: TBitBtn
    Left = 25
    Top = 78
    Width = 115
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1075#1086#1076
    Default = True
    TabOrder = 2
    OnClick = bitbtnOkClick
  end
  object bitbtnCancel: TBitBtn
    Left = 143
    Top = 78
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = bitbtnCancelClick
  end
end
