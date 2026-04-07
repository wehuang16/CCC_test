within CCC_test.ESTCP;
function w_function
  "Polynomial, used because OpenModelica 1.4.3 does not expand the sum() into a scalar"
  extends Modelica.Icons.Function;

  input Real w "w";
  input Real x "x";
  input Real T "T";
  output Real y "Dependent variable";
algorithm
 y :=0.9*w + 0.1*x + T;


end w_function;
