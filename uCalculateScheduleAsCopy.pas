unit uCalculateScheduleAsCopy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, FMTBcd, DB, SqlExpr, udmMain, Buttons, DBXpress;

type
  TfrmCalculateScheduleAsCopy = class(TForm)
    strgrdMarks: TStringGrid;
    sqlqryMarks: TSQLQuery;
    grpboxSource: TGroupBox;
    cboxSchedulesSrc: TComboBox;
    cboxShiftsSrc: TComboBox;
    Label3: TLabel;
    cboxYearsSrc: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    grpboxDestination: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cboxSchedulesDst: TComboBox;
    cboxShiftsDst: TComboBox;
    cboxYearsDst: TComboBox;
    cboxCell: TComboBox;
    bitbtnOk: TBitBtn;
    bitbtnCancel: TBitBtn;
    sqlqryShiftMonth: TSQLQuery;
    chkboxDontClose: TCheckBox;
    bitbtnNewMark: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cboxSchedulesSrcChange(Sender: TObject);
    procedure cboxSchedulesDstChange(Sender: TObject);
    procedure cboxYearsSrcChange(Sender: TObject);
    procedure cboxCellChange(Sender: TObject);
    procedure cboxCellExit(Sender: TObject);
    procedure strgrdMarksSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure bitbtnOkClick(Sender: TObject);
    procedure bitbtnCancelClick(Sender: TObject);
    procedure bitbtnNewMarkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    l_sShiftType: String;
    l_sCurYear: String;
    l_schSchedule: TSchedule;
    procedure FillInMarksSrcTable(_sShiftType, _sCurYear: String);
    procedure FillInMarksDstTable;
    function GetRespondingMark(_MarkID: String): String;
  end;

var
  frmCalculateScheduleAsCopy: TfrmCalculateScheduleAsCopy;

implementation

uses Contnrs, uMarkList;

{$R *.dfm}

procedure TfrmCalculateScheduleAsCopy.FillInMarksSrcTable(_sShiftType, _sCurYear: String);
var
  i: Integer;
  _Mark: TMark;
begin
  sqlqryMarks.Active := False;
  sqlqryMarks.ParamByName('SHIFT_TYPE').AsString := _sShiftType;
  sqlqryMarks.ParamByName('CUR_YEAR').AsString   := _sCurYear;
  sqlqryMarks.Active := True;
  with strgrdMarks do begin
    RowCount := 1;
    ColCount := 2;
    i := 1;
    while not(sqlqryMarks.Eof) do begin
      try
        _Mark := TMark(oblstMarkList.Items[GetMarkIndexByID(sqlqryMarks.Fields.Fields[0].AsString)]);
        RowCount := i + 1;
        Cells[0, i] := _Mark.MarkID+' - '+_Mark.WorkTimeStr+'ч ('+_Mark.Description+')';
        inc(i);
      except
      end;
      sqlqryMarks.Next;
    end;
    if RowCount > 1 then
      FixedRows := 1;
  end;
end;

procedure TfrmCalculateScheduleAsCopy.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to oblstScheduleList.Count-1 do
    cboxSchedulesSrc.Items.Add(TSchedule(oblstScheduleList.Items[i]).NameU);
  cboxSchedulesDst.Items := cboxSchedulesSrc.Items;

  cboxYearsSrc.Items := GetYears;
  cboxYearsSrc.ItemIndex := cboxYearsSrc.Items.IndexOf(sCurYear);
  cboxYearsDst.Items := cboxYearsSrc.Items;
  cboxYearsDst.ItemIndex := cboxYearsSrc.ItemIndex;
end;

procedure TfrmCalculateScheduleAsCopy.cboxSchedulesSrcChange(Sender: TObject);
var
  i: Integer;
  _Schedule: TSchedule;
begin

  _Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesSrc.Text)]);
  cboxShiftsSrc.Clear;
  for i:=0 to _Schedule.ShiftsCount-1 do
    cboxShiftsSrc.Items.Add(_Schedule.Shifts[i].NameU);

  Application.ProcessMessages;
  FillInMarksSrcTable(IntToStr(_Schedule.ScheduleType), cboxYearsSrc.Text);

  try
    cboxShiftsSrc.ItemIndex := 0;
  except
  end;
end;

procedure TfrmCalculateScheduleAsCopy.cboxSchedulesDstChange(
  Sender: TObject);
var
  i: Integer;
  _Schedule: TSchedule;
