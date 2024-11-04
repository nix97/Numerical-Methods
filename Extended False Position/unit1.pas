unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  formula, TAGraph, TASeries, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    ArtFormula1: TArtFormula;
    AboutBut: TButton;
    ExampleBut: TButton;
    Chart1: TChart;
    Label8: TLabel;
    IterCheck: TCheckBox;
    Label11: TLabel;
    MEdit: TEdit;
    Label12: TLabel;
    RootSeries2: TLineSeries;
    GraphYSeries1: TLineSeries;
    Label10: TLabel;
    ResultMemo: TMemo;
    HelpMemo: TMemo;
    RunBut: TButton;
    ClearBut: TButton;
    gammaEdit: TEdit;
    SinglerootEdit: TEdit;
    YEdit: TEdit;
    aEdit: TEdit;
    bEdit: TEdit;
    deltaEdit: TEdit;
    epsilonEdit: TEdit;
    iterEdit: TEdit;
    x1Edit: TEdit;
    x2Edit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ResultLabel: TLabel;
    Label9: TLabel;
    procedure AboutButClick(Sender: TObject);
    procedure ClearButClick(Sender: TObject);
    procedure ExampleButClick(Sender: TObject);
    procedure RunButClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.RunButClick(Sender: TObject);
label
  stop,stop2,stop3;
var
  found : boolean;
  a,b,c,ac,delta,epsilon,ya,yb,yc,dx,h,x1,x2,delta_x,rb,gamma : extended;
  k,i,j,max,num,M,l,rootNo : integer;
  vars : array of string;
  vals1 : TCalcArray;
  a_str,b_str,c_str,x_str,YEquation,x3_str,line : string;
  x,y,x3,y3,root,error,residual : array[0..10000] of extended;
  iter:array[0..10000] of string;

