within CCC_test.Examples;
model testAnyBlock3
              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  Modelica.Blocks.Sources.BooleanConstant
                                   booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  Modelica.Blocks.Sources.Constant const1(k=7)
    annotation (Placement(transformation(extent={{-94,-46},{-74,-26}})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=1,
    f=0.00004629629,
    offset=0.5)
    annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
  testFmuInitialization10 testFmuInitialization10_1
    annotation (Placement(transformation(extent={{-24,-8},{-4,12}})));
equation
  connect(booleanConstant.y, testFmuInitialization10_1.u) annotation (Line(
        points={{-79,44},{-32,44},{-32,2},{-26,2}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end testAnyBlock3;
