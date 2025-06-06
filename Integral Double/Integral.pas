unit Integral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, CalcExpress, ExtCtrls, jpeg, Grids;

type
  //A=array[1..100,1..100]of extended;

  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    EditFunc: TEdit;
    Label2: TLabel;
    EditN: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditA: TEdit;
    EditB: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EditC: TEdit;
    EditD: TEdit;
    ButtonRun: TButton;
    LabelResult: TLabel;
    CalcExp: TCalcExpress;
    MemoVar: TMemo;
    Memo1: TMemo;
    Label7: TLabel;
    Image1: TImage;
    CBGraph: TCheckBox;
    TabSheet2: TTabSheet;
    Image2: TImage;
    TabSheet3: TTabSheet;
    ButtonAbout: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ButtonRun2: TButton;
    Editg: TEdit;
    EditG2: TEdit;
    EdA: TEdit;
    EdB: TEdit;
    EdC: TEdit;
    EdD: TEdit;
    EdN: TEdit;
    EdM: TEdit;
    GroupBox1: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    cbExact: TCheckBox;
    EditExact: TEdit;
    cbGraph2: TCheckBox;
    CEg: TCalcExpress;
    CEG2: TCalcExpress;
    Memo2: TMemo;
    sg: TStringGrid;
    CEexact: TCalcExpress;
    ButtonClear2: TButton;
    Label17: TLabel;
    procedure ButtonRunClick(Sender: TObject);
    procedure ButtonAboutClick(Sender: TObject);
    procedure ButtonRun2Click(Sender: TObject);
    procedure ButtonClear2Click(Sender: TObject);
//    Procedure Sum(var D:A;var E:A;var N:integer;var sum3:extended);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses mainfrm;




  //B=array[1..100,1..100]of integer;



{$R *.dfm}

{
Procedure Sum(var D:A;var E:A;var N:integer;var sum3:extended);
var
  i,j:integer;
  sum2:array[1..100,1..100] of extended;
begin
  sum3:=0;
  for i:=1 to N do
   for j:=1 to N do
   begin
    sum2[i,j]:=D[i,j]*E[i,j];
    sum3:=sum3+sum2[i,j];
   end;
end;
}


procedure TForm1.ButtonRunClick(Sender: TObject);
label
 akhir;
var
 a,a2,b,c,c2,d,Hx,Hy,sum3:extended;
 i,j,N,p,TotalN,r,q:integer;
 X,Y,XX,YY,F,sum2:array[1..100,1..100] of extended;
 S:array[1..100,1..100] of integer;
 parG,argG:array[0..1] of extended;
 Total:extended;
begin
 a:=strtofloat(editA.text);   //x1
 b:=strtofloat(editB.text);   //x2
 c:=strtofloat(editC.text);   //y1
 d:=strtofloat(editD.text);   //y2
 N:=strtoint(editN.text);

 if N mod 2 = 0 then
 begin
  showmessage('N must odd');
  goto akhir;
 end;

 if N >99 then
 begin
  showmessage('Maximum N=99');
  goto akhir;
 end;

