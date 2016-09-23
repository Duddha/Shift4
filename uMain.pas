unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ActnList, ImgList, Menus, ComCtrls, StdActns, ToolWin, Grids;

type
  TfrmMain = class(TForm)
    stbarStatus: TStatusBar;
    mmMain: TMainMenu;
    aclstMain: TActionList;
    imglstActions: TImageList;
    acNewSchedule: TAction;
    acScheduleInfo: TAction;
    acShowSchedule: TAction;
    acChangeCurYear: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    acExit: TAction;
    N4: TMenuItem;
    mmiWindow: TMenuItem;
    N6: TMenuItem;
    N5: TMenuItem;
    mmiShowSchedule: TMenuItem;
    acMarkInfo: TAction;
    mniMarks: TMenuItem;
    acNewMark: TAction;
    acHolidays: TAction;
    N8: TMenuItem;
    N9: TMenuItem;
    acScheduleList: TAction;
    N10: TMenuItem;
    acCalculate: TAction;
    N11: TMenuItem;
    mmmiColoredMode: TMenuItem;
    acWorktime: TAction;
    WindowClose1: TWindowClose;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrange1: TWindowArrange;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    acDeptSchedule: TAction;
    N18: TMenuItem;
    mmiShowMarkTime: TMenuItem;
    acShowMarkTime: TAction;
    acColoredMode: TAction;
    imglstActions24: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    acCalculateAsCopy: TAction;
    N19: TMenuItem;
    acPrintSchedule: TAction;
    acNewCalendar: TAction;
    N20: TMenuItem;
    mmiHelp: TMenuItem;
    mmiAbout: TMenuItem;
    acAbout: TAction;
    tlbtnSeparator: TToolButton;
    tlbtnRefreshAll: TToolButton;
    pmRefresh: TPopupMenu;
    pmiRefreshScheduleList: TMenuItem;
    pmiRefreshMarkList: TMenuItem;
    actEditSchedule: TAction;
    actCopyThisIntoOne: TAction;
    actCopyFromOneIntoThis: TAction;
    actMarks: TAction;
    procedure acChangeCurYearExecute(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acShowScheduleExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acMarkInfoExecute(Sender: TObject);
    procedure acNewMarkExecute(Sender: TObject);
    procedure acScheduleInfoExecute(Sender: TObject);
    procedure acNewScheduleExecute(Sender: TObject);
    procedure acHolidaysExecute(Sender: TObject);
    procedure acScheduleListExecute(Sender: TObject);
    procedure acCalculateExecute(Sender: TObject);
    procedure mmmiColoredModeClick(Sender: TObject);
    procedure stbarStatusDblClick(Sender: TObject);
    procedure acDeptScheduleExecute(Sender: TObject);
    procedure acColoredModeExecute(Sender: TObject);
    procedure acShowMarkTimeExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acCalculateAsCopyExecute(Sender: TObject);
    procedure acPrintScheduleExecute(Sender: TObject);
    procedure acNewCalendarExecute(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure tlbtnRefreshAllClick(Sender: TObject);
    procedure pmiRefreshScheduleListClick(Sender: TObject);
    procedure pmiRefreshMarkListClick(Sender: TObject);
    procedure actEditScheduleExecute(Sender: TObject);
    procedure actCopyThisIntoOneExecute(Sender: TObject);
    procedure actCopyFromOneIntoThisExecute(Sender: TObject);
    procedure actMarksExecute(Sender: TObject);
  private
    { Private declarations }
    function GetParentForm(Sender: TObject; SenderClassType: TClass): TForm;
  public
    { Public declarations }
    procedure ApplicationOnException(Sender: TObject; E: Exception);
    procedure CalculateScheduleWorktime(_Year, _ShiftID: string; _WholeYear, _HolidayTime: Boolean);
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uChangeCurYear, uSchedule, udmMain, uMarkInfo, Contnrs, uScheduleInfo, uHoliday, uNewSchedule, uScheduleList, uCalculateSchedule, uDeptSchedule,
  uCalculateScheduleAsCopy, uPrintSchedule, AboutForm, uGetCode;

{$R *.dfm}

procedure TfrmMain.acChangeCurYearExecute(Sender: TObject);
begin
  frmChangeCurYear := TfrmChangeCurYear.Create(Application);
  try
    frmChangeCurYear.ShowModal;
//    if not(frmChangeCurYear.CancelPressed) then
//      SetCurYear(frmChangeCurYear.cboxCurYear.Text);
    raise Exception.Create('Год изменен');
  finally
    frmChangeCurYear.Free;
  end;
end;

procedure TfrmMain.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.acShowScheduleExecute(Sender: TObject);
var
  frmSchedule: TfrmSchedule;
  i: Integer;
  bNoOneSelected: Boolean;
begin
  if TComponent(Sender).Name = 'lstvSchedules' then begin
    frmSchedule := TfrmSchedule.Create(Application);
    frmSchedule.Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]);
    frmSchedule.iScheduleType := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]).ScheduleType;
    frmSchedule.ShowSchedule(frmSchedule.Schedule.ScheduleType, iCurYear);
    frmSchedule.ChangeFormName;
    frmSchedule.Show;
  end
  else if TComponent(Sender).Name = 'tlbtnShowSchedule' then begin
    bNoOneSelected := True;
    for i := 0 to frmScheduleList.lstvSchedules.Items.Count - 1 do
      if frmScheduleList.lstvSchedules.Items.Item[i].Checked then begin
        frmSchedule := TfrmSchedule.Create(Application);
        frmSchedule.Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Items[i].Caption)]);
        frmSchedule.iScheduleType := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]).ScheduleType;
        frmSchedule.ShowSchedule(frmSchedule.Schedule.ScheduleType, iCurYear);
        frmSchedule.ChangeFormName;
        frmSchedule.Show;
        bNoOneSelected := False;
      end;
    if bNoOneSelected then begin
      frmSchedule := TfrmSchedule.Create(Application);
      frmSchedule.Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]);
      frmSchedule.iScheduleType := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]).ScheduleType;
      frmSchedule.ShowSchedule(frmSchedule.Schedule.ScheduleType, iCurYear);
      frmSchedule.ChangeFormName;
      frmSchedule.Show;
    end;
  end
  else begin
    frmSchedule := TfrmSchedule.Create(Application);
    frmSchedule.ChangeFormName;
    frmSchedule.Show;
  end;
  try
    frmSchedule.Width := frmSchedule.frameSchedule1.gridsWidth + 2 * GetSystemMetrics(SM_CXVSCROLL) + 70;
    if frmSchedule.Width < 800 then
      frmSchedule.Width := 800;
        //if frmSchedule.Height > frmSchedule.frameSchedule1.gridsHeight + 200 then
    frmSchedule.Height := frmSchedule.frameSchedule1.gridsHeight + frmSchedule.tlbarToolBar.Height + frmSchedule.stbarStatus.Height + 80;
    if frmSchedule.Height > frmMain.ClientHeight - ToolBar1.Height then begin
      frmSchedule.Height := frmMain.ClientHeight - ToolBar1.Height - 40;
      frmSchedule.Top := 6;
    end;
    if frmSchedule.Height < 350 then
      frmSchedule.Height := 350;
  except

  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {
  myDBConnection := TDBConnection.Create(dmMain.sqlconDB, 'Odessa Port Plant\OASU\SHIFT4');
  myDBConnection.RestoreConnections;
  try
    myDBConnection.SQLConnection.Connected := not(myDBConnection.SQLConnection.Connected);
  finally
    case myDBConnection.SQLConnection.Connected of
      True: begin
      end;
      False: begin
      end;
    end;
  end;
  CreateMarksList(dmMain.sqlconDB);
  ShowMessage(IntToStr(oblstMarkList.Count));
  }

  acColoredMode.Checked := AppConfig.ColoredMode;
  acShowMarkTime.Checked := AppConfig.ShowMarkTime;
  stbarStatus.Panels.Items[1].Text := 'Год: ' + sCurYear;
  Application.OnException := ApplicationOnException;
