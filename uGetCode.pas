unit uGetCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, StrUtils;

type
  TfrmGetCode = class(TForm)
    strgrdCodes: TStringGrid;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    pnlUnderTop: TPanel;
    pnlLeft: TPanel;
    lblCaption: TLabel;
    lblCode: TLabel;
    chkShowInfo: TCheckBox;
    splGridBottom: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure strgrdCodesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure strgrdCodesDblClick(Sender: TObject);
    procedure strgrdCodesSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure DrawFixedCell(ACol, ARow: Integer; Highlighted: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure strgrdCodesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure strgrdCodesMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure chkShowInfoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function GetHint(Col, Row: Integer): string;
  public
    { Public declarations }
    slValues: TStringList;
    returnCode: string;
    CanCloseFrom: Boolean;
    procedure FillGrid;
  end;

const
  //ARRAY_LENGTH = 159;
  ARRAY_LENGTH = 158;

var
  frmGetCode: TfrmGetCode;

implementation

uses
  udmMain;

{$R *.dfm}

procedure TfrmGetCode.FillGrid;
var
  i, j: Integer;
  sValue: string[2];
begin
  for i := 1 to ARRAY_LENGTH do
    for j := 1 to ARRAY_LENGTH do begin
      sValue := strgrdCodes.Cells[i, 0] + strgrdCodes.Cells[0, j];
      if slValues.IndexOf(sValue) <> -1 then
        strgrdCodes.Cells[i, j] := sValue;
    end;
end;

procedure TfrmGetCode.FormCreate(Sender: TObject);
var
  i: Integer;
  arChar: array[1..ARRAY_LENGTH] of Byte;
begin
  pnlBottom.Height := 30;
  CanCloseFrom := True;
  slValues := TStringList.Create;
  slValues.CaseSensitive := True;

  {
  for i := 1 to 95 do
    arChar[i] := i + 31;
  for i := 161 to 224 do
    arChar[i - 65] := i + 31;
  }

//  32 - пробел
//  33..47 - !"#$%&'()*+,-./
//  48..57 - 0..9
//  58..64 - :;<=>?@
//  65..90 - A..Z
//  91..96 - [\]^_`
//  97..122 - a..z
//  123..126 - {|}~
//  192..255 - А..Яа..я

  arChar[1] := 32; // пробел
  for i := 48 to 57 do
    arChar[i - 46] := i;  // 0..9
  for i := 192 to 255 do
    arChar[i - 180] := i; // русские символы
  for i := 65 to 90 do
    arChar[i + 11] := i;  // A..Z
  for i := 97 to 122 do
    arChar[i + 5] := i;     // a..z
  for i := 33 to 47 do
    arChar[i + 95] := i;  // !"#$%&'()*+,-./
  for i := 58 to 64 do
    arChar[i + 85] := i;  // :;<=>?@
  for i := 91 to 95 do
    arChar[i + 59] := i;  // [\]^_`   CHR(96) = ' - не берём
  for i := 123 to 126 do
    arChar[i + 32] := i;  // {|}~

  for i := 1 to ARRAY_LENGTH do begin
    strgrdCodes.Cells[i, 0] := Chr(arChar[i]);
    strgrdCodes.Cells[0, i] := strgrdCodes.Cells[i, 0];
  end;
end;

procedure TfrmGetCode.strgrdCodesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  //Фиксированные ячейки
  if (ARow < strgrdCodes.FixedRows) or (ACol < strgrdCodes.FixedCols) then begin
    strgrdCodes.Canvas.Font.Style := strgrdCodes.Canvas.Font.Style + [fsBold];
    strgrdCodes.Canvas.Font.Size := strgrdCodes.Font.Size;
    if (ARow = strgrdCodes.Row) or (ACol = strgrdCodes.Col) then begin
    //if ((ARow >= strgrdCodes.Selection.Top) and (ARow <= strgrdCodes.Selection.Bottom)) or ((ACol >= strgrdCodes.Selection.Left) and (ACol <= strgrdCodes.Selection.Right))
    //  then begin
      strgrdCodes.Canvas.Font.Color := clNavy;
      strgrdCodes.Canvas.Brush.Color := clSkyBlue;
    end
    else begin
      strgrdCodes.Canvas.Font.Color := clWindowText;
      strgrdCodes.Canvas.Brush.Color := strgrdCodes.FixedColor;
    end;
    DrawEdge(Handle, Rect, BDR_RAISEDINNER, BF_LEFT or BF_RIGHT or BF_TOP or BF_BOTTOM);
    {
    if (ARow = strgrdCodes.Row) or (ACol = strgrdCodes.Col) then begin
      strgrdCodes.Canvas.Font.Color := clBlue;
    end;
    }
  end
  else if strgrdCodes.Cells[ACol, ARow] <> '' then begin
    strgrdCodes.Canvas.Brush.Color := clMoneyGreen;
    if gdSelected in State then begin
      strgrdCodes.Canvas.Font.Style := strgrdCodes.Canvas.Font.Style + [fsBold];
      strgrdCodes.Canvas.Font.Color := clBlue;
      strgrdCodes.Canvas.Font.Size := strgrdCodes.Canvas.Font.Size + 1;
    end;
  end;

  strgrdCodes.Canvas.FillRect(Rect);
  strgrdCodes.Canvas.TextOut(Rect.Left + Trunc((strgrdCodes.ColWidths[ACol] - strgrdCodes.Canvas.TextWidth(strgrdCodes.Cells[ACol, ARow])) / 2), Rect.Top + 2,
    strgrdCodes.Cells[ACol, ARow]);
end;

procedure TfrmGetCode.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseFrom;
  if CanClose then begin
    slValues.Free;
    strgrdCodes.Free;
  end;
end;

procedure TfrmGetCode.strgrdCodesDblClick(Sender: TObject);
begin
  if btnSave.Enabled then
    btnSaveClick(Sender);
end;

procedure TfrmGetCode.strgrdCodesSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  i: Integer;
begin
  //Перерисовываем предыдующую и выделяемую фиксированные ячейки
  for i := 0 to strgrdCodes.FixedRows - 1 do begin
    //Предыдущая подсвеченная ячейка отрисовывается по умолчанию
    DrawFixedCell(strgrdCodes.Col, i, False);
    //Подсвечиваем новую ячейку
    DrawFixedCell(ACol, i, True);
  end;
  for i := 0 to strgrdCodes.FixedCols - 1 do begin
    DrawFixedCell(i, strgrdCodes.Row, False);
    DrawFixedCell(i, ARow, True);
  end;

  if chkShowInfo.Enabled then
    lblCode.Caption := GetHint(ACol, ARow);
end;

procedure TfrmGetCode.DrawFixedCell(ACol, ARow: Integer; Highlighted: Boolean);
var
  grid: TStringGrid;
  rect: TRect;
  outText: string;
begin
  grid := strgrdCodes;
  with grid.Canvas do begin
    Font.Style := Font.Style + [fsBold];
    Font.Size := grid.Font.Size;

    if Highlighted then begin
      Font.Color := clNavy;
      Brush.Color := clSkyBlue;
    end
    else begin
      Font.Color := clWindowText;
      Brush.Color := strgrdCodes.FixedColor;
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

procedure TfrmGetCode.btnCancelClick(Sender: TObject);
begin
  CanCloseFrom := True;
  returnCode := '';
  Close;
end;

procedure TfrmGetCode.btnSaveClick(Sender: TObject);
var
  i, j: Integer;
  sCode: string;

  function CheckCode(Code: string): Boolean;
  begin
    Result := True;
    if Trim(Code) = '' then begin
      ShowMessage('Не стоит в качестве кода использовать два пробела. Выберите другой, пожалуйста');
      Result := False;
    end
    else if AnsiPos('''', Code) > 0 then begin
      ShowMessage('Символ одинарной кавычки нежелателен в коде. Выберите другой код, пожалуйста');
      Result := False;
    end;
  end;

  function Codes2String(Codes: string): string;
  var
    i: Integer;
  begin
    Result := '';
    if Length(Codes) <= 2 then
      Result := '"' + Codes + '"'
    else begin
      for i := Trunc(Length(Codes) / 2) downto 1 do
        Result := ', "' + Copy(Codes, (i - 1) * 2 + 1, 2) + '"' + Result;

      Result := Copy(Result, 3, Length(Result));
    end;
  end;

begin
  returnCode := '';

  if (strgrdCodes.Selection.Left <> strgrdCodes.Selection.Right) or (strgrdCodes.Selection.Top <> strgrdCodes.Selection.Bottom) then begin // Multiselect
    for i := strgrdCodes.Selection.Left to strgrdCodes.Selection.Right do
      for j := strgrdCodes.Selection.Top to strgrdCodes.Selection.Bottom do begin
        sCode := strgrdCodes.Cells[i, 0] + strgrdCodes.Cells[0, j];
        if not (CheckCode(sCode)) then begin
          CanCloseFrom := False;
          Exit;
        end;
        if strgrdCodes.Cells[i, j] <> '' then begin
          ShowMessage('Код "' + sCode + '" уже используется! Выберите другой, пожалуйста');
          CanCloseFrom := False;
          Exit;
        end;
        returnCode := IfThen(Length(returnCode) = 0, '', returnCode) + sCode;
      end;
  end
  else begin
    sCode := strgrdCodes.Cells[strgrdCodes.Col, 0] + strgrdCodes.Cells[0, strgrdCodes.Row];
    if not (CheckCode(sCode)) then begin
      CanCloseFrom := False;
      Exit;
    end;
    if strgrdCodes.Cells[strgrdCodes.Col, strgrdCodes.Row] <> '' then begin
      ShowMessage('Код "' + sCode + '" уже используется! Выберите другой, пожалуйста');
      CanCloseFrom := False;
      Exit;
    end;
    returnCode := sCode;
  end;

  CanCloseFrom := True;
  //ShowMessage('Выбран(ы) код(ы): ' + Codes2String(returnCode) + #10#13 + returnCode);
  Close;
end;

procedure TfrmGetCode.strgrdCodesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{var
  i, j: Integer;}
begin
  // Подсветка фиксированных ячеек при множественном выборе
  {for i := strgrdCodes.LeftCol to strgrdCodes.Selection.Left - 1 do
    for j := 0 to strgrdCodes.FixedRows - 1 do
      DrawFixedCell(i, j, False);
  for i := strgrdCodes.Selection.Right + 1 to strgrdCodes.LeftCol + strgrdCodes.VisibleColCount do
    for j := 0 to strgrdCodes.FixedRows - 1 do
      DrawFixedCell(i, j, False);
  for i := strgrdCodes.TopRow to strgrdCodes.Selection.Top - 1 do
    for j := 0 to strgrdCodes.FixedCols - 1 do
      DrawFixedCell(j, i, False);
  for i := strgrdCodes.Selection.Bottom + 1 to strgrdCodes.Top + strgrdCodes.VisibleRowCount do
    for j := 0 to strgrdCodes.FixedCols - 1 do
      DrawFixedCell(j, i, False);

  if strgrdCodes.Selection.Left <> strgrdCodes.Selection.Right then begin
    for i := strgrdCodes.Selection.Left to strgrdCodes.Selection.Right do
      for j := 0 to strgrdCodes.FixedRows - 1 do
        DrawFixedCell(i, j, True);
  end;
  if strgrdCodes.Selection.Top <> strgrdCodes.Selection.Bottom then begin
    for i := strgrdCodes.Selection.Top to strgrdCodes.Selection.Bottom do
      for j := 0 to strgrdCodes.FixedCols - 1 do
        DrawFixedCell(j, i, True);
  end;}
end;

function TfrmGetCode.GetHint(Col, Row: Integer): string;
begin
  if (Col = -1) and (Row = -1) then begin
    Col := strgrdCodes.Col;
    Row := strgrdCodes.Row;
  end;
  Result := '';
  case frmGetCode.Tag of
    2: // Работаем с отметками
      begin
        if strgrdCodes.Cells[Col, Row] <> '' then begin
          Result := TMark(oblstMarkList.Items[GetMarkIndexByID(strgrdCodes.Cells[Col, Row])]).AsStrings;
        end;
      end;
    3: // Работаем со сменами
      begin
        { TODO -oBishop -cSHIFT : 
          Отображение дополнительной информации по коду смены:
           - показать название/описание
           - график, которому принадлежит смена
           - ...

          Разобраться как найти график в списке графиков по коду смены }
        if strgrdCodes.Cells[Col, Row] <> '' then begin
          //Result := 'Код смены: ''' + strgrdCodes.Cells[Col, Row] + '''' + #10#13 + 'Отображение дополнительной информации по коду смены будет реализовано в следующей версии...';
          Result := TSchedule(oblstScheduleList.Items[GetScheduleIndexByShiftID(strgrdCodes.Cells[Col, Row])]).AsStrings;
        end;
      end;
  else
    begin

    end;
  end;
end;

procedure TfrmGetCode.strgrdCodesMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
{
var
  iCol, iRow: Integer;
}
begin
{
  strgrdCodes.MouseToCell(X, Y, iCol, iRow);
  if (iCol >= strgrdCodes.FixedCols) and (iRow >= strgrdCodes.FixedRows) then
    if strgrdCodes.Cells[iCol, iRow] = '' then
      strgrdCodes.Hint := ''
    else
      strgrdCodes.Hint := GetHint(iCol, iRow);
}
end;

procedure TfrmGetCode.chkShowInfoClick(Sender: TObject);
begin
  if chkShowInfo.Checked then begin
    pnlBottom.Height := 140;
    //lblCode.Width := strgrdCodes.Width;
    lblCode.Caption := GetHint(strgrdCodes.Col, strgrdCodes.Row);
  end
  else begin
    pnlBottom.Height := 30;
  end;
end;

procedure TfrmGetCode.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then
    if (Key = Ord('i')) or (Key = Ord('I')) or (Key = Ord('ш')) or (Key = Ord('Ш')) then begin
      chkShowInfo.Checked := not(chkShowInfo.Checked);
      chkShowInfoClick(Sender);
    end;
end;

end.


