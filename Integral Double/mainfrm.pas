unit mainfrm;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, ComCtrls, Menus,
  SDL_sdlbase, SDL_plot3d,
  SDL_NumLab, SDL_rchart, SDL_ntabed, SDL_NumIO, SDL_Colsel;

type
  TFrmDataVis = class(TForm)
    Panel1: TPanel;
    BButExit: TBitBtn;
    ColorDialog1: TColorDialog;
    popMenPlot3D: TPopupMenu;
    Rotate1: TMenuItem;
    Pan1: TMenuItem;
    Zoom1: TMenuItem;
    RotateandZoom1: TMenuItem;
    RotXOnly1: TMenuItem;
    RotZOnly1: TMenuItem;
    BButExecute: TBitBtn;
    Panel5: TPanel;
    Label1: TLabel;
    LblSmooth: TLabel;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SBLoadUsercolor: TSpeedButton;
    SBSaveUserColor: TSpeedButton;
    SBGrayScale: TSpeedButton;
    SBStandardColors: TSpeedButton;
    CSHigh: TColSel;
    CSMid: TColSel;
    CSLow: TColSel;
    NIOSmooth: TNumIO;
    NIONumNb: TNumIO;
    RGWeighting: TRadioGroup;
    NIOResol: TNumIO;
    RGColorScale: TRadioGroup;
    Panel6: TPanel;
    PageControl1: TPageControl;
    TSData: TTabSheet;
    TEData: TNTabEd;
    BButLoadData: TBitBtn;
    TSColorMap: TTabSheet;
    Panel2: TPanel;
    NLXCoord: TNumLab;
    NLYCoord: TNumLab;
    NLZCoord: TNumLab;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CBoxShowData: TCheckBox;
    TS3DPlot: TTabSheet;
    Plot3D1: TPlot3D;
    Panel4: TPanel;
    NLabZ: TNumLab;
    NLabX: TNumLab;
    Label2: TLabel;
    NLabMag: TNumLab;
    SBReset: TSpeedButton;
    ScrBarAngleZ: TScrollBar;
    ScrBarAngleX: TScrollBar;
    CSelGrid: TColSel;
    ScrBarMagnif: TScrollBar;
    CBoxMesh: TCheckBox;
    ScrBarSclZ: TScrollBar;
    Panel7: TPanel;
    RCColCode: TRChart;
    RCCPlot: TRChart;
    NLabZScale: TNumLab;
    Label7: TLabel;
    Label8: TLabel;
    CBoxAutoCalc: TCheckBox;
    ODiag: TOpenDialog;
    CBoxEditDataAllowed: TCheckBox;
    PopMenEmptyDummy: TPopupMenu;
    Button1: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SBGrayScaleClick(Sender: TObject);
    procedure SBStandardColorsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BButExecuteClick(Sender: TObject);
    procedure RCCPlotMouseMoveInChart(Sender: TObject; InChart: Boolean;
      Shift: TShiftState; rMousePosX, rMousePosY: Double);
    procedure RGWeightingClick(Sender: TObject);
    procedure CBoxShowDataClick(Sender: TObject);
    procedure SBSaveUserColorClick(Sender: TObject);
    procedure SBLoadUsercolorClick(Sender: TObject);
    procedure BButLoadDataClick(Sender: TObject);
    procedure BButExitClick(Sender: TObject);
    procedure ScrBarAngleXChange(Sender: TObject);
    procedure ScrBarAngleZChange(Sender: TObject);
    procedure ScrBarMagnifChange(Sender: TObject);
    procedure ScrBarSclZChange(Sender: TObject);
    procedure CSelHighChange(Sender: TObject);
    procedure CselMidChange(Sender: TObject);
    procedure CSelLowChange(Sender: TObject);
    procedure SBResetClick(Sender: TObject);
    procedure CSelGridChange(Sender: TObject);
    procedure CBoxMeshClick(Sender: TObject);
    procedure Rotate1Click(Sender: TObject);
    procedure Pan1Click(Sender: TObject);
    procedure Zoom1Click(Sender: TObject);
    procedure RotateandZoom1Click(Sender: TObject);
    procedure RotXOnly1Click(Sender: TObject);
    procedure RotZOnly1Click(Sender: TObject);
    procedure Plot3D1MouseAction(Sender: TObject; var CenterX,
      CenterY: Integer; var RotXAngle, RotZAngle, Magnification: Double;
      Shift: TShiftState);
    procedure Plot3D1BeforeRenderPolygon(Sender: TObject;
      var Canvas: TCanvas; var Handled: Boolean; CellX, CellY: Integer;
      quad: TQuad; var color: TColor);
    procedure Plot3D1BeforeDrawScaleLabel(Sender: TObject;
      var Canvas: TCanvas; ScaleType: TP3ScaleKind;
      var CurrentTickLabel: String; ChartX, ChartY: Integer);
    procedure FormResize(Sender: TObject);
    procedure NewCalcNeededAfterClick(Sender: TObject);
    procedure TEDataChange(Sender: TObject);
    procedure CBoxEditDataAllowedClick(Sender: TObject);
    procedure Plot3D1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    Varix    : array[1..3] of integer; { index of selected variables }
    function  CalcColorCoding (value: double): TColor;
    procedure DisplayColorCoding;
    procedure DisplayPlots;
    procedure NewCalcNeeded;
  public
    { Public declarations }
  end;

