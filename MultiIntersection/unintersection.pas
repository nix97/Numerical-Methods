unit unIntersection;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, formula,
  TAGraph, TASeries,math;

type

  { TForm1 }

  TForm1 = class(TForm)
    AboutBut: TButton;
    ArtFormula1: TArtFormula;
    Chart1: TChart;
    GraphicY2: TLineSeries;
    ClearBut: TButton;
    deltaEdit: TEdit;
    epsilonEdit: TEdit;
    ExampleBut: TButton;
    gammaEdit: TEdit;
    GraphicY1: TLineSeries;
    GraphYSeries2: TLineSeries;
    HelpMemo: TMemo;
    IterCheck: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbEdit: TEdit;
    IntersectPoint: TLineSeries;
    MaxSeries3: TLineSeries;
    MEdit: TEdit;
    MaxEdit: TEdit;
    Iteration: TLineSeries;
    MinSeries4: TLineSeries;
    IntersectNoEdit: TEdit;
    processTime: TLabel;
    rbEdit: TEdit;
    ResultLabel: TLabel;
    ResultMemo: TMemo;
    RunBut: TButton;
    x1Edit: TEdit;
    x2Edit: TEdit;
    Y1Edit: TEdit;
    Y2Edit: TEdit;
    procedure ClearButClick(Sender: TObject);
    procedure ExampleButClick(Sender: TObject);
    procedure RunButClick(Sender: TObject);
    procedure AboutButClick(Sender: TObject);
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
  lb,rb,a,b,c,ac,delta,epsilon,ya,yb,yc,dx,h,x1,x2,x3,x4,y1,y2,y3,y4,gamma : extended;
  k,i,j,max,num,M,l,IntersectNo : integer;
  vars : array of string;
  vals1 : TCalcArray;
  a_str,b_str,c_str,x_str,Y1Equ,Y2Equ,x3_str,line,line2,x4_str,new_equ,iter : string;
  graphX1,graphX2,GraphY1,GraphY2,IntersectX,IntersectY: array[0..10000] of extended;
  start_time, stop_time, elapsed : TDateTime;

