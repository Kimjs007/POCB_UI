program Donga_UI;

uses
  Vcl.Forms,
  Form_Main in 'Form_Main.pas' {Frm_Main},
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  Frm_DM in 'Frm_DM.pas' {DM: TDataModule};

{$R *.res}

var
  i: Integer;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TDM, DM);

  DM.SP.ProgressBar.Position := 0;
  DM.SP.Show();
  Application.CreateForm(TFrm_Main, Frm_Main);

  for i := 20 to 100 do begin

    DM.SP.ProgressBar.Position := i;
    DM.DelayMS(1);
  end;
  DM.DelayMS(100);
  DM.SP.Close;
  Application.Run;
end.

