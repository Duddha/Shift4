unit uPrintSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, StdCtrls, DB, SqlExpr, Report_Excel, Math,
  ExtCtrls, StrUtils, IniFiles, DateUtils, Menus, FMTBcd;

type
  TfrmPrintSchedule = class(TForm)
    grp1: TGroupBox;
    grp2: TGroupBox;
    grp3: TGroupBox;
    chkCalTime: TCheckBox;
    chkSchedTime: TCheckBox;
    chkCalDays: TCheckBox;
    chkSchedDays: TCheckBox;
    chkOvertime: TCheckBox;
    chkHol023: TCheckBox;
    chkHol033: TCheckBox;
    chkEvngTime: TCheckBox;
    grpboxLegend: TGroupBox;
    btnSoglFBold: TSpeedButton;
    btnSoglFLeft: TSpeedButton;
    btnSoglFCenter: TSpeedButton;
    btnSoglFRight: TSpeedButton;
    btnSoglSBold: TSpeedButton;
    btnSoglSLeft: TSpeedButton;
    btnSoglSCenter: TSpeedButton;
    btnSoglSRight: TSpeedButton;
    btnSoglThBold: TSpeedButton;
    btnSoglThLeft: TSpeedButton;
    btnSoglThCenter: TSpeedButton;
    btnSoglThRight: TSpeedButton;
    btnUtvFLeft: TSpeedButton;
    btnUtvFCenter: TSpeedButton;
    btnUtvFRight: TSpeedButton;
    btnUtvFBold: TSpeedButton;
    btnUtvSLeft: TSpeedButton;
    btnUtvSCenter: TSpeedButton;
    btnUtvSRight: TSpeedButton;
    btnUtvSBold: TSpeedButton;
    btnUtvThLeft: TSpeedButton;
    btnUtvThCenter: TSpeedButton;
    btnUtvThRight: TSpeedButton;
    btnUtvThBold: TSpeedButton;
    sqlqrySchedule: TSQLQuery;
    lblSoglFirst: TLabel;
    lblSoglSecond: TLabel;
    lblSoglThird: TLabel;
    lblUtvFirst: TLabel;
    lblUtvSecond: TLabel;
    lblUtvThird: TLabel;
    btnTitleFirstBold: TSpeedButton;
    btnTitleFirstLeft: TSpeedButton;
    btnTitleFirstCenter: TSpeedButton;
    btnTitleFirstRight: TSpeedButton;
    btnTitleSecondBold: TSpeedButton;
    btnTitleSecondLeft: TSpeedButton;
    btnTitleSecondCenter: TSpeedButton;
    btnTitleSecondRight: TSpeedButton;
    btnTitleThirdBold: TSpeedButton;
    btnTitleThirdLeft: TSpeedButton;
    btnTitleThirdCenter: TSpeedButton;
    btnTitleThirdRight: TSpeedButton;
    rgShowMarkTime: TRadioGroup;
    btnSend2Excel: TBitBtn;
    grp4: TGroupBox;
    btnOEBossNameBold: TSpeedButton;
    btnOEBossNameLeft: TSpeedButton;
    btnOEBossNameCenter: TSpeedButton;
    btnOEBossNameRight: TSpeedButton;
    lbl1: TLabel;
    lbl2: TLabel;
    btnOEBossBold: TSpeedButton;
    btnOEBossLeft: TSpeedButton;
    btnOEBossCenter: TSpeedButton;
    btnOEBossRight: TSpeedButton;
    btnCancel: TBitBtn;
    bvl1: TBevel;
    pnlLeft: TPanel;
    btnLegendAdd: TSpeedButton;
    btnLegendDel: TSpeedButton;
    btnLegendUp: TSpeedButton;
    btnLegendDown: TSpeedButton;
    chkMarkHolidays: TCheckBox;
    sqlqryHolidays: TSQLQuery;
    chkLegend: TCheckBox;
    chkDoubleLineBetweenMonths: TCheckBox;
    chkWeekendEmpty: TCheckBox;
    lblTitleFirst: TLabel;
    lblTitleSecond: TLabel;
    lblTitleThird: TLabel;
    btnSaveSettings: TSpeedButton;
    btnRestoreSettings: TSpeedButton;
    lblOEBoss: TLabel;
    lblOEBossName: TLabel;
    btnLegendBorders: TSpeedButton;
    splLeft: TSplitter;
    pnlRight: TPanel;
    strgrdLegend: TStringGrid;
    pnlBottom: TPanel;
    lblLegendColumnsFormat: TLabel;
    btnLegendCol1Bold: TSpeedButton;
    btnLegendCol1Left: TSpeedButton;
    btnLegendCol1Center: TSpeedButton;
    btnLegendCol1Right: TSpeedButton;
    btnLegendCol2Bold: TSpeedButton;
    btnLegendCol2Left: TSpeedButton;
    btnLegendCol2Center: TSpeedButton;
    btnLegendCol2Right: TSpeedButton;
    btnLegendCol3Bold: TSpeedButton;
    btnLegendCol3Left: TSpeedButton;
    btnLegendCol3Center: TSpeedButton;
    btnLegendCol3Right: TSpeedButton;
    chkLinesInsideMonth: TCheckBox;
    lblHours: TLabel;
    lblDays: TLabel;
    chkHideSmenaColumn: TCheckBox;
    chkDoNotShowNegativeOvertime: TCheckBox;
    chkNghtTime: TCheckBox;
    chkDoNotShowSumHolNghtEvng: TCheckBox;
    pmUtv: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    pmLegend: TPopupMenu;
    mniLegendAddRow: TMenuItem;
    mniLegendDelRow: TMenuItem;
    N9: TMenuItem;
    mniLegendRowUp: TMenuItem;
    mniLegendRowDown: TMenuItem;
    N12: TMenuItem;
    mniLegendSwitch: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    mniLegendEditCellValue: TMenuItem;
    mniN10: TMenuItem;
    mniN11: TMenuItem;
    procedure btnSoglFBoldClick(Sender: TObject);
    procedure btnSoglFLeftClick(Sender: TObject);
    procedure btnSoglFCenterClick(Sender: TObject);
    procedure btnSoglFRightClick(Sender: TObject);
    procedure lblSoglFirstDblClick(Sender: TObject);
    procedure btnSend2ExcelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lblSoglSecondDblClick(Sender: TObject);
    procedure lblSoglThirdDblClick(Sender: TObject);
    procedure lblUtvFirstDblClick(Sender: TObject);
    procedure lblUtvSecondDblClick(Sender: TObject);
    procedure lblUtvThirdDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnLegendDelClick(Sender: TObject);
    procedure btnLegendUpClick(Sender: TObject);
    procedure btnLegendDownClick(Sender: TObject);
    procedure chkLegendClick(Sender: TObject);
    procedure strgrdLegendDblClick(Sender: TObject);
    procedure btnLegendAddClick(Sender: TObject);
    procedure strgrdLegendDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure rgShowMarkTimeClick(Sender: TObject);
    procedure btnSoglSLeftClick(Sender: TObject);
    procedure btnSoglSCenterClick(Sender: TObject);
    procedure btnSoglSRightClick(Sender: TObject);
    procedure btnSoglSBoldClick(Sender: TObject);
    procedure btnSoglThBoldClick(Sender: TObject);
    procedure btnSoglThLeftClick(Sender: TObject);
    procedure btnSoglThCenterClick(Sender: TObject);
    procedure btnSoglThRightClick(Sender: TObject);
    procedure btnUtvFBoldClick(Sender: TObject);
    procedure btnUtvFLeftClick(Sender: TObject);
    procedure btnUtvFCenterClick(Sender: TObject);
    procedure btnUtvFRightClick(Sender: TObject);
    procedure btnUtvSBoldClick(Sender: TObject);
    procedure btnUtvSLeftClick(Sender: TObject);
    procedure btnUtvSCenterClick(Sender: TObject);
    procedure btnUtvSRightClick(Sender: TObject);
    procedure btnUtvThBoldClick(Sender: TObject);
    procedure btnUtvThLeftClick(Sender: TObject);
    procedure btnUtvThCenterClick(Sender: TObject);
    procedure btnUtvThRightClick(Sender: TObject);
    procedure btnTitleFirstBoldClick(Sender: TObject);
    procedure btnTitleSecondBoldClick(Sender: TObject);
    procedure btnTitleThirdBoldClick(Sender: TObject);
    procedure lblTitleFirstDblClick(Sender: TObject);
    procedure lblTitleSecondDblClick(Sender: TObject);
    procedure lblTitleThirdDblClick(Sender: TObject);
    procedure btnTitleFirstLeftClick(Sender: TObject);
    procedure btnTitleFirstCenterClick(Sender: TObject);
    procedure btnTitleFirstRightClick(Sender: TObject);
    procedure btnTitleSecondLeftClick(Sender: TObject);
    procedure btnTitleSecondCenterClick(Sender: TObject);
    procedure btnTitleSecondRightClick(Sender: TObject);
    procedure btnTitleThirdLeftClick(Sender: TObject);
    procedure btnTitleThirdCenterClick(Sender: TObject);
    procedure btnTitleThirdRightClick(Sender: TObject);
    procedure btnRestoreSettingsClick(Sender: TObject);
    procedure btnSaveSettingsClick(Sender: TObject);
    procedure lblOEBossDblClick(Sender: TObject);
    procedure lblOEBossNameDblClick(Sender: TObject);
    procedure btnOEBossBoldClick(Sender: TObject);
    procedure btnOEBossNameBoldClick(Sender: TObject);
    procedure btnOEBossLeftClick(Sender: TObject);
    procedure btnOEBossCenterClick(Sender: TObject);
    procedure btnOEBossRightClick(Sender: TObject);
    procedure btnOEBossNameLeftClick(Sender: TObject);
    procedure btnOEBossNameCenterClick(Sender: TObject);
    procedure btnOEBossNameRightClick(Sender: TObject);
    procedure btnLegendCol1BoldClick(Sender: TObject);
    procedure chkOvertimeClick(Sender: TObject);
    procedure chkHol023Click(Sender: TObject);
    procedure chkDoNotShowNegativeOvertimeClick(Sender: TObject);
    procedure chkDoNotShowSumHolNghtEvngClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure mniLegendSwitchClick(Sender: TObject);
  private
    { Private declarations }
    lstLegend: TStringList;
    prevOEBoss, prevOEBossName, prevDeptBoss, prevDeptBossName: String;
    prevchkDoNotShowNegativeOvertime, prevchkDoNotShowSumHolNghtEvng: Boolean;
  public
    { Public declarations }
    sScheduleYear, sScheduleType: String;
    iNumOfShifts: Integer;
    strgrdSchedule, strgrdScheduleTime, strgrdScheduleTotal: TStringGrid;
    ShowMarkTime: Boolean;
    procedure FillInLegend(AskIfSavedExist: Boolean = True);
    procedure SaveSettings;
    procedure RestoreSettings(LegendOnly: Boolean = False);
  end;

