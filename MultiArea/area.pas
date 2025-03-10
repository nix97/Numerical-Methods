unit Area;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  formula, TAGraph, TASeries, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    AboutBut: TButton;
    ArtFormula1: TArtFormula;
    Area1: TAreaSeries;
    BoundLine: TLineSeries;
    BoundLine2: TLineSeries;
    DoubleExamBut: TButton;
    Chart1: TChart;
    ClearBut: TButton;
    deltaEdit: TEdit;
    epsilonEdit: TEdit;
    SingleExamBut: TButton;
    gammaEdit: TEdit;
    GraphicY1: TLineSeries;
    GraphicY2: TLineSeries;
    GraphicY3: TLineSeries;
    GraphicY4: TLineSeries;
    HelpMemo: TMemo;
    AreaCheck: TCheckBox; //IterPointCheckAreaCheck
    Label15: TLabel;
    NoPointEdit: TEdit;
    NoAreaEdit: TEdit;
    Point: TLineSeries;
    IntersectPoint1: TLineSeries;
    Iteration1: TLineSeries;
    IterPointCheck: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbEdit: TEdit;
    MaxEdit: TEdit;
    rgCurve: TRadioGroup;
    SEdit: TEdit;
    MEdit: TEdit;
    processTime: TLabel;
    rbEdit: TEdit;
    ResultLabel: TLabel;
    ResultMemo: TMemo;
    RunBut: TButton;
    x1Edit: TEdit;
    x2Edit: TEdit;
    Y1Edit: TEdit;
    Y2Edit: TEdit;
    procedure AboutButClick(Sender: TObject);
    procedure ClearButClick(Sender: TObject);
    procedure SingleExamButClick(Sender: TObject);
    procedure DoubleExamButClick(Sender: TObject);
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
  stop,stop3,break,break2,stopDouble;
var
  found : boolean;
  a,b,c,lb,rb,ac,delta,epsilon,ya,yb,yc,dx,h,x1,x2,x4,x5,x6,x7,resultEven,resultOdd : extended;
  gamma,y1,y2,y3,y4,TotalArea,lb1,lb2,rb1,rb2,lb1_point,lb2_point,rb1_point,rb2_point : extended;
  k,i,j,max,num,M,S,l,NoPoint,NoArea,totalBP,p : integer;
  vars : array of string;
  vals1 : TCalcArray;
  a_str,b_str,c_str,x_str,Y1Equ,Y2Equ,x4_str,x5_str,line,line2,line3 : string;
  iter,iter2,Y3Equ : string;
  x,y,x2graph,y2graph,boundPoint,fc,residual,Area,x_area,Fx0,FxM,sumEven,sumOdd,Fx_Area : array[0..10000] of extended;
  start_time, stop_time, elapsed : TDateTime;

