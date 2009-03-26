unit user;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,Base64;

type
  TuserForm = class(TForm)
    GroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    muser: TEdit;
    mpass: TEdit;
    mpass0: TEdit;
    mpass1: TEdit;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    mtips: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    m_breg:Boolean;
  end;

var
  userForm: TuserForm;

implementation

uses
  dbConn;

{$R *.dfm}


procedure TuserForm.BitBtn1Click(Sender: TObject);
var
  u,p,p0,p1,tp:String;
  s,ps:String;
begin
    u:=trim(muser.Text);
    p:=trim(mpass.Text);
    p0:=trim(mpass0.Text);
    p1:=trim(mpass1.Text);
    tp:=trim(mtips.Text);

    if u='' then
    begin
      Application.MessageBox('请输入帐号!!','提示');
      exit;
    end;
    if (p='') And (not m_breg) then
    begin
      Application.MessageBox('请输入旧密码!!','提示');
      exit;
    end;
    if p0='' then
    begin
      Application.MessageBox('请输入新的密码!!','提示');
      exit;
    end;
    if p0 <> p1 then
    begin
      Application.MessageBox('两次输入的新密码不正确!!','提示');
      exit;
    end;
    //注册
    if m_breg then
    begin
        s:='Select muser From TableUser where muser="'+ u +'" ';
        with dbConns.dbQuery do
        begin
          close;
          sql.clear;
          sql.text:=s;
          Open;
          if Not eof then
          begin
             Application.MessageBox('帐号已经存在了，请重新输入!!','提示');
             muser.Text:='';
             exit;
          end;
          close;
          ps:=EncodeBase64(p0); //加密
          s:='Insert Into TableUser(muser,mpass,mtips)Values("'+u+'","'+ps+'","'+tp+'")';
          sql.Clear;
          sql.text:=s;
          execSQL;
          close;
          Application.MessageBox('已经成功注册用户!!','提示');
          self.ModalResult:=1;
        end;
    end
    else   //修改
    begin
      if dbConns.m_pass <> EncodeBase64(p) then
      begin
        Application.MessageBox('原密码不正确，无法修改!!','提示');
        exit;
      end;
      ps:=EncodeBase64(p0); //加密
      s:='Update TableUser set mpass="'+ps+'",mtips="'+tp+'" where muser="'+ u +'" ';
        with dbConns.dbQuery do
        begin
          close;
          sql.clear;
          sql.text:=s;
          execSql;
          close;
          dbConns.m_pass:=ps;
          dbConns.m_tips:=tp;
          self.ModalResult:=1;
        end;
    end;

end;

procedure TuserForm.FormCreate(Sender: TObject);
begin
   muser.Text:='';
   mpass.Text:='';
   mpass0.Text:='';
   mpass1.Text:='';

   //窗体背景
   Color:=RGB(235,244,244);
   
end;

procedure TuserForm.FormShow(Sender: TObject);
begin
    if m_breg then
   begin
     mpass.Enabled:=false;
     mpass.Visible:=false;
   end
   else
   begin
     Caption:='修改您的密码';
     groupbox.Caption:='修改密码';
   end;
end;

end.
