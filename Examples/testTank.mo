within CCC_test.Examples;
model testTank
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.126,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=10000,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=0.7)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={-10,-9})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    m_flow=0.575,
    T=303.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-52,-44},{-32,-24}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
        MediumWater, nPorts=1)                          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={56,-42})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    m_flow=0.575,
    T=303.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-66,18},{-46,38}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(redeclare package Medium =
        MediumWater, nPorts=1)                          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={42,20})));
equation
  connect(boundary2.ports[1], tan.port_b) annotation (Line(points={{-46,28},{
          -28,28},{-28,-9},{-20,-9}}, color={0,127,255}));
  connect(tan.port_a, boundary3.ports[1]) annotation (Line(points={{0,-9},{18,
          -9},{18,20},{32,20}}, color={0,127,255}));
  connect(boundary1.ports[1], tan.portHex_a) annotation (Line(points={{-32,-34},
          {-12,-34},{-12,-32},{10,-32},{10,-12.42},{0,-12.42}}, color={0,127,
          255}));
  connect(tan.portHex_b, boundary.ports[1]) annotation (Line(points={{0,-16.2},
          {40,-16.2},{40,-42},{46,-42}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=8640, __Dymola_Algorithm="Dassl"));
end testTank;
