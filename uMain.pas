unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Win.ScktComp, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  IdSNTP,uHook,uLog,uFlash,uConfig,uFuncs;

type
  TfMain = class(TForm)
    Panel1: TPanel;
    btnStart: TButton;
    Page1: TPageControl;
    StatusBar1: TStatusBar;
    tsInfo: TTabSheet;
    tsData: TTabSheet;
    memoInfo: TMemo;
    MemoData: TMemo;
    Panel2: TPanel;
    btnDecrpt: TButton;
    edtInput: TEdit;
    btnTest: TButton;
    btnDecryptTime: TButton;
    btnSetSysTime: TButton;
    btnRestoreSysTime: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnDecrptClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnDecryptTimeClick(Sender: TObject);
    procedure btnSetSysTimeClick(Sender: TObject);
    procedure btnRestoreSysTimeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    procedure httpMessage(var MSG:TMessage); message WM_CAP_WORK;
    procedure AppException(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses uDM;

procedure TfMain.AppException(Sender: TObject; E: Exception);
begin
  //Application.ShowException(E);
  //Application.Terminate;
  Log(e.Message);
end;
procedure TfMain.httpMessage(var msg:TMessage);
var
  len,flag:integer;
  p:pointer;
  say,data:ansistring;

begin
  flag:=msg.LParam;
  len:=msg.WParam;
  case flag of
  0:begin
      say:='�������ݣ�'+inttostr(len);
      //data:=gSend;
    end;
  1:begin
      say:='�������ݣ�'+inttostr(len);
      //data:=gRecv;
    end;
  end;

  memoInfo.Lines.Add(uFuncs.getDateTimeString(now(),0));
  memoInfo.Lines.Add(say);
  //memoInfo.Lines.Add(gData);
end;

procedure TfMain.btnDecrptClick(Sender: TObject);
var
  s:ansiString;
begin
  s:=trim(edtInput.Text);
  s:=dm.flash.decryptData(s);
  memoData.Lines.Add(s);
end;

procedure TfMain.btnDecryptTimeClick(Sender: TObject);
var
  s:ansiString;
begin
  s:=trim(edtInput.Text);
  s:=dm.flash.decryptTimeData(s);
  memoData.Lines.Add(s);

end;

procedure TfMain.btnRestoreSysTimeClick(Sender: TObject);
begin
  dm.IdSNTP1.Host:='time.windows.com';
  dm.IdSNTP1.SyncTime ;
end;

procedure TfMain.btnSetSysTimeClick(Sender: TObject);
var
  systemtime:Tsystemtime;
  DateTime:TDateTime;
begin
  DateTime:=StrToDateTime('2019/09/22 11:00:00');   //���ʱ�䣨TDateTime��ʽ��
  DateTimeToSystemTime(DateTime,systemtime);   //��Delphi��TDateTime��ʽת��ΪAPI��TSystemTime��ʽ
  SetLocalTime(SystemTime);
  //GetLocalTime(SystemTime);   //��ȡϵͳʱ��
  //DateTime:=SystemTimeToDateTime(SystemTime);   //��API��TSystemTime��ʽ   ת��Ϊ   Delphi��TDateTime��ʽ
  //Edit2.Text:=DateTimeToStr(DateTime);   //��ʾ��ǰϵͳ��ʱ��
end;

procedure TfMain.btnStartClick(Sender: TObject);
begin
  dm.Timer1.Enabled:=true;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.IdSNTP1.Host:='time.windows.com';
  dm.IdSNTP1.SyncTime ;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  uHook.hForm:=fMain.Handle;
  dm.Timer1.Enabled:=false;
  page1.ActivePageIndex:=0;
end;

end.