within CCC_test.Examples;
model parallelValves

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    redeclare package Medium = MediumWater,
    per(pressure(V_flow={0,0.003,0.004}, dp={50,10,0})),
    addPowerToMedium=false)                                    "Supply air fan"
    annotation (Placement(transformation(extent={{-92,10},{-72,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{4,-34},{24,-14}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{4,30},{24,50}})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo(redeclare package Medium =
        MediumWater, nPorts=1)
              "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-132,-18})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo1(redeclare package Medium =
        MediumWater, nPorts=2)
              "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={82,14})));
  Buildings.Fluid.FixedResistances.Junction splSupNor(
    redeclare package Medium = MediumWater,
    m_flow_nominal={2,-1,-1},
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    "Splitter for room supply"
    annotation (Placement(transformation(extent={{11,11},{-11,-11}},
        rotation=180,
        origin={-31,27})));
  Modelica.Blocks.Sources.Ramp ramp1(duration=86400, startTime=0)
    annotation (Placement(transformation(extent={{-164,62},{-144,82}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0,
    duration=43200,
    offset=1,
    startTime=21600)
    annotation (Placement(transformation(extent={{-136,20},{-116,40}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTableVal1(
    table=[0,0.05; 0.05,0.05; 0.333,1; 0.667,0.05; 1,1],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-44,62},{-24,82}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTableVal2(
    table=[0,0.05; 0.05,0.05; 0.333,0.05; 0.667,1; 1,1],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-76,-48},{-56,-28}})));
equation
  connect(sinCoo.ports[1], fanSup.port_a) annotation (Line(points={{-122,-18},{
          -98,-18},{-98,20},{-92,20}}, color={0,127,255}));
  connect(val1.port_b, sinCoo1.ports[1]) annotation (Line(points={{24,40},{50,
          40},{50,30},{83,30},{83,24}}, color={0,127,255}));
  connect(val2.port_b, sinCoo1.ports[2]) annotation (Line(points={{24,-24},{62,
          -24},{62,30},{81,30},{81,24}}, color={0,127,255}));
  connect(fanSup.port_b, splSupNor.port_1) annotation (Line(points={{-72,20},{
          -48,20},{-48,27},{-42,27}}, color={0,127,255}));
  connect(splSupNor.port_2, val1.port_a) annotation (Line(points={{-20,27},{-2,
          27},{-2,40},{4,40}}, color={0,127,255}));
  connect(splSupNor.port_3, val2.port_a) annotation (Line(points={{-31,16},{-32,
          16},{-32,-24},{4,-24}}, color={0,127,255}));
  connect(ramp.y, fanSup.y) annotation (Line(points={{-115,30},{-96,30},{-96,42},
          {-82,42},{-82,32}}, color={0,0,127}));
  connect(combiTableVal1.y[1], val1.y) annotation (Line(points={{-23,72},{0,72},
          {0,64},{14,64},{14,52}}, color={0,0,127}));
  connect(combiTableVal2.y[1], val2.y) annotation (Line(points={{-55,-38},{-30,
          -38},{-30,-2},{14,-2},{14,-12}}, color={0,0,127}));
  connect(ramp1.y, combiTableVal1.u)
    annotation (Line(points={{-143,72},{-46,72}}, color={0,0,127}));
  connect(ramp1.y, combiTableVal2.u) annotation (Line(points={{-143,72},{-148,
          72},{-148,-36},{-78,-36},{-78,-38}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end parallelValves;
