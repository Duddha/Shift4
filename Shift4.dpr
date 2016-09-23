// JCL_DEBUG_EXPERT_GENERATEJDBG ON
program Shift4;

uses
  FastMM4,
  Forms,
  uMain in 'uMain.pas' {frmMain},
  VersionInfo in '..\Common Files\VersionInfo.pas',
  AboutForm in '..\Common Files\AboutForm.pas' {frmAbout},
  DBConnect in '..\Common Files\DBConnect.pas',
  DBConnectForm in '..\Common Files\DBConnectForm.pas' {frmDBConnect},
  uChangeCurYear in 'uChangeCurYear.pas' {frmChangeCurYear},
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  uSchedule in 'uSchedule.pas' {frmSchedule},
  uScheduleInfo in 'uScheduleInfo.pas' {frmScheduleInfo},
  uMarkInfo in 'uMarkInfo.pas' {frmMarkInfo},
  uFrameSchedule in 'uFrameSchedule.pas' {frameSchedule: TFrame},
  uHoliday in 'uHoliday.pas' {frmHolidays},
  uNewSchedule in 'uNewSchedule.pas' {frmNewSchedule},
  uMarkList in 'uMarkList.pas' {frmMarkList},
  uScheduleList in 'uScheduleList.pas' {frmScheduleList},
  uCalculateSchedule in 'uCalculateSchedule.pas' {frmCalculateSchedule},
  uChangeMark in 'uChangeMark.pas' {frmChangeMark},
  uDeptSchedule in 'uDeptSchedule.pas' {frmDeptSchedule},
  uCalculateScheduleAsCopy in 'uCalculateScheduleAsCopy.pas' {frmCalculateScheduleAsCopy},
  uPrintSchedule in 'uPrintSchedule.pas' {frmPrintSchedule},
  Report_Excel in '..\Common Files\Report_Excel.pas',
  uTestSchedule in 'uTestSchedule.pas' {frmTestSchedule},
  DBChangePassword in '..\Common Files\DBChangePassword.pas' {frmChangePassword},
  uGetCode in 'uGetCode.pas' {frmGetCode};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Графики 4';
  Application.CreateForm(TdmMain, dmMain);
  if not dmMain.CancelPressed then begin
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  end;
end.
