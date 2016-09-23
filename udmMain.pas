unit udmMain;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, DBConnect, Contnrs, Graphics, FMTBcd, IniFiles, Forms, Math, StrUtils;

type
  TdmMain = class(TDataModule)
    sqlconDB: TSQLConnection;
    sqlqryTemp: TSQLQuery;
    sqlqryTemp2: TSQLQuery;
    sqldsTemp: TSQLDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CancelPressed: Boolean;
  end;

  arrInt = array of Integer;

  recShift = record
    ShiftID, NameU, NameR: string;
  end;

  arrShift = array of recShift;

  TSchedule = class(TObject)
  private
    fTIP_SMEN: Integer;
    fNAME_U, fNAME_R, fCYCLE: string;
    fDAYS, fKOL_SMEN, fHOL_TYPE: Byte;
    fMarkIndexes: arrInt;
    //fMarkIndexes: TStringList;
    fShifts: arrShift;
    fEmployeeCount: Integer;
    fLastMonth: TDateTime;
    function GetMarkIndex(Index: Integer): Integer;
    procedure SetMarkIndex(Index: Integer; Value: Integer);
    function GetMarkIndexesCount: Integer;
    function GetShift(Index: Integer): recShift;
    procedure SetShift(Index: Integer; Value: recShift);
    function GetShiftsCount: Integer;
    function ScheduleAsString: string;
    function ScheduleAsStrings: string;
  protected
    function ScheduleAsStringSep(Separator: string): string;
  public
    property ScheduleType: Integer read fTIP_SMEN write fTIP_SMEN;
    property NameU: string read fNAME_U write fNAME_U;
    property NameR: string read fNAME_R write fNAME_R;
    property Cycle: string read fCYCLE write fCYCLE;
    property NumOfDays: Byte read fDAYS write fDAYS;
    property NumOfShifts: Byte read fKOL_SMEN write fKOL_SMEN;
    property HollidayType: Byte read fHOL_TYPE write fHOL_TYPE;
    property MarkIndexes[Index: Integer]: Integer read GetMarkIndex write SetMarkIndex;
    property MarkIndexesCount: Integer read GetMarkIndexesCount;
    property Shifts[Index: Integer]: recShift read GetShift write SetShift;
    property ShiftsCount: Integer read GetShiftsCount;
    property EmployeeCount: Integer read fEmployeeCount write fEmployeeCount;
    property LastMonth: TDateTime read fLastMonth write fLastMonth;
    property AsString: string read ScheduleAsString;
    property AsStrings: string read ScheduleAsStrings;

    function GetShiftIDByNameU(_NameU: string): string;
    function SaveToDB(SQLQuery: TSQLQuery): Boolean;
    function RefreshMarkIndexes(SQLQuery: TSQLQuery): Boolean;
    constructor Create; overload;//override;
    constructor Create(FromSchedule: TSchedule); overload;
    //destructor Destroy; override;
  published
  end;

  TMark = class(TObject)
  private
    fID_OTMETKA, fOPIS, fT_BEGIN, fT_END: string;
    fTIME_WORK, fTIME_N, fTIME_V: Currency;
    fID_VID, fOBED: Integer;
    fDAY_WORK: Byte;
    fColor: TColor;
    fDisplayMark: string;
    fOtNeProp: Boolean;
    function GetLunchTimeH: Currency;
    function GetWorkTimeStr: string;
    function MarkAsString: string;
    function MarkAsStrings: string;
  protected
    function MarkAsStringSep(Separator: string): string;
  public
    property MarkID: string read fID_OTMETKA write fID_OTMETKA;
    property WorkTime: Currency read fTIME_WORK write fTIME_WORK;
    property VidID: Integer read fID_VID write fID_VID;
    property WorkDays: Byte read fDAY_WORK write fDAY_WORK;
    property NightTime: Currency read fTIME_N write fTIME_N;
    property EveningTime: Currency read fTIME_V write fTIME_V;
    property Description: string read fOPIS write fOPIS;
    property StartTime: string read fT_BEGIN write fT_BEGIN;
    property FinishTime: string read fT_END write fT_END;
    property LunchTime: Integer read fOBED write fOBED;
    property LunchTimeH: Currency read GetLunchTimeH;
    property WorkTimeStr: string read GetWorkTimeStr;
    property Color: TColor read fColor write fColor;
    property DisplayMark: string read fDisplayMark write fDisplayMark;
    property OtNeProp: Boolean read fOtNeProp write fOtNeProp;
    property AsString: string read MarkAsString;
    property AsStrings: string read MarkAsStrings;
    constructor Create; //override;
    //destructor Destroy; override;

  published
  end;

  ApplicationConfiguration = record
    ColoredMode: Boolean;
    ShowMarkTime: Boolean;
    ScheduleListStyle: Byte; //0-vsIcon, 1-vsList, 2-vsReport, 3-vsSmallIcon
    ScheduleListSortByName: Boolean;
    ScheduleListSortByDescription: Boolean;
    ScheduleListSortByCycle: Boolean;
    ScheduleListSortByNumOfEmps: Boolean;
    ScheduleListSortByLastMonth: Boolean;
    ScheduleListReverseSort: Boolean;
    ScheduleListSort2ByName: Boolean;
    ScheduleListSort2ByDescription: Boolean;
    ScheduleListSort2ByCycle: Boolean;
    ScheduleListSort2ByNumOfEmps: Boolean;
    ScheduleListSort2ByLastMonth: Boolean;
    ScheduleListReverseSort2: Boolean;
  end;

