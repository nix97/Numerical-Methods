unit multiCriticalPoints;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  formula, TAGraph, TASeries,math;

type

  { TForm1 }

  TForm1 = class(TForm)
    AboutBut: TButton;
    IterCheck: TCheckBox;
    Label8: TLabel;
    MinSeries3: TLineSeries;
    lbEdit: TEdit;
    ArtFormula: TArtFormula;
    pointEdit: TEdit;
    ViewResultRg: TRadioGroup;
    rbEdit: TEdit;
    Chart1: TChart;
    ClearBut: TButton;
    deltaEdit: TEdit;
    gammaEdit: TEdit;
    ExampleBut: TButton;
    epsilonEdit: TEdit;
    GraphYSeries1: TLineSeries;
    GraphYSeries2: TLineSeries;
    HelpMemo: TMemo;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    MEdit: TEdit;
    ResultLabel: TLabel;
    ResultMemo: TMemo;
    MaxSeries2: TLineSeries;
    RootSeries3: TLineSeries;
    RunBut: TButton;
    x1Edit: TEdit;
    x2Edit: TEdit;
    YEdit: TEdit;
    processTime: TLabel;
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
  stop,stop2;
var
  found : boolean;
  a,b,c,lb,rb,delta,epsilon,ya,yb,yc,yd,h,x1,x2,gamma : extended;
  rone,rtwo,d,p,yp,highestYmax,lowestYmin : extended;
  k,i,j,num,M,l,pointNo,t,t2,numIdxYmax,numIdxYmin,z,z2 : integer;
  vars : array of string;
  vals1 : TCalcArray;
  a_str,b_str,c_str,x_str,YEquation,x3_str,line,critical_type,d_str: string;
  iterMax,iterMin,IdxMaxNo,IdxMaxNo2,IdxMinNo,IdxMinNo2 : string;
  x,y,x3,y3,xMin,xMax,yMin,yMax : array[0..10000] of extended;
  ErrXmax,ErrYmax,ErrXmin,ErrYmin : array[0..10000] of extended;
  highestYmaxIdx,lowestYminIdx : array[1..1000] of integer;
  start_time, stop_time, elapsed : TDateTime;

