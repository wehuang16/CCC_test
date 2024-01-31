within CCC_test.obsolete_eas_e;
model FlowRouter1To4
     replaceable package Medium =   Buildings.Media.Water;
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,-10},{-94,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,56},{114,76}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,14},{114,34}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,-36},{114,-16}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b4(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,-86},{114,-66}})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,4})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={52,62})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={44,-56})));
equation
  connect(port_a, jun1.port_1) annotation (Line(points={{-104,0},{-60,0},{-60,4},
          {-54,4}}, color={0,127,255}));
  connect(jun2.port_2, port_b1) annotation (Line(points={{62,62},{88,62},{88,66},
          {104,66}}, color={0,127,255}));
  connect(jun2.port_3, port_b2)
    annotation (Line(points={{52,52},{52,24},{104,24}}, color={0,127,255}));
  connect(jun3.port_2, port_b3) annotation (Line(points={{54,-56},{90,-56},{90,
          -26},{104,-26}}, color={0,127,255}));
  connect(jun3.port_3, port_b4)
    annotation (Line(points={{44,-66},{44,-76},{104,-76}}, color={0,127,255}));
  connect(jun1.port_2, jun2.port_1) annotation (Line(points={{-34,4},{36,4},{36,
          62},{42,62}}, color={0,127,255}));
  connect(jun1.port_3, jun3.port_1)
    annotation (Line(points={{-44,-6},{-44,-56},{34,-56}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FlowRouter1To4;
