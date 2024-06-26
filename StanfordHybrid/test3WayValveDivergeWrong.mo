within CCC_test.StanfordHybrid;
model test3WayValveDivergeWrong
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=500)
    annotation (Placement(transformation(extent={{4,6},{24,26}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{-90,12},{-70,32}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumWater, nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={96,-56})));
  Modelica.Blocks.Sources.Ramp ramp(duration=4320, startTime=2160)
    annotation (Placement(transformation(extent={{14,68},{34,88}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,18})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-82,76},{-62,96}})));
  Buildings.Fluid.FixedResistances.Junction convergingJun(
    redeclare package Medium = MediumWater,
    m_flow_nominal={1,-2,1},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,-12})));
equation
  connect(ramp.y, val.y)
    annotation (Line(points={{35,78},{40,78},{40,34},{14,34},{14,28}},
                                                      color={0,0,127}));
  connect(const.y, fan.m_flow_in) annotation (Line(points={{-61,86},{10,86},{10,
          92},{54,92},{54,-4},{70,-4},{70,6}},
                                color={0,0,127}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{86,-56},{82,-56},
          {82,4},{84,4},{84,18},{80,18}}, color={0,127,255}));
  connect(convergingJun.port_2, bou1.ports[1]) annotation (Line(points={{-42,
          -12},{-64,-12},{-64,22},{-70,22}}, color={0,127,255}));
  connect(fan.port_b, val.port_1) annotation (Line(points={{60,18},{30,18},{30,
          50},{-12,50},{-12,16},{4,16}}, color={0,127,255}));
  connect(val.port_3, convergingJun.port_1)
    annotation (Line(points={{14,6},{14,-12},{-22,-12}}, color={0,127,255}));
  connect(val.port_2, convergingJun.port_3) annotation (Line(points={{24,16},{
          36,16},{36,-2},{-32,-2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end test3WayValveDivergeWrong;
