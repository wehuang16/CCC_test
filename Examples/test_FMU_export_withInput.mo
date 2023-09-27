within CCC_test.Examples;
model test_FMU_export_withInput
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
        MediumWater,                          nPorts=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={52,10})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    m_flow=0.575,
    T=303.15,                                       nPorts=1)
    annotation (Placement(transformation(extent={{-56,8},{-36,28}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = MediumWater, m_flow_nominal=0.575)
    annotation (Placement(transformation(extent={{-14,10},{6,30}})));
  Modelica.Blocks.Interfaces.RealInput T_in
    annotation (Placement(transformation(extent={{-140,2},{-100,42}})));
equation
  connect(boundary1.ports[1], temperature.port_a)
    annotation (Line(points={{-36,18},{-26,18},{-26,20},{-14,20}},
                                                 color={0,127,255}));
  connect(temperature.port_b, boundary.ports[1]) annotation (Line(points={{6,20},{
          24,20},{24,10},{42,10}},  color={0,127,255}));
  connect(boundary1.T_in, T_in)
    annotation (Line(points={{-58,22},{-120,22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end test_FMU_export_withInput;