var
  FrmDataVis: TFrmDataVis;

implementation

uses
  SDL_math2, SDL_filesys, SDL_vector, SDL_matrix, Integral;

{$R *.DFM}

const
  Data : array[1..40, 1..3] of double =
        (( 5.02, 22.19, 0.36011),
         (16.00, 20.00, 0.5523),
         (25.43, 12.94, 0.65945),
         (32.42, 12.97, 0.95646),
         (56.59, 12.91, 1.51694),
         (63.58, 13.94, 1.32943),
         (72.75, 18.93, 1.20532),
         (83.46, 21.18, 1.61397),
         ( 5.22, 28.61, 0.57115),
         (15.89, 30.03, 0.76144),
         (25.93, 30.04, 0.1742),
         (33.68, 30.08, 0.97782),
         (55.43, 28.97, 1.72526),
         (63.68, 29.93, 1.01459),
         (72.06, 28.94, 1.21338),
         (15.99, 40.06, 0.95538),
         (25.73, 40.07, 0.26551),
         (33.68, 41.02, 0.09775),
         (55.53, 39.94, 1.01887),
         (63.58, 40.03, 1.61609),
         ( 7.95, 39.91, 1.50952),
         (16.00, 51.06, 0.65028),
         (25.83, 51.04, 0.77049),
         (33.98, 51.07, 1.10382),
         (75.43, 88.04, 1.32671),
         (63.87, 49.96, 1.90483),
         (72.85, 49.90, 1.81108),
         (15.69, 62.06, 0.06788),
         (25.24, 62.08, 0.38613),
         (33.49, 62.07, 1.90664),
         (55.03, 61.07, 1.23714),
         (63.28, 62.01, 1.6174),
         (72.55, 60.08, 1.12031),
         (16.30, 65.86, 0.37053),
         (19.84, 75.44, 0.29625),
         (24.54, 65.82, 0.8998),
         (33.39, 65.89, 1.42666),
         (35.79, 82.23, 1.30111),
         (35.87, 89.86, 1.41355),
         (44.38, 96.67, 1.90149));

var
  mins, maxs : array[1..3] of double;



(******************************************************************************)
function TFrmDataVis.CalcColorCoding (value: double): TColor;
(******************************************************************************)

var
  BlueLow  : integer;
  BlueHigh : integer;
  RedLow   : integer;
  RedHigh  : integer;
  GreenLow : integer;
  GreenHigh: integer;


begin
if value < RCColCode.Scale1X.RangeLow then
  value := RCColCode.Scale1X.RangeLow;
if value > RCColCode.Scale1X.RangeHigh then
  value := RCColCode.Scale1X.RangeHigh;
