unit Form_Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  AdvShapeButton,
  RzStatus,
  RzPanel,
  System.ImageList,
  AdvMetroTaskDialog,
  Vcl.ImgList, AdvSmoothSplashScreen;

type
  TFrm_Main = class(TForm)
    SV_LEFT: TSplitView;
    pnlToolbar: TPanel;
    NavPanel: TPanel;
    Img_BOTTOM: TImage;
    Btn_Login: TButton;
    Btn_MC: TButton;
    Btn_Model: TButton;
    Btn_Exit: TButton;
    IMG_Logo: TImage;
    Btn_Setup: TButton;
    RzstsbrMainFrmx: TRzStatusBar;
    stsbrStatusMemUsage: TRzResourceStatus;
    stsbrStatusClock: TRzClockStatus;
    stsbrStatusMemTitle: TRzStatusPane;
    stsbrStatusKeyTitle: TRzStatusPane;
    stsbrStatusKeyValue: TRzKeyStatus;
    Img_Lst: TImageList;
    procedure SV_LEFTClosing(Sender: TObject);
    procedure SV_LEFTOpening(Sender: TObject);
    procedure SV_LEFTMouseEnter(Sender: TObject);
    procedure NavPanelMouseEnter(Sender: TObject);
    procedure FormMouseEnter(Sender: TObject);
    procedure Btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Main: TFrm_Main;

implementation

uses
  Frm_DM;

{$R *.dfm}

procedure TFrm_Main.Btn_ExitClick(Sender: TObject);
begin
  if DM.ShowMsgBox('   POCB    ', 'Are you sure you want to quit?', '', tiQuestion, [cbYes, cbCancel], 4000) then begin
    Close;
  end;
end;

procedure TFrm_Main.FormMouseEnter(Sender: TObject);
begin
  if SV_LEFT.Opened then
    SV_LEFT.Opened := False;
end;

procedure TFrm_Main.NavPanelMouseEnter(Sender: TObject);
begin
  if not SV_LEFT.Opened then
    SV_LEFT.Opened := True;
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

end.