begin
  _Schedule := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesDst.Text)]);
  cboxShiftsDst.Clear;
  for i:=0 to _Schedule.ShiftsCount-1 do
    cboxShiftsDst.Items.Add(_Schedule.Shifts[i].ShiftID+' - '+_Schedule.Shifts[i].NameU);

  FillInMarksDstTable;
  try
    cboxShiftsDst.ItemIndex := 0;
    bitbtnNewMark.Enabled := True;
  except
    bitbtnNewMark.Enabled := False;
  end;
end;

procedure TfrmCalculateScheduleAsCopy.cboxYearsSrcChange(Sender: TObject);
begin
  try
    FillInMarksSrcTable(IntToStr(TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameR(cboxSchedulesSrc.Text)]).ScheduleType), cboxYearsSrc.Text);
  except
  end;
end;

procedure TfrmCalculateScheduleAsCopy.FillInMarksDstTable;
var
  i: Integer;
  _Mark: TMark;
begin
  cboxCell.Clear;
  for i:=0 to TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesDst.Text)]).MarkIndexesCount-1 do begin
    _Mark := TMark(oblstMarkList.Items[TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesDst.Text)]).MarkIndexes[i]]);
    cboxCell.Items.Add(_Mark.MarkID+' - '+_Mark.WorkTimeStr+'ч ('+_Mark.Description+')');
  end;
end;

procedure TfrmCalculateScheduleAsCopy.cboxCellChange(Sender: TObject);
begin
  strgrdMarks.Cells[1, strgrdMarks.Row] := cboxCell.Text;
  cboxCell.Visible := False;
  strgrdMarks.SetFocus;
end;

procedure TfrmCalculateScheduleAsCopy.cboxCellExit(Sender: TObject);
begin
  strgrdMarks.Cells[1, strgrdMarks.Row] := cboxCell.Text;
  cboxCell.Visible := False;
  strgrdMarks.SetFocus;
end;

procedure TfrmCalculateScheduleAsCopy.strgrdMarksSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  if (ACol=1) and (ARow>0) then begin
    {Ширина и положение ComboBox должно соответствовать ячейке StringGrid}
    R := strgrdMarks.CellRect(ACol, ARow);
    R.Left := R.Left + strgrdMarks.Left;
    R.Right := R.Right + strgrdMarks.Left;
    R.Top := R.Top + strgrdMarks.Top;
    R.Bottom := R.Bottom + strgrdMarks.Top;
    cboxCell.Left := R.Left + 1;
    cboxCell.Top := R.Top + 1;
    cboxCell.Width := (R.Right + 1) - R.Left;
    cboxCell.Height := (R.Bottom + 1) - R.Top; {Покажем combobox}
    cboxCell.Visible := True;
    cboxCell.SetFocus;
    //cboxCell.DroppedDown := True;
  end;
  CanSelect := True;
end;

procedure TfrmCalculateScheduleAsCopy.bitbtnOkClick(Sender: TObject);
var
  i, j: Integer;
  sSQL, sSQLDelete: String;
  _ShiftID, _ScheduleType: String;
  TD: TTransactionDesc;
  sDstDate: String;
