within CCC_test.Examples;
model testFCU1A
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  FanCoilUnitPidTest1A fanCoilUnitPidTest1_1(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.06111,
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
        origin={-56,33})));
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
equation
  connect(boundary2.ports[1], fanCoilUnitPidTest1_1.port_a1) annotation (Line(
        points={{-46,33},{-24,33},{-24,26.4},{-8.2,26.4}}, color={0,127,255}));
  connect(fanCoilUnitPidTest1_1.port_b1, boundary4.ports[1]) annotation (Line(
        points={{12.2,26.4},{46,26.4},{46,31},{52,31}}, color={0,127,255}));
  connect(boundary3.ports[1], fanCoilUnitPidTest1_1.port_b2) annotation (Line(
        points={{-62,-21},{-62,-22},{-14,-22},{-14,17.4},{-8.2,17.4}}, color={0,
          127,255}));
  connect(fanCoilUnitPidTest1_1.port_a2, boundary1.ports[1]) annotation (Line(
        points={{12.6,17.4},{56,17.4},{56,1},{60,1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFCU1A;
