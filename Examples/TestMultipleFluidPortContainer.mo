within CCC_test.Examples;
model TestMultipleFluidPortContainer

      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  TestMultipleFluidPort testMultipleFluidPort(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-6,-4},{14,16}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumAir,
    m_flow=1,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(extent={{-84,6},{-64,26}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumAir,
    m_flow=1,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-72,-32},{-52,-12}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = MediumAir,
      nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={94,-2})));
  Buildings.Fluid.Sensors.TemperatureTwoPort DoubleTempSensor[2](redeclare
      package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{42,-6},{62,14}})));
equation
  connect(boundary.ports[1], testMultipleFluidPort.port_a[1]) annotation (Line(
        points={{-64,16},{-10,16},{-10,5.75},{-6.4,5.75}}, color={0,127,255}));
  connect(boundary1.ports[1], testMultipleFluidPort.port_a[2]) annotation (Line(
        points={{-52,-22},{-10,-22},{-10,6.25},{-6.4,6.25}}, color={0,127,255}));
  connect(testMultipleFluidPort.port_b, DoubleTempSensor.port_a)
    annotation (Line(points={{14.4,6},{14.4,4},{42,4}}, color={0,127,255}));
  connect(DoubleTempSensor.port_b, bou.ports) annotation (Line(points={{62,4},{
          78,4},{78,-2},{84,-2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestMultipleFluidPortContainer;
