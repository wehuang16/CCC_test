within CCC_test.Examples;
model ThermalLoadSensor2
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{4,-6},{24,14}})));
  IBPSA.Fluid.Sources.MassFlowSource_T
                                  sou(
    redeclare package Medium = MediumAir,
    use_m_flow_in=false,
    m_flow=0.1,
    T=285.15,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-100,-4})));
  IBPSA.Fluid.Sources.Boundary_pT DhwSink(redeclare package Medium = MediumAir,
      nPorts=1)                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={92,-4})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 40)
    annotation (Placement(transformation(extent={{-96,30},{-76,50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-32,-8},{-12,12}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  CCC.Controls.EnergyFlowSensor energyFlowSensor(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-70,-14},{-50,6}})));
equation
  connect(const.y, hea.TSet) annotation (Line(points={{-75,40},{-6,40},{-6,12},
          {2,12}}, color={0,0,127}));
  connect(hea.port_b, senTem1.port_a)
    annotation (Line(points={{24,4},{28,4},{28,0},{36,0}}, color={0,127,255}));
  connect(senTem1.port_b, DhwSink.ports[1]) annotation (Line(points={{56,0},{74,
          0},{74,-4},{82,-4}}, color={0,127,255}));
  connect(senTem.port_b, hea.port_a)
    annotation (Line(points={{-12,2},{-12,4},{4,4}}, color={0,127,255}));
  connect(sou.ports[1], energyFlowSensor.port_a) annotation (Line(points={{-90,
          -4},{-80.1,-4},{-80.1,-4.4},{-70.2,-4.4}}, color={0,127,255}));
  connect(energyFlowSensor.port_b, senTem.port_a) annotation (Line(points={{
          -49.8,-4.4},{-38,-4},{-38,2},{-32,2}}, color={0,127,255}));
  connect(senTem1.T, energyFlowSensor.TempSupply) annotation (Line(points={{46,
          11},{46,22},{-59.8,22},{-59.8,7.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ThermalLoadSensor2;
