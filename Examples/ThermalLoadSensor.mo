within CCC_test.Examples;
model ThermalLoadSensor
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
        origin={-88,-2})));
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
  Buildings.Fluid.Sensors.MassFlowRate MassFlow(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-62,-8},{-42,12}})));
  IBPSA.Fluid.Sources.MassFlowSource_T
                                  sou1(
    redeclare package Medium = MediumAir,
    use_m_flow_in=false,
    m_flow=1,
    T=293.15,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-74,-84})));
  Buildings.Fluid.HeatExchangers.Heater_T hea1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-24,-92},{-4,-72}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 21)
    annotation (Placement(transformation(extent={{-72,-68},{-52,-48}})));
  IBPSA.Fluid.Sources.Boundary_pT DhwSink1(redeclare package Medium = MediumAir,
      nPorts=1)                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={64,-88})));
  Modelica.Blocks.Math.Gain HeatCapacity(k=1)
    annotation (Placement(transformation(extent={{4,-68},{24,-48}})));
  Modelica.Blocks.Math.Add deltaT(k2=-1)
    annotation (Placement(transformation(extent={{58,-50},{78,-30}})));
  Modelica.Blocks.Math.MultiProduct Q_flow_calculated(nu=3)
    annotation (Placement(transformation(extent={{126,-44},{138,-32}})));
equation
  connect(const.y, hea.TSet) annotation (Line(points={{-75,40},{-6,40},{-6,12},
          {2,12}}, color={0,0,127}));
  connect(hea.port_b, senTem1.port_a)
    annotation (Line(points={{24,4},{28,4},{28,0},{36,0}}, color={0,127,255}));
  connect(senTem1.port_b, DhwSink.ports[1]) annotation (Line(points={{56,0},{74,
          0},{74,-4},{82,-4}}, color={0,127,255}));
  connect(senTem.port_b, hea.port_a)
    annotation (Line(points={{-12,2},{-12,4},{4,4}}, color={0,127,255}));
  connect(sou.ports[1], MassFlow.port_a) annotation (Line(points={{-78,-2},{-70,
          -2},{-70,2},{-62,2}}, color={0,127,255}));
  connect(MassFlow.port_b, senTem.port_a)
    annotation (Line(points={{-42,2},{-32,2}}, color={0,127,255}));
  connect(const1.y, hea1.TSet) annotation (Line(points={{-51,-58},{-34,-58},{
          -34,-74},{-26,-74}}, color={0,0,127}));
  connect(sou1.ports[1], hea1.port_a) annotation (Line(points={{-64,-84},{-62,
          -84},{-62,-82},{-24,-82}}, color={0,127,255}));
  connect(hea1.port_b, DhwSink1.ports[1]) annotation (Line(points={{-4,-82},{28,
          -82},{28,-88},{54,-88}}, color={0,127,255}));
  connect(hea1.Q_flow, HeatCapacity.u) annotation (Line(points={{-3,-74},{-3,
          -68},{2,-68},{2,-58}}, color={0,0,127}));
  connect(senTem1.T, deltaT.u1) annotation (Line(points={{46,11},{60,11},{60,
          -24},{44,-24},{44,-34},{56,-34}}, color={0,0,127}));
  connect(senTem.T, deltaT.u2) annotation (Line(points={{-22,13},{-20,13},{-20,
          10},{56,10},{56,-46}}, color={0,0,127}));
  connect(deltaT.y, Q_flow_calculated.u[1]) annotation (Line(points={{79,-40},{
          79,-39.4},{126,-39.4}}, color={0,0,127}));
  connect(HeatCapacity.y, Q_flow_calculated.u[2]) annotation (Line(points={{25,
          -58},{74,-58},{74,-52},{126,-52},{126,-38}}, color={0,0,127}));
  connect(MassFlow.m_flow, Q_flow_calculated.u[3]) annotation (Line(points={{
          -52,13},{-50,13},{-50,30},{114,30},{114,-36.6},{126,-36.6}}, color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ThermalLoadSensor;
