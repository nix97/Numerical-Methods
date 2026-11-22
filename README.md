![License](https://img.shields.io/github/license/nix97/Numerical-Methods)
![Issues](https://img.shields.io/github/issues/nix97/Numerical-Methods)
![Stars](https://img.shields.io/github/stars/nix97/Numerical-Methods)
![Delphi](https://img.shields.io/badge/Built%20with-Delphi-red?logo=pascal)
![Root Finding](https://img.shields.io/badge/Method-Root%20Finding-blue)
![Interpolation](https://img.shields.io/badge/Method-Interpolation-green)
![Numerical Integration](https://img.shields.io/badge/Method-Numerical%20Integration-orange)
![Systems of Eq.](https://img.shields.io/badge/Method-Linear%20Systems-purple)
![Lazarus](https://img.shields.io/badge/Built%20with-Lazarus-blue?logo=pascal)
![GitHub release downloads](https://img.shields.io/github/downloads/nix97/Numerical-Methods/latest/total)

# Numerical Methods

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

## $I=\int_{y1}^{y2}\int_{x1}^{x2}f(x,y) dxdy\$ <br>
Build in Delphi 7<br><br>

## 6. File Nix NumericVer3.2.apk
### This is an app android for solving math problem using numerical methods.
<br>
MENU :<br>
1. GRAPHIC<br>
2. ROOT-FINDING <br>
 &nbsp;&nbsp;&nbsp;  2.1. BISECTION<br>
 &nbsp;&nbsp;&nbsp; 2.2. FALSE POSITION<br>
 &nbsp;&nbsp;&nbsp; 2.3. SECANT<br>
 &nbsp;&nbsp;&nbsp; 2.4. NEWTON-RAPHSON etc<br>
3. OPTIMIZATION<br>
4. NUMERICAL INTEGRATION<br>
5. NUMERICAL DIFFERENTIATION<br>
6. LINEAR SYSTEM<br>
7. EIGENPAIRS<br>
8. INTERPOLATION<br>
9. CURVE-FITTING<br>
10. ODEs<br>
11. PDEs<br>
Each menu got submenu.<br>
Download on: <br>
https://github.com/nix97/Numerical-Methods/releases/download/numerical/Nix.NumericVer3.2.apk.<br><br>

## 7. File Nix Numeric.rar
### This is an app windows for solving math problem using numerical methods.
<br>
The menu just like app android above.<br>
Download on:<br>
https://github.com/nix97/Numerical-Methods/releases/download/numerical2/Nix.Numeric.rar.<br><br>


