unit uNewSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, Grids, udmMain, Spin, StrUtils, DBXpress, DateUtils,
  Menus;

type
  TfrmNewSchedule = class(TForm)
    GroupBox1: TGroupBox;
    strgrdSample: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edNameU: TEdit;
    edNameR: TEdit;
    strgrdMarks: TStringGrid;
    spbtnAddMark: TSpeedButton;
    spbtnDeleteMark: TSpeedButton;
    edScheduleType: TEdit;
    spnedDays: TSpinEdit;
    strgrdCycle: TStringGrid;
    cboxCell: TComboBox;
    bitbtnSave: TBitBtn;
    spnedShifts: TSpinEdit;
    spbtnAddCycleDay: TSpeedButton;
    spbtnDeleteCycleDay: TSpeedButton;
    strgrdShifts: TStringGrid;
    cboxHollidays: TComboBox;
    bitbtnCancel: TBitBtn;
    Label8: TLabel;
    spbtnRefreshSample: TSpeedButton;
    Label10: TLabel;
    spbtnShiftCycleADayRight: TSpeedButton;
    bitbtnCheckSchedule: TBitBtn;
    spnedSampleYear: TSpinEdit;
    spnedStartDay: TSpinEdit;
    Label11: TLabel;
    pupmShifts: TPopupMenu;
    mniShowScheduleTypes: TMenuItem;
    mniGetScheduleType: TMenuItem;
    procedure edNameUExit(Sender: TObject);
    procedure edNameRExit(Sender: TObject);
    procedure spbtnAddMarkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure strgrdCycleDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure spnedDaysChange(Sender: TObject);
    procedure strgrdCycleSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure cboxCellChange(Sender: TObject);
    procedure cboxCellExit(Sender: TObject);
    procedure bitbtnSaveClick(Sender: TObject);
    procedure spbtnDeleteMarkClick(Sender: TObject);
    procedure spbtnAddCycleDayClick(Sender: TObject);
    procedure spbtnDeleteCycleDayClick(Sender: TObject);
    procedure strgrdShiftsClick(Sender: TObject);
    procedure spnedShiftsChange(Sender: TObject);
    procedure strgrdShiftsDblClick(Sender: TObject);
    procedure bitbtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spbtnRefreshSampleClick(Sender: TObject);
    procedure edNameUChange(Sender: TObject);
    procedure strgrdMarksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cboxCellDropDown(Sender: TObject);
    procedure strgrdMarksDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure strgrdSampleDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure strgrdShiftsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure spbtnShiftCycleADayRightClick(Sender: TObject);
    procedure bitbtnCheckScheduleClick(Sender: TObject);
    procedure edNameUKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mniGetScheduleTypeClick(Sender: TObject);
    procedure mniShowScheduleTypesClick(Sender: TObject);
    procedure edNameRChange(Sender: TObject);
    procedure pupmShiftsPopup(Sender: TObject);
  private
    { Private declarations }
    //gridCombo: TComboBox;
    StringList: TStrings;
    function CheckSchedule: Boolean;
  public
    { Public declarations }
    CancelPressed: Boolean;
    Schedule: TSchedule;
    SourceSchedule: TSchedule; // График-источник, который редактируется в режиме редактирования (для последующего сравнения и выявления изменений)
    procedure FillInScheduleInfo;
  end;

var
  frmNewSchedule: TfrmNewSchedule;

implementation

uses
  uMarkList, DB, uGetCode;

{$R *.dfm}

procedure TfrmNewSchedule.edNameUExit(Sender: TObject);
begin
  self.Schedule.NameU := edNameU.Text;
end;

procedure TfrmNewSchedule.edNameRExit(Sender: TObject);
begin
  self.Schedule.NameR := edNameR.Text;
end;

procedure TfrmNewSchedule.spbtnAddMarkClick(Sender: TObject);
var
  i: Integer;
begin
  if not (Assigned(frmMarkList)) then
    frmMarkList := TfrmMarkList.Create(nil);
  frmMarkList.DrawMarkList;
  frmMarkList.ChoosenMarkID := '000';
  frmMarkList.ShowModal;
  if frmMarkList.ChoosenMarkID <> '000' then begin
    //Не добавляем отметку, которая уже есть в списке
    for i := 0 to strgrdMarks.ColCount - 1 do
      if strgrdMarks.Cells[i, 0] = frmMarkList.ChoosenMarkID then
        exit;

    self.Schedule.MarkIndexes[-1] := frmMarkList.ChoosenMarkIndex;
    if self.Schedule.MarkIndexesCount <> 1 then
      strgrdMarks.ColCount := strgrdMarks.ColCount + 1;
    strgrdMarks.Cells[self.Schedule.MarkIndexesCount - 1, 0] := frmMarkList.ChoosenMarkID;
    StringList.Add(frmMarkList.ChoosenMarkID);

    //Отметки в комбобокс попадают в cboxCellOnDropDown
    //cboxCell.Items.Add(frmMarkList.ChoosenMarkID);
  end;
  strgrdMarks.SetFocus;
end;

