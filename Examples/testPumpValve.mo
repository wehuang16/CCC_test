within CCC_test.Examples;
model testPumpValve
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-74,-19})));
  Buildings.Fluid.Movers.SpeedControlled_y     pumpFcuWaterSupply(
    redeclare package Medium = MediumPropyleneGlycol,
    redeclare
      Buildings.Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4
      per,
    addPowerToMedium=false)                       "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-26,20})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{30,-22},{50,-2}})));
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
    height=-1,
    duration=4320,
    offset=1,
    startTime=2160)
    annotation (Placement(transformation(extent={{12,40},{32,60}})));
equation
  connect(pumpFcuWaterSupply.port_a, boundary2.ports[1]) annotation (Line(
        points={{-36,20},{-60,20},{-60,-19},{-64,-19}}, color={0,127,255}));
  connect(pumpFcuWaterSupply.port_b, val.port_a) annotation (Line(points={{-16,
          20},{24,20},{24,-12},{30,-12}}, color={0,127,255}));
  connect(val.port_b, boundary1.ports[1]) annotation (Line(points={{50,-12},{70,
          -12},{70,-3},{76,-3}}, color={0,127,255}));
  connect(const1.y, pumpFcuWaterSupply.y)
    annotation (Line(points={{-49,60},{-26,60},{-26,32}}, color={0,0,127}));
  connect(ramp.y, val.y)
    annotation (Line(points={{33,50},{40,50},{40,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPumpValve;
