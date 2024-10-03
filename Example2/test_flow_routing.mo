within CCC_test.Example2;
model test_flow_routing


    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-112,40},{-92,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{94,40},{114,60}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov[3](
    redeclare package Medium = MediumPropyleneGlycol,
    addPowerToMedium=false,
    m_flow_nominal=0.92)
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conInt(k=0.92)
    annotation (Placement(transformation(extent={{-32,36},{-12,56}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conInt1(k=0.6)
    annotation (Placement(transformation(extent={{-42,-42},{-22,-22}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conInt2(k=0)
    annotation (Placement(transformation(extent={{-34,-80},{-14,-60}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=0.92,
    V=0.000001,
    nPorts=4)   annotation (Placement(transformation(extent={{60,56},{80,76}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=0.92,
    V=0.000001,
    nPorts=4)   annotation (Placement(transformation(extent={{-80,58},{-60,78}})));
equation
  connect(conInt.y, mov[1].m_flow_in)
    annotation (Line(points={{-10,46},{32,46},{32,12}}, color={0,0,127}));
  connect(conInt1.y, mov[2].m_flow_in) annotation (Line(points={{-20,-32},{16,-32},
          {16,22},{32,22},{32,12}}, color={0,0,127}));
  connect(conInt2.y, mov[3].m_flow_in) annotation (Line(points={{-12,-70},{16,-70},
          {16,22},{32,22},{32,12}}, color={0,0,127}));
  connect(port_b1, vol.ports[1]) annotation (Line(points={{104,50},{68.5,50},{
          68.5,56}}, color={0,127,255}));
  connect(port_a1, vol1.ports[1]) annotation (Line(points={{-102,50},{-88,50},{
          -88,52},{-71.5,52},{-71.5,58}}, color={0,127,255}));
  connect(vol1.ports[2:4], mov.port_a) annotation (Line(points={{-68.5,58},{
          -68.5,18},{22,18},{22,0}}, color={0,127,255}));
  connect(vol.ports[2:4], mov.port_b) annotation (Line(points={{71.5,56},{71.5,
          50},{48,50},{48,0},{42,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_flow_routing;
