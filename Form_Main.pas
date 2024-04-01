unit Form_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Themes,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.WinXCtrls,
  AdvShapeButton, RzStatus, RzPanel, System.ImageList, AdvMetroTaskDialog,
  Common, Vcl.ImgList, AdvSmoothSplashScreen, CurvyControls, VrControls, VrButtons, AdvGroupBox;

type
  TFrm_Main = class(TForm)
    SV_LEFT: TSplitView;
    NavPanel: TPanel;
    Img_BOTTOM: TImage;
    Btn_Login: TButton;
    Btn_MC: TButton;
    Btn_Model: TButton;
    Btn_Exit: TButton;
    Btn_Setup: TButton;
    RzstsbrMainFrmx: TRzStatusBar;
    stsbrStatusMemUsage: TRzResourceStatus;
    stsbrStatusClock: TRzClockStatus;
    stsbrStatusMemTitle: TRzStatusPane;
    stsbrStatusKeyTitle: TRzStatusPane;
    stsbrStatusKeyValue: TRzKeyStatus;
    Img_Lst: TImageList;
    TM_Init: TTimer;
    CB_SetUI: TComboBox;
    PL_LEFT_TOP: TPanel;
    SB_Logo: TAdvShapeButton;
    IMG_Logo: TImage;
    procedure SV_LEFTClosing(Sender: TObject);
    procedure SV_LEFTOpening(Sender: TObject);
    procedure SV_LEFTMouseEnter(Sender: TObject);
    procedure FormMouseEnter(Sender: TObject);
    procedure Btn_ExitClick(Sender: TObject);
    procedure TM_InitTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CB_SetUIChange(Sender: TObject);
  private
    {Private declarations}
  public
    {Public declarations}
  end;

var
  Frm_Main: TFrm_Main;
  SET_UI: TSetUI;

implementation

uses
  Frm_DM;

{$R *.dfm}

procedure TFrm_Main.Btn_ExitClick(Sender: TObject);
begin
  if DM.ShowMsgBox('   POCB    ', 'Are you sure you want to quit?', '', tiQuestion, [cbYes, cbCancel], 0) then begin
    Close;
  end;
end;

procedure TFrm_Main.CB_SetUIChange(Sender: TObject);
begin
  try
    SET_UI := TSetUI.Create;
    SET_UI.MyUI_Style := TMyUI_Style(CB_SetUI.ItemIndex);
    SET_UI.SET_UI(SET_UI.MyUI_Style);
  finally
    SET_UI.Free;
  end;
end;

procedure TFrm_Main.FormCreate(Sender: TObject);
begin
  SV_LEFT.Opened := True;
  SV_LEFT.Tag := 0;
end;

procedure TFrm_Main.FormMouseEnter(Sender: TObject);
begin
  if (SV_LEFT.Opened) and (SV_LEFT.Tag = 1) then
    SV_LEFT.Opened := False;
end;

procedure TFrm_Main.FormShow(Sender: TObject);
begin
  TM_Init.Enabled := True;
end;

procedure TFrm_Main.SV_LEFTClosing(Sender: TObject);
begin
  Btn_Login.Caption := '';
  Btn_MC.Caption := '';
  Btn_Model.Caption := '';
  Btn_Setup.Caption := '';
  Btn_Exit.Caption := '';
end;

procedure TFrm_Main.SV_LEFTMouseEnter(Sender: TObject);
begin
  if not SV_LEFT.Opened then
    SV_LEFT.Opened := True;
end;

procedure TFrm_Main.SV_LEFTOpening(Sender: TObject);
begin
  Btn_Login.Caption := Btn_Login.Hint;
  Btn_MC.Caption := Btn_MC.Hint;
  Btn_Model.Caption := Btn_Model.Hint;
  Btn_Setup.Caption := Btn_Setup.Hint;
  Btn_Exit.Caption := Btn_Exit.Hint;
end;

procedure TFrm_Main.TM_InitTimer(Sender: TObject);
begin
  SV_LEFT.Opened := False;
  SV_LEFT.Tag := 1;
  TM_Init.Enabled := False;
end;

end.