procedure TfrmNewSchedule.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  CancelPressed := False;
  self.Schedule := TSchedule.Create;
  StringList := TStringList.Create;
  dmMain.sqlqryTemp.Active := False;
  dmMain.sqlqryTemp.SQL.Clear;
  dmMain.sqlqryTemp.SQL.Add('select max(TIP_SMEN)+1 from QWERTY.SP_ZAR_T_SMEN');
  dmMain.sqlqryTemp.Active := True;
  edScheduleType.Text := dmMain.sqlqryTemp.Fields.Fields[0].AsString;
  dmMain.sqlqryTemp.Active := False;
  strgrdShifts.Cells[1, 0] := 'Код смены';
  strgrdShifts.Cells[2, 0] := 'Наименование смены (рус)';
  strgrdShifts.Cells[3, 0] := 'Наименование смены (укр)';
  strgrdShifts.Cells[1, 1] := '';

  with strgrdSample do begin
    Cells[0, 0] := 'Месяц';
    Cells[0, 1] := 'Январь';
    Cells[0, 2] := 'Февраль';
    Cells[0, 3] := 'Март';
    Cells[0, 4] := 'Апрель';
    Cells[0, 5] := 'Май';
    Cells[0, 6] := 'Июнь';
    Cells[0, 7] := 'Июль';
    Cells[0, 8] := 'Август';
    Cells[0, 9] := 'Сентябрь';
    Cells[0, 10] := 'Октябрь';
    Cells[0, 11] := 'Ноябрь';
    Cells[0, 12] := 'Декабрь';
    Cells[1, 0] := 'Смена';
    for i := 1 to 31 do
      Cells[i + 1, 0] := IntToStr(i);
  end;
  spnedSampleYear.Value := YearOf(Date);
  spnedStartDay.Value := 1;
end;

procedure TfrmNewSchedule.strgrdCycleDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
{
var
  R: TRect;
begin
  R := StringGrid1.CellRect(vCol, vRow);
  if StringGrid1.Objects[vCol, vRow] is TControl then
    with TControl(StringGrid1.Objects[vCol, vRow]) do
      if R.Right = R.Left then //прямоугольник ячейки невидим
        Visible := False
      else
      begin
        InflateRect(R, -1, -1);
        OffsetRect(R, StringGrid1.Left + 1, StringGrid1.Top + 1);
        BoundsRect := R;
        Visible := True;
      end;
end;
}

{
  if gdFocused in State then begin
//    cboxGrid.Parent := strgrdCycle;
    cboxCell.Width := strgrdCycle.ColWidths[ACol]+2;
    cboxCell.Height := strgrdCycle.RowHeights[ARow];
    cboxCell.Left := Rect.Left-1;
    cboxCell.Top  := Rect.Top-1;
//    cboxCell.Items := StringList;
    cboxCell.Visible := True;
  end;
}
end;

procedure TfrmNewSchedule.spnedDaysChange(Sender: TObject);
begin
  if strgrdCycle.ColCount < spnedDays.Value then
    strgrdCycle.ColCount := spnedDays.Value;
end;

procedure TfrmNewSchedule.strgrdCycleSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  {Ширина и положение ComboBox должно соответствовать ячейке StringGrid}
  R := strgrdCycle.CellRect(ACol, ARow);
  R.Left := R.Left + strgrdCycle.Left;
  R.Right := R.Right + strgrdCycle.Left;
  R.Top := R.Top + strgrdCycle.Top;
  R.Bottom := R.Bottom + strgrdCycle.Top;
  cboxCell.Left := R.Left + 1;
  cboxCell.Top := R.Top + 1;
  cboxCell.Width := (R.Right + 1) - R.Left;
  cboxCell.Height := (R.Bottom + 1) - R.Top; {Покажем combobox}
  if strgrdCycle.Cells[ACol, ARow] <> '' then
    cboxCell.ItemIndex := cboxCell.Items.IndexOf(strgrdCycle.Cells[ACol, ARow]);
  cboxCell.Visible := True;
  cboxCell.SetFocus;
  //cboxCell.DroppedDown := True;
  CanSelect := True;
end;

procedure TfrmNewSchedule.cboxCellChange(Sender: TObject);
begin
  strgrdCycle.Cells[strgrdCycle.Col, 0] := cboxCell.Text;
  cboxCell.Visible := False;
  strgrdCycle.SetFocus;
end;

procedure TfrmNewSchedule.cboxCellExit(Sender: TObject);
begin
  cboxCellChange(Sender);
end;

procedure TfrmNewSchedule.bitbtnSaveClick(Sender: TObject);
var
  strSQL, strCycle: string;
  i, j: Integer;
  TD: TTransactionDesc;
