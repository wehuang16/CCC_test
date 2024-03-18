within CCC_test.Examples;
model ExampleBlock
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  Modelica.Blocks.Interfaces.RealOutput TOut
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={142,210})));
  Modelica.Blocks.Interfaces.RealOutput TZone annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={296,210})));
  Modelica.Blocks.Interfaces.RealInput m_flow
    annotation (Placement(transformation(extent={{60,-38},{100,2}})));
  Modelica.Blocks.Math.Gain gain(k=5)
    annotation (Placement(transformation(extent={{154,60},{174,80}})));
  Modelica.Blocks.Math.Gain gain1(k=7)
    annotation (Placement(transformation(extent={{266,28},{286,48}})));
equation
  connect(m_flow, gain.u) annotation (Line(points={{80,-18},{146,-18},{146,70},
          {152,70}}, color={0,0,127}));
  connect(m_flow, gain1.u) annotation (Line(points={{80,-18},{146,-18},{146,38},
          {264,38}}, color={0,0,127}));
  connect(gain.y, TOut) annotation (Line(points={{175,70},{180,70},{180,192},{
          142,192},{142,210}}, color={0,0,127}));
  connect(gain1.y, TZone)
    annotation (Line(points={{287,38},{296,38},{296,210}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,200}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,200}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ExampleBlock;
