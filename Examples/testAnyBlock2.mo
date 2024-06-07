within CCC_test.Examples;
model testAnyBlock2
              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  testFmuInitialization9 testFmuInitialization9_1
    annotation (Placement(transformation(extent={{-18,-4},{2,16}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  Modelica.Blocks.Sources.Constant const1(k=7)
    annotation (Placement(transformation(extent={{-94,-46},{-74,-26}})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=1,
    f=0.00004629629,
    offset=0.5)
    annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
equation
  connect(sine.y, testFmuInitialization9_1.u) annotation (Line(points={{-133,0},
          {-28,0},{-28,5.8},{-20,5.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end testAnyBlock2;
