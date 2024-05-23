within CCC_test.Examples;
model testPumpValveWithPressure
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Sources.Boundary_pT boundary2(redeclare package Medium =
        MediumWater,
    use_T_in=false)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-242,-25})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpFcuWaterSupply(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false,
    m_flow_nominal=1)                             "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-8,-6})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={144,-39})));
  Modelica.Blocks.Sources.CombiTimeTable
                                   combiTimeTable(
    table=[0,0; 21600,1; 43200,0; 64800,1; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=1,
    duration=4320,
    offset=0,
    startTime=2160)
    annotation (Placement(transformation(extent={{-134,26},{-114,46}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear
                                                val(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=1)
    annotation (Placement(transformation(extent={{100,-18},{74,8}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear
                                                val1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=1)
    annotation (Placement(transformation(extent={{-84,-24},{-110,2}})));
equation
  connect(pumpFcuWaterSupply.port_b, val.port_2) annotation (Line(points={{2,-6},
          {66,-6},{66,-5},{74,-5}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPumpValveWithPressure;
