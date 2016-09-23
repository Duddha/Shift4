unit uFrameSchedule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FMTBcd, DB, SqlExpr, ExtCtrls, Grids, Math, Menus;

type
  TframeSchedule = class(TFrame)
    strgrdSchedule: TStringGrid;
    strgrdScheduleTime: TStringGrid;
    Splitter1: TSplitter;
    sqlqrySchedule: TSQLQuery;
    sqlqryTotal: TSQLQuery;
    pnlBottom: TPanel;
    strgrdScheduleTotal: TStringGrid;
    Splitter2: TSplitter;
    procedure strgrdScheduleSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure strgrdScheduleTopLeftChanged(Sender: TObject);
    procedure strgrdScheduleTimeTopLeftChanged(Sender: TObject);
    procedure strgrdScheduleTimeSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure strgrdScheduleDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure strgrdScheduleTimeDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure strgrdScheduleDblClick(Sender: TObject);
    procedure strgrdScheduleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure strgrdScheduleTotalDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure strgrdScheduleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DrawFixedCell(ACol, ARow: Integer; Highlighted: Boolean);
  private
    { Private declarations }
    iStringGrid: Byte; //Флаг, показывающий в каком StringGrid-е произошло перемещение
  public
    { Public declarations }
    ColoredMode: Boolean;
    ShowMarkTime: Boolean;
    gridsWidth: Integer;
    gridsHeight: Integer;
    procedure ShowSchedule(_ScheduleType: string; _Year: string); overload;
    procedure ShowSchedule(_ScheduleType: Integer; _Year: Integer); overload;
  end;

implementation

uses
  udmMain, Contnrs, uMarkInfo;

{$R *.dfm}

{ TframeSchedule }

procedure TframeSchedule.ShowSchedule(_ScheduleType: string; _Year: string);
var
  i, j, Row, iNumOfFields, Col1, Col2, w, grid2Width: Integer;
  fColWidths: array of integer;
  grid1, grid2, grid3: TStringGrid;
