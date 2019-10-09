unit uLog;

interface
uses windows,sysutils,uConfig;
procedure init();
procedure Log(txt:string);
var
  tf:TextFile;
implementation
procedure init();
begin
  if not uConfig.isInit then uConfig.init();
  AssignFile(tf,uconfig.logfile);
  if(not fileexists(uconfig.logfile))then
    Rewrite(tF)  //�Ḳ���Ѵ��ڵ��ļ�
  else
    Append(tF);  //��׼��׷��
end;
procedure Log(txt:string);
var
  t:string;
begin
  t:=FormatDateTime('yyyy-mm-dd hh:nn:ss:zzz', Now);
  WriteLn(tf,t);
  WriteLn(tf,txt);
  flush(tf);
end;
initialization
  {��ʼ������}
  {��������ʱ��ִ��,��˳��ִ��}
  {һ����Ԫ�ĳ�ʼ����������֮ǰ,����������ʹ�õ�ÿһ����Ԫ�ĳ�ʼ������}
   init();
finalization
  {����������,�������ʱִ��}
  CloseFile(tF);
end.