within CCC_test.Examples;
model FlowRouterReturn
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
   replaceable package Medium1 =   Buildings.Media.Water;
  replaceable parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1
    "Valve nominal mass flow rate";
     replaceable parameter Modelica.Units.SI.Pressure dpValve_nominal=10
    "Valve nominal pressure drop";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-114,-30},{-94,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-114,-84},{-94,-64}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{94,54},{114,74}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{94,-6},{114,14}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,66},{-100,108}})));
  Modelica.Blocks.Interfaces.RealInput u1
    annotation (Placement(transformation(extent={{-142,28},{-102,70}})));
  Modelica.Blocks.Interfaces.RealInput u2
    annotation (Placement(transformation(extent={{-140,-10},{-100,32}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-126,118},{-106,138}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{94,-90},{114,-70}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{22,72},{42,92}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val3(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{34,40},{54,60}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val1(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{16,6},{36,26}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val4(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{32,-20},{52,0}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val2(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{22,-60},{42,-40}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val5(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    riseTime=1)
    annotation (Placement(transformation(extent={{32,-94},{52,-74}})));
protected
  Modelica.Blocks.Math.Feedback inv "Inversion of control signal"
    annotation (Placement(transformation(extent={{-84,74},{-72,86}})));
protected
  Modelica.Blocks.Math.Feedback inv1
                                    "Inversion of control signal"
    annotation (Placement(transformation(extent={{-84,52},{-72,64}})));
protected
  Modelica.Blocks.Math.Feedback inv2
                                    "Inversion of control signal"
    annotation (Placement(transformation(extent={{-84,4},{-72,16}})));
equation
  connect(inv.u2, u) annotation (Line(points={{-78,75.2},{-80,75.2},{-80,74},{-120,
          74},{-120,87}}, color={0,0,127}));
  connect(u1, inv1.u2)
    annotation (Line(points={{-122,49},{-78,49},{-78,53.2}}, color={0,0,127}));
  connect(u2, inv2.u2) annotation (Line(points={{-120,11},{-88,11},{-88,0},{-78,
          0},{-78,5.2}}, color={0,0,127}));
  connect(const.y, inv.u1) annotation (Line(points={{-105,128},{-92,128},{-92,80},
          {-82.8,80}}, color={0,0,127}));
  connect(inv1.u1, const.y) annotation (Line(points={{-82.8,58},{-105,58},{-105,
          128}}, color={0,0,127}));
  connect(inv2.u1, const.y) annotation (Line(points={{-82.8,10},{-86,10},{-86,46},
          {-105,46},{-105,128}}, color={0,0,127}));
  connect(val.port_b, port_b) annotation (Line(points={{42,82},{90,82},{90,64},
          {104,64}}, color={0,127,255}));
  connect(val3.port_b, port_b) annotation (Line(points={{54,50},{88,50},{88,64},
          {104,64}}, color={0,127,255}));
  connect(val1.port_b, port_b1) annotation (Line(points={{36,16},{88,16},{88,4},
          {104,4}}, color={0,127,255}));
  connect(val4.port_b, port_b1) annotation (Line(points={{52,-10},{88,-10},{88,
          4},{104,4}}, color={0,127,255}));
  connect(val2.port_b, port_b2) annotation (Line(points={{42,-50},{90,-50},{90,
          -80},{104,-80}}, color={0,127,255}));
  connect(val5.port_b, port_b2) annotation (Line(points={{52,-84},{88,-84},{88,
          -80},{104,-80}}, color={0,127,255}));
  connect(port_a, val.port_a) annotation (Line(points={{-104,-20},{12,-20},{12,
          82},{22,82}}, color={0,127,255}));
  connect(port_a, val1.port_a) annotation (Line(points={{-104,-20},{-42,-20},{
          -42,16},{16,16}}, color={0,127,255}));
  connect(port_a, val2.port_a) annotation (Line(points={{-104,-20},{16,-20},{16,
          -50},{22,-50}}, color={0,127,255}));
  connect(port_a1, val3.port_a) annotation (Line(points={{-104,-74},{-104,-34},
          {-38,-34},{-38,14},{14,14},{14,50},{34,50}}, color={0,127,255}));
  connect(port_a1, val4.port_a) annotation (Line(points={{-104,-74},{-34,-74},{
          -34,-10},{32,-10}}, color={0,127,255}));
  connect(port_a1, val5.port_a) annotation (Line(points={{-104,-74},{26,-74},{
          26,-84},{32,-84}}, color={0,127,255}));
  connect(u, val.y) annotation (Line(points={{-120,87},{-120,74},{-88,74},{-88,
          70},{10,70},{10,104},{32,104},{32,94}}, color={0,0,127}));
  connect(inv.y, val3.y) annotation (Line(points={{-72.6,80},{-12,80},{-12,62},
          {44,62}}, color={0,0,127}));
  connect(u1, val1.y) annotation (Line(points={{-122,49},{-78,49},{-78,46},{24,
          46},{24,36},{26,36},{26,28}}, color={0,0,127}));
  connect(u2, val2.y) annotation (Line(points={{-120,11},{-88,11},{-88,0},{14,0},
          {14,-18},{26,-18},{26,-30},{32,-30},{32,-38}}, color={0,0,127}));
  connect(inv1.y, val4.y) annotation (Line(points={{-72.6,58},{16,58},{16,48},{
          30,48},{30,36},{42,36},{42,2}}, color={0,0,127}));
  connect(inv2.y, val5.y) annotation (Line(points={{-72.6,10},{10,10},{10,-66},
          {34,-66},{34,-64},{42,-64},{42,-72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FlowRouterReturn;
