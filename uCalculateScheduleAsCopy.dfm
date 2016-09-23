object frmCalculateScheduleAsCopy: TfrmCalculateScheduleAsCopy
  Left = 399
  Top = 219
  Width = 404
  Height = 406
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object strgrdMarks: TStringGrid
    Left = 6
    Top = 123
    Width = 375
    Height = 175
    Hint = 
      #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1086#1090#1084#1077#1090#1086#1082'|'#1057#1086#1087#1086#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1086#1090#1084#1077#1090#1086#1082' '#1082#1086#1087#1080#1088#1091#1077#1084#1086#1075#1086' '#1075#1088#1072#1092#1080#1082#1072' '#1089 +
      ' '#1086#1090#1084#1077#1090#1082#1072' '#1082#1086#1087#1080#1088#1091#1102#1097#1077#1075#1086#1089#1103' '#1075#1088#1072#1092#1080#1082#1072
    ColCount = 2
    DefaultColWidth = 160
    DefaultRowHeight = 20
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 0
    OnSelectCell = strgrdMarksSelectCell
    ColWidths = (
      160
      188)
  end
  object grpboxSource: TGroupBox
    Left = 6
    Top = 6
    Width = 375
    Height = 55
    Caption = ' '#1050#1086#1087#1080#1088#1091#1077#1084#1099#1081' '#1075#1088#1072#1092#1080#1082'  '
    TabOrder = 1
    object Label3: TLabel
      Left = 170
      Top = 12
      Width = 33
      Height = 14
      Caption = #1057#1084#1077#1085#1072
    end
    object Label4: TLabel
      Left = 314
      Top = 12
      Width = 17
      Height = 14
      Caption = #1043#1086#1076
    end
    object Label5: TLabel
      Left = 6
      Top = 12
      Width = 36
      Height = 14
      Caption = #1043#1088#1072#1092#1080#1082
    end
    object cboxSchedulesSrc: TComboBox
      Left = 6
      Top = 28
      Width = 160
      Height = 22
      Hint = #1050#1086#1087#1080#1088#1091#1077#1084#1099#1081' '#1075#1088#1072#1092#1080#1082'|'#1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1086#1087#1080#1088#1091#1077#1084#1099#1081' '#1075#1088#1072#1092#1080#1082
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 0
      OnChange = cboxSchedulesSrcChange
    end
    object cboxShiftsSrc: TComboBox
      Left = 170
      Top = 28
      Width = 140
      Height = 22
      Hint = #1050#1086#1087#1080#1088#1091#1077#1084#1072#1103' '#1089#1084#1077#1085#1072' '#1075#1088#1072#1092#1080#1082#1072'|'#1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1084#1077#1085#1091' '#1075#1088#1072#1092#1080#1082#1072' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 1
    end
    object cboxYearsSrc: TComboBox
      Left = 314
      Top = 28
      Width = 55
      Height = 22
      Hint = #1043#1086#1076'|'#1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1086#1076', '#1076#1072#1085#1085#1099#1077' '#1079#1072' '#1082#1086#1090#1086#1088#1099#1093' '#1076#1086#1083#1078#1085#1099' '#1073#1099#1090#1100' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1085#1099
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 2
      OnChange = cboxYearsSrcChange
    end
  end
  object grpboxDestination: TGroupBox
    Left = 6
    Top = 63
    Width = 375
    Height = 55
    Caption = ' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1080#1079' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1074#1099#1096#1077' '#1075#1088#1072#1092#1080#1082#1072' '#1074' '
    TabOrder = 2
    object Label6: TLabel
      Left = 170
      Top = 12
      Width = 33
      Height = 14
      Caption = #1057#1084#1077#1085#1072
    end
    object Label7: TLabel
      Left = 314
      Top = 12
      Width = 17
      Height = 14
      Caption = #1043#1086#1076
    end
    object Label8: TLabel
      Left = 6
      Top = 12
      Width = 36
      Height = 14
      Caption = #1043#1088#1072#1092#1080#1082
    end
    object cboxSchedulesDst: TComboBox
      Left = 6
      Top = 28
      Width = 160
      Height = 22
      Hint = #1050#1086#1087#1080#1088#1091#1102#1097#1080#1081#1089#1103' '#1075#1088#1072#1092#1080#1082'|'#1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1086#1087#1080#1088#1091#1102#1097#1080#1081#1089#1103' '#1075#1088#1072#1092#1080#1082
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 0
      OnChange = cboxSchedulesDstChange
    end
    object cboxShiftsDst: TComboBox
      Left = 170
      Top = 28
      Width = 140
      Height = 22
      Hint = 
        #1057#1084#1077#1085#1072', '#1074' '#1082#1086#1090#1086#1088#1091#1102' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100'|'#1057#1084#1077#1085#1072', '#1082#1086#1090#1086#1088#1072#1103' '#1073#1091#1076#1077#1090' '#1089#1086#1079 +
        #1076#1072#1085#1072' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080' '#1076#1072#1085#1085#1099#1093' '#1082#1086#1087#1080#1088#1091#1077#1084#1086#1077#1075#1086' '#1075#1088#1072#1092#1080#1082#1072
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 1
    end
    object cboxYearsDst: TComboBox
      Left = 314
      Top = 28
      Width = 55
      Height = 22
      Hint = #1043#1086#1076' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103'|'#1043#1086#1076' '#1076#1083#1103' '#1085#1086#1074#1086#1075#1086' '#1075#1088#1072#1092#1080#1082#1072' '#1089#1084#1077#1085#1099
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 2
    end
  end
  object cboxCell: TComboBox
    Left = 158
    Top = 268
    Width = 145
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 3
    Visible = False
    OnChange = cboxCellChange
    OnExit = cboxCellExit
  end
  object bitbtnOk: TBitBtn
    Left = 166
    Top = 338
    Width = 115
    Height = 25
    Hint = #1053#1072#1095#1072#1090#1100' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077'|'#1053#1072#1095#1072#1090#1100' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1072
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
    Default = True
    TabOrder = 4
    OnClick = bitbtnOkClick
  end
  object bitbtnCancel: TBitBtn
    Left = 286
    Top = 338
    Width = 95
    Height = 25
    Hint = #1054#1090#1084#1077#1085#1072' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103'|'#1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086' '#1073#1077#1079' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = bitbtnCancelClick
  end
  object chkboxDontClose: TCheckBox
    Left = 6
    Top = 312
    Width = 173
    Height = 17
    Hint = 
      #1054#1089#1090#1072#1074#1072#1090#1100#1089#1103' '#1074' '#1101#1090#1086#1084' '#1086#1082#1085#1077' '#1087#1086#1089#1083#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103'|'#1053#1077' '#1079#1072#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1086', '#1095#1090#1086#1073 +
      #1099' '#1084#1086#1078#1085#1086' '#1073#1099#1083#1086' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1077#1097#1077' '#1086#1076#1085#1091' '#1089#1084#1077#1085#1091' '#1075#1088#1072#1092#1080#1082#1072
    Caption = #1053#1077' '#1079#1072#1082#1088#1099#1074#1072#1090#1100' '#1087#1086#1089#1083#1077' '#1088#1072#1089#1095#1077#1090#1072
    TabOrder = 6
  end
  object bitbtnNewMark: TBitBtn
    Left = 186
    Top = 304
    Width = 195
    Height = 25
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1088#1091#1075#1091#1102' '#1086#1090#1084#1077#1090#1082#1091'|'#1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1088#1091#1075#1091#1102' '#1080#1083#1080' '#1085#1086#1074#1091#1102' '#1086#1090#1084#1077#1090#1082#1091
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1090#1084#1077#1090#1082#1091
    Enabled = False
    TabOrder = 7
    OnClick = bitbtnNewMarkClick
  end
  object sqlqryMarks: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
        Value = '1'
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
        Value = '2007'
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SHIFT_TYPE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select distinct mark from '
      
        '(select           d1 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d2 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d3 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d4 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d5 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d6 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d7 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d8 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select  d9 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d10 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d11 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d12 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d13 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d14 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d15 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d16 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d17 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d18 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d19 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d20 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d21 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d22 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d23 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d24 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d25 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d26 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d27 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d28 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d29 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d30 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      
        'union all select d31 mark from QWERTY.SP_ZAR_GRAFIK where tip_sm' +
        'en=:SHIFT_TYPE and to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR)'
      'order by 1')
    Left = 312
    Top = 262
  end
  object sqlqryShiftMonth: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <
      item
        DataType = ftString
        Name = 'SHIFT_DATE'
        ParamType = ptInput
        Value = ''
      end
      item
        DataType = ftString
        Name = 'SHIFT_ID'
        ParamType = ptInput
        Value = ''
      end>
    SQL.Strings = (
      'select * from QWERTY.SP_ZAR_GRAFIK'
      'where '
      'data_graf=to_date(:SHIFT_DATE, '#39'dd.mm.yyyy'#39')'
      'and id_smen=:SHIFT_ID')
    Left = 346
    Top = 262
  end
end
