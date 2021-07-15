# CalcoloNumerico

## Basic Matrix Propreties and Linear Systems ##
* _**condizioni**_
  (requires _controlla_) finds propreties of Matrices and shows methods to solve the linear system "Ax=b".
* 

## Function Approx ##
* _**CGL**_ (chebyshev Gauss Lobatto)
  computes CGL knodes given the number of knodes-1 required and the interval [a,b]
* _**Lebesgue**_
  (requires _funzione_caratteristica_lagrange_) draws Lagrange polynomials and prints out the Lebesgue constant
* _****_


## Numerical Derivation/Integration ##
* _**grado_di_esattezza**_
  computes the degree of accuracy of a numerical formula (for the integration)
  
  
## Finite Difference Equations ##
* _**diffusione_trasporto_reazione**_, _**diffusione_trasporto_reazione_DN**_, _**diffusione_trasporto_reazione_ND**_, _**diffusione_trasporto_reazione_NN**_
  these scripts solve a diffusion-transport-reaction problem on the interval [a,b] (the \_XY after "diffusione_trasporto_reazione" stands for the type of boundary conditions (X for point a and Y for point B): N = Newmann, D = Dirichlet, if not present is DD). Please notice: sometimes the program suggests better viscosity to reduce numerical oscillations.
* _**pechlet**_
  evaluates Péclet number

## Basic Symbolic ##
* _**deriva**_
  outputs the derivative of the given function as a function handle
* _**integra**_
   outputs the integral of the given function as a function handle (notice: no constant added [c=0]!)
