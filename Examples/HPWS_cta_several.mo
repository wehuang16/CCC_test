within CCC_test.Examples;
model HPWS_cta_several
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Buildings.Media.Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-86,-26},{-66,-6}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{60,6},{40,26}})));
  models.HPWH.HPWH_virtual HPHW_virtual1(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=1,
    QHeaPum_flow_nominal=1230.9,
    Qres_nominal=3800,
    VTan=0.28,
    hTan=1.3,
    dIns=0.028146574,
    cut_temperature=275.9,
    deadband_hp=13,
    deadband_low_stratification=3.5,
    res_deadband=11.25,
    res_deadband_hpactive=11.25,
    hp_timewindow=300)
    annotation (Placement(transformation(extent={{-40,8},{-20,30}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression
    annotation (Placement(transformation(extent={{20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant const(k=0.1)
    annotation (Placement(transformation(extent={{-134,4},{-114,24}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 12)
    annotation (Placement(transformation(extent={{-144,-40},{-124,-20}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-86,62},{-66,82}})));
  Modelica.Blocks.Sources.Constant const3(k=273.15 + 49)
    annotation (Placement(transformation(extent={{-126,44},{-106,64}})));
  Modelica.Blocks.Sources.Constant const4(k=6)
    annotation (Placement(transformation(extent={{-94,18},{-74,38}})));
equation
  connect(HPHW_virtual1.port_a, boundary.ports[1])
    annotation (Line(points={{-40,20},{-64,20},{-64,-16},{-66,-16}},
                                                 color={0,127,255}));
  connect(HPHW_virtual1.port_b, bou.ports[1])
    annotation (Line(points={{-20,20},{34,20},{34,16},{40,16}},
                                               color={0,127,255}));
  connect(integerExpression.y, HPHW_virtual1.cta_signal) annotation (Line(
        points={{-1,50},{-30,50},{-30,32}}, color={255,127,0}));
  connect(const.y, boundary.m_flow_in) annotation (Line(points={{-113,14},{-96,
          14},{-96,-8},{-88,-8}}, color={0,0,127}));
  connect(const1.y, boundary.T_in) annotation (Line(points={{-123,-30},{-96,-30},
          {-96,-12},{-88,-12}}, color={0,0,127}));
  connect(const2.y, HPHW_virtual1.Toutside) annotation (Line(points={{-65,72},{
          -52,72},{-52,30},{-42,30}}, color={0,0,127}));
  connect(const2.y, HPHW_virtual1.Tevap) annotation (Line(points={{-65,72},{-52,
          72},{-52,27},{-42,27}}, color={0,0,127}));
  connect(const3.y, HPHW_virtual1.Tset_user) annotation (Line(points={{-105,54},
          {-54,54},{-54,24},{-42,24}}, color={0,0,127}));
  connect(const4.y, HPHW_virtual1.Tdelta) annotation (Line(points={{-73,28},{
          -60,28},{-60,16},{-42,16}}, color={0,0,127}));
  connect(const2.y, HPHW_virtual1.Tambient) annotation (Line(points={{-65,72},{
          -60,72},{-60,11},{-42,11}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end HPWS_cta_several;
