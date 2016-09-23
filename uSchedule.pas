unit uSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ExtCtrls, ActnList, uFrameSchedule, udmMain,
  Menus, ImgList, Math, StrUtils;

type
  TfrmSchedule = class(TForm)
    stbarStatus: TStatusBar;
    tlbarToolBar: TToolBar;
    pnlLeftDock: TPanel;
    pnlBottomDock: TPanel;
    pnlRightDock: TPanel;
    spltrVerticalL: TSplitter;
    spltrHorizontalB: TSplitter;
    aclstSchedule: TActionList;
    acShowDock: TAction;
    spltrVerticalR: TSplitter;
    frameSchedule1: TframeSchedule;
    tlbtnRefresh: TToolButton;
    tlbtnCalculateWorktime: TToolButton;
    tlbtnColoredMode: TToolButton;
    tlbtnChangeCurYear: TToolButton;
    tlbtnScheduleCalculate: TToolButton;
    pmPopup: TPopupMenu;
    N1: TMenuItem;
    pmiChangeMark: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    pmiChangeMarkAgain: TMenuItem;
    tlbtnShowMarkTime: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton1: TToolButton;
    tlbtnChangeFormYear: TToolButton;
    pmYears: TPopupMenu;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    pmScheduleTime: TPopupMenu;
    pmiEnableEdit: TMenuItem;
    N2: TMenuItem;
    pmiCopyDayTimeFromDnevniki: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tlbtnRefreshClick(Sender: TObject);
    procedure tlbtnColoredModeClick(Sender: TObject);
    procedure frameSchedule1strgrdScheduleSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure tlbtnChangeCurYearClick(Sender: TObject);
    procedure tlbtnCalculateWorktimeClick(Sender: TObject);
    procedure tlbtnScheduleCalculateClick(Sender: TObject);
    procedure pmiChangeMarkClick(Sender: TObject);
    procedure pmPopupPopup(Sender: TObject);
    procedure pmiChangeMarkAgainClick(Sender: TObject);
    procedure tlbtnShowMarkTimeClick(Sender: TObject);
    procedure pmiChangeYearClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure tlbtnChangeFormYearClick(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure pmiEnableEditClick(Sender: TObject);
    procedure frameSchedule1strgrdScheduleTimeDblClick(Sender: TObject);
    procedure pmScheduleTimePopup(Sender: TObject);
    procedure pmiCopyDayTimeFromDnevnikiClick(Sender: TObject);
    procedure frameSchedule1strgrdScheduleTimeKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
    sMarkForChange: String;
    bRecalculateWorkTime: Boolean;
  public
    { Public declarations }
    Schedule: TSchedule;
    iFormYear: Integer;
    iScheduleType: Integer;
    procedure ChangeFormName;
    procedure AddScheduleYears;
    function GetMonthByName(MonthName: String): Integer;
    function ChangeMark(newMark, ShiftID: String; iYear, iMonth, iDay: Integer; RecalculateWorktime: Boolean): Boolean;
    function RefreshSchedule: Boolean;
    procedure ShowSchedule(sScheduleType: String; sYear: String; bRefreshYears: Boolean = True); overload;
    procedure ShowSchedule(iScheduleType: Integer; iYear: Integer; bRefreshYears: Boolean = True); overload;
  end;

var
  frmSchedule: TfrmSchedule;

implementation

uses uMain, Grids, uChangeMark, uPrintSchedule, DBConnect;

{$R *.dfm}

procedure TfrmSchedule.ChangeFormName;
begin
  self.Caption := IfThen(self.Schedule.NameU<>self.Schedule.NameR, Self.Schedule.NameU + ' (' + Self.Schedule.NameR + ')', Self.Schedule.NameU)+' на '+IntToStr(iFormYear)+' год';
end;

procedure TfrmSchedule.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSchedule.FormCreate(Sender: TObject);
{var
  i: Integer;
  menuItem: TMenuItem;
  strlstYears: TStrings;
}
begin
  self.Schedule := TSchedule.Create;
  sMarkForChange := '';
  bRecalculateWorkTime := False;

  //self.Schedule := TSchedule(oblstScheduleList.Items[3]);
  //frameSchedule1.ShowSchedule(self.Schedule.ScheduleType, sCurYear);
  iFormYear := iCurYear;
  frameSchedule1.ColoredMode := frmMain.acColoredMode.Checked;
  tlbtnColoredMode.Down := frameSchedule1.ColoredMode;
  frameSchedule1.ShowMarkTime := frmMain.acShowMarkTime.Checked;
  tlbtnShowMarkTime.Down := frameSchedule1.ShowMarkTime;

  //Следующий блок выносится в отдельную процедуру AddScheduleYears,
  // которая вызывается после заполнения данных о смене в ShowSchedule
  {
  strlstYears := TStringList.Create;
  strlstYears := GetYears(self.Schedule.ScheduleType);
  for i:=strlstYears.Count-1 downto 0 do begin
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := strlstYears.Strings[i];
    menuItem.OnClick := pmiChangeYearClick;
    pmYears.Items.Add(menuItem);
  end;
  strlstYears.Free;
  }
end;

procedure TfrmSchedule.tlbtnRefreshClick(Sender: TObject);
var
  iRow, iCol, iTimeRow, iTimeCol, iTopRow, iLeftCol: Integer;
begin
  frameSchedule1.strgrdSchedule.DisableAlign;
  frameSchedule1.strgrdScheduleTime.DisableAlign;
  iRow     := frameSchedule1.strgrdSchedule.Row;
  iCol     := frameSchedule1.strgrdSchedule.Col;
  iTimeRow := frameSchedule1.strgrdScheduleTime.Row;
  iTimeCol := frameSchedule1.strgrdScheduleTime.Col;
  iTopRow  := frameSchedule1.strgrdSchedule.TopRow;
  iLeftCol := frameSchedule1.strgrdSchedule.LeftCol;
  try
    if iScheduleType <> Schedule.ScheduleType then
      self.Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByType(iScheduleType)]);
    ShowSchedule(Schedule.ScheduleType, iFormYear);
    ChangeFormName;
    frameSchedule1.strgrdSchedule.Col     := IfThen(iCol<frameSchedule1.strgrdSchedule.FixedCols, frameSchedule1.strgrdSchedule.FixedCols, iCol);
    frameSchedule1.strgrdSchedule.Row     := IfThen(iRow<frameSchedule1.strgrdSchedule.FixedRows, frameSchedule1.strgrdSchedule.FixedRows, iRow);
    frameSchedule1.strgrdScheduleTime.Col := iTimeCol;
    frameSchedule1.strgrdScheduleTime.Row := IfThen(iTimeRow<frameSchedule1.strgrdScheduleTime.FixedRows, frameSchedule1.strgrdSchedule.FixedRows, iTimeRow);
    frameSchedule1.strgrdSchedule.LeftCol := IfThen(iLeftCol<frameSchedule1.strgrdSchedule.FixedCols, frameSchedule1.strgrdSchedule.FixedCols, iLeftCol);
    frameSchedule1.strgrdSchedule.TopRow  := IfThen(iTopRow<frameSchedule1.strgrdSchedule.FixedRows, frameSchedule1.strgrdSchedule.FixedRows, iTopRow);
  finally
    frameSchedule1.strgrdSchedule.EnableAlign;
    frameSchedule1.strgrdScheduleTime.EnableAlign;
  end;
