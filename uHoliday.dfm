object frmHolidays: TfrmHolidays
  Left = 295
  Top = 260
  BorderStyle = bsDialog
  Caption = #1055#1088#1072#1079#1076#1085#1080#1095#1085#1099#1077' '#1076#1085#1080'...'
  ClientHeight = 343
  ClientWidth = 846
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
    846
    343)
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 6
    Top = 14
    Width = 78
    Height = 14
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 197
    Top = 10
    Width = 463
    Height = 13
    Caption = 
      #1063#1090#1086#1073#1099' '#1076#1086#1073#1072#1074#1080#1090#1100'/'#1091#1076#1072#1083#1080#1090#1100' '#1087#1088#1072#1079#1076#1085#1080#1082' '#1076#1074#1072#1078#1076#1099' '#1082#1083#1080#1082#1085#1080#1090#1077' '#1087#1086' '#1085#1091#1078#1085#1086#1084#1091' '#1076#1085#1102' '#1075 +
      #1086#1076#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object spbtnNewYear: TSpeedButton
    Left = 6
    Top = 316
    Width = 70
    Height = 22
    Hint = '1,1'
    AllowAllUp = True
    GroupIndex = 1
    Caption = #1053#1086#1074#1099#1081' '#1075#1086#1076
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnChistmas: TSpeedButton
    Left = 77
    Top = 316
    Width = 70
    Height = 22
    Hint = '7,1'
    AllowAllUp = True
    GroupIndex = 2
    Caption = #1056#1086#1078#1076#1077#1089#1090#1074#1086
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnMarch8: TSpeedButton
    Left = 149
    Top = 316
    Width = 65
    Height = 22
    Hint = '8,3'
    AllowAllUp = True
    GroupIndex = 3
    Caption = '8 '#1084#1072#1088#1090#1072
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnEaster: TSpeedButton
    Left = 215
    Top = 316
    Width = 65
    Height = 22
    AllowAllUp = True
    GroupIndex = 4
    Caption = #1055#1072#1089#1093#1072
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnTrinity: TSpeedButton
    Left = 282
    Top = 316
    Width = 65
    Height = 22
    AllowAllUp = True
    GroupIndex = 5
    Caption = #1058#1088#1086#1080#1094#1072
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnMay1: TSpeedButton
    Left = 348
    Top = 316
    Width = 65
    Height = 22
    Hint = '1,5'
    AllowAllUp = True
    GroupIndex = 6
    Caption = '1 '#1084#1072#1103
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnVictoryDay: TSpeedButton
    Left = 481
    Top = 316
    Width = 75
    Height = 22
    Hint = '9,5'
    AllowAllUp = True
    GroupIndex = 8
    Caption = #1044#1077#1085#1100' '#1087#1086#1073#1077#1076#1099
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnConstitutionDay: TSpeedButton
    Left = 557
    Top = 316
    Width = 100
    Height = 22
    Hint = '28,6'
    AllowAllUp = True
    GroupIndex = 9
    Caption = #1044#1077#1085#1100' '#1082#1086#1085#1089#1090#1080#1090#1091#1094#1080#1080
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnIndependenceDay: TSpeedButton
    Left = 659
    Top = 316
    Width = 115
    Height = 22
    Hint = '24,8'
    AllowAllUp = True
    GroupIndex = 10
    Caption = #1044#1077#1085#1100' '#1085#1077#1079#1072#1074#1080#1089#1080#1084#1086#1089#1090#1080
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnMay2: TSpeedButton
    Left = 414
    Top = 316
    Width = 65
    Height = 22
    Hint = '2,5'
    AllowAllUp = True
    GroupIndex = 7
    Caption = '2 '#1084#1072#1103
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object spbtnOctober14: TSpeedButton
    Left = 775
    Top = 316
    Width = 65
    Height = 22
    Hint = '14,10'
    AllowAllUp = True
    GroupIndex = 11
    Caption = '14 '#1086#1082#1090#1103#1073#1088#1103
    Transparent = False
    OnClick = spbtnNewYearClick
  end
  object cboxYear: TComboBox
    Left = 91
    Top = 6
    Width = 65
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 0
    OnChange = cboxYearChange
    OnKeyDown = cboxYearKeyDown
  end
  object strgrdCalendar: TStringGrid
    Left = 6
    Top = 34
    Width = 834
    Height = 276
    ColCount = 38
    DefaultColWidth = 20
    DefaultRowHeight = 20
    RowCount = 13
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 1
    OnDblClick = strgrdCalendarDblClick
    OnDrawCell = strgrdCalendarDrawCell
  end
  object bitbtnClose: TBitBtn
    Left = 724
    Top = 5
    Width = 115
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = bitbtnCloseClick
  end
  object sqlqryQuery: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <
      item
        DataType = ftString
        Name = 'YEAR'
        ParamType = ptInput
        Value = ''
      end>
    SQL.Strings = (
      'select * from qwerty.sp_zar_prazdn'
      'where to_char(dat_prazdn, '#39'yyyy'#39')=:YEAR'
      'order by 1')
    Left = 358
    Top = 62
  end
  object sqlqryYears: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <>
    SQL.Strings = (
      
        'select distinct to_char(dat_prazdn, '#39'yyyy'#39') from qwerty.sp_zar_p' +
        'razdn'
      'order by 1')
    Left = 404
    Top = 62
  end
end
