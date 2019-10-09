unit uHookData;

interface
uses
   System.SysUtils,windows;

var
  hFile:HWND;
procedure SaveFile(dataId:ansiString; var Buf;len: Integer);
procedure myCloseHandle(var hFile:HWND);
implementation
uses
  uConfig,uFuncs,uLog;
procedure SaveFile(dataId:ansiString; var Buf;len: Integer);
var
  header:ansistring;
  lpNumberOfBytesWritten,dwFileSize:DWORD;
  ret:BOOL;
begin
  if(len<=0)then exit;
  try
    if (hFile=0) then
    begin
      hFile:=CreateFileA(pansichar(uConfig.socketFile),GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
      if(hFile = INVALID_HANDLE_VALUE)then exit;
      //Log('hFile:'+dataId);
      //dwFileSize:=getFileSize(hFile,@dwFileSize);
      setFilePointer(hFile,0,nil,FILE_END);
    end;
    header:=#13#10+getDateTimeString(now(),0)+'--------'+dataId+'--------'+#13#10;
    ret:=writeFile(hFile,header[1],length(header),lpNumberOfBytesWritten,0);
    if(ret=false)then begin CloseHandle(hFile);hFile:=0;exit;end;

    lpNumberOfBytesWritten:=0;
    while(lpNumberOfBytesWritten<len)do
    begin
      ret:=writeFile(hFile,Buf,len,lpNumberOfBytesWritten,0);
      if(ret=false)then begin CloseHandle(hFile);hFile:=0;exit;end;
    end;
    FlushFileBuffers(hFile);
  finally

  end;
end;
procedure myCloseHandle(var hFile:HWND);
begin
  if(hFile<>0)then
  begin
    closeHandle(hFile);
    hFile:=0;
  end;
end;


initialization

finalization
   myCloseHandle(hFile);
end.
