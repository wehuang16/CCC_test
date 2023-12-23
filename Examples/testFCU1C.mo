within CCC_test.Examples;
model testFCU1C
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  FanCoilUnitPidTest1C fanCoilUnitPidTest1_1(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.06111,
    zone_temp_setpoint=291.15,
    dp1_nominal(displayUnit="kPa") = 10600,
    m2_flow_nominal=0.05333,
    T_a1_nominal=343.15,
    T_a2_nominal=293.15,
    Q_flow_nominal=2549.7177)
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-78,31})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{72,22},{52,40}})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{98,-184},{118,-164}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    T=293.15,
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
        origin={-72,-21})));
  Modelica.Blocks.Sources.Constant const4(k=17)
    annotation (Placement(transformation(extent={{-80,-76},{-60,-56}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        MediumWater, m_flow_nominal=0.06111)
    annotation (Placement(transformation(extent={{-48,16},{-28,36}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium =
        MediumAir, m_flow_nominal=0.05333)       annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-38,-24})));
equation
  connect(const4.y, fanCoilUnitPidTest1_1.zonAirTem) annotation (Line(points={{
          -59,-66},{-10,-66},{-10,13.2}}, color={0,0,127}));
  connect(fanCoilUnitPidTest1_1.m_flow_air, fan1.m_flow_in) annotation (Line(
        points={{13.2,13.8},{16,13.8},{16,4},{-12,4},{-12,-44},{-38,-44},{-38,
          -36}}, color={0,0,127}));
  connect(fanCoilUnitPidTest1_1.m_flow_water, fan.m_flow_in) annotation (Line(
        points={{13.2,30.2},{18,30.2},{18,48},{-38,48},{-38,38}}, color={0,0,
          127}));
  connect(boundary3.ports[1], fan1.port_b) annotation (Line(points={{-62,-21},{
          -62,-24},{-48,-24}}, color={0,127,255}));
  connect(fan1.port_a, fanCoilUnitPidTest1_1.port_b2) annotation (Line(points={
          {-28,-24},{-14,-24},{-14,17},{-8.2,17}}, color={0,127,255}));
  connect(fanCoilUnitPidTest1_1.port_a2, boundary1.ports[1]) annotation (Line(
        points={{12.2,16.8},{18,16.8},{18,1},{60,1}}, color={0,127,255}));
  connect(fanCoilUnitPidTest1_1.port_a1, fan.port_b) annotation (Line(points={{
          -8.2,26.4},{-17.1,26.4},{-17.1,26},{-28,26}}, color={0,127,255}));
  connect(fan.port_a, boundary2.ports[1])
    annotation (Line(points={{-48,26},{-68,26},{-68,31}}, color={0,127,255}));
  connect(fanCoilUnitPidTest1_1.port_b1, boundary4.ports[1]) annotation (Line(
        points={{12.2,26.4},{46,26.4},{46,31},{52,31}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFCU1C;
