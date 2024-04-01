unit Frm_DM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Diagnostics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, AdvMetroTaskDialog, Vcl.ExtCtrls, AdvSmoothPopup, Math,
  AdvSmoothSplashScreen, GDIPPictureContainer;




type
  TDM = class(TDataModule)
    POP_PL: TAdvSmoothPopup;
    TaskDialog: TAdvMetroTaskDialog;
    InputTaskDialog: TAdvInputMetroTaskDialog;
    SP: TAdvSmoothSplashScreen;
    GDIPPictureContainer1: TGDIPPictureContainer;
    procedure TaskDialogDialogProgress(Sender: TObject; var Pos: Integer; var State: TTaskDialogProgressState);
    procedure TaskDialogDialogButtonClick(Sender: TObject; ButtonID: Integer);
  private


    { Private declarations }
  public
    function ShowInputBox(iCaption, iTitle, iSubTitle, iInputText: string; iIcon: TTaskDialogIcon; iButtons: TCommonButtons): string;
    function ShowMsgBox(iCaption, iTitle, iSubTitle: string; iIcon: TTaskDialogIcon; iButtons: TCommonButtons; iTimeOut: Integer): Boolean;
    procedure DelayMS(MS: Integer);

    { Public declarations }
  end;

var
  DM: TDM;
  ST: TStopwatch;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses
  Form_Main;

{$R *.dfm}

procedure TDM.DelayMS(MS: Integer);
var
  PastCount: LongInt;
begin
  PastCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((GetTickCount - PastCount) >= LongInt(MS));
end;

procedure TDM.TaskDialogDialogButtonClick(Sender: TObject; ButtonID: Integer);
begin
  TaskDialog.Tag := ButtonID;
end;

procedure TDM.TaskDialogDialogProgress(Sender: TObject; var Pos: Integer; var State: TTaskDialogProgressState);
var
  sInt: Integer;
begin
  if TaskDialog.AutoCloseTimeOut = 0 then
    Exit;
  with TaskDialog do begin
    Pos := Round((ST.ElapsedMilliseconds / TaskDialog.AutoCloseTimeOut) * 100);
    sInt := Round((AutoCloseTimeOut - (ST.ElapsedMilliseconds)) / 1000);
    if sInt <= 0 then
      sInt := 0;
    Footer := FormatFloat('Time remaining 0 sec', sInt);
  end;
end;

function TDM.ShowInputBox(iCaption, iTitle, iSubTitle, iInputText: string; iIcon: TTaskDialogIcon; iButtons: TCommonButtons): string;
begin
  DM.InputTaskDialog.InputText := '';
  if Assigned(Frm_Main) then
    Frm_Main.AlphaBlendValue := 180;
  DM.InputTaskDialog.CollapsControlText := '';
  DM.InputTaskDialog.InputText := iInputText;
  DM.InputTaskDialog.ExpandedText := '';
  DM.InputTaskDialog.ExpandControlText := '';
  DM.InputTaskDialog.Title := iCaption;
  DM.InputTaskDialog.Instruction := iTitle;
  DM.InputTaskDialog.Content := iSubTitle;
  DM.InputTaskDialog.Footer := '';
  DM.InputTaskDialog.Icon := iIcon;
  DM.InputTaskDialog.CommonButtons := iButtons;

  if DM.InputTaskDialog.Execute in [1, 6] then begin
    result := InputTaskDialog.InputText;
  end
  else begin
    // InputTaskDialog.InputText := 'CANCEL';
    result := InputTaskDialog.InputText;
  end;

  if Assigned(Frm_Main) then
    Frm_Main.AlphaBlendValue := 255;
end;

function TDM.ShowMsgBox(iCaption, iTitle, iSubTitle: string; iIcon: TTaskDialogIcon; iButtons: TCommonButtons; iTimeOut: Integer): Boolean;
begin
  TaskDialog.Tag := 0;
  result := False;

  TaskDialog.AutoCloseTimeOut := iTimeOut;
  DM.TaskDialog.CollapsControlText := '';
  DM.TaskDialog.ExpandedText := '';
  DM.TaskDialog.ExpandControlText := '';
  DM.TaskDialog.Title := iCaption;
  DM.TaskDialog.Instruction := iTitle;
  DM.TaskDialog.Content := iSubTitle;
  DM.TaskDialog.Footer := '';
  DM.TaskDialog.Icon := iIcon;
  DM.TaskDialog.CommonButtons := iButtons;

  if iTimeOut <= 0 then begin
    TaskDialog.Options := [];
    TaskDialog.AutoClose := False;
  end
  else begin
    TaskDialog.Options := [doProgressBar];
    TaskDialog.AutoClose := True;
  end;

  if Assigned(Frm_Main) then begin
    Frm_Main.AlphaBlend := True;
    Frm_Main.AlphaBlendValue := 200;
  end;

  ST.Reset;
  ST.Start;
  DM.TaskDialog.Execute;

  if DM.TaskDialog.Tag in [0, 1, 6] then begin
    result := True;
    ST.Stop;
  end;
  if Assigned(Frm_Main) then begin
    Frm_Main.AlphaBlendValue := 255;
  end;
end;

end.

