object frmTestSchedule: TfrmTestSchedule
  Left = 344
  Top = 150
  Width = 870
  Height = 640
  Caption = 'frmTestSchedule'
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
  object Splitter1: TSplitter
    Left = 0
    Top = 301
    Width = 862
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 862
    Height = 301
    Align = alClient
    Caption = ' '#1048#1089#1093#1086#1076#1085#1099#1081' '#1075#1088#1072#1092#1080#1082' '
    TabOrder = 0
    object pnlSourceTop: TPanel
      Left = 2
      Top = 16
      Width = 858
      Height = 41
      Align = alTop
      Caption = 'pnlSourceTop'
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 11
        Width = 89
        Height = 14
        Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1075#1088#1072#1092#1080#1082
      end
      object cboxSchedule: TComboBox
        Left = 118
        Top = 6
        Width = 275
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
      end
    end
    object strgrdSource: TStringGrid
      Left = 2
      Top = 57
      Width = 858
      Height = 242
      Align = alClient
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 304
    Width = 862
    Height = 268
    Align = alBottom
    Caption = ' '#1048#1079#1084#1077#1085#1077#1085#1085#1099#1081' '#1075#1088#1072#1092#1080#1082' '
    TabOrder = 1
    object strgrdTest: TStringGrid
      Left = 2
      Top = 103
      Width = 858
      Height = 163
      Align = alClient
      TabOrder = 0
    end
    object pnlTestTop: TPanel
      Left = 2
      Top = 16
      Width = 858
      Height = 87
      Align = alTop
      Caption = 'pnlTestTop'
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 572
    Width = 862
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 2
  end
end
