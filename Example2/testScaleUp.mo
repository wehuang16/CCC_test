within CCC_test.Example2;
model testScaleUp
  Modelica.Blocks.Sources.Constant const[4](k=1:1:4)
    annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testScaleUp;