{
 if N >9 then
 begin
  CBGraph.Checked:=false;
  //showmessage('Maximal of N to display 3D graph is 9 or less then 100 coordinate ( limitation of free SDL component !!! )');
 end;
 }

 CalcExp.Formula:=editFunc.Text;
 CalcExp.Variables:=memoVar.lines;

 Hx:=(b-a)/(N-1);
 Hy:=(d-c)/(N-1);

 a2:=a;
 for i:=1 to N do
 begin
  X[1,i]:=a2;
  a2:=a2+Hx;
 end;

 c2:=c;
 for i:=1 to N do
 begin
  Y[1,i]:=c2;
  c2:=c2+Hy;
 end;

 for i:=1 to N do
  for j:=1 to N do
   XX[i,j]:=X[1,j];

 for i:=1 to N do
  for j:=1 to N do
   YY[j,i]:=Y[1,j];

  //f(x,y)
  for i:=1 to N do
   for  j:= 1 to N do
   begin
    parG[0]:=XX[i,j];
    parG[1]:=YY[i,j];
    for p:=0 to 1 do
     argG[p]:=parG[p];

    F[i,j]:=CalcExp.calc(argG);
  end;

  //Matrix S (Simpson coefficient

  S[1,1]:=1;
  S[1,N]:=1;
  S[N,1]:=1;
  S[N,N]:=1;

  for i:=2 to N-1 do
  begin
    if i mod 2=0 then S[1,i]:=4
    else
    S[1,i]:=2;
   end;

  for i:=2 to N-1 do
  begin
    if i mod 2=0 then S[N,i]:=4
    else
    S[N,i]:=2;
   end;

  for i:=2 to N-1 do
  begin
    if i mod 2=0 then S[i,1]:=4
    else
    S[i,1]:=2;
   end;

  for i:=2 to N-1 do
  begin
    if i mod 2=0 then S[i,N]:=4
    else
    S[i,N]:=2;
   end;

   for i:=2 to N-1 do       //S[2,2]:=S[2,1]*S[1,2]; S[3,2]=S[3,1]*S[1,2];
    for j:=2 to N-1 do
      S[i,j]:=S[i,1]*S[1,j];


  sum3:=0;
  for i:=1 to N do
   for j:=1 to N do
   begin
    sum2[i,j]:=S[i,j]*F[i,j];
    sum3:=sum3+sum2[i,j];
   end;

   Total:=Hx*Hy*sum3/9;



 labelResult.Caption:='Result = '+floattostr(Total);

 //View graph
 if CbGraph.Checked=true then
  begin
   CbGraph2.Checked:=false;

   totalN:=N*N; //total baris pembatasan Free component SDL (max 100)
   if (totalN>100) then
   begin
     CBGraph.Checked:=false;
    showmessage('Maximal of N to display 3D graph is 9 or 100 coordinate ( limitation of free SDL component !!! )');
    goto akhir;
   end;

   FrmDataVis.Close;
   FrmDataVis.Show;
   FrmDataVis.TEData.Clear;


   //X
   r:=0; // l diganti r
   for I:=1 to N do
    for J:=1 to N do
     begin
      r:=r+1;
      FrmDataVis.TEData[1,r]:=XX[I,j];
     end;

   //Y
   q:=0;
   for I:=1 to N do
    for J:=1 to N do
    begin
     q:=q+1;
     FrmDataVis.TEData[2,q]:=YY[i,j];
    end;

   //Z
   q:=0;
   for I:=1 to N do
    for J:=1 to N do
    begin
     q:=q+1;
     FrmDataVis.TEData[3,q]:=F[i,j];
    end;



 akhir:;
end;
end;

procedure TForm1.ButtonAboutClick(Sender: TObject);
const
 sAbout = '|======== Double Integral ========|' + #13#10 +
          '' + #13#10 +
          'Version 1.0 - Build Jun 11, 2018'+ #13#10 +
          'Created by Lukas Setiawan' + #13#10 +
          'Copyright (c) 2018. All Rights Reserved.' + #13#10 +
          'lukassetiawan@yahoo.com' + #13#10 +
          '' + #13#10+
          'My other works :'+#13#10+
           'https://bitbucket.org/nixz97/nix/downloads/'+#13#10+
          '' + #13#10 +
          'Educational backgroud : ' + #13#10 +
          ''+#13#10 +
          '1. SD IPPOR Eretan Wetan' + #13#10 +
          '2. SMP Negeri Kandanghaur-Indramayu' + #13#10 +
          '3. SMA BOPKRI I (BOSA) Yogyakarta' + #13#10 +
          '4. Teknik Kimia Angkatan 94 (NRP 6294015) Universitas Parahyangan Bandung' + #13#10 +
          '5. Teknik Informatika STMIK Indonesia Mandiri Bandung (NIM 36026084)' + #13#10 +
          '' + #13#10 +
          'Accepting donations for software development.'+ #13#10;