procedure SetCurYear(newCurYear: Integer); overload;

procedure SetCurYear(newCurYear: string); overload;

function CreateMarkList(SQLQuery: TSQLQuery): Boolean;

function RefreshMarkList(SQLQuery: TSQLQuery): Boolean;

function CreateScheduleList(SQLQuery, SQLQuery2: TSQLQuery): Boolean;

function RefreshScheduleList(SQLQuery, SQLQuery2: TSQLQuery): Boolean;

function GetMarkIndexByID(_MarkID: string): Integer;

function GetScheduleIndexByNameU(_NameU: string): Integer;

function GetScheduleIndexByNameR(_NameR: string): Integer;

function GetScheduleIndexByType(_ScheduleType: Integer): Integer;

function GetScheduleIndexByShiftID(_ShiftID: string): Integer;

function GetYears: TStrings; overload;

function GetYears(ScheduleType: Integer): TStrings; overload;

function GetDefaultYear: string;

function SaveDefaultYear: Boolean;

function RestoreConfiguration: Boolean;

function SaveConfiguration: Boolean;

function SaveMarkInfo: Boolean;

function MarkUse(MarkID: string): string; //Возвращает перечень графиков, которые используют данную отметку

var
  dmMain: TdmMain;
  myDBConnection: TDBConnection;
  oblstMarkList, oblstScheduleList: TObjectList;
  iCurYear: Integer;
  sCurYear: string;
  setMonths: array[1..12] of string;
  setDaysOfWeek: array[1..7] of string;
  MarksChanged, SchedulesChanged: Boolean;
  AppConfig: ApplicationConfiguration;

implementation

uses
  uMain;

{$R *.dfm}

procedure SetCurYear(newCurYear: Integer);
begin
  iCurYear := newCurYear;
  sCurYear := IntToStr(newCurYear);
end;

procedure SetCurYear(newCurYear: string);
begin
  try
    iCurYear := StrToInt(newCurYear);
    sCurYear := newCurYear;

//    raise Exception.Create('Год изменен');
  except
//    on e: Exception do
//    if e.Message='Год изменен' then begin
//      raise;
//    end;
  end;
end;

function CreateMarkList(SQLQuery: TSQLQuery): Boolean;
var
  sSQL: string;
  newMark: TMark;
  iniFile: TIniFile;
  iniFileExist: Boolean;
begin
  result := False;
  if FileExists(ExtractFileDir(Application.ExeName) + '\config\marks.ini') then begin
    iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\config\marks.ini');
    iniFileExist := True;
  end
  else begin
    iniFile := nil;
    iniFileExist := False;
  end;
  try
    sSQL := 'select pr.*, 1 FLAG from QWERTY.SP_ZAR_OT_PROP pr union select ID_OTMETKA, 0, ID_VID, 0, 0, 0, OPIS, '''', '''', 0, 0 FLAG from QWERTY.SP_ZAR_OTNE_PROP';
    SQLQuery.SQL.Add(sSQL);
    SQLQuery.Active := True;
    while not (SQLQuery.Eof) do begin
      newMark := TMark.Create;
      with newMark, SQLQuery do begin
        MarkID := FieldByName('ID_OTMETKA').AsString;
        WorkTime := FieldByName('TIME_WORK').AsFloat {* 100) / 100}; //округляем до 2-х знаков после запятой (были проблемы со значением 8.2) 15.10.2010 13:38
        VidID := FieldByName('ID_VID').AsInteger;
        WorkDays := FieldByName('DAY_WORK').AsInteger;
        NightTime := FieldByName('TIME_N').AsFloat;
        EveningTime := FieldByName('TIME_V').AsFloat;
        Description := FieldByName('OPIS').AsString;
        StartTime := FieldByName('T_BEGIN').AsString;
        FinishTime := FieldByName('T_END').AsString;
        LunchTime := FieldByName('OBED').AsInteger;

        if iniFileExist then begin
          Color := iniFile.ReadInteger('"' + MarkID + '"', 'Color', clMoneyGreen);
          DisplayMark := iniFile.ReadString('"' + MarkID + '"', 'DisplayMark', MarkID);
        end
        else begin
          Color := clMoneyGreen;
          DisplayMark := MarkID;
        end;
        OtNeProp := FieldByName('FLAG').AsInteger = 0;
        Next;
      end;
      oblstMarkList.Add(newMark);
    end;
  except
    result := False;
  end;
  if Assigned(iniFile) then
    iniFile.Free;
  SQLQuery.Active := False;
end;

function CreateScheduleList(SQLQuery, SQLQuery2: TSQLQuery): Boolean;
var
  sSQL: string;
  newSchedule: TSchedule;
  newShift: recShift;
