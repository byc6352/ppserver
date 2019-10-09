unit uConfig;

interface
uses
  Vcl.Forms,System.SysUtils;
const
  WORK_DIR:ansiString='ppserver'; // ����Ŀ¼
  DATA_DIR:ansiString='data'; // ����Ŀ¼
  LOG_NAME:ansiString='ppserverLog.txt'; //��־�ļ�
  SWF_NAME:ansiString='crypt.swf';        //flash�ļ�
  POLICY_NAME:ansiString='crossdomain.xml';//flash��Ȩ�ļ�
  CROSS_NAME:ansiString='crossdomain.dat';//flash��Ȩ�ļ�
  SOCKET_NAME:ansiString='socket.dat'; //socket�����ļ�
  YZCODE_NAME:ansiString='yzcode.png'; //��֤��
var
  workdir,dataDir:ansiString;//����Ŀ¼
  policyfile,crossfile,logfile,socketFile,yzcodeFile:ansiString;//
  swfFileName:ansiString;//xml���ò����ļ�
  isInit:boolean=false;
  procedure init();
implementation

procedure init();
var
    me:String;
begin
  isInit:=true;
  me:=application.ExeName;
  workdir:=extractfiledir(me)+'\'+WORK_DIR;
  if(not DirectoryExists(workdir))then ForceDirectories(workdir);
  dataDir:=workdir+'\'+DATA_DIR;
  if(not DirectoryExists(dataDir))then ForceDirectories(dataDir);
  logfile:=dataDir+'\'+LOG_NAME;
  policyfile:=workdir+'\'+POLICY_NAME;
  crossfile:=workdir+'\'+CROSS_NAME;
  swfFileName:=workdir+'\'+SWF_NAME;
  yzcodeFile:=workdir+'\'+YZCODE_NAME;
  socketFile:=dataDir+'\'+SOCKET_NAME;
end;
begin
  init();
end.