end;

procedure TfrmMain.acMarkInfoExecute(Sender: TObject);
begin
  frmMarkInfo := TfrmMarkInfo.Create(Application);
  frmMarkInfo.FormMode := 0;
  try
    frmMarkInfo.Mark := TMark(oblstMarkList.Items[3]);
    frmMarkInfo.FillInMarkInfo;
    frmMarkInfo.ShowModal;
  finally
    frmMarkInfo.Free;
  end;
end;

procedure TfrmMain.acNewMarkExecute(Sender: TObject);
begin
  frmMarkInfo := TfrmMarkInfo.Create(Application);
  frmMarkInfo.FormMode := 1;
  try
    frmMarkInfo.ShowModal;
  finally
    frmMarkInfo.Free;
  end;
end;

procedure TfrmMain.acScheduleInfoExecute(Sender: TObject);
begin
  frmScheduleInfo := TfrmScheduleInfo.Create(Application);
  frmScheduleInfo.FormMode := 0;
  try
    frmScheduleInfo.Schedule := TSchedule(oblstScheduleList.Items[3]);
    frmScheduleInfo.FillInScheduleInfo;
    frmScheduleInfo.ShowModal;
  finally
    frmScheduleInfo.Free;
  end;
end;

procedure TfrmMain.acNewScheduleExecute(Sender: TObject);
begin
{
  frmMarkList := TfrmMarkList.Create(Application);
  try
    frmMarkList.DrawMarkList;
    frmMarkList.ShowModal;
  finally
    frmMarkList.Free;
  end;


  exit;
}
  frmNewSchedule := TfrmNewSchedule.Create(Application);
  try
    //frmNewSchedule.ShowModal;
    frmNewSchedule.Show;
  finally
    //frmNewSchedule.Free;
  end;