begin
 try
  a:=strtofloat(aEdit.Text);
  b:=strtofloat(bEdit.Text);
  delta:=strtofloat(deltaEdit.Text);
  epsilon:=strtofloat(epsilonEdit.Text);
  max:=strtoint(iterEdit.Text);
  x1:=strtofloat(x1Edit.Text);
  x2:=strtofloat(x2Edit.Text);
  M:=strtoint(MEdit.Text);
  gamma:=strtofloat(gammaEdit.Text);
  YEquation:=YEdit.text;
  rootNo:=strtoint(SinglerootEdit.Text);

  //handling boundary etc
  if (x1=0) then x1:=-0.1;//due to graph problem, can not zero
  if (a>=b) then
  begin
   showmessage('Value of a must be lower than b !!!');
   goto stop3;
  end;

  if (delta<1e-18) or (epsilon<1e-18) then
  begin
   showmessage('Min value of delta or epsilon is 1e-18 !!!');
   goto stop3;
  end;

  if (a<x1) or (b>x2) then
  begin
   showmessage('Value of [a,b] at most on the domain x1 & x2  !!!');
   goto stop3;
  end;

  if (max>10000) then
  begin
   showmessage('Max of max iter is 10000 !!!');
   goto stop3;
  end;

  if (M>10000) then
  begin
   showmessage('Max of M is 10000 !!!');
   goto stop3;
  end;

  if (gamma<1e-12) then
  begin
   showmessage('Min gamma is 1e-12 !!!');
   goto stop3;
  end;



  num:=1; //numbers of variable (x)
  setlength(vars,num);
  setlength(vals1,num);
  vars[0]:='x'; //x

  RootSeries2.Clear;
  ResultMemo.lines.clear;

  rb:=b; //rb:right_boundary
  j:=1;
 repeat

  x3[0]:=a; //as starting point

  //check every (x+delta_x)so count delta_x first, with var gamma 1%(0.01), so delta_x=abs(0.01 x a)
  if (a<>0) then  //a can not zero to count delta_x
    delta_x:=abs(gamma*a)
  else
    delta_x:=abs(gamma*b);

  found:=false;
  i:=0;

  repeat
   x3_str:=floattostr(x3[i]);
   setS(vals1[0],x3_str);
   y3[i]:=strtofloat(ArtFormula1.ComputeStr(YEquation,num,@vars,@vals1));

   x3[i+1]:=x3[i]+delta_x;
   x3_str:=floattostr(x3[i+1]);
   setS(vals1[0],x3_str);
   y3[i+1]:=strtofloat(ArtFormula1.ComputeStr(YEquation,num,@vars,@vals1));

   if ((y3[i]*y3[i+1])<0) then found:=true;
   inc(i);
   if (x3[i]>rb) then goto stop2;

  until(found=true);

  a_str:=floattostr(x3[i-1]); // before calc use artFormula, value convert to string (x2)
  setS(vals1[0],a_str);
  ya:=strtofloat(ArtFormula1.ComputeStr(YEquation,num,@vars,@vals1));

  b_str:=floattostr(x3[i]);
  setS(vals1[0],b_str);
  yb:=strtofloat(ArtFormula1.ComputeStr(YEquation,num,@vars,@vals1));

  a:=x3[i-1];
  b:=x3[i];

  iter[j]:='';
  l:=0;
  for k:=1 to max do
  begin
   dx:=yb*(b-a)/(yb-ya);
   c:=b-dx;
   ac:=c-a;

   c_str:=floattostr(c);
   setS(vals1[0],c_str);
   yc:=strtofloat(ArtFormula1.ComputeStr(YEquation,num,@vars,@vals1));

   if (j=rootNo) then
   begin
     iter[j]:=iter[j]+format('%d %20.8e %20.8e %20.8e %20.8e %20.8e %20.8e',[l,a,c,b,ya,yc,yb])+#13#10;
     inc(l);
   end;

   if (c=0) then goto stop
   else if (yb*yc)>0 then
   begin
    b:=c;
    yb:=yc;
   end
   else
   begin
    a:=c;
    ya:=yc;
   end;
   dx:=min(abs(dx),ac);
   if (abs(dx)<delta) then goto stop;
   if (abs(yc)<epsilon) then goto stop;
  end;
  stop:

  root[j]:=c;
  error[j]:=abs(b-a)/2;

  c_str:=floattostr(c);
  setS(vals1[0],c_str);
  yc:=strtofloat(ArtFormula1.ComputeStr(YEquation,num,@vars,@vals1));
  residual[j]:=yc;

  inc(j);
  a:=x3[i];

  until (x3[i]>=rb);
   if (c>rb) then dec(j); //to avoid over root

   stop2:
   if (j=1) then
   begin
    showmessage('Try another interval [a,b] or have no root !!!');
    goto stop3;
   end;


   //Display result
   line:='===================================================================================';
   Resultlabel.Caption:='Result :';
   ResultMemo.Lines.Add(format('%1s %27s %47s %44s',['No','Root(c)','Error','Residual F(c)']));
   ResultMemo.Lines.Add(line);

   for k:=1 to j-1 do
    begin
     ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %30.18e',[root[k]])+format('%30.18e',[error[k]])+format('%30.18e',[residual[k]]));
    end;

   ResultMemo.Lines.Add(#13#10+'Number of roots = '+inttostr(j-1)+#13#10+#13#10);

  //with view iteration
   if (IterCheck.Checked) then
   begin
    if (rootNo>=j) then
    begin
     showmessage('Max root number is '+inttostr(j-1)+' !!!');
     goto stop3;
    end;

    if (rootNo=0) then
    begin
     showmessage('Min root number is 1 !!!');
     goto stop3;
    end;

    Resultlabel.Caption:='Result - iteration :';
    ResultMemo.Lines.Add('Iteration of the root-'+inttostr(rootNo)+' :'+#13#10);
    ResultMemo.Lines.Add(format('%1s %25s %24s %25s %25s %30s %30s',['i','left point(ai)','mid point(ci)','right point(bi)','F(ai)','F(ci)','F(bi)']));
    ResultMemo.Lines.Add(line);
    ResultMemo.Lines.Add(iter[rootNo]);
    ResultMemo.Lines.Add('Root(c) = '+format('%22.18e',[root[rootNo]]));
    ResultMemo.Lines.Add('Error = '+format('%22.18e',[error[rootNo]]));
    ResultMemo.Lines.Add('Residual F(c) = '+format('%22.18e',[residual[rootNo]]));
   end;

  //Graph
  GraphYSeries1.Clear;
  h:=abs(x2-x1)/M; //h stepsize of graph

   for k:=0 to M do
   begin
    x[k]:=x1+k*h;
    x_str:=floattostr(x[k]);
    setS(vals1[0],x_str);
    y[k]:=strtofloat(ArtFormula1.ComputeStr(YEquation,num,@vars,@vals1));
   end;

   for k:=0 to M do
   begin
    GraphYSeries1.AddXY(x[k],y[k] ); //(x,y)
   end;

   for k:=1 to j-1  do
   begin
    RootSeries2.AddXY(root[k],0); //(c,0)
   end;

   stop3:
 except
  showmessage('Something wrong with the input !!!');

 end;

end;

procedure TForm1.ClearButClick(Sender: TObject);
begin
  aEdit.Clear;
  bEdit.Clear;
  deltaEdit.Clear;
  epsilonEdit.Clear;
  iterEdit.Clear;
  x1Edit.Clear;
  x2Edit.Clear;
  MEdit.Clear;
  gammaEdit.Clear;
  YEdit.Clear;
  ResultMemo.Clear;
  GraphYSeries1.Clear;
  RootSeries2.Clear;
  SinglerootEdit.Clear;
  IterCheck.Checked:=false;

end;

procedure TForm1.AboutButClick(Sender: TObject);
const
 sAbout = '|======== Multi-Root Finding ========|' + #13#10 +
          '' + #13#10 +
          'Version 1.2 - build Nov 1, 2024'+ #13#10 +
          'Created by Lukas Setiawan.' + #13#10 +
          'Copyright (c) 2024. All Rights Reserved.' + #13#10 +
          '' + #13#10 +
          'Visit https://nix97.github.io/numericalmethods/' + #13#10 +
          'Facebook search: Metode Numerik-Plus Programnya' + #13#10 +
          'E-mail : lukassetiawan@yahoo.com' + #13#10 +
          '' + #13#10 +
          'My other works :'+ #13#10 +
          'https://bitbucket.org/nixz97/nix/downloads/' + #13#10 +

          '' + #13#10 +
          'Accepting donations for software development.'+ #13#10;

begin
 MessageDlg( sAbout, mtInformation, [mbOK], 0);
end;

procedure TForm1.ExampleButClick(Sender: TObject);
begin

  YEdit.Text:='x*sin(x)-1';
  aEdit.Text:='-10';
  bEdit.Text:='10';
  deltaEdit.Text:='1e-12';
  epsilonEdit.Text:='1e-12';
  IterEdit.Text:='1000';
  MEdit.Text:='100';
  gammaEdit.Text:='0.01';
  x1Edit.Text:='-10';
  x2Edit.Text:='10';
  SinglerootEdit.Text:='1';
  IterCheck.Checked:=true;

end;

end.

