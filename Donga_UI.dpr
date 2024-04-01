program Donga_UI;

uses
  Vcl.Forms,
  Form_Main in 'Form_Main.pas' {Frm_Main},
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  Frm_DM in 'Frm_DM.pas' {DM: TDataModule},
  Common in 'Common.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

var
  i: Integer;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  DM.SP.ProgressBar.Position := 0;
  DM.SP.ListItemsSettings.Space := 10;
  DM.SP.ListItemsSettings.HTMLFont.Name := 'Verdana';
  DM.SP.ListItemsSettings.HTMLFont.Size := 9;
  DM.SP.ListItemsSettings.Rect.Left := 155;
  DM.SP.ListItemsSettings.Rect.Top := 165;
  DM.SP.ListItemsSettings.Rect.Width := 200;
  DM.SP.ListItemsSettings.Rect.Height := 300;
  //--- Now display SplashScreen
  DM.SP.Show();

  with DM.SP.ListItems.Add do begin
    BeginUpdate;
    HTMLText := '<img src="UNCHECK">    Preparing System..';
    EndUpdate;
    DM.DelayMS(1000);

    BeginUpdate;
    HTMLText := '<img src="CHECK">    Prepared System';
    EndUpdate;
    DM.DelayMS(200);
  end;

  with DM.SP.ListItems.Add do begin
    BeginUpdate;
    HTMLText := '<img src="UNCHECK">    Preparing Unit..';
    EndUpdate;
    DM.DelayMS(1200);

    BeginUpdate;
    HTMLText := '<img src="CHECK">    Prepared Unit';
    EndUpdate;
    DM.DelayMS(200);
  end;

  with DM.SP.ListItems.Add do begin
    BeginUpdate;
    HTMLText := '<img src="UNCHECK">    Preparing Class..';
    EndUpdate;
    DM.DelayMS(1500);

    Application.CreateForm(TFrm_Main, Frm_Main);

    BeginUpdate;
    HTMLText := '<img src="CHECK">    Prepared Class';
    EndUpdate;
    DM.DelayMS(200);
  end;

  for i := 1 to 100 do begin
    DM.SP.ProgressBar.Position := i;
    DM.DelayMS(1);
  end;
  DM.DelayMS(100);
  DM.SP.Close;

  Application.Run;
end.

