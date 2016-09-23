unit uScheduleList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ImgList, ComCtrls, ToolWin, Menus, DateUtils, Math;

type
  TfrmScheduleList = class(TForm)
    lstvSchedules: TListView;
    imglstLarge: TImageList;
    imglstSmall: TImageList;
    tlbarToolBar: TToolBar;
    pmPopup: TPopupMenu;
    N1: TMenuItem;
    miList: TMenuItem;
    miReport: TMenuItem;
    miIcon: TMenuItem;
    miSmallIcon: TMenuItem;
    pmiRefreshList: TMenuItem;
    tlbtnShowSchedule: TToolButton;
    tlbtnCalculate: TToolButton;
    ToolButton3: TToolButton;
    tlbtnCalculateChecked: TToolButton;
    N4: TMenuItem;
    pmiShowScheduleYear: TMenuItem;
    mniSort: TMenuItem;
    pmiSortByName: TMenuItem;
    pmiSortByDescription: TMenuItem;
    pmiSortByCycle: TMenuItem;
    pmiSortByNumOfEmps: TMenuItem;
    pmiSortByLastMonth: TMenuItem;
    pmiReverseSort: TMenuItem;
    N6: TMenuItem;
    pmiNoSort: TMenuItem;
    stbarHollidayType: TStatusBar;
    mniSort2: TMenuItem;
    mniReverseSort2: TMenuItem;
    mniSort2Separator: TMenuItem;
    mniSort2ByName: TMenuItem;
    mniSort2ByDescription: TMenuItem;
    mniSort2ByCycle: TMenuItem;
    mniSort2ByNumOfEmps: TMenuItem;
    mniSort2ByLastMonth: TMenuItem;
    mniN2: TMenuItem;
    mniEditSchedule: TMenuItem;
    mniN3: TMenuItem;
    mniCopyThisIntoOne: TMenuItem;
    mniCopyFromOneIntoThis: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure lstvSchedulesDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miIconClick(Sender: TObject);
    procedure miListClick(Sender: TObject);
    procedure miReportClick(Sender: TObject);
    procedure miSmallIconClick(Sender: TObject);
    procedure pmiRefreshListClick(Sender: TObject);
    procedure tlbtnShowScheduleClick(Sender: TObject);
    procedure lstvSchedulesResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pmPopupPopup(Sender: TObject);
    procedure tlbtnCalculateClick(Sender: TObject);
    procedure tlbtnCalculateCheckedClick(Sender: TObject);
    procedure lstvSchedulesCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure pmiSortByNameClick(Sender: TObject);
    procedure pmiSortByDescriptionClick(Sender: TObject);
    procedure pmiSortByCycleClick(Sender: TObject);
    procedure pmiSortByNumOfEmpsClick(Sender: TObject);
    procedure pmiSortByLastMonthClick(Sender: TObject);
    procedure pmiReverseSortClick(Sender: TObject);
    procedure pmiNoSortClick(Sender: TObject);
    procedure lstvSchedulesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure stbarHollidayTypeResize(Sender: TObject);
    procedure lstvSchedulesColumnClick(Sender: TObject; Column: TListColumn);
    procedure mniReverseSort2Click(Sender: TObject);
    procedure mniSort2ByLastMonthClick(Sender: TObject);
    procedure lstvSchedulesCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure mniSort2ByNameClick(Sender: TObject);
    procedure mniSort2ByDescriptionClick(Sender: TObject);
    procedure mniSort2ByCycleClick(Sender: TObject);
    procedure mniSort2ByNumOfEmpsClick(Sender: TObject);
  private
    { Private declarations }
    function myCompare(Item1, Item2: TListItem): Integer;
    function mySubCompare(Item1, Item2: TListItem): Integer;
    procedure CheckMenuItems(Icon, List, Report, SmallIcon: Boolean);
    procedure YearMenuItemClick(Sender: TObject);
    procedure FillInSchedulesListView;
    procedure SetAppConfigSortType(ColumnIndex: Integer);
    procedure RestoreSort;
  public
    { Public declarations }
  end;

var
  frmScheduleList: TfrmScheduleList;

implementation

uses
  udmMain, uMain, uSchedule, uNewSchedule;

{$R *.dfm}

procedure TfrmScheduleList.FormCreate(Sender: TObject);
var
  i: Integer;
  menuItem: TMenuItem;
  strlstYears: TStrings;