value := (value-RCColCode.Scale1X.RangeLow)/(RCColCode.Scale1X.RangeHigh-RCColCode.Scale1X.RangeLow);
if value < 0.5
  then begin
       blueLow := (CSLOW.SelCOlor shr 16) and $FF;
       blueHigh := (CSMid.SelCOlor shr 16) and $FF;
       GreenLow := (CSLOW.SelCOlor shr 8) and $FF;
       GreenHigh := (CSMid.SelCOlor shr 8) and $FF;
       RedLow := CSLOW.SelColor and $000000FF;
       RedHigh := CSMid.SelColor and $000000FF;
       end
  else begin
       value := value-0.5;
       blueLow := (CSMid.SelCOlor shr 16) and $FF;
       blueHigh := (CSHigh.SelCOlor shr 16) and $FF;
       GreenLow := (CSMid.SelCOlor shr 8) and $FF;
       GreenHigh := (CSHigh.SelCOlor shr 8) and $FF;
       RedLow := CSMid.SelCOlor and $FF;
       RedHigh := CSHigh.SelCOlor and $FF;
       end;
CalcColorCoding := rgb (round(RedLow+2*value*(RedHigh-RedLow)),
                        round(GreenLow+2*value*(GreenHigh-GreenLow)),
                        round(BlueLow+2*value*(BlueHigh-BlueLow)));
end;


(******************************************************************************)
procedure TFrmDataVis.DisplayColorCoding;
(******************************************************************************)

const
  resolution = 500;

var
  step     : double;
  col      : TColor;
  BlueLow  : integer;
  BlueHigh : integer;
  RedLow   : integer;
  RedHigh  : integer;
  GreenLow : integer;
  GreenHigh: integer;
  i        : integer;  

begin
RCColCode.ClearGraf;
RcColCode.Scale1X.LabelType := ftNum;
RcColCode.Caption := 'Color Coding';
RcColCode.Scale1X.Caption := TEData.ColName[varix[3]];
RCColCode.LineWidth := 3;
Step := (RCColCode.Scale1X.RangeHigh - RcColCode.Scale1X.RangeLow)/resolution;
blueLow := (CSLOW.SelCOlor shr 16) and $FF;
blueHigh := (CSMid.SelCOlor shr 16) and $FF;
GreenLow := (CSLOW.SelCOlor shr 8) and $FF;
GreenHigh := (CSMid.SelCOlor shr 8) and $FF;
RedLow := CSLOW.SelColor and $000000FF;
RedHigh := CSMid.SelColor and $000000FF;
for i:=1 to (Resolution div 2) do
  begin
  col := round(redLow+2.0*(i-1)*(redHigh-redLow)/Resolution) +
         256*round(GreenLow+2*(i-1)*(greenHigh-greenLow)/Resolution) +
         65536*round(BlueLow+2*(i-1)*(blueHigh-blueLow)/Resolution);
  RCColCode.DataColor := col;
  RCColCode.Line (RCColCode.Scale1X.RangeLow+(i-1)*Step,0,RCColCode.Scale1X.RangeLow+(i-1)*Step,1);
  end;
blueLow := (CSMid.SelCOlor shr 16) and $FF;
blueHigh := (CSHigh.SelCOlor shr 16) and $FF;
GreenLow := (CSMid.SelCOlor shr 8) and $FF;
GreenHigh := (CSHigh.SelCOlor shr 8) and $FF;
RedLow := CSMid.SelCOlor and $FF;
RedHigh := CSHigh.SelCOlor and $FF;
for i:=1 to Resolution div 2 do
  begin
  col := round(redLow+2.0*(i-1)*(redHigh-redLow)/Resolution) +
         256*round(GreenLow+2*(i-1)*(greenHigh-greenLow)/Resolution) +
         65536*round(BlueLow+2*(i-1)*(blueHigh-blueLow)/Resolution);
  RCColCode.DataColor := col;
  RCColCode.Line (RCColCode.Scale1X.RangeLow+(i-1+Resolution div 2)*Step,0,
                  RCColCode.Scale1X.RangeLow+(i-1+Resolution div 2)*Step,1);
  end;
RCColCode.ShowGraf;
end;



(******************************************************************************)
procedure TFrmDataVis.DisplayPlots;
(******************************************************************************)

const
  RimPercent = 0.02;

var
  dx         : double;
  i, j       : integer;
  z          : double;
  diffx      : double;
  diffy      : double;
  success    : boolean;
  TargetVec  : TVector;
  InVec      : TVector;
  AuxMat     : TMatrix;
  MaxAct     : double;
  q1, q2, q3 : double;
  dbar       : double;
  Means      : TVector;
  StdDevs    : TVector;
  Res        : integer;


