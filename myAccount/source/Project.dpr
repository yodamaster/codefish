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
  Application.Title := '�ҵļ�ͥ�����˱� v1.2';
  Application.CreateForm(TdbConns, dbConns);
  if dbConns.m_bConn=false then
  begin
    Application.MessageBox('�޷����������������ݿ�, ���Ժ�����!!','�ҵ��˱�');
    Application.Terminate;
    exit;
  end;
  //��¼
  logForm := TLogForm.Create(nil);;
  if logForm.ShowModal <> 1 then
  begin
    Application.Terminate;
    exit;
  end;
  logForm.Destroy;
  //��ҳ��
  Application.CreateForm(TmainForm, mainForm);
  //��������
  Application.Run;
end.
