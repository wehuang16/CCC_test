within CCC_test.Example2;
model test_flow_routing_container

    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  test_flow_routing test_flow_routing1
    annotation (Placement(transformation(extent={{-20,-2},{0,18}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumPropyleneGlycol, nPorts=1)
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumPropyleneGlycol, nPorts=1)
    annotation (Placement(transformation(extent={{16,-30},{36,-10}})));
equation
  connect(bou.ports[1], test_flow_routing1.port_a1) annotation (Line(points={{
          -52,0},{-26,0},{-26,13},{-20.2,13}}, color={0,127,255}));
  connect(test_flow_routing1.port_b1, bou1.ports[1]) annotation (Line(points={{
          0.4,13},{42,13},{42,-20},{36,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_flow_routing_container;
