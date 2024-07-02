within CCC_test.Examples;
model ZydSystem_picture

            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.MassFlowRate  m_flow_nominal=1;
parameter Modelica.Units.SI.PressureDifference  dp_nominal=1000;

  CCC.Fluid.HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{-172,146},{-152,166}})));
  CCC.Fluid.HeatExchangers.BaseClasses.CoilRegisterFourPort Pcm58(
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=1,
    Design(Tes_nominal(displayUnit="kWh") = 21600000, PCM(
        k=matPro.kPCMHig,
        c=matPro.cPCMHig,
        d=matPro.dPCMHig,
        TSol=matPro.TSolHig,
        TLiq=matPro.TLiqHig,
        LHea=matPro.LHeaHig)),
    redeclare package Medium = MediumWater,
    TStart_pcm=328.15)
    annotation (Placement(transformation(extent={{78,-28},{98,-8}})));
  CCC.Fluid.HeatExchangers.BaseClasses.CoilRegisterFourPort Pcm48(
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=1,
    Design(Tes_nominal(displayUnit="kWh") = 21600000, PCM(
        k=matPro.kPCMLow,
        c=matPro.cPCMLow,
        d=matPro.dPCMLow,
        TSol=matPro.TSolLow,
        TLiq=matPro.TLiqLow,
        LHea=matPro.LHeaLow)),
    redeclare package Medium = MediumWater,
    TStart_pcm=320.15)
    annotation (Placement(transformation(extent={{126,-108},{146,-88}})));
  CCC.Fluid.HeatExchangers.BaseClasses.CoilRegisterFourPort Pcm22(
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=1,
    Design(Tes_nominal(displayUnit="kWh") = 21600000, PCM(
        k=matPro.kPCMPas,
        c=matPro.cPCMPas,
        d=matPro.dPCMPas,
        TSol=matPro.TSolPas,
        TLiq=matPro.TLiqPas,
        LHea=matPro.LHeaPas)),
    redeclare package Medium = MediumWater,
    TStart_pcm=295.15)
    annotation (Placement(transformation(extent={{122,-184},{142,-164}})));
  Buildings.Fluid.Sources.Boundary_pT          pumpFcuWaterSupply1(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    T=308.15,
    nPorts=1)                                     "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,-256})));
  Buildings.Fluid.Storage.StratifiedEnhanced tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=m_flow_nominal,
    VTan=0.302833,
    hTan=1.2,
    dIns=0.05,
    nSeg=5,
    T_start=313.15,
    tau=1)  annotation (Placement(transformation(extent={{26,6},{46,26}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = MediumWater,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    Q_flow_nominal=3500) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,44})));
  Buildings.Fluid.Movers.SpeedControlled_y mov(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-14,4})));
  Modelica.Blocks.Interfaces.RealInput WaterHeaterHeatPumpSetpoint
    annotation (Placement(transformation(extent={{-140,24},{-100,64}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-88,44},{-68,64}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumSupTem(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal)
    "HeatPumpSupplyTemperature"
    annotation (Placement(transformation(extent={{0,86},{20,106}})));
  Modelica.Blocks.Interfaces.RealOutput WaterHeaterTankTemperatureLayer
    annotation (Placement(transformation(extent={{314,12},{332,30}}),
        iconTransformation(extent={{314,12},{332,30}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor[5]
    annotation (Placement(transformation(extent={{256,48},{276,68}})));
  CCC.Controls.HysteresisDynamic hysteresisDynamic
    annotation (Placement(transformation(extent={{-74,-70},{-54,-50}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-72,2},{-52,22}})));
  Modelica.Blocks.Interfaces.RealInput WaterHeaterTankSetpointDelta
    annotation (Placement(transformation(extent={{-142,-30},{-102,10}})));
  Modelica.Blocks.Interfaces.RealInput WaterHeaterTankSetpoint
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-188,14},{-168,34}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-182,-90},{-162,-70}})));
  Modelica.Blocks.Interfaces.RealInput OccupantHotWaterUsageFlow
    annotation (Placement(transformation(extent={{-140,-246},{-100,-206}})));
  Modelica.Blocks.Interfaces.RealInput CityWaterTemperature
    annotation (Placement(transformation(extent={{-140,-288},{-100,-248}})));
  IBPSA.Fluid.Sources.Boundary_pT sin2(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{284,100},{264,120}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort OccHotWatSupTem(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal)
    "OccupantHotWaterSupplyTemperature"
    annotation (Placement(transformation(extent={{204,100},{224,120}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumRetTem(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal) "HeatPumpReturnTemp"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,-12})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-74,-40},{-54,-20}})));
  Modelica.Blocks.Interfaces.RealInput PcmChargingNominalMassFlow
    annotation (Placement(transformation(extent={{-140,-126},{-100,-86}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           mov1(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false,
    m_flow_nominal=m_flow_nominal)
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,-46})));
  Modelica.Blocks.Interfaces.RealOutput OccupantHotWaterSupplyTemperature
    annotation (Placement(transformation(extent={{314,56},{332,74}}),
        iconTransformation(extent={{200,52},{218,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort PcmChaTemSup(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={58,0})));
  Buildings.Fluid.Sensors.TemperatureTwoPort PcmChaTem58To48(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,-52})));
  Buildings.Fluid.Sensors.TemperatureTwoPort PcmChaTem48To22(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={102,-86})));
  Buildings.Fluid.Sensors.TemperatureTwoPort PcmChaTemRet(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-152})));
  Buildings.Fluid.Sensors.TemperatureTwoPort PcmDisTem22To48(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={58,-198})));
  Buildings.Fluid.Sensors.TemperatureTwoPort PcmDisTem48To58(redeclare package
      Medium = MediumWater, m_flow_nominal=m_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={88,-54})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloHeaPum(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,72})));
  Modelica.Blocks.Interfaces.RealOutput HeatPumpThermalPower annotation (
      Placement(transformation(extent={{312,-36},{330,-18}}),
        iconTransformation(extent={{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealInput HeatPumpCOP
    annotation (Placement(transformation(extent={{-140,54},{-100,94}})));
  Modelica.Blocks.Interfaces.RealOutput HeatPumpElectricPower annotation (
      Placement(transformation(extent={{312,-56},{330,-38}}),
        iconTransformation(extent={{100,50},{118,68}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{236,-2},{256,18}})));
  Modelica.Blocks.Interfaces.RealOutput MassFlowHeatPump annotation (Placement(
        transformation(extent={{312,-72},{330,-54}}), iconTransformation(extent=
           {{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealOutput HeatPumpSupplyTemperature annotation (
      Placement(transformation(extent={{312,-88},{330,-70}}),
        iconTransformation(extent={{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealOutput HeatPumpReturnTemperature annotation (
      Placement(transformation(extent={{316,-104},{334,-86}}),
        iconTransformation(extent={{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealOutput PcmChargeTemperatureSupply annotation (
      Placement(transformation(extent={{316,36},{334,54}}), iconTransformation(
          extent={{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealOutput PcmChargeTemperatureReturn annotation (
      Placement(transformation(extent={{312,-10},{330,8}}), iconTransformation(
          extent={{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealOutput Pcm58SOC annotation (Placement(
        transformation(extent={{314,-124},{332,-106}}),
                                                      iconTransformation(extent=
           {{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealOutput Pcm48SOC annotation (Placement(
        transformation(extent={{314,-142},{332,-124}}),iconTransformation(
          extent={{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.RealOutput Pcm22SOC annotation (Placement(
        transformation(extent={{316,-164},{334,-146}}), iconTransformation(
          extent={{100,50},{118,68}})));
  Modelica.Blocks.Interfaces.BooleanInput ActiveChargingTurnOn
    annotation (Placement(transformation(extent={{-142,92},{-102,132}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = MediumWater,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=1,
    l={0.00001,0.00001})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-242})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=1,
    l={0.00001,0.00001})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={164,116})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-76,-124},{-56,-104}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-194,-132},{-174,-112}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-54,44},{-34,64}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-96,82},{-76,102}})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloCityToTank(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-26,-186})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloTankToOccupant(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={58,118})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloPcmChargingReturn(redeclare
      package Medium = MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-98})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloPcmChargingSupply(redeclare
      package Medium = MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={42,40})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloCityToPcm(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={48,-246})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloPcmToOccupant(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,98})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           mov2(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false,
    m_flow_nominal=m_flow_nominal)
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-54,-300})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-68,132},{-48,152}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{-222,114},{-202,134}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{-218,74},{-198,94}})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=1,
    f=0.00833333333,
    offset=0.5)
    annotation (Placement(transformation(extent={{696,78},{716,98}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{616,110},{636,130}})));
  Modelica.Blocks.Sources.Constant const5(k=1)
    annotation (Placement(transformation(extent={{620,60},{640,80}})));
  CCC.Controls.realSwitch realSwitch2
    annotation (Placement(transformation(extent={{748,62},{768,82}})));
equation
  connect(hea.port_a, mov.port_b) annotation (Line(points={{-8,34},{-8,26},{-14,
          26},{-14,14}}, color={0,127,255}));
  connect(WaterHeaterHeatPumpSetpoint, conPID.u_s) annotation (Line(points={{-120,44},
          {-94,44},{-94,38},{-90,38},{-90,54}},
                                           color={0,0,127}));
  connect(HeaPumSupTem.port_b, tan.port_a)
    annotation (Line(points={{20,96},{26,96},{26,16}}, color={0,127,255}));
  connect(HeaPumSupTem.T, conPID.u_m) annotation (Line(points={{10,107},{10,106},
          {-40,106},{-40,32},{-78,32},{-78,42}}, color={0,0,127}));
  connect(tan.heaPorVol, temperatureSensor.port) annotation (Line(points={{36,16},
          {94,16},{94,76},{256,76},{256,58}},       color={191,0,0}));
  connect(temperatureSensor[1].T, WaterHeaterTankTemperatureLayer)
    annotation (Line(points={{277,58},{323,58},{323,21}}, color={0,0,127}));
  connect(temperatureSensor[4].T, hysteresisDynamic.u) annotation (Line(points={{277,58},
          {306,58},{306,-72},{64,-72},{64,-80},{-76,-80},{-76,-60}},
                                                        color={0,0,127}));
  connect(booleanToReal.y, hea.u) annotation (Line(points={{-51,12},{-30,12},{
          -30,32},{-14,32}},             color={0,0,127}));
  connect(WaterHeaterTankSetpoint, add1.u1) annotation (Line(points={{-120,-60},
          {-166,-60},{-166,-56},{-206,-56},{-206,-74},{-184,-74}}, color={0,0,127}));
  connect(WaterHeaterTankSetpoint, add.u1) annotation (Line(points={{-120,-60},{
          -176,-60},{-176,-30},{-220,-30},{-220,30},{-190,30}}, color={0,0,127}));
  connect(WaterHeaterTankSetpointDelta, add.u2) annotation (Line(points={{-122,-10},
          {-156,-10},{-156,-12},{-190,-12},{-190,18}}, color={0,0,127}));
  connect(WaterHeaterTankSetpointDelta, add1.u2) annotation (Line(points={{-122,
          -10},{-178,-10},{-178,-18},{-226,-18},{-226,-86},{-184,-86}}, color={0,
          0,127}));
  connect(add1.y, hysteresisDynamic.uHigh) annotation (Line(points={{-161,-80},{
          -146,-80},{-146,-86},{-80,-86},{-80,-76},{-76,-76},{-76,-67.6}},
        color={0,0,127}));
  connect(add.y, hysteresisDynamic.uLow) annotation (Line(points={{-167,24},{-124,
          24},{-124,16},{-82,16},{-82,-53.2},{-76,-53.2}}, color={0,0,127}));
  connect(OccHotWatSupTem.port_b, sin2.ports[1]) annotation (Line(points={{224,110},
          {264,110}},                          color={0,127,255}));
  connect(tan.port_b, HeaPumRetTem.port_a)
    annotation (Line(points={{46,16},{46,-12},{20,-12}},color={0,127,255}));
  connect(HeaPumRetTem.port_b, mov.port_a) annotation (Line(points={{-1.77636e-15,
          -12},{-14,-12},{-14,-6}}, color={0,127,255}));
  connect(hysteresisDynamic.y, not1.u) annotation (Line(points={{-53,-60},{-53,-42},
          {-84,-42},{-84,-30},{-76,-30}}, color={255,0,255}));
  connect(not1.y, booleanToReal.u) annotation (Line(points={{-53,-30},{-48,-30},
          {-48,-12},{-84,-12},{-84,12},{-74,12}},
                                        color={255,0,255}));
  connect(pumpFcuWaterSupply1.T_in, CityWaterTemperature) annotation (Line(
        points={{-84,-252},{-98,-252},{-98,-134},{-120,-134},{-120,-268}},color=
         {0,0,127}));
  connect(mov1.port_b, tan.port_b) annotation (Line(points={{26,-36},{26,-12},{
          46,-12},{46,16}},
                        color={0,127,255}));
  connect(OccHotWatSupTem.T, OccupantHotWaterSupplyTemperature) annotation (
      Line(points={{214,121},{214,124},{323,124},{323,65}},          color={0,0,
          127}));
  connect(PcmChaTemSup.port_b, Pcm58.port_a1) annotation (Line(points={{58,-10},
          {58,-13.8},{78,-13.8}}, color={0,127,255}));
  connect(Pcm58.port_b1, PcmChaTem58To48.port_a) annotation (Line(points={{98,
          -13.8},{104,-13.8},{104,-34},{44,-34},{44,-42}}, color={0,127,255}));
  connect(PcmChaTem58To48.port_b, Pcm48.port_a1) annotation (Line(points={{44,-62},
          {44,-64},{48,-64},{48,-76},{60,-76},{60,-68},{126,-68},{126,-93.8}},
                                       color={0,127,255}));
  connect(PcmChaTem48To22.port_a, Pcm48.port_b1) annotation (Line(points={{102,-76},
          {156,-76},{156,-93.8},{146,-93.8}},             color={0,127,255}));
  connect(PcmChaTem48To22.port_b, Pcm22.port_a1) annotation (Line(points={{102,-96},
          {102,-169.8},{122,-169.8}},                         color={0,127,255}));
  connect(PcmChaTemRet.port_a, Pcm22.port_b1) annotation (Line(points={{22,-162},
          {22,-172},{116,-172},{116,-160},{128,-160},{128,-156},{142,-156},{142,
          -169.8}},                                     color={0,127,255}));
  connect(PcmDisTem22To48.port_a, Pcm22.port_b2) annotation (Line(points={{58,-208},
          {58,-212},{122,-212},{122,-178.2}},                 color={0,127,255}));
  connect(PcmDisTem22To48.port_b, Pcm48.port_a2) annotation (Line(points={{58,-188},
          {112,-188},{112,-116},{156,-116},{156,-102.2},{146,-102.2}},color={0,
          127,255}));
  connect(Pcm48.port_b2, PcmDisTem48To58.port_a) annotation (Line(points={{126,
          -102.2},{88,-102.2},{88,-64}},        color={0,127,255}));
  connect(PcmDisTem48To58.port_b, Pcm58.port_a2) annotation (Line(points={{88,
          -44},{118,-44},{118,-22.2},{98,-22.2}}, color={0,127,255}));
  connect(hea.port_b, MasFloHeaPum.port_a)
    annotation (Line(points={{-8,54},{-8,62}}, color={0,127,255}));
  connect(MasFloHeaPum.port_b, HeaPumSupTem.port_a)
    annotation (Line(points={{-8,82},{-8,96},{0,96}}, color={0,127,255}));
  connect(division.y, HeatPumpElectricPower) annotation (Line(points={{257,8},{
          302,8},{302,-47},{321,-47}}, color={0,0,127}));
  connect(hea.Q_flow, HeatPumpThermalPower) annotation (Line(points={{-14,55},{
          182,55},{182,42},{284,42},{284,-27},{321,-27}},
                                                        color={0,0,127}));
  connect(hea.Q_flow, division.u1) annotation (Line(points={{-14,55},{70,55},{
          70,42},{112,42},{112,14},{234,14}}, color={0,0,127}));
  connect(HeatPumpCOP, division.u2) annotation (Line(points={{-120,74},{110,74},
          {110,2},{234,2}}, color={0,0,127}));
  connect(MasFloHeaPum.m_flow, MassFlowHeatPump) annotation (Line(points={{-19,72},
          {92,72},{92,58},{208,58},{208,-2},{226,-2},{226,-20},{282,-20},{282,
          -63},{321,-63}},     color={0,0,127}));
  connect(HeaPumSupTem.T, HeatPumpSupplyTemperature) annotation (Line(points={{10,107},
          {10,-30},{308,-30},{308,-74},{306,-74},{306,-79},{321,-79}},
                               color={0,0,127}));
  connect(HeaPumRetTem.T, HeatPumpReturnTemperature) annotation (Line(points={{10,-23},
          {10,-24},{184,-24},{184,-38},{236,-38},{236,-95},{325,-95}},
        color={0,0,127}));
  connect(PcmChaTemSup.T, PcmChargeTemperatureSupply) annotation (Line(points={{69,
          -2.05391e-15},{216,-2.05391e-15},{216,32},{304,32},{304,45},{325,45}},
                                                                   color={0,0,
          127}));
  connect(PcmChaTemRet.T, PcmChargeTemperatureReturn) annotation (Line(points={{11,-152},
          {8,-152},{8,-132},{96,-132},{96,-160},{308,-160},{308,-172},{321,-172},
          {321,-1}},                         color={0,0,127}));
  connect(Pcm58.SOC, Pcm58SOC) annotation (Line(points={{99,-27},{104,-27},{104,
          -48},{248,-48},{248,-115},{323,-115}},           color={0,0,127}));
  connect(Pcm48SOC, Pcm48.SOC)
    annotation (Line(points={{323,-133},{147,-133},{147,-107}},
                                                             color={0,0,127}));
  connect(Pcm22SOC, Pcm22.SOC) annotation (Line(points={{325,-155},{325,-183},{
          143,-183}},                                          color={0,0,127}));
  connect(val1.port_2, OccHotWatSupTem.port_a)
    annotation (Line(points={{174,116},{174,110},{204,110}},
                                                 color={0,127,255}));
  connect(PcmChargingNominalMassFlow, switch1.u1)
    annotation (Line(points={{-120,-106},{-78,-106}}, color={0,0,127}));
  connect(switch1.y, mov1.m_flow_in) annotation (Line(points={{-55,-114},{-40,
          -114},{-40,-46},{14,-46}}, color={0,0,127}));
  connect(const.y, switch1.u3) annotation (Line(points={{-173,-122},{-142,-122},
          {-142,-128},{-86,-128},{-86,-122},{-78,-122}}, color={0,0,127}));
  connect(ActiveChargingTurnOn, switch1.u2) annotation (Line(points={{-122,112},
          {-122,12},{-88,12},{-88,-114},{-78,-114}}, color={255,0,255}));
  connect(const1.y, switch2.u3) annotation (Line(points={{-75,92},{-68,92},{-68,
          66},{-64,66},{-64,38},{-56,38},{-56,46}}, color={0,0,127}));
  connect(conPID.y, switch2.u1) annotation (Line(points={{-67,54},{-62,54},{-62,
          62},{-56,62}}, color={0,0,127}));
  connect(switch2.y, mov.y) annotation (Line(points={{-33,54},{-28,54},{-28,10},
          {-34,10},{-34,4},{-26,4}}, color={0,0,127}));
  connect(not1.y, switch2.u2) annotation (Line(points={{-53,-30},{-48,-30},{-48,
          -12},{-84,-12},{-84,34},{-64,34},{-64,70},{-56,70},{-56,54}}, color={
          255,0,255}));
  connect(MasFloCityToTank.port_b, tan.port_b) annotation (Line(points={{-16,
          -186},{-16,-34},{12,-34},{12,-28},{26,-28},{26,-12},{46,-12},{46,16}},
        color={0,127,255}));
  connect(val1.port_1, MasFloTankToOccupant.port_b)
    annotation (Line(points={{154,116},{116,116},{116,118},{68,118}},
                                                  color={0,127,255}));
  connect(MasFloTankToOccupant.port_a, tan.port_a)
    annotation (Line(points={{48,118},{26,118},{26,16}}, color={0,127,255}));
  connect(mov1.port_a, MasFloPcmChargingReturn.port_b)
    annotation (Line(points={{26,-56},{22,-56},{22,-88}}, color={0,127,255}));
  connect(MasFloPcmChargingReturn.port_a, PcmChaTemRet.port_b)
    annotation (Line(points={{22,-108},{22,-142}}, color={0,127,255}));
  connect(tan.port_a, MasFloPcmChargingSupply.port_a)
    annotation (Line(points={{26,16},{26,40},{32,40}}, color={0,127,255}));
  connect(MasFloPcmChargingSupply.port_b, PcmChaTemSup.port_a)
    annotation (Line(points={{52,40},{58,40},{58,10}}, color={0,127,255}));
  connect(MasFloCityToPcm.port_b, Pcm22.port_a2) annotation (Line(points={{58,-246},
          {142,-246},{142,-178.2}},
                    color={0,127,255}));
  connect(Pcm58.port_b2, MasFloPcmToOccupant.port_a) annotation (Line(points={{78,
          -22.2},{78,98},{96,98}},                 color={0,127,255}));
  connect(MasFloPcmToOccupant.port_b, val1.port_3) annotation (Line(points={{116,98},
          {116,106},{164,106}},          color={0,127,255}));
  connect(pumpFcuWaterSupply1.ports[1], mov2.port_a) annotation (Line(points={{
          -62,-256},{-62,-300},{-64,-300}}, color={0,127,255}));
  connect(mov2.port_b, val.port_2) annotation (Line(points={{-44,-300},{-36,
          -300},{-36,-302},{-10,-302},{-10,-252}}, color={0,127,255}));
  connect(OccupantHotWaterUsageFlow, mov2.m_flow_in) annotation (Line(points={{
          -120,-226},{-86,-226},{-86,-228},{-54,-228},{-54,-288}}, color={0,0,
          127}));
  connect(val.port_1, MasFloCityToTank.port_a) annotation (Line(points={{-10,
          -232},{-10,-120},{-36,-120},{-36,-186}}, color={0,127,255}));
  connect(val.port_3, MasFloCityToPcm.port_a) annotation (Line(points={{-20,
          -242},{-20,-218},{38,-218},{38,-246}}, color={0,127,255}));
  connect(const2.y, switch3.u1) annotation (Line(points={{-201,124},{-136,124},
          {-136,150},{-70,150}}, color={0,0,127}));
  connect(const3.y, switch3.u3) annotation (Line(points={{-197,84},{-132,84},{
          -132,134},{-70,134}}, color={0,0,127}));
  connect(ActiveChargingTurnOn, switch3.u2) annotation (Line(points={{-122,112},
          {-122,12},{-80,12},{-80,30},{-70,30},{-70,40},{-62,40},{-62,118},{-70,
          118},{-70,142}}, color={255,0,255}));
  connect(switch3.y, val1.y)
    annotation (Line(points={{-47,142},{164,142},{164,128}}, color={0,0,127}));
  connect(switch3.y, val.y) annotation (Line(points={{-47,142},{-44,142},{-44,
          122},{2,122},{2,-242}}, color={0,0,127}));
  connect(const4.y,realSwitch2. u1) annotation (Line(points={{637,120},{736,120},
          {736,78.2},{746,78.2}},                  color={0,0,127}));
  connect(sine.y,realSwitch2. u2) annotation (Line(points={{717,88},{740,88},{
          740,71},{746,71}}, color={0,0,127}));
  connect(const5.y,realSwitch2. u3) annotation (Line(points={{641,70},{728,70},
          {728,63.8},{745.8,63.8}},         color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{200,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,
            100}})));
end ZydSystem_picture;
