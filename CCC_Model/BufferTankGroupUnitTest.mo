within CCC_test.CCC_Model;
model BufferTankGroupUnitTest
   extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC_test.CCC_Model.TRC_1BufferTank_3fcus_fake3
    arisBufferTankGroup_contained
    annotation (Placement(transformation(extent={{6,2},{54,34}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-202,17})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 50)
    annotation (Placement(transformation(extent={{-178,74},{-158,94}})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=5,
    f=0.00011574074,
    offset=273.15 + 18)
    annotation (Placement(transformation(extent={{-276,-10},{-256,10}})));
  Modelica.Blocks.Sources.Sine     sine1(
    amplitude=5,
    f=0.00092592592,
    offset=273.15 + 10,
    startTime=540)
    annotation (Placement(transformation(extent={{-154,-106},{-134,-86}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=true,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-92,83})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 7)
    annotation (Placement(transformation(extent={{-184,44},{-164,64}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-136,60},{-116,80}})));
  Modelica.Fluid.Sources.Boundary_pT boundary6(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={128,-91})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-6,-100},{14,-80}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-64,0},{-44,20}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{82,-38},{102,-16}})));
  Buildings.Controls.OBC.CDL.Reals.Abs abs1
    annotation (Placement(transformation(extent={{138,-40},{158,-20}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=0.92)
    annotation (Placement(transformation(extent={{188,-38},{208,-18}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=-0.1)
    annotation (Placement(transformation(extent={{108,44},{128,64}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=3)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={214,27})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem[3](redeclare package Medium
      = MediumAir, m_flow_nominal=0.14)
    annotation (Placement(transformation(extent={{-136,6},{-116,26}})));
  Modelica.Blocks.Sources.Sine     sine2(
    amplitude=0,
    f=0.00011574074,
    offset=273.15 + 18)
    annotation (Placement(transformation(extent={{-272,-56},{-252,-36}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-198,-29})));
  Modelica.Blocks.Sources.Sine     sine3(
    amplitude=0,
    f=0.00011574074,
    offset=273.15 + 18)
    annotation (Placement(transformation(extent={{-270,-106},{-250,-86}})));
  Modelica.Fluid.Sources.Boundary_pT boundary5(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-196,-79})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1[3](redeclare package
      Medium = MediumAir, m_flow_nominal=0.14)
    annotation (Placement(transformation(extent={{144,18},{164,38}})));
equation
  connect(sine.y, boundary3.T_in) annotation (Line(points={{-255,0},{-222,0},{-222,
          13.4},{-214,13.4}},              color={0,0,127}));
  connect(sine1.y, arisBufferTankGroup_contained.TOut) annotation (Line(points={{-133,
          -96},{-32,-96},{-32,-34},{30.8,-34},{30.8,0}},   color={0,0,127}));
  connect(const6.y, switch1.u1) annotation (Line(points={{-157,84},{-146,84},{
          -146,78},{-138,78}}, color={0,0,127}));
  connect(const1.y, switch1.u3)
    annotation (Line(points={{-163,54},{-138,54},{-138,62}}, color={0,0,127}));
  connect(switch1.y, boundary4.T_in) annotation (Line(points={{-115,70},{-110,
          70},{-110,79.4},{-104,79.4}}, color={0,0,127}));
  connect(arisBufferTankGroup_contained.port_b5, pump2.port_a) annotation (Line(
        points={{14,1.8},{14,-66},{-12,-66},{-12,-90},{-6,-90}}, color={0,127,255}));
  connect(pump2.port_b, boundary6.ports[1]) annotation (Line(points={{14,-90},{114,
          -90},{114,-91},{118,-91}}, color={0,127,255}));
  connect(arisBufferTankGroup_contained.port_a5, boundary4.ports[1])
    annotation (Line(points={{14,34.2},{16,34.2},{16,83},{-82,83}}, color={0,127,
          255}));
  connect(booleanConstant.y, arisBufferTankGroup_contained.heaCooMod)
    annotation (Line(points={{-43,10},{-6,10},{-6,20.2},{3.6,20.2}}, color={255,
          0,255}));
  connect(arisBufferTankGroup_contained.RequestSpaCon, intToRea.u) annotation (
      Line(points={{45.4,0},{50,0},{50,-27},{80,-27}}, color={255,127,0}));
  connect(intToRea.y, abs1.u) annotation (Line(points={{104,-27},{104,-28},{128,
          -28},{128,-30},{136,-30}}, color={0,0,127}));
  connect(abs1.y, gai.u) annotation (Line(points={{160,-30},{178,-30},{178,-28},
          {186,-28}}, color={0,0,127}));
  connect(gai.y, pump2.m_flow_in) annotation (Line(points={{210,-28},{238,-28},{
          238,-78},{4,-78}}, color={0,0,127}));
  connect(intToRea.y, greThr.u) annotation (Line(points={{104,-27},{104,-28},{112,
          -28},{112,38},{98,38},{98,54},{106,54}}, color={0,0,127}));
  connect(greThr.y, switch1.u2) annotation (Line(points={{130,54},{172,54},{172,
          70},{-138,70}}, color={255,0,255}));
  connect(senTem.port_b, arisBufferTankGroup_contained.port_a) annotation (Line(
        points={{-116,16},{-70,16},{-70,28.6},{5.4,28.6}}, color={0,127,255}));
  connect(sine2.y, boundary2.T_in) annotation (Line(points={{-251,-46},{-218,-46},
          {-218,-32.6},{-210,-32.6}}, color={0,0,127}));
  connect(sine3.y, boundary5.T_in) annotation (Line(points={{-249,-96},{-216,-96},
          {-216,-82.6},{-208,-82.6}}, color={0,0,127}));
  connect(senTem[1].port_a, boundary3.ports[1]) annotation (Line(points={{-136,16},
          {-186,16},{-186,17},{-192,17}}, color={0,127,255}));
  connect(senTem[2].port_a, boundary2.ports[1]) annotation (Line(points={{-136,16},
          {-182,16},{-182,-29},{-188,-29}}, color={0,127,255}));
  connect(senTem[3].port_a, boundary5.ports[1]) annotation (Line(points={{-136,16},
          {-182,16},{-182,-64},{-180,-64},{-180,-79},{-186,-79}}, color={0,127,255}));
  connect(arisBufferTankGroup_contained.port_b, senTem1.port_a) annotation (
      Line(points={{54.6,28.6},{56,28},{144,28}}, color={0,127,255}));
  connect(senTem1.port_b, boundary1.ports) annotation (Line(points={{164,28},{184,
          28},{184,27},{204,27}}, color={0,127,255}));
  connect(arisBufferTankGroup_contained.TZoneAir[1], sine.y) annotation (Line(
        points={{31.8,34.8667},{31.8,0},{-255,0}}, color={0,0,127}));
  connect(arisBufferTankGroup_contained.TZoneAir[2], sine2.y) annotation (Line(
        points={{31.8,35.2},{31.8,40},{-74,40},{-74,-2},{-234,-2},{-234,-46},{
          -251,-46}}, color={0,0,127}));
  connect(arisBufferTankGroup_contained.TZoneAir[3], sine3.y) annotation (Line(
        points={{31.8,35.5333},{31.8,40},{-74,40},{-74,-2},{-234,-2},{-234,-96},
          {-249,-96}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end BufferTankGroupUnitTest;