begin
  case AppConfig.ScheduleListStyle of
    0:
      begin
        lstvSchedules.ViewStyle := vsIcon;
        CheckMenuItems(True, False, False, False);
      end;
    1:
      begin
        lstvSchedules.ViewStyle := vsList;
        CheckMenuItems(False, True, False, False);
      end;
    2:
      begin
        lstvSchedules.ViewStyle := vsReport;
        CheckMenuItems(False, False, True, False);
      end;
    3:
      begin
        lstvSchedules.ViewStyle := vsSmallIcon;
        CheckMenuItems(False, False, False, True);
      end;
  end;

  FillInSchedulesListView;

  with AppConfig do begin
    pmiReverseSort.Checked := ScheduleListReverseSort;
    pmiSortByName.Checked := ScheduleListSortByName;
    pmiSortByDescription.Checked := ScheduleListSortByDescription;
    pmiSortByCycle.Checked := ScheduleListSortByCycle;
    pmiSortByNumOfEmps.Checked := ScheduleListSortByNumOfEmps;
    pmiSortByLastMonth.Checked := ScheduleListSortByLastMonth;

    mniReverseSort2.Checked := ScheduleListReverseSort2;
    mniSort2ByName.Checked := ScheduleListSort2ByName;
    mniSort2ByDescription.Checked := ScheduleListSort2ByDescription;
    mniSort2ByCycle.Checked := ScheduleListSort2ByCycle;
    mniSort2ByNumOfEmps.Checked := ScheduleListSort2ByNumOfEmps;
    mniSort2ByLastMonth.Checked := ScheduleListSort2ByLastMonth;

    {
    if AppConfig.ScheduleListSortByName then
      pmiSortByNameClick(Sender)
    else
      if AppConfig.ScheduleListSortByDescription then
        pmiSortByDescriptionClick(Sender)
      else
      if AppConfig.ScheduleListSortByCycle then
        pmiSortByCycleClick(Sender)
      else
        if AppConfig.ScheduleListSortByNumOfEmps then
          pmiSortByNumOfEmpsClick(Sender)
        else
          if AppConfig.ScheduleListSortByLastMonth then
            pmiSortByLastMonthClick(Sender);


    if AppConfig.ScheduleListSort2ByName then
      mniSort2ByNameClick(Sender)
    else
      if AppConfig.ScheduleListSort2ByDescription then
        mniSort2ByDescriptionClick(Sender)
      else
      if AppConfig.ScheduleListSort2ByCycle then
        mniSort2ByCycleClick(Sender)
      else
        if AppConfig.ScheduleListSort2ByNumOfEmps then
          mniSort2ByNumOfEmpsClick(Sender)
        else
          if AppConfig.ScheduleListSort2ByLastMonth then
            mniSort2ByLastMonthClick(Sender);
    }
  end;

  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;

  strlstYears := TStringList.Create;
  strlstYears := GetYears;
  for i := 0 to strlstYears.Count - 1 do begin
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := strlstYears.Strings[i];
    menuItem.OnClick := YearMenuItemClick;
    pmiShowScheduleYear.Add(menuItem);
  end;
  strlstYears.Free;

  try
    lstvSchedules.TopItem.Selected := True;
  except

  end;
end;

procedure TfrmScheduleList.lstvSchedulesDblClick(Sender: TObject);
begin
  frmMain.acShowScheduleExecute(Sender);
end;

procedure TfrmScheduleList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmScheduleList.miIconClick(Sender: TObject);
begin
  lstvSchedules.ViewStyle := vsIcon;
  CheckMenuItems(True, False, False, False);
  AppConfig.ScheduleListStyle := 0;
end;

procedure TfrmScheduleList.miListClick(Sender: TObject);
begin
  lstvSchedules.ViewStyle := vsList;
  CheckMenuItems(False, True, False, False);
  AppConfig.ScheduleListStyle := 1;
end;

procedure TfrmScheduleList.miReportClick(Sender: TObject);
begin
  lstvSchedules.ViewStyle := vsReport;
  CheckMenuItems(False, False, True, False);
  AppConfig.ScheduleListStyle := 2;
end;

procedure TfrmScheduleList.miSmallIconClick(Sender: TObject);
begin
  lstvSchedules.ViewStyle := vsSmallIcon;
  CheckMenuItems(False, False, False, True);
  AppConfig.ScheduleListStyle := 3;
end;

procedure TfrmScheduleList.CheckMenuItems(Icon, List, Report, SmallIcon: Boolean);
begin
  miIcon.Checked := Icon;
  miList.Checked := List;
  miReport.Checked := Report;
  miSmallIcon.Checked := SmallIcon;
