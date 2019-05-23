unit locatedlg;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, StdActns, ActnList, DateUtils,ExtCtrls,
  IdUDPServer,IdSocketHandle, IdBaseComponent, IdComponent, IdUDPBase, Mask;

type
  TlocateForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    IdUDPServer2: TIdUDPServer;
    procedure MaskEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure IdUDPServer2UDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    m_ipctrl:string;
    fRecvUDPstring:string;
    RemostIP:string;
    { Public declarations }
  end;

var
  locateForm: TlocateForm;

implementation
uses fUHFReader18demomain,UHFReader18_Head;
{$R *.dfm}

procedure TlocateForm.MaskEdit1Change(Sender: TObject);
var
t: array[0..3] of string;
i, j, len: integer;
begin
len := StrLen(PChar(MaskEdit1.text));
//ȡ�ַ�������
for i := 0 to 3 do
    //���Ķζ�ȡ
begin
    t[i] := '';
    if len < i * 3 + 1 then
      Break;
    for j := i * 3 + 1 to i * 3 + 3 do
    begin
      //�������ַ�
      if j <= len then
        t[i] := t[i] + MaskEdit1.Text[j]
      else
        Break;
    end;
    if t[i] = '' then
    begin
      ShowMessage('����: ' + t[i] + '�Ǵ���ĵ�ַ');
      Break;
    end;
    if StrToIntDef(t[i], 0) > 255 then
    begin
      ShowMessage('����: ' + t[i] + '�Ǵ���ĵ�ַ');
      Break;
    end;
end;

end;

procedure TlocateForm.Button1Click(Sender: TObject);
var
  aDateTime: TDateTime;
  comd,str,str1:string;
  i,t,dwNo:integer;
  ecode,use,dsname:string;
  aListItem:TListItem;
  bOpt:DWORD;
begin
  str:= MaskEdit1.Text;
  str:=Trim(str);
  m_ipctrl:='';
  for i:=1 to (Length(str))do
  begin
    if(str[i]<>' ')then
      m_ipctrl:=m_ipctrl+str[i];
  end;
 if( Pos('..',m_ipctrl)>0)then
 begin
   MessageDlg('�����IP���Ϸ���', mtWarning, [mbOK], 0);
   Exit;
 end;
 frmUHFReader18demomain.ListView1.Items.Clear;
 try
  IdUDPServer2.DefaultPort:=0;
  IdUDPServer2.Active:=True;
 except
  MessageDlg('����˿ڳ�ͻ��', mtInformation, [mbOK], 0);
 end;
 comd:= 'X';
 IdUDPServer2.Bindings[0].IP:='255.255.255.255';
 IdUDPServer2.Bindings[0].Port:=65535;
 bOpt:=1;
 IdUDPServer2.Bindings[0].SetSockOpt(65535,$20,@bOpt, SizeOf(bOpt));
 IdUDPServer2.Bindings[0].SendTo(IdUDPServer2.Bindings[0].IP,IdUDPServer2.Bindings[0].Port,comd[1],Length(comd));
 aDateTime := Now;
 fRecvUDPstring:='';
  while (Now < IncMilliSecond(aDateTime, 1000 )) do //ѯ��ʱ��û�����
  begin
    Application.ProcessMessages;
    if fRecvUDPstring <> '' then
    begin
       if(m_ipctrl=RemostIP)then
       begin
         ecode:=Copy(fRecvUDPstring,1,1);
         if(ecode<>'A')then
         begin
           GeteCodeDesc(ecode);
           Exit;
         end;
         dwNo:=frmUHFReader18demomain.ListView1.Items.Count;
         aListItem := frmUHFReader18demomain.ListView1.Items.Add;
         aListItem.SubItems.Add('');
         aListItem.SubItems.Add('');
         aListItem.SubItems.Add('');//
         aListItem.SubItems.Add('');//
         aListItem.Caption:=IntToStr(frmUHFReader18demomain.ListView1.Items.Count);
         str:=Copy(fRecvUDPstring,2,Pos('/',fRecvUDPstring)-2);
         if(m_ipctrl<>RemostIP) then Break ;
         frmUHFReader18demomain.ListView1.Items[dwNo].SubItems[0]:=str;
         frmUHFReader18demomain.ListView1.Items[dwNo].SubItems[1]:=RemostIP;
         t :=Pos('*',fRecvUDPstring)+8;
         str1:=Copy(fRecvUDPstring,t,Length(fRecvUDPstring)-t+1)   ;
         t:=Pos('/',str1);
         use:=Copy(str1,1,t-1);
         dsname:=Copy(str1,t+1,Length(str1)-t+1);
         str:='';
         if((use = '') and (dsname = '' ))or (dsname = '/')then
          str:=''
         else
         begin
          str:= use+'/'+dsname;
         end;
         frmUHFReader18demomain.ListView1.Items[dwNo].SubItems[2]:=str;
         Break;
       end;
    end;
  end;
  Close;
end;

procedure TlocateForm.IdUDPServer2UDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var DataStringStream:tstringstream;
begin
  //tstringstream������������࣬��Ҫ������socket�д��ݴ������ַ�
   fRecvUDPstring:='';
   DataStringStream:=tstringstream.Create('');
   TRY
     DataStringStream.CopyFrom(adata,adata.Size);
     fRecvUDPstring:=DataStringStream.DataString;
     RemostIP:= ABinding.PeerIP;
   finally
     DataStringStream.Free;
   end;
end;

procedure TlocateForm.Button2Click(Sender: TObject);
begin
Close;
end;

end.
