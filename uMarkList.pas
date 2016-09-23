unit uMarkList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type
  TfrmMarkList = class(TForm)
    strgrdMarkList: TStringGrid;
    bitbtnOk: TBitBtn;
    bitbtnClose: TBitBtn;
    cboxSortType: TComboBox;
    Label1: TLabel;
    bitbtnNewMark: TBitBtn;
    procedure bitbtnCloseClick(Sender: TObject);
    procedure bitbtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure strgrdMarkListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure cboxSortTypeChange(Sender: TObject);
    procedure bitbtnNewMarkClick(Sender: TObject);
    procedure strgrdMarkListDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure strgrdMarkListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    ChoosenMarkID: String;
    ChoosenMarkIndex: Integer;
    procedure DrawMarkList;
    procedure SortTable(ACol: Integer);
    procedure ChangeRows(Row1, Row2: Integer);
  end;

var
  frmMarkList: TfrmMarkList;
  oldDecimalSeparator: Char;

implementation

uses udmMain, uMarkInfo, DBConnect;

{$R *.dfm}

procedure TfrmMarkList.DrawMarkList;
var
  w, i, j: Integer;
begin
  with strgrdMarkList do begin
    ColCount := 9;
    RowCount := oblstMarkList.Count+1;

    Cells[1, 0] := 'Отметка';
    w := Canvas.TextWidth(Cells[1, 0]);
    ColWidths[1] := w+8;
    Cells[2, 0] := 'Время работы, ч';
    w := Canvas.TextWidth(Cells[2, 0]);
    ColWidths[2] := w+8;
    Cells[3, 0] := 'Дней';
    w := Canvas.TextWidth(Cells[3, 0]);
    ColWidths[3] := w+8;
    Cells[4, 0] := 'Вечерние, ч';
    w := Canvas.TextWidth(Cells[4, 0]);
    ColWidths[4] := w+8;
    Cells[5, 0] := 'Ночные, ч';
    w := Canvas.TextWidth(Cells[5, 0]);
    ColWidths[5] := w+8;
    Cells[6, 0] := 'Обед, мин';
    w := Canvas.TextWidth(Cells[6, 0]);
    ColWidths[6] := w+8;
    Cells[7, 0] := 'Описание';
    w := Canvas.TextWidth(Cells[7, 0]);
    ColWidths[7] := w+8;
    Cells[8, 0] := 'ObjectListIndex';
    ColWidths[8] := 0;
    ColWidths[0] := 5;
  end;
  for i:=0 to oblstMarkList.Count-1 do begin
    j := i+1;
    with strgrdMarkList do begin
      Cells[1, j] := TMark(oblstMarkList.Items[i]).MarkID;
      w := Canvas.TextWidth(Cells[1, j])+8;
      if ColWidths[1]<w then
        ColWidths[1] := w;

      Cells[2, j] := FloatToStr(TMark(oblstMarkList.Items[i]).WorkTime);
      w := Canvas.TextWidth(Cells[2, j])+8;
      if ColWidths[2]<w then
        ColWidths[2] := w;

      Cells[3, j] := IntToStr(TMark(oblstMarkList.Items[i]).WorkDays);
      w := Canvas.TextWidth(Cells[3, j])+8;
      if ColWidths[3]<w then
        ColWidths[3] := w;

      Cells[4, j] := FloatToStr(TMark(oblstMarkList.Items[i]).EveningTime);
      w := Canvas.TextWidth(Cells[4, j])+8;
      if ColWidths[4]<w then
        ColWidths[4] := w;

      Cells[5, j] := FloatToStr(TMark(oblstMarkList.Items[i]).NightTime);
      w := Canvas.TextWidth(Cells[5, j])+8;
      if ColWidths[5]<w then
        ColWidths[5] := w;

      Cells[6, j] := IntToStr(TMark(oblstMarkList.Items[i]).LunchTime);
      w := Canvas.TextWidth(Cells[6, j])+8;
      if ColWidths[6]<w then
        ColWidths[6] := w;

      Cells[7, j] := TMark(oblstMarkList.Items[i]).Description;
      w := Canvas.TextWidth(Cells[7, j])+8;
      if ColWidths[7]<w then
        ColWidths[7] := w;

      Cells[8, j] := IntToStr(i);
    end;
  end;

  with strgrdMarkList do begin
    strgrdMarkList.Width := ColWidths[0]+ColWidths[1]+ColWidths[2]+ColWidths[3]+ColWidths[4]+ColWidths[5]+ColWidths[6]+ColWidths[7]+ColWidths[8]+GetSystemMetrics(SM_CXVSCROLL)+12;
    frmMarkList.ClientWidth := strgrdMarkList.Width+12;
    //bitbtnClose.Left := frmMarkList.ClientWidth-6-bitbtnClose.Width;
    //bitbtnOk.Left    := frmMarkList.ClientWidth-12-bitbtnOk.Width-bitbtnClose.Width;
  end;
end;

procedure TfrmMarkList.bitbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMarkList.bitbtnOkClick(Sender: TObject);
begin
  ChoosenMarkID := strgrdMarkList.Cells[1, strgrdMarkList.Selection.Top];
  ChoosenMarkIndex := StrToInt(strgrdMarkList.Cells[8, strgrdMarkList.Selection.Top]);
  Close;
end;

procedure TfrmMarkList.FormCreate(Sender: TObject);
begin
  ChoosenMarkID := '000';
  oldDecimalSeparator := DecimalSeparator;
  DecimalSeparator := RightDecimalSeparator;
end;

