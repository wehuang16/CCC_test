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
    T=323.15)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-74,-19})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpFcuWaterSupply(
    redeclare package Medium = MediumPropyleneGlycol,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false,
    m_flow_nominal=1)                             "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-26,20})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=100)
    annotation (Placement(transformation(extent={{30,-22},{50,-2}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={86,-3})));
  Modelica.Blocks.Sources.Constant const1(k=-1)
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-0.8,
    duration=43200,
    offset=1,
    startTime=21600)
    annotation (Placement(transformation(extent={{12,40},{32,60}})));
equation
  connect(pumpFcuWaterSupply.port_b, val.port_a) annotation (Line(points={{-16,
          20},{24,20},{24,-12},{30,-12}}, color={0,127,255}));
  connect(ramp.y, val.y)
    annotation (Line(points={{33,50},{40,50},{40,0}}, color={0,0,127}));
  connect(const1.y, pumpFcuWaterSupply.m_flow_in) annotation (Line(points={{-49,
          60},{-38,60},{-38,50},{-26,50},{-26,32}}, color={0,0,127}));
  connect(pumpFcuWaterSupply.port_a, val.port_b) annotation (Line(points={{-36,
          20},{-46,20},{-46,-46},{58,-46},{58,-12},{50,-12}}, color={0,127,255}));
  connect(boundary1.ports[1], val.port_a) annotation (Line(points={{76,-3},{54,
          -3},{54,2},{30,2},{30,-12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPumpValve;
