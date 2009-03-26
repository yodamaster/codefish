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


//注册
procedure TlogForm.BitBtn2Click(Sender: TObject);
begin
    if dbConns.m_bDisReg then
    begin
      Application.MessageBox('  已经禁止新用户注册!!  ','提示');
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

//创建
procedure TlogForm.FormCreate(Sender: TObject);
begin
    bCanClose:=true;
    bRegNew:=true;
   //读取图片
   //logpic.Picture.LoadFromFile('logpic.jpg'); //顶部图片
   //logbg.Picture.LoadFromFile('logbg.jpg');  //背景
   //窗体背景
   Color:=RGB(235,244,244);

   bHave:=False;
   //读取用户列表
   ReadUserList();
   //是否允许新注册
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

//读取用户
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

//登录
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
      Application.MessageBox('  :( 帐号和密码都不能为空，重新输入!!  ','提示');
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
        Application.MessageBox('  :( 好像没有这个帐号哦!!  ','提示');
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
		     stips:='还没有设置密码提示哦 :(';
      ps:=EncodeBase64(spass);   
      if str <> ps then
      begin
        Application.MessageBox(pChar('密码不正确，请重新输入吧!!'+#13#13#13+'密码提示: '+stips),'提示');
        exit;
      end;
      Close;
      //登录成功
      dbConns.m_user := suser;  //用户
      dbConns.m_pass := ps;  //密码
      dbConns.m_tips:=stips;
      dbConns.m_ID:=sid;        //id
       dbConns.m_bTray:=false;  //是否到托盘
      if stray='1' then
          dbConns.m_bTray:=true;
      dbConns.m_lastLogt:=slogt; //登录时间
      if sfree='' then
          sfree:='10';
      dbConns.m_freeTime:=StrToInt(sfree); //空闲锁定
      //更新数据
      SQL.Clear;
      Close;
      SQL.Text:='Update TableUser set mlogt="'+DateTimeToStr(now)+'" where muser="'+ suser +'"';
      execSQL;
      //是否是第一个用户(管理员)
      Close;
      SQL.TExt:='Select id,mreg From TableUser Order By ID ASC';
      Open;
      sid2:=FieldByName('ID').AsString;
      dbConns.m_bFstUser:=false;
      if sid2=sid then
        dbConns.m_bFstUser:=true;
      Close;
      //返回
      bCanClose:=true;
      Self.ModalResult:=1;
   end;
end;


procedure TlogForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose:=bCanClose;
end;

end.
