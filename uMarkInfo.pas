unit uMarkInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, udmMain, ExtCtrls, Mask, StrUtils, Grids;

type
  TfrmMarkInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edMarkID: TEdit;
    edWorkTime: TEdit;
    edVidID: TEdit;
    edWorkDays: TEdit;
    edEveningTime: TEdit;
    edNightTime: TEdit;
    edDescription: TEdit;
    Label8: TLabel;
    bitbtnOk: TBitBtn;
    bitbtnCancel: TBitBtn;
    pnlColor: TPanel;
    ColorDialog1: TColorDialog;
    Label9: TLabel;
    edLunchTime: TEdit;
    spbtnCheckMarkID: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    medStartTime: TMaskEdit;
    medFinishTime: TMaskEdit;
    procedure bitbtnOkClick(Sender: TObject);
    procedure bitbtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnlColorClick(Sender: TObject);
    procedure edMarkIDChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edMarkIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spbtnCheckMarkIDClick(Sender: TObject);
    procedure edMarkIDExit(Sender: TObject);
    procedure edVidIDExit(Sender: TObject);
    procedure edWorkDaysExit(Sender: TObject);
    procedure edEveningTimeExit(Sender: TObject);
    procedure edNightTimeExit(Sender: TObject);
    procedure edLunchTimeExit(Sender: TObject);
    procedure medStartTimeExit(Sender: TObject);
    procedure medFinishTimeExit(Sender: TObject);
    procedure edDescriptionExit(Sender: TObject);
    procedure edDescriptionDblClick(Sender: TObject);
    procedure edWorkTimeKeyPress(Sender: TObject; var Key: Char);
    procedure edLunchTimeKeyPress(Sender: TObject; var Key: Char);
    procedure edDescriptionEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edMarkIDDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Mark: TMark;
    FormMode: Byte; //0 - Просмотр информации об отметке, 1 - Создание новой отметки, 2 - Изменение существующей отметки
    CancelPressed: Boolean;

    procedure ChangeFormMode;
    function FillInMarkInfo: Boolean; overload;
    function FillInMarkInfo(_Mark: TMark): Boolean; overload;
    function FillUpMarkInfo: Boolean;
    function IfMarkAvailable(SilentMode: Boolean): Boolean;
  end;

var
  frmMarkInfo: TfrmMarkInfo;
  oldDecimalSeparator: Char;

implementation

uses SqlExpr, DB, DBConnect, uGetCode;

{$R *.dfm}

