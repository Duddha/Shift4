unit uCalculateSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, Spin, ComCtrls, udmMain, FMTBcd, DB, SqlExpr, ExtCtrls,
  DateUtils, JvGIF;

type
  TfrmCalculateSchedule = class(TForm)
    dtpkrStartDate: TDateTimePicker;
    Label1: TLabel;
    bitbtnOk: TBitBtn;
    bitbtnCancel: TBitBtn;
    cboxShift: TComboBox;
    Label3: TLabel;
    sqlqryTemp: TSQLQuery;
    chkboxDontClose: TCheckBox;
    Label5: TLabel;
    lbCycle: TLabel;
    imgImage: TImage;
    grpCalculationVariants: TGroupBox;
    chkboxUsePrevDays: TCheckBox;
    lbl1: TLabel;
    sePosition: TSpinEdit;
    lbl2: TLabel;
    lblDayOfWeek: TLabel;
    procedure bitbtnOkClick(Sender: TObject);
    procedure bitbtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkboxUsePrevDaysClick(Sender: TObject);
    procedure dtpkrStartDateChange(Sender: TObject);
    procedure cboxShiftChange(Sender: TObject);
  private
    { Private declarations }
    procedure CalculateSchedule;
  public
    { Public declarations }
    Schedule: TSchedule;
    constructor Create(Sender: TComponent; _Schedule: TSchedule); overload;
  end;

var
  frmCalculateSchedule: TfrmCalculateSchedule;

implementation

{$R *.dfm}

procedure TfrmCalculateSchedule.bitbtnOkClick(Sender: TObject);
var
  i, j: Integer;
begin
  if cboxShift.Text = '--��� �����--' then begin
    j := cboxShift.ItemIndex;
    if Application.MessageBox(PChar('�� ������������� ������ ��������� ��� ����� ������� "' + Self.Schedule.NameU + '" c ' + DateToStr(dtpkrStartDate.Date)),
      '������ �������', MB_YESNO + MB_ICONQUESTION) = ID_YES then begin
      for i := 0 to j - 1 do begin
        cboxShift.ItemIndex := i;
        CalculateSchedule;
      end;
      cboxShift.ItemIndex := j;
    //ShowMessage('������ ������� ������ ���� ���� ������� ��������');
      Application.MessageBox(PChar('��� ����� ������� "' + Self.Schedule.NameU + '" � ' + DateToStr(dtpkrStartDate.Date) + ' �� ����� ' + IntToStr(YearOf(dtpkrStartDate.Date))
        + ' ���� ������� ����������'), '������� ������ �������� ��������� ���', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    end;
  end
  else begin
    if Application.MessageBox(PChar('�� ������������� ������ ��������� ������ "' + Self.Schedule.NameU + '" c ' + DateToStr(dtpkrStartDate.Date)),
      '������ �������', MB_YESNO + MB_ICONQUESTION) = ID_YES then begin
      CalculateSchedule;
      //ShowMessage('������ ������� ������ ����� ������� ��������');
      Application.MessageBox(PChar('������ ������� ������ ����� "' + cboxShift.Text + '" � ' + DateToStr(dtpkrStartDate.Date) + ' �� ����� ' + IntToStr(YearOf(dtpkrStartDate.Date))
        + ' ���� ������� ��������'), '������� ������ �������� ��������� ���', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    end
  end;
{
  if chkboxUsePrevDays.Checked then begin
    sqlqryTemp.SQL.Clear;
    sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.SCHEDULE_CALCULATE_WITH_PAST('''+FormatDateTime('dd.mm.yyyy', dtpkrStartDate.Date)+''', '''+self.Schedule.GetShiftIDByNameU(cboxShift.Text)+'''); end;');
    sqlqryTemp.ExecSQL(True);
  end
  else begin
    sqlqryTemp.SQL.Clear;
    sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.SCHEDULE_CALCULATE('''+FormatDateTime('dd.mm.yyyy', dtpkrStartDate.Date)+''', '''+self.Schedule.GetShiftIDByNameU(cboxShift.Text)+''', '+IntToStr(spnedPosition.Value)+'); end;');
    sqlqryTemp.ExecSQL(True);
  end;
}
  if not (chkboxDontClose.Checked) then
    Close;
end;

constructor TfrmCalculateSchedule.Create(Sender: TComponent; _Schedule: TSchedule);
var
  i: Integer;
begin
  inherited Create(Sender);
  //self.Create(Sender);
  self.Schedule := _Schedule;
  self.Caption := '������ ������� "' + self.Schedule.NameU + '"';

  for i := 0 to self.Schedule.ShiftsCount - 1 do
    cboxShift.Items.Add(self.Schedule.Shifts[i].NameU);
  cboxShift.Items.Add('--��� �����--');
  cboxShift.ItemIndex := 0;
  lbCycle.Caption := self.Schedule.Cycle;
end;

procedure TfrmCalculateSchedule.bitbtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCalculateSchedule.FormCreate(Sender: TObject);
var
  _Year, _Month, _Day: Word;
begin
  DecodeDate(Date, _Year, _Month, _Day);
  dtpkrStartDate.DateTime := EncodeDate(_Year + 1, 1, 1);
  dtpkrStartDateChange(Application);
end;

procedure TfrmCalculateSchedule.CalculateSchedule;
begin
  if chkboxUsePrevDays.Checked then begin
    sqlqryTemp.SQL.Clear;
    sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.SCHEDULE_CALCULATE_WITH_PAST(''' + FormatDateTime('dd.mm.yyyy', dtpkrStartDate.Date) + ''', ''' + self.Schedule.GetShiftIDByNameU
      (cboxShift.Text) + '''); end;');
    sqlqryTemp.ExecSQL(True);
  end
  else begin
    sqlqryTemp.SQL.Clear;
    sqlqryTemp.SQL.Add('begin SHIFT_ADM.shift4.SCHEDULE_CALCULATE(''' + FormatDateTime('dd.mm.yyyy', dtpkrStartDate.Date) + ''', ''' + self.Schedule.GetShiftIDByNameU
      (cboxShift.Text) + ''', ' + IntToStr(sePosition.Value * 2 - 1) + '); end;');
    sqlqryTemp.ExecSQL(True);
  end;
end;

procedure TfrmCalculateSchedule.chkboxUsePrevDaysClick(Sender: TObject);
begin
  lbl2.Enabled := not (chkboxUsePrevDays.Checked);
  sePosition.Enabled := lbl2.Enabled;
  lbl1.Enabled := lbl2.Enabled;
end;

procedure TfrmCalculateSchedule.dtpkrStartDateChange(Sender: TObject);
begin
  sePosition.Value := DayOfTheWeek(dtpkrStartDate.Date);
  case DayOfTheWeek(dtpkrStartDate.Date) of
    1:
      lblDayOfWeek.Caption := '�����������';
    2:
      lblDayOfWeek.Caption := '�������';
    3:
      lblDayOfWeek.Caption := '�����';
    4:
      lblDayOfWeek.Caption := '�������';
    5:
      lblDayOfWeek.Caption := '�������';
    6:
      lblDayOfWeek.Caption := '�������';
    7:
      lblDayOfWeek.Caption := '�����������';
  end;
end;

procedure TfrmCalculateSchedule.cboxShiftChange(Sender: TObject);
begin
  chkboxDontClose.Checked := cboxShift.ItemIndex < cboxShift.Items.Count - 2;
end;

end.