begin
  result := False;
  try
    //Увеличиваем информативность запроса, добавляем данные о работниках на графике, и о последнем месяце использования графика
    //sSQL := 'select * from QWERTY.SP_ZAR_T_SMEN order by NAME_U';

    sSQL := 'select tsm.*, nvl(b.employee_cnt, 0) employee_cnt, c.last_schedule_date';
    sSQL := sSQL + ' from QWERTY.SP_ZAR_T_SMEN tsm,';
    sSQL := sSQL + ' (select ssm.tip_smen, count(sw.id_tab) employee_cnt';
    sSQL := sSQL + ' from qwerty.sp_zar_s_smen ssm, qwerty.sp_zar_swork sw';
    sSQL := sSQL + ' where ssm.id_smen = sw.smena';
    sSQL := sSQL + ' group by tip_smen) b,';
    sSQL := sSQL + ' (select tip_smen, max(data_graf) last_schedule_date';
    sSQL := sSQL + ' from QWERTY.SP_ZAR_GRAFIK t';
    sSQL := sSQL + ' group by tip_smen) c';
    sSQL := sSQL + ' where tsm.tip_smen = b.tip_smen(+)';
    sSQL := sSQL + ' and tsm.tip_smen = c.tip_smen(+)';
    //sSQL := sSQL + ' order by tsm.NAME_U';
    sSQL := sSQL + ' order by tsm.tip_smen';
    //sSQL := sSQL + ' to_number(nvl(translate(tsm.NAME_U,''1234567890-/.(): №АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя'',''1234567890,,''),tsm.tip_smen))';

    {
    sSQL :=        'SELECT tsm.*';
    sSQL := sSQL + '      ,nvl(b.employee_cnt';
    sSQL := sSQL + '          ,0) employee_cnt';
    sSQL := sSQL + '      ,c.last_schedule_date';
    sSQL := sSQL + '  FROM QWERTY.SP_ZAR_T_SMEN tsm';
    sSQL := sSQL + '      ,(SELECT ssm.tip_smen';
    sSQL := sSQL + '              ,COUNT(sw.id_tab) employee_cnt';
    sSQL := sSQL + '          FROM qwerty.sp_zar_s_smen ssm';
    sSQL := sSQL + '              ,qwerty.sp_zar_swork  sw';
    sSQL := sSQL + '         WHERE ssm.id_smen = sw.smena';
    sSQL := sSQL + '         GROUP BY tip_smen) b';
    sSQL := sSQL + '      ,(SELECT tip_smen';
    sSQL := sSQL + '              ,MAX(data_graf) last_schedule_date';
    sSQL := sSQL + '          FROM QWERTY.SP_ZAR_GRAFIK t';
    sSQL := sSQL + '         GROUP BY tip_smen) c';
    sSQL := sSQL + ' WHERE tsm.tip_smen = b.tip_smen(+)';
    sSQL := sSQL + '   AND tsm.tip_smen = c.tip_smen(+)';
    sSQL := sSQL + ' ORDER BY to_number(nvl(translate(NAME_U';
    sSQL := sSQL + '                                 ,''1234567890-/.(): №АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя''';
    sSQL := sSQL + '                                 ,''1234567890,,'')';
    sSQL := sSQL + '                       ,tsm.tip_smen))';
    }


    SQLQuery.Active := False;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add(sSQL);
    {
    SQLQuery.SQL.Add('SELECT tsm.*');
    SQLQuery.SQL.Add('      ,nvl(b.employee_cnt');
    SQLQuery.SQL.Add('          ,0) employee_cnt');
    SQLQuery.SQL.Add('      ,c.last_schedule_date');
    SQLQuery.SQL.Add('  FROM QWERTY.SP_ZAR_T_SMEN tsm');
    SQLQuery.SQL.Add('      ,(SELECT ssm.tip_smen');
    SQLQuery.SQL.Add('              ,COUNT(sw.id_tab) employee_cnt');
    SQLQuery.SQL.Add('          FROM qwerty.sp_zar_s_smen ssm');
    SQLQuery.SQL.Add('              ,qwerty.sp_zar_swork  sw');
    SQLQuery.SQL.Add('         WHERE ssm.id_smen = sw.smena');
    SQLQuery.SQL.Add('         GROUP BY tip_smen) b');
    SQLQuery.SQL.Add('      ,(SELECT tip_smen');
    SQLQuery.SQL.Add('              ,MAX(data_graf) last_schedule_date');
    SQLQuery.SQL.Add('          FROM QWERTY.SP_ZAR_GRAFIK t');
    SQLQuery.SQL.Add('         GROUP BY tip_smen) c');
    SQLQuery.SQL.Add(' WHERE tsm.tip_smen = b.tip_smen(+)');
    SQLQuery.SQL.Add('   AND tsm.tip_smen = c.tip_smen(+)');
    SQLQuery.SQL.Add(' ORDER BY nvl(to_number(translate(tsm.NAME_U');
    SQLQuery.SQL.Add('                                 ,''1234567890-/.(): №АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя''');
    SQLQuery.SQL.Add('                                 ,''1234567890,,'')), 100) + tsm.tip_smen/1000');
    //SQLQuery.SQL.Add('                       ,tsm.tip_smen)');
    }
    SQLQuery.Active := True;
    while not (SQLQuery.Eof) do begin
      newSchedule := TSchedule.Create;
      with newSchedule, SQLQuery do begin
        ScheduleType := FieldByName('TIP_SMEN').AsInteger;
        NameU := FieldByName('NAME_U').AsString;
        NameR := FieldByName('NAME_R').AsString;
        Cycle := FieldByName('CYCLE').AsString;
        NumOfDays := FieldByName('DAYS').AsInteger;
        NumOfShifts := FieldByName('KOL_SMEN').AsInteger;
        HollidayType := FieldByName('HOL_TYPE').AsInteger;

        EmployeeCount := FieldByName('EMPLOYEE_CNT').AsInteger;
        LastMonth := FieldByName('LAST_SCHEDULE_DATE').AsDateTime;

        //Создаём список отметок графика
        SQLQuery2.Active := False;
        SQLQuery2.SQL.Clear;
        SQLQuery2.SQL.Add('select distinct id_otmetka from QWERTY.SP_ZAR_TABL_SMEN');
        SQLQuery2.sql.Add('where id_smen in (select id_smen from QWERTY.SP_ZAR_S_SMEN where tip_smen=' + IntToStr(newSchedule.ScheduleType) + ')');
        SQLQuery2.Active := True;
        while not (SQLQuery2.Eof) do begin
          MarkIndexes[-1] := GetMarkIndexByID(SQLQuery2.Fields.Fields[0].AsString);
          SQLQuery2.Next;
        end;
        SQLQuery2.Active := False;

        SQLQuery2.SQL.Clear;
        SQLQuery2.SQL.Add('select id_smen, name_u, name_r from QWERTY.SP_ZAR_S_SMEN where tip_smen=' + IntToStr(ScheduleType) + ' order by id_smen');
        SQLQuery2.Active := True;
        while not (SQLQuery2.Eof) do begin
          newShift.ShiftID := SQLQuery2.FieldByName('ID_SMEN').AsString;
          newShift.NameU := SQLQuery2.FieldByName('NAME_U').AsString;
          newShift.NameR := SQLQuery2.FieldByName('NAME_R').AsString;
          Shifts[-1] := newShift;
          SQLQuery2.Next;
        end;
        SQLQuery2.Active := False;

        Next;
      end;
      oblstScheduleList.Add(newSchedule);
    end;
  except
    //result := False;
    on E: Exception do begin
      result := False;
      Application.MessageBox(PChar(E.Message + ' (' + IntToStr(E.HelpContext) + ')'), 'Ошибка в программе', );
    end;
  end;
  SQLQuery.Active := False;
