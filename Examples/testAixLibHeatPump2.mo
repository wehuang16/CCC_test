within CCC_test.Examples;
model testAixLibHeatPump2
              replaceable package Medium_eva = Buildings.Media.Air;
  replaceable package Medium_con = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  replaceable model PerDataMainHP =
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
        scaleUnits_QCon={"K","K",""})
  "Performance data of a heat pump in main operation mode";
  replaceable model PerDataRevHP =
      CCC.Fluid.Chillers.BaseClasses.LookUpTableND (
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
        scaleUnits_QCon={"K","K",""})
  "Performance data of a heat pump in reversible operation mode";
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con = MediumPropyleneGlycol,
    redeclare package Medium_eva = Medium_eva,
    use_refIne=false,
    refIneFre_constant=2,
    nthOrder=2,
    mFlow_conNominal=0.5,
    VCon=0.05,
    dpCon_nominal=0,
    mFlow_evaNominal=0.5,
    VEva=0.05,
    dpEva_nominal=0,
    redeclare model PerDataMainHP =
        PerDataMainHP,
    redeclare model PerDataRevHP = PerDataRevHP,
    useBusConnectorOnly=true,
    use_conCap=false,
    use_evaCap=false)
    annotation (Placement(transformation(extent={{-14,24},{6,48}})));

  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={6,-34})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
    annotation (Placement(transformation(extent={{30,-34},{60,0}}),
        iconTransformation(extent={{-22,30},{-4,56}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium =
        MediumPropyleneGlycol,
                    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{56,46},{76,66}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium =
        MediumPropyleneGlycol,
                    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium =
        Medium_eva, m_flow_nominal=1)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium =
        Medium_eva, m_flow_nominal=1)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-66,6})));
  Modelica.Blocks.Sources.Constant TSet(final k=273.15 + 7) annotation (
      Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-100,-48})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false)
    annotation (Placement(transformation(extent={{66,-72},{86,-52}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    m_flow=0.52,
    T=285.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-122,61})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={132,45})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary3(
    redeclare package Medium = Medium_eva,
    use_T_in=false,
    m_flow=0.5,
    T=308.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={138,-11})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = Medium_eva,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-130,3})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-46,-62},{-26,-42}})));
  Modelica.Blocks.Sources.Constant nSet(final k=1) annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={20,-78})));
equation
  connect(sigBus1,heatPump. sigBus) annotation (Line(
      points={{45,-17},{45,20},{-18,20},{-18,32.1},{-13.9,32.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y,sigBus1. iceFacMea) annotation (Line(points={{14.8,-34},{26,
          -34},{26,-16.915},{45.075,-16.915}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, sigBus1.modeSet) annotation (Line(points={{87,-62},
          {92,-62},{92,-18},{45.075,-18},{45.075,-16.915}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boundary1.ports[1], TWatRet.port_a) annotation (Line(points={{-112,61},
          {-80,61},{-80,54},{-74,54}}, color={0,127,255}));
  connect(TWatSup.port_b, boundary2.ports[1]) annotation (Line(points={{76,56},
          {100,56},{100,48},{122,48},{122,45}}, color={0,127,255}));
  connect(boundary3.ports[1], TAirRet.port_a) annotation (Line(points={{128,-11},
          {128,-12},{86,-12},{86,18},{80,18}}, color={0,127,255}));
  connect(TAirSup.port_b, boundary4.ports[1]) annotation (Line(points={{-76,6},
          {-102,6},{-102,3},{-120,3}}, color={0,127,255}));
  connect(TSet.y, conPID.u_s) annotation (Line(points={{-91.2,-48},{-58,-48},{
          -58,-52},{-48,-52}}, color={0,0,127}));
  connect(conPID.y, sigBus1.nSet) annotation (Line(points={{-25,-52},{45.075,
          -52},{45.075,-16.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TWatSup.T, conPID.u_m) annotation (Line(points={{66,67},{12,67},{12,
          72},{-36,72},{-36,-64}}, color={0,0,127}));
  connect(TWatRet.port_b, heatPump.port_a1) annotation (Line(points={{-54,54},{
          -18,54},{-18,42},{-14,42}}, color={0,127,255}));
  connect(heatPump.port_b1, TWatSup.port_a) annotation (Line(points={{6,42},{50,
          42},{50,56},{56,56}}, color={0,127,255}));
  connect(heatPump.port_a2, TAirRet.port_b) annotation (Line(points={{6,30},{54,
          30},{54,18},{60,18}}, color={0,127,255}));
  connect(heatPump.port_b2, TAirSup.port_a) annotation (Line(points={{-14,30},{
          -50,30},{-50,6},{-56,6}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAixLibHeatPump2;
