unit uScheduleInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, udmMain, Spin;

type
  TfrmScheduleInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edScheduleType: TEdit;
    edNameU: TEdit;
    edNameR: TEdit;
    edCycle: TEdit;
    spnedNumOfDays: TSpinEdit;
    spnedNumOfShifts: TSpinEdit;
    cboxHollidayType: TComboBox;
    edMarks: TEdit;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Schedule: TSchedule;
    FormMode: Byte; //0 - Просмотр информации об графике, 1 - Создание нового графика, 2 - Изменение существующего графика

    function FillInScheduleInfo: Boolean; overload;
    function FillInScheduleInfo(_Schedule: TSchedule): Boolean; overload;
    { Public declarations }
  end;

var
  frmScheduleInfo: TfrmScheduleInfo;
{
property ScheduleType: Integer read fTIP_SMEN write fTIP_SMEN;
    property NameU: String read fNAME_U write fNAME_U;
    property NameR: String read fNAME_R write fNAME_R;
    property Cycle: String read fCYCLE write fCYCLE;
    property NumOfDays: Byte read fDAYS write fDAYS;
    property NumOfShifts: Byte read fKOL_SMEN write fKOL_SMEN;
    property HollidayType: Byte read fHOL_TYPE write fHOL_TYPE;
    property LaunchTime: Integer read fOBED write fOBED;
    property LaunchTimeH: Single read GetLaunchTimeH;
    property MarkIndexes[Index: Integer]: Integer read GetMarkIndex write SetMarkIndex;
}
implementation

{$R *.dfm}

{ TfrmScheduleInfo }

function TfrmScheduleInfo.FillInScheduleInfo: Boolean;
begin
  result := False;
  with self.Schedule do begin
    edScheduleType.Text  := IntToStr(ScheduleType);
    edNameU.Text         := NameU;
    edNameR.Text         := NameR;
    edCycle.Text         := Cycle;
    spnedNumOfDays.Value := NumOfDays;
    spnedNumOfShifts.Value := NumOfShifts;
    cboxHollidayType.ItemIndex := HollidayType;
    //edMarks.Text
  end;
end;

function TfrmScheduleInfo.FillInScheduleInfo(
  _Schedule: TSchedule): Boolean;
begin
  self.Schedule := _Schedule;
  result := FillInScheduleInfo;
end;

procedure TfrmScheduleInfo.FormCreate(Sender: TObject);
begin
  FormMode := 0;
end;

end.
