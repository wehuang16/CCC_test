within CCC_test.ESTCP;
model test_function

    // State variables
  Real y;
equation
  y=w_function(5,2,1);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end test_function;
