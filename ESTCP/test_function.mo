within CCC_test.ESTCP;
model test_function

    // State variables
  Real x;
  Real y;
equation
  (x,y)=CCC_test.ESTCP.Tphi_hxp(10000,0.01,101325);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end test_function;