begin
  strgrdSchedule.DisableAlign;
  strgrdScheduleTime.DisableAlign;
  strgrdScheduleTotal.DisableAlign;

  sqlqrySchedule.Active := False;
  sqlqrySchedule.ParamByName('SCHEDULE_TYPE').AsString := _ScheduleType;
  sqlqrySchedule.ParamByName('CUR_YEAR').AsString := _Year;
  sqlqrySchedule.Active := True;
  sqlqryTotal.Active := False;
  sqlqryTotal.ParamByName('SCHEDULE_TYPE').AsString := _ScheduleType;
  sqlqryTotal.ParamByName('CUR_YEAR').AsString := _Year;
  sqlqryTotal.Active := True;

  strgrdSchedule.RowCount := 0;
  strgrdScheduleTime.RowCount := 0;

  if sqlqrySchedule.Eof then begin
    strgrdSchedule.RowCount := 2;
    strgrdSchedule.FixedRows := 1;
    strgrdSchedule.Rows[1].Clear;
    strgrdScheduleTime.RowCount := 2;
    strgrdScheduleTime.FixedRows := 1;
    strgrdScheduleTime.Rows[1].Clear;
    strgrdScheduleTotal.RowCount := 2;
    strgrdScheduleTotal.FixedRows := 1;
    strgrdScheduleTotal.Rows[1].Clear;
    Exit;
  end;

  SetLength(fColWidths, sqlqrySchedule.FieldCount);
  for i := 0 to High(fColWidths) do
    fColWidths[i] := 18;

  grid1 := TStringGrid.Create(Self);
  grid2 := TStringGrid.Create(Self);
  grid3 := TStringGrid.Create(Self);
  grid1.Visible := False;
  grid2.Visible := False;
  grid3.Visible := False;

  iNumOfFields := sqlqrySchedule.FieldCount;
  Col1 := 0;
  Col2 := 0;
  Row := 0;
  //Формируем первую строку с заголовками
  for i := 0 to iNumOfFields - 1 do begin
    case sqlqrySchedule.Fields[i].FieldName[1] of
      '_':
        begin
        //Вспомогательное поле - пока ничего не далаем
        end;
      '+':
        begin
        //Дни и время - заполняем grid2
          grid2.Cells[Col2, Row] := Copy(sqlqrySchedule.Fields[i].FieldName, 2, Length(sqlqrySchedule.Fields[i].FieldName) - 1);
          w := strgrdSchedule.Canvas.TextWidth(grid2.Cells[Col2, Row]);
          if fColWidths[34 + Col2] < w then
            fColWidths[34 + Col2] := w;
          inc(Col2);
        end;
    else
      begin
        //Данные для grid1
        grid1.Cells[Col1, Row] := sqlqrySchedule.Fields[i].FieldName;
        w := strgrdSchedule.Canvas.TextWidth(grid1.Cells[Col1, Row]);
        if fColWidths[Col1] < w then
          fColWidths[Col1] := w;
        inc(Col1);
      end;
    end;
  end;

  //Формируем данные за год
  grid3.ColCount := 8;
  grid3.Cells[0, 0] := 'Смена';
  grid3.Cells[1, 0] := 'Дни по графику';
  grid3.Cells[2, 0] := 'Часы по графику';
  grid3.Cells[3, 0] := 'Переработка (024)';
  grid3.Cells[4, 0] := 'Праздничные (023)';
  grid3.Cells[5, 0] := 'Праздничные (033)';
  grid3.Cells[6, 0] := 'Вечерние';
  grid3.Cells[7, 0] := 'Ночные';
  j := 1;
  with sqlqryTotal do
  try
    DisableControls;
    while not (Eof) do
    try
      grid3.RowCount := j + 1;
      grid3.Cells[0, j] := Fields[1].AsString;
      grid3.Cells[1, j] := Fields[2].AsString;
      grid3.Cells[2, j] := Fields[3].AsString;
      grid3.Cells[3, j] := Fields[4].AsString;
      grid3.Cells[4, j] := Fields[6].AsString;
      grid3.Cells[5, j] := Fields[7].AsString;
      grid3.Cells[6, j] := Fields[8].AsString;
      grid3.Cells[7, j] := Fields[9].AsString;
      inc(j);
    finally
      Next;
    end;
  finally
    Active := False;
    strgrdScheduleTotal.RowCount := grid3.RowCount;
    strgrdScheduleTotal.ColCount := grid3.ColCount;
    for i := 0 to grid3.ColCount - 1 do begin
      strgrdScheduleTotal.Cols[i] := grid3.Cols[i];
    end;
    strgrdScheduleTotal.ColWidths[0] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[0, 0]) + 15;
    strgrdScheduleTotal.ColWidths[1] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[1, 0]) + 15;
    strgrdScheduleTotal.ColWidths[2] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[2, 0]) + 15;
    strgrdScheduleTotal.ColWidths[3] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[3, 0]) + 15;
    strgrdScheduleTotal.ColWidths[4] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[4, 0]) + 15;
    strgrdScheduleTotal.ColWidths[5] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[5, 0]) + 15;
    strgrdScheduleTotal.ColWidths[6] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[6, 0]) + 15;
    strgrdScheduleTotal.ColWidths[7] := strgrdScheduleTotal.Canvas.TextWidth(strgrdScheduleTotal.Cells[7, 0]) + 15;
    strgrdScheduleTotal.FixedRows := 1;
    strgrdScheduleTotal.FixedCols := 1;
    grid3.Free;
    pnlBottom.Height := strgrdScheduleTotal.DefaultRowHeight * strgrdScheduleTotal.RowCount + 12;
    EnableControls;
  end;

  inc(Row);
  with sqlqrySchedule do
  try
    grid1.ColCount := 33;
    grid2.ColCount := 7;
    grid1.FixedCols := 2;

    DisableControls;
    First;
    while not (Eof) do
    try
      grid1.RowCount := Row + 1;
      grid2.RowCount := Row + 1;
      Col1 := 0;
      Col2 := 0;

      for i := 0 to iNumOfFields - 1 do begin
        case Fields[i].FieldName[1] of
          '_':
            begin
            //Вспомогательное поле - пока ничего не далаем
            end;
          '+':
            begin
            //Дни и время - заполняем grid2
              grid2.Cells[Col2, Row] := Fields[i].AsString;
              w := strgrdSchedule.Canvas.TextWidth(grid2.Cells[Col2, Row]);
              if fColWidths[34 + Col2] < w then
                fColWidths[34 + Col2] := w;
              inc(Col2);
            end;
        else
          begin
            //Данные для grid1
            grid1.Cells[Col1, Row] := Fields[i].AsString;
            w := strgrdSchedule.Canvas.TextWidth(grid1.Cells[Col1, Row]);
            if fColWidths[Col1] < w then
              fColWidths[Col1] := w;
            inc(Col1);
          end;
        end;
      end;
      inc(Row);
    finally
      Next;
    end;

  finally
    strgrdScheduleTime.RowCount := grid2.RowCount;
    strgrdScheduleTime.ColCount := grid2.ColCount;
    grid2Width := 0;
    for i := 0 to grid2.ColCount - 1 do begin
      strgrdScheduleTime.Cols[i] := grid2.Cols[i];
      strgrdScheduleTime.ColWidths[i] := fColWidths[34 + i] + 12;
      inc(grid2Width, strgrdScheduleTime.ColWidths[i]);
    end;
    strgrdScheduleTime.FixedRows := 1;
    strgrdScheduleTime.FixedCols := 0;
    strgrdScheduleTime.Width := grid2Width + GetSystemMetrics(SM_CXVSCROLL) + 15;
    grid2.Free;

    strgrdSchedule.RowCount := grid1.RowCount;
    strgrdSchedule.ColCount := grid1.ColCount;
    for i := 0 to grid1.ColCount - 1 do begin
      strgrdSchedule.Cols[i] := grid1.Cols[i];
      strgrdSchedule.ColWidths[i] := fColWidths[i] + 4;
      Inc(grid2Width, strgrdSchedule.ColWidths[i]);
    end;
    gridsHeight := 0;
    //for i:=0 to grid1.RowCount-1 do begin
    //  Inc(gridsHeight, strgrdSchedule.RowHeights[i]);
    //end;
    Inc(gridsHeight, (strgrdSchedule.RowCount + 1) * strgrdSchedule.DefaultRowHeight);
    Inc(gridsHeight, pnlBottom.Height);

    strgrdSchedule.ColWidths[0] := strgrdSchedule.ColWidths[0] + 4;
    strgrdSchedule.ColWidths[1] := strgrdSchedule.ColWidths[1] + 4;
    strgrdSchedule.FixedRows := 1;
    strgrdSchedule.FixedCols := 2;
    grid1.Free;

    gridsWidth := grid2Width;

    sqlqrySchedule.Active := False;

    EnableControls;
  end;

  strgrdSchedule.EnableAlign;
  strgrdScheduleTime.EnableAlign;
  strgrdScheduleTotal.EnableAlign;
