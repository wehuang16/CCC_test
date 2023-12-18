within CCC_test.Examples;
model testFCU
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  FanCoilUnitTest1                                 fanCoilUnitTest1_1(
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
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-62,1})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{76,-4},{56,14}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{72,22},{52,40}})));
  Modelica.Blocks.Sources.Constant const1(k=0.06389)
    annotation (Placement(transformation(extent={{-62,54},{-42,74}})));
  Modelica.Blocks.Sources.Constant const2(k=0.05333)
    annotation (Placement(transformation(extent={{-48,-34},{-28,-14}})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{98,-184},{118,-164}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=3,
    duration=4320,
    offset=273.15 + 17,
    startTime=2160)
    annotation (Placement(transformation(extent={{-50,-68},{-30,-48}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{14,-52},{34,-32}})));
  Modelica.Blocks.Sources.Constant const3(k=1007)
    annotation (Placement(transformation(extent={{8,-92},{28,-72}})));
  Modelica.Blocks.Math.MultiProduct heatTransfer(nu=3)
    annotation (Placement(transformation(extent={{58,-76},{70,-64}})));
equation
  connect(boundary2.ports[1], fanCoilUnitTest1_1.port_a1) annotation (Line(
        points={{-46,33},{-24,33},{-24,26.4},{-8.2,26.4}}, color={0,127,255}));
  connect(fanCoilUnitTest1_1.port_b1, boundary4.ports[1]) annotation (Line(
        points={{12.2,26.4},{46,26.4},{46,31},{52,31}}, color={0,127,255}));
  connect(boundary3.ports[1], fanCoilUnitTest1_1.port_a2) annotation (Line(
        points={{56,5},{14,5},{14,16.8},{12.2,16.8}}, color={0,127,255}));
  connect(fanCoilUnitTest1_1.port_b2, boundary1.ports[1]) annotation (Line(
        points={{-8.2,17},{-48,17},{-48,1},{-52,1}}, color={0,127,255}));
  connect(const1.y, fanCoilUnitTest1_1.WaterMassFlow) annotation (Line(points={
          {-41,64},{-18,64},{-18,29.8},{-10,29.8}}, color={0,0,127}));
  connect(const2.y, fanCoilUnitTest1_1.AirMassFlow) annotation (Line(points={{
          -27,-24},{-18,-24},{-18,13.2},{-10,13.2}}, color={0,0,127}));
  connect(fanCoilUnitTest1_1.TempAirReturn, add.u1)
    annotation (Line(points={{-3.4,11},{-3.4,-36},{12,-36}}, color={0,0,127}));
  connect(fanCoilUnitTest1_1.TempAirSupply, add.u2)
    annotation (Line(points={{5.6,11},{5.6,-48},{12,-48}}, color={0,0,127}));
  connect(add.y, heatTransfer.u[1]) annotation (Line(points={{35,-42},{52,-42},
          {52,-71.4},{58,-71.4}}, color={0,0,127}));
  connect(const3.y, heatTransfer.u[2]) annotation (Line(points={{29,-82},{50,
          -82},{50,-70},{58,-70}}, color={0,0,127}));
  connect(const2.y, heatTransfer.u[3]) annotation (Line(points={{-27,-24},{-6,
          -24},{-6,-62},{52,-62},{52,-68.6},{58,-68.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFCU;
