within CCC_test.Examples;
model testAixLibHeatPump
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con = MediumPropyleneGlycol,
    redeclare package Medium_eva = MediumAir,
    mFlow_conNominal=0.5,
    VCon=0.4,
    dpCon_nominal=0,
    mFlow_evaNominal=0.5,
    VEva=0.04,
    dpEva_nominal=0,
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
        AixLib.DataBase.Chiller.PerformanceData.LookUpTableND (
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
        scaleUnits_QCon={"K","K",""}),
    useBusConnectorOnly=true,
    use_conCap=false,
    use_evaCap=false)
    annotation (Placement(transformation(extent={{4,0},{24,24}})));


  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={80,21})));
  Modelica.Blocks.Sources.Constant const1(k=0.06393)
    annotation (Placement(transformation(extent={{-60,56},{-40,76}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-0.3,
    duration=4320,
    offset=0.8,
    startTime=2160)
    annotation (Placement(transformation(extent={{-94,10},{-74,30}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    m_flow=0.05,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-42,23})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,-44})));
  Modelica.Blocks.Sources.Constant nSet(final k=1)
    "Relative rotational speed of compressor between 0 and 1"
                                                   annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-56,-20})));
  Modelica.Blocks.Sources.BooleanConstant modeSet
    "Current operation mode: true: main operation mode, false: reversible operation mode"
    annotation (Placement(transformation(extent={{-48,-86},{-28,-66}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary3(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    m_flow=0.2,
    T=283.15,
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
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
    annotation (Placement(transformation(extent={{20,-44},{50,-10}}),
        iconTransformation(extent={{-22,30},{-4,56}})));
equation
  connect(boundary1.ports[1], heatPump.port_a1) annotation (Line(points={{-32,23},
          {-4,23},{-4,18},{4,18}},     color={0,127,255}));
  connect(heatPump.port_b1, boundary2.ports[1]) annotation (Line(points={{24,18},
          {64,18},{64,21},{70,21}}, color={0,127,255}));
  connect(boundary4.ports[1], heatPump.port_b2) annotation (Line(points={{-74,-25},
          {-74,-26},{-70,-26},{-70,-48},{-24,-48},{-24,6},{4,6}},      color={0,
          127,255}));
  connect(heatPump.port_a2, boundary3.ports[1]) annotation (Line(points={{24,6},{
          72,6},{72,-35},{76,-35}},  color={0,127,255}));
  connect(sigBus1, heatPump.sigBus) annotation (Line(
      points={{35,-27},{35,-4},{-2,-4},{-2,8.1},{4.1,8.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y, sigBus1.iceFacMea) annotation (Line(points={{4.8,-44},{16,-44},
          {16,-26.915},{35.075,-26.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nSet.y, sigBus1.nSet) annotation (Line(points={{-47.2,-20},{14,-20},{14,
          -26.915},{35.075,-26.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeSet.y, sigBus1.modeSet) annotation (Line(points={{-27,-76},{35.075,
          -76},{35.075,-26.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAixLibHeatPump;
