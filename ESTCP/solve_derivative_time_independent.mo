within CCC_test.ESTCP;
model solve_derivative_time_independent

  parameter Real T0 = 1;
  parameter Real w0 = 5;
  parameter Real x0 = 2;
  parameter Real m0 = 0;


  // State variables
  Real T(start=T0);
  Real w(start=w0);
  Real x(start=x0);
  Real m(start=m0);

equation
  der(T)=1;
  der(w)=0.9*w+0.1*x+T;
  der(x)=0.1*w+0.9*x+T;
  der(m)=0.45*w+0.05*x+0.5*T;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=0,
      StopTime=5,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end solve_derivative_time_independent;
