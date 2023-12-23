within CCC_test.Examples;
model testFCU2
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  CCC.Fluid.HeatExchangers.BaseClasses.FanCoilUnit
                       fanCoilUnitPidTest1_1(
    redeclare package Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.1222,
    dp1_nominal(displayUnit="Pa") = 7742,
    m2_flow_nominal=0.07589,
    T_a1_nominal=343.15,
    T_a2_nominal=293.15,
    Q_flow_nominal=2463)
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-56,33})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
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
  Modelica.Blocks.Sources.Constant const1(k=0.07059)
    annotation (Placement(transformation(extent={{-74,64},{-54,84}})));
  Modelica.Blocks.Sources.Constant const2(k=0.07589)
    annotation (Placement(transformation(extent={{-82,-74},{-62,-54}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{62,-66},{74,-54}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{22,-36},{42,-16}})));
  Modelica.Blocks.Sources.Constant const3(k=1007)
    annotation (Placement(transformation(extent={{-4,-60},{16,-40}})));
equation
  connect(boundary2.ports[1], fanCoilUnitPidTest1_1.port_a1) annotation (Line(
        points={{-46,33},{-24,33},{-24,26.4},{-8.2,26.4}}, color={0,127,255}));
  connect(fanCoilUnitPidTest1_1.port_b1, boundary4.ports[1]) annotation (Line(
        points={{12.2,26.4},{46,26.4},{46,31},{52,31}}, color={0,127,255}));
  connect(boundary3.ports[1], fanCoilUnitPidTest1_1.port_b2) annotation (Line(
        points={{-62,-21},{-62,-22},{-14,-22},{-14,17},{-8.2,17}},     color={0,
          127,255}));
  connect(fanCoilUnitPidTest1_1.port_a2, boundary1.ports[1]) annotation (Line(
        points={{12.2,16.8},{56,16.8},{56,1},{60,1}}, color={0,127,255}));
  connect(const1.y, fanCoilUnitPidTest1_1.WaterMassFlow) annotation (Line(
        points={{-53,74},{-18,74},{-18,29.8},{-10,29.8}}, color={0,0,127}));
  connect(const2.y, fanCoilUnitPidTest1_1.AirMassFlow) annotation (Line(points=
          {{-61,-64},{-10,-64},{-10,13.2}}, color={0,0,127}));
  connect(fanCoilUnitPidTest1_1.TempAirReturn, add.u1)
    annotation (Line(points={{-3.4,11},{-3.4,-20},{20,-20}}, color={0,0,127}));
  connect(fanCoilUnitPidTest1_1.TempAirSupply, add.u2)
    annotation (Line(points={{5.6,11},{5.6,-32},{20,-32}}, color={0,0,127}));
  connect(add.y, multiProduct.u[1]) annotation (Line(points={{43,-26},{56,-26},
          {56,-61.4},{62,-61.4}}, color={0,0,127}));
  connect(const2.y, multiProduct.u[2]) annotation (Line(points={{-61,-64},{56,
          -64},{56,-60},{62,-60}}, color={0,0,127}));
  connect(const3.y, multiProduct.u[3]) annotation (Line(points={{17,-50},{56,
          -50},{56,-58.6},{62,-58.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFCU2;
