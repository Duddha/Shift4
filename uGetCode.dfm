object frmGetCode: TfrmGetCode
  Left = 560
  Top = 205
  Width = 812
  Height = 689
  BorderStyle = bsSizeToolWin
  Caption = #1055#1086#1076#1073#1086#1088' '#1082#1086#1076#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object splGridBottom: TSplitter
    Left = 0
    Top = 508
    Width = 796
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
  end
  object strgrdCodes: TStringGrid
    Left = 15
    Top = 40
    Width = 781
    Height = 468
    Align = alClient
    ColCount = 159
    DefaultColWidth = 24
    DefaultRowHeight = 18
    RowCount = 159
    TabOrder = 0
    OnDblClick = strgrdCodesDblClick
    OnDrawCell = strgrdCodesDrawCell
    OnMouseDown = strgrdCodesMouseDown
    OnMouseMove = strgrdCodesMouseMove
    OnSelectCell = strgrdCodesSelectCell
    RowHeights = (
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18
      18)
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 796
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 
      #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1093#1086#1076#1103#1097#1080#1081' '#1082#1086#1076' '#1080' '#1085#1072#1078#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' '#1074#1085#1080#1079#1091' '#1080#1083#1080' '#1076#1074#1072#1078#1076#1099' '#1082#1083#1080#1082#1085#1080 +
      #1090#1077' '#1087#1086' '#1103#1095#1077#1081#1082#1077' '#1089' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1082#1086#1076#1086#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 511
    Width = 796
    Height = 140
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      796
      140)
    object lblCode: TLabel
      Left = 15
      Top = 6
      Width = 781
      Height = 103
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 'lblCode'
      WordWrap = True
    end
    object btnCancel: TBitBtn
      Left = 714
      Top = 113
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
      OnClick = btnCancelClick
      Kind = bkCancel
    end
    object btnSave: TBitBtn
      Left = 490
      Top = 113
      Width = 220
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1082#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnSaveClick
      Kind = bkOK
    end
    object chkShowInfo: TCheckBox
      Left = 15
      Top = 118
      Width = 284
      Height = 17
      Hint = 
        #1057#1082#1088#1099#1090#1100'/'#1087#1086#1082#1072#1079#1072#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' '#1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1086#1084#1091' '#1082#1086#1076#1091' (Ct' +
        'rl+I)'
      Anchors = [akLeft, akBottom]
      Caption = #1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' (Ctrl+I)'
      TabOrder = 2
      OnClick = chkShowInfoClick
    end
  end
  object pnlUnderTop: TPanel
    Left = 0
    Top = 25
    Width = 796
    Height = 15
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = '          '#1087#1077#1088#1074#1099#1081' '#1089#1080#1084#1074#1086#1083
    TabOrder = 3
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 40
    Width = 15
    Height = 468
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
    object lblCaption: TLabel
      Left = 3
      Top = 6
      Width = 8
      Height = 169
      Caption = #1074' '#1090' '#1086' '#1088' '#1086' '#1081'   '#1089' '#1080' '#1084' '#1074' '#1086' '#1083
      WordWrap = True
    end
  end
end