end;

function GetMarkIndexByID(_MarkID: string): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to oblstMarkList.Count - 1 do begin
    if TMark(oblstMarkList.Items[i]).MarkID = _MarkID then begin
      result := i;
      exit;
    end;
  end;
end;

function GetScheduleIndexByNameU(_NameU: string): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to oblstScheduleList.Count - 1 do begin
    if TSchedule(oblstScheduleList.Items[i]).NameU = _NameU then begin
      result := i;
      exit;
    end;
  end;
end;

function GetScheduleIndexByNameR(_NameR: string): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to oblstScheduleList.Count - 1 do begin
    if TSchedule(oblstScheduleList.Items[i]).NameR = _NameR then begin
      result := i;
      exit;
    end;
  end;
end;

function GetScheduleIndexByType(_ScheduleType: Integer): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to oblstScheduleList.Count - 1 do begin
    if TSchedule(oblstScheduleList.Items[i]).ScheduleType = _ScheduleType then begin
      result := i;
      exit;
    end;
  end;
end;

function GetScheduleIndexByShiftID(_ShiftID: string): Integer;
var
  i, j: Integer;
begin
  Result := -1;
  for i := 0 to oblstScheduleList.Count - 1 do begin
    for j := 0 to TSchedule(oblstScheduleList.Items[i]).ShiftsCount - 1 do begin
      if TSchedule(oblstScheduleList.Items[i]).Shifts[j].ShiftID = _ShiftID then   begin
        Result := i;
        exit;
      end;
    end;
  end;
end;

function GetYears: TStrings;
begin
  result := nil;
  with dmMain.sqlqryTemp do begin
    Active := False;
    SQL.Clear;
    SQL.Add('select distinct to_char(data_graf, ''yyyy'') from QWERTY.SP_ZAR_GRAFIK order by 1');
    Active := True;
    if not (Eof) then
      result := TStringList.Create;
    while not (Eof) do begin
      result.Add(Fields.Fields[0].AsString);
      Next;
    end;
    Active := False;
  end;
end;

function GetYears(ScheduleType: Integer): TStrings;
begin
  result := nil;
  with dmMain.sqlqryTemp do begin
    Active := False;
    SQL.Clear;
    SQL.Add('select distinct to_char(data_graf, ''yyyy'') from QWERTY.SP_ZAR_GRAFIK where tip_smen=' + IntToStr(ScheduleType) + ' order by 1');
    Active := True;
    if not (Eof) then
      result := TStringList.Create;
    while not (Eof) do begin
      result.Add(Fields.Fields[0].AsString);
      Next;
    end;
    Active := False;
  end;