end;

procedure TfrmScheduleList.pmiRefreshListClick(Sender: TObject);
var
  i: Integer;
  sSelectedSchedule: string;
begin
  lstvSchedules.Items.BeginUpdate;
  try
    sSelectedSchedule := lstvSchedules.Selected.Caption;

    for i := lstvSchedules.Items.Count - 1 downto 0 do
      lstvSchedules.Items[i].Free;

    RefreshScheduleList(dmMain.sqlqryTemp, dmMain.sqlqryTemp2);

    FillInSchedulesListView;
    RestoreSort;
    for i := 0 to lstvSchedules.Items.Count - 1 do
      if lstvSchedules.Items[i].Caption = sSelectedSchedule then begin
        lstvSchedules.Items[i].Selected := True;
        Break;
      end;
    lstvSchedules.ItemFocused := lstvSchedules.Selected;

    for i := 0 to frmMain.MDIChildCount - 1 do
      if (Pos('frmSchedule_', frmMain.MDIChildren[i].Name) <> 0) or (frmMain.MDIChildren[i].Name = 'frmSchedule') then
      try
        TfrmSchedule(frmMain.MDIChildren[i]).RefreshSchedule;
      except
      end;
  finally
    lstvSchedules.Items.EndUpdate;
  end;
end;

procedure TfrmScheduleList.tlbtnShowScheduleClick(Sender: TObject);
begin
  frmMain.acShowScheduleExecute(Sender);
end;

procedure TfrmScheduleList.lstvSchedulesResize(Sender: TObject);
begin
  lstvSchedules.Arrange(arDefault);
end;

procedure TfrmScheduleList.YearMenuItemClick(Sender: TObject);
var
  _Year: Integer;
begin
  frmSchedule := TfrmSchedule.Create(Application);
  frmSchedule.Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(lstvSchedules.Selected.Caption)]);
  try
    _Year := StrToInt(Concat(Copy(TMenuItem(Sender).Caption, 1, Pos('&', TMenuItem(Sender).Caption) - 1), Copy(TMenuItem(Sender).Caption, Pos('&', TMenuItem(Sender).Caption)
      + 1, 4)));
    frmSchedule.iFormYear := _Year;
    frmSchedule.iScheduleType := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(lstvSchedules.Selected.Caption)]).ScheduleType;
    frmSchedule.ShowSchedule(frmSchedule.Schedule.ScheduleType, _Year, False);
    frmSchedule.ChangeFormName;
  except
  end;
  frmSchedule.Show;
end;

procedure TfrmScheduleList.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  for i := pmiShowScheduleYear.Count - 1 downto 0 do
    pmiShowScheduleYear.Items[i].Free;
  {
  for i := lstvSchedules.Items.Count - 1 downto 0 do
    TListItem(lstvSchedules.Items.Item[i]).Free;
  lstvSchedules.Items.Free;
  }
end;

procedure TfrmScheduleList.pmPopupPopup(Sender: TObject);
begin
  pmiShowScheduleYear.Enabled := not (lstvSchedules.SelCount = 0);
  mniSort.Enabled := not (pmiNoSort.Checked);
  mniSort2.Enabled := mniSort.Enabled;

  mniSort2ByName.Enabled := not (pmiSortByName.Checked);
  mniSort2ByDescription.Enabled := not (pmiSortByDescription.Checked);
  mniSort2ByCycle.Enabled := not (pmiSortByCycle.Checked);
  mniSort2ByNumOfEmps.Enabled := not (pmiSortByNumOfEmps.Checked);
  mniSort2ByLastMonth.Enabled := not (pmiSortByLastMonth.Checked);
end;

procedure TfrmScheduleList.tlbtnCalculateClick(Sender: TObject);
begin
  frmMain.acCalculateExecute(Sender);
end;

procedure TfrmScheduleList.tlbtnCalculateCheckedClick(Sender: TObject);
begin
  frmMain.acCalculateExecute(Sender);
end;

procedure TfrmScheduleList.FillInSchedulesListView;
var
  i: Integer;
  liListItem: TListItem;