begin
Res := round(NIOResol.Value);
Screen.Cursor := crHourGlass;
Application.ProcessMessages;
InVec := TVector.Create (nil);
InVec.Resize(2);
RCCplot.ClearGraf;
TEData.Data.NumericData.MinMax (varix[1],1,varix[1],TEData.NrOfRows,
                                      mins[1], maxs[1]);
TEData.Data.NumericData.MinMax (varix[2],1,varix[2],TEData.NrOfRows,
                                      mins[2], maxs[2]);
TEData.Data.NumericData.MinMax (varix[3],1,varix[3],TEData.NrOfRows,
                                      mins[3], maxs[3]);
TEData.Data.NumericData.Quartiles (varix[3],1,varix[3],TEData.NrOfRows,
                                        Q1, Q2, Q3);
for i:=1 to 3 do
  if Mins[i] = Maxs[i] then
    begin
    Mins[i] := Mins[i] - 0.1;
    Maxs[i] := Maxs[i] + 0.1;
    end;

RCCplot.Scale1X.RangeLow := mins[1]-(Maxs[1]-Mins[1])*RimPercent;
RCCplot.Scale1X.RangeHigh := Maxs[1]+(Maxs[1]-Mins[1])*RimPercent;

RCCplot.Scale1Y.RangeLow := mins[2]-(Maxs[2]-Mins[2])*RimPercent;
RCCplot.Scale1Y.RangeHigh := Maxs[2]+(Maxs[2]-Mins[2])*RimPercent;

case RGColorScale.ItemIndex of
  0 : begin
      RCColCode.Scale1X.RangeLow := mins[3];
      RCColCode.Scale1X.RangeHigh := Maxs[3];
      end;
  1 : begin
      RCColCode.Scale1X.RangeLow := Q2-abs(Q3-Q1);
      RCColCode.Scale1X.RangeHigh := Q2+abs(Q3-Q1);
      end;
end;
diffx := (RCCplot.Scale1X.RangeHigh-RCCplot.Scale1X.RangeLow)/res;
diffy := (RCCplot.Scale1Y.RangeHigh-RCCplot.Scale1Y.RangeLow)/res;

AuxMat := TMatrix.Create (nil);
AuxMat.Resize (2, TEData.Data.NrOfRows);
AuxMat.CopyFrom (TEData.Data.NumericData, VarIx[1], 1, VarIx[1], TEData.Data.NrOfRows, 1, 1);
AuxMat.CopyFrom (TEData.Data.NumericData, VarIx[2], 1, VarIx[2], TEData.Data.NrOfRows, 2, 1);

Means := TVector.Create (nil);
Means.Resize(2);
StdDevs := TVector.Create (nil);
StdDevs.Resize(2);
AuxMat.StandardizeColumns (Means, StdDevs);
if StdDevs[1] = 0 then
  StdDevs[1] := 1.0;
if StdDevs[2] = 0 then
  StdDevs[2] := 1.0;
TargetVec := TVector.Create (nil);
TargetVec.Resize(TEData.Data.NrOfRows);
TEData.Data.NumericData.CopyColToVec (TargetVec, varix[3], 1, TEData.Data.NrOfRows);

RcColCode.DataColor := clBlue;
RcColCode.FillColor := clBlue;
RcColCode.ClearGraf;
RcColCode.Scale1X.LabelType := ftNoFigs;
RcColCode.Caption := '... interpolating 3D values';
dx := (RcColCode.Scale1X.RangeHigh-RcColCode.Scale1X.RangeLow)/res;
RcCPlot.Classdefault := 0;

Plot3D1.SuppressPaint := true;
Plot3D1.ColorLow := CalcColorCoding (Mins[3]);
Plot3D1.ColorMid := CalcColorCoding ((RCColCode.Scale1X.RangeLow+RCColCode.Scale1X.RangeHigh)/2);
Plot3D1.ColorHigh := CalcColorCoding (Maxs[3]);

