unit uHoliday;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, DateUtils, FMTBcd, DB, SqlExpr, StrUtils, Math,
  Buttons, ComCtrls;

type
  TfrmHolidays = class(TForm)
    Label1: TLabel;
    cboxYear: TComboBox;
    strgrdCalendar: TStringGrid;
    sqlqryQuery: TSQLQuery;
    sqlqryYears: TSQLQuery;
    bitbtnClose: TBitBtn;
    Label2: TLabel;
    spbtnNewYear: TSpeedButton;
    spbtnChistmas: TSpeedButton;
    spbtnMarch8: TSpeedButton;
    spbtnEaster: TSpeedButton;
    spbtnTrinity: TSpeedButton;
    spbtnMay1: TSpeedButton;
    spbtnVictoryDay: TSpeedButton;
    spbtnConstitutionDay: TSpeedButton;
    spbtnIndependenceDay: TSpeedButton;
    spbtnMay2: TSpeedButton;
    spbtnOctober14: TSpeedButton;
    procedure cboxYearChange(Sender: TObject);
    procedure strgrdCalendarDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure strgrdCalendarDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bitbtnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure spbtnNewYearClick(Sender: TObject);
    procedure cboxYearKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    arHolidays: array of array of integer;
    strlstHolidays: TStringList;
    sEasterDay, sEasterMonth, sTrinityDay, sTrinityMonth: String;
    clHoliday: TColor;
  public
    { Public declarations }
    sYear: String;

    procedure DrawCalendar(_Year: Integer); overload;
    procedure DrawCalendar; overload;
    procedure CreateHolidayArray;
    function IsHoliday(_Day, _Month: Integer): Boolean;
    procedure GetEaster(_Year: Integer);
    procedure CheckButtons;
  end;

var
  frmHolidays: TfrmHolidays;

implementation

uses udmMain;

{$R *.dfm}

procedure TfrmHolidays.DrawCalendar(_Year: Integer);
var
  w: Integer;
  i, j, k: Byte;
  bLeapYear: Boolean;
  gs: TGridRect;
begin
  for i:=1 to 12 do begin
    strgrdCalendar.Cells[0, i] := setMonths[i];
    w := strgrdCalendar.Canvas.TextWidth(setMonths[i])+4;
    if strgrdCalendar.ColWidths[0]<w then
      strgrdCalendar.ColWidths[0] := w;
  end;
  for i:=0 to 4 do
    for j:=1 to 7 do
      strgrdCalendar.Cells[i*7+j, 0] := setDaysOfWeek[j];
  strgrdCalendar.Cells[36, 0] := setDaysOfWeek[1];
  strgrdCalendar.Cells[37, 0] := setDaysOfWeek[2];

  strgrdCalendar.Width := strgrdCalendar.ColWidths[0]+37*20+42;
  frmHolidays.ClientWidth := strgrdCalendar.Width+12;
  bitbtnClose.Left := strgrdCalendar.Left+strgrdCalendar.Width-bitbtnClose.Width;

  if (_Year mod 4 = 0) and not(_Year mod 400 = 0) then
    bLeapYear := True
  else
    bLeapYear := False;

  i := 1;
  repeat
    k := DayOfTheWeek(EncodeDate(_Year, i, 1))-1;
    for j:=1 to 31 do
      strgrdCalendar.Cells[j+k, i] := IntToStr(j);
    inc(i, 2);
  until i>7;
  i := 8;
  repeat
    k := DayOfTheWeek(EncodeDate(_Year, i, 1))-1;
    for j:=1 to 31 do
      strgrdCalendar.Cells[j+k, i] := IntToStr(j);
    inc(i, 2);
  until i>12;

  case bLeapYear of
    True: begin
      w := 29;
    end;
    False: begin
      w := 28;
    end;
  end;
  k := DayOfTheWeek(EncodeDate(_Year, 2, 1))-1;
  for j:=1 to w do
    strgrdCalendar.Cells[j+k, 2] := IntToStr(j);

  i := 4;
  repeat
    k := DayOfTheWeek(EncodeDate(_Year, i, 1))-1;
    for j:=1 to 30 do
      strgrdCalendar.Cells[j+k, i] := IntToStr(j);
    inc(i, 2);
  until i>6;
  i := 9;
  repeat
    k := DayOfTheWeek(EncodeDate(_Year, i, 1))-1;
    for j:=1 to 30 do
      strgrdCalendar.Cells[j+k, i] := IntToStr(j);
    inc(i, 2);
  until i>11;

  gs.Left   := 1;
  gs.Top    := 1;
  gs.Right  := 1;
  gs.Bottom := 1;
  strgrdCalendar.Selection := gs;
end;

procedure TfrmHolidays.DrawCalendar;
begin
  DrawCalendar(StrToInt(sYear));
end;

procedure TfrmHolidays.cboxYearChange(Sender: TObject);
var
  i, j: Byte;