var
  frmPrintSchedule: TfrmPrintSchedule;

implementation

uses udmMain;

{$R *.dfm}

procedure TfrmPrintSchedule.btnSoglFBoldClick(Sender: TObject);
begin
  case btnSoglFBold.Down of
    True: lblSoglFirst.Font.Style := lblSoglFirst.Font.Style + [fsBold];
    False: lblSoglFirst.Font.Style := lblSoglFirst.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnSoglFLeftClick(Sender: TObject);
begin
  lblSoglFirst.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnSoglFCenterClick(Sender: TObject);
begin
  lblSoglFirst.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnSoglFRightClick(Sender: TObject);
begin
  lblSoglFirst.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.lblSoglFirstDblClick(Sender: TObject);
begin
  lblSoglFirst.Caption := InputBox('Введите новое значение', 'СОГЛАСОВАНО', lblSoglFirst.Caption);
end;

procedure TfrmPrintSchedule.btnSend2ExcelClick(Sender: TObject);
var
  xlApp: TMyExcel;
  i, j, k, l, m, s, iCol, iRow, iFieldsNum, iStatCol, iJustRow: Integer;
  RowValue: array of Variant;
  RowVals: OLEVariant;
  cellAlignment: Alignment;
  holMonth, holDay: Integer;
  MarkWorkTime: String;
  fCellWidth, fCellsWidth: Double;
  sUtvLongestText: String;
  cellLegend1Alignment, cellLegend2Alignment, cellLegend3Alignment: Alignment;
  fTextWidht: Double;
  sMaxCellText: string;
  arLegendStartCols: array [1..3] of Integer;
  arLegendCols: array [1 .. 3] of Integer;
  colOvertime, colHol023, colHol033, colNight, colEvening: Integer;
  arShiftName: TStringList;