end;

procedure TframeSchedule.ShowSchedule(_ScheduleType, _Year: Integer);
begin
  self.ShowSchedule(IntToStr(_ScheduleType), IntToStr(_Year));
end;

procedure TframeSchedule.strgrdScheduleSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  i: Integer;
begin
  if iStringGrid <> 2 then begin
    iStringGrid := 1;
    strgrdScheduleTime.Row := ARow;
  end
  else
    iStringGrid := 0;

  //Перерисовываем предыдующую и выделяемую фиксированные ячейки
  for i := 0 to strgrdSchedule.FixedRows - 1 do begin
    //Предыдущая подсвеченная ячейка отрисовывается по умолчанию
    DrawFixedCell(strgrdSchedule.Col, i, False);
    //Подсвечиваем новую ячейку
    DrawFixedCell(ACol, i, True);
  end;
  for i := 0 to strgrdSchedule.FixedCols - 1 do begin
    DrawFixedCell(i, strgrdSchedule.Row, False);
    DrawFixedCell(i, ARow, True);
  end;
end;

procedure TframeSchedule.strgrdScheduleTopLeftChanged(Sender: TObject);
begin
  strgrdScheduleTime.TopRow := strgrdSchedule.TopRow;
end;

procedure TframeSchedule.strgrdScheduleTimeTopLeftChanged(Sender: TObject);
begin
  strgrdSchedule.TopRow := strgrdScheduleTime.TopRow;
end;

procedure TframeSchedule.strgrdScheduleTimeSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if iStringGrid <> 1 then begin
    iStringGrid := 2;
    strgrdSchedule.Row := ARow;
  end
  else
    iStringGrid := 0;
end;

procedure TframeSchedule.strgrdScheduleDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  oldFontStyle: TFontStyles;
  iMarkIndex: Integer;
  outText: string;