begin
  for i:=1 to strgrdMarks.RowCount-1 do
    if strgrdMarks.Cells[1, i]='' then begin
      ShowMessage('Вы должны определить соответствие отметок копируемого графика и графика-приемника');
      strgrdMarks.Row := i;
      strgrdMarks.Col := 1;
      exit; 
    end;
    
  if MessageBox(0, PChar('Вы действительно хотите скопировать график работы'+#13+#10+'смены "'+cboxShiftsSrc.Text+'" графика "'+cboxSchedulesSrc.Text+'" за '+cboxYearsSrc.Text+'год'+#13+#10+'в смену "'+cboxShiftsDst.Text+'" графика "'+cboxSchedulesDst.Text+'" на '+cboxYearsDst.Text+'год?'), 'Копирование графика', MB_ICONQUESTION or MB_YESNO)=ID_NO then
    exit;

  _ScheduleType := IntToStr(TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesDst.Text)]).ScheduleType);
  _ShiftID      := Copy(cboxShiftsDst.Text, 1, 2);
  sqlqryShiftMonth.ParamByName('SHIFT_ID').AsString := TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesSrc.Text)]).Shifts[cboxShiftsSrc.ItemIndex].ShiftID;

  for j:=1 to 12 do begin
    sqlqryShiftMonth.Active := False;
    if j<10 then begin
      sqlqryShiftMonth.ParamByName('SHIFT_DATE').AsString := '01.0'+IntToStr(j)+'.'+cboxYearsSrc.Text;
      sDstDate := '01.0'+IntToStr(j)+'.'+cboxYearsDst.Text;
    end
    else begin
      sqlqryShiftMonth.ParamByName('SHIFT_DATE').AsString := '01.'+IntToStr(j)+'.'+cboxYearsSrc.Text;
      sDstDate := '01.'+IntToStr(j)+'.'+cboxYearsDst.Text;
    end;
    sqlqryShiftMonth.Active := True;
    sSQLDelete := 'delete from QWERTY.SP_ZAR_GRAFIK where DATA_GRAF=to_date('''+sqlqryShiftMonth.ParamByName('SHIFT_DATE').AsString+''', ''dd.mm.yyyy'') and ID_SMEN='''+_ShiftID+'''';
    sSQL := 'insert into QWERTY.SP_ZAR_GRAFIK(DATA_GRAF, TIP_SMEN, ID_SMEN, D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20, D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31) values(to_date('''+sDstDate+''', ''dd.mm.yyyy''), '+_ScheduleType+', '''+_ShiftID+''', ';
    for i:=1 to 30 do
      sSQL := sSQL+''''+GetRespondingMark(sqlqryShiftMonth.Fields.Fields[i+8].AsString)+''', ';
    sSQL := sSQL+''''+GetRespondingMark(sqlqryShiftMonth.Fields.Fields[39].AsString)+''')';

    if not dmMain.sqlconDB.InTransaction then begin
      TD.TransactionID := 1;
      TD.IsolationLevel := xilREADCOMMITTED;
      dmMain.sqlconDB.StartTransaction(TD);
      try
        dmMain.sqlconDB.ExecuteDirect(sSQLDelete);
        dmMain.sqlconDB.ExecuteDirect(sSQL);
        dmMain.sqlconDB.Commit(TD); {on success, commit the changes};
      except
        dmMain.sqlconDB.Rollback(TD); {on failure, undo the changes};
      end;
    end;
  end;
  ShowMessage('Копирование графика завершено');
  if not(chkboxDontClose.Checked) then
    Close;
end;

function TfrmCalculateScheduleAsCopy.GetRespondingMark(
  _MarkID: String): String;
var
  i: Integer;
begin
  result := '  ';
  for i:=1 to strgrdMarks.RowCount do
    if Copy(strgrdMarks.Cells[0, i], 1, 2) = _MarkID then begin
      result := Copy(strgrdMarks.Cells[1, i], 1, 2);
      Exit;
    end;
end;

procedure TfrmCalculateScheduleAsCopy.bitbtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCalculateScheduleAsCopy.bitbtnNewMarkClick(Sender: TObject);
var
  sSQL: String;
begin
  frmMarkList := TfrmMarkList.Create(Application);
  try
    frmMarkList.Caption := 'Выберите отметку для добавления';
    frmMarkList.DrawMarkList;
    frmMarkList.ShowModal;
    if frmMarkList.ChoosenMarkID<>'000' then begin
      TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesDst.Text)]).MarkIndexes[-1] := frmMarkList.ChoosenMarkIndex;
      sSQL := 'insert into QWERTY.SP_ZAR_TABL_SMEN (ID_SMEN, ID_OTMETKA) select ID_SMEN, '''+frmMarkList.ChoosenMarkID+''' from QWERTY.SP_ZAR_S_SMEN where TIP_SMEN='+IntToStr(TSchedule(oblstScheduleList.Items[GetScheduleIndexByNameU(cboxSchedulesDst.Text)]).ScheduleType);
      dmMain.sqlconDB.ExecuteDirect(sSQL);
      FillInMarksDstTable;
    end;
  finally
    frmMarkList.Free;
  end;
end;

procedure TfrmCalculateScheduleAsCopy.FormActivate(Sender: TObject);
begin
  if cboxSchedulesSrc.Text = '' then begin
    cboxSchedulesSrc.SetFocus;
    cboxSchedulesSrc.DroppedDown := True;
  end
  else
    if cboxSchedulesDst.Text = '' then begin
      cboxSchedulesDst.SetFocus;
      cboxSchedulesDst.DroppedDown := True;
    end;
end;

end.
