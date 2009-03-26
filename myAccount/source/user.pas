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
      Application.MessageBox('�������ʺ�!!','��ʾ');
      exit;
    end;
    if (p='') And (not m_breg) then
    begin
      Application.MessageBox('�����������!!','��ʾ');
      exit;
    end;
    if p0='' then
    begin
      Application.MessageBox('�������µ�����!!','��ʾ');
      exit;
    end;
    if p0 <> p1 then
    begin
      Application.MessageBox('��������������벻��ȷ!!','��ʾ');
      exit;
    end;
    //ע��
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
             Application.MessageBox('�ʺ��Ѿ������ˣ�����������!!','��ʾ');
             muser.Text:='';
             exit;
          end;
          close;
          ps:=EncodeBase64(p0); //����
          s:='Insert Into TableUser(muser,mpass,mtips)Values("'+u+'","'+ps+'","'+tp+'")';
          sql.Clear;
          sql.text:=s;
          execSQL;
          close;
          Application.MessageBox('�Ѿ��ɹ�ע���û�!!','��ʾ');
          self.ModalResult:=1;
        end;
    end
    else   //�޸�
    begin
      if dbConns.m_pass <> EncodeBase64(p) then
      begin
        Application.MessageBox('ԭ���벻��ȷ���޷��޸�!!','��ʾ');
        exit;
      end;
      ps:=EncodeBase64(p0); //����
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

   //���屳��
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
     Caption:='�޸���������';
     groupbox.Caption:='�޸�����';
   end;
end;

end.
