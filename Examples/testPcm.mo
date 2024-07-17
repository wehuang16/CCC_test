within CCC_test.Examples;
model testPcm
     package MediumW = Buildings.Media.Water "Medium model for 9% prop glycol mix with water";
  package MediumA = Buildings.Media.Air "Medium model for air";
  CCC.Fluid.Plants.BaseClasses.Tes_hybrid_alternative hot_PCM(
    redeclare package Medium = MediumW,
    mTes_flow_nominal=1,
    k=matPro.kPCMLow,
    c=matPro.cPCMLow,
    d=matPro.dPCMLow,
    TSol=matPro.TSolLow,
    TLiq=matPro.TLiqLow,
    T_start=293.15,
    LHea=matPro.LHeaLow,
    Tes_nominal(displayUnit="kWh") = 32400000) annotation (Placement(
        transformation(
        extent={{-13,-18},{13,18}},
        rotation=180,
        origin={-5,30})));
  CCC.Fluid.Plants.BaseClasses.Tes_hybrid_alternative cold_PCM(
    redeclare package Medium = MediumW,
    mTes_flow_nominal=1,
    k=matPro.kPCMCoo,
    c=matPro.cPCMCoo,
    d=matPro.dPCMCoo,
    TSol=matPro.TSolCoo,
    TLiq=matPro.TLiqCoo,
    T_start=303.15,
    LHea=matPro.LHeaCoo,
    Tes_nominal(displayUnit="kWh") = 32400000) annotation (Placement(
        transformation(
        extent={{-13,-18},{13,18}},
        rotation=180,
        origin={3,-42})));
  CCC.Fluid.HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{-94,-4},{-74,16}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumW,
    m_flow=0.05,
    T=338.15,
    nPorts=1) annotation (Placement(transformation(extent={{-88,22},{-68,42}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = MediumW,
      nPorts=1)
    annotation (Placement(transformation(extent={{-74,68},{-54,88}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium = MediumW,
      nPorts=1)
    annotation (Placement(transformation(extent={{-58,-18},{-38,2}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumW,
    m_flow=0.05,
    T=276.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-72,-64},{-52,-44}})));
equation
  connect(boundary.ports[1], hot_PCM.port_a) annotation (Line(points={{-68,32},
          {-22,32},{-22,19.2},{-18,19.2}}, color={0,127,255}));
  connect(hot_PCM.port_b, bou.ports[1]) annotation (Line(points={{-18,41.4545},
          {-48,41.4545},{-48,78},{-54,78}}, color={0,127,255}));
  connect(boundary1.ports[1], cold_PCM.port_a) annotation (Line(points={{-52,
          -54},{-50,-54},{-50,-52.8},{-10,-52.8}}, color={0,127,255}));
  connect(cold_PCM.port_b, bou1.ports[1]) annotation (Line(points={{-10,
          -30.5455},{-32,-30.5455},{-32,-8},{-38,-8}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPcm;
