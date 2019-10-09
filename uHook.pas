unit uHook;

interface
uses windows,WinSock2,Messages,WININET;

Const
  WM_CAP_WORK = WM_USER+1001;
var
  original_Send: function(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;

  original_Recv:function (s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;

  hForm:HWND;
  gData:ansiString;

  function replaced_Send(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
  function replaced_Recv(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
  procedure UnHookWebAPI;
  procedure HookWebAPI;
implementation
uses
  HookUtils,uDataSocket;

function replaced_Send(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
var
  p:pansiChar;
begin
  //这儿进行接收的数据处理
  //setlength(gSend,len);
  //move(buf,gSend[1],len);

  result:=original_Send(s,buf,len,flags);
  if(result<0)then exit;
  SaveSocketDataToFile('send',s,Buf,len);
  p:=pointer(integer(@Buf)+22);
  gData:=p;
  //postMessage(hform, WM_CAP_WORK,len,0);
  MessageBeep(1000); //简单的响一声
end;

function replaced_Recv(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
var
  p:pansiChar;
begin

  result:=original_Recv(s,buf,len,flags);
  if(result<1)then exit;
  SaveSocketDataToFile('Recv',s,Buf,len);
  p:=pointer(integer(@Buf)+22);
  gData:=p;
  postMessage(hform, WM_CAP_WORK,len,1);
  MessageBeep(10000); //简单的响一声
end;
{------------------------------------}
{过程功能:HookAPI
{过程参数:无
{------------------------------------}
procedure HookWebAPI;
const
  SendRealName = 'send';
  RecvRealName = 'recv';
begin
  if not(Assigned(original_Send)) then
  begin
    @original_Send := HookProcInModule('ws2_32.dll', SendRealName, @replaced_Send); //ws2_32  wsock32
  end;
  if not(Assigned(original_Recv)) then
  begin
    @original_Recv := HookProcInModule('ws2_32.dll', RecvRealName, @replaced_Recv);
  end;

end;
{------------------------------------}
{过程功能:取消HOOKAPI
{过程参数:无
{------------------------------------}
procedure UnHookWebAPI;
begin
  if Assigned(original_Send) then
    UnHook(@original_Send);
  if Assigned(original_Recv) then
    UnHook(@original_Recv);
end;

initialization
  HookWebAPI;
finalization
  UnHookWebAPI;
end.