begin

 try

    start_time := now; //start to counting Process time
    lb:=strtofloat(lbEdit.Text);//left boundary(lb)
    rb:=strtofloat(rbEdit.Text); //right boundary(rb)
    delta:=strtofloat(deltaEdit.Text); //delta is tolerance for the zero
    epsilon:=strtofloat(epsilonEdit.Text); //epsilon is tolerance for the value of F at zero
    gamma:=strtofloat(gammaEdit.Text); //constan width step size to count F(x),F(x+gamma) etc e.g. gamma=0.1;
    max:=strtoint(MaxEdit.Text); //max iteration
    x1:=strtofloat(x1Edit.Text); //domain graph [x1,x2]
    x2:=strtofloat(x2Edit.Text);
    M:=strtoint(MEdit.Text); //smoothness of graph
    Y1Equ:=Y1Edit.text; //equation Y1
    Y2Equ:=Y2Edit.text; //equation Y2
    IntersectNo:=strtoint(IntersectNoEdit.Text); //no of intersection point, start from 1 in left


    //handling boundary etc
    if (x1=0) then x1:=-0.1;//due to graph problem, can not zero
    if (lb>=rb) then
    begin
     showmessage('Value of lb must be lower than rb !!!');
     goto stop3;
    end;

    if (delta<1e-12) or (epsilon<1e-12) then
    begin
     showmessage('Minimum value of delta or epsilon is 1e-12 !!!');
     goto stop3;
    end;

    if (lb<x1) or (rb>x2) then
    begin
     showmessage('Value of [lb,rb] must be on the domain graph [x1,x2]  !!!');
     goto stop3;
    end;

    if (gamma<1e-12) then
    begin
     showmessage('Minimum value of gamma is 1e-6 !!!');
     goto stop3;
    end;

    if (max>1000) then
    begin
     showmessage('Max of iteration is 1000 !!!');
     goto stop3;
    end;

    if (M>10000) then
    begin
     showmessage('Max of M is 10000 !!!');
     goto stop3;
    end;

    //end of handling

    //how to use ArtFormula
    num:=1; //numbers of variable (x)
    setlength(vars,num); //variable
    setlength(vals1,num); //value
    vars[0]:='x'; //x //symbol var in equ F(x) and G(x)

    //clear graph,result
    IntersectPoint.Clear;
    ResultMemo.Clear;
    GraphicY1.Clear;
    GraphicY2.Clear;
    Iteration.Clear;
    IntersectPoint.Clear;
    GraphicY1.Legend.Visible:=false;
    GraphicY2.Legend.Visible:=false;
    IntersectPoint.Legend.Visible:=false;
    Iteration.Legend.Visible:=false;

    j:=0; //index intersect
    i:=0; //index iteration to find left point(a) and right point(b)
    l:=0; //index iteration
    iter:='';

 repeat
   found:=false; //initial state as not found yet

   repeat
    //count y1 at x1
    x3:=lb+i*gamma; //use symbol x3 due to x1 & x2 used in graph domain [x1,x2], x3=x1 in illustration
    x3_str:=floattostr(x3);
    setS(vals1[0],x3_str);
    y1:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

    //count y2 at x1
    y2:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

    //count y1 at x2, call y3
    x4:=x3+gamma; //x4=x2 in illustration means x2=x1+gamma
    x4_str:=floattostr(x4);
    setS(vals1[0],x4_str);
    y3:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

    //count y2 at x2, call y4
    y4:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

    //(F(x1) < G(x1) and F(x2) > G(x2))   or   (F(x1) > G(x1) and F(x2) < G(x2))
    if ((y1<y2) and (y3>y4) or ((y1>y2) and (y3<y4))) then
    begin
     found:=true; //fullfil condition above so it's found intersection point
     inc(j);
    end;

    inc(i);

    if (x3>rb) then goto stop2; //if x3 over right boundary but not found then message ('no point');

   until(found=true);

   //When 2 graph intersec Y1=Y2 so Y1-Y2=0 (it's root finding problem)
   //it's use False Position method

    new_equ:=Y1Equ+'-('+Y2Equ+')'; //new_equ=Y1-Y2, use parenthesis ()
    a_str:=floattostr(x3);

    setS(vals1[0],a_str);
    ya:=strtofloat(ArtFormula1.ComputeStr(new_equ,num,@vars,@vals1));

    //b_str:=floattostr(x3[i]);
    b_str:=floattostr(x4);
    setS(vals1[0],b_str);
    yb:=strtofloat(ArtFormula1.ComputeStr(new_equ,num,@vars,@vals1));

    a:=x3; //left end point to start iteration
    b:=x4; //right end point to start iteration

    //starting iteration till reach condition
    for k:=1 to max do
    begin
     dx:=yb*(b-a)/(yb-ya);
     c:=b-dx;
     ac:=c-a;

     c_str:=floattostr(c);
     setS(vals1[0],c_str);
     yc:=strtofloat(ArtFormula1.ComputeStr(new_equ,num,@vars,@vals1));

     //View iteration
     if IterCheck.Checked=true then
     begin
      if (j=IntersectNo) then
      begin
       iter:=iter+format('%d %20.8e %20.8e %20.8e %20.8e %20.8e %20.8e',[l,a,c,b,ya,yc,yb])+#13#10;
       inc(l);
      end;
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
     if (abs(dx)<delta) then goto stop; //condition 1
     if (abs(yc)<epsilon) then goto stop; //or condition 2
    end;
    stop:

    IntersectX[j]:=c;

    c_str:=floattostr(c);
    setS(vals1[0],c_str);
    yc:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //input x value to one of equ(Y1 or Y2)
    IntersectY[j]:=yc;

 until (x3>rb);

    stop2:
    if (j=0) then
    begin
     showmessage('Try another interval [lb,rb] or have no intersection point !!!');
     goto stop3;
    end;


    //Display result
    line:='================================================================================';
    line2:='===========================================';
    Resultlabel.Caption:='Result :';
    ResultMemo.Lines.Add(format('%1s %30s %40s',['No','X Intersection','Y Intersection']));
    ResultMemo.Lines.Add(line2);

    for k:=1 to j do
    begin
     ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %30.18e',[IntersectX[k]])+format(' %30.18e',[IntersectY[k]]));
    end;

    ResultMemo.Lines.Add(#13#10+'The number of Intersection points is '+inttostr(j)+'.'+#13#10+#13#10);

    //view iteration
    if (IterCheck.Checked) then
    begin
     if (IntersectNo>j) then
     begin
      showmessage('Max intersection number is '+inttostr(j)+' !!!');
      goto stop3;
     end;

     if (IntersectNo<=0) then
     begin
      showmessage('Minimum intersection number is 1 !!!');
      goto stop3;
     end;

     Resultlabel.Caption:='Result - Iteration :';
     ResultMemo.Lines.Add('Iteration of the intersection point-'+inttostr(IntersectNo)+' :'+#13#10);
     ResultMemo.Lines.Add(format('%1s %25s %24s %25s %25s %30s %30s',['i','left point(ai)','mid point(ci)','right point(bi)','F(ai)','F(ci)','F(bi)']));
     ResultMemo.Lines.Add(line);
     ResultMemo.Lines.Add(iter);

     //graph iteration
     Iteration.Legend.Visible:=true;
     Iteration.AddXY(IntersectX[IntersectNo],IntersectY[IntersectNo]);
    end;


    //Graph
    //graph Y1
    GraphicY1.Legend.Visible:=true;
    h:=abs(x2-x1)/M; //h stepsize of graph
    for k:=0 to M do
    begin
      graphX1[k]:=x1+k*h; //graph Y1 is (graphX1,graphY1)
      x_str:=floattostr(graphX1[k]);
      setS(vals1[0],x_str);
      graphY1[k]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));
    end;

    for k:=0 to M do
    begin
      GraphicY1.AddXY(graphX1[k],graphY1[k]);
    end;

    //graph Y2
    GraphicY2.Legend.Visible:=true;
    h:=abs(x2-x1)/M; //h stepsize of graph
    for k:=0 to M do
    begin
      graphX2[k]:=x1+k*h; //graph Y2 is(graphX2,graphY2)
      x_str:=floattostr(graphX2[k]);
      setS(vals1[0],x_str);
      graphY2[k]:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));
    end;

    for k:=0 to M do
    begin
      GraphicY2.AddXY(graphX2[k],graphY2[k]);
    end;

    //Intersection points
    IntersectPoint.Legend.Visible:=true;
    for k:=1 to j do
    begin
      IntersectPoint.AddXY(IntersectX[k],IntersectY[k]);
    end;

  stop3:

  except
   showmessage('Something wrong with the input !!!');
 end;

 stop_time := Now;
 elapsed := stop_time - start_time;
 processTime.Caption:='Process time : '+timetostr(elapsed)+' (hh:mm:ss)';

