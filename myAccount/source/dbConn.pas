unit dbConn;

interface

uses
  Windows,SysUtils, Classes, DB, ADODB, ComObj,Registry;

type
  TdbConns = class(TDataModule)
    dbConnect: TADOConnection;
    dbQuery: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function CreateDbTable():Boolean;
  public
    { Public declarations }
    m_bConn:Boolean;
    m_connStr:String;
    m_dataPath:STring;
	m_ID:String;
    m_user,m_pass:String;
    m_tips:String;
    m_lastLogt:String;//�ϴε�¼ʱ��
    m_bFstUser:Boolean;//�Ƿ��ǵ�һ��ע���û�
    m_bDisReg:Boolean;//�Ƿ��ֹע��
    m_freeTime:Integer;//����ʱ������ ����
    m_bTray:Boolean;//�Ƿ���С��������

     procedure Encode();
  end;

var
  dbConns: TdbConns;

implementation

{$R *.dfm}

function LockupFile(FileName:string;Lock:boolean=true):integer;
//���ܡ��������ݿ�,��� Access 2000
var
f:File;
bf:array[0..63] of Byte;
i:integer;
const
fpos=64;
flen=64;
//�����Ϊ�Լ�����Կ,������������ɵ�,���Ϊ�Լ�����Կ
pw:array[0..63] of byte=
     ($97,$A0,$0C,$A1,$06,$59,$0A,$6D,
      $91,$33,$51,$57,$D4,$A3,$94,$16,
      $3D,$B2,$C7,$A0,$7D,$A3,$30,$EE,
      $34,$D6,$C1,$FF,$F7,$EC,$A5,$1F,
      $71,$2C,$19,$68,$E3,$25,$7D,$8B,
      $D3,$95,$AB,$C9,$02,$8A,$87,$44,
      $9F,$C7,$D7,$7D,$BA,$69,$56,$15,
      $FB,$CB,$03,$D6,$94,$A6,$BF,$F7);
begin
result:=-1;
if not FileExists(FileName) then exit;
try
  AssignFile(f,Filename);
  Reset(f,1);
  Seek(f,fpos);
  BlockRead(f,bf,flen);
  //����Ĵ������ж��Ƿ񱻼���,������ö����Ʊ༭����MDB�ļ��Ա�,
  //�����õ�64,65�ֽ���Ϊ�Ƿ���ܵı��,δ������汾���,���ܺ���汾����Կ���
  if lock and (bf[0]=$2B) and (bf[1]=$EE)
  or not lock and (bf[0]=$BC) and (bf[1]=$4E)
  or not ((bf[0]=$2B) and (bf[1]=$EE))
  and not ((bf[0]=$BC) and (bf[1]=$4E)) then
  begin
  result:=0;
  exit;
  end;
  for i:=0 to flen-1 do
  bf[i]:=bf[i] xor pw[i mod 64];
  Seek(f,fpos);
  BlockWrite(f,bf,flen);
  result:=1;
finally
  CloseFile(f);
end;
end;

procedure TdbConns.Encode;
begin
    //����
    LockupFile(m_dataPath,true);
end;

procedure TdbConns.DataModuleCreate(Sender: TObject);
var
  reg:TRegistry;
begin
    m_dataPath := ExtractFilePath(Paramstr(0))+'MyAccount.db';
    m_connStr := 'Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source='+m_dataPath;
    //�������������ݿ�
    m_bConn := CreateDbTable();
    //�޸�.ldb����
    reg:=TRegistry.Create;
    try
      reg.RootKey:=HKEY_CLASSES_ROOT;
      reg.OpenKey('.ldb',true);
      reg.WriteString('','system');
    finally
      reg.closekey;
      reg.free;
    end;
end;

procedure TdbConns.DataModuleDestroy(Sender: TObject);
begin
    Encode;
end;

//�������ݿ�ͱ�
function TdbConns.CreateDbTable():Boolean;
var
  db:OleVariant;
  str:String;
begin
    if FileExists(m_dataPath) then //�������ݿ�
    begin
      //����
      LockupFile(m_dataPath,false);
      //conn
      dbConnect.ConnectionString := m_connStr;
      dbConnect.Connected := true;
      dbQuery.Connection := dbConnect;
      Result:=true;
      exit;
    end;
    
    //���ݿ�û�д��ڣ�����
    try
      db:=CreateOleObject('ADOX.Catalog');
      db.Create('Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ m_dataPath);
      Result:=true;
    except
      Result:=false;
    end;
    //�������ݱ�
    dbConnect.ConnectionString := m_connStr;
    dbConnect.Connected := true;
    dbQuery.Connection := dbConnect;

    //�˱���¼�� TableRecord
    str := 'Create Table TableRecord(ID integer identity(1,1) primary key,';
    str := str +              'mdate Date not null default date(),';
    str := str +              'mtype varchar(50) not null,';
    str := str +              'mclass varchar(50) not null,';
    str := str +              'mmoney double not null default 0,';
    str := str +              'mabout varchar(250),';
    str := str +              'mmonth Date not null,';
    str := str +              'mstr1 varchar(250),';
    str := str +              'mstr2 varchar(250),';
    str := str +              'muser varchar(50) not null';
    str := str + ')';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    //�û���
    str := 'Create Table TableUser(ID integer identity(1,1) primary key,';
    str := str +              'muser varchar(50) not null,';
    str := str +              'mpass varchar(50) not null,';
    str := str +              'mlogt varchar(50),';
    str := str +              'mtray integer default 1,';
    str := str +              'mreg integer default 0,';
    str := str +              'mfree integer default 10,';
    str := str +              'mstr1 varchar(250),';
    str := str +              'mstr2 varchar(250),';
    str := str +              'mtips varchar(200)';
    str := str + ')';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    //�����
    str := 'Create Table TableClass(ID integer identity(1,1) primary key,';
    str := str +              'mclass varchar(50) not null,';
    str := str +              'mstr1 varchar(250),';
    str := str +              'mstr2 varchar(250),';
    str := str +              'mtype varchar(50) not null';
    str := str + ')';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    //////////////////////
    //��ӳ�ʼ�ļ�¼
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("���","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("���","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("���","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("��ͨ��","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("����","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;

    //
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("����","in")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("����","in")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("����","in")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    //str := 'Insert Into TableClass(mclass,mtype)Values';
    //str := str + '("��ĸ����","in")';
    //dbQuery.SQL.Text := str;
    //dbQuery.ExecSQL;
    //
    dbQuery.Close;
    dbConnect.Connected := false;
    Result:=true;
end;

end.
