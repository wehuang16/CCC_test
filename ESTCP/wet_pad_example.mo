within CCC_test.ESTCP;
model wet_pad_example

  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  wet_pad wet_pad1(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{34,-2},{54,18}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin
                                   sin(
    amplitude=0,
    freqHz=1/43200,
    offset=1)
    annotation (Placement(transformation(extent={{-114,46},{-94,66}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium =
        MediumAir,
    use_T_in=true,
    use_X_in=true,
    T=308.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={156,-7})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temIn(redeclare package Medium =
        MediumAir, m_flow_nominal=1) annotation (Placement(transformation(
          extent={{-16,-8},{4,12}}, rotation=0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temOut(redeclare package Medium =
        MediumAir, m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,12})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData bou(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-72,-12},{-52,8}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC_test/Resources/weatherdata/Sacramento_TMY3.mos"))
    annotation (Placement(transformation(extent={{-220,-58},{-200,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin
                                   sin1(
    amplitude=5,
    freqHz=1/43200,
    offset=273.15 + 35)
    annotation (Placement(transformation(extent={{132,50},{152,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin2(
    amplitude=0.002,
    freqHz=1/43200,
    offset=0.009)
    annotation (Placement(transformation(extent={{142,-64},{162,-44}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{190,-94},{210,-74}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=1)
    annotation (Placement(transformation(extent={{78,-96},{98,-76}})));
equation
  connect(temIn.port_b, wet_pad1.port_a)
    annotation (Line(points={{4,2},{20,2},{20,8},{34,8}}, color={0,127,255}));
  connect(wet_pad1.port_b, temOut.port_a) annotation (Line(points={{54,8},{68,8},
          {68,12},{80,12}}, color={0,127,255}));
  connect(temOut.port_b, boundary1.ports[1]) annotation (Line(points={{100,12},
          {124,12},{124,-7},{146,-7}}, color={0,127,255}));
  connect(weaDat.weaBus, bou.weaBus) annotation (Line(
      points={{-200,-48},{-174,-48},{-174,-1.8},{-72,-1.8}},
      color={255,204,51},
      thickness=0.5));
  connect(sin.y, bou.m_flow_in) annotation (Line(points={{-92,56},{-92,32},{-72,
          32},{-72,6}}, color={0,0,127}));
  connect(bou.ports[1], temIn.port_a) annotation (Line(points={{-52,-2},{-36,-2},
          {-36,2},{-16,2}}, color={0,127,255}));
  connect(sin1.y, boundary1.T_in) annotation (Line(points={{154,60},{154,30},{
          168,30},{168,-3.4}}, color={0,0,127}));
  connect(con.y, sub.u1) annotation (Line(points={{100,-86},{152,-86},{152,-78},
          {188,-78}}, color={0,0,127}));
  connect(sin2.y, sub.u2) annotation (Line(points={{164,-54},{176,-54},{176,-90},
          {188,-90}}, color={0,0,127}));
  connect(sin2.y, boundary1.X_in[1]) annotation (Line(points={{164,-54},{178,
          -54},{178,-10.6},{168,-10.6}}, color={0,0,127}));
  connect(sub.y, boundary1.X_in[2]) annotation (Line(points={{212,-84},{224,-84},
          {224,-12},{168,-12},{168,-10.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end wet_pad_example;