begin
  with strgrdSchedule.Canvas do begin
    oldFontStyle := Font.Style;

    iMarkIndex := -1;

    if gdSelected in State then begin
      Font.Style := Font.Style + [fsBold];
    end;

    //Фиксированные ячейки
    if (ARow < strgrdSchedule.FixedRows) or (ACol < strgrdSchedule.FixedCols) then begin
      Font.Style := Font.Style + [fsBold];
      if (ARow = strgrdSchedule.Row) or (ACol = strgrdSchedule.Col) then begin
        Font.Color := clNavy;
        Brush.Color := clSkyBlue;
      end
      else begin
        Font.Color  := clWindowText;
        Brush.Color := strgrdSchedule.FixedColor;
      end;
      DrawEdge(Handle, rect, BDR_RAISEDINNER, BF_LEFT or BF_RIGHT or BF_TOP or BF_BOTTOM);
      outText := strgrdSchedule.Cells[ACol, ARow];
    end
    else begin
      //Ячейки грида с отметками
      //if ColoredMode or ShowMarkTime then
        iMarkIndex := GetMarkIndexByID(strgrdSchedule.Cells[ACol, ARow]);

      if (iMarkIndex <> -1) then begin
        if ColoredMode and not(gdSelected in State) then
          Brush.Color := TMark(oblstMarkList.Items[iMarkIndex]).Color;

        //Показывать время или отметку
        if ShowMarkTime then
          outText := TMark(oblstMarkList.Items[iMarkIndex]).WorkTimeStr
        else
          outText := strgrdSchedule.Cells[ACol, ARow];
      end;
    end;

    FillRect(Rect);
    TextOut(Rect.Left + Trunc((strgrdSchedule.ColWidths[ACol] - TextWidth(outText)) / 2), Rect.Top + 2, outText);
    Font.Style := oldFontStyle;

    if strgrdSchedule.ColWidths[ACol] < TextWidth(outText) + 5 then
      strgrdSchedule.ColWidths[ACol] := TextWidth(outText) + 5;
  end;
end;

procedure TframeSchedule.strgrdScheduleTimeDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  oldFontStyle: TFontStyles;
begin
  with strgrdScheduleTime.Canvas do begin
    oldFontStyle := Font.Style;
    if (ARow = 0) then
      Font.Style := Font.Style + [fsBold];
    FillRect(Rect);
    TextOut(Rect.Left + Trunc((strgrdScheduleTime.ColWidths[ACol] - TextWidth(strgrdScheduleTime.Cells[ACol, ARow])) / 2), Rect.Top + 2, strgrdScheduleTime.Cells[ACol, ARow]);
    Font.Style := oldFontStyle;
  end;
end;

procedure TframeSchedule.strgrdScheduleDblClick(Sender: TObject);
var
  iMarkIndex: Integer;
begin
  iMarkIndex := GetMarkIndexByID(strgrdSchedule.Cells[strgrdSchedule.Col, strgrdSchedule.Row]);
  if iMarkIndex <> -1 then begin
    frmMarkInfo := TfrmMarkInfo.Create(Application);
    try
      frmMarkInfo.FillInMarkInfo(TMark(oblstMarkList.Items[iMarkIndex]));
      frmMarkInfo.FormMode := 0;
      frmMarkInfo.ChangeFormMode;
      frmMarkInfo.ShowModal;
    finally
      frmMarkInfo.Free;
      strgrdSchedule.Repaint;
    end;
  end;
end;

procedure TframeSchedule.strgrdScheduleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
//var
//  r: integer;
//  c: integer;
begin
{
  if (strgrdSchedule.Row<>1) and (strgrdSchedule.Col<>2) and (strgrdSchedule.Col<>1) then begin
    strgrdSchedule.MouseToCell(X, Y, C, R);
    with strgrdSchedule do
    begin
      if ((Row <> r) or(Col <> c)) then
      begin
        Row := r;
        Col := c;
        Application.CancelHint;
        strgrdSchedule.Hint :=IntToStr(r)+#32+IntToStr(c);
      end;
    end;
  end;
}
end;

procedure TframeSchedule.strgrdScheduleTotalDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  oldFontStyle: TFontStyles;
begin
  with strgrdScheduleTotal.Canvas do begin
    oldFontStyle := Font.Style;
    if (ARow = 0) or (ACol = 0) then
      Font.Style := Font.Style + [fsBold];
    FillRect(Rect);
    TextOut(Rect.Left + Trunc((strgrdScheduleTotal.ColWidths[ACol] - TextWidth(strgrdScheduleTotal.Cells[ACol, ARow])) / 2), Rect.Top + 2, strgrdScheduleTotal.Cells[ACol, ARow]);
    Font.Style := oldFontStyle;
  end;
end;

