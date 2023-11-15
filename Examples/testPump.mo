within CCC_test.Examples;
model testPump
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Buildings.Fluid.Movers.FlowControlled_m_flow fanFcuAirSupply1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=8*51*1.2/3600,
    nominalValuesDefineDefaultPressureCurve=true) "Fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,4})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={66,7})));
  Modelica.Fluid.Sources.Boundary_pT      hpPump(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-76,10})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{-36,48},{-16,68}})));
equation
  connect(hpPump.ports[1], fanFcuAirSupply1.port_a) annotation (Line(points={{
          -66,10},{-14,10},{-14,4},{-8,4}}, color={0,127,255}));
  connect(fanFcuAirSupply1.port_b, boundary2.ports[1])
    annotation (Line(points={{12,4},{50,4},{50,7},{56,7}}, color={0,127,255}));
  connect(const5.y, fanFcuAirSupply1.m_flow_in)
    annotation (Line(points={{-15,58},{2,58},{2,16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testPump;
