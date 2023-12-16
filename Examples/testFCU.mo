within CCC_test.Examples;
model testFCU
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  CCC.Fluid.HeatExchangers.BaseClasses.FanCoilUnitPid
                                                   fanCoilUnitPid(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    T_a1_nominal=328.15,
    T_a2_nominal=288.15,
    zone_temp_setpoint=291.15)
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
    T=285.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{76,-4},{56,14}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{72,22},{52,40}})));
  Modelica.Blocks.Sources.Constant const1(k=0.5)
    annotation (Placement(transformation(extent={{-48,54},{-28,74}})));
  Modelica.Blocks.Sources.Constant const2(k=0.3)
    annotation (Placement(transformation(extent={{-94,-54},{-74,-34}})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{98,-184},{118,-164}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=3,
    duration=4320,
    offset=273.15 + 17,
    startTime=2160)
    annotation (Placement(transformation(extent={{-54,-40},{-34,-20}})));
equation
  connect(boundary2.ports[1], fanCoilUnitPid.port_a1) annotation (Line(points={
          {-46,33},{-24,33},{-24,26.4},{-8.2,26.4}}, color={0,127,255}));
  connect(fanCoilUnitPid.port_b1, boundary4.ports[1]) annotation (Line(points={
          {12.2,26.4},{46,26.4},{46,31},{52,31}}, color={0,127,255}));
  connect(boundary3.ports[1], fanCoilUnitPid.port_a2) annotation (Line(points={
          {56,5},{14,5},{14,16.8},{12.2,16.8}}, color={0,127,255}));
  connect(fanCoilUnitPid.port_b2, boundary1.ports[1]) annotation (Line(points={
          {-8.2,17},{-48,17},{-48,1},{-52,1}}, color={0,127,255}));
  connect(ramp.y, fanCoilUnitPid.zonAirTem) annotation (Line(points={{-33,-30},
          {-18,-30},{-18,13.2},{-10,13.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFCU;
