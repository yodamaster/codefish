unit ClassEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,dbConn;

type
  TclassFrm = class(TForm)
    groupbox1: TGroupBox;
    outListBox: TListBox;
    outBtnAdd: TBitBtn;
    outBtnEdt: TBitBtn;
    outBtnDel: TBitBtn;
    GroupBox2: TGroupBox;
    inListBox: TListBox;
    inBtnAdd: TBitBtn;
    inBtnEdt: TBitBtn;
    inBtnDel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure outBtnAddClick(Sender: TObject);
    procedure outBtnDelClick(Sender: TObject);
    procedure outBtnEdtClick(Sender: TObject);
    procedure inBtnAddClick(Sender: TObject);
    procedure inBtnEdtClick(Sender: TObject);
    procedure inBtnDelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadClass(flag:String);
    procedure UpdateClass(cname,cname0,flag:String;badd:Boolean);
    procedure DelClass(cname,flag:String);
    function getSelStr(flag:String):String;
  end;

var
  classFrm: TclassFrm;

implementation

{$R *.dfm}

procedure TclassFrm.FormCreate(Sender: TObject);
begin
    //读分类数据到列表中
    ReadClass('out');
    ReadClass('in');
end;


//增加支出项目
procedure TclassFrm.outBtnAddClick(Sender: TObject);
var
  cls:String;
begin
    cls := inputBox('支出项目','请输入一个支出项目名称','新名称...');
    cls:=trim(cls);
    if (cls<>'新名称...') And (cls<>'') then
    begin
      UpdateClass(cls,'','out',true);
      ReadClass('out');
    end;
end;
//删除
procedure TclassFrm.outBtnDelClick(Sender: TObject);
var
  cls:String;
begin
    cls:=getSelStr('out');
    if cls='' then
      exit;
    ////////////////////////  
    if Application.MessageBox('是否要删除此项目?','确认',MB_YESNO)=IDYES then
    begin
      DelClass(cls,'out');
      outListBox.DeleteSelected;
    end;
end;

//修改
procedure TclassFrm.outBtnEdtClick(Sender: TObject);
var
  cls0,cls:String;
begin
    cls0:=getSelStr('out');
    if cls0='' then
      exit;
    cls := inputBox('支出项目','请输入一个新的支出项目名称',cls0);
    cls:=trim(cls);
    if (cls<>cls0) And (cls<>'') then
    begin
      UpdateClass(cls,cls0,'out',false);
      ReadClass('out');
    end;
end;


procedure TclassFrm.inBtnAddClick(Sender: TObject);
var
  cls:String;
begin
    cls := inputBox('收入项目','请输入一个收入项目名称','新名称...');
    cls:=trim(cls);
    if (cls<>'新名称...') And (cls<>'') then
    begin
      UpdateClass(cls,'','in',true);
      ReadClass('in');
    end;
end;

procedure TclassFrm.inBtnDelClick(Sender: TObject);
var
  cls:String;
begin
    cls:=getSelStr('in');
    if cls='' then
      exit;
    ////////////////////////  
    if Application.MessageBox('是否要删除此项目?','确认',MB_YESNO)=IDYES then
    begin
      DelClass(cls,'in');
      inListBox.DeleteSelected;
    end
end;

procedure TclassFrm.inBtnEdtClick(Sender: TObject);
var
  cls0,cls:String;
begin
    cls0:=getSelStr('in');
    if cls0='' then
      exit;
    cls := inputBox('收入项目','请输入一个新的收入项目名称',cls0);
    cls:=trim(cls);
    if (cls<>cls0) And (cls<>'') then
    begin
      UpdateClass(cls,cls0,'in',false);
      ReadClass('in');
    end;
end;

function TclassFrm.getSelStr(flag: string):String;
var
  cls:String;
  i,j:Integer;
begin
    cls:='';
    if flag='out' then
       j:=outListBox.Items.Count
    else
       j:=inListBox.Items.Count;
    for i := 0 to j - 1 do
    begin
      if flag='out' then
      begin
       if outListBox.Selected[i] then
          cls:=outListBox.Items[i];
      end
      else
      begin
       if inListBox.Selected[i] then
          cls:=inListBox.Items[i];
      end;
    end;
    result:=cls;
end;

//read
procedure TclassFrm.ReadClass(flag:String);
var
  s:String;
begin
    with dbConns.dbQuery do
    begin
        if flag='out' then
          outListBox.Clear;
        if flag='in' then
          inListBox.Clear;
        SQL.Clear;
        Close;
        SQL.Text := 'Select mclass,mtype From TableClass Where mtype="'+ flag +'" order by ID Desc';
        Open;
        while Not Eof do
        begin
            s := FieldByName('mclass').AsString;
            if flag='out' then
              outListBox.AddItem(s,nil);
            if flag='in' then
              inListBox.AddItem(s,nil);
            next;
        end;
        close;
    end;
end;

//update
procedure TclassFrm.UpdateClass(cname,cname0,flag: string; badd:Boolean);
var
  s:string;
begin
  if badd=true then
  begin
  s:='Select ID From TableClass where mtype="'+flag+'" and mclass="'+cname+'"';
  with dbConns.dbQuery do
  begin
    close;
    sql.Clear;
    sql.text:=s;
    open;
    if not eof then
    begin
      close;
      exit;
    end
    else
    begin
      close;
      sql.clear;
      sql.text := 'Insert Into TableClass(mclass,mtype)values("'+cname+'","'+flag+'")';
      execSql;
      exit;
    end;
  end;
  end
  else //edit
  begin
    with dbConns.dbQuery do
    begin
      s:='Update TableClass Set mclass="'+cname+'" where mtype="'+flag+'" And mclass="'+cname0+'"';
      close;
      sql.Clear;
      sql.text:=s;
      ExecSql;
      close;
      s:='Update TableRecord Set mclass="'+cname+'" where mtype="'+flag+'" And mclass="'+cname0+'"';
      close;
      sql.Clear;
      sql.text:=s;
      ExecSql;
      close;
    end;
  end;

end;

//del
procedure TclassFrm.DelClass(cname: string; flag: string);
var
  s:String;
begin
  //s:='Select ID From TableClass where mtype="'+flag+'" and mclass="'+cname+'"';

  with dbConns.dbQuery do
  begin
    s:='Delete From TableClass where mtype="'+flag+'" and mclass="'+cname+'"';
    close;
    sql.Clear;
    sql.text:=s;
    ExecSql;
    close;
    if Application.MessageBox('是否要删除此项目对应的账目数据','确认',MB_YESNO)=IDYES then
    begin
      s:='Delete From TableRecord where mtype="'+flag+'" and mclass="'+cname+'"';
      close;
      sql.Clear;
      sql.text:=s;
      ExecSql;
      close;
    end;
  end;
end;

end.
