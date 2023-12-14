within CCC_test.Examples;
model testHx
    replaceable package Medium2 =  Buildings.Media.Air;
  replaceable package Medium1 =  Buildings.Media.Water;


  replaceable parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.126
    "Nominal mass flow rate for Medium 1";
  replaceable parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=0.126
    "Nominal mass flow rate for Medium 2";
  replaceable parameter Modelica.Units.SI.Temperature T_a1_nominal=273.15+55
    "Nominal temperature at port a1";
  replaceable parameter Modelica.Units.SI.Temperature T_a2_nominal=273.15+20
    "Nominal temperature at port a2";
  replaceable parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=500
    "Nominal heat flow rate (positive for heat transfer from 1 to 2)";
  replaceable parameter Modelica.Units.SI.Temperature zone_temp_setpoint=273.15+20
    "Zone air temperature setpoint";
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
        Medium1,     nPorts=1)                          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={84,-22})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium1,
    use_m_flow_in=true,
    m_flow=0.2,
    T=323.15,                                       nPorts=1)
    annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = Medium1,     m_flow_nominal=0.575)
    annotation (Placement(transformation(extent={{-52,-28},{-32,-8}})));
  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=10,
    dp2_nominal=10,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_a1_nominal,
    T_a2_nominal=T_a2_nominal)
    annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));

  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(redeclare package
      Medium = Medium1,     m_flow_nominal=0.575)
    annotation (Placement(transformation(extent={{46,-30},{66,-10}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = Medium2,
    use_m_flow_in=true,
    use_T_in=true,
    m_flow=0.18,
    T=288.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={78,-72})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(redeclare package Medium =
        Medium2,   nPorts=1)                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-64})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature2(redeclare package
      Medium = Medium2,   m_flow_nominal=0.575)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,-62})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature3(redeclare package
      Medium = Medium2,   m_flow_nominal=0.575)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-34,-62})));
  Modelica.Blocks.Math.Gain        gain(k=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-92,28},{-72,48}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant const4(k=5)
    annotation (Placement(transformation(extent={{-74,58},{-54,78}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{4,-12},{24,8}})));
  Modelica.Blocks.Math.Gain        gain1(k=m2_flow_nominal)
    annotation (Placement(transformation(extent={{12,-100},{32,-80}})));
  Buildings.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-34,-100},{-14,-80}})));
  Modelica.Blocks.Sources.Constant zonAirSet(k=zone_temp_setpoint)
    annotation (Placement(transformation(extent={{-86,-100},{-66,-80}})));
  Modelica.Blocks.Sources.Ramp     zonAirSet1(
    height=3,
    duration=4320,
    offset=273.15 + 19,
    startTime=2160)
    annotation (Placement(transformation(extent={{-74,-136},{-54,-116}})));
equation
  connect(boundary1.ports[1], temperature.port_a)
    annotation (Line(points={{-64,-12},{-60,-12},{-60,-18},{-52,-18}},
                                                 color={0,127,255}));
  connect(temperature.port_b, hex.port_a1) annotation (Line(points={{-32,-18},{
          -12,-18},{-12,-24},{-6,-24}},
                                    color={0,127,255}));
  connect(hex.port_b1, temperature1.port_a) annotation (Line(points={{14,-24},{40,
          -24},{40,-20},{46,-20}}, color={0,127,255}));
  connect(temperature1.port_b, boundary.ports[1]) annotation (Line(points={{66,-20},
          {70,-20},{70,-22},{74,-22}}, color={0,127,255}));
  connect(boundary3.ports[1], temperature3.port_b) annotation (Line(points={{-70,
          -64},{-68,-64},{-68,-62},{-44,-62}}, color={0,127,255}));
  connect(temperature3.port_a, hex.port_b2) annotation (Line(points={{-24,-62},{
          -12,-62},{-12,-36},{-6,-36}}, color={0,127,255}));
  connect(hex.port_a2, temperature2.port_b) annotation (Line(points={{14,-36},{30,
          -36},{30,-62},{36,-62}}, color={0,127,255}));
  connect(temperature2.port_a, boundary2.ports[1]) annotation (Line(points={{56,
          -62},{62,-62},{62,-72},{68,-72}}, color={0,127,255}));
  connect(const4.y, conPID.u_s) annotation (Line(points={{-53,68},{-32,68},{-32,
          50},{-22,50}}, color={0,0,127}));
  connect(gain.y, boundary1.m_flow_in) annotation (Line(points={{-71,38},{-68,38},
          {-68,52},{-104,52},{-104,-4},{-84,-4}}, color={0,0,127}));
  connect(conPID.y, gain.u) annotation (Line(points={{1,50},{6,50},{6,24},{-100,
          24},{-100,30},{-102,30},{-102,38},{-94,38}}, color={0,0,127}));
  connect(temperature.T, add.u1) annotation (Line(points={{-42,-7},{-42,12},{2,
          12},{2,4}},
                  color={0,0,127}));
  connect(temperature1.T, add.u2) annotation (Line(points={{56,-9},{28,-9},{28,-16},
          {2,-16},{2,-8}}, color={0,0,127}));
  connect(add.y, conPID.u_m) annotation (Line(points={{25,-2},{28,-2},{28,28},{-10,
          28},{-10,38}}, color={0,0,127}));
  connect(gain1.y, boundary2.m_flow_in)
    annotation (Line(points={{33,-90},{88,-90},{88,-80}}, color={0,0,127}));
  connect(conPID1.y, gain1.u)
    annotation (Line(points={{-13,-90},{10,-90}}, color={0,0,127}));
  connect(zonAirSet.y, conPID1.u_s)
    annotation (Line(points={{-65,-90},{-36,-90}}, color={0,0,127}));
  connect(zonAirSet1.y, conPID1.u_m) annotation (Line(points={{-53,-126},{-24,
          -126},{-24,-102}}, color={0,0,127}));
  connect(zonAirSet1.y, boundary2.T_in) annotation (Line(points={{-53,-126},{52,
          -126},{52,-134},{130,-134},{130,-76},{90,-76}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testHx;
