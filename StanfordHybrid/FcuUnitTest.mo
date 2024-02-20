within CCC_test.StanfordHybrid;
model FcuUnitTest
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Blocks.Sources.Constant T_zon(k=273.15 + 17)
    annotation (Placement(transformation(extent={{46,-88},{66,-68}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=311.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{84,44},{64,62}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-80,-31})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-78,39})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    T=311.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={100,-45})));
  CCC.Fluid.HeatExchangers.FanCoilUnit
                             fanCoilUnit(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.2,
    m2_flow_nominal=0.07589,
    zone_temp_setpoint=294.15,
    dp1_nominal(displayUnit="Pa") = 4394)
    annotation (Placement(transformation(extent={{24,-34},{44,-14}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,-14})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-24,20},{-4,40}})));
equation
  connect(boundary4.T_in, T_zon.y) annotation (Line(points={{112,-41.4},{120,
          -41.4},{120,-78},{67,-78}}, color={0,0,127}));
  connect(T_zon.y, fanCoilUnit.TZon) annotation (Line(points={{67,-78},{38.4,
          -78},{38.4,-36}}, color={0,0,127}));
  connect(fanCoilUnit.port_a2, boundary4.ports[1]) annotation (Line(points={{
          44.2,-29.2},{86,-29.2},{86,-45},{90,-45}}, color={0,127,255}));
  connect(boundary1.ports[1], fanCoilUnit.port_b1) annotation (Line(points={{64,
          53},{50,53},{50,-19.6},{44.2,-19.6}}, color={0,127,255}));
  connect(fanCoilUnit.port_b2, fan.port_a) annotation (Line(points={{23.8,-29},
          {23.8,-30},{14,-30},{14,-14},{-22,-14}}, color={0,127,255}));
  connect(fan.port_b, boundary2.ports[1]) annotation (Line(points={{-42,-14},{
          -66,-14},{-66,-31},{-70,-31}}, color={0,127,255}));
  connect(boundary3.ports[1], pump.port_a) annotation (Line(points={{-68,39},{
          -30,39},{-30,30},{-24,30}}, color={0,127,255}));
  connect(pump.port_b, fanCoilUnit.port_a1) annotation (Line(points={{-4,30},{
          18,30},{18,-19.6},{23.8,-19.6}}, color={0,127,255}));
  connect(fanCoilUnit.m_flow_water, pump.m_flow_in) annotation (Line(points={{
          45.2,-15.8},{45.2,42},{-14,42}}, color={0,0,127}));
  connect(fanCoilUnit.m_flow_air, fan.m_flow_in) annotation (Line(points={{45.2,
          -32.2},{48,-32.2},{48,-44},{40,-44},{40,-46},{-32,-46},{-32,-26}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FcuUnitTest;
