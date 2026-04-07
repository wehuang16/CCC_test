within CCC_test.ESTCP;
model solve_derivative_time_dependent

    Real y;
equation
  der(y) = sin(time);

initial equation
  y = 1;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end solve_derivative_time_dependent;
