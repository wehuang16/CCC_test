within CCC_test.CCC_Model;
model Aixlib_AirToWaterHeatPump_3D_archived_08142024
              replaceable package Medium_eva = Buildings.Media.Air;
  replaceable package Medium_con = Buildings.Media.Water;
  parameter Modelica.Units.SI.Temperature Tinit = 305.15;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.MassFlowRate  mEva_flow_nominal=2.333;
  parameter Modelica.Units.SI.MassFlowRate  mCon_flow_nominal=0.92;
  parameter Modelica.Units.SI.PressureDifference  dp_nominal=100 "nominal pressure drop through each piece of equipment";
  replaceable model PerDataMainHP =
      CCC.Fluid.HeatPumps.BaseClasses.LookUpTableND_AirToWater (
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
        scaleUnits_QCon={"K","K",""})
  "Performance data of a heat pump in reversible operation mode";
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con = Medium_con,
    redeclare package Medium_eva = Medium_eva,
    scalingFactor=0.80,
    use_refIne=false,
    mFlow_conNominal=mCon_flow_nominal,
    VCon=0.05,
    dpCon_nominal=dp_nominal,
    mFlow_evaNominal=mEva_flow_nominal,
    VEva=0.05,
    dpEva_nominal=dp_nominal,
    TCon_start=Tinit,
    redeclare model PerDataMainHP =
        PerDataMainHP,
    redeclare model PerDataRevHP = PerDataRevHP,
    useBusConnectorOnly=true,
    use_conCap=false,
    use_evaCap=false)
    annotation (Placement(transformation(extent={{-12,24},{8,48}})));

  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={10,6})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
    annotation (Placement(transformation(extent={{26,-20},{60,16}}),
        iconTransformation(extent={{-22,30},{-4,56}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium_con) annotation (Placement(transformation(extent={{96,48},{116,68}}),
        iconTransformation(extent={{98,58},{118,78}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium_con) annotation (Placement(transformation(extent={{-112,46},{-92,
            66}}), iconTransformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (Placement(
        transformation(extent={{-126,-82},{-102,-58}}), iconTransformation(
          extent={{-122,-50},{-100,-28}})));
  Modelica.Blocks.Interfaces.BooleanInput Mode
    "Current operation mode: true: main operation mode, false: reversible operation mode"
    annotation (Placement(transformation(extent={{126,-14},{102,10}}),
        iconTransformation(extent={{124,8},{100,32}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium =
        Medium_con, m_flow_nominal=1,
    T_start=Tinit)
    annotation (Placement(transformation(extent={{72,48},{92,68}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium =
        Medium_con, m_flow_nominal=1,
    T_start=Tinit)
    annotation (Placement(transformation(extent={{-48,46},{-28,66}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium =
        Medium_eva, m_flow_nominal=1)
                   annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,30})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium =
        Medium_eva, m_flow_nominal=1)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-66,30})));
  Modelica.Blocks.Logical.Switch ModeSwitch
    annotation (Placement(transformation(extent={{-62,-70},{-42,-50}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-18,-70},{2,-50}})));
  Modelica.Blocks.Logical.Switch ModeSwitch1
    annotation (Placement(transformation(extent={{-30,-136},{-10,-116}})));
  Modelica.Blocks.Interfaces.RealInput TOutAir
    annotation (Placement(transformation(extent={{126,-58},{100,-32}}),
        iconTransformation(extent={{126,-46},{100,-20}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     boundary3(
    redeclare package Medium = Medium_eva,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=false,
    m_flow_nominal=mEva_flow_nominal)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={88,-75})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = Medium_eva,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-116,-21})));
  Modelica.Blocks.Sources.Constant const1(k=mEva_flow_nominal)
    annotation (Placement(transformation(extent={{160,-20},{140,0}})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-112,32}),
        iconTransformation(extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-112,20})));
  Modelica.Blocks.Logical.Switch OnOffSwitch
    annotation (Placement(transformation(extent={{14,-78},{34,-58}})));
  Modelica.Blocks.Sources.Constant const(final k=0) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={4,-98})));

  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium_con)
    annotation (Placement(transformation(extent={{-86,46},{-66,66}})));
  Modelica.Blocks.Interfaces.RealOutput QCon
    "Name is a bit confusing, but this represents the useful heat flow of the heat exchanger: this will be condenser hear flow for heating, and evaporator heat flow for cooling"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-74,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-85,111})));
  Modelica.Blocks.Interfaces.RealOutput QEva
    "Name is a bit confusing, but this represents the non-useful heat flow of the heat exchanger: this will be evaporator hear flow for heating, and condenser heat flow for cooling"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-50,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-53,111})));
  Modelica.Blocks.Interfaces.RealOutput Pel
    "electricity consumption of the heat pump" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-22,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-19,111})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=heatPump.innerCycle.QCon)
    annotation (Placement(transformation(extent={{-176,94},{-156,114}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=heatPump.innerCycle.QEva)
    annotation (Placement(transformation(extent={{-102,126},{-82,146}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=heatPump.innerCycle.Pel)
    annotation (Placement(transformation(extent={{-44,126},{-24,146}})));
  Modelica.Blocks.Interfaces.RealOutput QHeating
    "Heat pump thermal power during heating mode. Zero if in cooling mode."
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={28,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={31,111})));
  Modelica.Blocks.Interfaces.RealOutput QCooling
    "Heat pump thermal power during cooling mode. Zero if in heating mode."
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={60,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={59,111})));
  CCC.Controls.SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{-138,82},{-118,102}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Medium_eva,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={140,-71})));
  Modelica.Blocks.Logical.Switch EvaFanOnOff
    annotation (Placement(transformation(extent={{30,-162},{50,-142}})));
  Modelica.Blocks.Sources.Constant const2(final k=0)
                                                    annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-34,-170})));
  Modelica.Blocks.Interfaces.RealOutput EvaFanPow
    "electricity consumption of the evaporator fan" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={76,-112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=270,
        origin={65,-111})));
  Modelica.Blocks.Interfaces.RealOutput COP annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={90,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={85,111})));
  CCC.Controls.calculateCOP calculateCOP
    annotation (Placement(transformation(extent={{140,68},{160,88}})));
  Modelica.Blocks.Interfaces.RealInput TWatOut annotation (Placement(
        transformation(extent={{-122,-92},{-100,-70}}), iconTransformation(
          extent={{-122,-92},{-100,-70}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium_con,
    T_start=Tinit,
    m_flow_nominal=1,
    V=0.04,
    nPorts=2)
    annotation (Placement(transformation(extent={{50,56},{30,36}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow(
        displayUnit="kW") = -2000)
    annotation (Placement(transformation(extent={{134,36},{114,56}})));
  CCC.Controls.HPController hPController(delayTime=180, desTLow=-5)
    annotation (Placement(transformation(extent={{-180,-140},{-140,-100}})));
  parameter Modelica.Units.SI.Time Ti=600 "Time constant of Integrator block";
  parameter Real k=0.01 "Gain of controller";
equation
  connect(sigBus1,heatPump.sigBus) annotation (Line(
      points={{43,-2},{43,20},{-18,20},{-18,32.1},{-11.9,32.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y,sigBus1.iceFacMea) annotation (Line(points={{18.8,6},{6,6},{
          6,-1.91},{43.085,-1.91}},       color={0,0,127}), Text,
    sigBus1(       iceFacMea));
  connect(Mode, sigBus1.modeSet) annotation (Line(points={{114,-2},{66,-2},{66,
          -1.91},{43.085,-1.91}},
                             color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TWatRet.port_b, heatPump.port_a1) annotation (Line(points={{-28,56},{-18,
          56},{-18,42},{-12,42}}, heatPump(
                          port_a1))         annotation (Line(points={{-28,56},{
          -18,56},{-18,42},{-12,42}},
                                  color={0,127,255})));
  connect(TWatSup.port_b, port_b) annotation (Line(points={{92,58},{106,58}},
                     color={0,127,255}));
  connect(heatPump.port_a2, TAirRet.port_b) annotation (Line(points={{8,30},{60,
          30}},                 color={0,127,255}));
  connect(heatPump.port_b2, TAirSup.port_a) annotation (Line(points={{-12,30},{
          -56,30}},             color={0,127,255}));
  connect(TSupSet, ModeSwitch.u1) annotation (Line(points={{-114,-70},{-76,-70},
          {-76,-52},{-64,-52}},                     color={0,0,127}));
  connect(TSupSet, ModeSwitch1.u3) annotation (Line(points={{-114,-70},{-46,-70},
          {-46,-134},{-32,-134}}, color={0,0,127}));
  connect(ModeSwitch.y, conPID.u_s) annotation (Line(points={{-41,-60},{-26,-60},
          {-26,-60},{-20,-60}}, color={0,0,127}));
  connect(ModeSwitch1.y, conPID.u_m) annotation (Line(points={{-9,-126},{-8,
          -126},{-8,-72}},           color={0,0,127}));
  connect(Mode, ModeSwitch.u2) annotation (Line(points={{114,-2},{66,-2},{66,-44},
          {-64,-44},{-64,-60}},      color={255,0,255}));
  connect(Mode, ModeSwitch1.u2) annotation (Line(points={{114,-2},{66,-2},{66,
          -44},{-42,-44},{-42,-126},{-32,-126}}, color={255,0,255}));
  connect(TAirSup.port_b, boundary4.ports[1]) annotation (Line(points={{-76,30},
          {-94,30},{-94,-21},{-106,-21}},
                                        color={0,127,255}));
  connect(conPID.y, OnOffSwitch.u1) annotation (Line(points={{3,-60},{12,-60}},
                              color={0,0,127}));
  connect(const.y, OnOffSwitch.u3) annotation (Line(points={{10.6,-98},{18,-98},
          {18,-84},{12,-84},{12,-76}}, color={0,0,127}));
  connect(port_a, senMasFlo.port_a) annotation (Line(points={{-102,56},{-86,56}},
                              color={0,127,255}));
  connect(senMasFlo.port_b, TWatRet.port_a) annotation (Line(points={{-66,56},{
          -48,56}},                   color={0,127,255}));
  connect(QEva, QEva)
    annotation (Line(points={{-50,112},{-50,112}}, color={0,0,127}));
  connect(realExpression.y, QCon) annotation (Line(points={{-155,104},{-72,104},
          {-72,102},{-74,102},{-74,112}},
                                color={0,0,127}));
  connect(realExpression1.y, QEva)
    annotation (Line(points={{-81,136},{-50,136},{-50,112}}, color={0,0,127}));
  connect(realExpression2.y, Pel) annotation (Line(points={{-23,136},{-22,136},
          {-22,112}},         color={0,0,127}));
  connect(realExpression.y, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-155,104},{-155,92},{-140,92}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy, QHeating)
    annotation (Line(points={{-116,95.6},{28,95.6},{28,112}},
        color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy, QCooling)
    annotation (Line(points={{-116,86.2},{60,86.2},{60,112}},
        color={0,0,127}));
  connect(TAirRet.port_a, boundary3.port_b) annotation (Line(points={{80,30},{
          86,30},{86,-60},{72,-60},{72,-75},{78,-75}},
                                                    color={0,127,255}));
  connect(boundary1.ports[1], boundary3.port_a) annotation (Line(points={{130,-71},
          {130,-75},{98,-75}}, color={0,127,255}));
  connect(TOutAir, boundary1.T_in) annotation (Line(points={{113,-45},{113,-46},
          {164,-46},{164,-67.4},{152,-67.4}}, color={0,0,127}));
  connect(const1.y, boundary3.m_flow_in) annotation (Line(points={{139,-10},{88,
          -10},{88,-64.2}},                   color={0,0,127}));
  connect(boundary3.P, EvaFanOnOff.u1) annotation (Line(points={{77,-66.9},{68,
          -66.9},{68,-94},{28,-94},{28,-144}},           color={0,0,127}));
  connect(const2.y, EvaFanOnOff.u3) annotation (Line(points={{-27.4,-170},{20,-170},
          {20,-160},{28,-160}},
                            color={0,0,127}));
  connect(EvaFanOnOff.y, EvaFanPow) annotation (Line(points={{51,-152},{76,-152},
          {76,-112}},                               color={0,0,127}));
  connect(realExpression.y, calculateCOP.QUse) annotation (Line(points={{-155,104},
          {-92,104},{-92,112},{-88,112},{-88,98},{-4,98},{-4,83},{138,83}},
        color={0,0,127}));
  connect(realExpression2.y, calculateCOP.ElePow) annotation (Line(points={{-23,136},
          {-2,136},{-2,76},{128,76},{128,72},{138,72}},      color={0,0,127}));
  connect(calculateCOP.COP, COP) annotation (Line(points={{161,78.2},{178,78.2},
          {178,112},{90,112}}, color={0,0,127}));
  connect(OnOffSwitch.y, sigBus1.nSet) annotation (Line(points={{35,-68},{42,-68},
          {42,-40},{43.085,-40},{43.085,-1.91}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TWatOut, ModeSwitch.u3) annotation (Line(points={{-111,-81},{-64,-81},
          {-64,-68},{-64,-68}}, color={0,0,127}));
  connect(TWatOut, ModeSwitch1.u1) annotation (Line(points={{-111,-81},{-64,-81},
          {-64,-118},{-32,-118}}, color={0,0,127}));
  connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{114,46},{
          50,46}},                            color={191,0,0}));
  connect(TWatSup.port_a, vol.ports[1])
    annotation (Line(points={{72,58},{41,58},{41,56}}, color={0,127,255}));
  connect(vol.ports[2], heatPump.port_b1) annotation (Line(points={{39,56},{39,
          58},{16,58},{16,42},{8,42}}, color={0,127,255}));
  connect(OnOff, hPController.OnOff) annotation (Line(points={{-112,32},{-160,
          32},{-160,-96}}, color={255,0,255}));
  connect(hPController.SwitchSet, EvaFanOnOff.u2) annotation (Line(points={{
          -138,-120},{-84,-120},{-84,-152},{28,-152}}, color={255,0,255}));
  connect(hPController.SwitchSet, OnOffSwitch.u2) annotation (Line(points={{
          -138,-120},{-84,-120},{-84,-152},{-4,-152},{-4,-68},{12,-68}}, color=
          {255,0,255}));
  connect(TSupSet, hPController.TWatSet) annotation (Line(points={{-114,-70},{
          -114,-148},{-194,-148},{-194,-132},{-184,-132}}, color={0,0,127}));
  connect(TWatRet.T, hPController.TWatIn) annotation (Line(points={{-38,67},{
          -38,76},{-202,76},{-202,-124},{-184,-124}}, color={0,0,127}));
  connect(TWatSup.T, hPController.TWatOut) annotation (Line(points={{82,69},{82,
          72},{-198,72},{-198,-116},{-184,-116}}, color={0,0,127}));
  connect(senMasFlo.m_flow, hPController.FlowRate) annotation (Line(points={{
          -76,67},{-76,70},{-194,70},{-194,-108},{-184,-108}}, color={0,0,127}));
                                       annotation (Line(points={{18.8,6},{
          45.075,6},{45.075,-16.915}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>In reverse operation mode, the condenser becomes the evaporator, and the evaporator becomes the condenser.</p>
</html>"));
end Aixlib_AirToWaterHeatPump_3D_archived_08142024;
