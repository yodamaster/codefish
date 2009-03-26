unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, jpeg;

type
  TlogForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    user: TComboBox;
    pass: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    logpic: TImage;
    logbg: TImage;
    btnClose: TBitBtn;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure logpicClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadUserList();
    procedure DisReg();
  public
    { Public declarations }
    str:String;
    bHave:Boolean;
    bCanClose:Boolean;
    bRegNew:Boolean;
  end;

var
  logForm: TlogForm;

implementation

uses
  dbConn,user,ShellApi,Base64;

{$R *.dfm}


//ע��
procedure TlogForm.BitBtn2Click(Sender: TObject);
begin
    if dbConns.m_bDisReg then
    begin
      Application.MessageBox('  �Ѿ���ֹ���û�ע��!!  ','��ʾ');
      exit;
    end;

     userForm:=TUserForm.Create(nil);
     userForm.m_breg:=true;
     if userForm.ShowModal = 1 then
       ReadUserList();
end;

procedure TlogForm.btnCloseClick(Sender: TObject);
begin
    bCanClose:=true;
    Application.Terminate;
end;

//����
procedure TlogForm.FormCreate(Sender: TObject);
begin
    bCanClose:=true;
    bRegNew:=true;
   //��ȡͼƬ
   //logpic.Picture.LoadFromFile('logpic.jpg'); //����ͼƬ
   //logbg.Picture.LoadFromFile('logbg.jpg');  //����
   //���屳��
   Color:=RGB(235,244,244);

   bHave:=False;
   //��ȡ�û��б�
   ReadUserList();
   //�Ƿ�������ע��
   DisReg();
end;

procedure TlogForm.DisReg;
begin
    with dbConns.dbQuery  do
    begin
      Close;
      SQL.TExt:='Select id,mreg From TableUser Order By ID ASC';
      Open;
      dbConns.m_bDisReg:=false;
      if FieldByName('mreg').AsString='1' then
      begin
         dbConns.m_bDisReg:=true;
         BitBtn2.Visible:=false;
      end;
      Close;
    end;
end;

procedure TlogForm.FormShow(Sender: TObject);
begin
  if Not bRegNew then
     BitBtn2.Visible:=false;
end;

procedure TlogForm.Label3Click(Sender: TObject);
begin
    ShellExecute(Handle,'open','http://hi.baidu.com/codefish', nil, nil, SW_SHOWNORMAL);
end;

procedure TlogForm.logpicClick(Sender: TObject);
begin

end;

//��ȡ�û�
procedure TlogForm.ReadUserList;
begin
   user.Items.Clear;
   with dbConns.dbQuery do
   begin
      SQL.Clear;
      Close;
      SQL.Text := 'Select muser From TableUser order by muser';
      Open;
      while Not Eof do
      begin
        str:=FieldByName('muser').AsString;
        user.Items.Add(str);
		    bHave:=True;
        next;
      end;
      Close;
   end;
end;

//��¼
procedure TlogForm.BitBtn1Click(Sender: TObject);
var
  sid,sid2,ps:String;
  suser,spass,stips:String;
  slogt,sreg,sfree,stray:String;
begin
   suser := trim(user.Text);
   spass := trim(pass.Text);
   if (suser='') Or (spass='') then
   begin
      Application.MessageBox('  :( �ʺź����붼����Ϊ�գ���������!!  ','��ʾ');
      exit;
   end;
   with dbConns.dbQuery do
   begin
      SQL.Clear;
      Close;
      SQL.Text := 'Select ID,muser,mpass,mtips,mreg,mfree,mtray,mlogt From TableUser where muser="'+ suser +'"';
      Open;
      if Eof then
      begin
        Application.MessageBox('  :( ����û������ʺ�Ŷ!!  ','��ʾ');
        exit;
      end;
      str := FieldByName('mpass').AsString;
	    stips:=FieldByName('mtips').AsString;
      sid:=FieldByName('ID').AsString;
      slogt:=FieldByName('mlogt').AsString;
      sreg:=FieldByName('mreg').AsString;
      sfree:=FieldByName('mfree').AsString;
      stray:=FieldByName('mtray').AsString;
	    if trim(stips)='' then
		     stips:='��û������������ʾŶ :(';
      ps:=EncodeBase64(spass);   
      if str <> ps then
      begin
        Application.MessageBox(pChar('���벻��ȷ�������������!!'+#13#13#13+'������ʾ: '+stips),'��ʾ');
        exit;
      end;
      Close;
      //��¼�ɹ�
      dbConns.m_user := suser;  //�û�
      dbConns.m_pass := ps;  //����
      dbConns.m_tips:=stips;
      dbConns.m_ID:=sid;        //id
       dbConns.m_bTray:=false;  //�Ƿ�����
      if stray='1' then
          dbConns.m_bTray:=true;
      dbConns.m_lastLogt:=slogt; //��¼ʱ��
      if sfree='' then
          sfree:='10';
      dbConns.m_freeTime:=StrToInt(sfree); //��������
      //��������
      SQL.Clear;
      Close;
      SQL.Text:='Update TableUser set mlogt="'+DateTimeToStr(now)+'" where muser="'+ suser +'"';
      execSQL;
      //�Ƿ��ǵ�һ���û�(����Ա)
      Close;
      SQL.TExt:='Select id,mreg From TableUser Order By ID ASC';
      Open;
      sid2:=FieldByName('ID').AsString;
      dbConns.m_bFstUser:=false;
      if sid2=sid then
        dbConns.m_bFstUser:=true;
      Close;
      //����
      bCanClose:=true;
      Self.ModalResult:=1;
   end;
end;


procedure TlogForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose:=bCanClose;
end;

end.
