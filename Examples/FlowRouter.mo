within CCC_test.Examples;
model FlowRouter
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
   replaceable package Medium1 =   Buildings.Media.Water;
  replaceable parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Valve nominal mass flow rate";
     replaceable parameter Modelica.Units.SI.Pressure dpValve_nominal=0
    "Valve nominal pressure drop";


  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,                               riseTime=1)
    annotation (Placement(transformation(extent={{-46,68},{-26,88}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val1(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{-52,2},{-32,22}})));

  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val2(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{-46,-64},{-26,-44}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-116,-32},{-96,-12}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-114,-56},{-94,-36}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-114,-90},{-94,-70}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val3(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{-34,36},{-14,56}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val4(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{-36,-24},{-16,-4}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val5(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{-36,-98},{-16,-78}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{94,54},{114,74}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{96,-52},{116,-32}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,66},{-100,108}})));
  Modelica.Blocks.Interfaces.RealInput u1
    annotation (Placement(transformation(extent={{-142,28},{-102,70}})));
  Modelica.Blocks.Interfaces.RealInput u2
    annotation (Placement(transformation(extent={{-140,-10},{-100,32}})));
protected
  Modelica.Blocks.Math.Feedback inv "Inversion of control signal"
    annotation (Placement(transformation(extent={{-74,86},{-62,98}})));
protected
  Modelica.Blocks.Math.Feedback inv1
                                    "Inversion of control signal"
    annotation (Placement(transformation(extent={{-82,52},{-70,64}})));
protected
  Modelica.Blocks.Math.Feedback inv2
                                    "Inversion of control signal"
    annotation (Placement(transformation(extent={{-84,4},{-72,16}})));
equation
  connect(port_a, val.port_a) annotation (Line(points={{-106,-22},{-70,-22},{
          -70,46},{-52,46},{-52,78},{-46,78}}, color={0,127,255}));
  connect(port_a, val3.port_a) annotation (Line(points={{-106,-22},{-70,-22},{
          -70,46},{-34,46}}, color={0,127,255}));
  connect(port_a1, val1.port_a) annotation (Line(points={{-104,-46},{-58,-46},{
          -58,12},{-52,12}}, color={0,127,255}));
  connect(port_a1, val4.port_a) annotation (Line(points={{-104,-46},{-36,-46},{
          -36,-14}}, color={0,127,255}));
  connect(port_a2, val2.port_a) annotation (Line(points={{-104,-80},{-52,-80},{
          -52,-54},{-46,-54}}, color={0,127,255}));
  connect(port_a2, val5.port_a) annotation (Line(points={{-104,-80},{-42,-80},{
          -42,-88},{-36,-88}}, color={0,127,255}));
  connect(val.port_b, port_b) annotation (Line(points={{-26,78},{88,78},{88,64},
          {104,64}}, color={0,127,255}));
  connect(val1.port_b, port_b) annotation (Line(points={{-32,12},{86,12},{86,64},
          {104,64}}, color={0,127,255}));
  connect(val2.port_b, port_b) annotation (Line(points={{-26,-54},{86,-54},{86,
          64},{104,64}}, color={0,127,255}));
  connect(val3.port_b, port_b1) annotation (Line(points={{-14,46},{92,46},{92,
          -42},{106,-42}}, color={0,127,255}));
  connect(val4.port_b, port_b1) annotation (Line(points={{-16,-14},{92,-14},{92,
          -42},{106,-42}}, color={0,127,255}));
  connect(val5.port_b, port_b1) annotation (Line(points={{-16,-88},{92,-88},{92,
          -42},{106,-42}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FlowRouter;
