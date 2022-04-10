# CalcoloNumerico #

Software by Carlo Zambaldo (info@carlozambaldo.it)
This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.

Raccolta di alcune funzioni utili durante il corso di Calcolo Numerico

  
## Basic Calculus - Basic Matrix Propreties - Linear Systems ##
* _**insiemeF**_
* _**condizioni**_
  (requires _controlla_) finds propreties of Matrices and shows methods to solve the linear system "Ax=b".
* _**Wilkinson**_
  estimates the maximum value of the perturbation expected on a given matrix
* _**controlla**_
  
  
## Non-linar Functions - Zeros of Functions##
* _**condizioniF**_
* _**metodocorde**_
* _**metodosecanti**_
* _**ptofis_sistemi**_
* _**molteplicity**_
  computes the molteplicity of the zero of a function


## Function Approx ##
* _**CGL**_ (chebyshev Gauss Lobatto)
  computes CGL knodes given the number of knodes-1 required and the interval [a,b]
* _**Lebesgue**_
  (requires _funzione_caratteristica_lagrange_) draws Lagrange polynomials and prints out the Lebesgue constant
* _**funzione_caratteristica_lagrange**_
* _**interp_trigo.m**_ 
  outputs the trigonometric interpolator as a function handle


## Numerical Derivation/Integration - ODEs ##
* _**grado_di_esattezza**_
  computes the degree of accuracy of a numerical formula (for the integration)
* _**stability_region**_, _**stability_region_contour**_
  plots the stability region of a particular numerical method (notice: the stability function is required!)
* _**leap_frog**_
  implements the Leap-Frog method
* _**runge_kutta**_
  solves the given Cauchy Problem, given a particular Butcher tableau.


## Finite Difference Equations ##
* _**diffusione_trasporto_reazione**_, _**diffusione_trasporto_reazione_DN**_, _**diffusione_trasporto_reazione_ND**_, _**diffusione_trasporto_reazione_NN**_
  these scripts solve a diffusion-transport-reaction problem on the interval [a,b] (the \_XY after "diffusione_trasporto_reazione" stands for the type of boundary conditions (X for point a and Y for point B): N = Newmann, D = Dirichlet, if not present is DD). Please notice: sometimes the program suggests better viscosity to reduce numerical oscillations.
* _**pechlet**_
  evaluates local Péclet number


## Basic Symbolic ##
* _**deriva**_
  outputs the derivative of the given function as a function handle
* _**integra**_
   outputs the integral of the given function as a function handle (notice: no constant added [c=0]!)
* _**jacobiana**_ 


## Other ##
* _**stimaalgebrica_p**_
  estimates C and p in: err <= C * h^p
* _**stimaerr**_
* _**plot_soluzione**_
  quickly plots the solution obtained with a numerical method (i.e. _diffusione_trasporto_reazione_)
* _**tridiag**_
  outputs a tridiagonal matrix
* _**pentadiag**_
  outputs a pentadiagonal matrix
* _**poly2func**_
  

# Licence #

Copyright 2020 Carlo Zambaldo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
* Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 
* NonCommercial — You may not use the material for commercial purposes. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
