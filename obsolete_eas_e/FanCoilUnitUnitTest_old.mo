within CCC_test.obsolete_eas_e;
model FanCoilUnitUnitTest_old
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC_test.obsolete_eas_e.FanCoilUnit_old fanCoilUnit_hysteresis_air_control(
    redeclare package Medium1 = MediumPropyleneGlycol,
    redeclare package Medium2 = MediumAir,
    dp1_nominal(displayUnit="kPa"))
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=true,
    T=348.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-134,59})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{72,22},{52,40}})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{98,-184},{118,-164}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    T=299.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={70,1})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-118,-19})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 35)
    annotation (Placement(transformation(extent={{30,-64},{50,-44}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=0.08758,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-78,24},{-58,44}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium =
        MediumAir,
    m_flow_nominal=0.07589,
    addPowerToMedium=false)                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-38,-24})));
  Modelica.Blocks.Sources.Constant const1(k=0.075)
    annotation (Placement(transformation(extent={{-116,68},{-96,88}})));
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
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 24)
    annotation (Placement(transformation(extent={{-6,-84},{14,-64}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,273.15 + 75; 8640*1,
        273.15 + 75; 8640*1,273.15 + 55; 8640*2,273.15 + 55; 8640*2,273.15 + 45;
        8640*3,273.15 + 45; 8640*3,273.15 + 35; 8640*4,273.15 + 35])
    annotation (Placement(transformation(extent={{-202,42},{-182,62}})));
  Modelica.Blocks.Sources.TimeTable timeTable1(table=[0.0,273.15 + 35; 8640*1,
        273.15 + 35; 8640*1,273.15 + 45; 8640*2,273.15 + 45; 8640*2,273.15 + 55;
        8640*3,273.15 + 55; 8640*3,273.15 + 75; 8640*4,273.15 + 75])
    annotation (Placement(transformation(extent={{-206,0},{-186,20}})));
  Modelica.Blocks.Sources.TimeTable timeTable2(table=[0.0,273.15 + 7; 8640*1,
        273.15 + 7; 8640*1,273.15 + 16; 8640*2,273.15 + 16; 8640*2,273.15 +
        18.3; 8640*3,273.15 + 18.3])
    annotation (Placement(transformation(extent={{-192,-30},{-172,-10}})));
equation
  connect(fanCoilUnit_hysteresis_air_control.m_flow_air, fan1.m_flow_in)
    annotation (Line(points={{13.2,13.8},{16,13.8},{16,4},{-12,4},{-12,-44},{-38,
          -44},{-38,-36}}, color={0,0,127}));
  connect(boundary3.ports[1], fan1.port_b) annotation (Line(points={{-108,-19},
          {-108,-20},{-54,-20},{-54,-24},{-48,-24}},
                               color={0,127,255}));
  connect(fan1.port_a, fanCoilUnit_hysteresis_air_control.port_b2) annotation (
      Line(points={{-28,-24},{-14,-24},{-14,17},{-8.2,17}}, color={0,127,255}));
  connect(fanCoilUnit_hysteresis_air_control.port_a2, boundary1.ports[1])
    annotation (Line(points={{12.2,16.8},{18,16.8},{18,1},{60,1}}, color={0,127,
          255}));
  connect(fanCoilUnit_hysteresis_air_control.port_b1, boundary4.ports[1])
    annotation (Line(points={{12.2,26.4},{46,26.4},{46,31},{52,31}}, color={0,
          127,255}));
  connect(fan.port_a, temp1.port_b)
    annotation (Line(points={{-78,34},{-90,34}}, color={0,127,255}));
  connect(temp1.port_a, boundary2.ports[1]) annotation (Line(points={{-110,34},
          {-118,34},{-118,59},{-124,59}}, color={0,127,255}));
  connect(fanCoilUnit_hysteresis_air_control.port_a1, temp2.port_b) annotation (
     Line(points={{-8.2,26.4},{-17.1,26.4},{-17.1,26},{-26,26}}, color={0,127,
          255}));
  connect(temp2.port_a, fan.port_b) annotation (Line(points={{-46,26},{-52,26.4},
          {-52,34},{-58,34}}, color={0,127,255}));
  connect(fanCoilUnit_hysteresis_air_control.m_flow_water, fan.m_flow_in)
    annotation (Line(points={{13.2,30.2},{13.2,46},{-68,46}}, color={0,0,127}));
  connect(const4.y, boundary1.T_in) annotation (Line(points={{51,-54},{82,-54},
          {82,4.6}},                   color={0,0,127}));
  connect(fanCoilUnit_hysteresis_air_control.TZon, const2.y) annotation (Line(
        points={{6.4,10},{6.4,-60},{15,-60},{15,-74}}, color={0,0,127}));
  connect(timeTable2.y, boundary2.T_in) annotation (Line(points={{-171,-20},{
          -146,-20},{-146,55.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=43200,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end FanCoilUnitUnitTest_old;