procedure TfrmMarkInfo.bitbtnOkClick(Sender: TObject);
//var
//  sSQL, sTBegin, sTEnd: String;
begin
  case FormMode of
    0: begin
      //Просмотр информации об отметке
    end;
    1: begin
      //Создание новой отметки
      FillUpMarkInfo;
      {
      //ЭТО ДЕЙСТВИЕ ЕСТЬ В uMarkList
      sSQL := 'insert into QWERTY.SP_ZAR_OT_PROP(ID_OTMETKA, TIME_WORK, ID_VID, DAY_WORK, TIME_N, TIME_V, OPIS, T_BEGIN, T_END, OBED) ';
      sTBegin := ifThen(medStartTime.Text='  :  ', '----', Copy(medStartTime.Text, 1, 2)+Copy(medStartTime.Text, 4, 2));
      sTEnd   := ifThen(medFinishTime.Text='  :  ', '----', Copy(medFinishTime.Text, 1, 2)+Copy(medFinishTime.Text, 4, 2));
      sSQL := sSQL+'values('''+edMarkID.Text+''', '+edWorkTime.Text+', '+edVidID.Text+', '+edWorkDays.Text+', '+edNightTime.Text+', '+edEveningTime.Text+', '''+edDescription.Text+''', '''+sTBegin+''', '''+sTEnd+''', '+edLunchTime.Text+')';
      dmMain.sqlconDB.ExecuteDirect(sSQL);
      }
    end;
    2: begin
      //Изменение существующей отметки
    end;
  end;
  CancelPressed := False;
  Close;
end;

procedure TfrmMarkInfo.bitbtnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmMarkInfo.FillInMarkInfo: Boolean;
begin
  with self.Mark do begin
    edMarkID.Text      := MarkID;
    edWorkTime.Text    := FormatFloat('0.##', WorkTime);
    edVidID.Text       := IntToStr(VidID);
    edWorkDays.Text    := IntToStr(WorkDays);
    edEveningTime.Text := FormatFloat('0.##', EveningTime);
    edNightTime.Text   := FormatFloat('0.##', NightTime);
    medStartTime.Text  := Copy(StartTime, 1, 2)+':'+Copy(StartTime, 3, 2);
    medFinishTime.Text := Copy(FinishTime, 1, 2)+':'+Copy(FinishTime, 3, 2);
    edLunchTime.Text   := IntToStr(LunchTime);
    edDescription.Text := Description;
    pnlColor.Color     := Color;
  end;
end;

function TfrmMarkInfo.FillInMarkInfo(_Mark: TMark): Boolean;
begin
  self.Mark := _Mark;
  Result := FillInMarkInfo;
end;

procedure TfrmMarkInfo.FormCreate(Sender: TObject);
begin
  FormMode := 0;
  CancelPressed := True;
  //self.Mark := TMark.Create;
  oldDecimalSeparator := DecimalSeparator;
  DecimalSeparator := RightDecimalSeparator;
end;

procedure TfrmMarkInfo.pnlColorClick(Sender: TObject);
begin
  ColorDialog1.Options := ColorDialog1.Options + [cdFullOpen] + [cdAnyColor];
  ColorDialog1.Color := pnlColor.Color;

  if ColorDialog1.Execute then
    if pnlColor.Color <> ColorDialog1.Color then begin
      pnlColor.Color := ColorDialog1.Color;
      self.Mark.Color := ColorDialog1.Color;
      MarksChanged := True;
    end;
end;

procedure TfrmMarkInfo.edMarkIDChange(Sender: TObject);
begin
  self.Mark.MarkID := edMarkID.Text;
end;

procedure TfrmMarkInfo.FormDestroy(Sender: TObject);
begin
  //self.Mark.Free;
end;

procedure TfrmMarkInfo.edMarkIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key=VK_RETURN) then
    spbtnCheckMarkIDClick(Sender);
end;

procedure TfrmMarkInfo.spbtnCheckMarkIDClick(Sender: TObject);
begin
  edMarkIDDblClick(Sender);

  //IfMarkAvailable(False);
end;

procedure TfrmMarkInfo.edMarkIDExit(Sender: TObject);
begin
  self.Mark.MarkID := edMarkID.Text;
end;

procedure TfrmMarkInfo.edVidIDExit(Sender: TObject);
begin
  self.Mark.VidID := StrToInt(edVidID.Text);
end;

procedure TfrmMarkInfo.edWorkDaysExit(Sender: TObject);
begin
  self.Mark.WorkDays := StrToInt(edWorkDays.Text);
end;

procedure TfrmMarkInfo.edEveningTimeExit(Sender: TObject);
begin
  self.Mark.EveningTime := StrToFloat(edEveningTime.Text);
end;

procedure TfrmMarkInfo.edNightTimeExit(Sender: TObject);
begin
  self.Mark.NightTime := StrToFloat(edNightTime.Text);
end;

procedure TfrmMarkInfo.edLunchTimeExit(Sender: TObject);
begin
  self.Mark.LunchTime := StrToInt(edLunchTime.Text);
end;

procedure TfrmMarkInfo.medStartTimeExit(Sender: TObject);
begin
  self.Mark.StartTime := ifThen(medStartTime.Text='  :  ', '----', Copy(medStartTime.Text, 1, 2)+Copy(medStartTime.Text, 4, 2));
end;

procedure TfrmMarkInfo.medFinishTimeExit(Sender: TObject);
begin
  self.Mark.FinishTime := ifThen(medFinishTime.Text='  :  ', '----', Copy(medFinishTime.Text, 1, 2)+Copy(medFinishTime.Text, 4, 2));
end;

procedure TfrmMarkInfo.edDescriptionExit(Sender: TObject);
begin
  self.Mark.Description := edDescription.Text;
end;

function TfrmMarkInfo.FillUpMarkInfo: Boolean;
begin
  result := False;
  try
    with self.Mark do begin
      MarkID      := edMarkID.Text;
      WorkTime    := StrToFloat(edWorkTime.Text);
      VidID       := StrToInt(edVidID.Text);
      WorkDays    := StrToInt(edWorkDays.Text);
      EveningTime := StrToFloat(edEveningTime.Text);
      NightTime   := StrToFloat(edNightTime.Text);
      StartTime   := ifThen(medStartTime.Text='  :  ', '----', Copy(medStartTime.Text, 1, 2)+Copy(medStartTime.Text, 4, 2));
      FinishTime  := ifThen(medFinishTime.Text='  :  ', '----', Copy(medFinishTime.Text, 1, 2)+Copy(medFinishTime.Text, 4, 2));
      LunchTime   := StrToInt(edLunchTime.Text);
      Description := edDescription.Text;
      Color       := pnlColor.Color;
    end;
    result := True;
  except
  end;
end;

procedure TfrmMarkInfo.edDescriptionDblClick(Sender: TObject);
begin
  edDescription.Text := medStartTime.Text+'-'+medFinishTime.Text;
end;

procedure TfrmMarkInfo.edWorkTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=WrongDecimalSeparator then
    Key := RightDecimalSeparator;
  if not(Key in ['0'..'9', #8, RightDecimalSeparator]) then
    Key := Chr(0);
end;

procedure TfrmMarkInfo.edLunchTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9', #8]) then
    Key := Chr(0);
end;

function TfrmMarkInfo.IfMarkAvailable(SilentMode: Boolean): Boolean;
var
  sTMP: String;
begin
  result := False;
  with dmMain.sqlqryTemp do begin
    Active := False;
    SQL.Clear;
    SQL.Add('select count(*) num_of_marks from (select ID_OTMETKA from QWERTY.SP_ZAR_OT_PROP union all select ID_OTMETKA from QWERTY.SP_ZAR_OTNE_PROP) where ID_OTMETKA='''+edMarkID.Text+'''');
    Active := True;
    if not(Fields.Fields[0].AsInteger=0) then begin
      if not(SilentMode) then
        ShowMessage('Такая отметка уже существует');
      edMarkID.Clear;
    end
    else begin
      if not(SilentMode) then
        ShowMessage('Вы можете использовать эту отметку');
      result := True;
    end;
  end;
end;

procedure TfrmMarkInfo.ChangeFormMode;
begin
  case self.FormMode of
    0: begin
      edMarkID.ReadOnly        := True;
      spbtnCheckMarkID.Enabled := False;
      edVidID.ReadOnly         := True;
      edWorkDays.ReadOnly      := True;
      edWorkTime.ReadOnly      := True;
      edEveningTime.ReadOnly   := True;
      edNightTime.ReadOnly     := True;
      edLunchTime.ReadOnly     := True;
      medStartTime.ReadOnly    := True;
      medFinishTime.ReadOnly   := True;
      edDescription.ReadOnly   := True;
    end;
    1: begin
      edMarkID.ReadOnly        := False;
      spbtnCheckMarkID.Enabled := True;
      edVidID.ReadOnly         := False;
      edWorkDays.ReadOnly      := False;
      edWorkTime.ReadOnly      := False;
      edEveningTime.ReadOnly   := False;
      edNightTime.ReadOnly     := False;
      edLunchTime.ReadOnly     := False;
      medStartTime.ReadOnly    := False;
      medFinishTime.ReadOnly   := False;
      edDescription.ReadOnly   := False;
    end;
  end;
end;

procedure TfrmMarkInfo.edDescriptionEnter(Sender: TObject);
begin
  if edDescription.Text='' then
    if (medStartTime.Text<>'  :  ') and (medFinishTime.Text<>'  :  ') then
      edDescription.Text := medStartTime.Text+'-'+medFinishTime.Text;
end;

procedure TfrmMarkInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  DecimalSeparator := oldDecimalSeparator;
end;

procedure TfrmMarkInfo.edMarkIDDblClick(Sender: TObject);
begin
  if frmMarkInfo.FormMode <> 1 then
    Exit;

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  frmGetCode := TfrmGetCode.Create(nil);
  frmGetCode.Caption := 'Подбор кода отметки';
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
    frmGetCode.ShowModal;
  finally
    if frmGetCode.returnCode <> '' then begin
      edMarkID.Text := Copy(frmGetCode.returnCode, 1, 2);
    end;
    frmGetCode.Free;
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;
end;

end.
