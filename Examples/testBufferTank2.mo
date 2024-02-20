within CCC_test.Examples;
model testBufferTank2
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  Modelica.Fluid.Sensors.TemperatureTwoPort tempSupply(redeclare package Medium =
        MediumPropyleneGlycol) annotation (Placement(transformation(extent={{-28,
            -2},{-8,18}}, rotation=0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                          fan(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
              annotation (Placement(transformation(extent={{-80,2},{-60,22}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempReturn1(redeclare package
      Medium = MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,82})));
  Modelica.Blocks.Sources.Constant const3(k=0.5)
    annotation (Placement(transformation(extent={{-82,62},{-62,82}})));
  Buildings.Fluid.Storage.Stratified tan(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    VTan=0.15,
    hTan=0.764,
    dIns=0.05,
    nSeg=2,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-4,34},{16,54}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempTanBot
    "bottom tank tempearture" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,32})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempTanTop
    "bottom tank tempearture" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={74,68})));
  Modelica.Blocks.Sources.Constant const1(k=0.3)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                          fan1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
              annotation (Placement(transformation(extent={{-48,-78},{-28,-58}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dp_nominal=10)
    annotation (Placement(transformation(extent={{-118,2},{-98,22}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-130,54},{-110,74}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-132,-54},{-112,-34}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dp_nominal=10)
    annotation (Placement(transformation(extent={{-90,-78},{-70,-58}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempReturn2(redeclare package
      Medium = MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={44,-88})));
  CCC.Controls.FlowConstraintBreaker flowConstraintBreaker(redeclare package
      Medium = MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,-94})));
equation
  connect(const3.y, fan.m_flow_in) annotation (Line(points={{-61,72},{-58,72},{
          -58,34},{-70,34},{-70,24}}, color={0,0,127}));
  connect(tan.heaPorVol[1], tempTanTop.port)
    annotation (Line(points={{6,43.85},{6,68},{64,68}}, color={191,0,0}));
  connect(tan.heaPorVol[2], tempTanBot.port) annotation (Line(points={{6,44.15},
          {6,68},{52,68},{52,32},{58,32}}, color={191,0,0}));
  connect(tempSupply.port_b, tan.port_b) annotation (Line(points={{-8,8},{0,8},
          {0,10},{16,10},{16,44}}, color={0,127,255}));
  connect(tan.port_a, tempReturn1.port_a) annotation (Line(points={{-4,44},{-12,
          44},{-12,82},{-18,82}}, color={0,127,255}));
  connect(fan.port_b, tempSupply.port_a) annotation (Line(points={{-60,12},{-34,
          12},{-34,8},{-28,8}}, color={0,127,255}));
  connect(const1.y, fan1.m_flow_in)
    annotation (Line(points={{-59,-30},{-38,-30},{-38,-56}}, color={0,0,127}));
  connect(fan1.port_b, tan.port_b) annotation (Line(points={{-28,-68},{28,-68},
          {28,44},{16,44}}, color={0,127,255}));
  connect(hea1.port_b, fan1.port_a)
    annotation (Line(points={{-70,-68},{-48,-68}}, color={0,127,255}));
  connect(const4.y, hea1.TSet) annotation (Line(points={{-111,-44},{-100,-44},{
          -100,-60},{-92,-60}}, color={0,0,127}));
  connect(const2.y, hea.TSet) annotation (Line(points={{-109,64},{-106,64},{
          -106,20},{-120,20}}, color={0,0,127}));
  connect(hea.port_b, fan.port_a)
    annotation (Line(points={{-98,12},{-80,12}}, color={0,127,255}));
  connect(tempReturn1.port_b, hea.port_a) annotation (Line(points={{-38,82},{
          -88,82},{-88,90},{-132,90},{-132,12},{-118,12}}, color={0,127,255}));
  connect(tan.port_a, tempReturn2.port_a) annotation (Line(points={{-4,44},{0,
          44},{0,-42},{62,-42},{62,-88},{54,-88}}, color={0,127,255}));
  connect(tempReturn2.port_b, flowConstraintBreaker.port_a) annotation (Line(
        points={{34,-88},{-2,-88},{-2,-95.6},{-7.6,-95.6}}, color={0,127,255}));
  connect(flowConstraintBreaker.port_b, hea1.port_a) annotation (Line(points={{
          -28,-95.6},{-96,-95.6},{-96,-68},{-90,-68}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testBufferTank2;