begin

 try
   start_time := now; //start to counting Process time

   lb:=strtofloat(lbEdit.Text); //left boundary
   rb:=strtofloat(rbEdit.Text); //right boundary
   delta:=strtofloat(deltaEdit.Text); //tolerance for the zero
   epsilon:=strtofloat(epsilonEdit.Text); //tolerance of the function at the zero
   max:=strtoint(MaxEdit.Text); //max AreaHighlight
   x1:=strtofloat(x1Edit.Text); //domain graph [x1,x2]
   x2:=strtofloat(x2Edit.Text);
   M:=strtoint(MEdit.Text); //number of subinterval of area
   S:=strtoint(SEdit.Text); //smoothness of graph
   gamma:=strtofloat(gammaEdit.Text); //const width step size as scanner from lb+gamma to analyze f(x),f(x+gamma),..so on. With different gamma each step.
   Y1Equ:=Y1Edit.text; //Equation Y1
   Y2Equ:=Y2Edit.text; //Equation Y2
   NoPoint:=strtoint(NoPointEdit.Text); //No point to view AreaHighlight of the point(point of boundary area)
   NoArea:=strtoint(NoAreaEdit.Text); //No area to view which the area counted

   //handling boundary etc
   if (lb>=rb) then
   begin
     showmessage('Value of rb must be greater than lb !!!');
     goto stop3;
   end;

   if (delta<1e-18) or (epsilon<1e-18) then
   begin
     showmessage('Min value of the delta or epsilon is 1e-18 !!!');
     goto stop3;
   end;

   if (lb<x1) or (rb>x2) then
   begin
     showmessage('Value of [lb,rb] at most on the domain x1 & x2  !!!');
     goto stop3;
   end;

   if (max>10000) then
   begin
     showmessage('Max of the max iter is 10000 !!!');
     goto stop3;
   end;

   if (M>10000) then
   begin
     showmessage('Max of the M is 10000 !!!');
     goto stop3;
   end;

   if (M mod 2<>0) then //due to Simpson's 1/3 have two subinterval, so must be even
   begin
     showmessage('M must be even !!!');
     goto stop3;
   end;

   if (gamma<1e-12) then
   begin
     showmessage('Min of the gamma is 1e-12 !!!');
     goto stop3;
   end;

   num:=1; //numbers of variable (x)
   setlength(vars,num); //how to use ArtFormula as parser (start here)
   setlength(vals1,num);
   vars[0]:='x'; //var x at F(x),G(x) //...till here

   ResultMemo.lines.clear; //view result
   Point.Clear; //clear graph
   GraphicY1.Clear;
   GraphicY2.Clear;
   Area1.Clear;
   BoundLine.Clear;
   BoundLine2.Clear;

   j:=1; //index point of boundary(outer repeat loop)
   i:=0; //index to find boundary(inner repeat loop)
   l:=0; //index AreaHighlight root
   iter:='';//string to view AreaHighlight
   iter2:='';//string to view AreaHighlight double curve

   if (rgCurve.ItemIndex=0) then //single curve
   begin
   repeat
     found:=false; //root not found yet

     repeat

       //count y1 at x4 (graph cross x-axis if opposite y1&y2 or (y1*y2)<0)
       x4:=lb+i*gamma; //use symbol x4 (at start x4=lb when i=0) how to count y use ArtFormula...
       x4_str:=floattostr(x4);
       setS(vals1[0],x4_str);
       y1:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //...till here

       //count y2 at x5+gamma
       x5:=x4+gamma; //position point x with different gamma
       x5_str:=floattostr(x5);
       setS(vals1[0],x5_str);
       y2:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

       //y1 & y2 have opposite sign
       if (y1*y2<0) then
       begin
         found:=true; //fulfill condition above so it's found intersection point
         inc(j);
       end;

       if (x4>=rb) then goto break;
       inc(i);

     until(found=true);

     a_str:=floattostr(x4); // use of artFormula
     setS(vals1[0],a_str);
     ya:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

     b_str:=floattostr(x5);
     setS(vals1[0],b_str);
     yb:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

     a:=x4;
     b:=x5;

     for k:=1 to max do //max iteration
     begin
       dx:=yb*(b-a)/(yb-ya);
       c:=b-dx;
       ac:=c-a;

       c_str:=floattostr(c);
       setS(vals1[0],c_str);
       yc:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

       //iteration point
       if IterPointCheck.Checked=true then
       begin
         if (j=NoPoint) then
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
       if (abs(dx)<delta) then goto stop;
       if (abs(yc)<epsilon) then goto stop;
     end;

    stop:
    boundPoint[j]:=c; //boundaryPoint(root)
    //error[j]:=abs(b-a)/2; not display just as note

    c_str:=floattostr(c);
    setS(vals1[0],c_str);
    yc:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));
    residual[j]:=yc;

  until (x4>=rb);

  break:

  if (j=1) then //no root
  begin
    showmessage('Have no root or no need to view iteration of the point(lb & rb only) !!!');
    IterPointCheck.Checked:=false;
    boundPoint[1]:=lb;
    boundPoint[2]:=rb;
    totalBP:=2;
  end
  else
  if (abs(boundPoint[j]-rb)<1e-12) then //means last bound point=rb(same value)
  begin
    totalBP:=j;
  end
  else
  begin
    boundPoint[1]:=lb;
    boundPoint[j+1]:=rb;
    totalBP:=j+1;
  end;

   //calculate area

   for p:=1 to totalBP-1 do //Number of Area
   begin
     x_area[0]:=boundPoint[p];
     x_str:=floattostr(x_area[0]);
     setS(vals1[0],x_str);
     Fx0[p]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //f(lb) or f(x0) of each area

     x_area[M]:=boundPoint[p+1];
     x_str:=floattostr(x_area[M]);
     setS(vals1[0],x_str);
     FxM[p]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //f(rb) or f(xM) of each area

     h:=(boundPoint[p+1]-boundPoint[p])/M;

     //Sum even e.g. x2,x4,...
     sumeven[p]:=0;
     for k:=1 to (trunc(M/2)-1) do
     begin
       x_area[2*k]:=boundPoint[p]+2*k*h;
       x_str:=floattostr(x_area[2*k]);
       setS(vals1[0],x_str);
       resultEven:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //f(lb) or f(x0)
       sumEven[p]:=sumEven[p]+resultEven; //sum of even
     end;

     //Sum odd e.g. x1,x3,...
     sumOdd[p]:=0;
     for k:=1 to trunc(M/2) do
     begin
       x_area[2*k-1]:=boundPoint[p]+(2*k-1)*h;
       x_str:=floattostr(x_area[2*k-1]);
       setS(vals1[0],x_str);
       resultOdd:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //f(lb) or f(x0)
       sumOdd[p]:=sumOdd[p]+resultOdd; //sum of even
     end;

     Area[p]:=abs(h*(Fx0[p]+2*sumEven[p]+4*sumOdd[p]+FxM[p])/3);

     TotalArea:=0;
     for k:=1 to totalBP-1 do
     begin
       TotalArea:=TotalArea+Area[k];
     end;
   end;

   //Display result
   line:='==============================================================';
   ResultMemo.Lines.Add(format('%1s %27s %40s %38s',['No','Lower Limit','Upper Limit','Area']));
   ResultMemo.Lines.Add(line);

   for k:=1 to totalBP-1 do
   begin
     ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %30.18e',[boundPoint[k]])+format('%30.18e',[boundPoint[k+1]])+format('%30.18e',[Area[k]]));
   end;

   ResultMemo.Lines.Add(#13#10+'Total of the Area='+floattostr(TotalArea)+#13#10+#13#10);

   //view iteration point
   if (IterPointCheck.Checked) then
   begin
     if (NoPoint<1) then
     begin
       showmessage('Min of the no point is 2, due to point-1 is left boundary or no need iteration !!!');
       goto stop3;
     end;

     if (NoPoint=1) then
     begin
       showmessage('This point is the left boundary or no need iteration !!! , try [2,'+inttostr(totalBP-1)+']');
       goto stop3;
     end;

     if (NoPoint=totalBP) then
     begin
       showmessage('This point is the right boundary or no need iteration !!! , try [2,'+inttostr(totalBP-1)+']');
       goto stop3;
     end;

     if (NoPoint>totalBP) then
     begin
       showmessage('Max of the boundary point is '+inttostr(totalBP-1)+' !!! , try [2,'+inttostr(totalBP-1)+']');
       goto stop3;
     end;

     line2:='================================================================================';
     ResultMemo.Lines.Add('The iteration of the boundary point-'+inttostr(NoPoint)+' :'+#13#10);
     ResultMemo.Lines.Add(format('%1s %22s %20s %25s %17s %29s %29s',['k','left endpoint(ak)','mid point(ck)','right endpoint(bk)','F(ak)','F(ck)','F(bk)']));
     ResultMemo.Lines.Add(line2);
     ResultMemo.Lines.Add(iter);
     ResultMemo.Lines.Add('Bound point or root(c)='+format('%22.18e',[boundPoint[NoPoint]]));
     ResultMemo.Lines.Add('Residual F(c)='+format('%22.18e',[residual[NoPoint]])+#13#10+#13#10);

  end;

  //View counting area
  h:=(boundPoint[NoArea+1]-boundPoint[NoArea])/M;
  if (AreaCheck.Checked=true) then
  begin
  //Display result area count

  if (NoArea>(totalBP-1)) then //Number of Area=totalBP-1
  begin
   showmessage('Max of the area is '+inttostr(totalBP-1)+' !!!');
   goto stop3;
  end;

  if (NoArea<1) then
  begin
    showmessage('Min of the no area is 1 !!!');
    goto stop3;
  end;

  a:=boundPoint[NoArea];
  b:=boundPoint[NoArea+1];
  h:=(b-a)/M;

  ResultMemo.Lines.Add('The Calculation of the Area-'+inttostr(NoArea)+#13#10);
  line3:='============================================';
  ResultMemo.Lines.Add(format('%1s %27s %47s',['k','Xk','F(Xk)']));
  ResultMemo.Lines.Add(line3);

  for k:=0 to M do
  begin
    x_area[k]:=boundPoint[NoArea]+k*h;
    x_str:=floattostr(x_area[k]);
    setS(vals1[0],x_str);
    Fx_Area[k]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));
    ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %30.18e',[x_area[k]])+format('%30.18e',[Fx_area[k]]));
  end;

  ResultMemo.Lines.Add(#13#10+'Area=h/3[F(X0)+2*SumEven(Fx)+4*SumOdd(Fx)+F(XM)];  get absolute value ');
  ResultMemo.Lines.Add('where h=(b-a)/M'+#13#10);
  ResultMemo.Lines.Add('a='+floattostr(boundPoint[NoArea])+';  (lower limit)');
  ResultMemo.Lines.Add('b='+floattostr(boundPoint[NoArea+1])+';  (upper limit)');
  ResultMemo.Lines.Add('M='+inttostr(M)+';  (subinterval)');
  ResultMemo.Lines.Add('h=('+floattostr(boundPoint[NoArea+1])+'-'+floattostr(boundPoint[NoArea])+')/'+inttostr(M)+'='+floattostr(h)+';  (step size)'+#13#10);
  ResultMemo.Lines.Add('F(X0)='+floattostr(Fx0[NoArea])+';  (Fx at index k=0)');
  ResultMemo.Lines.Add('SumEven(Fx)='+floattostr(sumEven[NoArea])+';  (Sum of Fx at index even k=2,4,6,...,etc.)');
  ResultMemo.Lines.Add('SumOdd(Fx)='+floattostr(sumOdd[NoArea])+';  (Sum of Fx at index odd k=1,3,5,...,etc.)');
  ResultMemo.Lines.Add('F(XM)='+floattostr(FxM[NoArea])+';  (Fx at index k=M)'+#13#10);
  ResultMemo.Lines.Add('Area=abs('+floattostr(h)+'/'+'3'+'[('+floattostr(Fx0[NoArea])+')+2('+floattostr(sumEven[NoArea])+')+4('+floattostr(sumOdd[NoArea])+')+('+floattostr(FxM[NoArea])+')])');
  ResultMemo.Lines.Add('Area='+floattostr(Area[NoArea]));

 end;

 end  //end of single curve or rgCurve.ItemIndex=0
 else
 //double curve or rgCurve.ItemIndex=1,start here
 begin

   //When 2 graph intersec Y1=Y2 so Y1-Y2=0 or Y3=Y1-Y2, or Y3=0 (it's a root-finding  problem)
   //it's use False Position method

   Y3Equ:=Y1Equ+'-('+Y2Equ+')'; //Y3=Y1-Y2, use parenthesis ()
   repeat
     found:=false; //root not found yet

     repeat

       //count y1 at x6
       x6:=lb+i*gamma;
       x_str:=floattostr(x6);
       setS(vals1[0],x_str);
       y1:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

       //count y2 at x6
       y2:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

       //count y1 at x7
       x7:=x6+gamma; //x4=x2 in illustration means x2=x1+gamma
       x_str:=floattostr(x7);
       setS(vals1[0],x_str);
       y3:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

       //count y2 at x7
       y4:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

       //(F(x6) < G(x6) and F(x7) > G(x7))   or   (F(x6) > G(x6) and F(x7) < G(x7))
       if ((y1<y2) and (y3>y4) or ((y1>y2) and (y3<y4))) then
       begin
         found:=true; //fulfill condition above so it's found intersection point
         inc(j);
       end;

       if (x6>=rb) then goto break2;

       inc(i);

     until(found=true);

     //Y3Equ:=Y1Equ+'-('+Y2Equ+')'; //Y3=Y1-Y2, use parenthesis ()
     a_str:=floattostr(x6);
     setS(vals1[0],a_str);
     ya:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1));

     b_str:=floattostr(x7);
     setS(vals1[0],b_str);
     yb:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1));

     a:=x6; //left end point to start AreaHighlight
     b:=x7; //right end point to start AreaHighlight

     for k:=1 to max do //max AreaHighlight
     begin
       dx:=yb*(b-a)/(yb-ya);
       c:=b-dx;
       ac:=c-a;

       c_str:=floattostr(c);
       setS(vals1[0],c_str);
       yc:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1));

       if (j=NoPoint) then
       begin
         iter2:=iter2+format('%d %20.8e %20.8e %20.8e %20.8e %20.8e %20.8e',[l,a,c,b,ya,yc,yb])+#13#10;
         inc(l);
       end;

       //iteration point
       if IterPointCheck.Checked=true then
       begin
         if (j=NoPoint) then
         begin
           iter:=iter+format('%d %20.8e %20.8e %20.8e %20.8e %20.8e %20.8e',[l,a,c,b,ya,yc,yb])+#13#10;
           inc(l);
         end;
       end;

       if (c=0) then goto stopDouble
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
       if (abs(dx)<delta) then goto stopDouble;
       if (abs(yc)<epsilon) then goto stopDouble;
     end;

     stopDouble:
     boundPoint[j]:=c; //boundaryPoint(root) double curve

     //function value f(c) at point c(input c into y1 or y2 (intersection point)

     c_str:=floattostr(c);
     setS(vals1[0],c_str);
     fc[j]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //intersection poin(c,fc)

     c_str:=floattostr(c);
     setS(vals1[0],c_str);
     yc:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1));

     residual[j]:=yc;

   until (x6>=rb);

   break2:

   if (j=1) then //no root(no intersection)
   begin
     showmessage('Have no intersection or no need to view iteration of the point(lb & rb only) !!!');
     IterPointCheck.Checked:=false;
     boundPoint[1]:=lb;
     boundPoint[2]:=rb;
     totalBP:=2;
   end
   else
   if (abs(boundPoint[j]-rb)<1e-12) then //means last bound point=rb(same value)
   begin
     totalBP:=j;
   end
   else
   begin
     boundPoint[1]:=lb;
     boundPoint[j+1]:=rb;
     totalBP:=j+1;
   end;

   //case where lb=intersect point-1
   if (abs(boundPoint[2]-lb)<1e-12) then //means same value
   begin
     for k:=2 to j do
     begin
       boundPoint[1]:=lb;
       boundPoint[k]:=boundPoint[k+1];
       totalBP:=j;

       //recalculate fc at point(c,fc)
       c_str:=floattostr(boundPoint[k]);
       setS(vals1[0],c_str);
       fc[k]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1)); //intersection poin(c,fc)
     end;

     //also last bound point=rb
     if (abs(boundPoint[j-1]-rb)<1e-12) then
     begin
       totalBP:=j-1;
     end;
   end;

   for p:=1 to totalBP-1 do //Number of Area
   begin

     x_area[0]:=boundPoint[p];
     x_str:=floattostr(x_area[0]);
     setS(vals1[0],x_str);
     Fx0[p]:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1)); //f(lb) or f(x0) of each area

     x_area[M]:=boundPoint[p+1];
     x_str:=floattostr(x_area[M]);
     setS(vals1[0],x_str);
     FxM[p]:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1)); //f(rb) or f(xM) of each area


     h:=(boundPoint[p+1]-boundPoint[p])/M;

     //Sum even e.g. x2,x4,...
     sumeven[p]:=0;
     for k:=1 to (trunc(M/2)-1) do
     begin
      x_area[2*k]:=boundPoint[p]+2*k*h;
      x_str:=floattostr(x_area[2*k]);
      setS(vals1[0],x_str);
      resultEven:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1)); //f(lb) or f(x0)
      sumEven[p]:=sumEven[p]+resultEven; //sum of even
     end;

     //Sum odd e.g. x1,x3,...
     sumOdd[p]:=0;
     for k:=1 to trunc(M/2) do
     begin
      x_area[2*k-1]:=boundPoint[p]+(2*k-1)*h;
      x_str:=floattostr(x_area[2*k-1]);
      setS(vals1[0],x_str);
      resultOdd:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1)); //f(lb) or f(x0)
      sumOdd[p]:=sumOdd[p]+resultOdd; //sum of even
     end;


     Area[p]:=abs(h*(Fx0[p]+2*sumEven[p]+4*sumOdd[p]+FxM[p])/3);

     TotalArea:=0;
     for k:=1 to totalBP-1 do
     begin
      TotalArea:=TotalArea+Area[k];
     end;

    end;

    //Display result
    line:='==============================================================';
    ResultMemo.Lines.Add(format('%1s %27s %40s %38s',['No','Lower Limit','Upper Limit','Area']));
    ResultMemo.Lines.Add(line);

    for k:=1 to totalBP-1 do
    begin
      ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %30.18e',[boundPoint[k]])+format('%30.18e',[boundPoint[k+1]])+format('%30.18e',[Area[k]]));
    end;

    ResultMemo.Lines.Add(#13#10+'Total of the Area='+floattostr(TotalArea)+#13#10+#13#10);

    //view iteration point
    if (IterPointCheck.Checked) then
    begin
      if (NoPoint<1) then
      begin
        showmessage('Min of the no point is 2, due to point-1 is left boundary or no need iteration !!!');
        goto stop3;
      end;

      if (NoPoint=1) then
      begin
        showmessage('This point is the left boundary or no need iteration !!! , try [2,'+inttostr(totalBP-1)+']');
        goto stop3;
      end;

      if (NoPoint=totalBP) then
      begin
        showmessage('This point is the right boundary or no need iteration !!! , try [2,'+inttostr(totalBP-1)+']');
        goto stop3;
      end;

      if (NoPoint>totalBP) then
      begin
        showmessage('Max of the boundary point is '+inttostr(totalBP-1)+' !!! , try [2,'+inttostr(totalBP-1)+']');
        goto stop3;
      end;

      line2:='================================================================================';
      ResultMemo.Lines.Add('The iteration of the boundary point-'+inttostr(NoPoint)+' :'+#13#10);
      ResultMemo.Lines.Add(format('%1s %22s %20s %25s %17s %29s %29s',['k','left endpoint(ak)','mid point(ck)','right endpoint(bk)','F(ak)','F(ck)','F(bk)']));
      ResultMemo.Lines.Add(line2);
      ResultMemo.Lines.Add(iter);
      ResultMemo.Lines.Add('Bound point or root(c) ='+format('%22.18e',[boundPoint[NoPoint]]));
      ResultMemo.Lines.Add('Residual F(c)='+format('%22.18e',[residual[NoPoint]])+#13#10+#13#10);

   end;

   //View counting area
   h:=(boundPoint[NoArea+1]-boundPoint[NoArea])/M;
   if (AreaCheck.Checked=true) then
   begin

     if (NoArea>(totalBP-1)) then //Number of Area=totalBP-1
     begin
       showmessage('Max of area is '+inttostr(totalBP-1)+' !!!');
       goto stop3;
     end;

     if (NoArea<1) then
     begin
       showmessage('Min of no area is 1 !!!');
       goto stop3;
     end;

     a:=boundPoint[NoArea];
     b:=boundPoint[NoArea+1];
     h:=(b-a)/M;

     ResultMemo.Lines.Add('The Calculation of the Area-'+inttostr(NoArea)+#13#10);
     line3:='============================================';

     ResultMemo.Lines.Add(format('%1s %27s %47s',['k','Xk','F(Xk)']));
     ResultMemo.Lines.Add(line3);

     for k:=0 to M do
     begin
       x_area[k]:=boundPoint[NoArea]+k*h;
       x_str:=floattostr(x_area[k]);
       setS(vals1[0],x_str);
       Fx_Area[k]:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1));

       ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %30.18e',[x_area[k]])+format('%30.18e',[Fx_area[k]]));
     end;

     ResultMemo.Lines.Add(#13#10+'Area=h/3[F(X0)+2*SumEven(Fx)+4*SumOdd(Fx)+F(XM)];  get absolute value ');
     ResultMemo.Lines.Add('where h=(b-a)/M'+#13#10);
     ResultMemo.Lines.Add('a='+floattostr(boundPoint[NoArea])+';  (lower limit)');
     ResultMemo.Lines.Add('b='+floattostr(boundPoint[NoArea+1])+';  (upper limit)');
     ResultMemo.Lines.Add('M='+inttostr(M)+';  (subinterval)');
     ResultMemo.Lines.Add('h=('+floattostr(boundPoint[NoArea+1])+'-'+floattostr(boundPoint[NoArea])+')/'+inttostr(M)+'='+floattostr(h)+';  (step size)'+#13#10);
     ResultMemo.Lines.Add('F(X0)='+floattostr(Fx0[NoArea])+';  (Fx at index k=0)');
     ResultMemo.Lines.Add('SumEven(Fx)='+floattostr(sumEven[NoArea])+';  (Sum of Fx at index even k=2,4,6,...,etc.)');
     ResultMemo.Lines.Add('SumOdd(Fx)='+floattostr(sumOdd[NoArea])+';  (Sum of Fx at index odd k=1,3,5,...,etc.)');
     ResultMemo.Lines.Add('F(XM)='+floattostr(FxM[NoArea])+';  (Fx at index k=M)'+#13#10);
     ResultMemo.Lines.Add('Area=abs('+floattostr(h)+'/'+'3'+'[('+floattostr(Fx0[NoArea])+')+2('+floattostr(sumEven[NoArea])+')+4('+floattostr(sumOdd[NoArea])+')+('+floattostr(FxM[NoArea])+')])');
     ResultMemo.Lines.Add('Area='+floattostr(Area[NoArea]));
   end;

 end;

 //Graph
 GraphicY1.Legend.Visible:=false;
 GraphicY2.Legend.Visible:=false;
 Area1.Legend.Visible:=false;
 BoundLine.Legend.Visible:=false;
 BoundLine2.Legend.Visible:=false;


 //Graph Y1

 h:=abs(x2-x1)/S; //h stepsize of graph
 for k:=0 to S do
 begin
   x[k]:=x1+k*h;
   x_str:=floattostr(x[k]);
   setS(vals1[0],x_str);
   y[k]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));
 end;

 for k:=0 to S do
 begin
   GraphicY1.AddXY(x[k],y[k] ); //(x,y)
 end;

 Point.Legend.Visible:=true;
 GraphicY1.Legend.Visible:=true;

 if (rgCurve.ItemIndex=0) then //single curve
 begin
   //root or boundary point of area
   for k:=1 to totalBP  do
   begin
     Point.AddXY(boundPoint[k],0); //(c,0)
   end;

  //Graph Y1 shaded
  Area1.Legend.Visible:=true;
  h:=abs(rb-lb)/S; //h stepsize of graph

  for k:=0 to S do
  begin
    x[k]:=lb+k*h;
    x_str:=floattostr(x[k]);
    setS(vals1[0],x_str);
    y[k]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));
  end;

  for k:=0 to S do
  begin
    Area1.AddXY(x[k],y[k] ); //shaded single
    Area1.UseZeroLevel:=true;
  end;

 end
 else //double curve
 begin
   //Graph Y2
   GraphicY2.Legend.Visible:=true;
   h:=abs(x2-x1)/S; //h stepsize of graph
   for k:=0 to S do
   begin
     x2graph[k]:=x1+k*h;
     x_str:=floattostr(x2graph[k]);
     setS(vals1[0],x_str);
     y2graph[k]:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));
   end;

   for k:=0 to S do
   begin
     GraphicY2.AddXY(x2graph[k],y2graph[k] ); //(x2,y2)
   end;


   for k:=2 to totalBP-1  do
   begin
     Point.AddXY(boundPoint[k],fc[k]); //(c,fc)
   end;


   //Bound line(lb and rb),dash line

   //lb dash
   x_str:=floattostr(boundPoint[1]);
   setS(vals1[0],x_str);
   lb1:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

   x_str:=floattostr(boundPoint[1]);
   setS(vals1[0],x_str);
   lb2:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

   BoundLine.AddXY(boundPoint[1],lb1);
   BoundLine.AddXY(boundPoint[1],lb2);

   //rb dash
   x_str:=floattostr(boundPoint[totalBP]);
   setS(vals1[0],x_str);
   rb1:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

   x_str:=floattostr(boundPoint[totalBP]);
   setS(vals1[0],x_str);
   rb2:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

   BoundLine2.AddXY(boundPoint[totalBP],rb1);
   BoundLine2.AddXY(boundPoint[totalBP],rb2);

   //plot point at lb
   x_str:=floattostr(boundPoint[1]);
   setS(vals1[0],x_str);
   lb1_point:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

   x_str:=floattostr(boundPoint[1]);
   setS(vals1[0],x_str);
   lb2_point:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

   if abs((lb1_point-lb2_point))<1e-12 then //same or intersection point at lb
   begin
     Point.AddXY(boundPoint[1],lb1_point); //lb=intersection point
   end
   else //at lb do not intersect
   begin
     Point.AddXY(boundPoint[1],lb1);
   end;

   //plot point at rb
   x_str:=floattostr(boundPoint[totalBP]);
   setS(vals1[0],x_str);
   rb1_point:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));

   x_str:=floattostr(boundPoint[totalBP]);
   setS(vals1[0],x_str);
   rb2_point:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));

   if abs((rb1_point-rb2_point))<1e-12 then //same or intersection point at rb
   begin
     Point.AddXY(boundPoint[totalBP],rb1_point);
   end
   else //at rb do not intersect
   begin
     Point.AddXY(boundPoint[totalBP],rb1_point);
   end;


   //forget this one (just note)
   {
   //plot end point
     x_str:=floattostr(boundPoint[totalBP]);
     setS(vals1[0],x_str);
     fc[totalBP]:=strtofloat(ArtFormula1.ComputeStr(Y3Equ,num,@vars,@vals1));

   if ((boundPoint[totalBP]-rb)<1e-12) then //same
     Point.AddXY(boundPoint[totalBP],fc[totalBP])
   else
     Point.AddXY(boundPoint[totalBP],0);
    }

   //This part for shading area of double curves(not done yet...)
    {
    //Graph Y2 shaded

    h:=abs(boundPoint[2]-x1)/S; //h stepsize of graph

    for k:=0 to S do
    begin
    x[k]:=x1+k*h;
    x_str:=floattostr(x[k]);
    setS(vals1[0],x_str);
    y[k]:=strtofloat(ArtFormula1.ComputeStr(Y1Equ,num,@vars,@vals1));
    end;

    for k:=0 to S do
    begin
     Area1.ZeroLevel:=boundPoint[2];
     Area1.UseZeroLevel:=true;
     Area1.AddXY(x[k],y[k] );
    end;

    //y2
    for k:=0 to S do
    begin
    x[k]:=x1+k*h;
    x_str:=floattostr(x[k]);
    setS(vals1[0],x_str);
    y[k]:=strtofloat(ArtFormula1.ComputeStr(Y2Equ,num,@vars,@vals1));
    end;

    for k:=0 to S do
    begin
     Area2.ZeroLevel:=boundPoint[2];
     //Area2.UseZeroLevel.
     Area2.UseZeroLevel:=true;
     Area2.AddXY(x[k],y[k] );
    end;
    }

  end;

 stop3:

