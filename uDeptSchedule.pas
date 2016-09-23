unit uDeptSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, SqlExpr, FMTBcd, DB, DBClient, DBLocal, DBLocalS,
  Grids, DBGrids, ExtCtrls, Math;

type
  TfrmDeptSchedule = class(TForm)
    SQLClientDataSet1: TSQLClientDataSet;
    SQLQuery1: TSQLQuery;
    strgrdDeptSchedule: TStringGrid;
    Panel1: TPanel;
    sqlqryText: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure strgrdDeptScheduleDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure strgrdDeptScheduleDblClick(Sender: TObject);
    procedure strgrdDeptScheduleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure strgrdDeptScheduleMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure strgrdDeptScheduleMouseWheelUp(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure strgrdDeptScheduleMouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    //arrDepts: array of String;
    arrDepts: TStringList;
    arrSchedules: array of String;
    prevRow: Integer;
    procedure ChessTable; //Шахматка зависимости между графиками и цехами
  public
    { Public declarations }
  end;

  TListItem = class(TObject)
  private
    fDeptID: Integer;
    fDeptName: String;
  protected

  public
    property DeptID: Integer read fDeptID write fDeptID;
    property DeptName: String read fDeptName write fDeptName;

    //constructor Create; override;
    //destructor Destroy; override;
  published

  end;


var
  frmDeptSchedule: TfrmDeptSchedule;

implementation

uses udmMain;

{$R *.dfm}

procedure TfrmDeptSchedule.FormCreate(Sender: TObject);
begin
  ChessTable;
  prevRow := 1;
end;

procedure TfrmDeptSchedule.strgrdDeptScheduleDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Buf: array[byte] of char;
begin
  with strgrdDeptSchedule.Canvas do
    if (ACol = 0) and (ARow = 0) then begin
      Font.Style := Font.Style + [fsBold];
      FillRect(Rect);
      StrPCopy(Buf, ' ' + strgrdDeptSchedule.Cells[ACol, ARow] + ' ');
      DrawText(Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_CENTER);
    end
    else
      if (ACol = 0) then begin
        if ARow = strgrdDeptSchedule.Row then
          Font.Style := Font.Style + [fsBold]
        else
          Font.Style := Font.Style - [fsBold];
        FillRect(Rect);
        StrPCopy(Buf, ' ' + strgrdDeptSchedule.Cells[ACol, ARow] + ' ');
        DrawText(Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_CENTER);
      end
      else
        if (ARow = 0) then begin
          if strgrdDeptSchedule.Cells[ACol, strgrdDeptSchedule.Row] <> '' then
            Font.Style := Font.Style + [fsBold]
          else
            Font.Style := Font.Style - [fsBold];
          if strgrdDeptSchedule.Col = ACol then
            Font.Color := clBlue
          else
            Font.Color := clWindowText;
          FillRect(Rect);
          StrPCopy(Buf, ' ' + strgrdDeptSchedule.Cells[ACol, ARow] + ' ');
          DrawText(Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_CENTER);
        end
        else
          if strgrdDeptSchedule.Cells[ACol, ARow]<>'' then begin
            Brush.Color := clMoneyGreen;
            FillRect(Rect);
          end{
          else
            if gdSelected in State then begin
              Brush.Color := clGray;
              FillRect(Rect);
            end};

      {
      else
        if (ACol = strgrdDeptSchedule.Col) or (ARow = strgrdDeptSchedule.Row) then begin
          Brush.Color := clInfoBk;
          FillRect(Rect);
        end;
      }
{    end
    else begin
      if (ACol = 0) or (strgrdDeptSchedule.Cells[ACol, strgrdDeptSchedule.Row] <> '') then
        Font.Style := Font.Style + [fsBold]
      else
        Font.Style := Font.Style - [fsBold];
      FillRect(Rect);
      StrPCopy(Buf, strgrdDeptSchedule.Cells[ACol, ARow]);
      if ARow = 0 then
        DrawText(Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP);
      else
        DrawText(Handle, Buf, -1, Rect, DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_CENTER);
      //TextOut(Rect.Left+Trunc((strgrdDeptSchedule.ColWidths[ACol]-TextWidth(strgrdDeptSchedule.Cells[ACol, ARow]))/2),Rect.Top+2,strgrdDeptSchedule.Cells[ACol,ARow]);
    end;
}
end;

procedure TfrmDeptSchedule.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDeptSchedule.strgrdDeptScheduleDblClick(Sender: TObject);
var
  sSQL: String;
  iCol, iRow: Integer;
begin
  iCol := strgrdDeptSchedule.Col;
  iRow := strgrdDeptSchedule.Row;
  if strgrdDeptSchedule.Cells[strgrdDeptSchedule.Col, strgrdDeptSchedule.Row] = '' then begin
    if Application.MessageBox(PChar('Вы действительно хотите разрешить график "' + strgrdDeptSchedule.Cells[0, strgrdDeptSchedule.Row] + '" цеху "' + strgrdDeptSchedule.Cells[strgrdDeptSchedule.Col, 0] + '"?'), 'Добавление графика', MB_ICONQUESTION or MB_YESNO) = ID_YES then begin
      //sSQL := 'insert into QWERTY.SP_ZAR_CEX_SMEN(ID_CEX, ID_SMEN) select '+arrDepts[strgrdDeptSchedule.Col-1]+', ID_SMEN from QWERTY.SP_ZAR_S_SMEN where TIP_SMEN='+arrSchedules[strgrdDeptSchedule.Row-1];
      sSQL := 'insert into QWERTY.SP_ZAR_CEX_SMEN(ID_CEX, ID_SMEN) select ' + IntToStr(TListItem(arrDepts.Objects[arrdepts.IndexOf(strgrdDeptSchedule.Cells[strgrdDeptSchedule.Col, 0])]).DeptID) + ', ID_SMEN from QWERTY.SP_ZAR_S_SMEN where TIP_SMEN=' + arrSchedules[strgrdDeptSchedule.Row - 1];
      SQLQuery1.SQL.Clear;
      SQLQuery1.SQL.Add(sSQL);
      SQLQuery1.ExecSQL(True);
      ChessTable;
      strgrdDeptSchedule.Col := iCol;
      strgrdDeptSchedule.Row := iRow;
    end;
  end
  else if Application.MessageBox(PChar('Вы действительно хотите забрать у цеха "' + strgrdDeptSchedule.Cells[strgrdDeptSchedule.Col, 0] + '" график "' + strgrdDeptSchedule.Cells[0, strgrdDeptSchedule.Row] + '"?'), 'Удаление графика', MB_ICONHAND or MB_YESNO) = ID_YES then begin
      //sSQL := 'delete from QWERTY.SP_ZAR_CEX_SMEN where ID_CEX='+arrDepts[strgrdDeptSchedule.Col-1]+' and ID_SMEN in (select ID_SMEN from QWERTY.SP_ZAR_S_SMEN where TIP_SMEN='+arrSchedules[strgrdDeptSchedule.Row-1]+')';
    sSQL := 'delete from QWERTY.SP_ZAR_CEX_SMEN where ID_CEX=' + IntToStr(TListItem(arrDepts.Objects[arrdepts.IndexOf(strgrdDeptSchedule.Cells[strgrdDeptSchedule.Col, 0])]).DeptID) + ' and ID_SMEN in (select ID_SMEN from QWERTY.SP_ZAR_S_SMEN where TIP_SMEN=' + arrSchedules[strgrdDeptSchedule.Row - 1] + ')';
    SQLQuery1.SQL.Clear;
    SQLQuery1.SQL.Add(sSQL);
    SQLQuery1.ExecSQL(True);
    ChessTable;
    strgrdDeptSchedule.Col := iCol;
    strgrdDeptSchedule.Row := iRow;
  end;
end;

procedure TfrmDeptSchedule.ChessTable;
var
  sSQL1, sSQL2, sSQL3: string;
  i, j: Integer;
  sC: string;
  grid: TStringGrid;
  colWidth: array of Integer;
  lstItem: TListItem;
begin
  strgrdDeptSchedule.RowCount := 0;
  strgrdDeptSchedule.ColCount := 0;
{
  SQLQuery1.SQL.Add('select tip_smen, name_u from qwerty.sp_zar_t_smen order by 1');
  SQLQuery1.Active := True;
  sSQL1 := 'select p.id_cex, ';
  sSQL2 := 'from (select distinct id_cex from qwerty.sp_zar_cex_smen) p, ';
  sSQL3 := 'where ';
  i := 1;
  while not(SQLQuery1.Eof) do begin
    sS    := 's'+IntToStr(i);
    sSQL1 := sSQL1+sS+'.schdl "'+SQLQuery1.Fields.Fields[1].AsString+'", ';
    sSQL2 := sSQL2+'(select id_cex, count(*) schdl from qwerty.sp_zar_cex_smen where id_smen in (select id_smen from qwerty.sp_zar_s_smen where tip_smen='+SQLQuery1.Fields.Fields[0].AsString+') group by id_cex) '+sS+', ';
    sSQL3 := sSQL3+sS+'.id_cex(+)=p.id_cex and ';
    inc(i);
    SQLQuery1.Next;
  end;
  sSQL1 := Copy(sSQL1, 1, Length(sSQL1)-2);
  sSQL2 := Copy(sSQL2, 1, Length(sSQL2)-2);
  sSQL3 := Copy(sSQL3, 1, Length(sSQL3)-5);
  SQLClientDataSet1.CommandText := sSQL1+' '+sSQL2+' '+sSQL3;
  SQLClientDataSet1.Active := True;
}
  SQLQuery1.Active := False;
  SQLQuery1.SQL.Clear;
  SQLQuery1.SQL.Add('select id_cex, name_u, nam from qwerty.sp_podr where id_cex in (select distinct id_cex from qwerty.sp_zar_cex_smen) order by 2');
  SQLQuery1.Active := True;
  sSQL1 := 'select ts.tip_smen "Тип", ts.name_u "ГРАФИКИ \ ЦЕХА", ';
  sSQL2 := 'from (select tip_smen, name_u from qwerty.sp_zar_t_smen where tip_smen in (select tip_smen from qwerty.sp_zar_s_smen)) ts, ';
  sSQL3 := 'where ';
  i := 1;
  arrDepts := TStringList.Create;
  while not (SQLQuery1.Eof) do begin
    if SQLQuery1.Fields.Fields[2].AsString <> '' then begin
      sC := 'c' + IntToStr(i);
      sSQL1 := sSQL1 + sC + '.cnt "' + SQLQuery1.Fields.Fields[2].AsString + '", ';
      sSQL2 := sSQL2 + '(select tip_smen, count(*) cnt from qwerty.sp_zar_s_smen where id_smen in (select id_smen from qwerty.sp_zar_cex_smen where id_cex=' + SQLQuery1.Fields.Fields[0].AsString + ') group by tip_smen) ' + sC + ', ';
      sSQL3 := sSQL3 + sC + '.tip_smen(+)=ts.tip_smen and ';

      //SetLength(arrDepts, i);
      //arrDepts[i - 1] := SQLQuery1.Fields.Fields[0].AsString;
      lstItem := TListItem.Create;
      lstItem.DeptID := SQLQuery1.Fields.Fields[0].AsInteger;
      lstItem.DeptName := SQLQuery1.Fields.Fields[2].AsString;
      arrDepts.AddObject(SQLQuery1.Fields.Fields[2].AsString, lstItem);

      inc(i);
      SQLQuery1.Next;
    end;
  end;
  sSQL1 := Copy(sSQL1, 1, Length(sSQL1) - 2);
  sSQL2 := Copy(sSQL2, 1, Length(sSQL2) - 2);
  sSQL3 := Copy(sSQL3, 1, Length(sSQL3) - 5);
  SQLClientDataSet1.Active := False;
  //SQLClientDataSet1.CommandText := sSQL1 + ' ' + sSQL2 + ' ' + sSQL3 + ' order by 2';
  sqlqryText.Active := True;

  SQLClientDataSet1.CommandText := 'SELECT * FROM (SELECT DISTINCT tip_smen "Тип", smena_name "ГРАФИКИ \ ЦЕХА"';
  while not(sqlqryText.Eof) do begin
    SQLClientDataSet1.CommandText := SQLClientDataSet1.CommandText + ' ' + sqlqryText.Fields.FieldByName('QRY').AsString;
    sqlqryText.Next;
  end;
  sqlqryText.Active := False;
  SQLClientDataSet1.CommandText := SQLClientDataSet1.CommandText + ' ' + 'FROM (SELECT DISTINCT ts.tip_smen, ts.name_u smena_name, p.name_u dept_name, ';
  SQLClientDataSet1.CommandText := SQLClientDataSet1.CommandText + ' ' + 'p.nam dept_s_name, COUNT(*) over(PARTITION BY ts.tip_smen, cs.id_cex) smena_cnt, cs.id_cex';
  SQLClientDataSet1.CommandText := SQLClientDataSet1.CommandText + ' ' + 'FROM qwerty.sp_zar_cex_smen cs, qwerty.sp_zar_s_smen ss, qwerty.sp_zar_t_smen ts';
  SQLClientDataSet1.CommandText := SQLClientDataSet1.CommandText + ' ' + ', qwerty.sp_podr p WHERE cs.id_smen(+) = ss.id_smen AND ss.tip_smen = ts.tip_smen AND cs.id_cex = p.id_cex(+))) ORDER BY 2';

  SQLClientDataSet1.Active := True;
  grid := TStringGrid.Create(self);
  grid.RowCount := SQLClientDataSet1.RecordCount + 1;
  strgrdDeptSchedule.RowCount := grid.RowCount;
  grid.ColCount := SQLClientDataSet1.Fields.Count - 1;
  strgrdDeptSchedule.ColCount := grid.ColCount;
  i := 0;
  SetLength(colWidth, grid.ColCount);

  for j := 0 to grid.ColCount - 1 do begin
    strgrdDeptSchedule.Cells[j, i] := SQLClientDataSet1.Fields.Fields[j + 1].FieldName;
    colWidth[j] := Max(colWidth[j], strgrdDeptSchedule.Canvas.TextWidth(strgrdDeptSchedule.Cells[j, i]) + 20);
  end;

  inc(i);

  while not (SQLClientDataSet1.Eof) do begin
    for j := 0 to grid.ColCount - 1 do begin
      grid.Cells[j, i] := SQLClientDataSet1.Fields.Fields[j + 1].AsString;
      if j = 0 then begin
        //w := strgrdDeptSchedule.Canvas.TextWidth(grid.Cells[j, i]) + 20;
        //if w > colWidth[j] then
        //  colWidth[j] := w;
        colWidth[j] := Max(colWidth[j], strgrdDeptSchedule.Canvas.TextWidth(grid.Cells[j, i]) + 40);
      end;
    end;

    SetLength(arrSchedules, i);
    arrSchedules[i - 1] := SQLClientDataSet1.Fields.Fields[0].AsString;

    inc(i);
    SQLClientDataSet1.Next;
  end;

  for i := 1 to grid.RowCount - 1 do
    for j := 0 to grid.ColCount - 1 do
      strgrdDeptSchedule.Cells[j, i] := grid.Cells[j, i];

  for j := 0 to grid.ColCount - 1 do
    strgrdDeptSchedule.ColWidths[j] := colWidth[j];

  strgrdDeptSchedule.FixedCols := 1;
  strgrdDeptSchedule.FixedRows := 1;
//  for i:=2 to DBGrid1.Columns.Count-1 do
//    DBGrid1.Columns.Items[i].Width := 40;
end;

procedure TfrmDeptSchedule.strgrdDeptScheduleKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //if strgrdDeptSchedule.Row <> prevRow then begin
    prevRow := strgrdDeptSchedule.Row;
    strgrdDeptSchedule.Refresh;
  //end;
end;

procedure TfrmDeptSchedule.strgrdDeptScheduleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //if strgrdDeptSchedule.Row <> prevRow then begin
    prevRow := strgrdDeptSchedule.Row;
    strgrdDeptSchedule.Refresh;
  //end;
end;

procedure TfrmDeptSchedule.strgrdDeptScheduleMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if strgrdDeptSchedule.Row = 1 then
    Exit;

  strgrdDeptSchedule.Row := strgrdDeptSchedule.Row - 1;
  Handled := True;
  if strgrdDeptSchedule.Row <> prevRow then begin
    prevRow := strgrdDeptSchedule.Row;
    strgrdDeptSchedule.Refresh;
  end;
end;

procedure TfrmDeptSchedule.strgrdDeptScheduleMouseWheelDown(
  Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  if strgrdDeptSchedule.Row = strgrdDeptSchedule.RowCount - 1 then
    Exit;

  strgrdDeptSchedule.Row := strgrdDeptSchedule.Row + 1;
  Handled := True;
  if strgrdDeptSchedule.Row <> prevRow then begin
    prevRow := strgrdDeptSchedule.Row;
    strgrdDeptSchedule.Refresh;
  end;
end;

procedure TfrmDeptSchedule.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  i: Integer;
begin
  if Assigned(arrDepts) then
    for i:= arrDepts.Count - 1 to 0 do
      TListItem(arrDepts.Objects[i]).Free;
end;

end.
