within CCC_test.StanfordHybrid;
model testTESHybrid
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.Plants.BaseClasses.Tes_hybrid_alternative tes_hybrid_alternative(
    redeclare package Medium = MediumPropyleneGlycol,
    mTes_flow_nominal=1,
    k=matPro.kPCMHig,
    c=matPro.cPCMHig,
    d=matPro.dPCMHig,
    TSol=matPro.TSolHig,
    TLiq=matPro.TLiqHig,
    T_start=328.15,
    LHea=matPro.LHeaHig,
    Tes_nominal(displayUnit="kWh") = 14400000)
    annotation (Placement(transformation(extent={{14,-26},{40,-4}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{84,-34},{64,-16}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumPropyleneGlycol,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.1,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(extent={{-74,-16},{-54,4}})));
  CCC.Fluid.HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
equation
  connect(boundary.ports[1], tes_hybrid_alternative.port_a) annotation (Line(
        points={{-54,-6},{0,-6},{0,4},{52,4},{52,-8.4},{40,-8.4}}, color={0,127,
          255}));
  connect(tes_hybrid_alternative.port_b, boundary1.ports[1]) annotation (Line(
        points={{40,-22},{54,-22},{54,-25},{64,-25}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testTESHybrid;