begin
  for i := 0 to oblstScheduleList.Count - 1 do begin
    liListItem := lstvSchedules.Items.Add;
    liListItem.Caption := TSchedule(oblstScheduleList.Items[i]).NameU;
    liListItem.ImageIndex := TSchedule(oblstScheduleList.Items[i]).HollidayType;
    liListItem.SubItems.Add(TSchedule(oblstScheduleList.Items[i]).NameR);
    liListItem.SubItems.Add(TSchedule(oblstScheduleList.Items[i]).Cycle);

    liListItem.SubItems.Add(IntToStr(TSchedule(oblstScheduleList.Items[i]).EmployeeCount));
    liListItem.SubItems.Add(AnsiLowerCase(FormatDateTime('yyyy, mmmm', TSchedule(oblstScheduleList.Items[i]).LastMonth)));

    liListItem.SubItems.Add(IntToStr(TSchedule(oblstScheduleList.Items[i]).NumOfShifts));
    liListItem.SubItems.Add(IntToStr(TSchedule(oblstScheduleList.Items[i]).ScheduleType));
  end;
  try
    //lstvSchedules.Items.Item[0].Selected := True;
    //lstvSchedules.Selected := lstvSchedules.Items.Item[0];
    lstvSchedules.TopItem.Selected := True;
  except
  end;
end;

procedure TfrmScheduleList.lstvSchedulesCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  Compare := myCompare(Item1, Item2);
end;

procedure TfrmScheduleList.pmiSortByNameClick(Sender: TObject);
begin
  if pmiSortByName.Checked then
    pmiReverseSort.Checked := pmiSortByName.Checked and not (pmiReverseSort.Checked);

  pmiSortByName.Checked := True;
  SetAppConfigSortType(0);
  lstvSchedules.SortType := stNone;
  //lstvSchedules.SortType := stData;
  lstvSchedules.SortType := stText;
end;

procedure TfrmScheduleList.pmiSortByDescriptionClick(Sender: TObject);
begin
  if pmiSortByDescription.Checked then
    pmiReverseSort.Checked := pmiSortByDescription.Checked and not (pmiReverseSort.Checked);
  pmiSortByDescription.Checked := True;
  SetAppConfigSortType(1);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.pmiSortByCycleClick(Sender: TObject);
begin
  if pmiSortByCycle.Checked then
    pmiReverseSort.Checked := pmiSortByCycle.Checked and not (pmiReverseSort.Checked);
  pmiSortByCycle.Checked := True;
  SetAppConfigSortType(2);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.pmiSortByNumOfEmpsClick(Sender: TObject);
begin
  if pmiSortByNumOfEmps.Checked then
    pmiReverseSort.Checked := pmiSortByNumOfEmps.Checked and not (pmiReverseSort.Checked);
  pmiSortByNumOfEmps.Checked := True;
  SetAppConfigSortType(3);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.pmiSortByLastMonthClick(Sender: TObject);
begin
  if pmiSortByLastMonth.Checked then
    pmiReverseSort.Checked := pmiSortByLastMonth.Checked and not (pmiReverseSort.Checked);
  pmiSortByLastMonth.Checked := True;
  SetAppConfigSortType(4);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.pmiReverseSortClick(Sender: TObject);
begin
  pmiReverseSort.Checked := not (pmiReverseSort.Checked);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.pmiNoSortClick(Sender: TObject);
begin
  pmiNoSort.Checked := not (pmiNoSort.Checked);
  if pmiNoSort.Checked then begin
    lstvSchedules.SortType := stNone;
    lstvSchedules.Clear;
    FillInSchedulesListView;
  end
  else
    lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.lstvSchedulesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  if Change = ctState then
    case Item.ImageIndex of
      0:
        stbarHollidayType.Panels[0].Text := 'Календарный праздник является выходным днём (дневной персонал)';
      1:
        stbarHollidayType.Panels[0].Text := 'Праздники не влияют на цикл работы';
      2:
        stbarHollidayType.Panels[0].Text := 'Календарный праздник - выходной день и разбивает цикл (отметка следующего дня после праздника = отметке в праздничный день)';
      3:
        stbarHollidayType.Panels[0].Text := 'Календарный праздник и выходной день дневной смены являются выходными и разбивают цикл';
      4:
        stbarHollidayType.Panels[0].Text := 'Календарный праздник является выходным днём, но не разбивает цикл';
    else
      stbarHollidayType.Panels[0].Text := '---неверный тип---';
    end;
end;

procedure TfrmScheduleList.stbarHollidayTypeResize(Sender: TObject);
begin
  stbarHollidayType.Panels[0].Width := stbarHollidayType.Width;
end;

