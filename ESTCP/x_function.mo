within CCC_test.ESTCP;
function x_function
  extends Modelica.Icons.Function;

  input Real w "w";
  input Real x "x";
  input Real T "T";
  output Real y "Dependent variable";
algorithm
 y :=0.1*w + 0.9*x + T;

end x_function;
