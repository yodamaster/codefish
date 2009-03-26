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
    m_lastLogt:String;//上次登录时间
    m_bFstUser:Boolean;//是否是第一个注册用户
    m_bDisReg:Boolean;//是否禁止注册
    m_freeTime:Integer;//空闲时间锁定 分钟
    m_bTray:Boolean;//是否最小化到托盘

     procedure Encode();
  end;

var
  dbConns: TdbConns;

implementation

{$R *.dfm}

function LockupFile(FileName:string;Lock:boolean=true):integer;
//加密、解密数据库,针对 Access 2000
var
f:File;
bf:array[0..63] of Byte;
i:integer;
const
fpos=64;
flen=64;
//下面改为自己的密钥,我是用随机生成的,请改为自己的密钥
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
  //下面的代码是判断是否被加密,你可以用二进制编辑器打开MDB文件对比,
  //我是用第64,65字节作为是否加密的标记,未加密与版本相关,加密后与版本和密钥相关
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
    //加密
    LockupFile(m_dataPath,true);
end;

procedure TdbConns.DataModuleCreate(Sender: TObject);
var
  reg:TRegistry;
begin
    m_dataPath := ExtractFilePath(Paramstr(0))+'MyAccount.db';
    m_connStr := 'Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source='+m_dataPath;
    //创建并连接数据库
    m_bConn := CreateDbTable();
    //修改.ldb类型
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

//创建数据库和表
function TdbConns.CreateDbTable():Boolean;
var
  db:OleVariant;
  str:String;
begin
    if FileExists(m_dataPath) then //存在数据库
    begin
      //解密
      LockupFile(m_dataPath,false);
      //conn
      dbConnect.ConnectionString := m_connStr;
      dbConnect.Connected := true;
      dbQuery.Connection := dbConnect;
      Result:=true;
      exit;
    end;
    
    //数据库没有存在，创建
    try
      db:=CreateOleObject('ADOX.Catalog');
      db.Create('Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ m_dataPath);
      Result:=true;
    except
      Result:=false;
    end;
    //创建数据表
    dbConnect.ConnectionString := m_connStr;
    dbConnect.Connected := true;
    dbQuery.Connection := dbConnect;

    //账本记录表 TableRecord
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
    //用户表
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
    //分类表
    str := 'Create Table TableClass(ID integer identity(1,1) primary key,';
    str := str +              'mclass varchar(50) not null,';
    str := str +              'mstr1 varchar(250),';
    str := str +              'mstr2 varchar(250),';
    str := str +              'mtype varchar(50) not null';
    str := str + ')';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    //////////////////////
    //添加初始的记录
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("早餐","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("午餐","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("晚餐","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("交通费","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("购物","out")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;

    //
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("工资","in")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("奖金","in")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    str := 'Insert Into TableClass(mclass,mtype)Values';
    str := str + '("福利","in")';
    dbQuery.SQL.Text := str;
    dbQuery.ExecSQL;
    //str := 'Insert Into TableClass(mclass,mtype)Values';
    //str := str + '("父母资助","in")';
    //dbQuery.SQL.Text := str;
    //dbQuery.ExecSQL;
    //
    dbQuery.Close;
    dbConnect.Connected := false;
    Result:=true;
end;

end.