begin
  for i:=1 to 12 do
    for j:= 1 to 37 do
      strgrdCalendar.Cells[j, i] := '';
  sYear := cboxYear.Text;
  CreateHolidayArray;
  DrawCalendar;
  GetEaster(StrToInt(sYear));
  CheckButtons;
end;

procedure TfrmHolidays.strgrdCalendarDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with strgrdCalendar, strgrdCalendar.Canvas do begin
    try
      try
        if IsHoliday(StrToInt(Cells[ACol, ARow]), ARow) then begin
          //Brush.Color := clSkyBlue;
          Brush.Color := clHoliday;
        end
        else
          if not(Brush.Color = FixedColor) then begin
            if (ARow mod 2 <> 0) then
              Brush.Color := clInfoBk
            else
              Brush.Color := clWindow;
            if (Cells[ACol, 0]='Сб') or (Cells[ACol, 0]='Вс') then
              Brush.Color := clMoneyGreen;
          end;
      except
      end;
    finally
      FillRect(Rect);
      TextOut(Rect.Left+Trunc((strgrdCalendar.ColWidths[ACol]-TextWidth(strgrdCalendar.Cells[ACol, ARow]))/2),Rect.Top+2,strgrdCalendar.Cells[ACol,ARow]);
    end;
  end;
end;

procedure TfrmHolidays.CreateHolidayArray;
var
  w: Integer;
begin
  with sqlqryQuery do begin
    Active := False;
    ParamByName('YEAR').AsString := sYear;
    Active := True;
    First;
    SetLength(arHolidays, 0);

    w := 0;

    strlstHolidays.Clear;

    while not(Eof) do begin
      SetLength(arHolidays, w+1);
      SetLength(arHolidays[w], 2);
      arHolidays[w, 0] := DayOf(Fields.Fields[0].AsDateTime);
      arHolidays[w, 1] := MonthOf(Fields.Fields[0].AsDateTime);
      inc(w);

      strlstHolidays.Add(IntToStr(DayOf(Fields.Fields[0].AsDateTime))+','+IntToStr(MonthOf(Fields.Fields[0].AsDateTime)));

      Next;
    end;
    Active := False;
  end;
end;

function TfrmHolidays.IsHoliday(_Day, _Month: Integer): Boolean;
//var
//  i: Integer;
begin
  result := strlstHolidays.IndexOf(IntToStr(_Day)+','+IntToStr(_Month)) <> -1;
  {
  result := False;
  for i:=0 to Length(arHolidays)-1 do
    if (arHolidays[i, 0]=_Day) and (arHolidays[i, 1]=_Month) then begin
      result := True;
      exit;
    end;
  }
end;

procedure TfrmHolidays.strgrdCalendarDblClick(Sender: TObject);
var
  strSQL: String;
