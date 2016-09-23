unit uFRReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FR_Class, FMTBcd, DB, SqlExpr, FR_DSet, FR_DBSet;

type
  TfrmFDReport = class(TForm)
    frReport1: TfrReport;
    sqlqrySchedule: TSQLQuery;
    DataSource1: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    sqlqryScheduleTotal: TSQLQuery;
    frDBDataSet2: TfrDBDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFDReport: TfrmFDReport;

implementation

uses udmMain;

{$R *.dfm}

end.