except
 showmessage('Something wrong with the input !!!');

end;

 stop_time := Now;
 elapsed := stop_time - start_time;
 processTime.Caption:='Process time : '+timetostr(elapsed)+' (hh:mm:ss)';


end;

procedure TForm1.ClearButClick(Sender: TObject);
begin
  lbEdit.Clear;
  rbEdit.Clear;
  deltaEdit.Clear;
  epsilonEdit.Clear;
  MaxEdit.Clear;
  x1Edit.Clear;
  x2Edit.Clear;
  MEdit.Clear;
  SEdit.Clear;
  gammaEdit.Clear;
  Y1Edit.Clear;
  Y2Edit.Clear;
  NoPointEdit.Clear;
  NoAreaEdit.Clear;

  ResultMemo.lines.clear;
  Point.Clear;
  GraphicY1.Clear;
  GraphicY2.Clear;
  Area1.Clear;
  BoundLine.Clear;
  BoundLine2.Clear;

  IterPointCheck.Checked:=false;
  AreaCheck.Checked:=false;

  Point.Legend.Visible:=false;
  GraphicY1.Legend.Visible:=false;
  GraphicY2.Legend.Visible:=false;
  Area1.Legend.Visible:=false;

end;


procedure TForm1.SingleExamButClick(Sender: TObject);
begin
  //example single curve
  lbEdit.Text:='0'; //left boundary
  rbEdit.Text:='3'; //right boundary
  deltaEdit.Text:='1e-12'; //tolerance for the zero
  epsilonEdit.Text:='1e-12'; //tolerance of the function at the zero
  MaxEdit.Text:='1000'; //max AreaHighlight
  x1Edit.Text:='0'; //domain graph [x1,x2]
  x2Edit.Text:='3';
  MEdit.Text:='50'; //number of subinterval of area
  SEdit.Text:='2000'; //smoothness of graph
  gammaEdit.Text:='0.0097'; //const width step size as scanner from lb+gamma to analyze f(x),f(x+gamma),..so on. With different gamma each step.
  Y1Edit.text:='19*sin(2*(x^2))'; //Equation Y1
  Y2Edit.text:='0'; //Equation Y2
  NoPointEdit.Text:='2'; //No point to view AreaHighlight of the point(point of boundary area)
  NoAreaEdit.Text:='1'; //No area to view which the area counted
  IterPointCheck.Checked:=true;
  AreaCheck.Checked:=true;
  rgCurve.ItemIndex:=0;