Plot3D1.Gridmat.Resize (res, res); // setup size of Plot3D grid
for i:=1 to res do
  begin
  RcColCode.Rectangle (RcColCode.Scale1X.RangeLow+(i-1)*dx,0,RcColCode.Scale1X.RangeLow+i*dx,1);
  RCColCode.ShowGraf;
  Application.ProcessMessages;
  for j:=1 to res do
    begin
    InVec.Elem[1] := RCCplot.Scale1X.RangeLow + i*(RCCplot.Scale1X.RangeHigh-RCCplot.Scale1X.RangeLow)/res;
    InVec[1] := (InVec[1]-Means[1])/StdDevs[1];
    InVec.Elem[2] := RCCplot.Scale1Y.RangeLow + j*(RCCplot.Scale1Y.RangeHigh-RCCplot.Scale1Y.RangeLow)/res;
    InVec[2] := (InVec[2]-Means[2])/StdDevs[2];
    EstimateByKNN (AuxMat,                       // TrnMat: TMatrix;
                   TargetVec,
                   round(NIONumNb.Value),        // kn: integer;
                   TKnnWMode(RGWeighting.ItemIndex), // WeightingMode: TKnnWMode;
                   NIOSmooth.Value,
                   Invec,
                   z,                            // EstTarget: double;
                   dbar);                        // var EstMeanDist: double);
    RCCplot.DataColor := CalcColorCoding (z);
    RCCplot.FillColor := RCCplot.DataColor;
                       // trick to store height in RCPlot tag data (asingle and alongint are physically the same)
    RCCPlot.DataTag := round(1000*z);
                       // plot grid element of contour plot
    RCCPlot.Rectangle (RCCplot.Scale1X.RangeLow+i/res*(RCCplot.Scale1X.RangeHigh-RCCplot.Scale1X.RangeLow)-DiffX,
                       RCCplot.Scale1Y.RangeLow+j/res*(RCCplot.Scale1Y.RangeHigh-RCCplot.Scale1Y.RangeLow)-DiffY,
                       RCCplot.Scale1X.RangeLow+i/res*(RCCplot.Scale1X.RangeHigh-RCCplot.Scale1X.RangeLow)+DiffX,
                       RCCplot.Scale1Y.RangeLow+j/res*(RCCplot.Scale1Y.RangeHigh-RCCplot.Scale1Y.RangeLow)+DiffY);
    Plot3D1.GridMat.Elem[res-i+1,j] := z;         // load 3D plot grid element (unscaled in meters)
    end;
  end;

Plot3D1.SetRange (Maxs[1], Mins[1], Mins[2], Maxs[2], Mins[3], Maxs[3]);
ScrBarSclZChange (nil);
Plot3D1.ColorScaleLow := Mins[3];
Plot3D1.ColorScaleHigh := Maxs[3];
Plot3D1.SuppressPaint := false;

RcCPlot.RemoveItemsByClass (99);  // remove any previous sensor data points
if CBoxShowData.Checked then
  begin
  RcCPlot.Classdefault := 99;     // display sensor data
  RcCPlot.DataColor := clBlack;
  for i:=1 to TEData.Data.NrOfRows do
    RCCPlot.MarkAt (TEData.Data[varix[1],i],TEData.Data[varix[2],i],7);
  end;
RCCplot.Scale1X.Caption := TEData.ColName[varix[1]];
RCCplot.Scale1X.Caption := TEData.ColName[varix[2]];
RCCPlot.SHowGraf;
Means.Free;
StdDevs.Free;
AUxMat.Free;
TargetVec.Free;
Screen.Cursor := crDefault;
end;


(******************************************************************************)
procedure TFrmDataVis.SpeedButton1Click(Sender: TObject);
(******************************************************************************)

begin
if ColorDialog1.Execute then
  begin
  CSHigh.SelColor := ColorDialog1.Color;
  NewCalcNeeded;
  end;
end;

(******************************************************************************)
procedure TFrmDataVis.SpeedButton2Click(Sender: TObject);
(******************************************************************************)

begin
if ColorDialog1.Execute then
  begin
  CSMid.SelColor := ColorDialog1.Color;
  NewCalcNeeded;
  end;
end;

(******************************************************************************)
procedure TFrmDataVis.SpeedButton3Click(Sender: TObject);
(******************************************************************************)

