within CCC_test.Examples;
model testAnyBlock
              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  Modelica.Blocks.Sources.Sine loaVar(
    amplitude=1500000,
    f=1/86400,
    phase=4.1887902047864,
    offset=1500000,
    startTime(displayUnit="h") = 0)     "Variable demand load"
    annotation (Placement(transformation(extent={{-36,-22},{-16,-2}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=259200,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
