within CCC_test.Examples;
model testPumpWithPressure
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-74,-19})));
  Buildings.Fluid.Movers.SpeedControlled_y     pumpFcuWaterSupply(
    redeclare package Medium = MediumPropyleneGlycol,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false)                       "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-8,-6})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={86,-3})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=1,
    duration=4320,
    offset=0,
    startTime=2160)
    annotation (Placement(transformation(extent={{-56,16},{-36,36}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=pumpFcuWaterSupply.senMasFlo.m_flow)
    annotation (Placement(transformation(extent={{-18,-58},{2,-38}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=PumpPcm.senMasFlo.m_flow)
    annotation (Placement(transformation(extent={{120,-218},{140,-198}})));
equation
  connect(boundary2.ports[1], pumpFcuWaterSupply.port_a) annotation (Line(
        points={{-64,-19},{-24,-19},{-24,-6},{-18,-6}}, color={0,127,255}));
  connect(pumpFcuWaterSupply.port_b, boundary1.ports[1]) annotation (Line(
        points={{2,-6},{38,-6},{38,-3},{76,-3}}, color={0,127,255}));
  connect(ramp.y, pumpFcuWaterSupply.y) annotation (Line(points={{-35,26},{-22,
          26},{-22,20},{-8,20},{-8,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPumpWithPressure;