end;

function GetDefaultYear: string;
var
  iniFile: TIniFile;
  _Year, _Month, _Day: Word;
begin
  DecodeDate(Date, _Year, _Month, _Day);
  result := IntToStr(_Year);
  if FileExists(ExtractFileDir(Application.ExeName) + '\config\config.ini') then begin
    iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\config\config.ini');
    result := iniFile.ReadString('Default', 'Year', result);
    iniFile.Free;
  end;
end;

function SaveDefaultYear: Boolean;
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\config\config.ini');
  try
    iniFile.WriteString('Default', 'Year', sCurYear);
    iniFile.Free;
    result := True;
  except
    result := False;
  end;
end;

function RestoreConfiguration: Boolean;
var
  iniFile: TIniFile;
begin
  result := False;
  if FileExists(ExtractFileDir(Application.ExeName) + '\config\config.ini') then begin
    iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\config\config.ini');
    try
      try
        AppConfig.ColoredMode := iniFile.ReadBool('Default', 'ColoredMode', False);
      except
      end;
      try
        AppConfig.ShowMarkTime := iniFile.ReadBool('Default', 'ShowMarkTime', False);
      except
      end;
      try
        AppConfig.ScheduleListStyle := iniFile.ReadInteger('Default', 'ScheduleListStyle', 0);
      except
      end;
      try
        AppConfig.ScheduleListSortByName := iniFile.ReadBool('Default', 'ScheduleListSortByName', False);
      except
      end;
      try
        AppConfig.ScheduleListSortByDescription := iniFile.ReadBool('Default', 'ScheduleListSortByDescription', False);
      except
      end;
      try
        AppConfig.ScheduleListSortByCycle := iniFile.ReadBool('Default', 'ScheduleListSortByCycle', False);
      except
      end;
      try
        AppConfig.ScheduleListSortByNumOfEmps := iniFile.ReadBool('Default', 'ScheduleListSortByNumOfEmps', False);
      except
      end;
      try
        AppConfig.ScheduleListSortByLastMonth := iniFile.ReadBool('Default', 'ScheduleListSortByLastMonth', False);
      except
      end;
      try
        AppConfig.ScheduleListReverseSort := iniFile.ReadBool('Default', 'ScheduleListReverseSort', False);
      except
      end;
      try
        AppConfig.ScheduleListSort2ByName := iniFile.ReadBool('Default', 'ScheduleListSort2ByName', False);
      except
      end;
      try
        AppConfig.ScheduleListSort2ByDescription := iniFile.ReadBool('Default', 'ScheduleListSort2ByDescription', False);
      except
      end;
      try
        AppConfig.ScheduleListSort2ByCycle := iniFile.ReadBool('Default', 'ScheduleListSort2ByCycle', False);
      except
      end;
      try
        AppConfig.ScheduleListSort2ByNumOfEmps := iniFile.ReadBool('Default', 'ScheduleListSort2ByNumOfEmps', False);
      except
      end;
      try
        AppConfig.ScheduleListSort2ByLastMonth := iniFile.ReadBool('Default', 'ScheduleListSort2ByLastMonth', False);
      except
      end;
      try
        AppConfig.ScheduleListReverseSort2 := iniFile.ReadBool('Default', 'ScheduleListReverseSort2', False);
      except
      end;
    finally
      iniFile.Free;
    end;
  end;
end;

function SaveConfiguration: Boolean;
var
  iniFile: TIniFile;
begin
  result := False;

  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\config\config.ini');
  try
    with AppConfig do begin
      iniFile.WriteBool('Default', 'ColoredMode', ColoredMode);
      iniFile.WriteBool('Default', 'ShowMarkTime', ShowMarkTime);
      iniFile.WriteInteger('Default', 'ScheduleListStyle', ScheduleListStyle);
      iniFile.WriteBool('Default', 'ScheduleListSortByName', ScheduleListSortByName);
      iniFile.WriteBool('Default', 'ScheduleListSortByDescription', ScheduleListSortByDescription);
      iniFile.WriteBool('Default', 'ScheduleListSortByCycle', ScheduleListSortByCycle);
      iniFile.WriteBool('Default', 'ScheduleListSortByNumOfEmps', ScheduleListSortByNumOfEmps);
      iniFile.WriteBool('Default', 'ScheduleListSortByLastMonth', ScheduleListSortByLastMonth);
      iniFile.WriteBool('Default', 'ScheduleListReverseSort', ScheduleListReverseSort);
      iniFile.WriteBool('Default', 'ScheduleListSort2ByName', ScheduleListSort2ByName);
      iniFile.WriteBool('Default', 'ScheduleListSort2ByDescription', ScheduleListSort2ByDescription);
      iniFile.WriteBool('Default', 'ScheduleListSort2ByCycle', ScheduleListSort2ByCycle);
      iniFile.WriteBool('Default', 'ScheduleListSort2ByNumOfEmps', ScheduleListSort2ByNumOfEmps);
      iniFile.WriteBool('Default', 'ScheduleListSort2ByLastMonth', ScheduleListSort2ByLastMonth);
      iniFile.WriteBool('Default', 'ScheduleListReverseSort2', ScheduleListReverseSort2);
    end;

    result := True;
  finally
    iniFile.Free;
  end;
