within CCC_test.Examples;
model NonArisMultiFamilyTest2
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-64,18},{-44,38}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-62,-24},{-42,-4}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 45)
    annotation (Placement(transformation(extent={{-16,70},{4,90}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 5)
    annotation (Placement(transformation(extent={{24,-54},{44,-34}})));
  Buildings.Fluid.Sources.MassFlowSource_T           freshAirCor(
    redeclare package Medium = MediumAir,
    m_flow=0.2,
    T=283.15,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={84,16})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-80,5})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={84,41})));
  Buildings.Fluid.Sources.MassFlowSource_T           freshAirCor1(
    redeclare package Medium = MediumAir,
    m_flow=0.3,
    T=306.15,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-62,54})));
  Buildings.Fluid.HeatPumps.Carnot_TCon
    heaPum(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    QCon_flow_nominal=2000,
    TCon_nominal=333.15,
    TEva_nominal=293.15,
    dp1_nominal=5,
    dp2_nominal=5)
    annotation (Placement(transformation(extent={{-2,20},{18,44}})));
equation
  connect(freshAirCor1.ports[1], heaPum.port_a1)
    annotation (Line(points={{-52,54},{-2,54},{-2,39.2}}, color={0,127,255}));
  connect(heaPum.port_b1, boundary2.ports[1]) annotation (Line(points={{18,39.2},
          {68,39.2},{68,41},{74,41}}, color={0,127,255}));
  connect(boundary1.ports[1], heaPum.port_b2) annotation (Line(points={{-70,5},{
          -70,4},{-12,4},{-12,24.8},{-2,24.8}}, color={0,127,255}));
  connect(heaPum.port_a2, freshAirCor.ports[1]) annotation (Line(points={{18,24.8},
          {68,24.8},{68,16},{74,16}}, color={0,127,255}));
  connect(heaPum.TSet, const1.y)
    annotation (Line(points={{-4,42.8},{-4,80},{5,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=300,
      __Dymola_Algorithm="Dassl"));
end NonArisMultiFamilyTest2;
