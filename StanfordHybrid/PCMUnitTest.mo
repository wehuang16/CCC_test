within CCC_test.StanfordHybrid;
model PCMUnitTest
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.HeatExchangers.BaseClasses.CoilRegisterFourPort
    coilRegisterFourPort(
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    TStart_pcm=328.15,
    Design(Tes_nominal(displayUnit="kWh") = 14400000, PCM(
        k=matPro.kPCMHig,
        c=matPro.cPCMHig,
        d=matPro.dPCMHig,
        TSol=matPro.TSolHig,
        TLiq=matPro.TLiqHig,
        LHea=matPro.LHeaHig)),
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-10,16},{10,36}})));
  CCC.Fluid.HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{-68,74},{-48,94}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.1,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(extent={{-74,48},{-54,68}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=2)
    annotation (Placement(transformation(extent={{84,30},{64,48}})));
equation
  connect(boundary.ports[1], coilRegisterFourPort.port_a2) annotation (Line(
        points={{-54,58},{26,58},{26,21.8},{10,21.8}}, color={0,127,255}));
  connect(coilRegisterFourPort.port_b1, boundary1.ports[1]) annotation (Line(
        points={{10,30.2},{58,30.2},{58,38.1},{64,38.1}}, color={0,127,255}));
  connect(coilRegisterFourPort.port_b2, boundary1.ports[2]) annotation (Line(
        points={{-10,21.8},{-20,21.8},{-20,20},{-28,20},{-28,10},{64,10},{64,
          39.9}}, color={0,127,255}));
  connect(coilRegisterFourPort.port_a1, coilRegisterFourPort.port_a2)
    annotation (Line(points={{-10,30.2},{-16,30.2},{-16,44},{20,44},{20,21.8},{
          10,21.8}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PCMUnitTest;
