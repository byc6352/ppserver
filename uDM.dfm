object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 259
  Width = 524
  object ss1: TServerSocket
    Active = False
    Port = 8300
    ServerType = stNonBlocking
    OnClientConnect = ss1ClientConnect
    OnClientRead = ss1ClientRead
    Left = 12
    Top = 8
  end
  object IdSNTP1: TIdSNTP
    Host = 'time.windows.com'
    Port = 123
    ReceiveTimeout = 2000
    Left = 148
    Top = 19
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 73
    Top = 10
  end
  object ss2: TServerSocket
    Active = True
    Port = 843
    ServerType = stNonBlocking
    OnClientConnect = ss2ClientConnect
    OnClientRead = ss2ClientRead
    Left = 12
    Top = 64
  end
end