begin
 MessageDlg( sAbout, mtInformation, [mbOK], 0);
end;

procedure TForm1.ButtonRun2Click(Sender: TObject);
label
 akhir;
var
 i,j,l,n,N2,N3,m,M2,M3,p,jMinus1,iMinus1,r,o,q,nm,totalN:integer;
 a,b,c,d,h,k,half_h,half_k,hk,error,psi,ksi,temp1,pv,yx:extended;
 temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,sum:extended;
 X2,Y2,b_vector:array[1..101] of extended;
 parG1,argG1:array[0..1] of extended;
 U,W:array[1..101,1..101] of extended;
 A2,A3,RE:array[1..101,1..101] of extended;



begin
 a:=strtofloat(edA.Text);
 b:=strtofloat(edB.Text);
 c:=strtofloat(edC.Text);
 d:=strtofloat(edD.Text);
 n:=strtoint(edN.Text);
 m:=strtoint(edM.Text);

 if (n<>m) then
 begin
  showmessage('Dimension of n and m must same !!!');
  goto akhir
 end;

 if (n>100) or (m >100) then
 begin
  showmessage('Maximum m or n is 100 !!!');
  goto akhir;
 end;
 N2:=n+1;
 M2:=m+1;
 h:=(b-a)/n;
 k:=(d-c)/m;

 CEg.Formula:=editg.Text;
 CEg.Variables:=memoVar.lines;

 CEG2.Formula:=editG2.Text;
 CEG2.Variables:=memoVar.lines;

 X2[1]:=a;
 for i:=1 to N2 do
  X2[i]:=a+h*(i-1);

 Y2[1]:=c;
 for i:=1 to M2 do
  Y2[i]:=c+k*(i-1);

 hk:=h*k;
 half_h:=h/2;
 half_k:=k/2;

 for i:=1 to N2 do
  for j:=1 to M2 do
   U[i,j]:=0;

 for i:=1 to N2 do
 begin
   parG1[0]:=X2[i];
   parG1[1]:=Y2[1];
   for p:=0 to 1 do
     argG1[p]:=parG1[p];

   U[i,1]:=CEg.calc(argG1);

 end;

 for i:=1 to N2 do
  b_vector[i]:=0;

  error:=0;

  //for j:=2 to 3 do
  for j:=2 to M2 do
  begin

  for i:=1 to N2 do
   for o:=1 to N2 do
   begin
    if i=o then A2[i,o]:=1
   else
    A2[i,o]:=0;
  end;

  for i:=1 to n do
   A2[i,i+1]:=-1;



    jMinus1:=j-1;
    psi:=Y2[j]-half_k;
    ksi:=X2[1]+half_h;

    parG1[0]:=ksi;
    parG1[1]:=psi;
    for p:=0 to 1 do
     argG1[p]:=parG1[p];

    temp1:=CEG2.calc(argG1);
    for i:=1 to N2 do
      A2[N2,1]:=hk*temp1;

    parG1[0]:=X2[1];
    parG1[1]:=Y2[j];
    for p:=0 to 1 do
     argG1[p]:=parG1[p];
    temp2:=CEg.calc(argG1);

    parG1[0]:=X2[2];
    parG1[1]:=Y2[j];
    for p:=0 to 1 do
     argG1[p]:=parG1[p];
    temp3:=CEg.calc(argG1);

    b_vector[1]:=temp2-temp3;

    parG1[0]:=X2[N2];
    parG1[1]:=Y2[j];
    for p:=0 to 1 do
     argG1[p]:=parG1[p];
    temp4:=CEg.calc(argG1);

    parG1[0]:=X2[1];
    parG1[1]:=Y2[jMinus1];
    for p:=0 to 1 do
     argG1[p]:=parG1[p];
    temp5:=CEg.calc(argG1);



     b_vector[N2]:=4*(temp4+U[1,jMinus1]-temp5);


    sum:=0;
    for i:=2 to n do
    begin
     iMinus1:=i-1;

     parG1[0]:=ksi;
     parG1[1]:=psi;
     for p:=0 to 1 do
      argG1[p]:=parG1[p];
     temp6:=CEG2.calc(argG1);

     parG1[0]:=ksi+h;
     parG1[1]:=psi;
     for p:=0 to 1 do
      argG1[p]:=parG1[p];
     temp7:=CEG2.calc(argG1);

     A2[N2,i]:=hk*(temp6+temp7);


     parG1[0]:=X2[i];
     parG1[1]:=Y2[j];
     for p:=0 to 1 do
      argG1[p]:=parG1[p];
     temp8:=CEg.calc(argG1);

     parG1[0]:=X2[i+1];
     parG1[1]:=Y2[j];
     for p:=0 to 1 do
      argG1[p]:=parG1[p];
     temp9:=CEg.calc(argG1);

     b_vector[i]:=temp8-temp9;

     parG1[0]:=ksi;
     parG1[1]:=psi;
     for p:=0 to 1 do
      argG1[p]:=parG1[p];
     temp10:=CEG2.calc(argG1);

     sum:=sum+(U[iMinus1,jMinus1]+U[i,jMinus1])*temp10;
     ksi:=ksi+h;
    end;

     parG1[0]:=ksi;
     parG1[1]:=psi;
     for p:=0 to 1 do
      argG1[p]:=parG1[p];
     temp10:=CEG2.calc(argG1);

     A2[N2,N2]:=4*(hk*temp10-1);
     sum:=sum+(U[n,jMinus1]+U[N2,jMinus1])*temp10;
     b_vector[N2]:=-(b_vector[N2]+hk*sum);



 // inverse (A2)
 for i:=1 to N2 do
 begin
  pv:=A2[i,i];
  A2[i,i]:=1;
  for l:=1 to N2 do
   A2[i,l]:=A2[i,l]/pv;
   for o:=1 to N2 do
   begin
    if o<>i then
    begin
     yx:=A2[o,i];
     A2[o,i]:=0;
     for l:=1 to N2 do
      A2[o,l]:= A2[o,l]-yx*A2[i,l];
     end;
    end;
 end;

 { OK!!!
//Inv(A2)*b_vector
  for i:=1 to N2 do
   //for o:=1 to l do
   for o:=1 to 1 do
   begin
    U[i,j] := 0;
    for p:=1 to N2 do
     U[i,j]:=U[i,j]+A2[i,p]*b_vector[p];
   end;
  }

  //Inv(A2)*b_vector
  for i:=1 to N2 do
  begin
    U[i,j] := 0;
    for p:=1 to N2 do
     U[i,j]:=U[i,j]+A2[i,p]*b_vector[p];
  end;



    {
    tempError:=abs(U(1,j)-f(x(1),y(j)));
    if error<tempError
        error=tempError;
    }


  end;

  //clear
  for i := 0 to sg.rowCount-1 do
   sg.rows[i].Clear;

  sg.Cells[0,0]:='F(xi,yj) Numeric';
  sg.ColWidths[0]:=85;
  for i:=0 to n do
   sg.Cells[i+1,0]:='x'+inttostr(i)+'='+floattostr(X2[i+1]);

  for i:=0 to m do
   sg.Cells[0,i+1]:='y'+inttostr(i)+'='+floattostr(Y2[i+1]);

  for i:=1 to M2 do
   for l:=1 to N2 do
     sg.Cells[l,i]:=floattostr(U[i,l]);


   //Exact
  if cbExact.Checked=true then
  begin
  CEExact.Formula:=editExact.Text;
  CEExact.Variables:=memoVar.lines;
  for i:=1 to N2 do
   for l:=1 to M2 do
   begin
    parG1[0]:=X2[i];
    parG1[1]:=Y2[l];
    for p:=0 to 1 do
      argG1[p]:=parG1[p];
    W[i,l]:=CEExact.calc(argG1); //Exact
   end;


  sg.Cells[0,M2+2]:='F(xi,yj) Exact';
  for i:=0 to m do
   sg.Cells[0,M2+i+3]:='y'+inttostr(i)+'='+floattostr(Y2[i+1]);

  for i:=1 to M2 do //x
   for l:=1 to N2 do   //y
     sg.Cells[l,M2+i+2]:=floattostr(W[l,i]);

  //Relative error(%)
  for i:=1 to N2 do
   for l:=1 to M2 do
   begin
    if abs(W[i,l])=0 then W[i,l]:=0
    else //and abs(W[i,j]-U[i,l])
     RE[i,l]:=(abs(W[i,l]-U[i,l])/abs(W[i,l]))*100; //dalam persen
   end;

  sg.Cells[0,+2*M2+4]:='Relative Error(%)';
  for i:=0 to m do
   sg.Cells[0,i+2*M2+5]:='y'+inttostr(i)+'='+floattostr(Y2[i+1]);

  for i:=1 to M2 do
   for l:=1 to N2 do
    sg.Cells[l,i+2*M2+4]:=floattostr(RE[i,l]);

  end;
  //Graph
  if cbGraph2.Checked= true then
  begin
   CbGraph.Checked:=false;

   totalN:=N2*N2; //total baris pembatasan Free component SDL (max 100)
   if (totalN>100) then
   begin
     CBGraph2.Checked:=false;
    showmessage('Maximal of n or m  to display 3D graph is 9 or 100 coordinate ( limitation of free SDL component !!! )');
    goto akhir;
   end;

   FrmDataVis.Close;
   FrmDataVis.Show;
   FrmDataVis.TEData.Clear;


   //X
   r:=0; // l diganti r
   for I:=1 to N2 do
    for J:=1 to N2 do
     begin
      r:=r+1;
      FrmDataVis.TEData[1,r]:=X2[I];
     end;

   //Y
   q:=0;
   for I:=1 to N2 do
    for J:=1 to N2 do
    begin
     q:=q+1;
     FrmDataVis.TEData[2,q]:=Y2[j];
    end;

   //Z
   q:=0;
   for I:=1 to N2 do
    for J:=1 to N2 do
    begin
     q:=q+1;
     FrmDataVis.TEData[3,q]:=U[j,i];
    end;
  {
   //X
   nm:=n*m;
   if (nm>100) then
   begin
    N3:=N div 10;
    M3:=m div 10;
   label20.Caption:=inttostr(N3);

   r:=0; // l diganti r
   j:=1;
   for I:=1 to 20 do    //1 3 5 7 9 11 13 15 17 20
     begin
      r:=r+1;
      FrmDataVis.TEData[1,r]:=X2[j];
      j:=j+n3;
     end;
   {
   //Y
   q:=0;
   j:=1;
   for I:=1 to 10 do
    begin
     q:=q+1;
     FrmDataVis.TEData[2,q]:=Y2[j];
     j:=j+m3;
    end;

   //Z
   q:=0;
   p:=1;
   l:=1;
   for I:=1 to 10 do
    for J:=1 to 10 do
    begin
     q:=q+1;
     FrmDataVis.TEData[3,q]:=U[l,p];
     p:=p+m3;
     l:=l+n3;
    end;

    end;
    }

   end;


 akhir:




end;

procedure TForm1.ButtonClear2Click(Sender: TObject);
var
 i:integer;
begin
 Editg.Clear;
 Editg2.clear;
 EdA.Clear;
 EdB.Clear;
 EdC.Clear;
 EdD.Clear;
 EdN.Clear;
 EdM.Clear;
 EdA.Clear;
 EditExact.Clear;
 cbExact.Checked:=false;
 cbGraph2.Checked:=false;

  //clear
  for i:=0 to sg.rowCount-1 do
   sg.rows[i].Clear;

end;

end.
