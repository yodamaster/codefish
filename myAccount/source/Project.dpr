program Project;

uses
  Forms,
  main in 'main.pas' {mainForm},
  login in 'login.pas' {logForm},
  dbConn in 'dbConn.pas' {dbConns: TDataModule},
  user in 'user.pas' {userForm},
  modfiy in 'modfiy.pas' {modify},
  about in 'about.pas' {aboutFrm},
  Base64 in 'Base64.pas',
  ClassEdt in 'ClassEdt.pas' {classFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '我的家庭电子账本 v1.2';
  Application.CreateForm(TdbConns, dbConns);
  if dbConns.m_bConn=false then
  begin
    Application.MessageBox('无法创建或者连接数据库, 请稍候再试!!','我的账本');
    Application.Terminate;
    exit;
  end;
  //登录
  logForm := TLogForm.Create(nil);;
  if logForm.ShowModal <> 1 then
  begin
    Application.Terminate;
    exit;
  end;
  logForm.Destroy;
  //主页面
  Application.CreateForm(TmainForm, mainForm);
  //跑起来吧
  Application.Run;
end.