end;

function SaveMarkInfo: Boolean;
var
  iniFile: TIniFile;
  i: Integer;
  mMark: TMark;
begin
  Result := False;

  iniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\config\marks.ini');
  for i := 0 to oblstMarkList.Count - 1 do begin
    mMark := TMark(oblstMarkList.Items[i]);
    iniFile.WriteInteger('"' + mMark.MarkID + '"', 'Color', mMark.Color);
    iniFile.WriteString('"' + mMark.MarkID + '"', 'DisplayMark', mMark.DisplayMark);
  end;
  iniFile.Free;

  Result := True;
end;

function MarkUse(MarkID: string): string;
begin
  Result := '';

  dmMain.sqlqryTemp.Active := False;
  dmMain.sqlqryTemp.SQL.Clear;
  dmMain.sqlqryTemp.SQL.Text := 'SELECT mark_id' + #13#10 +
                                '      ,schedule_id' + #13#10 +
                                '      ,schedule_name' + #13#10 +
                                '      ,schedule_name || '' (смен'' || decode(LEVEL' + #13#10 +
                                '                                          ,1' + #13#10 +
                                '                                          ,''а ''' + #13#10 +
                                '                                          ,''ы '') || ltrim(sys_connect_by_path(shift_id' + #13#10 +
                                '                                                                             ,'', '')' + #13#10 +
                                '                                                         ,'', '') || '')'' shifts' + #13#10 +
                                '  FROM (SELECT tbls.id_otmetka mark_id' + #13#10 +
                                '              ,tbls.id_smen shift_id' + #13#10 +
                                '              ,ss.name_u shift_name' + #13#10 +
                                '              ,ss.tip_smen schedule_id' + #13#10 +
                                '              ,ts.name_u schedule_name' + #13#10 +
                                '              ,lag(ss.id_smen) over(PARTITION BY ss.tip_smen ORDER BY ss.id_smen) prev_shift_id' + #13#10 +
                                '              ,lead(ss.id_smen) over(PARTITION BY ss.tip_smen ORDER BY ss.id_smen) next_shift_id' + #13#10 +
                                '          FROM qwerty.sp_zar_tabl_smen tbls' + #13#10 +
                                '              ,qwerty.sp_zar_s_smen    ss' + #13#10 +
                                '              ,qwerty.sp_zar_t_smen    ts' + #13#10 +
                                '         WHERE tbls.id_otmetka = ''' + MarkID + '''' + #13#10 +
                                '           AND tbls.id_smen = ss.id_smen' + #13#10 +
                                '           AND ss.tip_smen = ts.tip_smen' + #13#10 +
                                '        UNION ALL' + #13#10 +
                                '        SELECT id_otmetka' + #13#10 +
                                '              ,''-''' + #13#10 +
                                '              ,''тип '' || tip' + #13#10 +
                                '              ,-1' + #13#10 +
                                '              ,''отметка неявки: '' || opis' + #13#10 +
                                '              ,NULL' + #13#10 +
                                '              ,NULL' + #13#10 +
                                '          FROM qwerty.sp_zar_otne_prop' + #13#10 +
                                '         WHERE id_otmetka = ''' + MarkID + ''')' + #13#10 +
                                ' WHERE next_shift_id IS NULL' + #13#10 +
                                'CONNECT BY PRIOR schedule_id = schedule_id' + #13#10 +
                                '       AND PRIOR shift_id = prev_shift_id' + #13#10 +
                                ' START WITH prev_shift_id IS NULL';
  dmMain.sqlqryTemp.Active := True;
  while not (dmMain.sqlqryTemp.Eof) do begin
    Result := Result + IfThen(Result = '', '', '; ') + dmMain.sqlqryTemp.FieldByName('SCHEDULE_NAME').AsString; //dmMain.sqlqryTemp.FieldByName('SHIFTS').AsString;
    dmMain.sqlqryTemp.Next;
  end;
  dmMain.sqlqryTemp.Active := False;
  dmMain.sqlqryTemp.SQL.Clear;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
var
  bBadName: Boolean;
begin
  CancelPressed := False;
  RestoreConfiguration;

  oblstMarkList := TObjectList.Create;
  oblstScheduleList := TObjectList.Create;
  MarksChanged := False;
  SchedulesChanged := False;

  myDBConnection := TDBConnection.Create(sqlconDB{, 'Odessa Port Plant\OASU\SHIFT4'});
  myDBConnection.RestoreConnections;
  bBadName := False;
  repeat
  try
    bBadName := False;
    myDBConnection.SQLConnection.Connected := True;
    case myDBConnection.SQLConnection.ConnectionState of
      csStateClosed:
        begin
          CancelPressed := True;
        end;
    else
      begin
      end;
    end;
  except
    on e: EDatabaseError do begin
      if myDBConnection.LoginCanceledByUser then begin
        CancelPressed := True;
        exit;
      end;
      if Pos('ORA-01017', e.Message) = 1 then begin
        bBadName := True;
        Application.MessageBox(PChar('Неверное имя пользователя или пароль' + #10#13 + e.Message), 'Ошибка при подключении к БД ORACLE');
      end
      else begin
        bBadName := True;
        Application.MessageBox(PChar('Произошла ошибка при подключении к БД:' + #10#13 + e.Message), 'Ошибка при подключении к БД ORACLE');
      end;
    end;
  end;
  until not (bBadName) or CancelPressed;
  if CancelPressed then
    Exit;

  CreateMarkList(sqlqryTemp);
  CreateScheduleList(sqlqryTemp, sqlqryTemp2);

  setMonths[1] := 'Январь';
  setMonths[2] := 'Февраль';
  setMonths[3] := 'Март';
  setMonths[4] := 'Апрель';
  setMonths[5] := 'Май';
  setMonths[6] := 'Июнь';
  setMonths[7] := 'Июль';
  setMonths[8] := 'Август';
  setMonths[9] := 'Сентябрь';
  setMonths[10] := 'Октябрь';
  setMonths[11] := 'Ноябрь';
  setMonths[12] := 'Декабрь';

  setDaysOfWeek[1] := 'Пн';
  setDaysOfWeek[2] := 'Вт';
  setDaysOfWeek[3] := 'Ср';
  setDaysOfWeek[4] := 'Чт';
  setDaysOfWeek[5] := 'Пт';
  setDaysOfWeek[6] := 'Сб';
  setDaysOfWeek[7] := 'Вс';

  SetCurYear(GetDefaultYear);
end;

{ TSchedule }

constructor TSchedule.Create;
begin
  inherited;
  SetLength(self.fMarkIndexes, 0);
  //self.fMarkIndexes := TStringList.Create;
end;

constructor TSchedule.Create(FromSchedule: TSchedule);
var
  i: Integer;
begin
  Self.Create;

  Self.ScheduleType := FromSchedule.ScheduleType;
  Self.NameU := FromSchedule.NameU;
  Self.NameR := FromSchedule.NameR;
  Self.Cycle := FromSchedule.Cycle;
  Self.NumOfDays := FromSchedule.NumOfDays;
  Self.NumOfShifts := FromSchedule.NumOfShifts;
  Self.HollidayType := FromSchedule.HollidayType;
  //MarkIndexes
  SetLength(Self.fMarkIndexes, FromSchedule.MarkIndexesCount);
  for i := 0 to FromSchedule.MarkIndexesCount - 1 do begin
    Self.MarkIndexes[i] := FromSchedule.MarkIndexes[i];
  end;
  //Shifts
  SetLength(Self.fShifts, FromSchedule.ShiftsCount);
  for i := 0 to FromSchedule.ShiftsCount - 1 do begin
    Self.Shifts[i] := FromSchedule.Shifts[i];
  end;
  Self.EmployeeCount := FromSchedule.EmployeeCount;
  Self.LastMonth := FromSchedule.LastMonth;
end;

function TSchedule.GetMarkIndex(Index: Integer): Integer;
begin
  result := fMarkIndexes[Index];
  //result := StrToInt(fMarkIndexes.Strings[Index]);
end;

function TSchedule.GetMarkIndexesCount: Integer;
begin
  try
    result := Length(self.fMarkIndexes);
    //result := self.fMarkIndexes.Count;
  except
    result := 0;
  end;
end;

function TSchedule.GetShift(Index: Integer): recShift;
begin
  result := fShifts[Index];
end;

function TSchedule.GetShiftIDByNameU(_NameU: string): string;
var
  i: Integer;
begin
  result := '';
  for i := 0 to Length(self.fShifts) - 1 do
    if self.Shifts[i].NameU = _NameU then
      result := self.Shifts[i].ShiftID;
end;

function TSchedule.GetShiftsCount: Integer;
begin
  try
    result := Length(fShifts);
  except
    result := 0;
  end;
end;

function TSchedule.RefreshMarkIndexes(SQLQuery: TSQLQuery): Boolean;
begin
  Result := False;

  SQLQuery.Active := False;
  SetLength(self.fMarkIndexes, 0);
  SQLQuery.SQL.Clear;
  SQLQuery.SQL.Add('select distinct id_otmetka from QWERTY.SP_ZAR_TABL_SMEN');
  SQLQuery.sql.Add('where id_smen in (select id_smen from QWERTY.SP_ZAR_S_SMEN where tip_smen=' + IntToStr(Self.ScheduleType) + ')');
  SQLQuery.Active := True;
  while not (SQLQuery.Eof) do begin
    MarkIndexes[-1] := GetMarkIndexByID(SQLQuery.Fields.Fields[0].AsString);
    SQLQuery.Next;
  end;
  SQLQuery.Active := False;

  Result := True;
end;

function TSchedule.SaveToDB(SQLQuery: TSQLQuery): Boolean;
begin
  Result := False;

  SQLQuery.Active := False;
  SQLQuery.SQL.Clear;
  SQLQuery.SQL.Add('insert into QWERTY.SP_ZAR_T_SMEN(TIP_SMEN, NAME_U, NAME_R, CYCLE, DAYS, KOL_SMEN, HOL_TYPE)');
  SQLQuery.SQL.Add('values (' + IntToStr(self.ScheduleType) + ', ''' + self.NameU + ''', ''' + self.NameR + ''', ''' + self.Cycle + ''', ');
  SQLQuery.SQL.Add(IntToStr(self.NumOfDays) + ', ' + IntToStr(self.NumOfShifts) + ', ' + IntToStr(self.HollidayType) + ')');

  Result := True;
end;

function TSchedule.ScheduleAsString: string;
begin
  Result := Self.ScheduleAsStringSep('; ');
end;

function TSchedule.ScheduleAsStrings: string;
begin
  Result := Self.ScheduleAsStringSep(#10#13);
end;

function TSchedule.ScheduleAsStringSep(Separator: string): string;
var
  s: string;
  i: Integer;
begin
  if Separator = '' then
    Separator := '; ';

  s := 'График: ''' + IntToStr(Self.ScheduleType) + '''' + Separator;
  s := 'Название: ' + IfThen(Self.NameU = Self.NameR, Self.NameU, Self.NameU + ' (' + Self.NameR + ')') + Separator;
  s := s + 'Смены: ';
  for i := 0 to Self.ShiftsCount - 1 do begin
    if i > 0 then
      s := s + ', ';
    s := s + IfThen(Self.Shifts[i].NameU = Self.Shifts[i].NameR, Self.Shifts[i].NameU + ' [' + Self.Shifts[i].ShiftID + ']', Self.Shifts[i].NameU + ' (' + Self.Shifts[i].NameR + ') [' + Self.Shifts[i].ShiftID + ']');
  end;
  s := s + Separator;
  s := s + 'Используемые отметки: ';
  for i := 0 to Self.MarkIndexesCount - 1 do
    if i = 0 then
      s := s + TMark(oblstMarkList.Items[Self.GetMarkIndex(i)]).MarkID
    else
      s := s + ', ' + TMark(oblstMarkList.Items[Self.GetMarkIndex(i)]).MarkID;

  Result := s;
end;

procedure TSchedule.SetMarkIndex(Index, Value: Integer);
var
  i: Integer;
begin          { TODO 2 : Разобраться с удалением отметки из списка отметок смены }
  if Value = -999 then begin  //Удаление отметки из списка
    for i := Index to Length(fMarkIndexes) - 2 do
      fMarkIndexes[i] := fMarkIndexes[i + 1];

    SetLength(fMarkIndexes, Length(fMarkIndexes) - 1);
    exit;
  end;

  if Index = -1 then begin //Добавление новой отметки в список
    SetLength(fMarkIndexes, Length(fMarkIndexes) + 1);
    Index := Length(fMarkIndexes) - 1;
  end;
  fMarkIndexes[Index] := Value;

{
  if Index=-1 then
    self.fMarkIndexes.Add(IntToStr(Value))
  else
    self.fMarkIndexes.Strings[Index] := IntToStr(Value);
}
end;

procedure TSchedule.SetShift(Index: Integer; Value: recShift);
begin
  if Index = -1 then begin
    SetLength(fShifts, Length(fShifts) + 1);
    Index := Length(fShifts) - 1;
  end;
  fShifts[Index] := Value;
end;

{ TMark }

constructor TMark.Create;
begin
  inherited;

end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  if MarksChanged then begin
    SaveMarkInfo;
  end;

  oblstMarkList.Clear;
  oblstMarkList.Free;
  oblstScheduleList.Clear;
  oblstScheduleList.Free;
end;

function RefreshMarkList(SQLQuery: TSQLQuery): Boolean;
begin
  Result := False;

  oblstMarkList.Clear;
  oblstMarkList.Free;
  CreateMarkList(SQLQuery);

  Result := True;
end;

function RefreshScheduleList(SQLQuery, SQLQuery2: TSQLQuery): Boolean;
begin
  Result := False;

  oblstScheduleList.Clear;
  //oblstScheduleList.Free;
  CreateScheduleList(SQLQuery, SQLQuery2);

  Result := True;
end;

function TMark.GetLunchTimeH: Currency;
begin
  result := Trunc((self.fOBED / 60) * 100) / 100;
end;

function TMark.GetWorkTimeStr: string;
begin
  result := FormatFloat('0.##', self.Worktime);
end;

function TMark.MarkAsString: string;
begin
  Result := Self.MarkAsStringSep('; ');
end;

function TMark.MarkAsStrings: string;
begin
  Result := Self.MarkAsStringSep(#10#13);
end;

function TMark.MarkAsStringSep(Separator: string): string;
var
  s: string;
begin
  if Separator = '' then
    Separator := '; ';

  s := 'Отметка: ''' + Self.MarkID + '''' + Separator;
  s := s + 'Время работы: ' + Self.WorkTimeStr + 'ч (вечерние - ' + FormatFloat('0.##', Self.EveningTime) + 'ч, ночные - ' + FormatFloat('0.##', Self.NightTime)
    + 'ч)' + Separator;
  s := s + 'Описание: ' + Self.Description + Separator;
  s := s + 'Используется в графиках: ' + MarkUse(Self.MarkID);

  Result := s;
end;

end.


