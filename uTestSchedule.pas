unit uTestSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls;

type
  TfrmTestSchedule = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Splitter1: TSplitter;
    pnlSourceTop: TPanel;
    Label1: TLabel;
    cboxSchedule: TComboBox;
    strgrdSource: TStringGrid;
    strgrdTest: TStringGrid;
    pnlTestTop: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTestSchedule: TfrmTestSchedule;

implementation

{$R *.dfm}

end.