begin
 try

  start_time := now; //start to counting Process time

  lb:=strtofloat(lbEdit.Text); //left boundary
  rb:=strtofloat(rbEdit.Text); //right boundary
  delta:=strtofloat(deltaEdit.Text); //condition to (yb - ya)
  epsilon:=strtofloat(epsilonEdit.Text); //condition to (b - a)
  gamma:=strtofloat(gammaEdit.Text); //to count F(x)
  M:=strtoint(MEdit.Text); //smoothness graph
  x1:=strtofloat(x1Edit.Text); //domain graph [x1,x2]
  x2:=strtofloat(x2Edit.Text);
  YEquation:=YEdit.text; //input equation
  pointNo:=strtoint(pointEdit.Text); //view iteration


  //handling boundary etc
  if (x1=0) then x1:=-0.1;//due to graph problem, can not zero
  if (lb>=rb) then
  begin
   showmessage('Value of lb must be lower than rb !!!');
   goto stop2;
  end;

  if (delta<1e-12) or (epsilon<1e-12) then
  begin
   showmessage('Minimum value of delta or epsilon is 1e-12 !!!');
   goto stop2;
  end;

  if (lb<x1) or (rb>x2) then
  begin
   showmessage('Value of [lb,rb] must be on the domain graph [x1,x2]  !!!');
   goto stop2;
  end;

  if (M>10000) then
  begin
   showmessage('Max of M is 10000 !!!');
   goto stop2;
  end;

  if (gamma<1e-12) then
  begin
   showmessage('Minimum value of gamma is 1e-12 !!!');
   goto stop2;
  end;
  //end of handling


  num:=1; //numbers of variable (x)
  setlength(vars,num);
  setlength(vals1,num);
  vars[0]:='x'; //x

  MaxSeries2.Clear; //clear graph series
  MinSeries3.Clear;
  ResultMemo.lines.clear; //clear ResultMemo

  x3[0]:=lb; //as starting point

  i:=0; //index find [a,b]
  j:=0; //index store max
  l:=0; //index store min
  t:=0; //index iteration max
  t2:=0; //index iteration max
  iterMax:=''; //iteration Max, result as string
  iterMin:=''; //iteration Min, result as string

  repeat
   found:=false;

   repeat

    //check every (x+gamma), e.g. gamma = 0.1 ;

    x3_str:=floattostr(x3[i]); //x1
    setS(vals1[0],x3_str);
    y3[i]:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1)); //y1

    x3[i+1]:=x3[i]+gamma;  //x2
    x3_str:=floattostr(x3[i+1]);
    setS(vals1[0],x3_str);
    y3[i+1]:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1)); //y2

    x3[i+2]:=x3[i+1]+gamma;  //x3
    x3_str:=floattostr(x3[i+2]);
    setS(vals1[0],x3_str);
    y3[i+2]:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1)); //y3

    x3[i+3]:=x3[i+2]+gamma;   //x4
    x3_str:=floattostr(x3[i+3]);
    setS(vals1[0],x3_str);
    y3[i+3]:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1)); //y4

    if ((y3[i+1]-y3[i])>0) and ((y3[i+3]-y3[i+2])<0)  then //slope positif(y2-y1) to negative(y4-y3) means got peak/max
    begin
     found:=true;
     critical_type:='maximum';
     inc(j); //index of max point
    end;

    if ((y3[i+1]-y3[i])<0) and ((y3[i+3]-y3[i+2])>0)  then //slope negative(y2-y1) to positif(y4-y3) means got valley/min
    begin
     found:=true;
     critical_type:='minimum';
     inc(l); //index of min point
    end;
    inc(i);
    if (x3[i]>rb) then goto stop;
   until(found=true);


   //Golden search start here
   rOne:=(sqrt(5)-1)/2; //look algo
   rTwo:=rOne * rOne;
   a:=x3[i];  //a,b as starting point to start iteration on golden search algo
   b:=x3[i+2];

   a_str:=floattostr(a);
   setS(vals1[0],a_str);
   ya:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));

   b_str:=floattostr(b);
   setS(vals1[0],b_str);
   yb:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));

   h:=b-a; //width on x
   c:=a+rTwo*h;
   c_str:=floattostr(c);
   setS(vals1[0],c_str);
   yc:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));

   d:=a+rOne*h;
   d_str:=floattostr(d);
   setS(vals1[0],d_str);
   yd:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));

   //Iteration

   //maximum
   if (critical_type='maximum') then
   begin
    while (abs(yb - ya) > epsilon) or (h > delta) do
    begin
     if (yc>yd) then
     begin
      b:=d;
      yb:=yd;
      d:=c;
      yd:=yc;
      h:=b-a;
      c:=a+rTwo*h;

      c_str:=floattostr(c);
      setS(vals1[0],c_str);
      yc:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));
     end
     else
     begin
      a:=c;
      ya:=yc;
      c:=d;
      yc:=yd;
      h:=b-a;
      d:=a+rOne*h;

      d_str:=floattostr(d);
      setS(vals1[0],d_str);
      yd:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));
     end;

     //max iteration
     if (IterCheck.Checked=true) then
     begin
      if (j=pointNo) then
      begin
       iterMax:=iterMax+format('%d %20.8e %20.8e %20.8e %20.8e %20.8e %20.8e',[t,a,c,d,b,yc,yd])+#13#10;
       inc(t);
      end;
     end;

    end;

    ErrXmax[j]:=abs(b-a); //Error bound Xmax
    ErrYmax[j]:=abs(yb-ya); //Error bound Ymax
    p:=a;
    yp:=ya;
    if (yb > ya) then
    begin
     p:=b;
     yp:=yb;
    end;
    xMax[j]:=p;
    yMax[j]:=yp;

   end;


   //Minimum
   if (critical_type='minimum') then
   begin
    while (abs(yb - ya) > epsilon) or (h > delta) do
    begin
     if (yc<yd) then
     begin
      b:=d;
      yb:=yd;
      d:=c;
      yd:=yc;
      h:=b-a;
      c:=a+rTwo*h;

      c_str:=floattostr(c);
      setS(vals1[0],c_str);
      yc:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));
     end
     else
     begin
      a:=c;
      ya:=yc;
      c:=d;
      yc:=yd;
      h:=b-a;
      d:=a+rOne*h;

      d_str:=floattostr(d);
      setS(vals1[0],d_str);
      yd:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));
     end;

     //min iteration
     if (IterCheck.Checked=true) then
     begin
      if (l=pointNo) then
      begin
       iterMin:=iterMin+format('%d %20.8e %20.8e %20.8e %20.8e %20.8e %20.8e',[t2,a,c,d,b,yc,yd])+#13#10;
       inc(t2);
      end;
     end;

    end;

    ErrXmin[l]:=abs(b-a); //Error bound Xmin
    ErrYmin[l]:=abs(yb-ya); //Error bound Ymin
    p:=a;
    yp:=ya;
    if (yb > ya) then
    begin
     p:=b;
     yp:=yb;
    end;
    xMin[l]:=p;
    yMin[l]:=yp;

   end;

    inc(i); //increase index i to next points
    //i:=i+2;
  until((x3[i]>rb));

  if (xMax[j]>rb) then dec(j); //to avoid over xMax
  if (xMin[l]>rb) then dec(l); //to avoid over xMin


  stop:
  if ((j=0)and (l=0)) then
  begin
   showmessage('Try another interval [lb,rb] or have no critical point !!!');
   goto stop2;
  end;

  //Find Highest Ymax(it could be multi)
  highestYmax:=Ymax[1];
  for k:=2 to j do
  begin
   if (Ymax[k]> highestYmax) then
   begin
    highestYmax:=Ymax[k];
   end;
  end;

  //Find index point no Highest Ymax

  numIdxYmax:=0;
  z:=1;
  for k:=1 to j do
  begin
   if (abs(highestYmax-Ymax[k])<epsilon) then //due to last digit different but same Ymax value actually
   begin
    highestYmaxIdx[z]:=k;
    inc(numIdxYmax); //number of index Ymax
    inc(z); //index of highestYmaxIdx
   end;
  end;

  //Find Lowest Ymin(it could be multi)
  lowestYmin:=Ymin[1];
  for k:=2 to l do
  begin
   if (Ymin[k]<lowestYmin) then
   begin
    lowestYmin:=Ymin[k];
   end;
  end;

  //Find index point no lowest Ymin

  numIdxYmin:=0;
  z2:=1;
  for k:=1 to l do
  begin
   if (abs(lowestYmin-Ymin[k])<epsilon) then //due to last digit different but same Ymin value actually
   begin
    lowestYminIdx[z2]:=k;
    inc(numIdxYmin); //number of index Ymin
    inc(z2); //index of highestYminIdx
   end;
  end;


 //Graph Y=F(x)
  GraphYSeries1.Clear;
  MaxSeries2.Clear;
  MinSeries3.Clear;

  GraphYSeries1.Legend.Visible:=true;
  h:=abs(x2-x1)/M; //h stepsize of graph

  for k:=0 to M do
  begin
   x[k]:=x1+k*h;
   x_str:=floattostr(x[k]);
   setS(vals1[0],x_str);
   y[k]:=strtofloat(ArtFormula.ComputeStr(YEquation,num,@vars,@vals1));
  end;

  for k:=0 to M do
  begin
   GraphYSeries1.AddXY(x[k],y[k] ); //(x,y)
  end;

  MaxSeries2.Legend.Visible:=false;
  MinSeries3.Legend.Visible:=false;


  //Result values & graph

  line:='===================================================================================';

  case ViewResultRg.ItemIndex of
  0://max points
  begin
   //Display result
    if (j=0) then
    begin
     showmessage('Have no Max point !!!');
     goto stop2;
    end;

    if (pointNo>j) then
    begin
     showmessage('Bigest no point of max is '+inttostr(j)+' !!!');
     goto stop2;
    end;


    ResultLabel.Caption:='Result :';
    ResultMemo.Lines.Add('MAXIMUM POINTS :');
    ResultMemo.Lines.Add('Total Maximum points is '+inttostr(j)+#13#10);
    ResultMemo.Lines.Add('');
    ResultMemo.Lines.Add(format('%1s %24s %32s %37s %30s',['No','X Maximum','Y Maximum','Error bound X Max','Error bound Y Max'])); //'Error ∆X max
    ResultMemo.Lines.Add(line);

    for k:=1 to j do
    begin
     ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %27.18e',[xMax[k]])+format('%27.18e',[yMax[k]])+format('%27.18e',[ErrXmax[k]])+format('%27.18e',[ErrYmax[k]]));
    end;

    IdxMaxNo:='';
    for k:=1 to numIdxYmax do
    begin
     IdxMaxNo:=IdxMaxNo+inttostr(highestYmaxIdx[k])+' , ';
    end;

    IdxMaxNo2:=copy(IdxMaxNo,1,length(IdxMaxNo)-2);

    ResultMemo.Lines.Add(#13#10+'Highest Y Maximum is '+floattostr(highestYmax)+
    ' at the point maximum no '+IdxMaxNo2);

    ResultMemo.Lines.Add(#13#10);

    //graph max
    if (j>=1) then MaxSeries2.Legend.Visible:=true;

    for k:=1 to j  do
    begin
     MaxSeries2.AddXY(xMax[k],yMax[k]); //(xMax,yMax)
    end;
   end;

   1:
   begin
    //Display result min
    if (l=0) then
    begin
     showmessage('Have no Min point !!!');
     goto stop2;
    end;

    if (pointNo>l) then
    begin
     showmessage('Bigest no point of min is '+inttostr(l)+' !!!');
     goto stop2;
    end;

    ResultLabel.Caption:='Result :';
    ResultMemo.Lines.Add('MINIMUM POINTS :');
    ResultMemo.Lines.Add('Total Minimum points is '+inttostr(L)+#13#10);
    ResultMemo.Lines.Add(format('%1s %24s %32s %37s %30s',['No','X Minimum','Y Minimum','Error bound X Min','Error bound Y Min'])); //'Error ∆X max
    ResultMemo.Lines.Add(line);

    for k:=1 to l do
    begin
     ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %27.18e',[xMin[k]])+format('%27.18e',[yMin[k]])+format('%27.18e',[ErrXmin[k]])+format('%27.18e',[ErrYmin[k]]));
    end;


    IdxMinNo:='';
    for k:=1 to numIdxYmin do
    begin
     IdxMinNo:=IdxMinNo+inttostr(lowestYminIdx[k])+' , ';
    end;

    IdxMinNo2:='';
    for k:=1 to length(IdxMinNo)-2 do
     IdxMinNo2:=IdxMinNo2+IdxMinNo[k];

    IdxMinNo2:=copy(IdxMinNo,1,length(IdxMinNo)-2);

    ResultMemo.Lines.Add(#13#10+'Lowest Y Minimum is '+floattostr(lowestYmin)+
    ' at the point minimum no '+IdxMinNo2);

    //graph min
    if (l>=1) then MinSeries3.Legend.Visible:=true;

    for k:=1 to l  do
    begin
     MinSeries3.AddXY(xMin[k],yMin[k]); //(xMin,yMin)
    end;

    ResultMemo.Lines.Add(#13#10);
   end;

   2: //All
   begin
    IterCheck.Checked:=false;
    //Max
    if (j>=1) then
    begin
     MaxSeries2.Legend.Visible:=true;
     ResultLabel.Caption:='Result :';
     ResultMemo.Lines.Add('MAXIMUM POINTS :');
     ResultMemo.Lines.Add('Total Maximum points is '+inttostr(j)+#13#10);
     ResultMemo.Lines.Add(format('%1s %24s %32s %37s %30s',['No','X Maximum','Y Maximum','Error bound X Max','Error bound Y Max'])); //'Error ∆X max
     ResultMemo.Lines.Add(line);
    end;

    for k:=1 to j do
    begin
     ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %27.18e',[xMax[k]])+format('%27.18e',[yMax[k]])+format('%27.18e',[ErrXmax[k]])+format('%27.18e',[ErrYmax[k]]));
    end;

    IdxMaxNo:='';
    for k:=1 to numIdxYmax do
    begin
     IdxMaxNo:=IdxMaxNo+inttostr(highestYmaxIdx[k])+' , ';
    end;

    IdxMaxNo2:=copy(IdxMaxNo,1,length(IdxMaxNo)-2);

    ResultMemo.Lines.Add(#13#10+'Highest Y Maximum is '+floattostr(highestYmax)+
    ' at the maximum point  no '+IdxMaxNo2);


    //graph max
    for k:=1 to j  do
    begin
     MaxSeries2.AddXY(xMax[k],yMax[k]); //(xMax,yMax)
    end;


     //Display result Min
    if (l>=1) then
    begin
     MinSeries3.Legend.Visible:=true;
     ResultLabel.Caption:='Result :';
     if (j>=1) then ResultMemo.Lines.Add(#13#10); //space display
     ResultMemo.Lines.Add('MINIMUM POINTS :');
     ResultMemo.Lines.Add('Total Minimum points is '+inttostr(L));
     ResultMemo.Lines.Add('');
     ResultMemo.Lines.Add(format('%1s %24s %32s %37s %30s',['No','X Minimum','Y Minimum','Error bound X Min','Error bound Y Min'])); //'Error ∆X max
     ResultMemo.Lines.Add(line);
    end;

    for k:=1 to l do
    begin
     ResultMemo.Lines.Add(inttostr(k)+'.'+format(' %27.18e',[xMin[k]])+format('%27.18e',[yMin[k]])+format('%27.18e',[ErrXmin[k]])+format('%27.18e',[ErrYmin[k]]));
    end;

    IdxMinNo:='';
    for k:=1 to numIdxYmin do
    begin
     IdxMinNo:=IdxMinNo+inttostr(lowestYminIdx[k])+' , ';
    end;

    IdxMinNo2:='';
    for k:=1 to length(IdxMinNo)-2 do
     IdxMinNo2:=IdxMinNo2+IdxMinNo[k];

    IdxMinNo2:=copy(IdxMinNo,1,length(IdxMinNo)-2);

    ResultMemo.Lines.Add(#13#10+'Lowest Y Minimum is '+floattostr(lowestYmin)+
    ' at the minimum point no '+IdxMinNo2);

    //graph min
    for k:=1 to l  do
    begin
     MinSeries3.AddXY(xMin[k],yMin[k]); //(xMin,yMin)
    end;

   end;
  end;

  //Iteration
  if (IterCheck.Checked=true) then
  begin
   if (ViewResultRg.ItemIndex=0) then //max iter
   begin
    ViewResultRg.ItemIndex:=0;
    Resultlabel.Caption:='Result - Iteration :';
    ResultMemo.Lines.Add('Iteration of the Maximum point-'+inttostr(pointNo)+' :'+#13#10);
    ResultMemo.Lines.Add(format('%1s %25s %26s %23s %20s %22s %31s',['i','left point(ai)','left mid point(ci)','right mid point(di)','right point(bi)','F(ci)','F(di)']));
    ResultMemo.Lines.Add(line);
    ResultMemo.Lines.Add(iterMax);
   end
   else
   if (ViewResultRg.ItemIndex=1) then //min iter
   begin
    Resultlabel.Caption:='Result - Iteration :';
    ResultMemo.Lines.Add('Iteration of the Minimum point-'+inttostr(pointNo)+' :'+#13#10);
    ResultMemo.Lines.Add(format('%1s %25s %26s %23s %20s %22s %31s',['i','left point(ai)','left mid point(ci)','right mid point(di)','right point(bi)','F(ci)','F(di)']));
    ResultMemo.Lines.Add(line);
    ResultMemo.Lines.Add(iterMin);
   end;

  end;

 stop2:

 except
   showmessage('Something wrong with the input !!!');
 end;

 stop_time := Now;
 elapsed := stop_time - start_time;
 processTime.Caption:='Process time : '+timetostr(elapsed)+' (hh:mm:ss)';

end;

procedure TForm1.ClearButClick(Sender: TObject);
begin
  YEdit.Clear;
  lbEdit.Clear;
  rbEdit.Clear;
  deltaEdit.Clear;
  epsilonEdit.Clear;
  gammaEdit.Clear;
  MEdit.Clear;
  x1Edit.Clear;
  x2Edit.Clear;
  ResultMemo.Clear;
  GraphYSeries1.Clear;
  MaxSeries2.Clear;
  MinSeries3.Clear;
  pointEdit.Clear;
  IterCheck.Checked:=false;
  GraphYSeries1.Legend.Visible:=false;;
  MaxSeries2.Legend.Visible:=false;
  MinSeries3.Legend.Visible:=false;
  processTime.Caption:='Process Time :';
end;

procedure TForm1.ExampleButClick(Sender: TObject);
begin
  YEdit.Text:='x*sin(x)-1';
  lbEdit.Text:='-10';
  rbEdit.Text:='10';
  deltaEdit.Text:='1e-12';
  epsilonEdit.Text:='1e-12';
  gammaEdit.Text:='0.1';
  MEdit.Text:='1000';
  x1Edit.Text:='-10';
  x2Edit.Text:='10';
  pointEdit.Text:='1';
  IterCheck.Checked:=true;
end;

procedure TForm1.AboutButClick(Sender: TObject);
const
 sAbout = '|======== Multi-Critical Point Finder ========|' + #13#10 +
          '' + #13#10 +
          'Version 1.0 - build Jan 15, 2025'+ #13#10 +
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
 MessageDlg( sAbout, mtInformation, [mbOK], 0);end;

end.

