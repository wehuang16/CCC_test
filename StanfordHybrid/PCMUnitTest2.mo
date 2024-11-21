within CCC_test.StanfordHybrid;
model PCMUnitTest2
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

    parameter Modelica.Units.SI.MassFlowRate mTes_flow_nominal=0.5;
  CCC.Fluid.HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{-68,74},{-48,94}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.3,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(extent={{-74,48},{-54,68}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{84,30},{64,48}})));
  CCC.Fluid.Plants.BaseClasses.Tes_hybrid_alternative cold_PCM(
    redeclare package Medium = MediumWater,
    mTes_flow_nominal=mTes_flow_nominal,
    k=matPro.kPCMCoo,
    c=matPro.cPCMCoo,
    d=matPro.dPCMCoo,
    TSol=matPro.TSolCoo,
    TLiq=matPro.TLiqCoo,
    T_start=283.15,
    LHea=matPro.LHeaCoo,
    Tes_nominal(displayUnit="kWh") = 32400000) annotation (Placement(
        transformation(
        extent={{-13,-18},{13,18}},
        rotation=180,
        origin={13,42})));
equation
  connect(boundary.ports[1], cold_PCM.port_a) annotation (Line(points={{-54,58},
          {-6,58},{-6,31.2},{-1.77636e-15,31.2}}, color={0,127,255}));
  connect(cold_PCM.port_b, boundary1.ports[1]) annotation (Line(points={{0,
          53.4545},{36,53.4545},{36,38},{64,38},{64,39}},
                                                 color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end PCMUnitTest2;
