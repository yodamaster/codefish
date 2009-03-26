unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, Provider, DB, WideStrings, SqlExpr, ADODB, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Menus, ImgList, jpeg, AppEvnts,Base64;

type
  TmainForm = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    statusbar: TStatusBar;
    GroupBox1: TGroupBox;
    outList: TListView;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    outHistoryBtn: TSpeedButton;
    outDate1: TDateTimePicker;
    outDate2: TDateTimePicker;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    inHistoryBtn: TSpeedButton;
    inDate1: TDateTimePicker;
    inDate2: TDateTimePicker;
    GroupBox4: TGroupBox;
    inList: TListView;
    Label5: TLabel;
    outDate: TDateTimePicker;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    outClass: TComboBox;
    outMoney: TEdit;
    outAbout: TMemo;
    outBtnAdd: TBitBtn;
    outBtnRedo: TBitBtn;
    inDate: TDateTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    inClass: TComboBox;
    inMoney: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    inAbout: TMemo;
    inBtnAdd: TBitBtn;
    inBtnRedo: TBitBtn;
    dateTimer: TTimer;
    Label13: TLabel;
    Label14: TLabel;
    outTips: TLabel;
    inTips: TLabel;
    listMenu: TPopupMenu;
    muModify: TMenuItem;
    muDelete: TMenuItem;
    listImg: TImageList;
    groupboxtj: TGroupBox;
    GroupBox5: TGroupBox;
    statList: TListView;
    statMoreList: TListView;
    imgPie: TImage;
    Label15: TLabel;
    statDate1: TDateTimePicker;
    Label16: TLabel;
    statDate2: TDateTimePicker;
    statBtn: TSpeedButton;
    bDayStat: TRadioButton;
    bMonthStat: TRadioButton;
    exportBtn: TSpeedButton;
    statInfo: TMemo;
    ImageList1: TImageList;
    classView: TListView;
    Image1: TImage;
    Label17: TLabel;
    pzUser: TLabel;
    pzLogt: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    pzPass: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    GroupBox6: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    pzFreeTime: TEdit;
    pzTray: TCheckBox;
    pzDisReg: TCheckBox;
    BitBtn3: TBitBtn;
    trayIcon: TTrayIcon;
    trayMenu: TPopupMenu;
    muShow: TMenuItem;
    muLock: TMenuItem;
    muClose: TMenuItem;
    muAbout: TMenuItem;
    freeTimer: TTimer;
    ApplicationEvents1: TApplicationEvents;
    waitPn: TPanel;
    saveDlg: TSaveDialog;
    Label18: TLabel;
    Label19: TLabel;
    BitBtn4: TBitBtn;
    classEditOut: TSpeedButton;
    classEdtIn: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure dateTimerTimer(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure outBtnAddClick(Sender: TObject);
    procedure inBtnRedoClick(Sender: TObject);
    procedure outBtnRedoClick(Sender: TObject);
    procedure inBtnAddClick(Sender: TObject);
    procedure outHistoryBtnClick(Sender: TObject);
    procedure inHistoryBtnClick(Sender: TObject);
    procedure statBtnClick(Sender: TObject);
    procedure statListClick(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure muShowClick(Sender: TObject);
    procedure muLockClick(Sender: TObject);
    procedure muCloseClick(Sender: TObject);
    procedure muAboutClick(Sender: TObject);
    procedure freeTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure muModifyClick(Sender: TObject);
    procedure muDeleteClick(Sender: TObject);
    procedure listMenuPopup(Sender: TObject);
    procedure exportBtnClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure classEditOutClick(Sender: TObject);
    procedure classEdtInClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetListViewCol(flag:String);//����listview��
    procedure SetStatus(i:Integer;txt:String); //����״̬��
    procedure ReadClass(flag:String);//��ȡ����
    procedure ShowMsg(s:String);       //��ʾ��Ϣ
    function AddToDb(flag:String;d:TDateTime):Boolean;  //���뵽��
    procedure SetDefaultDate(flag:String);  //Ĭ����������
    procedure ReadListView(flag:string;isql:String); //���б�
    procedure UpdateClass(cls,tpe:String;badd:Boolean); //���·���
    procedure DrawPie(img:TImage;num1,num2:Real;str1,str2:String); //���Ʊ�ͼ
    procedure DrawPieText(img:Timage;s1,s2:String;c1:Tcolor;c2:Tcolor);
    function GetRealNum(f:Real;n:Integer):String;  //ȡС��
    function GetMonthOne(d:TDateTime):String; //�µĵ�һ��
    procedure statShowDetail(dt:String);
    procedure reSetSize(flag:String); //���ô��ڴ�С
    procedure About();
    procedure Lock();
    procedure statClassView(d1,d2:TDateTime);
    procedure ExportData(fn:String);
  public
    { Public declarations }
    m_dataPath:STring;
    m_connStr:String;
    m_user,m_pass:String;

    m_maxline:Integer;
    m_date,m_class,m_about,m_type,m_money:String;
    m_bstat:Boolean; //�Ƿ��Ѿ�ͳ��

    m_title:String;  //����
    m_version:String;//�汾

    m_bLock:Boolean; //�Ƿ�Ҫ����(����ʱ��ʾ����)
  end;

var
  mainForm: TmainForm;

implementation

uses
  dbConn,StrUtils,math,DateUtils,user,ShellApi,login,modfiy,about,classEdt;

{$R *.dfm}

function IsNumeric(Vaule:String):Boolean;   //�ж�Vaule�ǲ�������
var
i:integer;
begin
result:=true;   //���÷���ֵΪ �ǣ��棩
Vaule:=trim(Vaule);  //ȥ�ո�
  for i:=1 to length(Vaule) do  //׼��ѭ��
    begin
      if not (Vaule[i] in ['0'..'9']) then  //���Vaule�ĵ�i���ֲ���0-9�е���һ��
        begin
          result:=false;  //����ֵ ���ǣ��٣�
          exit;  //�˳�����
        end;
    end;
end;

//����
procedure TmainForm.FormCreate(Sender: TObject);
begin
    m_title := '�ҵļ�ͥ�����˱�';
    m_version:='v1.2 build090326';
    caption := m_title;
    m_bLock:=false;
    //���屳��
    Color:=RGB(235,244,244);

    //date ��ӦVistaϵͳ
    DateSeparator := '-';
    ShortDateFormat := 'yyyy-mm-dd';
    LongDateFormat := 'yyyy-mm-dd';
    //
    m_user := dbConns.m_user;
    m_pass := dbConns.m_pass;
    SetStatus(0,'������..');
    SetStatus(1,'��ǰ�û�: '+ m_user);
    SetStatus(3, m_title+m_version);
    dateTimer.Interval := 500;
    dateTimer.Enabled := True;
    outTips.Width := 130;
    outTips.Height:=15;
    outTips.Caption:='';
    inTips.Width := 130;
    inTips.Height:=15;
    inTips.Caption:='';
    m_maxline := 300; //Ĭ��ȡǰ������
    m_bstat:=false;
    outDate.Date:=DateOf(Now);
    inDate.Date:=DateOf(Now);

    //�����б�
    SetListViewCol('out');
    ReadClass('out');
    ReadClass('in');
    SetListViewCol('in');
    pageControl.ActivePageIndex := 0;
    ReadListView('out','');
    ReadListView('in','');
    SetDefaultDate('out');
    SetDefaultDate('in');
    SetDefaultDate('stat');
    SetStatus(0,'����');
    reSetSize('');
    waitPn.Visible:=false;
    exportBtn.Enabled:=false;

    //����
    pzUser.Caption:='��ǰ��¼�ʺţ�'+dbConns.m_user;
    pzLogt.Caption:='�ϴε�¼ʱ�䣺'+dbConns.m_lastLogt;
    pzPass.Text:='';
    pzFreeTime.Text:=IntToStr(dbConns.m_freeTime);
    pzTray.Checked:=dbConns.m_bTray;
    pzDisReg.Checked:=dbConns.m_bDisReg;
    pzDisreg.Enabled:=false;
    if dbConns.m_bFstUser then
       pzDisreg.Enabled:=true;

    //����ͼ��
    if dbConns.m_bTray then
    begin
      trayIcon.Visible:=true;
      trayIcon.Hint:=m_title;
    end;

    //������ʱ��
    freeTimer.Interval:=1000;
    freeTimer.Enabled:=true;
end;

//����Ĭ������ �����£�
procedure TmainForm.SetDefaultDate(flag: string);
var
  y,m:Word;
begin
    y:=YearOf(Now);
    m:=MonthOf(Now);
    if flag='out' then
    begin
      outDate1.Date := StrToDate(IntToStr(y)+'-'+IntToStr(m)+'-1');
      outDate2.Date := Today();
    end;
    if flag='in' then
    begin
      inDate1.Date := StrToDate(IntToStr(y)+'-'+IntToStr(m)+'-1');
      inDate2.Date := Today();
    end;
    if flag='stat' then
    begin
      y:=YearOf(IncMonth(Now,-3));
      m:=MonthOf(IncMonth(Now,-3));
      statDate1.Date := StrToDate(IntToStr(y)+'-'+IntToStr(m)+'-1');
      statDate2.Date := Today();
    end;
end;

//��ʱ���¼�
procedure TmainForm.dateTimerTimer(Sender: TObject);
var
  t:TDateTime;
  s:String;
begin
    //״̬����ʾʱ��
    t := Now;
    s := DateTimeToStr(t);
    SetStatus(2,s);
end;

//��ʾ��Ϣ
procedure TmainForm.ShowMsg(s: string);
begin
  Application.MessageBox(pchar(s),pchar(m_title),MB_ICONWARNING+MB_OK);
end;

//ȡС��λ
function TmainForm.GetRealNum(f: Real; n: Integer) :String;
var
  i:Integer;
  s:String;
begin
  s:=FloatToStr(f);
  i := pos('.',s);
  if i>0 then
    s:=LeftStr(s,i+n); //��λС��
  Result:=s;
end;

//�µĵ�һ��
function TmainForm.GetMonthOne(d: TDateTime):String;
var
  y,m:Word;
begin
    y:=YearOf(d);
    m:=MonthOf(d);
    Result := IntToStr(y)+'-'+IntToStr(m)+'-1';  //�·ݵ�һ��
end;

//��ʼͳ��
procedure TmainForm.statBtnClick(Sender: TObject);
var
  d0,d1,d2:TDateTime;
  iSql,str:String;
  days,mons:Integer;
  inNum,outNum,decNum:Real;
  inStr,outStr,decStr:String;
  inAll,outAll,decAll:Real;
  bin,bout:Boolean;
  item:TListItem;
begin
   d1:=statDate1.Date;
   d2:=statDate2.Date;
   days:=DaysBetween(d1,d2)+1;  //ͳ������
   mons:=0;
   inNum:=0; outNum:=0;decNum:=0;
   inAll:=0;outAll:=0;decAll:=0;
   bin:=false;bout:=false;
   statList.Items.Clear;
   statMoreList.Items.Clear;
   if d1>d2 then
   begin
       ShowMsg('��ʼ���ڲ�Ӧ�ô��ڽ�������');
       statBtn.Enabled:=true;
       exit;
   end;
   statBtn.Enabled:=false;
   waitPn.Visible:=true;
   classView.Items.Clear;
   Self.Update;
   /////////////////////////////////////////////////////////////////////////////
   //����ͳ��
   if bDayStat.Checked then
   begin
   if days>365*2 then
   begin
       ShowMsg('����ͳ��, ���ֻ��ͳ��2��!');
       statBtn.Enabled:=true;
       exit;
   end;
   d0:=d2;
   while d0>=d1 do
   begin
      bin:=false; bout:=false;
      inStr:=''; outStr:='';
      inNum:=0;outNum:=0;

      //���� ��
      isql:= 'Select Sum(mmoney) As mins From TableRecord Where mtype="in"';
      isql:=isql+' And mdate=#'+DateToStr(d0)+'# And muser="'+m_user+'"';
      with dbConns.dbQuery do
      begin
          SQL.Clear;
          Close;
          SQL.Text := isql;
          Open;
          inNum:=0;
          inStr:='';
          if Not Eof then
          begin
             inNum:=FieldByName('mins').AsFloat;
             inStr:=FieldByName('mins').AsString;
          end;
          if inStr<>'' then
            bin:=true
          else
            inStr:='0';
          close;
      end;

      //֧�� ��
      isql:= 'Select Sum(mmoney) As mouts From TableRecord Where mtype="out"';
      isql:=isql+' And mdate=#'+DateToStr(d0)+'# And muser="'+m_user+'"';
      with dbConns.dbQuery do
      begin
          SQL.Clear;
          Close;
          SQL.Text := isql;
          Open;
          outNum:=0;
          outStr:='';
          if Not Eof then
          begin
             outNum:=FieldByName('mouts').AsFloat;
             outStr:=FieldByName('mouts').AsString;
          end;
          if outStr<>'' then
            bout:=true
          else
            outStr:='0';
          close;
      end;

      //�����һ�������ݣ��ͼ���list
      if (bin=true) Or (bout=true) then
      begin
        item:=statList.Items.Add;
        item.Caption := DateToStr(d0);    //����
        item.SubItems.Add(inStr);         //����
        item.SubItems.Add(outStr);        //֧��
        item.SubItems.Add(FloatToStr(inNum-outNum));//��ֵ
      end;
      //�����
      inAll:=inAll + inNum;
      outAll:=outAll + outNum;
      //
      d0:=IncDay(d0,-1); //������ 1
   end;
   end;
   /////////////////////////////////////////////////////////////////////////////

   //����ͳ��
   if bMonthStat.Checked then
   begin
       d0 := StrToDate(GetMonthOne(d2));
       d1 := StrToDate(GetMonthOne(d1));
       while d0>=d1 do
       begin
          bin:=false; bout:=false;
          inStr:=''; outStr:='';
          inNum:=0;outNum:=0;

          //����
          isql:= 'Select Sum(mmoney) As mins From TableRecord Where mtype="in"';
          isql:=isql+' And mmonth=#'+DateToStr(d0)+'# And muser="'+m_user+'"';
          with dbConns.dbQuery do
          begin
              SQL.Clear;
              Close;
              SQL.Text := isql;
              Open;
              inNum:=0;
              inStr:='';
              if Not Eof then
              begin
              inNum:=FieldByName('mins').AsFloat;
              inStr:=FieldByName('mins').AsString;
              end;
              if inStr<>'' then
                bin:=true
              else
              inStr:='0';
              close;
          end;

          //֧��
          isql:= 'Select Sum(mmoney) As mouts From TableRecord Where mtype="out"';
          isql:=isql+' And mmonth=#'+DateToStr(d0)+'# And muser="'+m_user+'"';
          with dbConns.dbQuery do
          begin
              SQL.Clear;
              Close;
              SQL.Text := isql;
             Open;
              outNum:=0;
              outStr:='';
              if Not Eof then
              begin
             outNum:=FieldByName('mouts').AsFloat;
             outStr:=FieldByName('mouts').AsString;
              end;
              if outStr<>'' then
              bout:=true
              else
              outStr:='0';
            close;
          end;

          //�����һ�������ݣ��ͼ���list
          //if (bin=true) Or (bout=true) then
          //begin
            item:=statList.Items.Add;
            item.Caption := IntToStr(YearOf(d0))+'-'+IntToStr(MonthOf(d0));    //�·�
            item.SubItems.Add(inStr);         //����
            item.SubItems.Add(outStr);        //֧��
            item.SubItems.Add(FloatToStr(inNum-outNum));//��ֵ
          //end;
          //�����
          inAll:=inAll + inNum;
          outAll:=outAll + outNum;

          mons:=mons+1;
          d0:=IncMonth(d0,-1);   //������ 1
       end;
   end;

   /////////////////////////////////////
   ///ͳ�Ƹ�����Ŀ
   if bMonthStat.Checked then
   begin
       d1 := StrToDate(GetMonthOne(d1));
       d2 := StrToDate(GetMonthOne(d2));
   end;
   statClassView(d1,d2);

   /////////////////////////////////////////////////////////////////////////////
   //���Ʊ�ͼ
   DrawPie(imgPie,inAll,outAll,'����: ','֧��: ');
   //���뵽ͳ����Ϣ
   statInfo.Clear;
   //statInfo.Lines.Add('- - - - - - - - -');
   statInfo.Lines.Add('ͳ������:  '+ IntToStr(days));
   statInfo.Lines.Add('������:  '+ GetRealNum(inAll,2));
   statInfo.Lines.Add('��֧��:  '+ GetRealNum(outAll,2));

   if bMonthStat.Checked then
   begin
     statInfo.Lines.Add('�¾�����:  '+ GetRealNum(inAll / mons,2));
     statInfo.Lines.Add('�¾�֧��:  '+ GetRealNum(outAll / mons,2));
   end;

   statInfo.Lines.Add('�վ�����:  '+ GetRealNum(inAll / days,2));
   statInfo.Lines.Add('�վ�֧��:  '+ GetRealNum(outAll / days,2));
   statInfo.Lines.Add('- - - - - - - - -');
   statInfo.Lines.Add('����:  '+ GetRealNum(inAll-outAll,2));
   //
   statBtn.Enabled:=true;
   waitPn.Visible:=false;
   exportBtn.Enabled:=true;
   m_bstat:=true;
end;

//��Ŀͳ��
procedure TmainForm.statClassView(d1,d2:TDateTime);
var
  s,c,m:String;
  i,j,k:Integer;
  item:Tlistitem;
begin
   classView.Items.Clear;
   j:=outClass.Items.Count;
   k:=inClass.Items.Count;
   for i := 0 to (j+k-2) do
   begin
       if i<k then
         c:=inClass.Items[i]
       else
         c:=outClass.Items[i-k];
         
       s:='Select SUM(mMoney) As mny From TableRecord';
       s:=s+' where mclass="'+c+'"';
       if bMonthStat.Checked then
          s:=s+' and (mmonth between #'+DateToStr(d1)+'# and #'+DateToStr(d2)+'#)'
       else
          s:=s+' and (mdate between #'+DateToStr(d1)+'# and #'+DateToStr(d2)+'#)';
       s:=s+' And muser="'+m_user+'"';
       //ShowMsg(s);
       with dbConns.dbQuery do
       begin
          close;
          sql.text:=s;
          Open;
          if not eof then
          begin
             m:=FieldByName('mny').AsString;
             if m <> '' then
             begin
               item:=classView.Items.add;
               item.Caption:=c;
               item.SubItems.Add(m);
             end;
          end;
          close;
       end;
   end;

end;

//����鿴ͳ����ϸ���
procedure TmainForm.statListClick(Sender: TObject);
var
  dt:String;
begin
     if statList.SelCount=0 then
        exit;
     dt:=statList.Selected.Caption;// statList.Items.Item[idx].Caption; //����
     if bMonthStat.Checked then
        dt:=dt+'-1';
     statShowDetail(dt);
end;

//ͳ����ϸ��Ϣ
procedure TmainForm.statShowDetail(dt: string);
var
  item:TListItem;
  s:String;
begin
    statMoreList.Clear;
    Self.Update;
    s:='Select * From TableRecord Where mdate=#'+dt+'#';
    if bMonthStat.Checked then
      s:='Select * From TableRecord Where mmonth=#'+dt+'#';

    s:=s+' And muser="'+m_user+'" Order By mdate Desc,ID Desc';
    with dbConns.dbQuery do
    begin
      close;
      SQL.Clear;
      Sql.Text:=s;
      Open;
      while Not Eof do
      begin
        item:=statMoreList.Items.Add;
        item.Caption := FieldByName('mdate').AsString;    //�·�
        s:='֧��';
        if FieldByName('mtype').AsString = 'in' then
          s:='����';
        item.SubItems.Add(s);
        item.SubItems.Add(FieldByName('mclass').AsString);
        item.SubItems.Add(FieldByName('mmoney').AsString);
        item.SubItems.Add(FieldByName('mabout').AsString);
        Next;
      end;
      close;
    end;
end;

/////////////////////////////////////////////////////////////

//������д�뵽�����ı���
procedure TMainForm.ReadClass(flag:String);
var
  s:String;
begin
    with dbConns.dbQuery do
    begin
        if flag='out' then
          outClass.Items.Clear;
        if flag='in' then
          inClass.Items.Clear;
        SQL.Clear;
        Close;
        SQL.Text := 'Select mclass,mtype From TableClass Where mtype="'+ flag +'"  order by ID Desc';
        Open;
        while Not Eof do
        begin
            s := FieldByName('mclass').AsString;
            if flag='out' then
              outClass.Items.Add(s);
            if flag='in' then
              inClass.Items.Add(s);
            next;
        end;
        close;
    end;
end;

//����д����
procedure TmainForm.inBtnRedoClick(Sender: TObject);
begin
   inClass.Text:='';
   inMoney.Text:='0';
   inAbout.Text:='';
end;

//����д֧��
procedure TmainForm.outBtnRedoClick(Sender: TObject);
begin
   outClass.Text:='';
   outMoney.Text:='0';
   outAbout.Text:='';
end;

//֧����ʷ
procedure TmainForm.outHistoryBtnClick(Sender: TObject);
var
  d1,d2:String;
  iSql:String;
begin
   d1:=DateToStr(outDate1.Date);
   d2:=DateToStr(outDate2.Date);
   isql:='Select * From TableRecord Where mdate>=#'+d1+'# And mdate<=#'+d2+'# And ';
   isql:=isql + 'muser="'+ m_user +'" And mtype="out" Order By mdate Desc,ID Desc';
   //showmessage(isql);
   ReadListView('out',isql);
end;

//������ʷ
procedure TmainForm.inHistoryBtnClick(Sender: TObject);
var
  d1,d2:String;
  iSql:String;
begin
   d1:=DateToStr(inDate1.Date);
   d2:=DateToStr(inDate2.Date);
   isql:='Select * From TableRecord Where mdate>=#'+d1+'# And mdate<=#'+d2+'# And ';
   isql:=isql + 'muser="'+ m_user +'" And mtype="in" Order By mdate Desc,ID Desc';
   //showmessage(isql);
   ReadListView('in',isql);

end;

//��¼���
function TMainForm.AddToDb(flag:String;d:TDateTime):Boolean;
var
  s,dm:String;
begin
    dm := GetMonthOne(d);  //�·�
    with dbConns.dbQuery Do
    begin
      Close;
      SQL.clear;
      s := 'Insert Into TableRecord(mdate,mclass,mmoney,mabout,mmonth,muser,mtype)values';
      s := s+'("'+m_date+'","'+m_class+'",'+m_money+',"'+m_about+'","'+dm+'","'+m_user+'","'+flag+'")';
      SQL.Text := s;
      try
        ExecSQL;
        Result:=true;
      except
         Result:=false;
      end;
      close;
    end;
end;

//����¼���б�
procedure TmainForm.ReadListView(flag: string;isql:String);
var
  itm:TListItem;
  s,s1:String;
  i:integer;
begin
    if flag='out' then outList.Items.Clear;
    if flag='in' then inList.Items.Clear;
    listImg.Height := 20;
    listImg.Width := 5;
    outList.SmallImages := listImg;
    inList.SmallImages := listImg;
    with dbConns.dbQuery do
    begin
      close;
      SQL.Clear;
      s:='Select top '+inttostr(m_maxline)+' * From TableRecord Where ';
      //s:='Select * From TableRecord Where ';
      s:=s + 'muser="'+ m_user +'" And mtype="'+flag+'" Order By mdate Desc,ID Desc';
      if isql<>'' then
          s:=isql;
      SQL.Text := s;
     try
        Open;
      except
        close;
        ShowMsg('�޷���ȡ��¼��!!');
        exit;
      end;
      while Not Eof do
      begin
        if flag='out' then
          itm := outList.Items.Add
        else
           itm := inList.Items.Add;
        itm.Caption := FieldByName('ID').AsString;
        itm.SubItems.Add(FieldByName('mdate').AsString);
        itm.SubItems.Add(FieldByName('mclass').AsString);
        s1:=FieldByName('mmoney').AsString;
        i := pos('.',s1);
        s:=s1;
        if i>0 then
          s:=LeftStr(s1,i+2); //��λС��
        itm.SubItems.Add(s);
        itm.SubItems.Add(FieldByName('mabout').AsString);
        next;
      end;
      close;
    end;
end;

//���֧����¼
procedure TmainForm.outBtnAddClick(Sender: TObject);
begin
    m_date := DateToStr(outDate.Date);
    m_class := Trim(outClass.Text);
    m_money := Trim(outMoney.Text);
    m_about := Trim(outAbout.Text);
    if m_class='' then
    begin
      ShowMsg('���������ѵ���Ŀ!!');
      exit;
    end;
    if m_money='' then
    begin
      ShowMsg('���������ѵĽ��!!');
      exit;
    end;
    try
      strToFloat(m_money);
    except
      ShowMsg('���ѵĽ�����������!!');
      exit;
    end;
    //���
    if AddToDb('out',outDate.Date)=true then
    begin
      outBtnRedoClick(nil);
      ReadListView('out','');
      SetDefaultDate('out');
      UpdateClass(m_class,'out',true);
      outTips.Caption:='�Ѿ��ɹ�����һ����¼!';
      Update;
      sleep(750);
      outTips.Caption:='';
    end
    else
    begin
      ShowMsg('�����¼�������Ժ�����!');
      exit;
    end;
end;

//������� ��¼
procedure TmainForm.inBtnAddClick(Sender: TObject);
begin
    m_date := DateToStr(inDate.Date);
    m_class := Trim(inClass.Text);
    m_money := Trim(inMoney.Text);
    m_about := Trim(inAbout.Text);
    if m_class='' then
    begin
      ShowMsg('�������������Ŀ!!');
      exit;
    end;
    if m_money='' then
    begin
      ShowMsg('����������Ľ��!!');
      exit;
    end;
    try
      strToFloat(m_money);
    except
      ShowMsg('����Ľ�����������!!');
      exit;
    end;
    //���
    if AddToDb('in',outDate.Date)=true then
    begin
      inBtnRedoClick(nil);
      ReadListView('in','');
      SetDefaultDate('in');
      UpdateClass(m_class,'in',true);
      inTips.Caption:='�Ѿ��ɹ�����һ����¼!';
      Update;
      sleep(750);
      inTips.Caption:='';
    end
    else
    begin
      ShowMsg('�����¼�������Ժ�����!');
      exit;
    end;
end;

//�޸ļ�¼
procedure TmainForm.muModifyClick(Sender: TObject);
var
  ids,dt,cls,mny,abt:String;
  s:String;
begin
     modify:=Tmodify.Create(nil);
     if pageControl.ActivePageIndex=0 then
     begin
        if outList.SelCount=0 then
           exit;
        ids:=outList.Selected.caption;
        dt:=outList.Selected.SubItems[0];
        cls:=outList.Selected.SubItems[1];
        mny:=outList.Selected.SubItems[2];
        abt:=outList.Selected.SubItems[3];
        modify.m_id:=ids;
        modify.m_type:='out';
        modify.mClass.Items:=outClass.Items;
        modify.group.Caption:='֧����¼�޸�';
     end
     else
     begin
        if inList.SelCount=0 then
           exit;
        ids:=inList.Selected.caption;
        dt:=inList.Selected.SubItems[0];
        cls:=inList.Selected.SubItems[1];
        mny:=inList.Selected.SubItems[2];
        abt:=inList.Selected.SubItems[3];
        modify.m_id:=ids;
        modify.m_type:='in';
        modify.mClass.Items:=inClass.Items;
        modify.group.Caption:='�����¼�޸�';
     end;
     modify.mClass.Text:=cls;
     modify.mMoney.Text:=mny;
     modify.mAbout.Text:=abt;
     modify.mDate.Date:=StrToDate(dt);
     if modify.ShowModal=1 then
     begin
        //��ʼ�޸�
        s:='Update TableRecord Set mdate="'+modify.m_date+'",mclass="'+modify.m_class+'",';
        s:=s+'mmoney='+modify.m_money+',mabout="'+modify.m_about+'",mmonth="'+GetMonthOne(modify.mDate.Date)+'" ';
        s:=s+' where ID='+ids+' ';
        dbConns.dbQuery.Close;
        dbConns.dbQuery.SQL.Text:=s;
        dbConns.dbQuery.ExecSQL;
        dbConns.dbQuery.Close;
        //��ȡ����
        if pageControl.ActivePageIndex=0 then
          outHistoryBtnClick(nil)
        else
          inHistoryBtnClick(nil);
     end;
end;

//ɾ����¼
procedure TmainForm.muDeleteClick(Sender: TObject);
var
  ids,s:String;
begin
    if Application.MessageBox('�Ƿ�Ҫɾ��������¼??','��ʾ',mb_yesno)=idyes then
    begin
     if pageControl.ActivePageIndex=0 then
     begin
        if outList.SelCount=0 then
           exit;
        ids:=outList.Selected.caption;
        outList.Selected.Delete;
     end
     else
     begin
        if inList.SelCount=0 then
           exit;
        ids:=inList.Selected.caption;
        inList.Selected.Delete;
     end;
     //del
     s:='Delete From TableRecord Where ID='+ ids +' ';
     dbConns.dbQuery.Close;
     dbConns.dbQuery.SQL.Text:=s;
     dbConns.dbQuery.ExecSQL;
     dbConns.dbQuery.Close;
    end;
    
end;

//�Ҽ��˵�
procedure TmainForm.listMenuPopup(Sender: TObject);
begin
     listMenu.Items.Items[0].Enabled:=true;
     listMenu.Items.Items[1].Enabled:=true;
     if pageControl.ActivePageIndex=0 then
     begin
        if outList.SelCount=0 then
        begin
           listMenu.Items.Items[0].Enabled:=false;
           listMenu.Items.Items[1].Enabled:=false;
        end
     end
     else
     begin
        if inList.SelCount=0 then
        begin
           listMenu.Items.Items[0].Enabled:=false;
           listMenu.Items.Items[1].Enabled:=false;
        end;
     end;
end;

//���·���
procedure TmainForm.UpdateClass(cls: string; tpe: string; badd: Boolean);
var
  s:string;
begin
  s:='Select ID From TableClass where mtype="'+tpe+'" and mclass="'+cls+'"';
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
      sql.text := 'Insert Into TableClass(mclass,mtype)values("'+cls+'","'+tpe+'")';
      execSql;
      ReadClass(tpe);
      exit;
    end;
  end;
  
end;

//���ô��ڴ�С
procedure TmainForm.reSetSize(flag: string);
begin
  if flag<>'TJ' then
  begin
    height:=500;
    pageControl.Height:=440;
    classView.Visible:=false;
  end
  else
  begin
    height:=570;
    pageControl.Height:=505;
    classView.Visible:=true;
  end;
end;

//�л���ǩ
procedure TmainForm.PageControlChange(Sender: TObject);
var
  idx:Integer;
begin
    idx := pageControl.ActivePageIndex;
    case idx of
      0:  //֧��
        begin
          Caption:=m_title + ' ����֧��';
          ReadClass('out');
          reSetSize('');
        end;
      1:  //����
        begin
          Caption:=m_title + ' �ʽ�����';
          ReadClass('in');
          reSetSize('');
        end;
      2:  //ͳ��
        begin
          Caption:=m_title + ' ͳ��';
          reSetSize('TJ');
          if Not m_bstat then
          begin
            DrawPie(imgPie,0,0,'֧�� ','���� ');
            listImg.Height := 18;
            listImg.Width := 5;
            statList.SmallImages := listImg;
            statMoreList.SmallImages := listImg;
            statInfo.Clear;
            m_bstat:=true;
          end;
        end;
      3:   //����
        begin
          Caption:=m_title + ' ����';
          reSetSize('');
          pzPass.Text:='';
          pzFreeTime.Text:=IntToStr(dbConns.m_freeTime);
          pzTray.Checked:=dbConns.m_bTray;
        end;
    end;
end;

//״̬����Ϣ
procedure TmainForm.SetStatus(i: Integer; txt: string);
begin
  statusBar.Panels.Items[i].Text := txt;
end;

//����listview
procedure TmainForm.SetListViewCol(flag:String);
begin
  if flag='out' then
  begin
    with outList do
    begin
      ViewStyle:=vsreport;
      GridLines:=True;
      RowSelect := True;
      Clear;
      Columns.Clear;
      Columns.Add;
      Columns.Add;
      Columns.Add;
      Columns.Add;
      Columns.Add;
      Columns.Items[0].Caption := 'ID';
      Columns.Items[0].Width := 1;
      Columns.Items[1].Caption := '����';
      Columns.Items[1].Width := 90;
      Columns.Items[2].Caption := '��Ŀ';
      Columns.Items[2].Width := 80;
      Columns.Items[3].Caption := '���';
      Columns.Items[3].Width := 60;
      Columns.Items[4].Caption := '��ע';
      Columns.Items[4].Width := 230;
    end;
  end;

  if flag='in' then
  begin
    with inList do
    begin
      ViewStyle:=vsreport;
      GridLines:=True;
      RowSelect := True;
      Clear;
      Columns.Clear;
      Columns.Add;
      Columns.Add;
      Columns.Add;
      Columns.Add;
      Columns.Add;
      Columns.Items[0].Caption := 'ID';
      Columns.Items[0].Width := 1;
      Columns.Items[1].Caption := '����';
      Columns.Items[1].Width := 90;
      Columns.Items[2].Caption := '��Ŀ';
      Columns.Items[2].Width := 80;
      Columns.Items[3].Caption := '���';
      Columns.Items[3].Width := 60;
      Columns.Items[4].Caption := '��ע';
      Columns.Items[4].Width := 230;
    end;
  end;
end;

//���Ʊ�ͼ
procedure TmainForm.DrawPie(img: TImage; num1: Real; num2: Real; str1: string; str2: string);
var
  cvs:TCanvas;
  x,y,x1,y1,x2,y2,R:Integer;
  w,h,s:Integer;
  x3,y3,x4,y4:Integer;
  clr1,clr2,bkr:TColor;
  a,a0,ar:Real;
begin
    w := img.Width;
    h := img.Height;
    s := w; if s>h then s:=h;
    R := s div 2 - 5;
    x := w div 2 + 20; y := h div 2;   //Բ��
    x1 := x-R; y1 := y-R; //���Բ
    x2 := x+R; y2 := y+R;

    clr1:= RGB(155,155,0);  //��һ��ɫ
    clr2:= RGB(155,0,0);    //�ڶ�����ɫ
    bkr:=RGB(255,255,255);  //����ɫ

    cvs:=img.Canvas;
    cvs.Refresh;
    cvs.Brush.Color:=bkr;
    cvs.FillRect(Rect(0,0,w,h));
    cvs.Pen.Color:=RGB(200,0,200);//��Ե��ɫ
    cvs.Pen.Width:=2;
    if (num1<=0) And (num2<=0) then
    begin
        cvs.Ellipse(x1,y1,x2,y2);
        DrawPieText(img,str1,str2,clr1,clr2);
        exit;
    end;

    if (num1<=0) And (num2>0) then
    begin
        cvs.Brush.Color:=clr2;
        cvs.Ellipse(x1,y1,x2,y2);
        DrawPieText(img,str1+': 0',str2+': '+FloatToStr(num2),clr1,clr2);
        exit;
    end;

    if (num1>0) And (num2<=0) then
    begin
        cvs.Brush.Color:=clr1;
        cvs.Ellipse(x1,y1,x2,y2);
        DrawPieText(img,str1+': '+FloatToStr(num1),str2+': 0',clr1,clr2);
        exit;
    end;

    //���кϷ�����
    cvs.Brush.Color:=clr1;
    cvs.Ellipse(x1,y1,x2,y2);      //���Ƶ�һ��(��Բ)
    cvs.Brush.Color:=clr2;

    //����ڶ�������
    a := 360 * (num2 /(num1+num2)); //�Ƕ�
    if a=180 then
    begin
      x3:=x;y3:=y1;
      x4:=x;y4:=y2;
    end
    else
    begin
        a0:=a;
        if a>180 then
          a:=a-180;
        ar := (a /2.0) / 180.0 * 3.1415926;
        x3:=x-round(R*tan(3.1415926/2-ar)); y3:=y1;
        if a0>180 then
          x3:=x + round(R * tan(ar));
        x4:=x3; y4:=y2;
    end;
    cvs.Pen.Color:=RGB(60,60,60);//��Ե��ɫ
    cvs.Pie(x1,y1,x2,y2,x3,y3,x4,y4);

    //���ͼ��
    DrawPieText(img,str1+': '+FloatToStr(num1),str2+': '+FloatToStr(num2),clr1,clr2);
end;

//��ͼ��ͼ��
procedure TmainForm.DrawPieText(img: TImage; s1: string; s2: string;c1:Tcolor;c2:Tcolor);
var
  cvs:TCanvas;
begin
   cvs := img.Canvas;
   cvs.Refresh;
   cvs.Brush.Color:=c1;
   cvs.Font.Color:=RGB(255,255,255);
   cvs.TextOut(5,10,s1);
   
   cvs.Brush.Color:=c2;
   cvs.TextOut(5,30,s2);
end;

//�޸�����
procedure TmainForm.BitBtn2Click(Sender: TObject);
begin
     userForm:=TUserForm.Create(nil);
     userForm.m_breg:=false;
     userForm.muser.Text:=m_user;
     userForm.muser.readonly:=true;
     userForm.mtips.Text:=dbConns.m_tips;
     if userForm.ShowModal = 1 then
       showMsg('�����Ѿ��޸ĳɹ�!');
end;

//����ȫ������
procedure TmainForm.BitBtn3Click(Sender: TObject);
var
  f,r,t:String;
  s:String;
  n:Integer;
begin
    f:=trim(pzFreeTime.Text);
    if (f='') Or (IsNumeric(f)=false) then
    begin
      ShowMsg(' ������һ������!');
      exit;
    end;
    n:=StrToInt(f);
    if n<=0 then
       f:='10';
    
    r:='0';
    if pzDisReg.Checked then
      r:='1';
    t:='0';
    if pzTray.Checked then
      t:='1';
    s:='Update TableUser set mfree='+f+',mtray='+t;
    if dbConns.m_bFstUser then
    begin
        dbConns.m_bDisReg:=pzDisReg.Checked;
        s:=s+',mreg='+r;
    end;
    s:=s+' where muser="'+ dbConns.m_user +'"';
    dbConns.dbQuery.SQL.Text:=s;
    dbConns.dbQuery.ExecSQL;
    dbConns.dbQuery.Close;

    dbConns.m_bTray:=pzTray.Checked;
    dbConns.m_freeTime:=n;

    //����ͼ��
    if dbConns.m_bTray then
    begin
      trayIcon.Visible:=true;
      trayIcon.Hint:=m_title;
    end
    else
      trayIcon.Visible:=false;

    ShowMsg('ȫ�������Ѿ������޸�!!');
end;

//��Ŀ����
procedure TmainForm.BitBtn4Click(Sender: TObject);
begin
    //
    classFrm:=TclassFrm.Create(nil);
    classFrm.ShowModal;
    //�ض�
    ReadClass('out');
    ReadClass('in');
end;

procedure TmainForm.classEditOutClick(Sender: TObject);
begin
    BitBtn4Click(nil);
end;

procedure TmainForm.classEdtInClick(Sender: TObject);
begin
    BitBtn4Click(nil);
end;

//�����ʺ�
procedure TmainForm.BitBtn1Click(Sender: TObject);
begin
    if EncodeBase64(trim(pzPass.Text)) <> dbConns.m_pass then
    begin
      ShowMsg('��������ȷ�ĵ�¼����!!');
      exit;
    end;
    if Application.MessageBox('�Ƿ�Ҫ�����ʺ�??'+#13#13+'ע��: ���ٺ��޷��ָ�.','����',mb_yesno+ mb_iconquestion)=idyes then
    begin
      if Application.MessageBox('�ٴ�ȷ��Ҫ����??','ȷ��',mb_yesno)=idyes then
      begin
        with dbConns.dbQuery do
        begin
          close;
          sql.Text:='delete From TableUser Where muser="'+dbConns.m_user+'"';
          execSql;
          close;
          sql.Text:='delete From TableRecord Where muser="'+dbConns.m_user+'"';
          execSql;
          ShowMsg('�Ѿ����ٴ��ʺ�, ��ӭ�����������!!');
          Label27Click(nil);
          Application.Terminate;
        end;
      end;
    end;
end;

//ת����վ
procedure TmainForm.Label27Click(Sender: TObject);
begin
    ShellExecute(Handle,'open','http://hi.baidu.com/codefish', nil, nil, SW_SHOWNORMAL);
end;

///////////////////////////////////////////////////////////
//trayIcon
procedure TmainForm.muAboutClick(Sender: TObject);
begin
    //About
    About;
end;

procedure TmainForm.muCloseClick(Sender: TObject);
begin
   //close
   Application.Terminate;
end;

procedure TmainForm.muLockClick(Sender: TObject);
begin
   //lock
   Lock;
end;

//��ʾ����
procedure TmainForm.muShowClick(Sender: TObject);
begin
   //show hide
   if Visible then
      Hide
   else
   begin
      Show;
      ShowWindow(Handle,1);
   end;
end;

procedure TmainForm.FormHide(Sender: TObject);
begin
    muShow.Caption:='��ʾ(&S)';
end;
procedure TmainForm.FormShow(Sender: TObject);
begin
    muShow.Caption:='����(&S)';
    if m_block then
    begin
      m_block:=false;
      Lock;
    end;
end;

//������ʱ��
procedure TmainForm.freeTimerTimer(Sender: TObject);
var   
      LInput:TLastInputInfo;
      nt:DWord;
begin
      LInput.cbSize   :=   SizeOf(TLastInputInfo);   
      GetLastInputInfo(LInput);   
      nt:=(GetTickCount - LInput.dwTime) div 1000; //s
      if int(nt) >= dbConns.m_freeTime*60 then
        Lock;
end;

//����
procedure TmainForm.About;
begin
   aboutFrm:=TaboutFrm.Create(nil);
   aboutFrm.ShowModal;
end;

//��������
procedure TmainForm.Lock;
begin
    freeTimer.Enabled:=false;
    if Not Visible then
    begin
      m_bLock:=true;
      exit;
    end;
    
    logForm:=TlogForm.Create(nil);
    logForm.bCanClose:=false;
    logForm.user.Text:=m_user;
    logForm.user.Enabled:=false;
    logForm.bRegNew:=false;
    if logForm.ShowModal = 1 then
    begin
      freeTimer.Enabled:=true;
    end
    else
      Application.Terminate;
end;

//��С��
procedure TmainForm.ApplicationEvents1Minimize(Sender: TObject);
begin
   //Hide;
end;

//����ͳ������
procedure TmainForm.exportBtnClick(Sender: TObject);
var
  fn:String;
begin
    saveDlg.FileName:='��֧ͳ��';
    if saveDlg.Execute(Handle) then
    begin
       fn:=saveDlg.FileName;
       if FileExists(fn) then
       begin
          if Application.MessageBox('�ļ��Ѿ�����, �Ƿ񸲸�?','��ʾ',mb_yesno)<>idyes then
            exit;
       end;
       
       ExportData(fn);
    end;
end;

//����
procedure TmainForm.ExportData(fn:String);
var
  htm,tit,s1,s2:String;
  i,j:Integer;
  tf:TextFile;
begin
    s1:=DateToStr(statDate1.Date);
    s2:=DateToStr(statDate2.Date);
    if bMonthStat.Checked then
    begin
       s1:=GetMonthOne(statDate1.Date);
       s2:=GetMonthOne(statDate2.Date);
    end;
    tit:=s1+' �� '+s2+' ��֧ͳ�Ƽ�¼';

    htm:='<html><head><title>'+tit+'</title><style>body,td{font-size:14px}</style></head><body>';
    htm:=htm+'<h3>'+ tit +'</h3>';

    s1:='<table border=1 width=400>';
    s1:=s1+'<tr><td width=80>����</td><td>����</td><td>֧��</td><td>��ֵ</td></tr>';
    //ͳ��
    j:=statList.Items.Count;
    for i := 0 to j - 1 do
    begin
      s1:=s1+'<tr><td align=left>'+statList.Items.Item[i].Caption+'</td>';
      s1:=s1+'<td>'+statList.Items.Item[i].SubItems[0]+'</td>';
      s1:=s1+'<td>'+statList.Items.Item[i].SubItems[1]+'</td>';
      s1:=s1+'<td>'+statList.Items.Item[i].SubItems[2]+'</td></tr>';
    end;
    s1:=s1+'</table>';

    //����
    s2:='<table border=1 width=140>';
    s2:=s2+'<tr><td>��Ŀ</td><td>���</td></tr>';
    j:=classView.Items.Count;
    for i := 0 to j - 1 do
    begin
      s2:=s2+'<tr><td align=left>'+classView.Items.Item[i].Caption+'</td>';
      s2:=s2+'<td>'+classView.Items.Item[i].SubItems[0]+'</td>';
    end;
    s2:=s2+'</table>';

    htm:=htm+'<table border=0><tr><td valign=top>'+s2+'</td><td width=5></td>';
    htm:=htm+'<td valign=top>'+s1+'</td></tr></table>';

    htm:=htm+'</body></html>';

    AssignFile(tf, fn);
    rewrite(tf);
    write(tf,htm);
    closefile(tf);
end;


//�ر����
procedure TmainForm.FormDestroy(Sender: TObject);
begin
    dbConns.dbQuery.Close;
    dbConns.dbConnect.Close;
end;

/////////////////////////////
end.