begin
if ColorDialog1.Execute then
  begin
  CSLow.SelColor := ColorDialog1.Color;
  NewCalcNeeded;
  end;
end;

(******************************************************************************)
procedure TFrmDataVis.SBStandardColorsClick(Sender: TObject);
(******************************************************************************)

begin
CSLow.SelColor := $FF8080;
CSMid.SelColor := $80FF80;
CSHigh.SelColor := $8080FF;
NewCalcNeeded;
end;


(******************************************************************************)
procedure TFrmDataVis.SBGrayScaleClick(Sender: TObject);
(******************************************************************************)

begin
CSLow.SelColor := clBlack;
CSMid.SelColor := clSilver;
CSHigh.SelColor := clWhite;
NewCalcNeeded;
end;

(******************************************************************************)
procedure TFrmDataVis.FormShow(Sender: TObject);
(******************************************************************************)

var
  i,j,n,N2,o: integer;

begin
varix[1] := 1;
varix[2] := 2;
varix[3] := 3;
NLXCoord.LeftText := TEData.ColName[varix[1]];
NLYCoord.LeftText := TEData.ColName[varix[2]];
NLZCoord.LeftText := TEData.ColName[varix[3]];
SBStandardColorsClick(Sender);
TEdata.PopupDMask := 0;
BButExecute.Enabled := false;

if form1.CbGraph.Checked=true then
begin
 form1.CbGraph2.Checked:=false;

 N:=strtoint(form1.EditN.text);
 o:=N*N;

 TEData.NrOfRows :=o;    //nix asli 40
 for i:=1 to N do
  for j:=1 to N do
    TEData[j,i] := Data[i,j]; //nix

 BButExecuteClick (nil);
end
else//graph2(Integ Eq)
begin
form1.CbGraph.Checked:=false;

 n:=strtoint(form1.EdN.text);
 N2:=n+1;
 o:=N2*N2;

 TEData.NrOfRows :=o;    //nix asli 40
 for i:=1 to N2 do
  for j:=1 to N2 do
    TEData[j,i] := Data[i,j]; //nix

 BButExecuteClick (nil);
end

end;


(******************************************************************************)
procedure TFrmDataVis.BButExecuteClick(Sender: TObject);
(******************************************************************************)

begin
NLXCoord.LeftText := TEData.ColName[varix[1]];
NLYCoord.LeftText := TEData.ColName[varix[2]];
NLZCoord.LeftText := TEData.ColName[varix[3]];
DisplayPlots;
DisplayColorCoding;
if PageControl1.ActivePage = TSData then
  PageControl1.ActivePage := TSColorMap;
Plot3D1.Visible := true;
RCCPlot.Visible := true;
BButExecute.Enabled := false;
end;

(******************************************************************************)
procedure TFrmDataVis.RCCPlotMouseMoveInChart(Sender: TObject;
  InChart: Boolean; Shift: TShiftState; rMousePosX, rMousePosY: Double);
(******************************************************************************)

var
  pdc      : longint;
  dist     : double;
  dcan     : TrcChartItem;

begin
NLXCoord.value := rMousePosX;
NLYCoord.value := rMousePosY;
pdc := RCCPlot.FindNearestItemScreen (RMousePosX, rMousePosY, tkRect, 255, Dist);
if pdc >= 0 then
  begin
  dcan := RCCplot.GetItemParams (pdc);
  NLZCoord.value := dcan.tag/1000;
  end;
end;


(******************************************************************************)
procedure TFrmDataVis.RGWeightingClick(Sender: TObject);
(******************************************************************************)

begin
if RGWeighting.ItemIndex = 0
  then begin
       LblSmooth.Enabled :=true;
       NIOSmooth.Enabled :=true;
       end
  else begin
       LblSmooth.Enabled :=false;
       NIOSmooth.Enabled :=false;
       end;
NewCalcNeeded;
end;

(******************************************************************************)
procedure TFrmDataVis.NewCalcNeeded;
(******************************************************************************)

begin
if CBoxAutoCalc.Checked
  then begin
       BButExecuteClick (nil);
       end
  else begin
       Plot3D1.Visible := false;
       RCCPlot.Visible := false;
       BButExecute.Enabled := true;
       end;
