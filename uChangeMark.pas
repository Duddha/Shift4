unit uChangeMark;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, udmMain, StrUtils;

type
  TfrmChangeMark = class(TForm)
    bitbtnOk: TBitBtn;
    bitbtnCancel: TBitBtn;
    Label1: TLabel;
    lstboxMarks: TListBox;
    lbPrevMark: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbDate: TLabel;
    lbShift: TLabel;
    chkboxRecalculateWorktime: TCheckBox;
    bitbtnNewMark: TBitBtn;
    procedure bitbtnCancelClick(Sender: TObject);
    procedure bitbtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bitbtnNewMarkClick(Sender: TObject);
    procedure lstboxMarksDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iDay, iMonth, iYear: Integer;
    sShiftID: string;
    sPrevMark: string;
    sNewMark: string;
    CancelPressed: Boolean;
    _Schedule: TSchedule;
    _DontShowMark: string;
    function FillIn(MarkOrTime: Boolean = True): Boolean;
  end;

var
  frmChangeMark: TfrmChangeMark;

implementation

uses
  uMarkList;

{$R *.dfm}

procedure TfrmChangeMark.bitbtnCancelClick(Sender: TObject);
begin
  CancelPressed := True;
  Close;
end;

procedure TfrmChangeMark.bitbtnOkClick(Sender: TObject);
begin
  sNewMark := LeftStr(lstboxMarks.Items.Strings[lstboxMarks.ItemIndex], 2);
  CancelPressed := False;
  Close;
end;

function TfrmChangeMark.FillIn(MarkOrTime: Boolean = True): Boolean;
var
  i: Integer;
  _Mark: TMark;
begin
  try
    lbPrevMark.Caption := sPrevMark;
    lbDate.Caption := FormatDateTime('mmmm dd, yyyy - dddd', EncodeDate(iYear, iMonth, iDay));
    lbShift.Caption := sShiftID;

    lstboxMarks.Clear;
    for i := 0 to _Schedule.MarkIndexesCount - 1 do begin
      if (_DontShowMark <> TMark(oblstMarkList.Items[_Schedule.MarkIndexes[i]]).MarkID) then begin
        _Mark := TMark(oblstMarkList.Items[_Schedule.MarkIndexes[i]]);
        if MarkOrTime then
          lstboxMarks.Items.Add(_Mark.MarkID + ' - ' + _Mark.Description + ' (' + FloatToStr(_Mark.WorkTime) + '/' + FloatToStr(_Mark.EveningTime) + '/' +
            FloatToStr(_Mark.NightTime) + '/' + FloatToStr(_Mark.LunchTime) + ')')
        else
          lstboxMarks.Items.Add(_Mark.MarkID + ' [' + FloatToStr(_Mark.WorkTime) + 'ч.] - ' + _Mark.Description + ' (' + FloatToStr(_Mark.WorkTime) + '/' +
            FloatToStr(_Mark.EveningTime) + '/' + FloatToStr(_Mark.NightTime) + '/' + FloatToStr(_Mark.LunchTime) + ')');
      end;
    end;

    result := True;
  except
    result := False;
  end;
end;

procedure TfrmChangeMark.FormCreate(Sender: TObject);
begin
  CancelPressed := True;
end;

procedure TfrmChangeMark.bitbtnNewMarkClick(Sender: TObject);
var
  sSQL: string;
begin
  frmMarkList := TfrmMarkList.Create(Application);
  try
    frmMarkList.Caption := 'Выберите отметку для добавления';
    frmMarkList.DrawMarkList;
    frmMarkList.ShowModal;
    if frmMarkList.ChoosenMarkID <> '000' then begin
      _Schedule.MarkIndexes[-1] := frmMarkList.ChoosenMarkIndex;
      sSQL := 'insert into QWERTY.SP_ZAR_TABL_SMEN (ID_SMEN, ID_OTMETKA) select ID_SMEN, ''' + frmMarkList.ChoosenMarkID +
        ''' from QWERTY.SP_ZAR_S_SMEN where TIP_SMEN=' + IntToStr(_Schedule.ScheduleType);
      dmMain.sqlconDB.ExecuteDirect(sSQL);
      FillIn;
    end;
  finally
    frmMarkList.Free;
  end;
end;

procedure TfrmChangeMark.lstboxMarksDblClick(Sender: TObject);
begin
  bitbtnOkClick(Sender);
end;

end.


