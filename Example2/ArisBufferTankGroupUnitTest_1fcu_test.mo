within CCC_test.Example2;
model ArisBufferTankGroupUnitTest_1fcu_test
  extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  ArisBufferTankGroup_1BufferTank_1Fcu_test arisBufferTankGroup_contained
    annotation (Placement(transformation(extent={{24,-30},{72,2}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-82,23})));
  Modelica.Fluid.Sources.Boundary_pT boundary5(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={106,45})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-178,74},{-158,94}})));
  Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=4320,
      startValue=false)
    annotation (Placement(transformation(extent={{-136,-30},{-116,-10}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 23)
    annotation (Placement(transformation(extent={{-178,12},{-158,32}})));
  Modelica.Blocks.Sources.Sine     sine1(
    amplitude=12.5,
    f=0.00092592592,
    offset=273.15 + 12.5,
    startTime=540)
    annotation (Placement(transformation(extent={{-76,-100},{-56,-80}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=true,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-88,63})));
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
        origin={44,-87})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                          fan2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
              annotation (Placement(transformation(extent={{-6,-100},{14,-80}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-66,72},{-46,92}})));
  Modelica.Blocks.Sources.Constant const3(k=273.15 + 23)
    annotation (Placement(transformation(extent={{-12,40},{8,60}})));
equation
  connect(booleanStep.y, arisBufferTankGroup_contained.DhwRequestPriority)
    annotation (Line(points={{-115,-20},{-86,-20},{-86,-12},{14,-12},{14,0.6},{
          22,0.6}},    color={255,0,255}));
  connect(const2.y, boundary1.T_in) annotation (Line(points={{-157,22},{-102,22},
          {-102,19.4},{-94,19.4}},                        color={0,0,127}));
  connect(sine1.y, arisBufferTankGroup_contained.TOut) annotation (Line(points={{-55,-90},
          {-14,-90},{-14,-104},{58,-104},{58,-40},{48.8,-40},{48.8,-32}},
                                                           color={0,0,127}));
  connect(const6.y, switch1.u1) annotation (Line(points={{-157,84},{-146,84},{
          -146,78},{-138,78}}, color={0,0,127}));
  connect(const1.y, switch1.u3)
    annotation (Line(points={{-163,54},{-138,54},{-138,62}}, color={0,0,127}));
  connect(switch1.y, boundary4.T_in) annotation (Line(points={{-115,70},{-110,
          70},{-110,59.4},{-100,59.4}}, color={0,0,127}));
  connect(arisBufferTankGroup_contained.ModeBufferTankCommand, switch1.u2)
    annotation (Line(points={{38.2,-32},{38.2,-40},{-188,-40},{-188,70},{-138,
          70}},      color={255,0,255}));
  connect(arisBufferTankGroup_contained.port_b5, fan2.port_a) annotation (Line(
        points={{32,-30.2},{32,-66},{-12,-66},{-12,-90},{-6,-90}},
                                               color={0,127,255}));
  connect(fan2.port_b, boundary6.ports[1]) annotation (Line(points={{14,-90},{
          24,-90},{24,-87},{34,-87}}, color={0,127,255}));
  connect(boundary4.ports[1], senMasFlo.port_a) annotation (Line(points={{-78,63},
          {-72,63},{-72,82},{-66,82}},     color={0,127,255}));
  connect(senMasFlo.port_b, arisBufferTankGroup_contained.port_a5) annotation (
      Line(points={{-46,82},{-30,82},{-30,78},{16,78},{16,100},{48,100},{48,8},
          {32,8},{32,2.2}},                       color={0,127,255}));
  connect(senMasFlo.m_flow, fan2.m_flow_in) annotation (Line(points={{-56,93},{
          -48,93},{-48,94},{-34,94},{-34,-62},{4,-62},{4,-78}}, color={0,0,127}));
  connect(arisBufferTankGroup_contained.port_a, boundary1.ports[1]) annotation
    (Line(points={{23.4,-3.4},{-66,-3.4},{-66,23},{-72,23}}, color={0,127,255}));
  connect(arisBufferTankGroup_contained.port_b, boundary5.ports[1]) annotation
    (Line(points={{72.6,-3.4},{90,-3.4},{90,45},{96,45}}, color={0,127,255}));
  connect(const3.y, arisBufferTankGroup_contained.TZoneAir)
    annotation (Line(points={{9,50},{49.8,50},{49.8,3.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisBufferTankGroupUnitTest_1fcu_test;