end;

procedure TfrmMain.acHolidaysExecute(Sender: TObject);
begin
  frmHolidays := TfrmHolidays.Create(Application);
  try
    frmHolidays.cboxYear.ItemIndex := frmHolidays.cboxYear.Items.IndexOf(sCurYear);
    frmHolidays.cboxYearChange(Sender);
    //frmHolidays.CreateHolidayArray;
    //frmHolidays.DrawCalendar;
    frmHolidays.ShowModal;
  finally
    frmHolidays.Free;
  end;
end;

procedure TfrmMain.acScheduleListExecute(Sender: TObject);
begin
  try
    frmScheduleList.BringToFront;
    if frmScheduleList.WindowState = wsMinimized then
      frmScheduleList.WindowState := wsNormal;
  except
    frmScheduleList := TfrmScheduleList.Create(Application);
    frmScheduleList.Show;
  end;
end;

procedure TfrmMain.acCalculateExecute(Sender: TObject);
var
  i: Integer;
begin
  //Действительно хотите расчитать?
  if TComponent(Sender).Name = 'tlbtnCalculate' then begin
    if frmScheduleList.lstvSchedules.SelCount = 0 then begin
      ShowMessage('Ни один график не выбран! Необходимо выделить хотя бы один график для расчета');
      exit;
    end;
    frmCalculateSchedule := TfrmCalculateSchedule.Create(Application, TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]));
    frmCalculateSchedule.cboxShift.ItemIndex := frmCalculateSchedule.cboxShift.Items.Count - 1;
    frmCalculateSchedule.chkboxUsePrevDays.Checked := True;
    frmCalculateSchedule.ShowModal;
  end
  else begin
    if TComponent(Sender).Name = 'tlbtnCalculateChecked' then begin
      for i := 0 to frmScheduleList.lstvSchedules.Items.Count - 1 do
        if frmScheduleList.lstvSchedules.Items.Item[i].Checked then begin
          frmCalculateSchedule := TfrmCalculateSchedule.Create(Application, TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Items
            [i].Caption)]));
          frmCalculateSchedule.cboxShift.ItemIndex := frmCalculateSchedule.cboxShift.Items.Count - 1;
          frmCalculateSchedule.chkboxUsePrevDays.Checked := True;
          frmCalculateSchedule.ShowModal;
        end;
    end
    else begin
      if TComponent(Sender).Name = 'tlbtnScheduleCalculate' then begin
          //frmCalculateSchedule := TfrmCalculateSchedule.Create(Application, frmSchedule.Schedule);
        frmCalculateSchedule := TfrmCalculateSchedule.Create(Application, TfrmSchedule(GetParentForm(Sender, TfrmSchedule)).Schedule);
        frmCalculateSchedule.cboxShift.ItemIndex := frmCalculateSchedule.cboxShift.Items.Count - 1;
        frmCalculateSchedule.chkboxUsePrevDays.Checked := True;
        frmCalculateSchedule.ShowModal;
      end;
    end;
  end;
