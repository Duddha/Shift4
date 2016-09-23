unit uChangeCurYear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmChangeCurYear = class(TForm)
    Label1: TLabel;
    cboxCurYear: TComboBox;
    CheckBox1: TCheckBox;
    bitbtnOk: TBitBtn;
    bitbtnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure bitbtnCancelClick(Sender: TObject);
    procedure bitbtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CancelPressed: Boolean;
  end;

var
  frmChangeCurYear: TfrmChangeCurYear;

implementation

uses udmMain;

{$R *.dfm}

procedure TfrmChangeCurYear.FormCreate(Sender: TObject);
begin
  CancelPressed := True;
  cboxCurYear.Items.Assign(GetYears);
  cboxCurYear.ItemIndex := cboxCurYear.Items.IndexOf(sCurYear);
end;

procedure TfrmChangeCurYear.bitbtnCancelClick(Sender: TObject);
begin
  CancelPressed := True;
  Close;
end;

procedure TfrmChangeCurYear.bitbtnOkClick(Sender: TObject);
begin
  CancelPressed := False;
  SetCurYear(cboxCurYear.Text);
  if CheckBox1.Checked then
    SaveDefaultYear;
  Close;
end;

end.
