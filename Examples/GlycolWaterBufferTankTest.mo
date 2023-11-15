within CCC_test.Examples;
model GlycolWaterBufferTankTest
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.2,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{18,24},{38,44}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{92,24},{72,42}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-84,58},{-64,78}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=313.15,
    fluidVolume=0.1,
    nPorts=2) annotation (Placement(transformation(extent={{-32,18},{-12,38}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{56,-38},{76,-18}})));
equation
  connect(boundary.ports[1], conservationEquation.ports[1]) annotation (Line(
        points={{-66,30},{-52,30},{-52,-2},{-23,-2},{-23,18}}, color={0,127,255}));
  connect(conservationEquation.ports[2], tempTankOutlet.port_a) annotation (
      Line(points={{-21,18},{-20,18},{-20,-4},{10,-4},{10,34},{18,34}}, color={
          0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_a) annotation (Line(points={{38,
          34},{50,34},{50,-28},{56,-28}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary1.ports[1]) annotation (Line(points={{76,
          -28},{80,-28},{80,20},{68,20},{68,33},{72,33}}, color={0,127,255}));
  connect(const6.y, conservationEquation.Q_flow) annotation (Line(points={{-63,
          68},{-44,68},{-44,34},{-34,34}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GlycolWaterBufferTankTest;
