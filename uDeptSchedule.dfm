object frmDeptSchedule: TfrmDeptSchedule
  Left = 579
  Top = 304
  Width = 870
  Height = 640
  Caption = #1057#1074#1103#1079#1100' '#1094#1077#1093#1086#1074' '#1080' '#1075#1088#1072#1092#1080#1082#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object strgrdDeptSchedule: TStringGrid
    Left = 0
    Top = 20
    Width = 854
    Height = 582
    Align = alClient
    DefaultRowHeight = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentFont = False
    TabOrder = 0
    OnDblClick = strgrdDeptScheduleDblClick
    OnDrawCell = strgrdDeptScheduleDrawCell
    OnKeyUp = strgrdDeptScheduleKeyUp
    OnMouseUp = strgrdDeptScheduleMouseUp
    OnMouseWheelDown = strgrdDeptScheduleMouseWheelDown
    OnMouseWheelUp = strgrdDeptScheduleMouseWheelUp
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 854
    Height = 20
    Align = alTop
    TabOrder = 1
  end
  object SQLClientDataSet1: TSQLClientDataSet
    Aggregates = <>
    Options = [poAllowCommandText]
    ObjectView = True
    Params = <>
    DBConnection = dmMain.sqlconDB
    Left = 234
    Top = 30
  end
  object SQLQuery1: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <>
    Left = 306
    Top = 30
  end
  object sqlqryText: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <>
    SQL.Strings = (
      'SELECT DISTINCT p.nam'
      
        '               ,'#39', sum(decode(id_cex, '#39' || s.id_cex || '#39', smena_' +
        'cnt, '#39#39#39#39')) over (partition by smena_name) "'#39' || p.nam || '#39'"'#39' qr' +
        'y'
      '  FROM qwerty.sp_stat s'
      '      ,qwerty.sp_podr p'
      
        ' WHERE id_stat IN (SELECT DISTINCT id_stat FROM qwerty.sp_rb_key' +
        ')'
      '   AND s.id_cex = p.id_cex'
      ' ORDER BY p.nam')
    Left = 272
    Top = 92
  end
end