end;

procedure TfrmMain.ApplicationOnException(Sender: TObject; E: Exception);
begin
  if e.Message = 'Год изменен' then begin
    stbarStatus.Panels.Items[1].Text := 'Год: ' + sCurYear;
    exit;
  end;
  //При закрытии формы frmPrintSchedule для e.g. "Графика №3" вылетает эта ошибка
  // почему и чем вызвана, пока не разобрался (18.12.2015)
  if (Sender.ClassName = 'TfrmPrintSchedule') and (E.Message = 'Invalid variant type') then begin
    //ShowMessage(e.message);
    Exit;
  end;
  //Application.ShowException(E);
  Application.MessageBox(PChar(E.Message + ' [' + Sender.ClassName + ']'), 'Ошибка в программе', MB_ICONERROR);
end;

procedure TfrmMain.mmmiColoredModeClick(Sender: TObject);
begin
  //mmiColoredMode.Checked := not(mmiColoredMode.Checked);
end;

procedure TfrmMain.stbarStatusDblClick(Sender: TObject);
var
  pCursorPos: TPoint;
begin
  if GetCursorPos(pCursorPos) then
    if (pCursorPos.X > (stbarStatus.Left + stbarStatus.Panels[0].Width + frmMain.Left)) and (pCursorPos.X < (stbarStatus.Left + stbarStatus.Panels[0].Width +
      stbarStatus.Panels[1].Width + frmMain.Left)) then
      acChangeCurYearExecute(Sender);
end;

procedure TfrmMain.CalculateScheduleWorktime(_Year, _ShiftID: string; _WholeYear, _HolidayTime: Boolean);
begin
  dmMain.sqlqryTemp.Active := False;
  dmMain.sqlqryTemp.SQL.Clear;
  dmMain.sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.SCHEDULE_CALCULATE_WORKTIME(''' + _Year + ''', ''' + _ShiftID + ''', ' + BoolToStr(_WholeYear, True) + ', '
    + BoolToStr(_HolidayTime, True) + '); end;');
  dmMain.sqlqryTemp.ExecSQL(True);
end;

function TfrmMain.GetParentForm(Sender: TObject; SenderClassType: TClass): TForm;
begin
  result := nil;
  if TComponent(Sender).Owner.ClassType = SenderClassType then
    result := TForm(TComponent(Sender).Owner)
  else
    GetParentForm(TComponent(Sender).Owner, SenderClassType);
end;

procedure TfrmMain.acDeptScheduleExecute(Sender: TObject);
begin
  frmDeptSchedule := TfrmDeptSchedule.Create(Application);
  try
    frmDeptSchedule.Show;
  finally
    //frmDeptSchedule.Free;
  end;
end;

procedure TfrmMain.acColoredModeExecute(Sender: TObject);
begin
  acColoredMode.Checked := not (acColoredMode.Checked);
  AppConfig.ColoredMode := acColoredMode.Checked;
end;

procedure TfrmMain.acShowMarkTimeExecute(Sender: TObject);
begin
  acShowMarkTime.Checked := not (acShowMarkTime.Checked);
  AppConfig.ShowMarkTime := acShowMarkTime.Checked;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not (SaveConfiguration) then
    ShowMessage('Ошибка при сохранении настроек [TfrmMain.FormCloseQuery]');
end;

procedure TfrmMain.acCalculateAsCopyExecute(Sender: TObject);
begin
  frmCalculateScheduleAsCopy := TfrmCalculateScheduleAsCopy.Create(Application);
  //frmCalculateScheduleAsCopy.FillInMarksTable;
  try
    frmCalculateScheduleAsCopy.ShowModal;
  finally
    frmCalculateScheduleAsCopy.Free;
  end;
end;

procedure TfrmMain.acPrintScheduleExecute(Sender: TObject);
var
  schSchedule: TSchedule;