procedure TfrmMarkList.strgrdMarkListDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
//var
//  lRow, lCol : Longint;
begin
{
  lRow := ARow;
  lCol := ACol;
  with Sender as TStringGrid, Canvas do begin
    if (gdSelected in State) then begin
      Brush.Color := clHighlight;
    end
    else if (gdFixed in State) then begin
      Brush.Color := FixedColor;
    end
      else begin
        Brush.Color := Color;
      end;
    FillRect(Rect);
    SetBkMode(Handle, TRANSPARENT);
    SetTextAlign(Handle, TA_CENTER);
    TextOut(Rect.Right-2, Rect.Top+2, Cells[lCol, lRow]);
  end;
}
end;

procedure TfrmMarkList.SortTable(ACol: Integer);
var
  sTMP: String;
  fTMP: Double;
  i, j: Integer;
begin
{
    Cells[1, 0] := 'Отметка';
    w := Canvas.TextWidth(Cells[1, 0]);
    ColWidths[1] := w+8;
    Cells[2, 0] := 'Время работы, ч';
    w := Canvas.TextWidth(Cells[1, 0]);
    ColWidths[2] := w+8;
    Cells[3, 0] := 'Дней';
    w := Canvas.TextWidth(Cells[3, 0]);
    ColWidths[3] := w+8;
    Cells[4, 0] := 'Вечерние, ч';
    w := Canvas.TextWidth(Cells[4, 0]);
    ColWidths[4] := w+8;
    Cells[5, 0] := 'Ночные, ч';
    w := Canvas.TextWidth(Cells[5, 0]);
    ColWidths[5] := w+8;
    Cells[6, 0] := 'Обед, мин';
    w := Canvas.TextWidth(Cells[6, 0]);
    ColWidths[6] := w+8;
    Cells[7, 0] := 'Описание';
}
  case ACol of
    1, 7: begin
      for j:=1 to strgrdMarkList.RowCount-2 do begin
        sTMP := strgrdMarkList.Cells[ACol, j];
        for i:=j+1 to strgrdMarkList.RowCount-1 do
          if strgrdMarkList.Cells[ACol, i]<sTMP then begin
            ChangeRows(j, i);
            sTMP := strgrdMarkList.Cells[ACol, j];
          end;
      end;
    end;
    2..6: begin
      for j:=1 to strgrdMarkList.RowCount-2 do begin
        fTMP := StrToFloat(strgrdMarkList.Cells[ACol, j]);
        for i:=j+1 to strgrdMarkList.RowCount-1 do
          if StrToFloat(strgrdMarkList.Cells[ACol, i])<fTMP then begin
            ChangeRows(j, i);
            fTMP := StrToFloat(strgrdMarkList.Cells[ACol, j]);
          end;
      end;
    end;
  end;


end;

procedure TfrmMarkList.ChangeRows(Row1, Row2: Integer);
var
  sStr: String;
  i: Integer;
begin
  for i:=0 to strgrdMarkList.ColCount-1 do begin
    sStr := strgrdMarkList.Cells[i, Row1];
    strgrdMarkList.Cells[i, Row1] := strgrdMarkList.Cells[i, Row2];
    strgrdMarkList.Cells[i, Row2] := sStr;
  end;
end;

procedure TfrmMarkList.cboxSortTypeChange(Sender: TObject);
var
  crsrPrevCursor: TCursor;
begin
  crsrPrevCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  try
    SortTable(cboxSortType.ItemIndex+1);
    strgrdMarkList.SetFocus;
  finally
    Screen.Cursor := crsrPrevCursor;
    Application.ProcessMessages;
  end;
end;

procedure TfrmMarkList.bitbtnNewMarkClick(Sender: TObject);
var
  i: Integer;
  sSQL: String;
begin
  frmMarkInfo := TfrmMarkInfo.Create(Application);
  frmMarkInfo.FormMode := 1;
  frmMarkInfo.ChangeFormMode;
  try
    frmMarkInfo.Mark := TMark.Create;
    frmMarkInfo.ShowModal;
    if not(frmMarkInfo.CancelPressed) then begin
      sSQL := 'insert into QWERTY.SP_ZAR_OT_PROP(ID_OTMETKA, TIME_WORK, ID_VID, DAY_WORK, TIME_N, TIME_V, OPIS, T_BEGIN, T_END, OBED) ';
      with frmMarkInfo.Mark do
        sSQL := sSQL+'values('''+MarkID+''', '+FloatToStr(WorkTime)+', '+IntToStr(VidID)+', '+IntToStr(WorkDays)+', '+FloatToStr(NightTime)+', '+FloatToStr(EveningTime)+', '''+Description+''', '''+StartTime+''', '''+FinishTime+''', '+IntToStr(LunchTime)+')';
      dmMain.sqlconDB.ExecuteDirect(sSQL);
      oblstMarkList.Add(frmMarkInfo.Mark);
      DrawMarkList;
      for i:=1 to strgrdMarkList.RowCount-1 do
        if strgrdMarkList.Cells[1, i]=frmMarkInfo.Mark.MarkID then begin
          strgrdMarkList.Row := i;
          exit;
        end;
    end;
  finally
    frmMarkInfo.Free;
  end;
end;

procedure TfrmMarkList.strgrdMarkListDblClick(Sender: TObject);
begin
  bitbtnOkClick(Sender);
end;

procedure TfrmMarkList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  DecimalSeparator := oldDecimalSeparator;
end;

procedure TfrmMarkList.strgrdMarkListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Column, Row: Longint;
begin
  strgrdMarkList.MouseToCell(X, Y, Column, Row);
  if Row=0 then begin
    cboxSortType.ItemIndex := Column-1;
    cboxSortTypeChange(Sender);
  end;
end;

end.
