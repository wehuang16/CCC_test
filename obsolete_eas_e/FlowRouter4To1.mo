within CCC_test.obsolete_eas_e;
model FlowRouter4To1
   replaceable package Medium =   Buildings.Media.Water;
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,62},{-94,82}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,14},{-94,34}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,-30},{-94,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a4(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,-78},{-94,-58}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,-12},{114,8}})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-24,60})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Medium,
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-22,-40})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Medium,
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={54,4})));
equation
  connect(port_a1, jun1.port_1) annotation (Line(points={{-104,72},{-76,72},{
          -76,68},{-34,68},{-34,60}}, color={0,127,255}));
  connect(port_a2, jun1.port_3)
    annotation (Line(points={{-104,24},{-24,24},{-24,50}}, color={0,127,255}));
  connect(port_a3, jun2.port_1) annotation (Line(points={{-104,-20},{-38,-20},{
          -38,-40},{-32,-40}}, color={0,127,255}));
  connect(port_a4, jun2.port_3) annotation (Line(points={{-104,-68},{-62,-68},{
          -62,-54},{-22,-54},{-22,-50}}, color={0,127,255}));
  connect(jun1.port_2, jun3.port_1) annotation (Line(points={{-14,60},{38,60},{
          38,4},{44,4}}, color={0,127,255}));
  connect(jun2.port_2, jun3.port_3)
    annotation (Line(points={{-12,-40},{54,-40},{54,-6}}, color={0,127,255}));
  connect(jun3.port_2, port_b) annotation (Line(points={{64,4},{88,4},{88,-2},{
          104,-2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FlowRouter4To1;