end;

procedure TfrmSchedule.tlbtnColoredModeClick(Sender: TObject);
begin
  frmMain.acColoredModeExecute(Sender);
  frameSchedule1.ColoredMode := frmMain.acColoredMode.Checked;
  tlbtnColoredMode.Down := frmMain.acColoredMode.Checked;
  frameSchedule1.strgrdSchedule.Repaint;
end;

procedure TfrmSchedule.frameSchedule1strgrdScheduleSelectCell(
  Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  iMonth: Byte;
  sMonth: String;
begin
  frameSchedule1.strgrdScheduleSelectCell(Sender, ACol, ARow, CanSelect);

  try
    with TMark(oblstMarkList.Items[GetMarkIndexByID(frameSchedule1.strgrdSchedule.Cells[ACol, ARow])]) do
      begin
        //stbarStatus.Panels.Items[1].Text := '['+MarkID+'] '+Description+' ('+FloatToStr(WorkTime)+'/'+FloatToStr(EveningTime)+'/'+FloatToStr(NightTime)+'/'+IntToStr(LunchTime)+')';
        stbarStatus.Panels.Items[1].Text := '['+MarkID+'] '+Description+' ('+FormatFloat('0.##', WorkTime)+'/'+FormatFloat('0.##', EveningTime)+'/'+FormatFloat('0.##', NightTime)+'/'+IntToStr(LunchTime)+')';
        //stbarStatus.Panels.Items[1].Width := max(Trunc(Canvas.TextWidth(stbarStatus.Panels.Items[1].Text)*1.25), stbarStatus.Panels.Items[1].Width);
      end;
    sMonth := frameSchedule1.strgrdSchedule.Cells[0, ARow];
    iMonth := GetMonthByName(sMonth);
    //stbarStatus.Panels.Items[0].Text := FormatDateTime('dd.mm.yyyy - dddd', EncodeDate(iFormYear, ((ARow-1) div self.Schedule.NumOfShifts)+1, ACol-1));
    stbarStatus.Panels.Items[0].Text := FormatDateTime('dd.mm.yyyy - dddd', EncodeDate(iFormYear, iMonth, ACol-1));
  except
    stbarStatus.Panels.Items[0].Text := '';
    stbarStatus.Panels.Items[1].Text := ' - ';
  end;
end;

procedure TfrmSchedule.tlbtnChangeCurYearClick(Sender: TObject);
begin
  try
    frmMain.acChangeCurYearExecute(Sender);
  finally
    iFormYear := iCurYear;
    tlbtnRefreshClick(Sender);
  end;
end;

procedure TfrmSchedule.tlbtnCalculateWorktimeClick(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to self.Schedule.ShiftsCount-1 do
    frmMain.CalculateScheduleWorktime(FormatDateTime('dd.mm.yyyy', EncodeDate(iFormYear, 1, 1)), self.Schedule.Shifts[i].ShiftID, True, True);
  tlbtnRefreshClick(Sender);
end;

procedure TfrmSchedule.tlbtnScheduleCalculateClick(Sender: TObject);
begin
  frmMain.acCalculateExecute(Sender);
  AddScheduleYears;
  tlbtnRefreshClick(Sender);
end;

procedure TfrmSchedule.pmiChangeMarkClick(Sender: TObject);
var
  i: Integer;
begin
  frmChangeMark := TfrmChangeMark.Create(Application);
  with frmChangeMark do
  try
    lstboxMarks.Clear;

    iDay      := frameSchedule1.strgrdSchedule.Col-1;
    iMonth    := GetMonthByName(frameSchedule1.strgrdSchedule.Cells[0, frameSchedule1.strgrdSchedule.Row]);
    iYear     := iFormYear;
    sShiftID  := frameSchedule1.strgrdSchedule.Cells[1, frameSchedule1.strgrdSchedule.Row];
    sPrevMark := frameSchedule1.strgrdSchedule.Cells[frameSchedule1.strgrdSchedule.Col, frameSchedule1.strgrdSchedule.Row];

    {
    for i:=0 to self.Schedule.MarkIndexesCount-1 do begin
      if (frameSchedule1.strgrdSchedule.Cells[frameSchedule1.strgrdSchedule.Col, frameSchedule1.strgrdSchedule.Row]<>TMark(oblstMarkList.Items[self.Schedule.MarkIndexes[i]]).MarkID) then
        lstboxMarks.Items.Add(TMark(oblstMarkList.Items[self.Schedule.MarkIndexes[i]]).MarkID+' - '+TMark(oblstMarkList.Items[self.Schedule.MarkIndexes[i]]).Description+' ('+FloatToStr(TMark(oblstMarkList.Items[self.Schedule.MarkIndexes[i]]).WorkTime)+'/'+FloatToStr(TMark(oblstMarkList.Items[self.Schedule.MarkIndexes[i]]).EveningTime)+'/'+FloatToStr(TMark(oblstMarkList.Items[self.Schedule.MarkIndexes[i]]).NightTime)+')');
    end;
    }
    _Schedule := self.Schedule;
    _DontShowMark := frameSchedule1.strgrdSchedule.Cells[frameSchedule1.strgrdSchedule.Col, frameSchedule1.strgrdSchedule.Row];
    FillIn(not(tlbtnShowMarkTime.Down));
    
    ShowModal;
  finally
    if not(CancelPressed) then begin
      ChangeMark(sNewMark, sShiftID, iYear, iMonth, iDay, chkboxRecalculateWorktime.Checked);
      bRecalculateWorkTime := chkboxRecalculateWorktime.Checked;
    end;
    tlbtnRefreshClick(Sender);
    Free;
  end;
end;

function TfrmSchedule.GetMonthByName(MonthName: String): Integer;
var
  sMonthName: String;
begin
  result := 0;
  sMonthName := AnsiUpperCase(MonthName);
  case sMonthName[1] of
    'Я': result := 1;
    'Ф': result := 2;
    'М': if sMonthName='МАРТ' then
            result := 3
          else
            result := 5;
    'А': if sMonthName='АПРЕЛЬ' then
            result := 4
          else
            result := 8;
    'И': if sMonthName='ИЮНЬ' then
            result := 6
          else
            result := 7;
    'С': result := 9;
    'О': result := 10;
    'Н': result := 11;
    'Д': result := 12;
  end;
end;

function TfrmSchedule.ChangeMark(newMark, ShiftID: String; iYear, iMonth,
  iDay: Integer; RecalculateWorktime: Boolean): Boolean;
var
  sSQL: String;
begin
  try
    sSQL := 'update QWERTY.SP_ZAR_GRAFIK set D'+IntToStr(iDay)+'='''+newMark+''' where data_graf=to_date('''+FormatDateTime('dd.mm.yyyy', EncodeDate(iYear, iMonth, 1))+''', ''dd.mm.yyyy'') and id_smen='''+ShiftID+'''';
    dmMain.sqlconDB.ExecuteDirect(sSQL);
    result := True;
    tlbtnRefreshClick(self);
    sMarkForChange := newMark;
    stbarStatus.Panels.Items[2].Text := 'Заменить выделенную отметку на "'+sMarkForChange+'" ('+IfThen(RecalculateWorktime, 'пересчитывать', 'не пересчитывать')+' время)';
    bRecalculateWorkTime := RecalculateWorktime;
    if RecalculateWorktime then
      frmMain.CalculateScheduleWorktime(FormatDateTime('dd.mm.yyyy', EncodeDate(iFormYear, 1, 1)), ShiftID, True, True);
  except
    result := False;
  end;
end;

procedure TfrmSchedule.pmPopupPopup(Sender: TObject);
begin
  if sMarkForChange<>'' then
    pmiChangeMarkAgain.Enabled := True
  else
    pmiChangeMarkAgain.Enabled := False;
end;

procedure TfrmSchedule.pmiChangeMarkAgainClick(Sender: TObject);
begin
  ChangeMark(sMarkForChange, frameSchedule1.strgrdSchedule.Cells[1, frameSchedule1.strgrdSchedule.Row], iFormYear, GetMonthByName(frameSchedule1.strgrdSchedule.Cells[0, frameSchedule1.strgrdSchedule.Row]), frameSchedule1.strgrdSchedule.Col-1, bRecalculateWorkTime);
  tlbtnRefreshClick(Sender);
end;

procedure TfrmSchedule.tlbtnShowMarkTimeClick(Sender: TObject);
begin
  frmMain.acShowMarkTimeExecute(Sender);
  frameSchedule1.ShowMarkTime := frmMain.acShowMarkTime.Checked;
  tlbtnShowMarkTime.Down := frameSchedule1.ShowMarkTime;
  frameSchedule1.strgrdSchedule.Repaint;
end;

procedure TfrmSchedule.pmiChangeYearClick(Sender: TObject);
var
  _Year: Integer;
begin
  try
    _Year := StrToInt(Concat(Copy(TMenuItem(Sender).Caption, 1, Pos('&', TMenuItem(Sender).Caption)-1), Copy(TMenuItem(Sender).Caption, Pos('&', TMenuItem(Sender).Caption)+1, 4)));
    iFormYear := _Year;
    tlbtnRefreshClick(Sender);
  except
  end;
end;

procedure TfrmSchedule.N1Click(Sender: TObject);
begin
  frameSchedule1.strgrdScheduleDblClick(Sender);
end;

procedure TfrmSchedule.tlbtnChangeFormYearClick(Sender: TObject);
var
  p: TPoint;
begin
  p := Mouse.CursorPos;
  pmYears.Popup(p.X, p.Y);
end;

procedure TfrmSchedule.ToolButton6Click(Sender: TObject);
var
  schSchedule: TSchedule;
begin
  schSchedule := self.Schedule;

  frmPrintSchedule := TfrmPrintSchedule.Create(Application);

  frmPrintSchedule.sScheduleYear := IntToStr(iFormYear);
  frmPrintSchedule.sScheduleType := IntToStr(schSchedule.ScheduleType);
if iFormYear=2007 then
asm
   int 3
end;
  frmPrintSchedule.iNumOfShifts           := schSchedule.NumOfShifts;
  frmPrintSchedule.strgrdSchedule         := frameSchedule1.strgrdSchedule;
  //frmPrintSchedule.FillInLegend;
  frmPrintSchedule.strgrdScheduleTime     := frameSchedule1.strgrdScheduleTime;
  frmPrintSchedule.strgrdScheduleTotal    := frameSchedule1.strgrdScheduleTotal;
  frmPrintSchedule.lblTitleFirst.Caption  := schSchedule.NameU;
  frmPrintSchedule.lblTitleSecond.Caption := schSchedule.NameR;
  if not((AnsiLowerCase(frmPrintSchedule.lblTitleThird.Caption) = 'на %year% год') or (AnsiLowerCase(frmPrintSchedule.lblTitleThird.Caption) = 'на %год% год')) then
    frmPrintSchedule.lblTitleThird.Caption  := 'на '+IntToStr(iFormYear)+' год';

  frmPrintSchedule.RestoreSettings;
  //frmPrintSchedule.FillInLegend;

  frmPrintSchedule.ShowModal;
  frmPrintSchedule.Free;
end;

procedure TfrmSchedule.pmiEnableEditClick(Sender: TObject);
begin
  if pmiEnableEdit.Caption='Разрешить редактирование' then begin
    pmiEnableEdit.Caption := 'Запретить редактирование';
    pmiEnableEdit.Tag     := 1;
    frameSchedule1.strgrdScheduleTime.Options := frameSchedule1.strgrdScheduleTime.Options - [goRowSelect];
    frameSchedule1.strgrdScheduleTime.Col := 1;
  end
  else begin
    pmiEnableEdit.Caption := 'Разрешить редактирование';
    pmiEnableEdit.Tag     := 0;
    frameSchedule1.strgrdScheduleTime.Options := frameSchedule1.strgrdScheduleTime.Options + [goRowSelect];
  end;
end;

procedure TfrmSchedule.frameSchedule1strgrdScheduleTimeDblClick(
  Sender: TObject);
var
  strNewValue, strSQL: String;
  fNewValue: Double;
begin
  if goRowSelect in frameSchedule1.strgrdScheduleTime.Options then
    Exit;
  if InputQuery('Изменение значения', 'Предыдущее значение: '+frameSchedule1.strgrdScheduleTime.Cells[frameSchedule1.strgrdScheduleTime.Col, frameSchedule1.strgrdScheduleTime.Row], strNewValue) then begin
    try
      fNewValue := StrToFloat(strNewValue);
      if Application.MessageBox(PChar('Вы действительно хотите заменить значение '+frameSchedule1.strgrdScheduleTime.Cells[frameSchedule1.strgrdScheduleTime.Col, frameSchedule1.strgrdScheduleTime.Row]+' на '+strNewValue+'?'), 'Изменение значения', MB_YESNO)=ID_YES then begin
        //Выполнение запроса на изменение значения
        // что конкретно необходимо изменить определяется по названию колонкои грида
        //+Дни +Часы +024 +023 +033 +Ночные +Вечерние
        strSQL := 'update QWERTY.SP_ZAR_GRAFIK set';
        if Pos(WrongDecimalSeparator, strNewValue)<>0 then
          strNewValue := StringReplace(strNewValue, WrongDecimalSeparator, RightDecimalSeparator, []);
        case frameSchedule1.strgrdScheduleTime.Cells[frameSchedule1.strgrdScheduleTime.Col, 0][1] of
          'Д': begin
            strSQL := strSQL + ' DAY_GRAF';
          end;
          'Ч': begin
            strSQL := strSQL + ' TIME_GRAF';
          end;
          'Н': begin
            strSQL := 'update QWERTY.SP_ZAR_GRAFIK_NV set TIME_N';
          end;
          'В': begin
            strSQL := 'update QWERTY.SP_ZAR_GRAFIK_NV set TIME_V';
          end;
          '0':  if frameSchedule1.strgrdScheduleTime.Cells[frameSchedule1.strgrdScheduleTime.Col, 0]='024' then begin
                  strSQL := strSQL + ' TIME_PER';
                end
                else
                  if frameSchedule1.strgrdScheduleTime.Cells[frameSchedule1.strgrdScheduleTime.Col, 0]='023' then begin
                    strSQL := strSQL + ' TIME_PRA1';
                  end
                  else begin
                    strSQL := strSQL + ' TIME_PRA2';
                  end;
        end;
        strSQL := strSQL + '='+strNewValue+' where DATA_GRAF=to_date('''+FormatDateTime('dd.mm.yyyy', EncodeDate(iFormYear, GetMonthByName(frameSchedule1.strgrdSchedule.Cells[0, frameSchedule1.strgrdSchedule.Row]), 1))+''', ''dd.mm.yyyy'') and ID_SMEN='''+frameSchedule1.strgrdSchedule.Cells[1, frameSchedule1.strgrdScheduleTime.Row]+'''';
        dmMain.sqlqryTemp.Active := False;
        dmMain.sqlqryTemp.SQL.Clear;
        dmMain.sqlqryTemp.SQL.Add(strSQL);
        dmMain.sqlqryTemp.ExecSQL(True);
        tlbtnRefreshClick(Sender);
      end;
    except
      on e: EConvertError do
        ShowMessage('Ошибка ввода: неверное число (возможно проблема в разделителе целой и дробной части)'+#10#13+e.Message);
    end;
  end;
end;

procedure TfrmSchedule.pmScheduleTimePopup(Sender: TObject);
begin
  pmiCopyDayTimeFromDnevniki.Enabled := (Schedule.ScheduleType = 2) and (pmiEnableEdit.Tag = 1);
end;

procedure TfrmSchedule.pmiCopyDayTimeFromDnevnikiClick(Sender: TObject);
begin
  case Application.MessageBox(PChar('Скопировать значения за текущий месяц [Да] или весь год [Нет]?'), 'Копирование значений из дневного графика', MB_YESNOCANCEL) of
    ID_YES: begin
      dmMain.sqlqryTemp.SQL.Clear;
      dmMain.sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.COPY_DAYS_TIME_FROM_DAYSTAFF('''+FormatDateTime('dd.mm.yyyy', EncodeDate(iFormYear, GetMonthByName(frameSchedule1.strgrdSchedule.Cells[0, frameSchedule1.strgrdSchedule.Row]), 1))+''', FALSE); end;');
      dmMain.sqlqryTemp.ExecSQL(True);
      tlbtnRefreshClick(Sender);
    end;
    ID_NO: begin
      dmMain.sqlqryTemp.SQL.Clear;
      dmMain.sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.COPY_DAYS_TIME_FROM_DAYSTAFF('''+FormatDateTime('dd.mm.yyyy', EncodeDate(iFormYear, GetMonthByName(frameSchedule1.strgrdSchedule.Cells[0, frameSchedule1.strgrdSchedule.Row]), 1))+''', TRUE); end;');
      dmMain.sqlqryTemp.ExecSQL(True);
      tlbtnRefreshClick(Sender);
    end;
  end;
end;

procedure TfrmSchedule.frameSchedule1strgrdScheduleTimeKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then
    if Key = VK_RETURN then
      frameSchedule1strgrdScheduleTimeDblClick(Sender);
end;

function TfrmSchedule.RefreshSchedule: Boolean;
begin
  Result := False;

  tlbtnRefreshClick(nil);

  Result := True;
end;

procedure TfrmSchedule.AddScheduleYears;
var
  i, j, k: Integer;
  menuItem, subMenuItem: TMenuItem;
  strlstYears: TStrings;
begin
  pmYears.Items.Clear;
  strlstYears := GetYears(self.Schedule.ScheduleType);
  k := 4; //Такое количество годов не будут убираться в подменю
  j := IfThen(strlstYears.Count > k, strlstYears.Count - k, 0);
  for i:=strlstYears.Count-1 downto j do begin
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := strlstYears.Strings[i];
    menuItem.OnClick := pmiChangeYearClick;
    pmYears.Items.Add(menuItem);
  end;
  if j<>0 then begin
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := 'Другие года';
    pmYears.Items.Add(menuItem);
    for i:=j-1 downto 0 do begin
      menuItem := TMenuItem.Create(self);
      menuItem.Caption := strlstYears.Strings[i];
      menuItem.OnClick := pmiChangeYearClick;
      pmYears.Items[k].Add(menuItem);
    end;
  end;
  strlstYears.Free;
end;

procedure TfrmSchedule.N4Click(Sender: TObject);
begin
  tlbtnRefreshClick(Sender);
end;

procedure TfrmSchedule.ShowSchedule(sScheduleType, sYear: String; bRefreshYears: Boolean = True);
begin
  if bRefreshYears then
    AddScheduleYears;
  Self.frameSchedule1.ShowSchedule(sScheduleType, sYear);
end;

procedure TfrmSchedule.ShowSchedule(iScheduleType, iYear: Integer; bRefreshYears: Boolean = True);
begin
  self.ShowSchedule(IntToStr(iScheduleType), IntToStr(iYear), bRefreshYears);
end;

end.
