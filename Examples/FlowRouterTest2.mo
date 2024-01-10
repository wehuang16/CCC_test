within CCC_test.Examples;
model FlowRouterTest2
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-66,14},{-46,34}})));
  CCC.Controls.FlowRouterSupply flowRouter(redeclare package Medium1 =
        MediumWater)
    annotation (Placement(transformation(extent={{0,8},{20,28}})));
  Modelica.Fluid.Sources.Boundary_pT      hpPump(
    redeclare package Medium = MediumWater,
    use_T_in=false,
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
  Modelica.Fluid.Sources.Boundary_pT      hpPump1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,-56})));
  Modelica.Fluid.Sources.Boundary_pT      hpPump2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,-92})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        MediumWater, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{34,30},{54,50}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium =
        MediumWater, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{38,-16},{58,4}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{10,72},{30,92}})));
  Modelica.Blocks.Sources.Constant const3(k=0.5)
    annotation (Placement(transformation(extent={{8,-34},{28,-14}})));
equation
  connect(const1.y, flowRouter.u) annotation (Line(points={{-37,64},{-10,64},{
          -10,26.7},{-2,26.7}}, color={0,0,127}));
  connect(const1.y, flowRouter.u1) annotation (Line(points={{-37,64},{-10,64},{
          -10,22.9},{-2.2,22.9}}, color={0,0,127}));
  connect(const.y, flowRouter.u2) annotation (Line(points={{-45,24},{-12,24},{
          -12,19.1},{-2,19.1}}, color={0,0,127}));
  connect(hpPump.ports[1], flowRouter.port_a) annotation (Line(points={{-48,-12},
          {-10,-12},{-10,15.8},{-0.6,15.8}}, color={0,127,255}));
  connect(hpPump1.ports[1], flowRouter.port_a1) annotation (Line(points={{-46,
          -56},{-0.4,-56},{-0.4,13.4}}, color={0,127,255}));
  connect(hpPump2.ports[1], flowRouter.port_a2) annotation (Line(points={{-46,
          -92},{-42,-92},{-42,-70},{-70,-70},{-70,-26},{-6,-26},{-6,10},{-0.4,
          10}}, color={0,127,255}));
  connect(flowRouter.port_b, fan.port_a) annotation (Line(points={{20.4,24.4},{
          30,24.4},{30,40},{34,40}}, color={0,127,255}));
  connect(fan.port_b, boundary.ports[1]) annotation (Line(points={{54,40},{72,
          40},{72,33},{78,33}}, color={0,127,255}));
  connect(flowRouter.port_b1, fan1.port_a) annotation (Line(points={{20.6,13.8},
          {34,13.8},{34,-6},{38,-6}}, color={0,127,255}));
  connect(fan1.port_b, boundary1.ports[1]) annotation (Line(points={{58,-6},{60,
          -6},{60,-5},{78,-5}}, color={0,127,255}));
  connect(const3.y, fan1.m_flow_in) annotation (Line(points={{29,-24},{32,-24},
          {32,-6},{36,-6},{36,16},{48,16},{48,6}}, color={0,0,127}));
  connect(const2.y, fan.m_flow_in)
    annotation (Line(points={{31,82},{44,82},{44,52}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end FlowRouterTest2;