end;

procedure TForm1.DoubleExamButClick(Sender: TObject);
begin
  //example double curve
  lbEdit.Text:='0'; //left boundary
  rbEdit.Text:='3'; //right boundary
  deltaEdit.Text:='1e-12'; //tolerance for the zero
  epsilonEdit.Text:='1e-12'; //tolerance of the function at the zero
  MaxEdit.Text:='1000'; //max AreaHighlight
  x1Edit.Text:='0'; //domain graph [x1,x2]
  x2Edit.Text:='3';
  MEdit.Text:='50'; //number of subinterval of area
  SEdit.Text:='2000'; //smoothness of graph
  gammaEdit.Text:='0.0097'; //const width step size as scanner from lb+gamma to analyze f(x),f(x+gamma),..so on. With different gamma each step.
  Y1Edit.text:='7*sin(2*(x^2))'; //Equation Y1
  Y2Edit.text:='4*cos(2*x)'; //Equation Y2
  NoPointEdit.Text:='2'; //No point to view AreaHighlight of the point(point of boundary area)
  NoAreaEdit.Text:='1'; //No area to view which the area counted
  IterPointCheck.Checked:=true;
  AreaCheck.Checked:=true;
  rgCurve.ItemIndex:=1;


end;

procedure TForm1.AboutButClick(Sender: TObject);
const
 sAbout = '|======== Multi-Area ========|' + #13#10 +
          '' + #13#10 +
          'Version 1.0 - build Mar 7, 2025'+ #13#10 +
          'Created by Lukas Setiawan.' + #13#10 +
          'Copyright (c) 2025. All Rights Reserved.' + #13#10 +
          '' + #13#10 +
          'Visit web: https://nix97.github.io/numericalmethods/' + #13#10 +
          'Facebook search: Metode Numerik-Plus Programnya' + #13#10 +
          'E-mail : lukassetiawan@yahoo.com' + #13#10 +
          '' + #13#10 +
          'My Work :'+ #13#10 +
          '<> https://bitbucket.org/nixz97/nix/downloads/' + #13#10 +
          '<> Other Repositories on GitHub: https://github.com/nix97' + #13#10 +
          '' + #13#10 +
          'Accepting donations for software development.'+ #13#10;
 begin
  MessageDlg( sAbout, mtInformation, [mbOK], 0);
end;

end.