begin
  try
    case IsHoliday(StrToInt(strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top]), strgrdCalendar.Selection.Top) of
      True: begin
        if Application.MessageBox(PChar('Вы действительно хотите удалить праздник '+strgrdCalendar.Cells[0, strgrdCalendar.Selection.Top]+', '+strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top]+' '+sYear+'г.?'), 'Удаление праздника', MB_YESNO)=ID_YES then begin
          strSQL := 'delete from qwerty.sp_zar_prazdn where dat_prazdn=to_date('''+ifThen(StrToInt(strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top])<10, '0'+strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top], strgrdCalendar.Cells[0, strgrdCalendar.Selection.Top])+'.'+ifThen(strgrdCalendar.Selection.Top<10, '0'+IntToStr(strgrdCalendar.Selection.Top), IntToStr(strgrdCalendar.Selection.Top))+'.'+sYear+''', ''dd.mm.yyyy'')';
          dmMain.sqlconDB.ExecuteDirect(strSQL);
        end;
      end;
      False: begin
        if Application.MessageBox(PChar('Вы действительно хотите добавить праздник '+strgrdCalendar.Cells[0, strgrdCalendar.Selection.Top]+', '+strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top]+' '+sYear+'г.?'), 'Добавление праздника', MB_YESNO)=ID_YES then begin
          strSQL := 'insert into qwerty.sp_zar_prazdn values(to_date('''+ifThen(StrToInt(strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top])<10, '0'+strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top], strgrdCalendar.Cells[strgrdCalendar.Selection.Left, strgrdCalendar.Selection.Top])+'.'+ifThen(strgrdCalendar.Selection.Top<10, '0'+IntToStr(strgrdCalendar.Selection.Top), IntToStr(strgrdCalendar.Selection.Top))+'.'+sYear+''', ''dd.mm.yyyy''))';
          dmMain.sqlconDB.ExecuteDirect(strSQL);
        end;
      end;
    end;
    cboxYearChange(Sender);
  except
  end;
end;

procedure TfrmHolidays.FormCreate(Sender: TObject);
begin
  clHoliday := RGB(255, 128, 128);
  sqlqryYears.Active := True;
  sqlqryYears.First;
  while not(sqlqryYears.Eof) do begin
    cboxYear.Items.Add(sqlqryYears.Fields.Fields[0].AsString);
    sqlqryYears.Next;
  end;
  cboxYear.Items.Add(IntToStr(StrToInt(cboxYear.Items.Strings[cboxYear.Items.Count-1])+1));
  sqlqryYears.Active := False;
  strlstHolidays := TStringList.Create;
end;

procedure TfrmHolidays.bitbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHolidays.CheckButtons;
begin
  spbtnNewYear.Down         := strlstHolidays.IndexOf('1,1') <> -1;
  spbtnChistmas.Down        := strlstHolidays.IndexOf('7,1') <> -1;
  spbtnMarch8.Down          := strlstHolidays.IndexOf('8,3') <> -1;
  spbtnEaster.Down          := strlstHolidays.IndexOf(sEasterDay+','+sEasterMonth) <> -1;
  spbtnTrinity.Down         := strlstHolidays.IndexOf(sTrinityDay+','+sTrinityMonth) <> -1;
  spbtnMay1.Down            := strlstHolidays.IndexOf('1,5') <> -1;
  spbtnMay2.Down            := strlstHolidays.IndexOf('2,5') <> -1;
  spbtnVictoryDay.Down      := strlstHolidays.IndexOf('9,5') <> -1;
  spbtnConstitutionDay.Down := strlstHolidays.IndexOf('28,6') <> -1;
  spbtnIndependenceDay.Down := strlstHolidays.IndexOf('24,8') <> -1;
  spbtnOctober14.Down       := strlstHolidays.IndexOf('14,10') <> -1;
end;

procedure TfrmHolidays.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  strlstHolidays.Clear;
  FreeAndNil(strlstHolidays);
end;

procedure TfrmHolidays.GetEaster(_Year: Integer);
var
  iDay, c, d: Integer;
  dTrinityDate: TDate;
begin
  sEasterMonth  := '0';
  sEasterDay    := '0';
  sTrinityMonth := '0';
  sTrinityDay   := '0';
  {Easter day
    if 4+c+d>30 then
      4+c+d-30 мая
    else
      4+c+d апреля

    c:
    Остаток от деления((Остаток от деления Года на 19)*19+15) на 30
    d:
    Остаток от деления(2*(Остаток от деления Года на 4)+4*(Остаток от деления года на 7)+6*c+6) на 7
  }
  //Calculate c
  c := ((_Year mod 19)*19+15) mod 30;

  //Calculate d
  d := (2*(_Year mod 4)+4*(_Year mod 7)+6*c+6) mod 7;
  iDay := 4+c+d;
  sEasterMonth  := ifThen(iDay<30, '4', '5');
  sEasterDay    := ifThen(iDay<30, IntToStr(iDay), IntToStr(iDay-30));
  dTrinityDate  := EncodeDate(_Year, ifThen(iDay<30, 4, 5), ifThen(iDay<30, iDay, iDay-30))+49;
  sTrinityMonth := IntToStr(MonthOf(dTrinityDate));
  sTrinityDay   := IntToStr(DayOf(dTrinityDate));
  spbtnEaster.Hint  := sEasterDay+','+sEasterMonth;
  spbtnTrinity.Hint := sTrinityDay+','+sTrinityMonth;
end;

procedure TfrmHolidays.spbtnNewYearClick(Sender: TObject);
var
  strSQL: String;
  iDay, iMonth, iCommaPos: Integer;
begin
  iCommaPos := Pos(',', TSpeedButton(Sender).Hint);
  iDay      := StrToInt(Copy(TSpeedButton(Sender).Hint, 1, iCommaPos-1));
  iMonth    := StrToInt(Copy(TSpeedButton(Sender).Hint, iCommaPos+1, 2));
  try
    case IsHoliday(iDay, iMonth) of
      True: begin
        if Application.MessageBox(PChar('Вы действительно хотите удалить праздник '+TSpeedButton(Sender).Caption+' в '+sYear+'г.?'), 'Удаление праздника', MB_YESNO)=ID_YES then begin
          strSQL := 'delete from qwerty.sp_zar_prazdn where dat_prazdn=to_date('''+Format('%.2d', [iDay])+'.'+Format('%.2d', [iMonth])+'.'+sYear+''', ''dd.mm.yyyy'')';
          dmMain.sqlconDB.ExecuteDirect(strSQL);
        end;
      end;
      False: begin
        if Application.MessageBox(PChar('Вы действительно хотите добавить праздник '+TSpeedButton(Sender).Caption+' в '+sYear+'г.?'), 'Добавление праздника', MB_YESNO)=ID_YES then begin
          strSQL := 'insert into qwerty.sp_zar_prazdn values(to_date('''+Format('%.2d', [iDay])+'.'+Format('%.2d', [iMonth])+'.'+sYear+''', ''dd.mm.yyyy''))';
          dmMain.sqlconDB.ExecuteDirect(strSQL);
        end;
      end;
    end;
    cboxYearChange(Sender);
  except
  end;
end;

procedure TfrmHolidays.cboxYearKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;  
end;

end.