begin
{
  if TComponent(Sender).Name='lstvSchedules' then begin
    frmSchedule := TfrmSchedule.Create(Application);
    frmSchedule.Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]);
    frmSchedule.ShowSchedule(frmSchedule.Schedule.ScheduleType, iCurYear);
    frmSchedule.ChangeFormName;
    frmSchedule.Show;
  end
  else if TComponent(Sender).Name='tlbtnShowSchedule' then begin
      for i:=0 to frmScheduleList.lstvSchedules.Items.Count-1 do
        if frmScheduleList.lstvSchedules.Items.Item[i].Checked then begin
          frmSchedule := TfrmSchedule.Create(Application);
          frmSchedule.Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Items[i].Caption)]);
          frmSchedule.ShowSchedule(frmSchedule.Schedule.ScheduleType, iCurYear);
          frmSchedule.ChangeFormName;
          frmSchedule.Show;
        end;
    end
    else begin
      frmSchedule := TfrmSchedule.Create(Application);
      frmSchedule.ChangeFormName;
      frmSchedule.Show;
    end;
}

  schSchedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]);

  frmPrintSchedule := TfrmPrintSchedule.Create(Application);

  frmPrintSchedule.sScheduleYear := IntToStr(TfrmSchedule(GetParentForm(Sender, TfrmSchedule)).iFormYear);
  frmPrintSchedule.sScheduleType := IntToStr(schSchedule.ScheduleType);
  frmPrintSchedule.iNumOfShifts := schSchedule.NumOfShifts;
  frmPrintSchedule.ShowModal;
  frmPrintSchedule.Free;
end;

procedure TfrmMain.acNewCalendarExecute(Sender: TObject);
var
  strlstYears: TStrings;
  strCalendarYear: string;
begin
  strlstYears := TStringList.Create;
  strlstYears.Assign(GetYears);
  strCalendarYear := IntToStr(StrToInt(strlstYears.Strings[strlstYears.Count - 1]) + 1);
  if Application.MessageBox(PChar('Вы действительно хотите расчитать календарь на ' + strCalendarYear + ' год?'), 'Новый календарь на год', MB_YESNO) = ID_YES then begin
    dmMain.sqlqryTemp.SQL.Clear;
    dmMain.sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.CALENDAR_NEW(''' + '01.01.' + strCalendarYear + ''', TRUE); end;');
    try
      dmMain.sqlqryTemp.ExecSQL(True);
      ShowMessage('Календарь на ' + strCalendarYear + ' год успешно расчитан');
    except
      on e: Exception do
        ShowMessage('Ошибка при расчете календаря на ' + strCalendarYear + ' год: ' + e.Message);
    end;
  end;
  strlstYears.Free;
end;

procedure TfrmMain.acAboutExecute(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(nil);
  try
    frmAbout.ShowModal;
  finally
    FreeAndNil(frmAbout);
  end;
end;

procedure TfrmMain.tlbtnRefreshAllClick(Sender: TObject);
begin
  pmiRefreshMarkListClick(Sender);
  pmiRefreshScheduleListClick(Sender);
end;

procedure TfrmMain.pmiRefreshScheduleListClick(Sender: TObject);
var
  i: Integer;
  bScheduleList: Boolean;
begin
  bScheduleList := False;
  for i := 0 to frmMain.MDIChildCount - 1 do
    if Pos('frmScheduleList', frmMain.MDIChildren[i].Name) <> 0 then
    try
      TfrmScheduleList(frmMain.MDIChildren[i]).pmiRefreshListClick(Sender);
      bScheduleList := True;
      Break;
    except
    end;

  if not (bScheduleList) then begin
    RefreshScheduleList(dmMain.sqlqryTemp, dmMain.sqlqryTemp2);

    for i := 0 to frmMain.MDIChildCount - 1 do
      if (Pos('frmSchedule_', frmMain.MDIChildren[i].Name) <> 0) or (frmMain.MDIChildren[i].Name = 'frmSchedule') then
      try
        TfrmSchedule(frmMain.MDIChildren[i]).RefreshSchedule;
      except
      end
  end;
end;

procedure TfrmMain.pmiRefreshMarkListClick(Sender: TObject);
var
  i, idxScheduleList: Integer;
begin
  idxScheduleList := -1;
  for i := 0 to frmMain.MDIChildCount - 1 do
    if Pos('frmScheduleList', frmMain.MDIChildren[i].Name) <> 0 then begin
      idxScheduleList := i;
      Break;
    end;

  RefreshMarkList(dmMain.sqlqryTemp);
  if idxScheduleList <> -1 then
    TfrmScheduleList(frmMain.MDIChildren[idxScheduleList]).pmiRefreshListClick(Sender)
  else
    for i := 0 to frmMain.MDIChildCount - 1 do
      if (Pos('frmSchedule_', frmMain.MDIChildren[i].Name) <> 0) or (frmMain.MDIChildren[i].Name = 'frmSchedule') then
      try
        TfrmSchedule(frmMain.MDIChildren[i]).RefreshSchedule;
      except
      end
end;

procedure TfrmMain.actEditScheduleExecute(Sender: TObject);
begin
  frmNewSchedule := TfrmNewSchedule.Create(Application);
  try
    frmNewSchedule.Tag := -1;
    frmNewSchedule.Schedule := TSchedule.Create(TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]));
    frmNewSchedule.SourceSchedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(frmScheduleList.lstvSchedules.Selected.Caption)]);
    frmNewSchedule.FillInScheduleInfo;
    frmNewSchedule.edScheduleType.Enabled := False;

    frmNewSchedule.FormStyle := fsNormal;
    frmNewSchedule.Visible := False;
    frmNewSchedule.ShowModal;
  finally
    try
      //Пробуем обновить список графиков, если не была нажата кнопка "Отмена"
      if not (frmNewSchedule.CancelPressed) then
        frmScheduleList.pmiRefreshListClick(Sender);
    except
    end;
    frmNewSchedule.Schedule.Free;
    frmNewSchedule.Free;
  end;
