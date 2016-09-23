object frmFDReport: TfrmFDReport
  Left = 207
  Top = 106
  Width = 870
  Height = 640
  Caption = #1055#1077#1095#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 14
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    Left = 28
    Top = 26
    ReportForm = {17000000}
  end
  object sqlqrySchedule: TSQLQuery
    Active = True
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
        Value = '2007'
      end
      item
        DataType = ftString
        Name = 'SCHEDULE_TYPE'
        ParamType = ptInput
        Value = '4'
      end>
    SQL.Strings = (
      'select '
      
        'sg.data_graf, sg.month, sg.id, g.day_graf CALENDAR_DAYS, sg.day_' +
        'graf, g.time_graf CALENDAR_TIME, sg.time_graf, '
      'sg.time_per, sg.time_pra1, sg.time_pra2, sg.time_n, sg.time_v, '
      
        'sg.d1, sg.d2, sg.d3, sg.d4, sg.d5, sg.d6, sg.d7, sg.d8, sg.d9, s' +
        'g.d10, sg.d11, sg.d12, sg.d13, sg.d14, sg.d15, sg.d16, sg.d17, '
      
        'sg.d18, sg.d19, sg.d20, sg.d21, sg.d22, sg.d23, sg.d24, sg.d25, ' +
        'sg.d26, sg.d27, sg.d28, sg.d29, sg.d30, sg.d31'
      'from qwerty.shift_grafik sg, qwerty.sp_zar_grafik g'
      'where '
      '  to_char(sg.data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      ' and'
      '  sg.tip=:SCHEDULE_TYPE'
      ' and'
      '  g.data_graf=sg.data_graf'
      ' and'
      '  g.tip_smen=0'
      'order by'
      '  sg.data_graf, sg.id')
    Left = 82
    Top = 22
  end
  object DataSource1: TDataSource
    DataSet = sqlqrySchedule
    Left = 114
    Top = 22
  end
  object frDBDataSet1: TfrDBDataSet
    DataSource = DataSource1
    Left = 82
    Top = 56
  end
  object sqlqryScheduleTotal: TSQLQuery
    Active = True
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
        Value = '2007'
      end
      item
        DataType = ftString
        Name = 'SCHEDULE_TYPE'
        ParamType = ptInput
        Value = '4'
      end>
    SQL.Strings = (
      
        'select SCHED_YEAR, ID, sum(CALENDAR_DAYS), sum(SCHED_DAYS), sum(' +
        'CALENDAR_TIME), sum(SCHED_TIME), sum(TIME_PER),'
      'sum(TIME_PRA1), sum(TIME_PRA2), sum(TIME_N), sum(TIME_V)'
      'from ('
      'select '
      
        'to_char(sg.data_graf, '#39'yyyy'#39') SCHED_YEAR, sg.id, g.day_graf CALE' +
        'NDAR_DAYS, sg.day_graf SCHED_DAYS, g.time_graf CALENDAR_TIME, '
      
        'sg.time_graf SCHED_TIME, sg.time_per TIME_PER, sg.time_pra1 TIME' +
        '_PRA1, sg.time_pra2 TIME_PRA2, sg.time_n TIME_N, sg.time_v TIME_' +
        'V'
      'from qwerty.shift_grafik sg, qwerty.sp_zar_grafik g'
      'where '
      '  to_char(sg.data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      ' and'
      '  sg.tip=:SCHEDULE_TYPE'
      ' and'
      '  g.data_graf=sg.data_graf'
      ' and'
      '  g.tip_smen=0'
      ')'
      'group by SCHED_YEAR, ID'
      'order by'
      '  ID')
    Left = 80
    Top = 104
  end
end