end;


(******************************************************************************)
procedure TFrmDataVis.CBoxShowDataClick(Sender: TObject);
(******************************************************************************)

var
  i : integer;

begin
RcCPlot.RemoveItemsByClass (99);
if CBoxShowData.Checked then
  begin
  RcCPlot.Classdefault := 99;
  RcCPlot.DataColor := clBlack;
  for i:=1 to TEData.Data.NrOfRows do
    RCCPlot.MarkAt (TEData.Data[varix[1],i],TEData.Data[varix[2],i],7);
  end;
RCCPlot.SHowGraf;
end;

(******************************************************************************)
procedure TFrmDataVis.SBSaveUserColorClick(Sender: TObject);
(******************************************************************************)

var
  SDiag : TSaveDialog;
  TFile : TextFile;

begin
SDiag := TSaveDialog.Create (self);
SDiag.Filter := 'Contour Plot Colors|*.cpc';
if SDiag.Execute then
  begin
  AssignFile (TFile, StripExtension(SDiag.FileName)+'.cpc');
  Rewrite (TFile);
  writeln (Tfile, CSLow.SelColor);
  writeln (Tfile, CSMid.SelColor);
  writeln (Tfile, CSHigh.SelColor);
  closeFile (TFile);
  end;
SDiag.Free;
end;

(******************************************************************************)
procedure TFrmDataVis.SBLoadUsercolorClick(Sender: TObject);
(******************************************************************************)

var
  TFile : TextFile;
  acolor : TColor;

begin
ODiag.Filter := 'Contour Plot Colors|*.cpc';
if ODiag.Execute then
  begin
  AssignFile (TFile, ODiag.FileName);
  Reset (TFile);
  readln (Tfile, acolor);
  CSLow.SelColor := acolor;
  readln (Tfile, acolor);
  CSMid.SelColor := acolor;
  readln (Tfile, acolor);
  CSHigh.SelColor := acolor;
  closeFile (TFile);
  end;
NewCalcNeeded;
end;



(******************************************************************************)
procedure TFrmDataVis.BButLoadDataClick(Sender: TObject);
(******************************************************************************)


begin
ODiag.Filter := 'Data (ASC Format)|*.asc';
if ODiag.Execute then
  begin
  TEData.SuppressPaint := true;
  TEData.Data.ImportASC (ODiag.FileName);
  TEData.SuppressPaint := false;
  end;
NewCalcNeeded;
end;



(**************************************************************************)
procedure TFrmDataVis.BButExitClick(Sender: TObject);
(**************************************************************************)

begin
close;
end;

