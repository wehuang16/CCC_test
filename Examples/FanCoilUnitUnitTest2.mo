within CCC_test.Examples;
model FanCoilUnitUnitTest2
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  containedTempSensor  fanCoilUnitPidTest1_1(redeclare package Medium1 =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-134,59})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{98,-184},{118,-164}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=0.08758,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-78,24},{-58,44}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp1(redeclare package Medium =
        MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,34})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp2(redeclare package Medium =
        MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,26})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={70,5})));
  Modelica.Blocks.Sources.Constant const1(k=0.5)
    annotation (Placement(transformation(extent={{-92,62},{-72,82}})));
equation
  connect(fan.port_a, temp1.port_b)
    annotation (Line(points={{-78,34},{-90,34}}, color={0,127,255}));
  connect(temp1.port_a, boundary2.ports[1]) annotation (Line(points={{-110,34},
          {-118,34},{-118,59},{-124,59}}, color={0,127,255}));
  connect(fanCoilUnitPidTest1_1.port_a1, temp2.port_b) annotation (Line(points=
          {{-8.2,24.6},{-17.1,24.6},{-17.1,26},{-26,26}}, color={0,127,255}));
  connect(temp2.port_a, fan.port_b) annotation (Line(points={{-46,26},{-52,26.4},
          {-52,34},{-58,34}}, color={0,127,255}));
  connect(fanCoilUnitPidTest1_1.port_b1, boundary1.ports[1]) annotation (Line(
        points={{12.2,24.6},{54,24.6},{54,5},{60,5}}, color={0,127,255}));
  connect(const1.y, fan.m_flow_in)
    annotation (Line(points={{-71,72},{-68,72},{-68,46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end FanCoilUnitUnitTest2;
