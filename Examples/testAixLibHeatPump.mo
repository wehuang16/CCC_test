within CCC_test.Examples;
model testAixLibHeatPump
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D
                              aixlib_AirToWaterHeatPump_3D(
    redeclare package Medium_con = MediumPropyleneGlycol,
    redeclare package Medium_eva = MediumAir,
    redeclare model PerDataMainHP =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTableND (
        nConv=1,
        interpMethod=SDF.Types.InterpolationMethod.Akima,
        extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
        filename_Pel=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating.sdf",
        dataset_Pel="/elec_power",
        dataUnit_Pel="W",
        scaleUnits_Pel={"K","K",""},
        filename_QCon=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating.sdf",
        dataset_QCon="/condenser_heat",
        dataUnit_QCon="W",
        scaleUnits_QCon={"K","K",""}),
    redeclare model PerDataRevHP =
        CCC.Fluid.Chillers.BaseClasses.LookUpTableND_AirToWater (
        nConv=1,
        interpMethod=SDF.Types.InterpolationMethod.Akima,
        extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
        filename_Pel=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_cooling.sdf",
        dataset_Pel="/elec_power",
        dataUnit_Pel="W",
        scaleUnits_Pel={"K","K",""},
        filename_QCon=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_cooling.sdf",
        dataset_QCon="/evaporator_heat",
        dataUnit_QCon="W",
        scaleUnits_QCon={"K","K",""}))
    annotation (Placement(transformation(extent={{6,10},{26,34}})));


  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={80,21})));
  Modelica.Blocks.Sources.Constant const1(k=0.06393)
    annotation (Placement(transformation(extent={{-76,60},{-56,80}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-0.52,
    duration=4320,
    offset=0.52,
    startTime=2160)
    annotation (Placement(transformation(extent={{-100,22},{-80,42}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_m_flow_in=true,
    use_T_in=false,
    m_flow=0.52,
    T=285.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-42,23})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={24,-72})));
  Modelica.Blocks.Sources.Constant TSet(final k=273.15 + 7)
                                                   annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-44,-30})));
  Modelica.Blocks.Sources.BooleanConstant bool
    annotation (Placement(transformation(extent={{-34,62},{-14,82}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary3(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    m_flow=0.5,
    T=308.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={86,-35})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-84,-25})));
  Modelica.Blocks.Sources.BooleanConstant bool1(k=false)
    annotation (Placement(transformation(extent={{22,58},{42,78}})));
  Modelica.Blocks.Sources.Step     step(
    height=-0.52,
    offset=0.52,
    startTime=4320)
    annotation (Placement(transformation(extent={{-102,-6},{-82,14}})));
equation
  connect(bool1.y, aixlib_AirToWaterHeatPump_3D.Mode) annotation (Line(points={
          {43,68},{44,68},{44,24.4},{27.2,24.4}}, color={255,0,255}));
  connect(TSet.y, aixlib_AirToWaterHeatPump_3D.TSupSet) annotation (Line(points
        ={{-35.2,-30},{-30,-30},{-30,10},{-4,10},{-4,17.32},{4.9,17.32}}, color
        ={0,0,127}));
  connect(step.y, boundary1.m_flow_in)
    annotation (Line(points={{-81,4},{-52,4},{-52,15.8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAixLibHeatPump;
