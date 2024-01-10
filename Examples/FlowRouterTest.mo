within CCC_test.Examples;
model FlowRouterTest
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;



  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-66,14},{-46,34}})));
  CCC.Controls.FlowRouterSupply flowRouter(redeclare package Medium1 =
        MediumWater)
    annotation (Placement(transformation(extent={{0,8},{20,28}})));
  Modelica.Fluid.Sources.MassFlowSource_T hpPump(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.5,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-58,-12})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{98,24},{78,42}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{98,-14},{78,4}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-58,54},{-38,74}})));
  Modelica.Fluid.Sources.MassFlowSource_T hpPump1(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.5,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,-56})));
  Modelica.Fluid.Sources.MassFlowSource_T hpPump2(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.5,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-16,-92})));
equation
  connect(flowRouter.port_b, boundary.ports[1]) annotation (Line(points={{20.4,
          24.4},{72,24.4},{72,33},{78,33}}, color={0,127,255}));
  connect(flowRouter.port_b1, boundary1.ports[1]) annotation (Line(points={{
          20.6,13.8},{74,13.8},{74,-5},{78,-5}}, color={0,127,255}));
  connect(const1.y, flowRouter.u) annotation (Line(points={{-37,64},{-10,64},{
          -10,26.7},{-2,26.7}}, color={0,0,127}));
  connect(const1.y, flowRouter.u1) annotation (Line(points={{-37,64},{-10,64},{
          -10,22.9},{-2.2,22.9}}, color={0,0,127}));
  connect(const.y, flowRouter.u2) annotation (Line(points={{-45,24},{-12,24},{
          -12,19.1},{-2,19.1}}, color={0,0,127}));
  connect(hpPump.ports[1], flowRouter.port_a) annotation (Line(points={{-48,-12},
          {-10,-12},{-10,15.8},{-0.6,15.8}}, color={0,127,255}));
  connect(hpPump1.ports[1], flowRouter.port_a1) annotation (Line(points={{-24,
          -56},{-4,-56},{-4,13.4},{-0.4,13.4}}, color={0,127,255}));
  connect(hpPump2.ports[1], flowRouter.port_a2) annotation (Line(points={{-6,
          -92},{-2,-92},{-2,4},{-0.4,4},{-0.4,10}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end FlowRouterTest;