end;

procedure TForm1.ExampleButClick(Sender: TObject);
begin
 Y1Edit.text:='sin(x*sin(0.97*x)-1)';
 Y2Edit.text:='cos(x^2-7.7)';
 lbEdit.Text:='-4';
 rbEdit.Text:='4';
 deltaEdit.Text:='1e-12';
 epsilonEdit.Text:='1e-12';
 gammaEdit.Text:='0.1';
 MaxEdit.Text:='1000';
 MEdit.Text:='2000';
 x1Edit.Text:='-5';
 x2Edit.Text:='5';
 IterCheck.Checked:=true;
 IntersectNoEdit.Text:='1';

end;

procedure TForm1.ClearButClick(Sender: TObject);
begin
 Y1Edit.Clear;
 Y2Edit.Clear;
 lbEdit.Clear;
 rbEdit.Clear;
 deltaEdit.Clear;
 epsilonEdit.Clear;
 gammaEdit.Clear;
 MaxEdit.Clear;
 MEdit.Clear;
 x1Edit.Clear;
 x2Edit.Clear;
 IntersectNoEdit.Clear;
 IterCheck.Checked:=false;
 ResultMemo.Clear;
 ResultLabel.Caption:='Result :';
 processTime.Caption:='Process Time :';

 IntersectPoint.Clear;
 GraphicY1.Clear;
 GraphicY2.Clear;
 Iteration.Clear;
 IntersectPoint.Clear;
 Iteration.Legend.Visible:=false;

end;


procedure TForm1.AboutButClick(Sender: TObject);
const
 sAbout = '|======== Multi-Intersection Point Finder ========|' + #13#10 +
          '' + #13#10 +
          'Version 1.1 - build Feb 2, 2025'+ #13#10 +
          'Created by Lukas Setiawan.' + #13#10 +
          'Copyright (c) 2025. All Rights Reserved.' + #13#10 +
          '' + #13#10 +
          'Visit https://nix97.github.io/numericalmethods/' + #13#10 +
          'Facebook search: Metode Numerik-Plus Programnya' + #13#10 +
          'E-mail : lukassetiawan@yahoo.com' + #13#10 +
          '' + #13#10 +
          'My Work :'+ #13#10 +
          'https://bitbucket.org/nixz97/nix/downloads/' + #13#10 +

          '' + #13#10 +
          'Accepting donations for software development.'+ #13#10;
 begin
  MessageDlg( sAbout, mtInformation, [mbOK], 0);
 end;


end.

