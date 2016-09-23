object frameSchedule: TframeSchedule
  Left = 0
  Top = 0
  Width = 841
  Height = 463
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 518
    Top = 0
    Width = 3
    Height = 353
    Cursor = crHSplit
    Align = alRight
    Beveled = True
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 353
    Width = 841
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
  end
  object strgrdSchedule: TStringGrid
    Left = 0
    Top = 0
    Width = 518
    Height = 353
    Align = alClient
    ColCount = 2
    DefaultRowHeight = 18
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
    ParentShowHint = False
    ScrollBars = ssHorizontal
    ShowHint = False
    TabOrder = 0
    OnDblClick = strgrdScheduleDblClick
    OnDrawCell = strgrdScheduleDrawCell
    OnKeyDown = strgrdScheduleKeyDown
    OnMouseMove = strgrdScheduleMouseMove
    OnSelectCell = strgrdScheduleSelectCell
    OnTopLeftChanged = strgrdScheduleTopLeftChanged
  end
  object strgrdScheduleTime: TStringGrid
    Left = 521
    Top = 0
    Width = 320
    Height = 353
    Align = alRight
    ColCount = 2
    DefaultRowHeight = 18
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 1
    OnDrawCell = strgrdScheduleTimeDrawCell
    OnSelectCell = strgrdScheduleTimeSelectCell
    OnTopLeftChanged = strgrdScheduleTimeTopLeftChanged
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 356
    Width = 841
    Height = 107
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object strgrdScheduleTotal: TStringGrid
      Left = 2
      Top = 2
      Width = 837
      Height = 103
      Align = alClient
      ColCount = 8
      DefaultRowHeight = 18
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
      OnDrawCell = strgrdScheduleTotalDrawCell
    end
  end
  object sqlqrySchedule: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <
      item
        DataType = ftString
        Name = 'SCHEDULE_TYPE'
        ParamType = ptInput
        Value = '3'
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
        Value = '2006'
      end>
    SQL.Strings = (
      'select '
      
        '  data_graf "_DATA_GRAF", month "'#1052#1077#1089#1103#1094'", tip "_TIP", id "'#1057#1084#1077#1085#1072'",' +
        ' day_graf "+'#1044#1085#1080'", '
      
        '  time_graf "+'#1063#1072#1089#1099'", time_per "+024", time_pra "_TIME_PRA", time' +
        '_pra1 "+023", '
      '  time_pra2 "+033", time_n "+'#1053#1086#1095#1085#1099#1077'", time_v "+'#1042#1077#1095#1077#1088#1085#1080#1077'",'
      
        '  d1 "1", d2 "2", d3 "3", d4 "4", d5 "5", d6 "6", d7 "7", d8 "8"' +
        ', d9 "9", d10 "10",'
      
        '  d11 "11", d12 "12", d13 "13", d14 "14", d15 "15", d16 "16", d1' +
        '7 "17", d18 "18", '
      
        '  d19 "19", d20  "20", d21 "21", d22 "22", d23 "23", d24 "24", d' +
        '25 "25", d26 "26", '
      '  d27 "27", d28 "28", d29 "29", d30 "30", d31 "31"'
      'from qwerty.shift_grafik'
      'where '
      '  tip=:SCHEDULE_TYPE '
      ' and '
      '  to_char(data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      'order by data_graf, id')
    Left = 474
    Top = 12
  end
  object sqlqryTotal: TSQLQuery
    NoMetadata = True
    SQLConnection = dmMain.sqlconDB
    Params = <
      item
        DataType = ftString
        Name = 'SCHEDULE_TYPE'
        ParamType = ptInput
        Value = '3'
      end
      item
        DataType = ftString
        Name = 'CUR_YEAR'
        ParamType = ptInput
        Value = '2006'
      end>
    SQL.Strings = (
      'select '
      '  year_graf "_YEAR", id_smen "'#1057#1084#1077#1085#1072'", '
      
        '  sum(day_graf) "+'#1044#1085#1080'", sum(time_graf) "+'#1063#1072#1089#1099'", sum(time_per) "+' +
        '024", sum(time_pra) "_TIME_PRA", '
      
        '  sum(time_pra1) "+023", sum(time_pra2) "+033", sum(time_v) "+'#1042#1077 +
        #1095#1077#1088#1085#1080#1077'", sum(time_n) "+'#1053#1086#1095#1085#1099#1077'"'
      'from '
      '('
      'select '
      
        '  g.data_graf, to_char(g.data_graf, '#39'yyyy'#39') year_graf, g.tip_sme' +
        'n, g.id_smen,'
      
        '  g.day_graf, g.time_graf, g.time_per, g.time_pra, g.time_pra1, ' +
        'g.time_pra2, gnv.time_v, gnv.time_n'
      'from qwerty.sp_zar_grafik g, qwerty.sp_zar_grafik_nv gnv'
      'where '
      '  gnv.data_graf(+)=g.data_graf'
      ' and'
      '  gnv.id_smen(+)=g.id_smen'
      ' and'
      '  g.tip_smen=:SCHEDULE_TYPE'
      ' and '
      '  to_char(g.data_graf, '#39'yyyy'#39')=:CUR_YEAR'
      ')'
      'group by year_graf, id_smen'
      'order by 2')
    Left = 474
    Top = 46
  end
end
