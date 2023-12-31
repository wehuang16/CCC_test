within CCC_test.Examples;
model testFCU2
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnitEps(
    redeclare package Medium1 = MediumPropyleneGlycol,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.06393,
    dp1_nominal(displayUnit="Pa") = 2481,
    m2_flow_nominal=0.07589,
    T_a1_nominal=323.15,
    T_a2_nominal=293.15,
    Q_flow_nominal=1324)
    annotation (Placement(transformation(extent={{-8,14},{12,34}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-86,39})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumPropyleneGlycol,
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
  Modelica.Blocks.Sources.Constant const1(k=0.06393)
    annotation (Placement(transformation(extent={{-76,64},{-56,84}})));
  Modelica.Blocks.Sources.Constant const2(k=0.07589)
    annotation (Placement(transformation(extent={{-86,-92},{-66,-72}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{62,-66},{74,-54}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{22,-36},{42,-16}})));
  Modelica.Blocks.Sources.Constant const3(k=1007)
    annotation (Placement(transformation(extent={{-4,-56},{16,-36}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-0.3,
    duration=4320,
    offset=0.8,
    startTime=2160)
    annotation (Placement(transformation(extent={{-98,2},{-78,22}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{18,70},{38,90}})));
  Modelica.Blocks.Math.Division effectiveness
    annotation (Placement(transformation(extent={{144,60},{164,80}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{20,38},{40,58}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{132,18},{152,38}})));
  Modelica.Blocks.Sources.Constant const4(k=1)
    annotation (Placement(transformation(extent={{102,-28},{122,-8}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{92,12},{112,32}})));
equation
  connect(fanCoilUnitEps.port_b1, boundary4.ports[1]) annotation (Line(points={{12.2,
          28.4},{46,28.4},{46,31},{52,31}},       color={0,127,255}));
  connect(boundary3.ports[1], fanCoilUnitEps.port_b2) annotation (Line(points={{-62,-21},
          {-62,-22},{-14,-22},{-14,19},{-8.2,19}},           color={0,127,255}));
  connect(fanCoilUnitEps.port_a2, boundary1.ports[1]) annotation (Line(points={{12.2,
          18.8},{56,18.8},{56,1},{60,1}},       color={0,127,255}));
  connect(const1.y, fanCoilUnitEps.WaterMassFlow) annotation (Line(points={{-55,74},
          {-18,74},{-18,31.8},{-10,31.8}},     color={0,0,127}));
  connect(const2.y, fanCoilUnitEps.AirMassFlow) annotation (Line(points={{-65,-82},
          {-16,-82},{-16,6},{-18,6},{-18,15.2},{-10,15.2}},      color={0,0,127}));
  connect(fanCoilUnitEps.TempAirReturn, add.u1)
    annotation (Line(points={{-3.4,13},{-3.4,-20},{20,-20}}, color={0,0,127}));
  connect(fanCoilUnitEps.TempAirSupply, add.u2)
    annotation (Line(points={{5.6,13},{5.6,-32},{20,-32}}, color={0,0,127}));
  connect(add.y, multiProduct.u[1]) annotation (Line(points={{43,-26},{56,-26},
          {56,-61.4},{62,-61.4}}, color={0,0,127}));
  connect(const2.y, multiProduct.u[2]) annotation (Line(points={{-65,-82},{-16,
          -82},{-16,-64},{56,-64},{56,-60},{62,-60}},
                                   color={0,0,127}));
  connect(const3.y, multiProduct.u[3]) annotation (Line(points={{17,-46},{56,-46},
          {56,-58.6},{62,-58.6}},      color={0,0,127}));
  connect(add1.y, effectiveness.u1) annotation (Line(points={{39,80},{132,80},{132,
          76},{142,76}}, color={0,0,127}));
  connect(fanCoilUnitEps.TempAirReturn, add1.u1)
    annotation (Line(points={{-3.4,13},{-3.4,86},{16,86}}, color={0,0,127}));
  connect(fanCoilUnitEps.TempAirSupply, add1.u2)
    annotation (Line(points={{5.6,13},{5.6,74},{16,74}}, color={0,0,127}));
  connect(fanCoilUnitEps.TempAirSupply, add2.u2)
    annotation (Line(points={{5.6,13},{5.6,42},{18,42}}, color={0,0,127}));
  connect(fanCoilUnitEps.TempWaterSupply, add2.u1)
    annotation (Line(points={{-3,35},{0,35},{0,54},{18,54}}, color={0,0,127}));
  connect(add2.y, switch1.u1) annotation (Line(points={{41,48},{122,48},{122,36},
          {130,36}}, color={0,0,127}));
  connect(switch1.y, effectiveness.u2) annotation (Line(points={{153,28},{148,28},
          {148,64},{142,64}}, color={0,0,127}));
  connect(const4.y, switch1.u3) annotation (Line(points={{123,-18},{136,-18},{136,
          12},{130,12},{130,20}}, color={0,0,127}));
  connect(add2.y, greaterThreshold.u) annotation (Line(points={{41,48},{80,48},{
          80,22},{90,22}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{113,22},{120,
          22},{120,28},{130,28}}, color={255,0,255}));
  connect(boundary2.ports[1], fanCoilUnitEps.port_a1) annotation (Line(points={{
          -76,39},{-20,39},{-20,28.4},{-8.2,28.4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFCU2;