begin
  iCol := 1;
  iRow := 13; //Строка, где начинается таблица графика
  iStatCol := 34; //Колонка, с которой начинаются суммарные данные за месяц: часы, дни и т.п.

  //Колонки для переработки, праздничных, вечерних и ночных
  colOvertime := IfThen(chkDoNotShowNegativeOvertime.Checked and chkOvertime.Checked,
                        iStatCol + IfThen(chkCalTime.Checked, 1) + IfThen(chkSchedTime.Checked, 1) +
                        IfThen(chkCalDays.Checked, 1) + IfThen(chkSchedDays.Checked, 1), 0);
  colHol023   := IfThen(chkHol023.Checked,
                        iStatCol + IfThen(chkCalTime.Checked, 1) + IfThen(chkSchedTime.Checked, 1) +
                        IfThen(chkCalDays.Checked, 1) + IfThen(chkSchedDays.Checked, 1) +
                        IfThen(chkOvertime.Checked, 1), 0);
  colHol033   := IfThen(chkHol033.Checked,
                        iStatCol + IfThen(chkCalTime.Checked, 1) + IfThen(chkSchedTime.Checked, 1) +
                        IfThen(chkCalDays.Checked, 1) + IfThen(chkSchedDays.Checked, 1) +
                        IfThen(chkOvertime.Checked, 1) + IfThen(chkHol023.Checked, 1), 0);
  colEvening  := IfThen(chkEvngTime.Checked,
                        iStatCol + IfThen(chkCalTime.Checked, 1) + IfThen(chkSchedTime.Checked, 1) +
                        IfThen(chkCalDays.Checked, 1) + IfThen(chkSchedDays.Checked, 1) +
                        IfThen(chkOvertime.Checked, 1) + IfThen(chkHol023.Checked, 1) +
                        IfThen(chkHol033.Checked, 1), 0);
  colNight    := IfThen(chkNghtTime.Checked,
                        iStatCol + IfThen(chkCalTime.Checked, 1) + IfThen(chkSchedTime.Checked, 1) +
                        IfThen(chkCalDays.Checked, 1) + IfThen(chkSchedDays.Checked, 1) +
                        IfThen(chkOvertime.Checked, 1) + IfThen(chkHol023.Checked, 1) +
                        IfThen(chkHol033.Checked, 1) + IfThen(chkEvngTime.Checked, 1), 0);

  xlApp := TMyExcel.Create;
  xlApp.OpenDocument(ExtractFileDir(Application.ExeName) + '\reports\Schedule.xlt');
  //xlApp.Visible := True;

  //Подготавливаем запрос для получения данных о графике: месяц, смена, суммарные данные (кол-во часов, дней и т.д.)
  with sqlqrySchedule do begin
    Active := False;
    SQL.Clear;
    SQL.Add('select sg.month, sg.id');

    if chkCalTime.Checked then begin
      SQL.Add(', g.time_graf');
      xlApp.SetColumnWidth(iCol + 33, 6);
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkSchedTime.Checked then begin
      SQL.Add(', sg.time_graf');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkCalDays.Checked then begin
      SQL.Add(', g.day_graf');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkSchedDays.Checked then begin
      SQL.Add(', sg.day_graf');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkOvertime.Checked then begin
      SQL.Add(', sg.time_per');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkHol023.Checked then begin
      SQL.Add(', sg.time_pra1');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkHol033.Checked then begin
      SQL.Add(', sg.time_pra2');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkEvngTime.Checked then begin
      SQL.Add(', sg.time_v');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    if chkNghtTime.Checked then begin
      SQL.Add(', sg.time_n');
      inc(iStatCol);
      inc(iCol);
    end
    else
      xlApp.DeleteCol(iStatCol);
    SQL.Add('from qwerty.shift_grafik sg, qwerty.sp_zar_grafik g where to_char(sg.data_graf, ''yyyy'')=''' + sScheduleYear + '''');
    SQL.Add(' and sg.tip=' + sScheduleType + ' and g.data_graf=sg.data_graf and g.tip_smen=0 order by sg.data_graf, sg.id');
    Active := True;

  end;

  iFieldsNum := 33 + sqlqrySchedule.FieldCount - 2;

  SetLength(RowValue, iFieldsNum);

  cellAlignment := my_alLeft;

  //Согласовано
  xlApp.TextXY(lblSoglFirst.Caption, 1, 1);
  xlApp.MergeCells(1, 1, 10, 1, True);
  if btnSoglFCenter.Down then
    cellAlignment := my_alCenter
  else if btnSoglFRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(1, 1, btnSoglFBold.Down, False, False, cellAlignment);

  xlApp.TextXY(lblSoglSecond.Caption, 1, 2);
  xlApp.MergeCells(1, 2, 10, 2, True);
  if btnSoglSCenter.Down then
    cellAlignment := my_alCenter
  else if btnSoglSRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(1, 2, btnSoglSBold.Down, False, False, cellAlignment);

  xlApp.TextXY(lblSoglThird.Caption, 1, 3);
  xlApp.MergeCells(1, 3, 10, 3, True);
  if btnSoglThCenter.Down then
    cellAlignment := my_alCenter
  else if btnSoglThRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(1, 3, btnSoglThBold.Down, False, False, cellAlignment);

  //Утверждаю
  //iCol := ifThen(iCol>5, iFieldsNum-6, iFieldsNum-iCol-2*(5-iCol));

  //Определяем самую длинную надпись из раздела "Утверждаю",
  // чтобы потом по ней определить сколько ячеек влево необходимо объединть для её размещения
  fCellWidth := Length(lblUtvFirst.Caption);
  sUtvLongestText := lblUtvFirst.Caption;
  if Length(lblUtvSecond.Caption) > fCellWidth then begin
    fCellWidth := Length(lblUtvSecond.Caption);
    sUtvLongestText := lblUtvSecond.Caption;
  end;
  if Length(lblUtvThird.Caption) > fCellWidth then begin
    fCellWidth := Length(lblUtvThird.Caption);
    sUtvLongestText := lblUtvThird.Caption;
  end;

  iCol := iFieldsNum;
  xlApp.TextXY(sUtvLongestText, iCol, 1);
  xlApp.FormatCell(iCol, 1, True, False, False, my_alLeft);
  xlApp.xlappExcel.Cells[1, iCol].Select;
  fCellWidth := xlApp.xlappExcel.ActiveCell.ColumnWidth;
  xlApp.xlappExcel.ActiveCell.Columns.AutoFit;
  fCellsWidth := xlApp.xlappExcel.Cells[1, iCol].ColumnWidth;
  xlApp.xlappExcel.Cells[1, iCol].ColumnWidth := fCellWidth;
  for i := 1 to iCol do begin
    fCellWidth := fCellWidth + xlApp.xlappExcel.Cells[1, iCol - 1].ColumnWidth;
    if fCellWidth >= fCellsWidth then
      Break;
  end;

  iCol := iFieldsNum - i;
  xlApp.TextXY(lblUtvFirst.Caption, iCol, 1);
  xlApp.MergeCells(iCol, 1, iFieldsNum, 1, True);
  if btnUtvFCenter.Down then
    cellAlignment := my_alCenter
  else if btnUtvFRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(iCol, 1, btnUtvFBold.Down, False, False, cellAlignment);

  xlApp.TextXY(lblUtvSecond.Caption, iCol, 2);
  xlApp.MergeCells(iCol, 2, iFieldsNum, 2, True);
  if btnUtvSCenter.Down then
    cellAlignment := my_alCenter
  else if btnUtvSRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(iCol, 2, btnUtvSBold.Down, False, False, cellAlignment);

  xlApp.TextXY(lblUtvThird.Caption, iCol, 3);
  xlApp.MergeCells(iCol, 3, iFieldsNum, 3, True);
  if btnUtvThCenter.Down then
    cellAlignment := my_alCenter
  else if btnUtvThRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(iCol, 3, btnUtvThBold.Down, False, False, cellAlignment);

  xlApp.TextXY(AnsiReplaceText(AnsiReplaceText(lblTitleFirst.Caption, '%ГОД%', Self.sScheduleYear), '%YEAR%', Self.sScheduleYear), 1, 4);
  xlApp.MergeCells(1, 4, iFieldsNum, 4, True);
  if btnTitleFirstCenter.Down then
    cellAlignment := my_alCenter
  else if btnTitleFirstRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(1, 4, btnTitleFirstBold.Down, False, False, cellAlignment);
  xlApp.TextXY(AnsiReplaceText(AnsiReplaceText(lblTitleSecond.Caption, '%ГОД%', Self.sScheduleYear), '%YEAR%', Self.sScheduleYear), 1, 5);
  xlApp.MergeCells(1, 5, iFieldsNum, 5, True);
  if btnTitleSecondCenter.Down then
    cellAlignment := my_alCenter
  else if btnTitleSecondRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(1, 5, btnTitleSecondBold.Down, False, False, cellAlignment);
  xlApp.TextXY(AnsiReplaceText(AnsiReplaceText(lblTitleThird.Caption, '%ГОД%', Self.sScheduleYear), '%YEAR%', Self.sScheduleYear), 1, 6);
  xlApp.MergeCells(1, 6, iFieldsNum, 6, True);
  if btnTitleThirdCenter.Down then
    cellAlignment := my_alCenter
  else if btnTitleThirdRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(1, 6, btnTitleThirdBold.Down, False, False, cellAlignment);

  i := iRow;
  k := 1;
  l := 1;

  arShiftName := TStringList.Create;
  for s := 1 to iNumOfShifts do begin
    arShiftName.Add(strgrdSchedule.cells[1, s]);
  end;

  if rgShowMarkTime.ItemIndex = 0 then
    //Печатаем время
    while not (sqlqrySchedule.Eof) do begin
      RowValue[0] := strgrdSchedule.Cells[0, l];
      //Название смены
      //RowValue[1] := strgrdSchedule.Cells[1, l];
      RowValue[1] := IntToStr(arShiftName.IndexOf(strgrdSchedule.Cells[1, l]) + 1);
      for j := 2 to 32 do
      try
        RowValue[j] := TMark(oblstMarkList.Items[GetMarkIndexByID(strgrdSchedule.Cells[j, l])]).WorkTimeStr;
        if RowValue[j] = '0' then
          RowValue[j] := '';
      except
        RowValue[j] := ''
      end;
      for j := 33 to iFieldsNum - 1 do begin
        RowValue[j] := FieldToVariant(sqlqrySchedule.Fields.Fields[j - 31]);
        if RowValue[j] = '0' then
          RowValue[j] := '';
        {
        if chkDoNotShowNegativeOvertime.Checked then
          if sqlqrySchedule.Fields.Fields[j - 31].AsString[1] = '-' then
            RowValue[j] := '';
        }
      end;
      xlApp.RowXY(RowValue, 1, i);
      if (k = iNumOfShifts) and (k <> 1) then begin
        //Объединяем ячейки для месяца
        xlApp.MergeCells(1, i - iNumOfShifts + 1, 1, i, True, my_alCenter);
        //Объединяем ячейчки дла часов по календарю
        xlApp.MergeCells(34, i - iNumOfShifts + 1, 34, i, True, my_alCenter);
        //Объединяем ячейчки дла дней по календарю
        xlApp.MergeCells(36, i - iNumOfShifts + 1, 36, i, True, my_alCenter);
        k := 1;
      end
      else
        inc(k);
      inc(i);
      inc(l);
      sqlqrySchedule.Next;
    end
  else
    //Печатаем отметки
    while not (sqlqrySchedule.Eof) do begin
      RowValue[0] := strgrdSchedule.Cells[0, l];
      //Название смены
      //RowValue[1] := strgrdSchedule.Cells[1, l];
      RowValue[1] := IntToStr(arShiftName.IndexOf(strgrdSchedule.Cells[1, l]) + 1);
      for j := 2 to 32 do
      try
        RowValue[j] := strgrdSchedule.Cells[j, l];
          //Вместо выходных ставим пропуск
        if chkWeekendEmpty.Checked then
          if RowValue[j] = ' В' then
            RowValue[j] := '';
      except
        RowValue[j] := '';
      end;
      for j := 33 to iFieldsNum - 1 do begin
        RowValue[j] := FieldToVariant(sqlqrySchedule.Fields.Fields[j - 31]);
        if RowValue[j] = '0' then
          RowValue[j] := '';
        {
        if chkDoNotShowNegativeOvertime.Checked then
          if sqlqrySchedule.Fields.Fields[j - 31].AsString[1] = '-' then
            RowValue[j] := '';
        }
      end;
      xlApp.RowXY(RowValue, 1, i);
      if (k = iNumOfShifts) and (k <> 1) then begin
        //Объединяем ячейки для месяца
        xlApp.MergeCells(1, i - iNumOfShifts + 1, 1, i, True, my_alCenter);
        //Объединяем ячейки для часов по календарю
        xlApp.MergeCells(34, i - iNumOfShifts + 1, 34, i, True, my_alCenter);
        //Объединяем ячейки для дней по календарю
        xlApp.MergeCells(36, i - iNumOfShifts + 1, 36, i, True, my_alCenter);
        k := 1;
      end
      else
        inc(k);
      inc(i);
      inc(l);
      sqlqrySchedule.Next;
    end;

  //Скрываем отрицательные значения переработки
  if chkDoNotShowNegativeOvertime.Enabled and chkDoNotShowNegativeOvertime.Checked then begin
    xlApp.HideColumnNegativeValues(colOvertime);
  end;

  //xlApp.ColumnsAutoFit(1, 7);
  for j := 0 to iNumOfShifts - 1 do begin
    //Добавляем формулы для подсчета данных за год
    iJustRow := i + j;
    xlApp.AddTotalRow(34, iJustRow, 12, sqlqrySchedule.FieldCount - 2, iNumOfShifts);
    if xlApp.GetTextXY(34, iJustRow) = '0' then begin
      xlApp.CellFormula(34, iJustRow, xlApp.GetTextXY(34, iJustRow - 1));
      xlApp.CellFormula(36, iJustRow, xlApp.GetTextXY(36, iJustRow - 1));
    end;

    if chkDoNotShowNegativeOvertime.Enabled and chkDoNotShowNegativeOvertime.Checked then begin
      xlApp.HideCellValue(colOvertime, iJustRow);
    end;

    if chkDoNotShowSumHolNghtEvng.Enabled and chkDoNotShowSumHolNghtEvng.Checked then begin
      if chkHol023.Checked then
        xlApp.HideCellValue(colHol023, iJustRow);
      if chkHol033.Checked then
        xlApp.HideCellValue(colHol033, iJustRow);
      if chkEvngTime.Checked then
        xlApp.HideCellValue(colEvening, iJustRow);
      if chkNghtTime.Checked then
        xlApp.HideCellValue(colNight, iJustRow);
      //Следующее действие и так выполняется, если стоит галочка "скрывать отрицательную переработку"
      // здесь просто дублируем его на тот случай, когда галочка не установлена, а суммарные данные не нужны
      if chkOvertime.Checked and not(chkDoNotShowNegativeOvertime.Enabled and chkDoNotShowNegativeOvertime.Checked) then
        xlApp.HideCellValue(colOvertime, iJustRow);
    end;
  end;

  //Объединяем ячейки для часов по календарю
  if chkCalTime.Checked then begin
    xlApp.MergeCells(34, i, 34, iJustRow, True, my_alCenter);
    xlApp.SetFontSize(34, i, xlApp.GetFontSize(35, i));
  end;
  //Объединяем ячейки для дней по календарю
  if chkCalDays.Checked then begin
    xlApp.MergeCells(36, i, 36, iJustRow, True, my_alCenter);
    xlApp.SetFontSize(36, i, xlApp.GetFontSize(35, i));
  end;

  //Выделяем праздники
  if chkMarkHolidays.Checked then begin
    sqlqryHolidays.ParamByName('YEAR').AsString := sScheduleYear;
    sqlqryHolidays.Active := True;
    while not (sqlqryHolidays.Eof) do begin
      holDay := DayOf(sqlqryHolidays.Fields.Fields[0].AsDateTime);
      holMonth := MonthOf(sqlqryHolidays.Fields.Fields[0].AsDateTime);
      xlApp.xlappExcel.Range[xlApp.xlappExcel.Cells[iRow + (holMonth - 1) * iNumOfShifts, 2 + holDay], xlApp.xlappExcel.Cells[iRow + (holMonth - 1) * iNumOfShifts + iNumOfShifts - 1, 2 + holDay]].Select;
      xlApp.xlappExcel.Selection.Interior.ColorIndex := 15;
      xlApp.xlappExcel.Selection.Interior.Pattern := 1;
      sqlqryHolidays.Next;
    end;
    sqlqryHolidays.Active := False;
  end;

  //Рисуем рамку вокруг дней
  //xlApp.RangeBorders(1, iRow, Length(RowValue), iRow+12*iNumOfShifts-1, True, True, True, True)
  // с разделителем месяцев (по желанию пользователя)
  xlApp.RangeBorders(1, iRow, Length(RowValue), iRow + 12 * iNumOfShifts - 1, True, True, True, True, iNumOfShifts, IfThen(chkDoubleLineBetweenMonths.Checked, xlDouble, xlContinuous), IfThen(chkDoubleLineBetweenMonths.Checked, xlMedium, xlThin));
  //Убираем линии внутри месяца
  if not(chkLinesInsideMonth.Checked) then begin
    for i := 0 to 11 do
      xlApp.RangeBorders(3, iRow + iNumOfShifts * i, 33, iRow + iNumOfShifts * (i + 1) - 1, True, True, True, True, False, False);
  end;
  //Рисуем рамку вокруг суммарных данных
  if chkDoNotShowSumHolNghtEvng.Checked then
    xlApp.RangeBorders(34, iRow + 12 * iNumOfShifts,
                       Length(RowValue) - IfThen(chkDoNotShowSumHolNghtEvng.Checked, IfThen(chkOvertime.Checked, 1, 0) +
                                                                                     IfThen(chkHol023.Checked, 1, 0) +
                                                                                     IfThen(chkHol033.Checked, 1, 0) +
                                                                                     IfThen(chkEvngTime.Checked, 1, 0) +
                                                                                     IfThen(chkNghtTime.Checked, 1, 0),
                                                0), iRow + 12 * iNumOfShifts + j - 1, True, True, True, True)
  else
    xlApp.RangeBorders(34, iRow + 12 * iNumOfShifts, Length(RowValue), iRow + 12 * iNumOfShifts + j - 1, True, True, True, True);
  //Выделяем название смены жирным
  for l := 0 to 12 * iNumOfShifts - 1 do
    xlApp.FormatCell(2, iRow + l, True, False, False, my_alCenter);

  {Печать легенды}
  if chkLegend.Checked then begin
    //Определяем выравнивание колонок легенды
    if btnLegendCol1Right.Down then
      cellLegend1Alignment := my_alRight
    else
      if btnLegendCol1Center.Down then
        cellLegend1Alignment := my_alCenter
      else
        cellLegend1Alignment := my_alLeft;
    if btnLegendCol2Right.Down then
      cellLegend2Alignment := my_alRight
    else
      if btnLegendCol2Center.Down then
        cellLegend2Alignment := my_alCenter
      else
        cellLegend2Alignment := my_alLeft;
    if btnLegendCol3Right.Down then
      cellLegend3Alignment := my_alRight
    else
      if btnLegendCol3Center.Down then
        cellLegend3Alignment := my_alCenter
      else
        cellLegend3Alignment := my_alLeft;

    l := iRow + 12 * iNumOfShifts + 1;
    m := l;

    arLegendStartCols[1] := 3;
    arLegendStartCols[2] := 8;
    arLegendStartCols[3] := 15;
    arLegendCols[1] := 0;
    arLegendCols[2] := 0;
    arLegendCols[3] := 0;
    //Определяем сколько ячеек по ширине необходимо для отображения легенды
    for j := 1 to 3 do begin
      fCellWidth := 0;
      sMaxCellText := '';
      fCellsWidth := 0;
      for i := 0 to strgrdLegend.RowCount - 1 do
        if Canvas.TextWidth(strgrdLegend.Cells[j - 1, i]) > fCellWidth then begin
          fCellWidth := Canvas.TextWidth(strgrdLegend.Cells[j - 1, i]);
          sMaxCellText := strgrdLegend.Cells[j - 1, i];
        end;
      xlApp.TextXY(sMaxCellText, arLegendStartCols[j], l);
      xlApp.xlappExcel.Cells[l, arLegendStartCols[j]].Select;
      fCellWidth := xlApp.xlappExcel.ActiveCell.ColumnWidth;
      xlApp.xlappExcel.ActiveCell.Columns.AutoFit;
      fCellsWidth := xlApp.xlappExcel.ActiveCell.ColumnWidth;
      xlApp.xlappExcel.ActiveCell.ColumnWidth := fCellWidth;
      for k := 1 to 100 do begin
        fCellWidth := fCellWidth + xlApp.xlappExcel.Cells[l, arLegendStartCols[j] + k].ColumnWidth;
        if fCellWidth >= fCellsWidth then
          Break;
      end;
      arLegendCols[j] := k;
      try
        arLegendStartCols[j + 1] := arLegendStartCols[j] + arLegendCols[j] + 1;
      except

      end;
    end;

    if rgShowMarkTime.ItemIndex = 0 then begin
    //Печатаем время
      for i := 0 to strgrdLegend.RowCount - 1 do begin
        xlApp.MergeCells(arLegendStartCols[1], l, arLegendStartCols[2] - 1, l, True, my_alCenter, cellLegend1Alignment);
        try
          MarkWorkTime := TMark(oblstMarkList.Items[GetMarkIndexByID(strgrdLegend.Cells[0, i])]).WorkTimeStr;
        except
          MarkWorkTime := strgrdLegend.Cells[0, i];
        end;
        if not ((MarkWorkTime = '0') or (MarkWorkTime = '')) then begin
          xlApp.TextXY(MarkWorkTime, arLegendStartCols[1], l);
          xlApp.FormatCell(arLegendStartCols[1], l, btnLegendCol1Bold.Down, False, False, cellLegend1Alignment);
          xlApp.MergeCells(arLegendStartCols[2], l, arLegendStartCols[3] - 1, l, True, my_alCenter, cellLegend2Alignment);
          xlApp.TextXY(strgrdLegend.Cells[1, i], arLegendStartCols[2], l);
          xlApp.FormatCell(arLegendStartCols[2], l, btnLegendCol2Bold.Down, False, False, cellLegend2Alignment);
          xlApp.MergeCells(arLegendStartCols[3], l, arLegendStartCols[3] + arLegendCols[3], l, True, my_alCenter, cellLegend3Alignment);
          xlApp.TextXY(strgrdLegend.Cells[2, i], arLegendStartCols[3], l);
          xlApp.FormatCell(arLegendStartCols[3], l, btnLegendCol3Bold.Down, False, False, cellLegend3Alignment);
          inc(l);
        end;
      end;
    end
    else
    //Печатаем отметки
      for i := 0 to strgrdLegend.RowCount - 1 do begin
        xlApp.MergeCells(arLegendStartCols[1], l, arLegendStartCols[2] - 1, l, True, my_alCenter, cellLegend1Alignment);
        xlApp.TextXY(strgrdLegend.Cells[0, i], arLegendStartCols[1], l);
        xlApp.FormatCell(arLegendStartCols[1], l, btnLegendCol1Bold.Down, False, False, cellLegend1Alignment);
        xlApp.MergeCells(arLegendStartCols[2], l, arLegendStartCols[3] - 1, l, True, my_alCenter, cellLegend2Alignment);
        xlApp.TextXY(strgrdLegend.Cells[1, i], arLegendStartCols[2], l);
        xlApp.FormatCell(arLegendStartCols[2], l, btnLegendCol2Bold.Down, False, False, cellLegend2Alignment);
        xlApp.MergeCells(arLegendStartCols[3], l, arLegendStartCols[3] + arLegendCols[3], l, True, my_alCenter, cellLegend3Alignment);
        xlApp.TextXY(strgrdLegend.Cells[2, i], arLegendStartCols[3], l);
        xlApp.FormatCell(arLegendStartCols[3], l, btnLegendCol3Bold.Down, False, False, cellLegend3Alignment);
        inc(l);
      end;
    //if btnLegendBorders.Down then
    //  xlApp.RangeBorders(3, m, 20, l - 1, True, True, True, True, True, False);
    //l := l+i+2;

    //Рамка вокруг легенды
    if btnLegendBorders.Down then
      xlApp.RangeBorders(arLegendStartCols[1], m, arLegendStartCols[3], l - 1, True, True, True, True, True, False);

    inc(l);
    if l < (iRow + 12 * iNumOfShifts + j) then
      l := iRow + 12 * iNumOfShifts + j;
  end
  else
    l := iRow + 12 * iNumOfShifts + j + 1;

  //Подписи
  //l := iRow+12*iNumOfShifts+j;
  xlApp.TextXY(lblOEBoss.Caption, 1, l);
  xlApp.MergeCells(1, l, 10, l, True);
  if btnOEBossCenter.Down then
    cellAlignment := my_alCenter
  else if btnOEBossRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(1, l, btnOEBossBold.Down, False, False, cellAlignment, 12);
  xlApp.TextXY(lblOEBossName.Caption, 17, l);
  xlApp.MergeCells(17, l, 27, l, True);
  if btnOEBossNameCenter.Down then
    cellAlignment := my_alCenter
  else if btnOEBossNameRight.Down then
    cellAlignment := my_alRight
  else
    cellAlignment := my_alLeft;
  xlApp.FormatCell(17, l, btnOEBossNameBold.Down, False, False, cellAlignment, 12);

  {//Подпись начальника подразделения
  if (edDeptBoss.Text<>'') or (edDeptBossName.Text<>'') then begin
    l := l+2;
    xlApp.TextXY(edDeptBoss.Text, 1, l);
    xlApp.MergeCells(1, l, 10, l, True);
    if btnDeptBossCenter.Down then
      cellAlignment := my_alCenter
    else
      if btnDeptBossRight.Down then
        cellAlignment := my_alRight
      else
        cellAlignment := my_alLeft;
    xlApp.FormatCell(1, l, btnDeptBossBold.Down, False, False, cellAlignment, 12);
    xlApp.TextXY(edDeptBossName.Text, 17, l);
    xlApp.MergeCells(17, l, 27, l, True);
    if btnDeptBossNameCenter.Down then
      cellAlignment := my_alCenter
    else
      if btnDeptBossNameRight.Down then
        cellAlignment := my_alRight
      else
        cellAlignment := my_alLeft;
    xlApp.FormatCell(17, l, btnDeptBossNameBold.Down, False, False, cellAlignment, 12);
  end;
  }

  //Скрываем колонку "Смена"
  if chkHideSmenaColumn.Checked then begin
    //xlApp.xlappExcel.Cells[l + 1, 2].Select;
    //xlApp.xlappExcel.Selection.EntireColumn.Hidden := True;
    xlApp.HideColumn(2, l + 1);
  end;

  //Добавляем несколько строк перед названием графика (чтобы как-то отцентровать по вертикали расположение графика на печатном листе
  xlApp.xlappExcel.Rows['4:4'].Select;
  for i := iNumOfShifts + 1 to 4 do
    xlApp.xlappExcel.Selection.Insert(Shift := -4121 {xlDown}, CopyOrigin := 0 {xlFormatFromLeftOrAbove});

  xlApp.xlappExcel.Cells[iRow - 1, 1].Select;
  sqlqrySchedule.Active := False;
  xlApp.Visible := True;

  xlApp.Free;
  SaveSettings;
  arShiftName.Free;
  Close;
end;

procedure TfrmPrintSchedule.FillInLegend(AskIfSavedExist: Boolean = True);
var
  i, j: Integer;
  mrkMark: TMark;
begin
  if (strgrdLegend.Cells[0, 0] <> '') and AskIfSavedExist then
    if Application.MessageBox('Найдена ранее сохраненная легенда:' + #13#10 + '  если хотите оставить сохраненные значения, нажмите "Да"' + #10#13 + '  перезаписать её стандартными значениями - нажмите "Нет"', 'Легенда', MB_YESNO) = ID_YES then begin
      strgrdLegend.Color := clInfoBk;
      Exit;
    end;

  if not(Assigned(lstLegend)) then
    lstLegend := TStringList.Create;

  for i:=1 to 12 do
    for j:=2 to 32 do
      if (strgrdSchedule.Cells[j, i]<>'  ') and (lstLegend.IndexOf(strgrdSchedule.Cells[j, i])=-1) then
        lstLegend.Add(strgrdSchedule.Cells[j, i]);
  lstLegend.Sort;

  strgrdLegend.RowCount := 2;
  strgrdLegend.Cells[0, 0] := 'Отметка';
  strgrdLegend.ColWidths[0] := strgrdLegend.Canvas.TextWidth(strgrdLegend.Cells[0, 0])+15;
  strgrdLegend.Cells[1, 0] := 'Время работы';
  strgrdLegend.ColWidths[1] := strgrdLegend.Canvas.TextWidth(strgrdLegend.Cells[1, 0])+15;
  strgrdLegend.Cells[2, 0] := 'Обед';
  for i:=1 to lstLegend.Count do begin
    try
      mrkMark := TMark(oblstMarkList.Items[GetMarkIndexByID(lstLegend.Strings[i-1])]);
      strgrdLegend.Cells[0, i] := mrkMark.MarkID;
      strgrdLegend.Cells[1, i] := mrkMark.Description;
      if strgrdLegend.ColWidths[1]<strgrdLegend.Canvas.TextWidth(strgrdLegend.Cells[1, i])+15 then
        strgrdLegend.ColWidths[1] := strgrdLegend.Canvas.TextWidth(strgrdLegend.Cells[1, i])+15;
      strgrdLegend.Cells[2, i] := ifThen(mrkMark.LunchTime=0, '', ifThen(mrkMark.LunchTime<60, IntToStr(mrkMark.LunchTime)+'мин.', IntToStr(Trunc(mrkMark.LunchTime/60))+'ч. '+ifThen((mrkMark.LunchTime mod 60)=0, '', IntToStr(mrkMark.LunchTime mod 60)+'мин.')));
    except

    end;
    if strgrdLegend.ColWidths[2]<strgrdLegend.Canvas.TextWidth(strgrdLegend.Cells[2, i])+15 then
      strgrdLegend.ColWidths[2] := strgrdLegend.Canvas.TextWidth(strgrdLegend.Cells[2, i])+15;
    strgrdLegend.RowCount    := strgrdLegend.RowCount+1;
  end;
  strgrdLegend.RowCount := strgrdLegend.RowCount-1;
  strgrdLegend.Color := clMoneyGreen;
  mniLegendSwitch.Tag := 1;
end;

procedure TfrmPrintSchedule.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  try
    if Assigned(lstLegend) then
      lstLegend.Free;
  except

  end;
end;

procedure TfrmPrintSchedule.lblSoglSecondDblClick(Sender: TObject);
begin
  lblSoglSecond.Caption := InputBox('Введите новое значение', 'Должность', lblSoglSecond.Caption);
end;

procedure TfrmPrintSchedule.lblSoglThirdDblClick(Sender: TObject);
begin
  lblSoglThird.Caption := InputBox('Введите новое значение', 'И.О. Фамилия', lblSoglThird.Caption);
end;

procedure TfrmPrintSchedule.lblUtvFirstDblClick(Sender: TObject);
begin
  lblUtvFirst.Caption := InputBox('Введите новое значение', 'УТВЕРЖДАЮ', lblUtvFirst.Caption);
end;

procedure TfrmPrintSchedule.lblUtvSecondDblClick(Sender: TObject);
begin
  lblUtvSecond.Caption := InputBox('Введите новое значение', 'Должность', lblUtvSecond.Caption);
end;

procedure TfrmPrintSchedule.lblUtvThirdDblClick(Sender: TObject);
begin
  lblUtvThird.Caption := InputBox('Введите новое значение', 'И.О. Фамилия', lblUtvThird.Caption);
end;

procedure TfrmPrintSchedule.FormCreate(Sender: TObject);
begin
  prevOEBoss       := '';
  prevOEBossName   := '';
  prevDeptBoss     := '';
  prevDeptBossName := '';
end;

procedure TfrmPrintSchedule.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrintSchedule.RestoreSettings(LegendOnly: Boolean = False);
var
  iniF: TIniFile;
  i, j: Integer;
begin
  iniF := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\reports\rep_sets.ini');
  try
    if not(LegendOnly) then begin
      lblSoglFirst.Caption := iniF.ReadString(self.sScheduleType, 'Sogl1', 'СОГЛАСОВАНО');
      btnSoglFBold.Down := iniF.ReadBool(self.sScheduleType, 'Sogl1B', True);
      if btnSoglFBold.Down then
        lblSoglFirst.Font.Style := lblSoglFirst.Font.Style + [fsBold];
      btnSoglFLeft.Down := iniF.ReadBool(self.sScheduleType, 'Sogl1L', True);
      if btnSoglFLeft.Down then
        lblSoglFirst.Alignment := taLeftJustify;
      btnSoglFCenter.Down := iniF.ReadBool(self.sScheduleType, 'Sogl1C', False);
      if btnSoglFCenter.Down then
        lblSoglFirst.Alignment := taCenter;
      btnSoglFRight.Down := iniF.ReadBool(self.sScheduleType, 'Sogl1R', False);
      if btnSoglFRight.Down then
        lblSoglFirst.Alignment := taRightJustify;

      lblSoglSecond.Caption := iniF.ReadString(self.sScheduleType, 'Sogl2', 'Председатель профкома');
      btnSoglSBold.Down := iniF.ReadBool(self.sScheduleType, 'Sogl2B', True);
      if btnSoglSBold.Down then
        lblSoglSecond.Font.Style := lblSoglSecond.Font.Style + [fsBold];
      btnSoglSLeft.Down := iniF.ReadBool(self.sScheduleType, 'Sogl2L', True);
      if btnSoglSLeft.Down then
        lblSoglSecond.Alignment := taLeftJustify;
      btnSoglSCenter.Down := iniF.ReadBool(self.sScheduleType, 'Sogl2C', False);
      if btnSoglSCenter.Down then
        lblSoglSecond.Alignment := taCenter;
      btnSoglSRight.Down := iniF.ReadBool(self.sScheduleType, 'Sogl2R', False);
      if btnSoglSRight.Down then
        lblSoglSecond.Alignment := taRightJustify;

      lblSoglThird.Caption := iniF.ReadString(self.sScheduleType, 'Sogl3', 'В.Я. Дрибноход');
      btnSoglThBold.Down := iniF.ReadBool(self.sScheduleType, 'Sogl3B', True);
      if btnSoglThBold.Down then
        lblSoglThird.Font.Style := lblSoglThird.Font.Style + [fsBold];
      btnSoglThLeft.Down := iniF.ReadBool(self.sScheduleType, 'Sogl3L', False);
      if btnSoglThLeft.Down then
        lblSoglThird.Alignment := taLeftJustify;
      btnSoglThCenter.Down := iniF.ReadBool(self.sScheduleType, 'Sogl3C', False);
      if btnSoglThCenter.Down then
        lblSoglThird.Alignment := taCenter;
      btnSoglThRight.Down := iniF.ReadBool(self.sScheduleType, 'Sogl3R', True);
      if btnSoglThRight.Down then
        lblSoglThird.Alignment := taRightJustify;


      lblUtvFirst.Caption := iniF.ReadString(self.sScheduleType, 'Utv1', 'УТВЕРЖДАЮ');
      btnUtvFBold.Down := iniF.ReadBool(self.sScheduleType, 'Utv1B', True);
      if btnUtvFBold.Down then
        lblUtvFirst.Font.Style := lblUtvFirst.Font.Style + [fsBold];
      btnUtvFLeft.Down := iniF.ReadBool(self.sScheduleType, 'Utv1L', True);
      if btnUtvFLeft.Down then
        lblUtvFirst.Alignment := taLeftJustify;
      btnUtvFCenter.Down := iniF.ReadBool(self.sScheduleType, 'Utv1C', False);
      if btnUtvFCenter.Down then
        lblUtvFirst.Alignment := taCenter;
      btnUtvFRight.Down := iniF.ReadBool(self.sScheduleType, 'Utv1R', False);
      if btnUtvFRight.Down then
        lblUtvFirst.Alignment := taRightJustify;

      lblUtvSecond.Caption := iniF.ReadString(self.sScheduleType, 'Utv2', 'Председатель правления - директор');
      btnUtvSBold.Down := iniF.ReadBool(self.sScheduleType, 'Utv2B', True);
      if btnUtvSBold.Down then
        lblUtvSecond.Font.Style := lblUtvSecond.Font.Style + [fsBold];
      btnUtvSLeft.Down := iniF.ReadBool(self.sScheduleType, 'Utv2L', True);
      if btnUtvSLeft.Down then
        lblUtvSecond.Alignment := taLeftJustify;
      btnUtvSCenter.Down := iniF.ReadBool(self.sScheduleType, 'Utv2C', False);
      if btnUtvSCenter.Down then
        lblUtvSecond.Alignment := taCenter;
      btnUtvSRight.Down := iniF.ReadBool(self.sScheduleType, 'Utv2R', False);
      if btnUtvSRight.Down then
        lblUtvSecond.Alignment := taRightJustify;

      lblUtvThird.Caption := iniF.ReadString(self.sScheduleType, 'Utv3', 'В.С. Горбатко');
      btnUtvThBold.Down := iniF.ReadBool(self.sScheduleType, 'Utv3B', True);
      if btnUtvThBold.Down then
        lblUtvThird.Font.Style := lblUtvThird.Font.Style + [fsBold];
      btnUtvThLeft.Down := iniF.ReadBool(self.sScheduleType, 'Utv3L', False);
      if btnUtvThLeft.Down then
        lblUtvThird.Alignment := taLeftJustify;
      btnUtvThCenter.Down := iniF.ReadBool(self.sScheduleType, 'Utv3C', False);
      if btnUtvThCenter.Down then
        lblUtvThird.Alignment := taCenter;
      btnUtvThRight.Down := iniF.ReadBool(self.sScheduleType, 'Utv3R', True);
      if btnUtvThRight.Down then
        lblUtvThird.Alignment := taRightJustify;


      lblTitleFirst.Caption := iniF.ReadString(self.sScheduleType, 'Title1', TSchedule(oblstScheduleList.Items[GetScheduleIndexByType(StrToInt(sScheduleType))]).NameU);
      btnTitleFirstBold.Down := iniF.ReadBool(self.sScheduleType, 'Title1B', True);
      if btnTitleFirstBold.Down then
        lblTitleFirst.Font.Style := lblTitleFirst.Font.Style + [fsBold];
      btnTitleFirstLeft.Down := iniF.ReadBool(self.sScheduleType, 'Title1L', False);
      if btnTitleFirstLeft.Down then
        lblTitleFirst.Alignment := taLeftJustify;
      btnTitleFirstCenter.Down := iniF.ReadBool(self.sScheduleType, 'Title1C', True);
      if btnTitleFirstCenter.Down then
        lblTitleFirst.Alignment := taCenter;
      btnTitleFirstRight.Down := iniF.ReadBool(self.sScheduleType, 'Title1R', False);
      if btnTitleFirstRight.Down then
        lblTitleFirst.Alignment := taRightJustify;

      lblTitleSecond.Caption := iniF.ReadString(self.sScheduleType, 'Title2', TSchedule(oblstScheduleList.Items[GetScheduleIndexByType(StrToInt(sScheduleType))]).NameR);
      btnTitleSecondBold.Down := iniF.ReadBool(self.sScheduleType, 'Title2B', True);
      if btnTitleSecondBold.Down then
        lblTitleSecond.Font.Style := lblTitleSecond.Font.Style + [fsBold];
      btnTitleSecondLeft.Down := iniF.ReadBool(self.sScheduleType, 'Title2L', False);
      if btnTitleSecondLeft.Down then
        lblTitleSecond.Alignment := taLeftJustify;
      btnTitleSecondCenter.Down := iniF.ReadBool(self.sScheduleType, 'Title2C', True);
      if btnTitleSecondCenter.Down then
        lblTitleSecond.Alignment := taCenter;
      btnTitleSecondRight.Down := iniF.ReadBool(self.sScheduleType, 'Title2R', False);
      if btnTitleSecondRight.Down then
        lblTitleSecond.Alignment := taRightJustify;

      lblTitleThird.Caption := iniF.ReadString(self.sScheduleType, 'Title3', 'на '+self.sScheduleYear+' год');
      btnTitleThirdBold.Down := iniF.ReadBool(self.sScheduleType, 'Title3B', True);
      if btnTitleThirdBold.Down then
        lblTitleThird.Font.Style := lblTitleThird.Font.Style + [fsBold];
      btnTitleThirdLeft.Down := iniF.ReadBool(self.sScheduleType, 'Title3L', False);
      if btnTitleThirdLeft.Down then
        lblTitleThird.Alignment := taLeftJustify;
      btnTitleThirdCenter.Down := iniF.ReadBool(self.sScheduleType, 'Title3C', True);
      if btnTitleThirdCenter.Down then
        lblTitleThird.Alignment := taCenter;
      btnTitleThirdRight.Down := iniF.ReadBool(self.sScheduleType, 'Title3R', False);
      if btnTitleThirdRight.Down then
        lblTitleThird.Alignment := taRightJustify;

      rgShowMarkTime.ItemIndex := iniF.ReadInteger(self.sScheduleType, 'ShowMarkTime', 0);

      chkCalTime.Checked                    := iniF.ReadBool(self.sScheduleType, 'CalTime', True);
      chkSchedTime.Checked                  := iniF.ReadBool(self.sScheduleType, 'SchedTime', True);
      chkCalDays.Checked                    := iniF.ReadBool(self.sScheduleType, 'CalDays', True);
      chkSchedDays.Checked                  := iniF.ReadBool(self.sScheduleType, 'SchedDays', True);
      chkOvertime.Checked                   := iniF.ReadBool(self.sScheduleType, 'OverTime', True);
      chkHol023.Checked                     := iniF.ReadBool(self.sScheduleType, 'Hol023', True);
      chkHol033.Checked                     := iniF.ReadBool(self.sScheduleType, 'Hol033', True);
      chkEvngTime.Checked                   := iniF.ReadBool(self.sScheduleType, 'EvngTime', True);
      chkNghtTime.Checked                   := iniF.ReadBool(self.sScheduleType, 'NghtTime', True);
      chkMarkHolidays.Checked               := iniF.ReadBool(self.sScheduleType, 'MarkHolidays', True);
      chkWeekendEmpty.Checked               := iniF.ReadBool(Self.sScheduleType, 'WeekendEmpty', True);
      chkDoubleLineBetweenMonths.Checked    := iniF.ReadBool(Self.sScheduleType, 'BoldDelimiter', False);
      chkLinesInsideMonth.Checked           := iniF.ReadBool(self.sScheduleType, 'LinesInsideMonth', iNumOfShifts = 1);
      chkHideSmenaColumn.Checked            := iniF.ReadBool(self.sScheduleType, 'HideSmenaColumn', iNumOfShifts = 1);
      chkDoNotShowNegativeOvertime.Checked  := iniF.ReadBool(self.sScheduleType, 'DoNotShowNegativeOvertime', True);
      prevchkDoNotShowNegativeOvertime      := chkDoNotShowNegativeOvertime.Checked;
      chkDoNotShowSumHolNghtEvng.Checked    := iniF.ReadBool(self.sScheduleType, 'DoNotShowSumHolNghtEvng', True);
      prevchkDoNotShowSumHolNghtEvng        := chkDoNotShowSumHolNghtEvng.Checked;

      lblOEBoss.Caption := iniF.ReadString(self.sScheduleType, 'OEBoss', 'Начальник ОЭ');
      lblOEBossName.Caption := iniF.ReadString(self.sScheduleType, 'OEBossName', 'В.Я. Вакеряк');
      //edDeptBoss.Text := iniF.ReadString(self.sScheduleType, 'DeptBoss', '');
      //edDeptBossName.Text := iniF.ReadString(self.sScheduleType, 'DeptBossName', '');
      btnOEBossBold.Down := iniF.ReadBool(self.sScheduleType, 'OEBossB', True);
      if btnOEBossBold.Down then
        lblOEBoss.Font.Style := lblOEBoss.Font.Style + [fsBold];
      btnOEBossLeft.Down := iniF.ReadBool(self.sScheduleType, 'OEBossL', False);
      if btnOEBossLeft.Down then
        lblOEBoss.Alignment := taLeftJustify;
      btnOEBossCenter.Down := iniF.ReadBool(self.sScheduleType, 'OEBossC', False);
      if btnOEBossCenter.Down then
        lblOEBoss.Alignment := taCenter;
      btnOEBossRight.Down := iniF.ReadBool(self.sScheduleType, 'OEBossR', True);
      if btnOEBossRight.Down then
        lblOEBoss.Alignment := taRightJustify;
      btnOEBossNameBold.Down := iniF.ReadBool(self.sScheduleType, 'OEBossNameB', True);
      if btnOEBossNameBold.Down then
        lblOEBossName.Font.Style := lblOEBossName.Font.Style + [fsBold];
      btnOEBossNameLeft.Down := iniF.ReadBool(self.sScheduleType, 'OEBossNameL', True);
      if btnOEBossNameLeft.Down then
        lblOEBossName.Alignment := taLeftJustify;
      btnOEBossNameCenter.Down := iniF.ReadBool(self.sScheduleType, 'OEBossNameC', False);
      if btnOEBossNameCenter.Down then
        lblOEBossName.Alignment := taCenter;
      btnOEBossNameRight.Down := iniF.ReadBool(self.sScheduleType, 'OEBossNameR', False);
      if btnOEBossNameRight.Down then
        lblOEBossName.Alignment := taRightJustify;
      //btnDeptBossBold.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossB', True);
      //btnDeptBossLeft.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossL', False);
      //btnDeptBossCenter.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossC', False);
      //btnDeptBossRight.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossR', True);
      //btnDeptBossNameBold.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossNameB', True);
      //btnDeptBossNameLeft.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossNameL', True);
      //btnDeptBossNameCenter.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossNameC', False);
      //btnDeptBossNameRight.Down := iniF.ReadBool(self.sScheduleType, 'DeptBossNameR', False);
    end;

    //Легенда
    chkLegend.Checked := iniF.ReadBool(self.sScheduleType, 'PrintLegend', True);
    grpboxLegend.Enabled := chkLegend.Checked;

    //Печатать легенду
    strgrdLegend.RowCount := iniF.ReadInteger(self.sScheduleType, 'LegendNumOfRows', 2);
    strgrdLegend.ColCount := iniF.ReadInteger(Self.sScheduleType, 'LegendNumOfCols', 3);
    btnLegendBorders.Down := iniF.ReadBool(self.sScheduleType, 'LegendPrintBorders', False);
    for i := 0 to strgrdLegend.RowCount - 1 do
      for j := 0 to strgrdLegend.ColCount - 1 do begin
        try
          strgrdLegend.Cells[j, i] := iniF.ReadString(Self.sScheduleType, 'LegendCell_' + IntToStr(i) + '_' + IntToStr(j), '');
          strgrdLegend.ColWidths[j] := Max(strgrdLegend.ColWidths[j], Canvas.TextWidth(strgrdLegend.Cells[j, i]) + 20)
        except

        end;
      end;
    btnLegendCol1Bold.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol1Bold', False);
    btnLegendCol1Left.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol1Left', True);
    btnLegendCol1Center.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol1Center', False);
    btnLegendCol1Right.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol1Right', False);

    btnLegendCol2Bold.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol2Bold', False);
    btnLegendCol2Left.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol2Left', True);
    btnLegendCol2Center.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol2Center', False);
    btnLegendCol2Right.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol2Right', False);

    btnLegendCol3Bold.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol3Bold', False);
    btnLegendCol3Left.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol3Left', True);
    btnLegendCol3Center.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol3Center', False);
    btnLegendCol3Right.Down := iniF.ReadBool(self.sScheduleType, 'LegendCol3Right', False);

    if not(LegendOnly) then
      FillInLegend;
  finally
    iniF.Free;
  end;
end;

procedure TfrmPrintSchedule.SaveSettings;
var
  iniF: TIniFile;
  i, j: Integer;
begin
  iniF := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\reports\rep_sets.ini');
  try
    //Солгасовано
    iniF.WriteString(self.sScheduleType, 'Sogl1', lblSoglFirst.Caption);
    iniF.WriteString(self.sScheduleType, 'Sogl2', lblSoglSecond.Caption);
    iniF.WriteString(self.sScheduleType, 'Sogl3', lblSoglThird.Caption);
    iniF.WriteBool(self.sScheduleType, 'Sogl1B', btnSoglFBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl1L', btnSoglFLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl1C', btnSoglFCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl1R', btnSoglFRight.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl2B', btnSoglSBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl2L', btnSoglSLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl2C', btnSoglSCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl2R', btnSoglSRight.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl3B', btnSoglThBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl3L', btnSoglThLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl3C', btnSoglThCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Sogl3R', btnSoglThRight.Down);

    //Утверждаю
    iniF.WriteString(self.sScheduleType, 'Utv1', lblUtvFirst.Caption);
    iniF.WriteString(self.sScheduleType, 'Utv2', lblUtvSecond.Caption);
    iniF.WriteString(self.sScheduleType, 'Utv3', lblUtvThird.Caption);
    iniF.WriteBool(self.sScheduleType, 'Utv1B', btnUtvFBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv1L', btnUtvFLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv1C', btnUtvFCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv1R', btnUtvFRight.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv2B', btnUtvSBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv2L', btnUtvSLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv2C', btnUtvSCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv2R', btnUtvSRight.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv3B', btnUtvThBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv3L', btnUtvThLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv3C', btnUtvThCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Utv3R', btnUtvThRight.Down);

    //Заголовок
    iniF.WriteString(self.sScheduleType, 'Title1', lblTitleFirst.Caption);
    iniF.WriteString(self.sScheduleType, 'Title2', lblTitleSecond.Caption);
    iniF.WriteString(self.sScheduleType, 'Title3', lblTitleThird.Caption);
    iniF.WriteBool(self.sScheduleType, 'Title1B', btnTitleFirstBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Title1L', btnTitleFirstLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Title1C', btnTitleFirstCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Title1R', btnTitleFirstRight.Down);
    iniF.WriteBool(self.sScheduleType, 'Title2B', btnTitleSecondBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Title2L', btnTitleSecondLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Title2C', btnTitleSecondCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Title2R', btnTitleSecondRight.Down);
    iniF.WriteBool(self.sScheduleType, 'Title3B', btnTitleThirdBold.Down);
    iniF.WriteBool(self.sScheduleType, 'Title3L', btnTitleThirdLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'Title3C', btnTitleThirdCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'Title3R', btnTitleThirdRight.Down);

    //Показывать отметки/время
    iniF.WriteInteger(self.sScheduleType, 'ShowMarkTime', rgShowMarkTime.ItemIndex);

    //Видимость колонок
    iniF.WriteBool(self.sScheduleType, 'CalTime', chkCalTime.Checked);
    iniF.WriteBool(self.sScheduleType, 'SchedTime', chkSchedTime.Checked);
    iniF.WriteBool(self.sScheduleType, 'CalDays', chkCalDays.Checked);
    iniF.WriteBool(self.sScheduleType, 'SchedDays', chkSchedDays.Checked);
    iniF.WriteBool(self.sScheduleType, 'OverTime', chkOvertime.Checked);
    iniF.WriteBool(self.sScheduleType, 'Hol023', chkHol023.Checked);
    iniF.WriteBool(self.sScheduleType, 'Hol033', chkHol033.Checked);
    iniF.WriteBool(self.sScheduleType, 'EvngTime', chkEvngTime.Checked);
    iniF.WriteBool(self.sScheduleType, 'NghtTime', chkNghtTime.Checked);
    iniF.WriteBool(self.sScheduleType, 'MarkHolidays', chkMarkHolidays.Checked);
    iniF.WriteBool(self.sScheduleType, 'WeekendEmpty', chkWeekendEmpty.Checked);
    iniF.WriteBool(self.sScheduleType, 'BoldDelimiter', chkDoubleLineBetweenMonths.Checked);
    iniF.WriteBool(self.sScheduleType, 'LinesInsideMonth', chkLinesInsideMonth.Checked);
    iniF.WriteBool(self.sScheduleType, 'HideSmenaColumn', chkHideSmenaColumn.Checked);
    iniF.WriteBool(self.sScheduleType, 'DoNotShowNegativeOvertime', chkDoNotShowNegativeOvertime.Checked);
    iniF.WriteBool(self.sScheduleType, 'DoNotShowSumHolNghtEvng', chkDoNotShowSumHolNghtEvng.Checked);

    //Начальник отдела экономики
    iniF.WriteString(self.sScheduleType, 'OEBoss', lblOEBoss.Caption);
    iniF.WriteString(self.sScheduleType, 'OEBossName', lblOEBossName.Caption);
    //iniF.WriteString(self.sScheduleType, 'DeptBoss', edDeptBoss.Text);
    //iniF.WriteString(self.sScheduleType, 'DeptBossName', edDeptBossName.Text);
    iniF.WriteBool(self.sScheduleType, 'OEBossB', btnOEBossBold.Down);
    iniF.WriteBool(self.sScheduleType, 'OEBossL', btnOEBossLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'OEBossC', btnOEBossCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'OEBossR', btnOEBossRight.Down);
    iniF.WriteBool(self.sScheduleType, 'OEBossNameB', btnOEBossNameBold.Down);
    iniF.WriteBool(self.sScheduleType, 'OEBossNameL', btnOEBossNameLeft.Down);
    iniF.WriteBool(self.sScheduleType, 'OEBossNameC', btnOEBossNameCenter.Down);
    iniF.WriteBool(self.sScheduleType, 'OEBossNameR', btnOEBossNameRight.Down);
    //Начальник подразделения
    //iniF.WriteBool(self.sScheduleType, 'DeptBossB', btnDeptBossBold.Down);
    //iniF.WriteBool(self.sScheduleType, 'DeptBossL', btnDeptBossLeft.Down);
    //iniF.WriteBool(self.sScheduleType, 'DeptBossC', btnDeptBossCenter.Down);
    //iniF.WriteBool(self.sScheduleType, 'DeptBossR', btnDeptBossRight.Down);
    //iniF.WriteBool(self.sScheduleType, 'DeptBossNameB', btnDeptBossNameBold.Down);
    //iniF.WriteBool(self.sScheduleType, 'DeptBossNameL', btnDeptBossNameLeft.Down);
    //iniF.WriteBool(self.sScheduleType, 'DeptBossNameC', btnDeptBossNameCenter.Down);
    //iniF.WriteBool(self.sScheduleType, 'DeptBossNameR', btnDeptBossNameRight.Down);

    //Печатать легенду
    iniF.WriteBool(self.sScheduleType, 'PrintLegend', chkLegend.Checked);

    //Легенда
    iniF.WriteInteger(self.sScheduleType, 'LegendNumOfRows', strgrdLegend.RowCount);
    iniF.WriteInteger(Self.sScheduleType, 'LegendNumOfCols', strgrdLegend.ColCount);
    iniF.WriteBool(self.sScheduleType, 'LegendPrintBorders', btnLegendBorders.Down);
    for i := 0 to strgrdLegend.RowCount - 1 do
      for j := 0 to strgrdLegend.ColCount - 1 do begin
        iniF.WriteString(Self.sScheduleType, 'LegendCell_' + IntToStr(i) + '_' + IntToStr(j), strgrdLegend.Cells[j, i]);
      end;
    iniF.WriteBool(self.sScheduleType, 'LegendCol1Bold', btnLegendCol1Bold.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol1Left', btnLegendCol1Left.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol1Center', btnLegendCol1Center.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol1Right', btnLegendCol1Right.Down);

    iniF.WriteBool(self.sScheduleType, 'LegendCol2Bold', btnLegendCol2Bold.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol2Left', btnLegendCol2Left.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol2Center', btnLegendCol2Center.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol2Right', btnLegendCol2Right.Down);

    iniF.WriteBool(self.sScheduleType, 'LegendCol3Bold', btnLegendCol3Bold.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol3Left', btnLegendCol3Left.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol3Center', btnLegendCol3Center.Down);
    iniF.WriteBool(self.sScheduleType, 'LegendCol3Right', btnLegendCol3Right.Down);
  finally
    iniF.Free;
  end;
end;

procedure TfrmPrintSchedule.btnLegendDelClick(Sender: TObject);
var
  i, iCurRow: Integer;
  bUserAnswer: Boolean;
begin
  iCurRow := strgrdLegend.Row;
  if (strgrdLegend.RowCount = 2) and (strgrdLegend.Cells[0, strgrdLegend.Row] = '') then
    Exit;
  if strgrdLegend.Cells[0, strgrdLegend.Row] = '' then
    bUserAnswer := True
  else
    bUserAnswer := Application.MessageBox(PChar('Вы действительно хотите удалить строку "' + strgrdLegend.Cells[0, strgrdLegend.Row] + '..."'), 'Удаление строки легенды', MB_YESNO) = ID_YES;
  if bUserAnswer then begin
    strgrdLegend.Rows[iCurRow].Clear;
    for i := strgrdLegend.Row to strgrdLegend.RowCount - 1 do begin
      strgrdLegend.Row := i;
      btnLegendDownClick(Sender);
    end;
    if strgrdLegend.RowCount = 2 then
      strgrdLegend.Rows[1].Clear
    else
      strgrdLegend.RowCount := strgrdLegend.RowCount - 1;
  end;

  try
    strgrdLegend.Row := iCurRow;
  except
    strgrdLegend.Row := strgrdLegend.RowCount - 1;
  end;

  strgrdLegend.Color := clInfoBk;
  mniLegendSwitch.Tag := 0;
end;

procedure TfrmPrintSchedule.btnLegendUpClick(Sender: TObject);
var
  str: String;
  i, iCurRow: Integer;
begin
  iCurRow := strgrdLegend.Row;
  if iCurRow<>0 then begin
    for i:=0 to 2 do begin
      str                              := strgrdLegend.Cells[i, iCurRow];
      strgrdLegend.Cells[i, iCurRow]   := strgrdLegend.Cells[i, iCurRow-1];
      strgrdLegend.Cells[i, iCurRow-1] := str;
    end;
    strgrdLegend.Row := iCurRow-1;
  end;
end;

procedure TfrmPrintSchedule.btnLegendDownClick(Sender: TObject);
var
  str: String;
  i, iCurRow: Integer;
begin
  iCurRow := strgrdLegend.Row;
  if iCurRow<>strgrdLegend.RowCount-1 then begin
    for i:=0 to 2 do begin
      str                              := strgrdLegend.Cells[i, iCurRow];
      strgrdLegend.Cells[i, iCurRow]   := strgrdLegend.Cells[i, iCurRow+1];
      strgrdLegend.Cells[i, iCurRow+1] := str;
    end;
    strgrdLegend.Row := iCurRow+1;
  end;
end;

procedure TfrmPrintSchedule.chkLegendClick(Sender: TObject);
begin
  grpboxLegend.Enabled := chkLegend.Checked;
end;

procedure TfrmPrintSchedule.strgrdLegendDblClick(Sender: TObject);
var
  oldValue: string;
begin
  oldValue := strgrdLegend.Cells[strgrdLegend.Col, strgrdLegend.Row];
  //if strgrdLegend.Row<>0 then
    strgrdLegend.Cells[strgrdLegend.Col, strgrdLegend.Row] := InputBox('Изменение значения ячейки', 'Введите новое значение', strgrdLegend.Cells[strgrdLegend.Col, strgrdLegend.Row]);
  strgrdLegend.ColWidths[strgrdLegend.Col] := Max(strgrdLegend.ColWidths[strgrdLegend.Col], Canvas.TextWidth(strgrdLegend.Cells[strgrdLegend.Col, strgrdLegend.Row]) + 20);
  if strgrdLegend.Cells[strgrdLegend.Col, strgrdLegend.Row] <> oldValue then begin
    strgrdLegend.Color := clInfoBk;
    mniLegendSwitch.Tag := 0;
  end;
end;

procedure TfrmPrintSchedule.btnLegendAddClick(Sender: TObject);
var
  i, iCurRow: Integer;
begin
  iCurRow := strgrdLegend.Row;
  strgrdLegend.RowCount := strgrdLegend.RowCount + 1;
  for i:=strgrdLegend.RowCount-1 downto strgrdLegend.Row+2 do begin
    strgrdLegend.Row := i;
    btnLegendUpClick(Sender);
  end;
  try
    strgrdLegend.Rows[iCurRow + 1].Clear;
  except

  end;
  strgrdLegend.Row := iCurRow;

  strgrdLegend.Color := clInfoBk;
  mniLegendSwitch.Tag := 0;
end;

procedure TfrmPrintSchedule.strgrdLegendDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  oldFontStyle: TFontStyles;
begin
  with strgrdLegend.Canvas do begin
    oldFontStyle := Font.Style;
    //if (ARow=0) {or (ACol=0)} then
    //  Font.Style := Font.Style + [fsBold];
    if (ACol = 0) and btnLegendCol1Bold.Down then
      Font.Style := Font.Style + [fsBold];
    if (ACol = 1) and btnLegendCol2Bold.Down then
      Font.Style := Font.Style + [fsBold];
    if (ACol = 2) and btnLegendCol3Bold.Down then
      Font.Style := Font.Style + [fsBold];

    FillRect(Rect);
    if (ACol = 0) then
      if btnLegendCol1Center.Down then
        TextOut(Rect.Left+Trunc((strgrdLegend.ColWidths[ACol]-TextWidth(strgrdLegend.Cells[ACol,ARow]))/2),Rect.Top+2,strgrdLegend.Cells[ACol,ARow])
      else
        if btnLegendCol1Right.Down then
          TextOut(Rect.Left - 2 +(strgrdLegend.ColWidths[ACol]-TextWidth(strgrdLegend.Cells[ACol,ARow])),Rect.Top+2,strgrdLegend.Cells[ACol,ARow])
        else
          TextOut(Rect.Left + 2,Rect.Top + 2,strgrdLegend.Cells[ACol,ARow]);

    if (ACol = 1) then
      if btnLegendCol2Center.Down then
        TextOut(Rect.Left+Trunc((strgrdLegend.ColWidths[ACol]-TextWidth(strgrdLegend.Cells[ACol,ARow]))/2),Rect.Top+2,strgrdLegend.Cells[ACol,ARow])
      else
        if btnLegendCol2Right.Down then
          TextOut(Rect.Left - 2 +(strgrdLegend.ColWidths[ACol]-TextWidth(strgrdLegend.Cells[ACol,ARow])),Rect.Top+2,strgrdLegend.Cells[ACol,ARow])
        else
          TextOut(Rect.Left + 2,Rect.Top + 2,strgrdLegend.Cells[ACol,ARow]);

    if (ACol = 2) then
      if btnLegendCol3Center.Down then
        TextOut(Rect.Left+Trunc((strgrdLegend.ColWidths[ACol]-TextWidth(strgrdLegend.Cells[ACol,ARow]))/2),Rect.Top+2,strgrdLegend.Cells[ACol,ARow])
      else
        if btnLegendCol3Right.Down then
          TextOut(Rect.Left - 2 +(strgrdLegend.ColWidths[ACol]-TextWidth(strgrdLegend.Cells[ACol,ARow])),Rect.Top+2,strgrdLegend.Cells[ACol,ARow])
        else
          TextOut(Rect.Left + 2,Rect.Top + 2,strgrdLegend.Cells[ACol,ARow]);

    Font.Style := oldFontStyle;
  end;
end;

procedure TfrmPrintSchedule.rgShowMarkTimeClick(Sender: TObject);
begin
  chkWeekendEmpty.Enabled := rgShowMarkTime.ItemIndex = 1;
end;

procedure TfrmPrintSchedule.btnSoglSLeftClick(Sender: TObject);
begin
  lblSoglSecond.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnSoglSCenterClick(Sender: TObject);
begin
  lblSoglSecond.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnSoglSRightClick(Sender: TObject);
begin
  lblSoglSecond.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnSoglSBoldClick(Sender: TObject);
begin
  case btnSoglSBold.Down of
    True: lblSoglSecond.Font.Style := lblSoglSecond.Font.Style + [fsBold];
    False: lblSoglSecond.Font.Style := lblSoglSecond.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnSoglThBoldClick(Sender: TObject);
begin
  case btnSoglThBold.Down of
    True: lblSoglThird.Font.Style := lblSoglThird.Font.Style + [fsBold];
    False: lblSoglThird.Font.Style := lblSoglThird.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnSoglThLeftClick(Sender: TObject);
begin
  lblSoglThird.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnSoglThCenterClick(Sender: TObject);
begin
  lblSoglThird.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnSoglThRightClick(Sender: TObject);
begin
  lblSoglThird.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnUtvFBoldClick(Sender: TObject);
begin
  case btnUtvFBold.Down of
    True: lblUtvFirst.Font.Style := lblUtvFirst.Font.Style + [fsBold];
    False: lblUtvFirst.Font.Style := lblUtvFirst.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnUtvFLeftClick(Sender: TObject);
begin
  lblUtvFirst.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnUtvFCenterClick(Sender: TObject);
begin
  lblUtvFirst.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnUtvFRightClick(Sender: TObject);
begin
  lblUtvFirst.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnUtvSBoldClick(Sender: TObject);
begin
  case btnUtvSBold.Down of
    True: lblUtvSecond.Font.Style := lblUtvSecond.Font.Style + [fsBold];
    False: lblUtvSecond.Font.Style := lblUtvSecond.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnUtvSLeftClick(Sender: TObject);
begin
  lblUtvSecond.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnUtvSCenterClick(Sender: TObject);
begin
  lblUtvSecond.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnUtvSRightClick(Sender: TObject);
begin
  lblUtvSecond.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnUtvThBoldClick(Sender: TObject);
begin
  case btnUtvThBold.Down of
    True: lblUtvThird.Font.Style := lblUtvThird.Font.Style + [fsBold];
    False: lblUtvThird.Font.Style := lblUtvThird.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnUtvThLeftClick(Sender: TObject);
begin
  lblUtvThird.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnUtvThCenterClick(Sender: TObject);
begin
  lblUtvThird.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnUtvThRightClick(Sender: TObject);
begin
  lblUtvThird.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnTitleFirstBoldClick(Sender: TObject);
begin
  case btnTitleFirstBold.Down of
    True: lblTitleFirst.Font.Style := lblTitleFirst.Font.Style + [fsBold];
    False: lblTitleFirst.Font.Style := lblTitleFirst.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnTitleSecondBoldClick(Sender: TObject);
begin
  case btnTitleSecondBold.Down of
    True: lblTitleSecond.Font.Style := lblTitleSecond.Font.Style + [fsBold];
    False: lblTitleSecond.Font.Style := lblTitleSecond.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnTitleThirdBoldClick(Sender: TObject);
begin
  case btnTitleThirdBold.Down of
    True: lblTitleThird.Font.Style := lblTitleThird.Font.Style + [fsBold];
    False: lblTitleThird.Font.Style := lblTitleThird.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.lblTitleFirstDblClick(Sender: TObject);
begin
  lblTitleFirst.Caption := InputBox('Введите новое значение', 'График №', lblTitleFirst.Caption);
end;

procedure TfrmPrintSchedule.lblTitleSecondDblClick(Sender: TObject);
begin
  lblTitleSecond.Caption := InputBox('Введите новое значение', 'График №', lblTitleSecond.Caption);
end;

procedure TfrmPrintSchedule.lblTitleThirdDblClick(Sender: TObject);
begin
  lblTitleThird.Caption := InputBox('Введите новое значение', 'Для автоподстановки года, напишите: "на %YEAR% год" или "на %ГОД% год"', lblTitleThird.Caption);
end;

procedure TfrmPrintSchedule.btnTitleFirstLeftClick(Sender: TObject);
begin
  lblTitleFirst.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnTitleFirstCenterClick(Sender: TObject);
begin
  lblTitleFirst.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnTitleFirstRightClick(Sender: TObject);
begin
  lblTitleFirst.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnTitleSecondLeftClick(Sender: TObject);
begin
  lblTitleSecond.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnTitleSecondCenterClick(Sender: TObject);
begin
  lblTitleSecond.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnTitleSecondRightClick(Sender: TObject);
begin
  lblTitleSecond.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnTitleThirdLeftClick(Sender: TObject);
begin
  lblTitleThird.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnTitleThirdCenterClick(Sender: TObject);
begin
  lblTitleThird.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnTitleThirdRightClick(Sender: TObject);
begin
  lblTitleThird.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnRestoreSettingsClick(Sender: TObject);
begin
  RestoreSettings;
end;

procedure TfrmPrintSchedule.btnSaveSettingsClick(Sender: TObject);
begin
  SaveSettings;
end;

procedure TfrmPrintSchedule.lblOEBossDblClick(Sender: TObject);
begin
  lblOEBoss.Caption := InputBox('Введите новое значение', 'Начальник ОЭ', lblOEBoss.Caption);
end;

procedure TfrmPrintSchedule.lblOEBossNameDblClick(Sender: TObject);
begin
  lblOEBossName.Caption := InputBox('Введите новое значение', 'В.Я. Вакеряк', lblOEBossName.Caption);
end;

procedure TfrmPrintSchedule.btnOEBossBoldClick(Sender: TObject);
begin
  case btnOEBossBold.Down of
    True: lblOEBoss.Font.Style := lblOEBoss.Font.Style + [fsBold];
    False: lblOEBoss.Font.Style := lblOEBoss.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnOEBossNameBoldClick(Sender: TObject);
begin
  case btnOEBossNameBold.Down of
    True: lblOEBossName.Font.Style := lblOEBossName.Font.Style + [fsBold];
    False: lblOEBossName.Font.Style := lblOEBossName.Font.Style - [fsBold];
  end;
end;

procedure TfrmPrintSchedule.btnOEBossLeftClick(Sender: TObject);
begin
  lblOEBoss.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnOEBossCenterClick(Sender: TObject);
begin
  lblOEBoss.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnOEBossRightClick(Sender: TObject);
begin
  lblOEBoss.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnOEBossNameLeftClick(Sender: TObject);
begin
  lblOEBossName.Alignment := taLeftJustify;
end;

procedure TfrmPrintSchedule.btnOEBossNameCenterClick(Sender: TObject);
begin
  lblOEBossName.Alignment := taCenter;
end;

procedure TfrmPrintSchedule.btnOEBossNameRightClick(Sender: TObject);
begin
  lblOEBossName.Alignment := taRightJustify;
end;

procedure TfrmPrintSchedule.btnLegendCol1BoldClick(Sender: TObject);
begin
  strgrdLegend.Repaint;
end;

procedure TfrmPrintSchedule.chkOvertimeClick(Sender: TObject);
begin
  if not(chkOvertime.Checked) then begin
    //prevchkDoNotShowNegativeOvertime := chkDoNotShowNegativeOvertime.Checked;
    //chkDoNotShowNegativeOvertime.Checked := False;
    chkDoNotShowNegativeOvertime.Enabled := False;
  end
  else begin
    chkDoNotShowNegativeOvertime.Enabled := True;
    //chkDoNotShowNegativeOvertime.Checked := prevchkDoNotShowNegativeOvertime;
  end;
end;

procedure TfrmPrintSchedule.chkHol023Click(Sender: TObject);
begin
  if (not(chkHol023.Checked) and not(chkHol033.Checked) and not(chkNghtTime.Checked) and not(chkEvngTime.Checked)) then begin
    //prevchkDoNotShowSumHolNghtEvng     := chkDoNotShowSumHolNghtEvng.Checked;
    //chkDoNotShowSumHolNghtEvng.Checked := False;
    chkDoNotShowSumHolNghtEvng.Enabled := False;
  end
  else begin
    chkDoNotShowSumHolNghtEvng.Enabled := True;
    //chkDoNotShowSumHolNghtEvng.Checked := prevchkDoNotShowSumHolNghtEvng;
  end;
end;

procedure TfrmPrintSchedule.chkDoNotShowNegativeOvertimeClick(
  Sender: TObject);
begin
  prevchkDoNotShowNegativeOvertime := chkDoNotShowNegativeOvertime.Checked;
end;

procedure TfrmPrintSchedule.chkDoNotShowSumHolNghtEvngClick(
  Sender: TObject);
begin
  prevchkDoNotShowSumHolNghtEvng := chkDoNotShowSumHolNghtEvng.Checked;
end;

procedure TfrmPrintSchedule.N1Click(Sender: TObject);
begin
  lblUtvSecond.Caption := Trim(Copy(TMenuItem(Sender).Caption, 1, AnsiPos('(', TMenuItem(Sender).Caption) - 1));
  lblUtvThird.Caption  := Trim(Copy(TMenuItem(Sender).Caption, AnsiPos('(', TMenuItem(Sender).Caption) + 1, AnsiPos(')', TMenuItem(Sender).Caption) - AnsiPos('(', TMenuItem(Sender).Caption) - 1));
end;

procedure TfrmPrintSchedule.mniLegendSwitchClick(Sender: TObject);
begin
  //Меняем тип отображаемой легенды
  if mniLegendSwitch.Tag = 0 then begin //Сохранённая легенда - меняем на стандартную
    FillInLegend(False);
    strgrdLegend.Color := clMoneyGreen;
    mniLegendSwitch.Tag := 1;
  end
  else begin //Стандартная (созданная по текущим отметкам) легенда - меняем на сохранённую
    RestoreSettings(True);
    strgrdLegend.Color := clInfoBk;
    mniLegendSwitch.Tag := 0;
  end;
end;

end.