procedure TfrmScheduleList.lstvSchedulesColumnClick(Sender: TObject; Column: TListColumn);
begin
  case Column.Index of
    0:
      begin
        if (pmiReverseSort.Checked and not (pmiSortByName.Checked)) then
          pmiReverseSort.Checked := False;
        pmiSortByNameClick(Sender);
      end;
    1:
      begin
        if (pmiReverseSort.Checked and not (pmiSortByDescription.Checked)) then
          pmiReverseSort.Checked := False;
        pmiSortByDescriptionClick(Sender);
      end;
    2:
      begin
        if (pmiReverseSort.Checked and not (pmiSortByCycle.Checked)) then
          pmiReverseSort.Checked := False;
        pmiSortByCycleClick(Sender);
      end;
    3:
      begin
        if (pmiReverseSort.Checked and not (pmiSortByNumOfEmps.Checked)) then
          pmiReverseSort.Checked := False;
        pmiSortByNumOfEmpsClick(Sender);
      end;
    4:
      begin
        if (pmiReverseSort.Checked and not (pmiSortByLastMonth.Checked)) then
          pmiReverseSort.Checked := False;
        pmiSortByLastMonthClick(Sender);
      end;
  end;
end;

procedure TfrmScheduleList.SetAppConfigSortType(ColumnIndex: Integer);
begin
  with AppConfig do begin
    ScheduleListSortByName := pmiSortByName.Checked;
    ScheduleListSortByDescription := pmiSortByDescription.Checked;
    ScheduleListSortByCycle := pmiSortByCycle.Checked;
    ScheduleListSortByNumOfEmps := pmiSortByNumOfEmps.Checked;
    ScheduleListSortByLastMonth := pmiSortByLastMonth.Checked;
    ScheduleListReverseSort := pmiReverseSort.Checked;
    ScheduleListSort2ByName := mniSort2ByName.Checked;
    ScheduleListSort2ByDescription := mniSort2ByDescription.Checked;
    ScheduleListSort2ByCycle := mniSort2ByCycle.Checked;
    ScheduleListSort2ByNumOfEmps := mniSort2ByNumOfEmps.Checked;
    ScheduleListSort2ByLastMonth := mniSort2ByLastMonth.Checked;
    ScheduleListReverseSort2 := mniReverseSort2.Checked;
  end;

  // 5/12/2012 Вроде дальнейшее уже не надо, т.к. вверху прочитаны актуальные значения
  //   раньше вверху везде кроме ReverseSort-ов стояло False
  Exit;
  case ColumnIndex of
    0:
      AppConfig.ScheduleListSortByName := True;
    1:
      AppConfig.ScheduleListSortByDescription := True;
    2:
      AppConfig.ScheduleListSortByCycle := True;
    3:
      AppConfig.ScheduleListSortByNumOfEmps := True;
    4:
      AppConfig.ScheduleListSortByLastMonth := True;
    10:
      AppConfig.ScheduleListSort2ByName := True;
    11:
      AppConfig.ScheduleListSort2ByDescription := True;
    12:
      AppConfig.ScheduleListSort2ByCycle := True;
    13:
      AppConfig.ScheduleListSort2ByNumOfEmps := True;
    14:
      AppConfig.ScheduleListSort2ByLastMonth := True;
  end;
end;

function TfrmScheduleList.myCompare(Item1, Item2: TListItem): Integer;
var
  s1, s2: string;
begin
  if AppConfig.ScheduleListSortByNumOfEmps then begin
    Result := Sign(StrToInt(Item1.SubItems.Strings[2]) - StrToInt(Item2.SubItems.Strings[2]));
  end
  else begin
    if AppConfig.ScheduleListSortByName then begin
      s1 := Item1.Caption;
      s2 := Item2.Caption;
    end
    else if AppConfig.ScheduleListSortByDescription then begin
      s1 := Item1.SubItems.Strings[0];
      s2 := Item2.SubItems.Strings[0];
    end
    else if AppConfig.ScheduleListSortByCycle then begin
      s1 := Item1.SubItems.Strings[1];
      s2 := Item2.SubItems.Strings[1];
    end
    else if AppConfig.ScheduleListSortByLastMonth then begin
      s1 := Item1.SubItems.Strings[3];
      s2 := Item2.SubItems.Strings[3];
    end
    else begin
      s1 := Item1.Caption;
      s2 := Item2.Caption;
    end;

    Result := AnsiCompareStr(s1, s2);
  end;
  if Result = 0 then
    Result := mySubCompare(Item2, Item1);
  if AppConfig.ScheduleListReverseSort then
    Result := -1 * Result;
end;

function TfrmScheduleList.mySubCompare(Item1, Item2: TListItem): Integer;
var
  s1, s2: string;
