within CCC_test.Examples;
model VariablePrimary
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium
      = MediumPropyleneGlycol)         "Pressure difference across resistance"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={2,-6})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=100)
    annotation (Placement(transformation(extent={{50,4},{70,24}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=100)
    annotation (Placement(transformation(extent={{56,-32},{76,-12}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_p_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{26,-94},{6,-76}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={38,-59})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,22})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,-48})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-62,-48})));
  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={24,20})));
  Buildings.Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
        MediumPropyleneGlycol, addPowerToMedium=false) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-118,30})));
  Modelica.Blocks.Sources.Constant const(final k=273.15 + 45)
    annotation (Placement(transformation(extent={{-72,76},{-54,94}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{102,8},{122,28}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{92,-32},{112,-12}})));
  Buildings.Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={112,-66})));
  Modelica.Blocks.Sources.Constant const1(final k=273.15 + 30)
    annotation (Placement(transformation(extent={{72,-8},{90,10}})));
  Modelica.Blocks.Sources.Constant const2(final k=273.15 + 20)
    annotation (Placement(transformation(extent={{58,72},{76,90}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium
      = MediumPropyleneGlycol, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={68,-64})));
  Buildings.Fluid.Sensors.Pressure senPre(redeclare package Medium =
        MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,-92})));
  Modelica.Blocks.Sources.Constant const3(final k=0.6)
    annotation (Placement(transformation(extent={{-164,62},{-146,80}})));
  Modelica.Blocks.Sources.Constant const4(final k=0.5)
    annotation (Placement(transformation(extent={{24,46},{42,64}})));
  Modelica.Blocks.Sources.Constant const5(final k=0.8)
    annotation (Placement(transformation(extent={{12,-44},{30,-26}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-86,-90},{-66,-70}})));
  Modelica.Blocks.Sources.Constant const6(final k=0.1)
    annotation (Placement(transformation(extent={{-158,-84},{-140,-66}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-32,-12})));
equation
  connect(jun2.port_2, senMasFlo.port_a)
    annotation (Line(points={{-40,-48},{-52,-48}}, color={0,127,255}));
  connect(hea.port_b, jun1.port_1) annotation (Line(points={{-70,30},{-46,30},{
          -46,22},{-40,22}}, color={0,127,255}));
  connect(jun1.port_2, jun3.port_1) annotation (Line(points={{-20,22},{-18,22},
          {-18,20},{14,20}}, color={0,127,255}));
  connect(jun3.port_2, val.port_a) annotation (Line(points={{34,20},{46,20},{46,
          14},{50,14}}, color={0,127,255}));
  connect(jun3.port_3, val1.port_a)
    annotation (Line(points={{24,10},{24,-22},{56,-22}}, color={0,127,255}));
  connect(jun1.port_2, senRelPre.port_a)
    annotation (Line(points={{-20,22},{2,22},{2,4}}, color={0,127,255}));
  connect(senRelPre.port_b, jun2.port_1)
    annotation (Line(points={{2,-16},{2,-48},{-20,-48}}, color={0,127,255}));
  connect(senMasFlo.port_b, fan1.port_a) annotation (Line(points={{-72,-48},{
          -134,-48},{-134,-46},{-148,-46},{-148,30},{-128,30}}, color={0,127,
          255}));
  connect(fan1.port_b, hea.port_a)
    annotation (Line(points={{-108,30},{-90,30}}, color={0,127,255}));
  connect(const.y, hea.TSet) annotation (Line(points={{-53.1,85},{-50,85},{-50,
          46},{-92,46},{-92,38}}, color={0,0,127}));
  connect(val.port_b, hea1.port_a) annotation (Line(points={{70,14},{96,14},{96,
          18},{102,18}}, color={0,127,255}));
  connect(val1.port_b, hea2.port_a)
    annotation (Line(points={{76,-22},{92,-22}}, color={0,127,255}));
  connect(hea2.port_b, jun4.port_3) annotation (Line(points={{112,-22},{116,-22},
          {116,-56},{112,-56}}, color={0,127,255}));
  connect(hea1.port_b, jun4.port_1) annotation (Line(points={{122,18},{126,18},
          {126,-66},{122,-66}}, color={0,127,255}));
  connect(const1.y, hea2.TSet) annotation (Line(points={{90.9,1},{90.9,-6.5},{
          90,-6.5},{90,-14}}, color={0,0,127}));
  connect(const2.y, hea1.TSet) annotation (Line(points={{76.9,81},{92,81},{92,
          26},{100,26}}, color={0,0,127}));
  connect(TWatRet.port_a, jun4.port_2) annotation (Line(points={{78,-64},{80,
          -64},{80,-66},{102,-66}}, color={0,127,255}));
  connect(TWatRet.port_b, boundary1.ports[1])
    annotation (Line(points={{58,-64},{48,-64},{48,-59}}, color={0,127,255}));
  connect(TWatRet.T, boundary2.T_in) annotation (Line(points={{68,-75},{68,
          -81.4},{28,-81.4}}, color={0,0,127}));
  connect(boundary2.ports[1], jun2.port_1) annotation (Line(points={{6,-85},{6,
          -86},{-10,-86},{-10,-48},{-20,-48}}, color={0,127,255}));
  connect(jun4.port_2, senPre.port)
    annotation (Line(points={{102,-66},{86,-66},{86,-82}}, color={0,127,255}));
  connect(senPre.p, boundary2.p_in) annotation (Line(points={{75,-92},{64,-92},
          {64,-77.8},{28,-77.8}}, color={0,0,127}));
  connect(const5.y, val1.y) annotation (Line(points={{30.9,-35},{30.9,-36},{34,
          -36},{34,0},{66,0},{66,-10}}, color={0,0,127}));
  connect(const4.y, val.y)
    annotation (Line(points={{42.9,55},{60,55},{60,26}}, color={0,0,127}));
  connect(senMasFlo.m_flow, conPID.u_m) annotation (Line(points={{-62,-59},{-60,
          -59},{-60,-98},{-76,-98},{-76,-92}}, color={0,0,127}));
  connect(const6.y, conPID.u_s) annotation (Line(points={{-139.1,-75},{-139.1,
          -76},{-98,-76},{-98,-80},{-88,-80}}, color={0,0,127}));
  connect(jun1.port_3, val2.port_a)
    annotation (Line(points={{-30,12},{-32,12},{-32,-2}}, color={0,127,255}));
  connect(val2.port_b, jun2.port_3) annotation (Line(points={{-32,-22},{-32,-32},
          {-30,-32},{-30,-38}}, color={0,127,255}));
  connect(conPID.y, val2.y) annotation (Line(points={{-65,-80},{-44,-80},{-44,
          -82},{-12,-82},{-12,-12},{-20,-12}}, color={0,0,127}));
  connect(const3.y, fan1.y) annotation (Line(points={{-145.1,71},{-118,71},{
          -118,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end VariablePrimary;
