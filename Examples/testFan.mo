within CCC_test.Examples;
model testFan

              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

   parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.4813;
   parameter Modelica.Units.SI.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-50,3})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={132,1})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=0.15,
    duration=64800,
    offset=0)
    annotation (Placement(transformation(extent={{-50,42},{-30,62}})));

  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     fan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=0.5)
    "Fan"
    annotation (Placement(transformation(extent={{0,-16},{20,4}})));
  Modelica.Blocks.Sources.Constant const(k=0.5)
    annotation (Placement(transformation(extent={{-12,50},{8,70}})));
equation
  connect(boundary2.ports[1], fan.port_a) annotation (Line(points={{-40,3},{-18,
          3},{-18,-4},{0,-4},{0,-6}}, color={0,127,255}));
  connect(fan.port_b, boundary1.ports[1]) annotation (Line(points={{20,-6},{116,
          -6},{116,1},{122,1}}, color={0,127,255}));
  connect(const.y, fan.m_flow_in) annotation (Line(points={{9,60},{14,60},{14,
          14},{10,14},{10,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFan;
