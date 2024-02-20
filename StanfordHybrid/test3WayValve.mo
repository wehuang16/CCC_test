within CCC_test.StanfordHybrid;
model test3WayValve
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=10,
    fraK=0.7)
    annotation (Placement(transformation(extent={{-10,12},{10,32}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{-90,12},{-70,32}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumWater, nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-36,-70})));
  Modelica.Blocks.Sources.Ramp ramp(duration=4320, startTime=2160)
    annotation (Placement(transformation(extent={{-34,58},{-14,78}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{46,14},{66,34}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{34,52},{54,72}})));
  Buildings.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = MediumWater,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={6,-30})));
equation
  connect(ramp.y, val.y)
    annotation (Line(points={{-13,68},{0,68},{0,34}}, color={0,0,127}));
  connect(const.y, fan.m_flow_in) annotation (Line(points={{55,62},{60,62},{60,
          44},{56,44},{56,36}}, color={0,0,127}));
  connect(val.port_2, fan.port_a) annotation (Line(points={{10,22},{12,22},{12,
          24},{46,24}}, color={0,127,255}));
  connect(fan.port_b, jun.port_1) annotation (Line(points={{66,24},{84,24},{84,
          -30},{16,-30}}, color={0,127,255}));
  connect(jun.port_3, val.port_3) annotation (Line(points={{6,-20},{4,-20},{4,
          12},{0,12}}, color={0,127,255}));
  connect(jun.port_2, bou.ports[1]) annotation (Line(points={{-4,-30},{-52,-30},
          {-52,-70},{-46,-70}}, color={0,127,255}));
  connect(bou1.ports[1], val.port_1)
    annotation (Line(points={{-70,22},{-10,22}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end test3WayValve;
