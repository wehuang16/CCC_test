within CCC_test.Examples;
model testAnyBlock

            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.PressureDifference  dpValve_nominal=1;
  Buildings.Fluid.Movers.FlowControlled_m_flow PumpHeatPump(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false,
    m_flow_nominal=1)       "Pump for radiator side" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={72,38})));
  Buildings.Fluid.Movers.FlowControlled_m_flow PumpPcm(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false,
    m_flow_nominal=1)       "Pump for radiator side" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={128,-130})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=dpValve_nominal)
    annotation (Placement(transformation(extent={{-54,24},{-74,44}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=dpValve_nominal)
    annotation (Placement(transformation(extent={{-34,-114},{-6,-86}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val2(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=dpValve_nominal)                                                           annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={86,-26})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val3(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=dpValve_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={190,98})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={316,38})));
  Modelica.Blocks.Tables.CombiTable1Ds ModeDefinitions(
    table=[1,1,1,0,0,1,0; 2,0,0,0,1,1,0; 3,0,0,1,0,0,1],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    "0=off/closed, 1=on/open. Column numbers in table: 1=input, 2=valA1, 3=valA2, 4=valA4, 5=valA5, 6=CP, 7=HP. Column numbers for use: 1=valA1, 2=valA2, 3=valA4, 4=valA45 5=CP, 6=HP"
    annotation (Placement(transformation(extent={{-164,62},{-144,82}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,-64})));
  Modelica.Blocks.Math.Gain gain(k=0.29)
    annotation (Placement(transformation(extent={{-104,84},{-84,104}})));
  Modelica.Blocks.Math.Gain gain1(k=0.29)
    annotation (Placement(transformation(extent={{56,-124},{76,-104}})));
  Modelica.Blocks.Sources.CombiTimeTable Mode0(
    table=[0.0,1; 43200,2; 86400,3; 129600,2; 172800,1],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,70})));
equation
  connect(val2.port_3,val3. port_3) annotation (Line(points={{96,-26},{108,-26},
          {108,108},{190,108}},
                              color={0,127,255}));
  connect(PumpHeatPump.port_b, val.port_2)
    annotation (Line(points={{82,38},{86,38},{86,16},{-80,16},{-80,34},{-74,34}},
                                                color={0,127,255}));
  connect(val.port_3, val3.port_1) annotation (Line(points={{-64,24},{-82,24},{
          -82,76},{114,76},{114,98},{200,98}},
                         color={0,127,255}));
  connect(ModeDefinitions.y[2], val1.y) annotation (Line(points={{-143,72},{
          -120,72},{-120,-12},{-38,-12},{-38,-26},{-20,-26},{-20,-83.2}},
                                                                     color={0,0,
          127}));
  connect(val.y,ModeDefinitions. y[1])
    annotation (Line(points={{-64,46},{-64,72},{-143,72}},
                                                        color={0,0,127}));
  connect(ModeDefinitions.y[3], val2.y) annotation (Line(points={{-143,72},{
          -120,72},{-120,-12},{-38,-12},{-38,-26},{74,-26}},
                                                     color={0,0,127}));
  connect(ModeDefinitions.y[4], val3.y) annotation (Line(points={{-143,72},{100,
          72},{100,70},{118,70},{118,86},{190,86}},       color={0,0,127}));
  connect(val2.port_1, PumpPcm.port_a) annotation (Line(points={{86,-16},{86,
          -10},{118,-10},{118,-130}},                color={0,127,255}));
  connect(boundary2.ports[1], PumpPcm.port_a) annotation (Line(points={{78,-64},
          {72,-64},{72,-100},{118,-100},{118,-130}},            color={0,127,255}));
  connect(val3.port_2, PumpHeatPump.port_a) annotation (Line(points={{180,98},{
          118,98},{118,110},{18,110},{18,38},{62,38}},
                                                 color={0,127,255}));
  connect(boundary1.ports[1], PumpHeatPump.port_a) annotation (Line(points={{306,38},
          {84,38},{84,24},{62,24},{62,38}},                 color={0,127,255}));
  connect(gain.y, PumpHeatPump.m_flow_in) annotation (Line(points={{-83,94},{20,
          94},{20,56},{72,56},{72,50}}, color={0,0,127}));
  connect(gain1.y, PumpPcm.m_flow_in) annotation (Line(points={{77,-114},{77,
          -118},{128,-118}}, color={0,0,127}));
  connect(ModeDefinitions.y[5], gain.u) annotation (Line(points={{-143,72},{
          -120,72},{-120,94},{-106,94}}, color={0,0,127}));
  connect(ModeDefinitions.y[6], gain1.u) annotation (Line(points={{-143,72},{
          -132,72},{-132,-12},{54,-12},{54,-114}}, color={0,0,127}));
  connect(Mode0.y[1], ModeDefinitions.u) annotation (Line(points={{-199,70},{
          -182,70},{-182,72},{-166,72}}, color={0,0,127}));
  connect(val1.port_3, PumpPcm.port_b) annotation (Line(points={{-20,-114},{-20,
          -120},{48,-120},{48,-104},{52,-104},{52,-102},{88,-102},{88,-130},{
          138,-130}}, color={0,127,255}));
  connect(val.port_1, val1.port_1) annotation (Line(points={{-54,34},{-48,34},{
          -48,-100},{-34,-100}}, color={0,127,255}));
  connect(val1.port_2, val2.port_2) annotation (Line(points={{-6,-100},{70,-100},
          {70,-36},{86,-36}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