end;

procedure TfrmMain.actCopyThisIntoOneExecute(Sender: TObject);
begin
  frmCalculateScheduleAsCopy := TfrmCalculateScheduleAsCopy.Create(Application);
  frmCalculateScheduleAsCopy.cboxSchedulesSrc.ItemIndex := frmCalculateScheduleAsCopy.cboxSchedulesSrc.Items.IndexOf(TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU
    (frmScheduleList.lstvSchedules.Selected.Caption)]).NameU);
  frmCalculateScheduleAsCopy.cboxSchedulesSrcChange(Sender);
  try
    frmCalculateScheduleAsCopy.ShowModal;
  finally
    frmCalculateScheduleAsCopy.Free;
  end;
end;

procedure TfrmMain.actCopyFromOneIntoThisExecute(Sender: TObject);
begin
  frmCalculateScheduleAsCopy := TfrmCalculateScheduleAsCopy.Create(Application);
  frmCalculateScheduleAsCopy.cboxSchedulesDst.ItemIndex := frmCalculateScheduleAsCopy.cboxSchedulesSrc.Items.IndexOf(TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU
    (frmScheduleList.lstvSchedules.Selected.Caption)]).NameU);
  frmCalculateScheduleAsCopy.cboxSchedulesDstChange(Sender);
  try
    frmCalculateScheduleAsCopy.ShowModal;
  finally
    frmCalculateScheduleAsCopy.Free;
  end;
end;

procedure TfrmMain.actMarksExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  frmGetCode := TfrmGetCode.Create(nil);
  frmGetCode.Caption := 'Просмотр отметок';
  frmGetCode.pnlTop.Caption := '';
  frmGetCode.Tag := 2; // Работаем с отметками
  try
    dmMain.sqlqryTemp.Active := False;
    dmMain.sqlqryTemp.SQL.Clear;
    dmMain.sqlqryTemp.SQL.Add('select ID_OTMETKA from QWERTY.SP_ZAR_OT_PROP UNION ALL select ID_OTMETKA from QWERTY.SP_ZAR_OTNE_PROP order by ID_OTMETKA');
    dmMain.sqlqryTemp.Active := True;
    while not (dmMain.sqlqryTemp.Eof) do begin
      frmGetCode.slValues.Add(dmMain.sqlqryTemp.Fields[0].AsString);
      dmMain.sqlqryTemp.Next;
    end;
    dmMain.sqlqryTemp.Active := False;
    frmGetCode.FillGrid;
    frmGetCode.strgrdCodes.Options := frmGetCode.strgrdCodes.Options - [goRangeSelect];
    frmGetCode.btnSave.Enabled := False;
    frmGetCode.chkShowInfo.Checked := True;
    frmGetCode.chkShowInfoClick(Sender);
    frmGetCode.ShowModal;
  finally
    frmGetCode.Free;
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;
end;

end.


