within CCC_test.ESTCP;
function m_function
  "Polynomial, used because OpenModelica 1.4.3 does not expand the sum() into a scalar"
  extends Modelica.Icons.Function;

  input Real w "w";
  input Real x "x";
  input Real T "T";
  output Real y "Dependent variable";
algorithm
 y :=0.45*w + 0.05*x + 0.5*T;

end m_function;