procedure TframeSchedule.strgrdScheduleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT: begin
      if strgrdSchedule.Col = strgrdSchedule.FixedCols then begin
        if strgrdSchedule.Row = strgrdSchedule.FixedRows then
          strgrdSchedule.Row := strgrdSchedule.RowCount - 1
        else
          strgrdSchedule.Row := strgrdSchedule.Row - 1;

        strgrdSchedule.Col := strgrdSchedule.ColCount - 1;
      end
      else
        strgrdSchedule.Col := strgrdSchedule.Col - 1;

      if Trim(strgrdSchedule.Cells[strgrdSchedule.Col, strgrdSchedule.Row]) = '' then
        //Key := VK_LEFT
        strgrdScheduleKeyDown(Sender, Key, Shift)
      else
        Key := 0;
    end;
    VK_RIGHT: begin
      if strgrdSchedule.Col = strgrdSchedule.ColCount - 1 then begin
        if strgrdSchedule.Row = strgrdSchedule.RowCount - 1 then
          strgrdSchedule.Row := strgrdSchedule.FixedRows
        else
          strgrdSchedule.Row := strgrdSchedule.Row + 1;

        strgrdSchedule.Col := strgrdSchedule.FixedCols;
      end
      else
        strgrdSchedule.Col := strgrdSchedule.Col + 1;

      if Trim(strgrdSchedule.Cells[strgrdSchedule.Col, strgrdSchedule.Row]) = '' then
        strgrdScheduleKeyDown(Sender, Key, Shift)
      else
        Key := 0;
    end;
    VK_UP: begin
      if strgrdSchedule.Row = strgrdSchedule.FixedRows then begin
        strgrdSchedule.Row := strgrdSchedule.RowCount - 1;

        Key := 0;
      end;
    end;
    VK_DOWN: begin
      if strgrdSchedule.Row = strgrdSchedule.RowCount - 1 then begin
        strgrdSchedule.Row := strgrdSchedule.FixedRows;

        Key := 0;
      end;
    end;
  end;

  {
  if strgrdSchedule.Col = strgrdSchedule.FixedCols then begin
    if Key = VK_LEFT then begin
      if strgrdSchedule.Row = strgrdSchedule.FixedRows then
        strgrdSchedule.Row := strgrdSchedule.RowCount - 1
      else
        strgrdSchedule.Row := strgrdSchedule.Row - 1;
      strgrdSchedule.Col := strgrdSchedule.ColCount - 1;

      Key := 0;
    end;
  end
  else if strgrdSchedule.Col = strgrdSchedule.ColCount - 1 then begin
    if Key = VK_RIGHT then begin
      if strgrdSchedule.Row = strgrdSchedule.RowCount - 1 then
        strgrdSchedule.Row := strgrdSchedule.FixedRows
      else
        strgrdSchedule.Row := strgrdSchedule.Row + 1;
      strgrdSchedule.Col := strgrdSchedule.FixedCols;

      Key := 0;
    end;
  end;
  if strgrdSchedule.Row = strgrdSchedule.FixedRows then begin
    if Key = VK_UP then begin
      strgrdSchedule.Row := strgrdSchedule.RowCount - 1;

      Key := 0;
    end;
  end
  else if strgrdSchedule.Row = strgrdSchedule.RowCount - 1 then begin
    if Key = VK_DOWN then begin
      strgrdSchedule.Row := strgrdSchedule.FixedRows;

      Key := 0;
    end;
  end;
  }
end;

procedure TframeSchedule.DrawFixedCell(ACol, ARow: Integer;
  Highlighted: Boolean);
var
  grid: TStringGrid;
  rect: TRect;
  outText: string;
begin
  grid := strgrdSchedule;
  with grid.Canvas do begin
    Font.Style := Font.Style + [fsBold];

    if Highlighted then begin
      Font.Color := clNavy;
      Brush.Color := clSkyBlue;
    end
    else begin
      Font.Color  := clWindowText;
      Brush.Color := strgrdSchedule.FixedColor;
    end;

    //Brush.Color := strgrdSchedule.FixedColor;
    rect := grid.CellRect(ACol, ARow);
    if IsRectEmpty(rect) then
      Exit;
    FillRect(rect);
    outText := grid.Cells[ACol, ARow];
    TextOut(rect.Left + Trunc((grid.ColWidths[ACol] - TextWidth(outText)) / 2), rect.Top + 2, outText);
    DrawEdge(Handle, rect, BDR_RAISEDINNER, BF_TOP or BF_BOTTOM or BF_LEFT or BF_RIGHT);
  end;
end;

end.

