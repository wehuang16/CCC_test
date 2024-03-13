within CCC_test.Examples;
model TestSpeedPumpPressure

 package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.Movers.SpeedControlled_y     pump(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,0})));
  Buildings.Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = MediumWater,
    p(displayUnit="Pa") = 100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-108,16},{-88,36}})));
  Buildings.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = MediumWater,
    use_p_in=true,
    p(displayUnit="Pa"),
    nPorts=1)                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,-14})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-50,52},{-30,72}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-15000,
    duration=64800,
    offset=100000 + 15000,
    startTime=0)
    annotation (Placement(transformation(extent={{26,-74},{46,-54}})));
equation
  connect(bou1.ports[1], pump.port_a) annotation (Line(points={{-88,26},{-36,26},
          {-36,0},{-30,0}}, color={0,127,255}));
  connect(pump.port_b, bou.ports[1]) annotation (Line(points={{-10,0},{22,0},{
          22,-10},{50,-10},{50,-14}}, color={0,127,255}));
  connect(const.y, pump.y)
    annotation (Line(points={{-29,62},{-20,62},{-20,12}}, color={0,0,127}));
  connect(ramp.y, bou.p_in) annotation (Line(points={{47,-64},{82,-64},{82,-22},
          {72,-22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestSpeedPumpPressure;