begin
  //Проверяем не находимся ли в режиме редактирования графика
  if frmNewSchedule.Tag = -1 then begin
    // пока что просто ничего не делаем
    ShowMessage('Реализация данной функциональности пока что не закончена');
    {
    property ScheduleType: Integer read fTIP_SMEN write fTIP_SMEN;
    property NameU: String read fNAME_U write fNAME_U;
    property NameR: String read fNAME_R write fNAME_R;
    property Cycle: String read fCYCLE write fCYCLE;
    property NumOfDays: Byte read fDAYS write fDAYS;
    property NumOfShifts: Byte read fKOL_SMEN write fKOL_SMEN;
    property HollidayType: Byte read fHOL_TYPE write fHOL_TYPE;
    property MarkIndexes[Index: Integer]: Integer read GetMarkIndex write SetMarkIndex;
    property MarkIndexesCount: Integer read GetMarkIndexesCount;
    property Shifts[Index: Integer]: recShift read GetShift write SetShift;
    property ShiftsCount: Integer read GetShiftsCount;
    property EmployeeCount: Integer read fEmployeeCount write fEmployeeCount;
    property LastMonth: TDateTime read fLastMonth write fLastMonth;
    }
    try
      TD.TransactionID := 1;
      TD.IsolationLevel := xilREADCOMMITTED;
      dmMain.sqlconDB.StartTransaction(TD);

      if Schedule.ScheduleType <> SourceSchedule.ScheduleType then begin
        //Изменился тип графика
        ShowMessage('Изменение кода графика ЗАПРЕЩЕНО! Как вы вообще умудрились тут что-то изменить? ;)');
      end;
      if Schedule.NameU <> SourceSchedule.NameU then begin
        //Изменилось наименование графика на русском языке
        strSQL := 'UPDATE QWERTY.SP_ZAR_T_SMEN SET NAME_U = ''' + Schedule.NameU + ''' WHERE TIP_SMEN = ' + IntToStr(Schedule.ScheduleType);
        dmMain.sqldsTemp.CommandText := strSQL;
        dmMain.sqldsTemp.ExecSQL(True);
        SourceSchedule.NameU := Schedule.NameU;
      end;
      if Schedule.NameR <> SourceSchedule.NameR then begin
        //Изменилось наименование графика на украинском языке
        strSQL := 'UPDATE QWERTY.SP_ZAR_T_SMEN SET NAME_R = ''' + Schedule.NameR + ''' WHERE TIP_SMEN = ' + IntToStr(Schedule.ScheduleType);
        dmMain.sqldsTemp.CommandText := strSQL;
        dmMain.sqldsTemp.ExecSQL(True);
        SourceSchedule.NameR := Schedule.NameR;
      end;
      if Schedule.Cycle <> SourceSchedule.Cycle then begin
        //Изменился цикл
        strSQL := 'UPDATE QWERTY.SP_ZAR_T_SMEN SET CYCLE = ''' + Schedule.Cycle + ''' WHERE TIP_SMEN = ' + IntToStr(Schedule.ScheduleType);
        dmMain.sqldsTemp.CommandText := strSQL;
        dmMain.sqldsTemp.ExecSQL(True);
        SourceSchedule.Cycle := Schedule.Cycle;
      end;
      if Schedule.NumOfDays <> SourceSchedule.NumOfDays then begin
        //Изменилось количество определяющих дней
        strSQL := 'UPDATE QWERTY.SP_ZAR_T_SMEN SET DAYS = ' + IntToStr(Schedule.NumOfDays) + ' WHERE TIP_SMEN = ' + IntToStr(Schedule.ScheduleType);
        dmMain.sqldsTemp.CommandText := strSQL;
        dmMain.sqldsTemp.ExecSQL(True);
        SourceSchedule.NumOfDays := Schedule.NumOfDays;
      end;
      if Schedule.NumOfShifts <> SourceSchedule.NumOfShifts then begin
        //Изменилось количество смен графика
        strSQL := 'UPDATE QWERTY.SP_ZAR_T_SMEN SET KOL_SMEN = ' + IntToStr(Schedule.NumOfShifts) + ' WHERE TIP_SMEN = ' + IntToStr(Schedule.ScheduleType);
        dmMain.sqldsTemp.CommandText := strSQL;
        dmMain.sqldsTemp.ExecSQL(True);
        { TODO 1 -oBishop -cДоработать : Если изменилось количество смен, значит надо добавить/удалить записи в QWERTY.SP_ZAR_S_SMEN }
        //Необходимо внести изменения в QWERTY.SP_ZAR_S_SMEN
        SourceSchedule.NumOfShifts := Schedule.NumOfShifts
      end;
      if Schedule.HollidayType <> SourceSchedule.HollidayType then begin
        //Изменился тип реагирования на праздничные дни
        strSQL := 'UPDATE QWERTY.SP_ZAR_T_SMEN SET HOL_TYPE = ' + Copy(cboxHollidays.Text, 1, 1) + ' WHERE TIP_SMEN = ' + IntToStr(Schedule.ScheduleType);
        dmMain.sqldsTemp.CommandText := strSQL;
        dmMain.sqldsTemp.ExecSQL(True);
        SourceSchedule.HollidayType := Schedule.HollidayType;
      end;

      { TODO 1 -oBishop -cДоработать : Написать реализацию реакции на изменение отметок и смен графика }

      if Schedule.EmployeeCount <> SourceSchedule.EmployeeCount then begin
        //Изменилось количество работников
        //В БД ничего не меняем
        // да и вообще этот параметр в данном случае не может измениться
        SourceSchedule.EmployeeCount := Schedule.EmployeeCount;
      end;
      if Schedule.LastMonth <> SourceSchedule.LastMonth then begin
        //Изменился последний месяц
        //В БД ничего не меняем
        // да и вообще этот параметр в данном случае не может измениться
        SourceSchedule.LastMonth := Schedule.LastMonth;
      end;
      dmMain.sqlconDB.Commit(TD);
      //ПЕРЕСТРОИТЬ СПИСОК ГРАФИКОВ, чтобы новый график отобразился в списке
      RefreshScheduleList(dmMain.sqlqryTemp, dmMain.sqlqryTemp2);
    except
      on e: Exception do begin
        dmMain.sqlconDB.Rollback(TD);
        ShowMessage('Произошла ошибка при редактировании нового графика: ' + e.Message);
      end;
    end;

    Close;
    Exit;
  end;

  if not (CheckSchedule) then
    exit;
  if dmMain.sqlconDB.InTransaction then begin
    ShowMessage('Не могу открыть новую сессию. БД занята');
    exit;
  end;
  TD.TransactionID := 1;
  TD.IsolationLevel := xilREADCOMMITTED;
  dmMain.sqlconDB.StartTransaction(TD);
  try
    //Записать в таблицу QWERTY.SP_ZAR_T_SMEN
    strCycle := '';
    for i := 0 to strgrdCycle.ColCount - 1 do
      if strgrdCycle.Cols[i].Strings[0] <> '' then
        strCycle := strCycle + strgrdCycle.Cols[i].Strings[0];
    strSQL := 'INSERT INTO QWERTY.SP_ZAR_T_SMEN(tip_smen, name_u, name_r, cycle, days, kol_smen, hol_type) VALUES(' + edScheduleType.Text + ', ''' + edNameU.Text
      + ''', ''' + edNameR.Text + ''', ''' + strCycle + ''', ' + IntToStr(spnedDays.Value) + ', ' + IntToStr(spnedShifts.Value) + ', ' + Copy(cboxHollidays.Text,
      1, 1) + ')';
    dmMain.sqldsTemp.CommandText := strSQL;
    dmMain.sqldsTemp.ExecSQL(True);
    //    А ДАЛЬШЕ???????????????????
    //Записать в таблицу QWERTY.SP_ZAR_S_SMEN
    for i := 1 to strgrdShifts.RowCount - 1 do begin
      strSQL := 'INSERT INTO QWERTY.SP_ZAR_S_SMEN(id_smen, name_u, name_r, tip_smen) VALUES(''' + strgrdShifts.Cells[1, i] + ''', ''' + strgrdShifts.Cells[2, i]
        + ''', ''' + strgrdShifts.Cells[3, i] + ''', ' + edScheduleType.Text + ')';
      dmMain.sqldsTemp.CommandText := strSQL;
      dmMain.sqldsTemp.ExecSQL(True);
    end;
    //Записать в таблицу QWERTY.SP_ZAR_TABL_SMEN
    for i := 1 to strgrdShifts.RowCount - 1 do
      for j := 0 to strgrdMarks.ColCount - 1 do begin
        strSQL := 'INSERT INTO QWERTY.SP_ZAR_TABL_SMEN(id_smen, id_otmetka) VALUES(''' + strgrdShifts.Cells[1, i] + ''', ''' + strgrdMarks.Cells[j, 0] + ''')';
        dmMain.sqldsTemp.CommandText := strSQL;
        dmMain.sqldsTemp.ExecSQL(True);
      end;
    dmMain.sqlconDB.Commit(TD);
    //ПЕРЕСТРОИТЬ СПИСОК ГРАФИКОВ, чтобы новый график отобразился в списке
    RefreshScheduleList(dmMain.sqlqryTemp, dmMain.sqlqryTemp2);

    //Записать в таблицу QWERTY.SP_ZAR_CEX_SMEN
    Close;
  except
    on e: Exception do begin
      dmMain.sqlconDB.Rollback(TD);
      ShowMessage('Произошла ошибка при добавлении нового графика: ' + e.Message);
    end;
  end;
end;

procedure TfrmNewSchedule.spbtnDeleteMarkClick(Sender: TObject);
begin
  //strgrdMarks.Cells[strgrdMarks.ColCount-1, 0] := '';
  self.Schedule.MarkIndexes[self.Schedule.MarkIndexesCount - 1] := -999;
  strgrdMarks.Cols[strgrdMarks.ColCount - 1].Clear;
  strgrdMarks.ColCount := strgrdMarks.ColCount - 1;
  //cboxCell.Items.Delete(cboxCell.Items.IndexOf(strgrdMarks.Cells[self.Schedule.MarkIndexesCount-1, 0]));
  //self.Schedule.MarkIndexes. := self.Schedule.MarkIndexesCount-1;
end;

procedure TfrmNewSchedule.spbtnAddCycleDayClick(Sender: TObject);
begin
  strgrdCycle.ColCount := strgrdCycle.ColCount + 1;
  spnedStartDay.MaxValue := strgrdCycle.ColCount;
end;

procedure TfrmNewSchedule.spbtnDeleteCycleDayClick(Sender: TObject);
begin
  strgrdCycle.Cols[strgrdCycle.ColCount - 1].Clear;
  strgrdCycle.ColCount := strgrdCycle.ColCount - 1;
  cboxCell.ItemIndex := cboxCell.Items.IndexOf(strgrdCycle.Cells[strgrdCycle.ColCount - 1, 0]);
  if spnedStartDay.Value > strgrdCycle.ColCount then
    spnedStartDay.Value := strgrdCycle.ColCount;
  spnedStartDay.MaxValue := strgrdCycle.ColCount;
end;

procedure TfrmNewSchedule.strgrdShiftsClick(Sender: TObject);
//var
//  bChecked: Boolean;
begin
{
  bChecked := False;
  case strgrdShifts.Col of
    0: ;
    1: begin
      if (Pos('Смена', strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row])=1) or (strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]='') then
        repeat
          strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := InputBox('Новая смена графика', 'Введите двухбуквенное обозначение новой смены', 'XX');
          dmMain.sqlqryTemp.Active := False;
          dmMain.sqlqryTemp.SQL.Clear;
          dmMain.sqlqryTemp.SQL.Add('select count(*) num_of_shift from qwerty.sp_zar_s_smen where id_smen='''+strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]+'''');
          dmMain.sqlqryTemp.Active := True;
          if dmMain.sqlqryTemp.Fields[0].AsInteger<>0 then
            ShowMessage('Смена с таким название уже существует. Введите уникальное обозначение смены')
          else
            bChecked := True;
          dmMain.sqlqryTemp.Active := False;
        until bChecked;
    end;
    2: begin
      if strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]='' then
        strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := InputBox('Новая смена графика', 'Введите название новой смены на русском языке (30 символов)', 'Смена '+IntToStr(strgrdShifts.Row)+' '+edNameU.Text);
    end;
    3: begin
      if strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]='' then
        strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := InputBox('Новая смена графика', 'Введите название новой смены на украинском языке или описание (30 символов)', 'Смена '+IntToStr(strgrdShifts.Row)+' '+edNameR.Text);
    end;
  end;
}
end;

procedure TfrmNewSchedule.spnedShiftsChange(Sender: TObject);
begin
  strgrdShifts.RowCount := spnedShifts.Value + 1;
end;

procedure TfrmNewSchedule.strgrdShiftsDblClick(Sender: TObject);
var
  bChecked: Boolean;
  sUserChoice: string;
begin
  case strgrdShifts.Col of
    0:
      ;
    1:
      begin
        if frmNewSchedule.Tag = -1 then
          mniGetScheduleTypeClick(Sender);
        Exit;

        //Старый вариант обработки
        repeat
          bChecked := False;
          repeat
            strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := InputBox('Новая смена графика', 'Введите ДВУХБУКВЕННОЕ обозначение новой смены',
              strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]);
            bChecked := Trim(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]) <> '';
            if not (bChecked) then
              ShowMessage('Код смены не может быть пустым');
          until bChecked;
          if Length(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]) > 2 then begin
            ShowMessage('Длина кода смены не должна превышать 2-х символов' + #10#13 + 'Код смены будет усечен до 2-х символов');
            strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := Copy(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row], 1, 2);
          end;
          dmMain.sqlqryTemp.Active := False;
          dmMain.sqlqryTemp.SQL.Clear;
          dmMain.sqlqryTemp.SQL.Add('select count(*) num_of_shift from qwerty.sp_zar_s_smen where id_smen=''' + strgrdShifts.Cells[strgrdShifts.Col,
            strgrdShifts.Row] + '''');
          dmMain.sqlqryTemp.Active := True;
          if dmMain.sqlqryTemp.Fields[0].AsInteger <> 0 then begin
            ShowMessage('Смена с таким названием уже существует! Введите уникальное обозначение смены');
            bChecked := False;
          end
          else
            bChecked := True;
          dmMain.sqlqryTemp.Active := False;
        until bChecked or (frmNewSchedule.Tag = -1);
      end;
    2:
      begin
        sUserChoice := IfThen(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] = '', IntToStr(strgrdShifts.Row) + ' (гр. ' + Copy(edNameU.Text, Pos('№',
          edNameU.Text) + 1, 20) + ')', strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]);
        if not (InputQuery('Новая смена графика', 'Введите название новой смены на русском языке (30 символов)', sUserChoice)) then
          Exit
        else
          strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := sUserChoice;
        //strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := InputBox('Новая смена графика', 'Введите название новой смены на русском языке (30 символов)',
        //  IfThen(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] = '', IntToStr(strgrdShifts.Row) + ' (гр. ' + Copy(edNameU.Text, Pos('№', edNameU.Text)
        //  + 1, 20) + ')', strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]));
        if Length(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]) > 30 then begin
          ShowMessage('Длина названия смены не может превышать 30 символов!' + #10#13 + 'Название будет усечено до 30 символов');
          strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := Copy(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row], 1, 30);
        end;
      end;
    3:
      begin
        sUserChoice := IfThen(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] = '', IntToStr(strgrdShifts.Row) + ' (гр. ' + Copy(edNameR.Text, Pos('№',
          edNameU.Text) + 1, 20) + ')', strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]);
        if not (InputQuery('Новая смена графика', 'Введите название новой смены на украинском языке или описание (30 символов)', sUserChoice)) then
          Exit
        else
          strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := sUserChoice;
        //strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := InputBox('Новая смена графика',
        //  'Введите название новой смены на украинском языке или описание (30 символов)', IfThen(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] = '',
        //  IntToStr(strgrdShifts.Row) + ' (гр. ' + Copy(edNameR.Text, Pos('№', edNameU.Text) + 1, 20) + ')', strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]));
        if Length(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row]) > 30 then begin
          ShowMessage('Длина названия смены не может превышать 30 символов!' + #10#13 + 'Название будет усечено до 30 символов');
          strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row] := Copy(strgrdShifts.Cells[strgrdShifts.Col, strgrdShifts.Row], 1, 30);
        end;
      end;
  end;
end;

procedure TfrmNewSchedule.bitbtnCancelClick(Sender: TObject);
begin
  CancelPressed := True;
  Close;
end;

procedure TfrmNewSchedule.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmNewSchedule.spbtnRefreshSampleClick(Sender: TObject);
var
  i, j, iDaysInCycle, iCurrPos: Integer;
  strCycle: string;
  arrCalendar: array[1..12] of array[1..31] of string;
begin
{ TODO : Расчет примерного графика работы должен учитывать тип рекации на праздники и календарные выходные! }
  strgrdSample.SetFocus;
  strgrdSample.Cells[30, 2] := '';
  iDaysInCycle := strgrdCycle.ColCount;
  for i := 0 to iDaysInCycle - 1 do
    strCycle := strCycle + strgrdCycle.Cells[i, 0];
  iCurrPos := spnedStartDay.Value * 2 - 1;
  iDaysInCycle := iDaysInCycle * 2;

  //Выбираем календарь на расчетный год
  dmMain.sqlqryTemp.Active := False;
  dmMain.sqlqryTemp.SQL.Clear;
  dmMain.sqlqryTemp.SQL.Add('select  nvl(d1, ''  ''),nvl(d2, ''  ''),nvl(d3, ''  ''),nvl(d4, ''  ''),nvl(d5, ''  ''),nvl(d6, ''  ''),nvl(d7, ''  ''),');
  dmMain.sqlqryTemp.SQL.Add('nvl(d8, ''  ''),nvl(d9, ''  ''),nvl(d10, ''  ''),nvl(d11, ''  ''),nvl(d12, ''  ''),nvl(d13, ''  ''),nvl(d14, ''  ''),');
  dmMain.sqlqryTemp.SQL.Add('nvl(d15, ''  ''),nvl(d16, ''  ''),nvl(d17, ''  ''),nvl(d18, ''  ''),nvl(d19, ''  ''),nvl(d20, ''  ''),nvl(d21, ''  ''),');
  dmMain.sqlqryTemp.SQL.Add('nvl(d22, ''  ''),nvl(d23, ''  ''),nvl(d24, ''  ''),nvl(d25, ''  ''),nvl(d26, ''  ''),nvl(d27, ''  ''),nvl(d28, ''  ''),');
  dmMain.sqlqryTemp.SQL.Add('nvl(d29, ''  ''),nvl(d30, ''  ''),nvl(d31, ''  '')');
  dmMain.sqlqryTemp.SQL.Add(' from QWERTY.SP_ZAR_GRAFIK where to_char(data_graf, ''yyyy'')=''' + IntToStr(spnedSampleYear.Value) + ''' AND tip_smen=0');
  dmMain.sqlqryTemp.Active := True;
  dmMain.sqlqryTemp.First;
  for i := 1 to 12 do begin
    for j := 1 to 31 do
      arrCalendar[i, j] := dmMain.sqlqryTemp.Fields[j - 1].AsString;
    dmMain.sqlqryTemp.Next;
  end;

{
0 - праздник является выходным днем, воскресенье является выходным (выходные из календаря)
1 - праздник не является выходным
2 - праздник является выходным и разбивает цикл
3 - воскресенье и праздник являются выходными и разбивают цикл
4 - праздник является выходным, но не разбивает цикл
}
  case cboxHollidays.ItemIndex of
    0:
      begin
      //0 - праздник является выходным днем, воскресенье является выходным (выходные из календаря)
      //Выбираем все выходные и праздники из календаря
        for i := 1 to 12 do begin
          strgrdSample.Cells[1, i] := strgrdShifts.Cells[1, 1];
          for j := 2 to DaysInAMonth(spnedSampleYear.Value, i) + 1 do begin
            if (arrCalendar[i, j - 1] = ' П') or (arrCalendar[i, j - 1] = ' В') then
              strgrdSample.Cells[j, i] := arrCalendar[i, j - 1]
            else
              strgrdSample.Cells[j, i] := Copy(strCycle, iCurrPos, 2);
            inc(iCurrPos, 2);
            iCurrPos := iCurrPos mod iDaysInCycle;
          end;
        end;
      end;
    1:
      begin
      //1 - праздник не является выходным
        for i := 1 to 12 do begin
          strgrdSample.Cells[1, i] := strgrdShifts.Cells[1, 1];
          for j := 2 to DaysInAMonth(spnedSampleYear.Value, i) + 1 do begin
            strgrdSample.Cells[j, i] := Copy(strCycle, iCurrPos, 2);
            inc(iCurrPos, 2);
            iCurrPos := iCurrPos mod iDaysInCycle;
          end;
        end;
      end;
    2:
      begin
      //2 - праздник является выходным и разбивает цикл
        ShowMessage('Расчет примерного графика работы для данного типа реакции на праздники пока не реализован');
      end;
    3:
      begin
      //3 - воскресенье и праздник являются выходными и разбивают цикл
        ShowMessage('Расчет примерного графика работы для данного типа реакции на праздники пока не реализован');
      end;
    4:
      begin
      //4 - праздник является выходным, но не разбивает цикл
        ShowMessage('Расчет примерного графика работы для данного типа реакции на праздники пока не реализован');
      end;
  end;
end;

function TfrmNewSchedule.CheckSchedule: Boolean;
var
  i: Integer;
  myRect: TGridRect;
begin
  result := True;
  if edNameU.Text = '' then begin
    ShowMessage('Введите наименование графика');
    edNameU.SetFocus;
    result := False;
    exit;
  end;
  if edNameR.Text = '' then begin
    ShowMessage('Введите украинское наименование графика');
    edNameR.SetFocus;
    result := False;
    exit;
  end;
  if (strgrdMarks.ColCount = 1) and (strgrdMarks.Cells[0, 0] = '') then begin
    ShowMessage('Не выбраны отметки для графика');
    strgrdMarks.SetFocus;
    result := False;
    exit;
  end;
  if (strgrdCycle.ColCount = 1) and (strgrdCycle.Cells[0, 0] = '') then begin
    ShowMessage('Не определен цикл работы для графика');
    strgrdCycle.SetFocus;
    result := False;
    exit;
  end;
  for i := 1 to strgrdShifts.RowCount - 1 do begin
    if (Length(strgrdShifts.Cells[1, i]) > 2) or (strgrdShifts.Cells[1, i] = '') then begin
      ShowMessage('Обозначение смены должно содержать 1 или 2 символа');
      strgrdShifts.SetFocus;
      myRect.Left := 1;
      myRect.Top := i;
      myRect.Right := 1;
      myRect.Bottom := i;
      strgrdShifts.Selection := myRect;
      strgrdShiftsDblClick(nil);
      result := False;
      exit;
    end;
    if strgrdShifts.Cells[2, i] = '' then begin
      ShowMessage('Введите наименование смены');
      strgrdShifts.SetFocus;
      myRect.Left := 2;
      myRect.Top := i;
      myRect.Right := 2;
      myRect.Bottom := i;
      strgrdShifts.Selection := myRect;
      strgrdShiftsDblClick(nil);
      result := False;
      exit;
    end;
    if strgrdShifts.Cells[3, i] = '' then begin
      ShowMessage('Введите украинское наименование смены');
      strgrdShifts.SetFocus;
      myRect.Left := 3;
      myRect.Top := i;
      myRect.Right := 3;
      myRect.Bottom := i;
      strgrdShifts.Selection := myRect;
      strgrdShiftsDblClick(nil);
      result := False;
      exit;
    end;
  end;
end;

procedure TfrmNewSchedule.edNameUChange(Sender: TObject);
begin
  if (edNameR.Text = '') or (edNameR.Text = Copy(edNameU.Text, 1, Length(edNameU.Text) - 1)) then
    edNameR.Text := edNameU.Text;
  edNameU.Hint := 'Наименование графика на русском языке (' + IntToStr(Length(edNameU.Text)) + ' символов из 20-ти возможных)';
end;

procedure TfrmNewSchedule.strgrdMarksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_INSERT then
    spbtnAddMarkClick(Sender)
  else if Key = VK_DELETE then
    spbtnDeleteMarkClick(Sender);
end;

procedure TfrmNewSchedule.cboxCellDropDown(Sender: TObject);
begin
  cboxCell.Items := strgrdMarks.Rows[0];
end;

procedure TfrmNewSchedule.strgrdMarksDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Buf: array[byte] of char;
begin
  if State = [gdFixed] then
    Exit;

  with strgrdMarks do begin
    Canvas.Font := Font;
    Canvas.Font.Color := clWindowText;
    Canvas.Brush.Color := clWindow;

    Canvas.FillRect(Rect);
    StrPCopy(Buf, Cells[ACol, ARow]);
    DrawText(Canvas.Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_CENTER);
  end;
end;

procedure TfrmNewSchedule.strgrdSampleDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Buf: array[byte] of char;
begin
  //strgrdSample.Canvas.Font.Color := clWindowText;
  if (ARow = 0) or (ACol < strgrdSample.FixedCols) then //begin
    strgrdSample.Canvas.Font.Style := strgrdSample.Canvas.Font.Style + [fsBold]
  else if (strgrdSample.Cells[ACol, ARow] = ' В') then
    strgrdSample.Canvas.Font.Color := clRed
  else if (strgrdSample.Cells[ACol, ARow] = ' П') then begin
    strgrdSample.Canvas.Font.Color := clRed;
    strgrdSample.Canvas.Font.Style := strgrdSample.Canvas.Font.Style + [fsBold];
  end;

  strgrdSample.Canvas.FillRect(Rect);

  StrPCopy(Buf, strgrdSample.Cells[ACol, ARow]);
  DrawText(strgrdSample.Canvas.Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_CENTER);
end;

procedure TfrmNewSchedule.strgrdShiftsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Buf: array[byte] of char;
begin
  with TStringGrid(Sender) do
    if (ARow = 0) or (ACol = 0) then begin
      Canvas.Font.Style := Font.Style + [fsBold];
      Canvas.FillRect(Rect);
      StrPCopy(Buf, Cells[ACol, ARow]);
      DrawText(Canvas.Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_CENTER);
    end;
end;

procedure TfrmNewSchedule.spbtnShiftCycleADayRightClick(Sender: TObject);
var
  i: Integer;
//  sFirstDay: String;
  sLastDay: string;
begin
  {
  //Сдвигаем на один день влево
  sFirstDay := strgrdCycle.Cells[0, 0];
  for i:=0 to strgrdCycle.ColCount-2 do
    strgrdCycle.Cells[i, 0] := strgrdCycle.Cells[i+1, 0];
  strgrdCycle.Cells[strgrdCycle.ColCount-1, 0] := sFirstDay;
  }
  sLastDay := strgrdCycle.Cells[strgrdCycle.ColCount - 1, 0];
  for i := strgrdCycle.ColCount - 1 downto 1 do
    strgrdCycle.Cells[i, 0] := strgrdCycle.Cells[i - 1, 0];
  strgrdCycle.Cells[0, 0] := sLastDay;
end;

procedure TfrmNewSchedule.bitbtnCheckScheduleClick(Sender: TObject);
begin
  CheckSchedule;
end;

procedure TfrmNewSchedule.edNameUKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_BACK then
    if edNameU.Text = edNameR.Text then
      edNameR.Text := Copy(edNameR.Text, 1, Length(edNameR.Text) - 1);
end;

procedure TfrmNewSchedule.mniGetScheduleTypeClick(Sender: TObject);
var
  i: Integer;
begin
  frmGetCode := TfrmGetCode.Create(nil);
  frmGetCode.Tag := 3; // Работаем с ID_SMEN
  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    dmMain.sqlqryTemp.Active := False;
    dmMain.sqlqryTemp.SQL.Clear;
    dmMain.sqlqryTemp.SQL.Add('select ID_SMEN from QWERTY.SP_ZAR_S_SMEN order by ID_SMEN');
    dmMain.sqlqryTemp.Active := True;
    while not (dmMain.sqlqryTemp.Eof) do begin
      frmGetCode.slValues.Add(dmMain.sqlqryTemp.Fields[0].AsString);
      dmMain.sqlqryTemp.Next;
    end;
    dmMain.sqlqryTemp.Active := False;
    frmGetCode.FillGrid;
    frmGetCode.ShowModal;
  finally
    if frmGetCode.returnCode <> '' then
      if Length(frmGetCode.returnCode) > 2 then begin
        for i := 1 to Trunc(Length(frmGetCode.returnCode) / 2) do
        try
          strgrdShifts.Cells[1, i] := Copy(frmGetCode.returnCode, i * 2 - 1, 2);
        except

        end;
      end
      else
        strgrdShifts.Cells[1, strgrdShifts.Row] := frmGetCode.returnCode;
    frmGetCode.Free;
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;
end;

procedure TfrmNewSchedule.mniShowScheduleTypesClick(Sender: TObject);
var
  sValue: string;
begin
  dmMain.sqlqryTemp.Active := False;
  dmMain.sqlqryTemp.SQL.Clear;
  dmMain.sqlqryTemp.SQL.Add('select ID_SMEN from QWERTY.SP_ZAR_S_SMEN order by ID_SMEN');
  dmMain.sqlqryTemp.Active := True;
  while not (dmMain.sqlqryTemp.Eof) do begin
    sValue := sValue + dmMain.sqlqryTemp.Fields[0].AsString + ', ';
    dmMain.sqlqryTemp.Next;
  end;
  dmMain.sqlqryTemp.Active := False;
  ShowMessage(sValue);
end;

procedure TfrmNewSchedule.FillInScheduleInfo;
var
  i: Integer;
begin
  edScheduleType.Text := IntToStr(Self.Schedule.ScheduleType);
  edNameU.Text := Self.Schedule.NameU;
  edNameR.Text := Self.Schedule.NameR;
  frmNewSchedule.Caption := 'Редактирование графика: ' + edNameU.Text + IfThen(edNameU.Text <> edNameR.Text, ' [' + edNameR.Text + ']', '');
  spnedDays.Value := Self.Schedule.NumOfDays;
  spnedShifts.Value := Self.Schedule.NumOfShifts;
  strgrdMarks.ColCount := Self.Schedule.MarkIndexesCount;

  for i := 0 to strgrdMarks.ColCount - 1 do begin
    strgrdMarks.Cells[i, 0] := TMark(oblstMarkList.Items[Self.Schedule.MarkIndexes[i]]).MarkID;
    cboxCell.Items.Add(strgrdMarks.Cells[i, 0]);
  end;
  strgrdCycle.ColCount := Trunc(Length(Self.Schedule.Cycle) / 2);
  //strgrdCycle.ScrollBars := ssNone;
  for i := 0 to strgrdCycle.ColCount - 1 do begin
    strgrdCycle.Cells[i, 0] := Copy(Self.Schedule.Cycle, 2 * i + 1, 2);
  end;
  for i := 0 to spnedShifts.Value - 1 do begin
    strgrdShifts.Cells[1, i + 1] := Self.Schedule.Shifts[i].ShiftID;
    strgrdShifts.Cells[2, i + 1] := Self.Schedule.Shifts[i].NameU;
    strgrdShifts.Cells[3, i + 1] := Self.Schedule.Shifts[i].NameR;
  end;
  cboxHollidays.ItemIndex := Self.Schedule.HollidayType;
end;

procedure TfrmNewSchedule.edNameRChange(Sender: TObject);
begin
  edNameR.Hint := 'Наименование графика на украинском языке или описание (' + IntToStr(Length(edNameR.Text)) + ' символов из 20-ти возможных)';
end;

procedure TfrmNewSchedule.pupmShiftsPopup(Sender: TObject);
begin
  if frmNewSchedule.Tag <> -1 then
    Exit;
end;

end.