begin
  Result := 0;

  if AppConfig.ScheduleListSort2ByNumOfEmps then begin
    Result := Sign(StrToInt(Item1.SubItems.Strings[2]) - StrToInt(Item2.SubItems.Strings[2]));
  end
  else begin
    if AppConfig.ScheduleListSort2ByName then begin
      s1 := Item1.Caption;
      s2 := Item2.Caption;
    end
    else if AppConfig.ScheduleListSort2ByDescription then begin
      s1 := Item1.SubItems.Strings[0];
      s2 := Item2.SubItems.Strings[0];
    end
    else if AppConfig.ScheduleListSort2ByCycle then begin
      s1 := Item1.SubItems.Strings[1];
      s2 := Item2.SubItems.Strings[1];
    end
    else if AppConfig.ScheduleListSort2ByLastMonth then begin
      s1 := Item1.SubItems.Strings[3];
      s2 := Item2.SubItems.Strings[3];
    end
    else begin
      s1 := Item1.Caption;
      s2 := Item2.Caption;
    end;

    Result := AnsiCompareStr(s1, s2);
  end;
  if AppConfig.ScheduleListReverseSort2 then
    Result := -1 * Result;
end;

procedure TfrmScheduleList.lstvSchedulesCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  sYear, sItemYear: string;
  i: Word;
begin
  sYear := IntToStr(YearOf(Now));
  sItemYear := Copy(Item.SubItems.Strings[3], 1, 4);
  if sItemYear >= sYear then begin
    Sender.Canvas.Font.Style := [];
    //Sender.Canvas.Font.Style := [fsBold];
    if sItemYear > sYear then begin
      Sender.Canvas.Font.Color := clNavy;
    end
    else begin
      Sender.Canvas.Font.Size := lstvSchedules.Font.Size + 1;
    end;
  end
  else begin
    Sender.Canvas.Font.Style := [];
    Sender.Canvas.Font.Color := clGray;
    Sender.Canvas.Font.Size := lstvSchedules.Font.Size;
  end;
  //Sender.Canvas.FillRect(Rect(Item.Left, Item.Top, Item.Left, Item.Top));
  if Item = nil then
    Exit;
  i := Item.Index;
  if i mod 2 = 0 then
    Sender.Canvas.Brush.Color := clCream
  else
    Sender.Canvas.Brush.Color := clWhite;
end;

procedure TfrmScheduleList.mniSort2ByNameClick(Sender: TObject);
begin
  mniSort2ByName.Checked := not (mniSort2ByName.Checked);
  SetAppConfigSortType(10);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.mniSort2ByDescriptionClick(Sender: TObject);
begin
  mniSort2ByDescription.Checked := not (mniSort2ByDescription.Checked);
  SetAppConfigSortType(11);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.mniSort2ByCycleClick(Sender: TObject);
begin
  mniSort2ByCycle.Checked := not (mniSort2ByCycle.Checked);
  SetAppConfigSortType(12);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.mniSort2ByNumOfEmpsClick(Sender: TObject);
begin
  mniSort2ByNumOfEmps.Checked := not (mniSort2ByNumOfEmps.Checked);
  SetAppConfigSortType(13);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.mniSort2ByLastMonthClick(Sender: TObject);
begin
  mniSort2ByLastMonth.Checked := not (mniSort2ByLastMonth.Checked);
  SetAppConfigSortType(14);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.mniReverseSort2Click(Sender: TObject);
begin
  mniReverseSort2.Checked := not (mniReverseSort2.Checked);
  SetAppConfigSortType(-1);
  lstvSchedules.SortType := stNone;
  lstvSchedules.SortType := stData;
end;

procedure TfrmScheduleList.RestoreSort;
begin
  if pmiSortByName.Checked then begin
    pmiSortByName.Checked := False;
    pmiSortByNameClick(nil);
  end
  else if pmiSortByDescription.Checked then begin
    pmiSortByDescription.Checked := False;
    pmiSortByDescriptionClick(nil);
  end
  else if pmiSortByCycle.Checked then begin
    pmiSortByCycle.Checked := False;
    pmiSortByCycleClick(nil);
  end
  else if pmiSortByNumOfEmps.Checked then begin
    pmiSortByNumOfEmps.Checked := False;
    pmiSortByNumOfEmpsClick(nil);
  end
  else if pmiSortByLastMonth.Checked then begin
    pmiSortByLastMonth.Checked := False;
    pmiSortByLastMonthClick(nil);
  end;
end;

end.


