within CCC_test.Examples;
model DummyLoad
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  IBPSA.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dp_nominal=0,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{-2,0},{18,20}})));
  IBPSA.Fluid.Sources.MassFlowSource_T
                                  DhwSink(
    redeclare package Medium = MediumWater,
    m_flow=1,
    T=278.15,
    nPorts=1)                  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-86,4})));
  IBPSA.Fluid.Sources.Boundary_pT DhwSink1(redeclare package Medium =
        MediumWater, nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={78,2})));
  Modelica.Blocks.Sources.Constant TSetpoint2(k=10000)      annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,56})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempSen1(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,4})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpReturn1(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={42,10})));
equation
  connect(TSetpoint2.y, hea.u) annotation (Line(points={{-25,56},{-10,56},{-10,
          16},{-4,16}}, color={0,0,127}));
  connect(DhwSink.ports[1], tempSen1.port_a)
    annotation (Line(points={{-76,4},{-58,4}}, color={0,127,255}));
  connect(tempSen1.port_b, hea.port_a) annotation (Line(points={{-38,4},{-8,4},
          {-8,10},{-2,10}}, color={0,127,255}));
  connect(hea.port_b, tempHpReturn1.port_a)
    annotation (Line(points={{18,10},{32,10}}, color={0,127,255}));
  connect(tempHpReturn1.port_b, DhwSink1.ports[1]) annotation (Line(points={{52,
          10},{62,10},{62,2},{68,2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end DummyLoad;
