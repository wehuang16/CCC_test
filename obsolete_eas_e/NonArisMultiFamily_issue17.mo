within CCC_test.obsolete_eas_e;
model NonArisMultiFamily_issue17
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating_old datTabHea;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling_old datTabCoo;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating_old
    datTabHeaHpwh;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling_old
    datTabCooHpwh;

    parameter Modelica.Units.SI.MassFlowRate mTankHx_flow_nominal=0.5
    "Water tank heat exchanger glycol nominal mass flow rate";
      parameter Modelica.Units.SI.MassFlowRate mOccupant_flow_nominal=0.126
    "Occupant hot water usage nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mMultiSplit_flow_nominal=0.3
    "Fan coil units total glycol nominal mass flow rate";
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{62,-2},{82,18}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{14,74},{34,94}})));
  Buildings.Fluid.Sources.MassFlowSource_T           freshAirCor(
    redeclare package Medium = MediumAir,
    m_flow=0.2,
    use_T_in=true,
    T=283.15,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,64})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={90,75})));
  CCC_test.Examples.ReversibleAirToWaterEuropeanNorm2D_withPowerData
    reversibleAirToWaterEuropeanNorm2D_withPowerData(
    redeclare package MediumCon = MediumAir,
    redeclare package MediumEva = MediumAir,
    QUse_flow_nominal=3000,
    y_nominal=1,
    TCon_nominal=333.15,
    dpCon_nominal=2000,
    TEva_nominal=293.15,
    dpEva_nominal=2000,                               datTabHea=datTabHea,
    datTabCoo=datTabCoo)
    annotation (Placement(transformation(extent={{-10,-12},{10,12}},
        rotation=180,
        origin={8,32})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumAir,
    m_flow_nominal={mMultiSplit_flow_nominal,-mMultiSplit_flow_nominal/3,-
        mMultiSplit_flow_nominal*2/3},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,-78})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = MediumAir,
    m_flow_nominal={mMultiSplit_flow_nominal*2/3,-mMultiSplit_flow_nominal/3,-
        mMultiSplit_flow_nominal/3},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-8,-182})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{140,18},{160,38}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    nPorts=4) annotation (Placement(transformation(extent={{328,34},{368,74}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="FlexLab-X3-ZoneA-Core-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    nPorts=4)
    annotation (Placement(transformation(extent={{352,-40},{392,0}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone sou(
    zoneName="FlexLab-X3-ZoneA-South-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    nPorts=4)
    annotation (Placement(transformation(extent={{384,-120},{424,-80}})));
  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{150,56},{170,76}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm(
    redeclare package Medium = MediumAir,
    p=101300,
    nPorts=3)   "Boundary condition"
    annotation (Placement(transformation(extent={{206,-72},{226,-52}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducNor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*nor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{270,30},{250,50}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducCor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*cor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{270,-74},{250,-54}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducSou(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*sou.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{266,-150},{246,-130}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirNor(
    redeclare package Medium = MediumAir,
    m_flow=0.3*nor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{260,-6},{280,14}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirCor2(
    redeclare package Medium = MediumAir,
    m_flow=0.3*cor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{274,-56},{294,-36}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirSou(
    redeclare package Medium = MediumAir,
    m_flow=0.3*sou.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{278,-120},{298,-100}})));
  Modelica.Blocks.Routing.RealPassThrough TOut
    annotation (Placement(transformation(extent={{492,-64},{512,-44}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{440,-70},{460,-50}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fanMultiSplitAirSupply1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.136,
    nominalValuesDefineDefaultPressureCurve=true) "Fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={24,-88})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = MediumAir,
    m_flow_nominal={mMultiSplit_flow_nominal*2/3,-mMultiSplit_flow_nominal,
        mMultiSplit_flow_nominal/3},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={68,-32})));
  Buildings.Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = MediumAir,
    m_flow_nominal={mMultiSplit_flow_nominal/3,-mMultiSplit_flow_nominal*2/3,
        mMultiSplit_flow_nominal/3},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={136,-72})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fanMultiSplitAirSupply2(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.136,
    nominalValuesDefineDefaultPressureCurve=true) "Fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,-154})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fanMultiSplitAirSupply3(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.136,
    nominalValuesDefineDefaultPressureCurve=true) "Fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={172,-212})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempMultiSplitSysAirSupply(
      redeclare package Medium = MediumAir) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-54,-6})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempMultiSplitSysAirReturn(
      redeclare package Medium = MediumAir) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,-4})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=6000,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=mTankHx_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={28,-251})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.2,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-54,-292},{-34,-272}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{128,-258},{148,-238}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{158,-270},{178,-250}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{206,-264},{186,-246}})));
  CCC_test.Examples.ReversibleAirToWaterEuropeanNorm2D_withPowerData
    reversibleAirToWaterEuropeanNorm2D_withPowerData1(
    redeclare package MediumCon = MediumWater,
    redeclare package MediumEva = MediumAir,
    QUse_flow_nominal=2200,
    y_nominal=1,
    TCon_nominal=333.15,
    dpCon_nominal=2000,
    TEva_nominal=293.15,
    dpEva_nominal=2000,
    datTabHea=datTabHeaHpwh,
    datTabCoo=datTabCooHpwh)
    annotation (Placement(transformation(extent={{-10,-12},{10,12}},
        rotation=0,
        origin={112,-314})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpHpSupply(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mTankHx_flow_nominal,
    nominalValuesDefineDefaultPressureCurve=true) "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={114,-284})));
  Modelica.Blocks.Sources.Constant const3(k=0.2)
    annotation (Placement(transformation(extent={{196,-310},{216,-290}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 55)
    annotation (Placement(transformation(extent={{54,-352},{74,-332}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k=true)
    annotation (Placement(transformation(extent={{58,-396},{78,-376}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fanHpwhCondenser(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.136,
    nominalValuesDefineDefaultPressureCurve=true) "Fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={188,-370})));
  Modelica.Blocks.Sources.Constant const5(k=0.1)
    annotation (Placement(transformation(extent={{144,-360},{164,-340}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone clo(
    zoneName="FlexLab-X3-MechRoom-ZoneA Thermal Zone",
    redeclare package Medium = MediumAir,
    nPorts=2)
    annotation (Placement(transformation(extent={{450,-188},{490,-148}})));
  Modelica.Blocks.Sources.Constant const6(k=0.1)
    annotation (Placement(transformation(extent={{-2,-68},{18,-48}})));
  Modelica.Blocks.Sources.Constant const7(k=0.1)
    annotation (Placement(transformation(extent={{136,-204},{156,-184}})));
  Modelica.Blocks.Sources.Constant const8(k=0.1)
    annotation (Placement(transformation(extent={{48,-142},{68,-122}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-20,-307})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    use_C_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={66,-309})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankHxReturn(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={46,-284})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-134,-246},{-114,-226}})));
  Modelica.Blocks.Sources.Constant const1(k=5)
    annotation (Placement(transformation(extent={{-190,-274},{-170,-254}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo1
    annotation (Placement(transformation(extent={{-100,-210},{-80,-190}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo2
    annotation (Placement(transformation(extent={{-100,-228},{-80,-208}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo3
    annotation (Placement(transformation(extent={{-100,-246},{-80,-226}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo4
    annotation (Placement(transformation(extent={{-100,-268},{-80,-248}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo5
    annotation (Placement(transformation(extent={{-98,-292},{-78,-272}})));
  Modelica.Blocks.Sources.Constant const2(k=1500)
    annotation (Placement(transformation(extent={{-184,-222},{-164,-202}})));
equation
  connect(const.y, reversibleAirToWaterEuropeanNorm2D_withPowerData.ySet)
    annotation (Line(points={{83,8},{88,8},{88,30},{19.6,30}},      color={0,0,127}));
  connect(booleanConstant.y, reversibleAirToWaterEuropeanNorm2D_withPowerData.hea)
    annotation (Line(points={{35,84},{64,84},{64,41},{19.6,41}},      color={255,
          0,255}));
  connect(boundary1.ports[1], reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b2)
    annotation (Line(points={{80,75},{104,75},{104,38},{18,38}},        color={0,
          127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a2, freshAirCor.ports[
    1]) annotation (Line(points={{-2,38},{-40,38},{-40,48},{-92,48},{-92,64},{
          -68,64}},                                                color={0,127,
          255}));
  connect(jun1.port_3, jun2.port_1) annotation (Line(points={{-36,-88},{-36,-182},
          {-18,-182}},color={0,127,255}));
  connect(qIntGai.y,nor. qGai_flow) annotation (Line(points={{171,66},{318,66},{
          318,64},{326,64}},  color={0,0,127}));
  connect(qIntGai.y,cor. qGai_flow) annotation (Line(points={{171,66},{192,66},{
          192,-12},{342,-12},{342,-10},{350,-10}},
                                            color={0,0,127}));
  connect(qIntGai.y,sou. qGai_flow) annotation (Line(points={{171,66},{192,66},{
          192,-12},{322,-12},{322,-62},{372,-62},{372,-90},{382,-90}},
                                                color={0,0,127}));
  connect(nor.ports[1],ducNor. port_a) annotation (Line(points={{346.5,34.9},{346.5,
          22},{270,22},{270,40}}, color={0,127,255}));
  connect(ducNor.port_b,pAtm. ports[1]) annotation (Line(points={{250,40},{244,
          40},{244,-63.3333},{226,-63.3333}}, color={0,127,255}));
  connect(cor.ports[1],ducCor. port_a) annotation (Line(points={{370.5,-39.1},{370.5,
          -60},{300,-60},{300,-64},{270,-64}},       color={0,127,255}));
  connect(ducCor.port_b,pAtm. ports[2]) annotation (Line(points={{250,-64},{248,
          -64},{248,-62},{226,-62}}, color={0,127,255}));
  connect(ducSou.port_b,pAtm. ports[3]) annotation (Line(points={{246,-140},{
          236,-140},{236,-60.6667},{226,-60.6667}}, color={0,127,255}));
  connect(sou.ports[1],ducSou. port_a) annotation (Line(points={{402.5,-119.1},{
          402.5,-128},{346,-128},{346,-140},{266,-140}},
                                 color={0,127,255}));
  connect(building.weaBus,freshAirNor. weaBus) annotation (Line(
      points={{160,28},{258,28},{258,20},{250,20},{250,4.2},{260,4.2}},
      color={255,204,51},
      thickness=0.5));
  connect(building.weaBus, freshAirCor2.weaBus) annotation (Line(
      points={{160,28},{194,28},{194,8},{274,8},{274,-45.8}},
      color={255,204,51},
      thickness=0.5));
  connect(building.weaBus,freshAirSou. weaBus) annotation (Line(
      points={{160,28},{170,28},{170,22},{202,22},{202,-109.8},{278,-109.8}},
      color={255,204,51},
      thickness=0.5));
  connect(freshAirNor.ports[1],nor. ports[2]) annotation (Line(points={{280,4},{
          326,4},{326,22},{347.5,22},{347.5,34.9}},
                                                  color={0,127,255}));
  connect(freshAirCor2.ports[1], cor.ports[2]) annotation (Line(points={{294,-46},
          {320,-46},{320,-60},{371.5,-60},{371.5,-39.1}}, color={0,127,255}));
  connect(freshAirSou.ports[1],sou. ports[2]) annotation (Line(points={{298,-110},
          {352,-110},{352,-119.1},{403.5,-119.1}},       color={0,127,255}));
  connect(building.weaBus,weaBus)  annotation (Line(
      points={{160,28},{176,28},{176,0},{450,0},{450,-60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus.TDryBul,TOut. u) annotation (Line(
      points={{450.05,-59.95},{450.05,-54},{490,-54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(jun1.port_2, fanMultiSplitAirSupply1.port_a) annotation (Line(points={
          {-26,-78},{8,-78},{8,-88},{14,-88}}, color={0,127,255}));
  connect(jun2.port_2, fanMultiSplitAirSupply2.port_a) annotation (Line(points={
          {2,-182},{64,-182},{64,-154},{70,-154}}, color={0,127,255}));
  connect(jun2.port_3, fanMultiSplitAirSupply3.port_a) annotation (Line(points={
          {-8,-192},{-8,-212},{162,-212}}, color={0,127,255}));
  connect(fanMultiSplitAirSupply1.port_b, nor.ports[3]) annotation (Line(points=
         {{34,-88},{90,-88},{90,-96},{348.5,-96},{348.5,34.9}}, color={0,127,255}));
  connect(fanMultiSplitAirSupply3.port_b, sou.ports[3]) annotation (Line(points=
         {{182,-212},{296,-212},{296,-210},{404.5,-210},{404.5,-119.1}}, color={
          0,127,255}));
  connect(fanMultiSplitAirSupply2.port_b, cor.ports[3]) annotation (Line(points=
         {{90,-154},{164,-154},{164,-148},{372.5,-148},{372.5,-39.1}}, color={0,
          127,255}));
  connect(cor.ports[4], jun4.port_3) annotation (Line(points={{373.5,-39.1},{373.5,
          -62},{136,-62}}, color={0,127,255}));
  connect(sou.ports[4], jun4.port_1) annotation (Line(points={{405.5,-119.1},{405.5,
          -132},{162,-132},{162,-72},{146,-72}}, color={0,127,255}));
  connect(jun4.port_2, jun3.port_1) annotation (Line(points={{126,-72},{118,-72},
          {118,-64},{78,-64},{78,-32}}, color={0,127,255}));
  connect(nor.ports[4], jun3.port_3) annotation (Line(points={{349.5,34.9},{349.5,
          -16},{68,-16},{68,-22}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b1,
    tempMultiSplitSysAirSupply.port_a)
    annotation (Line(points={{-2,26},{-54,26},{-54,4}}, color={0,127,255}));
  connect(tempMultiSplitSysAirSupply.port_b, jun1.port_1) annotation (Line(
        points={{-54,-16},{-54,-78},{-46,-78}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a1,
    tempMultiSplitSysAirReturn.port_b) annotation (Line(points={{18,26},{26,26},
          {26,22},{32,22},{32,6}}, color={0,127,255}));
  connect(tempMultiSplitSysAirReturn.port_a, jun3.port_2)
    annotation (Line(points={{32,-14},{32,-32},{58,-32}}, color={0,127,255}));
  connect(tan.port_b, boundary.ports[1]) annotation (Line(points={{18,-251},{
          -20,-251},{-20,-282},{-34,-282}},color={0,127,255}));
  connect(tan.port_a, tempTankOutlet.port_a) annotation (Line(points={{38,-251},
          {44,-251},{44,-248},{128,-248}},            color={0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_b) annotation (Line(points={{148,
          -248},{148,-244},{160,-244},{160,-240},{178,-240},{178,-260}},
                                        color={0,127,255}));
  connect(senMasFlo.port_b, boundary2.ports[1]) annotation (Line(points={{178,-260},
          {186,-260},{186,-255}}, color={0,127,255}));
  connect(const3.y, pumpHpSupply.m_flow_in) annotation (Line(points={{217,-300},
          {224,-300},{224,-284},{144,-284},{144,-296},{114,-296}},
                                                   color={0,0,127}));
  connect(const4.y, reversibleAirToWaterEuropeanNorm2D_withPowerData1.ySet)
    annotation (Line(points={{75,-342},{75,-344},{88,-344},{88,-312},{100.4,-312}},
        color={0,0,127}));
  connect(booleanConstant1.y, reversibleAirToWaterEuropeanNorm2D_withPowerData1.hea)
    annotation (Line(points={{79,-386},{100.4,-386},{100.4,-323}}, color={255,0,
          255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_b2,
    fanHpwhCondenser.port_a) annotation (Line(points={{102,-320},{92,-320},{92,-370},
          {178,-370}}, color={0,127,255}));
  connect(const5.y, fanHpwhCondenser.m_flow_in) annotation (Line(points={{165,-350},
          {176,-350},{176,-352},{188,-352},{188,-358}}, color={0,0,127}));
  connect(const7.y, fanMultiSplitAirSupply3.m_flow_in) annotation (Line(points={
          {157,-194},{172,-194},{172,-200}}, color={0,0,127}));
  connect(const8.y, fanMultiSplitAirSupply2.m_flow_in)
    annotation (Line(points={{69,-132},{80,-132},{80,-142}}, color={0,0,127}));
  connect(const6.y, fanMultiSplitAirSupply1.m_flow_in)
    annotation (Line(points={{19,-58},{24,-58},{24,-76}}, color={0,0,127}));
  connect(fanHpwhCondenser.port_b, clo.ports[1]) annotation (Line(points={{198,-370},
          {274,-370},{274,-372},{469,-372},{469,-187.1}}, color={0,127,255}));
  connect(clo.ports[2], reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_a2)
    annotation (Line(points={{471,-187.1},{471,-320},{122,-320}}, color={0,127,255}));
  connect(qIntGai.y, clo.qGai_flow) annotation (Line(points={{171,66},{224,66},{
          224,58},{366,58},{366,-158},{448,-158}}, color={0,0,127}));
  connect(freshAirCor.T_in, TOut.y) annotation (Line(points={{-90,68},{-86,68},{
          -86,80},{534,80},{534,-54},{513,-54}}, color={0,0,127}));
  connect(pumpHpSupply.port_a,
    reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_b1) annotation (Line(
        points={{124,-284},{136,-284},{136,-308},{122,-308}}, color={0,127,255}));
  connect(pumpHpSupply.port_b, tan.portHex_a) annotation (Line(points={{104,
          -284},{86,-284},{86,-268},{38,-268},{38,-254.42}}, color={0,127,255}));
  connect(tan.portHex_b, tempTankHxReturn.port_a) annotation (Line(points={{38,
          -258.2},{46,-258.2},{46,-274}}, color={0,127,255}));
  connect(tempTankHxReturn.port_b, boundary3.ports[1]) annotation (Line(points=
          {{46,-294},{46,-307},{-10,-307}}, color={0,127,255}));
  connect(boundary4.ports[1], reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_a1)
    annotation (Line(points={{76,-309},{89,-309},{89,-308},{102,-308}}, color={
          0,127,255}));
  connect(tempTankHxReturn.T, boundary4.T_in) annotation (Line(points={{57,-284},
          {57,-298.3},{54,-298.3},{54,-312.6}}, color={0,0,127}));
  connect(const1.y, division.u2) annotation (Line(points={{-169,-264},{-144,
          -264},{-144,-242},{-136,-242}}, color={0,0,127}));
  connect(const2.y, division.u1) annotation (Line(points={{-163,-212},{-144,
          -212},{-144,-230},{-136,-230}}, color={0,0,127}));
  connect(division.y, preHeaFlo1.Q_flow) annotation (Line(points={{-113,-236},{
          -113,-200},{-100,-200}}, color={0,0,127}));
  connect(division.y, preHeaFlo2.Q_flow) annotation (Line(points={{-113,-236},{
          -113,-228},{-100,-228},{-100,-218}}, color={0,0,127}));
  connect(division.y, preHeaFlo3.Q_flow)
    annotation (Line(points={{-113,-236},{-100,-236}}, color={0,0,127}));
  connect(division.y, preHeaFlo4.Q_flow) annotation (Line(points={{-113,-236},{
          -113,-244},{-100,-244},{-100,-258}}, color={0,0,127}));
  connect(division.y, preHeaFlo5.Q_flow) annotation (Line(points={{-113,-236},{
          -113,-244},{-108,-244},{-108,-282},{-98,-282}}, color={0,0,127}));
  connect(preHeaFlo1.port, tan.heaPorVol[1]) annotation (Line(points={{-80,-200},
          {-40,-200},{-40,-226},{28,-226},{28,-251.216}}, color={191,0,0}));
  connect(preHeaFlo2.port, tan.heaPorVol[2]) annotation (Line(points={{-80,-218},
          {-80,-220},{-40,-220},{-40,-228},{28,-228},{28,-251.108}}, color={191,
          0,0}));
  connect(preHeaFlo3.port, tan.heaPorVol[3]) annotation (Line(points={{-80,-236},
          {28,-236},{28,-251}}, color={191,0,0}));
  connect(preHeaFlo4.port, tan.heaPorVol[4]) annotation (Line(points={{-80,-258},
          {-80,-260},{-64,-260},{-64,-236},{28,-236},{28,-250.892}}, color={191,
          0,0}));
  connect(preHeaFlo5.port, tan.heaPorVol[5]) annotation (Line(points={{-78,-282},
          {-72,-282},{-72,-260},{-64,-260},{-64,-236},{28,-236},{28,-250.784}},
        color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -400},{520,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-400},{520,
            100}})),
    experiment(
      StopTime=8640,
      Interval=300,
      __Dymola_Algorithm="Dassl"));
end NonArisMultiFamily_issue17;
