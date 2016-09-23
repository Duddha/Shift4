object frmMarkList: TfrmMarkList
  Left = 998
  Top = 231
  BorderStyle = bsDialog
  Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1086#1090#1084#1077#1090#1086#1082
  ClientHeight = 437
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    570
    437)
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 6
    Top = 385
    Width = 86
    Height = 14
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '
  end
  object strgrdMarkList: TStringGrid
    Left = 6
    Top = 12
    Width = 557
    Height = 361
    DefaultRowHeight = 18
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
    OnDblClick = strgrdMarkListDblClick
    OnDrawCell = strgrdMarkListDrawCell
    OnMouseUp = strgrdMarkListMouseUp
  end
  object bitbtnOk: TBitBtn
    Left = 348
    Top = 405
    Width = 115
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1099#1073#1088#1072#1090#1100
    TabOrder = 1
    OnClick = bitbtnOkClick
    Kind = bkOK
  end
  object bitbtnClose: TBitBtn
    Left = 468
    Top = 405
    Width = 95
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = bitbtnCloseClick
    Kind = bkCancel
  end
  object cboxSortType: TComboBox
    Left = 95
    Top = 377
    Width = 173
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 3
    OnChange = cboxSortTypeChange
    Items.Strings = (
      #1054#1090#1084#1077#1090#1082#1077
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1091' '#1088#1072#1073#1086#1095#1080#1093' '#1095#1072#1089#1086#1074
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1091' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1077#1081
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1091' '#1074#1077#1095#1077#1088#1085#1080#1093' '#1095#1072#1089#1086#1074
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1091' '#1085#1086#1095#1085#1099#1093' '#1095#1072#1089#1086#1074
      #1042#1077#1083#1080#1095#1080#1085#1077' '#1086#1073#1077#1076#1072
      #1054#1087#1080#1089#1072#1085#1080#1102)
  end
  object bitbtnNewMark: TBitBtn
    Left = 6
    Top = 405
    Width = 95
    Height = 25
    Caption = #1053#1086#1074#1072#1103' '#1086#1090#1084#1077#1090#1082#1072
    TabOrder = 4
    OnClick = bitbtnNewMarkClick
  end
end
