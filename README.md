# Numerical Method
## 1. Extended False Position
### False Position Formula: ###
  ## $c_i=b_i-\frac { f(b_i)(b_i-a_i)} { f(b_i)-f(a_i) }\$ ## 
<br><i>for i = 0,1,2,…..,M</i>
<br><br>
&emsp; For finding multiple roots simultaneously of the function at the interval.<br><br>
This app use extended algorithm than classical False position method.<br>
Build in Lazarus 3.2. <br>
Use lib:<br>
1. Art formula as math parser to input math equation at runtime.<br>
2. Chart as graph viewer.
<br><br>

## 2. Multi-Critical Point Finder
### Using Extended Golden Search Method: ###
<br>
&nbsp&nbsp&nbsp To find multiple critical points (maximum and minimum) of the function simultaneously.
<br><br>
Build in Lazarus 3.2. <br>
Use lib:<br>
1. Art formula as math parser to input math equation at runtime.<br>
2. Chart as graph viewer.
<br><br>

## 3. Multi-Intersection Point Finder
### Using Extended False Position Method: ###
<br>
&nbsp&nbsp&nbsp To find multiple intersection points between two graphs/functions simultaneously.
<br><br>
When two graphs intersected, Y1=Y2 so Y1-Y2=0, it's a finding root problem that can be solved using one of the finding root methods, in this case using False position method.<br>
If we had been got the root(x), then input x into one of the equation (Y1 or Y2), so we got (x,y) as the intersection coordinate.<br>
This app will be found multiple intersection points, so the method need to be extended becomes Extended False Position method.<br>
Build in Lazarus 3.2. <br>
Use lib:<br>
1. Art formula as math parser to input math equation at runtime.<br>
2. Chart as graph viewer.
<br><br>

## 4. Multi-Area Calculation using Extended False Position Method and Extended Composite Simpson’s 1/3 Rule
### False Position Formula: ###
  ## $c_i=b_i-\frac { f(b_i)(b_i-a_i)} { f(b_i)-f(a_i) }\$ <br>
  <i>for i = 0,1,2,…..,M</i>
<br><br>
### Composite Simpson’s 1/3 Rule Formula: ###
  ## $\int_{a}^{b}f(x)dx\approx\frac{h}{3} \left[ f(x_0)+2\sum_{k=1}^{\frac{M}{2}-1}f(x_{2k})+4\sum_{k=1}^{\frac{M}{2}}f(x_{2k-1})+f(x_M)\right]\$ <br>
  <i>h=(b-a)/M ; x0 =a ; xM= b ; xk=a+k h ; for k=0,1,2…M</i>
<br><br>
&emsp; To simultaneously calculate the multi-area under the curve and between two curves of the function on the given interval.<br><br>
Build in Lazarus 3.2. <br>
Use lib:<br>
1. Art formula as math parser to input math equation at runtime, the component/lib on the folder "formula".<br>
2. Chart as graph viewer.
<br><br>

## 5. Integral Double & Integral Equation Solver
### Using Simpson's 1/3 rule: ###
<br>
&nbsp&nbsp&nbsp To find double integral of function I=f(x,y) and Integral Equation. <br>

  ## $\I=int_{y1}^{y2}int_{x1}^{x2}f(x,y)dx dy\$ <br>
Build in Delphi 7 <br>
<br><br>

