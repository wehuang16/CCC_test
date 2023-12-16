within CCC_test.Examples;
model testPump
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={66,7})));
  Modelica.Fluid.Sources.Boundary_pT      hpPump(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,14})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{-36,48},{-16,68}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpFcuWaterSupply(redeclare
      package Medium = MediumWater, m_flow_nominal=0.136)
                                                  "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-8,8})));
equation
  connect(const5.y, pumpFcuWaterSupply.m_flow_in)
    annotation (Line(points={{-15,58},{-8,58},{-8,20}}, color={0,0,127}));
  connect(hpPump.ports[1], pumpFcuWaterSupply.port_a) annotation (Line(points={
          {-64,14},{-24,14},{-24,8},{-18,8}}, color={0,127,255}));
  connect(pumpFcuWaterSupply.port_b, boundary2.ports[1])
    annotation (Line(points={{2,8},{32,8},{32,7},{56,7}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPump;
