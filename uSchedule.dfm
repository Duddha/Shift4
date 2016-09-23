object frmSchedule: TfrmSchedule
  Left = 354
  Top = 285
  Width = 1190
  Height = 574
  Caption = #1043#1088#1072#1092#1080#1082
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object spltrVerticalL: TSplitter
    Left = 0
    Top = 49
    Width = 3
    Height = 465
    Cursor = crHSplit
    Beveled = True
    Visible = False
  end
  object spltrHorizontalB: TSplitter
    Left = 0
    Top = 514
    Width = 1174
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    Visible = False
  end
  object spltrVerticalR: TSplitter
    Left = 1171
    Top = 49
    Width = 3
    Height = 465
    Cursor = crHSplit
    Align = alRight
    Beveled = True
  end
  object stbarStatus: TStatusBar
    Left = 0
    Top = 517
    Width = 1174
    Height = 19
    Hint = 
      #1044#1072#1090#1072' - '#1076#1077#1085#1100' '#1085#1077#1076#1077#1083#1080'; ['#1054#1090#1084#1077#1090#1082#1072'] '#1054#1087#1080#1089#1072#1085#1080#1077' ('#1042#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099', '#1095'/ '#1042#1077#1095#1077#1088#1085#1080 +
      #1077', '#1095'/ '#1053#1086#1095#1085#1099#1077', '#1095'/ '#1054#1073#1077#1076', '#1084#1080#1085')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Panels = <
      item
        Width = 200
      end
      item
        Width = 300
      end
      item
        Width = 250
      end>
    ParentShowHint = False
    ShowHint = True
    SimplePanel = False
    UseSystemFont = False
  end
  object pnlLeftDock: TPanel
    Left = 3
    Top = 49
    Width = 0
    Height = 465
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlLeftDock'
    DockSite = True
    TabOrder = 2
  end
  object pnlBottomDock: TPanel
    Left = 0
    Top = 517
    Width = 1174
    Height = 0
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlBottomDock'
    DockSite = True
    TabOrder = 5
  end
  object pnlRightDock: TPanel
    Left = 1174
    Top = 49
    Width = 0
    Height = 465
    Align = alRight
    BevelOuter = bvNone
    Caption = 'pnlRightDock'
    DockSite = True
    TabOrder = 3
  end
  inline frameSchedule1: TframeSchedule
    Left = 3
    Top = 49
    Width = 1168
    Height = 465
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    inherited Splitter1: TSplitter
      Left = 845
      Height = 355
    end
    inherited Splitter2: TSplitter
      Top = 355
      Width = 1168
    end
    inherited strgrdSchedule: TStringGrid
      Width = 845
      Height = 355
      DefaultRowHeight = 20
      PopupMenu = pmPopup
      OnSelectCell = frameSchedule1strgrdScheduleSelectCell
    end
    inherited strgrdScheduleTime: TStringGrid
      Left = 848
      Height = 355
      DefaultRowHeight = 20
      PopupMenu = pmScheduleTime
      OnDblClick = frameSchedule1strgrdScheduleTimeDblClick
      OnKeyDown = frameSchedule1strgrdScheduleTimeKeyDown
    end
    inherited pnlBottom: TPanel
      Top = 358
      Width = 1168
      inherited strgrdScheduleTotal: TStringGrid
        Width = 1164
      end
    end
  end
  object tlbarToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1174
    Height = 49
    AutoSize = True
    ButtonHeight = 45
    ButtonWidth = 106
    Caption = 'tlbarToolBar'
    EdgeBorders = [ebTop, ebBottom]
    Flat = True
    Images = frmMain.imglstActions24
    ShowCaptions = True
    TabOrder = 0
    object tlbtnRefresh: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 0
      OnClick = tlbtnRefreshClick
    end
    object ToolButton2: TToolButton
      Left = 62
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object tlbtnColoredMode: TToolButton
      Left = 70
      Top = 0
      AutoSize = True
      Caption = #1042#1099#1076#1077#1083#1077#1085#1080#1077' '#1094#1074#1077#1090#1086#1084
      ImageIndex = 2
      Style = tbsCheck
      OnClick = tlbtnColoredModeClick
    end
    object tlbtnShowMarkTime: TToolButton
      Left = 180
      Top = 0
      AutoSize = True
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1088#1077#1084#1103
      ImageIndex = 5
      Style = tbsCheck
      OnClick = tlbtnShowMarkTimeClick
    end
    object ToolButton1: TToolButton
      Left = 289
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object tlbtnChangeCurYear: TToolButton
      Left = 297
      Top = 0
      AutoSize = True
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1075#1086#1076
      ImageIndex = 3
      Visible = False
      OnClick = tlbtnChangeCurYearClick
    end
    object tlbtnChangeFormYear: TToolButton
      Left = 379
      Top = 0
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1075#1086#1076
      DropdownMenu = pmYears
      ImageIndex = 3
      Style = tbsDropDown
      OnClick = tlbtnChangeFormYearClick
    end
    object ToolButton4: TToolButton
      Left = 500
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object tlbtnCalculateWorktime: TToolButton
      Left = 508
      Top = 0
      AutoSize = True
      Caption = #1055#1086#1076#1089#1095#1080#1090#1072#1090#1100' '#1074#1088#1077#1084#1103
      ImageIndex = 1
      OnClick = tlbtnCalculateWorktimeClick
    end
    object ToolButton3: TToolButton
      Left = 616
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object tlbtnScheduleCalculate: TToolButton
      Left = 624
      Top = 0
      AutoSize = True
      Caption = #1056#1072#1089#1095#1080#1090#1072#1090#1100' '#1085#1086#1074#1099#1081
      ImageIndex = 4
      OnClick = tlbtnScheduleCalculateClick
    end
    object ToolButton5: TToolButton
      Left = 725
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 733
      Top = 0
      Caption = #1055#1077#1095#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1072'...'
      ImageIndex = 15
      OnClick = ToolButton6Click
    end
  end
  object aclstSchedule: TActionList
    Left = 10
    Top = 472
    object acShowDock: TAction
      Caption = 'acShowDock'
      ShortCut = 16467
    end
  end
  object pmPopup: TPopupMenu
    OnPopup = pmPopupPopup
    Left = 280
    Top = 138
    object N1: TMenuItem
      Caption = #1054#1090#1084#1077#1090#1082#1072'...'
      Default = True
      ShortCut = 16461
      OnClick = N1Click
    end
    object pmiChangeMark: TMenuItem
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100'...'
      ShortCut = 16472
      OnClick = pmiChangeMarkClick
    end
    object pmiChangeMarkAgain: TMenuItem
      Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1100' '#1079#1072#1084#1077#1085#1091
      ShortCut = 115
      OnClick = pmiChangeMarkAgainClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = #1042#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099' '#1089#1084#1077#1085#1099'...'
      Enabled = False
    end
  end
  object pmYears: TPopupMenu
    Left = 592
    Top = 202
  end
  object pmScheduleTime: TPopupMenu
    OnPopup = pmScheduleTimePopup
    Left = 958
    Top = 248
    object pmiEnableEdit: TMenuItem
      Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      OnClick = pmiEnableEditClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object pmiCopyDayTimeFromDnevniki: TMenuItem
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1085#1080'/'#1095#1072#1089#1099' '#1076#1085#1077#1074#1085#1086#1075#1086' '#1075#1088#1072#1092#1080#1082#1072
      Hint = 
        #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1085#1080'/'#1095#1072#1089#1099' '#1076#1085#1077#1074#1085#1086#1075#1086' '#1075#1088#1072#1092#1080#1082#1072'|'#1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1082#1086#1083#1080#1095 +
        #1077#1089#1090#1074#1072' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1077#1081' '#1080' '#1095#1072#1089#1086#1074' '#1080#1079' '#1076#1085#1077#1074#1085#1086#1075#1086' '#1075#1088#1072#1092#1080#1082#1072
      OnClick = pmiCopyDayTimeFromDnevnikiClick
    end
  end
end
