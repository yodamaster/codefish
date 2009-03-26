unit modfiy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  Tmodify = class(TForm)
    group: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    mDate: TDateTimePicker;
    mClass: TComboBox;
    mMoney: TEdit;
    mAbout: TMemo;
    BtnMod: TBitBtn;
    procedure BtnModClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    m_id:String;
    m_type:String;
    m_date,m_money,m_class,m_about:String;
  end;

var
  modify: Tmodify;

implementation

{$R *.dfm}

procedure Tmodify.BtnModClick(Sender: TObject);
begin
    m_date := DateToStr(mDate.Date);
    m_class := Trim(mClass.Text);
    m_money := Trim(mMoney.Text);
    m_about := Trim(mAbout.Text);
    if m_class='' then
    begin
      ShowMessage('请输入收入的项目!!');
      exit;
    end;
    if m_money='' then
    begin
      ShowMessage('请输入收入的金额!!');
      exit;
    end;
    try
      strToFloat(m_money);
    except
      ShowMessage('收入的金额必须是数字!!');
      exit;
    end;
    ////////////////////
    Self.ModalResult:=1;
end;

/////////////////////////////////////////////
procedure Tmodify.FormCreate(Sender: TObject);
begin
   Color:=RGB(235,244,244);
   group.Color:=Color;
end;

end.