(******************************************************************************)
procedure TFrmDataVis.ScrBarAngleXChange(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.ViewAngleX := ScrBarAngleX.Position;
NLabX.Value := ScrBarAngleX.Position;
end;

(******************************************************************************)
procedure TFrmDataVis.ScrBarAngleZChange(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.ViewAngleZ := ScrBarAngleZ.Position;
NLabZ.Value := ScrBarAngleZ.Position;
end;

(******************************************************************************)
procedure TFrmDataVis.ScrBarMagnifChange(Sender: TObject);
(******************************************************************************)

begin
Plot3d1.Magnification := ScrBarMagnif.position/100;
NLabMag.Value := ScrBarMagnif.position/100;
end;


(******************************************************************************)
procedure TFrmDataVis.CSelHighChange(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.ColorHigh := CSHigh.SelColor;
end;

(******************************************************************************)
procedure TFrmDataVis.CSelLowChange(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.ColorLow := CSLow.SelColor;
end;


(******************************************************************************)
procedure TFrmDataVis.CselMidChange(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.ColorMid := CSMid.SelColor;
end;


(******************************************************************************)
procedure TFrmDataVis.CSelGridChange(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.ColorMesh := CSelGrid.SelColor;
end;

(******************************************************************************)
procedure TFrmDataVis.CBoxMeshClick(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MeshVisible := CBoxMesh.Checked;
CSelGrid.Enabled := CboxMesh.Checked;
end;


(******************************************************************************)
procedure TFrmDataVis.Rotate1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotate;
end;

(******************************************************************************)
procedure TFrmDataVis.Pan1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maPan;
end;

(******************************************************************************)
procedure TFrmDataVis.Zoom1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maZoom;
end;

(******************************************************************************)
procedure TFrmDataVis.RotateandZoom1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotAndZoom;
end;

(******************************************************************************)
procedure TFrmDataVis.RotXOnly1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotXOnly;
end;

(******************************************************************************)
procedure TFrmDataVis.RotZOnly1Click(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.MouseAction := maRotZOnly;
end;


(******************************************************************************)
procedure TFrmDataVis.Plot3D1MouseAction(Sender: TObject; var CenterX,
  CenterY: Integer; var RotXAngle, RotZAngle, Magnification: Double;
  Shift: TShiftState);
(******************************************************************************)

begin
NLabX.Value := RotXAngle;
NLabZ.Value := RotZAngle;
NLabMag.Value := Magnification;
end;


(******************************************************************************)
procedure TFrmDataVis.ScrBarSclZChange(Sender: TObject);
(******************************************************************************)

begin
NLabZScale.Value := ScrBarSclZ.Position/100;
Plot3D1.Setrange (Plot3D1.RangeXLow, Plot3D1.RangeXHigh,
                  Plot3D1.RangeYLow, Plot3D1.RangeYHigh,
                  (Maxs[3]+Mins[3])/2 - (Maxs[3]-Mins[3])/2/ScrBarSclZ.Position*100,
                  (Maxs[3]+Mins[3])/2 + (Maxs[3]-Mins[3])/2/ScrBarSclZ.Position*100);
end;


(******************************************************************************)
procedure TFrmDataVis.SBResetClick(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.SuppressPaint := true;
ScrBarAngleZ.Position := 160;
ScrBarAngleX.Position := 75;
ScrBarMagnif.Position := 100;
ScrBarSclZ.Position := 100;
Plot3D1.SuppressPaint := false;
end;



(******************************************************************************)
procedure TFrmDataVis.Plot3D1BeforeRenderPolygon(Sender: TObject;
  var Canvas: TCanvas; var Handled: Boolean; CellX, CellY: Integer;
  quad: TQuad; var color: TColor);
(******************************************************************************)

begin
color := CalcColorCoding(Plot3D1.GridMat.Elem[CellX,CellY]);
end;



(******************************************************************************)
procedure TFrmDataVis.Plot3D1BeforeDrawScaleLabel(Sender: TObject;
  var Canvas: TCanvas; ScaleType: TP3ScaleKind;
  var CurrentTickLabel: String; ChartX, ChartY: Integer);
(******************************************************************************)

begin
case ScaleType of
  p3skX : CurrentTickLabel := CurrentTickLabel + ' m';
  p3skY : CurrentTickLabel := CurrentTickLabel + ' m';
  p3skZ : CurrentTickLabel := CurrentTickLabel + ' m';
end;
end;


(******************************************************************************)
procedure TFrmDataVis.FormResize(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.CentX := Plot3D1.Width div 2-20;
Plot3D1.CentY := Plot3D1.Height div 2;
end;

(******************************************************************************)
procedure TFrmDataVis.NewCalcNeededAfterClick(Sender: TObject);
(******************************************************************************)

begin
NewCalcNeeded;
end;

(******************************************************************************)
procedure TFrmDataVis.TEDataChange(Sender: TObject);
(******************************************************************************)

begin
Plot3D1.Visible := false;
RCCPlot.Visible := false;
BButExecute.Enabled := true;
end;

(******************************************************************************)
procedure TFrmDataVis.CBoxEditDataAllowedClick(Sender: TObject);
(******************************************************************************)

begin
if CboxEditDataAllowed.Checked
  then TEData.Options := TEData.Options + [goEditing]
  else TEData.Options := TEData.Options - [goEditing];
end;

(******************************************************************************)
procedure TFrmDataVis.Plot3D1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
(******************************************************************************)

begin
ScrBarAngleZ.Position := round(NLabZ.Value);
ScrBarAngleX.Position := round(NLabX.Value);
ScrBarMagnif.Position := round(100*NLabMag.Value);
end;

procedure TFrmDataVis.Button1Click(Sender: TObject);
begin
 TEData.Clear;
end;

end.

