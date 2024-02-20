within CCC_test.StanfordHybrid;
model Hybrid_2024_test1

   package MediumW = Buildings.Media.Water "Medium model for 9% prop glycol mix with water";
  package MediumA = Buildings.Media.Air "Medium model for air";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.8;
  parameter Modelica.Units.SI.MassFlowRate mTes_flow_nominal=0.8;
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal = 10
                                                                     "Nominal pressure drop of fully open valve";
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal = 1000 "pressure drop of pipe and other resistances that are in series" annotation(Dialog(group="System Specifications"));
  Buildings.Fluid.FixedResistances.Junction spl1(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{-9,9},{9,-9}},
        rotation=0,
        origin={-131,-67})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA4(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=0,
        origin={-172,-68})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA5(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-9,10},{9,-10}},
        rotation=0,
        origin={-97,-68})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-170,26})));
  Buildings.Fluid.FixedResistances.Junction spl4(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{-11,11},{11,-11}},
        rotation=180,
        origin={-171,89})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumW,
    use_T_in=false,
    T=295.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-326,81})));
  Modelica.Blocks.Sources.Constant V4_out(k=1)
    annotation (Placement(transformation(extent={{-198,-124},{-178,-104}})));
  Modelica.Blocks.Sources.Constant V5_out(k=1)
    annotation (Placement(transformation(extent={{-124,-124},{-104,-104}})));
  Modelica.Blocks.Sources.Constant P_out(k=0)
    annotation (Placement(transformation(extent={{-144,12},{-124,32}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = MediumW,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-224,-6})));
  Modelica.Blocks.Sources.Constant const5(k=0.3)
    annotation (Placement(transformation(extent={{-298,26},{-278,46}})));
equation

  connect(valA4.port_2, spl1.port_1) annotation (Line(points={{-162,-68},{-150,-68},
          {-150,-67},{-140,-67}}, color={0,127,255}));

  connect(spl1.port_2, valA5.port_1) annotation (Line(points={{-122,-67},{-114,-67},
          {-114,-68},{-106,-68}}, color={0,127,255}));
  connect(spl4.port_3, pump.port_a) annotation (Line(points={{-171,78},{-172,78},
          {-172,54},{-170,54},{-170,36}},
                                color={0,127,255}));
  connect(pump.port_b, valA4.port_3) annotation (Line(points={{-170,16},{-172,16},
          {-172,-60}}, color={0,127,255}));

  connect(V4_out.y, valA4.y) annotation (Line(points={{-177,-114},{-172,-114},{-172,
          -77.6}}, color={0,0,127}));
  connect(V5_out.y, valA5.y) annotation (Line(points={{-103,-114},{-97,-114},{-97,
          -80}}, color={0,0,127}));
  connect(P_out.y, pump.m_flow_in) annotation (Line(points={{-123,22},{-118,22},
          {-118,6},{-152,6},{-152,22},{-150,22},{-150,26},{-158,26}}, color={0,0,
          127}));
  connect(boundary1.ports[1], pump.port_a) annotation (Line(points={{-316,81},{
          -188,81},{-188,42},{-170,42},{-170,36}}, color={0,127,255}));
  connect(spl4.port_2, valA4.port_1) annotation (Line(points={{-182,89},{-194,89},
          {-194,90},{-204,90},{-204,-68},{-182,-68}}, color={0,127,255}));
  connect(pump1.port_b, valA5.port_3) annotation (Line(points={{-234,-6},{-270,-6},
          {-270,-44},{-97,-44},{-97,-58}}, color={0,127,255}));
  connect(const5.y, pump1.m_flow_in) annotation (Line(points={{-277,36},{-262,36},
          {-262,-28},{-224,-28},{-224,-18}}, color={0,0,127}));
  connect(valA5.port_2, spl4.port_1) annotation (Line(points={{-88,-68},{-48,-68},
          {-48,89},{-160,89}}, color={0,127,255}));
  connect(pump1.port_a, spl1.port_3) annotation (Line(points={{-214,-6},{-131,-6},
          {-131,-58}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,-100},
            {40,100}})),  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-340,-100},{40,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Hybrid_2024_test1;
