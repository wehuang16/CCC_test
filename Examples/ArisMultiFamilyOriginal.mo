within CCC_test.Examples;
model ArisMultiFamilyOriginal
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  parameter Modelica.Units.SI.MassFlowRate mOccupant_flow_nominal=0.126
    "Occupant hot water usage nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mFcu_flow_nominal=0.3
    "Fan coil units total glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mTankHx_flow_nominal=0.5
    "Water tank heat exchanger glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mHp_flow_nominal=mFcu_flow_nominal+mTankHx_flow_nominal
    "Heat pump glycol nominal mass flow rate";
  CCC.Fluid.HeatPumps.BaseClasses.CCC_HP_wTSup_ctr_withPowerData_3D cCC_HP_wTSup_ctr_withPowerData_3D(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumPropyleneGlycol (property_T=293.15, X_a
          =0.4),
    datTabHea=CCC.Fluid.HeatPumps.Data.LG_DATA_Heating(),
    datTabCoo=CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling(),
    Q_flow_nominal=18500,
    TCon_nominal=308.15,
    TEva_nominal=280.15,
    mCon_flow_nominal=0.92,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{8,48},{28,64}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{64,64},{84,84}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-118,42},{-98,62}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-66,72},{-46,92}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=318.15,
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
        origin={-24,-51})));
  Modelica.Fluid.Sources.Boundary_pT      hpPump(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={24,14})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,24})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankHxReturn(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={14,-62})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{72,-32},{52,-14}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.2,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-80,-96},{-60,-76}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{76,-56},{96,-36}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{154,-50},{134,-32}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    T_start=313.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{20,-116},{40,-96}})));

  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-44,-106},{-24,-86}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{106,-56},{126,-36}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{104,32},{124,52}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    nPorts=4) annotation (Placement(transformation(extent={{292,48},{332,88}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="FlexLab-X3-ZoneA-Core-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    nPorts=4)
    annotation (Placement(transformation(extent={{296,-26},{336,14}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone sou(
    zoneName="FlexLab-X3-ZoneA-South-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    nPorts=4)
    annotation (Placement(transformation(extent={{348,-106},{388,-66}})));
  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{114,70},{134,90}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm(
    redeclare package Medium = MediumAir,
    p=101300,
    nPorts=3)   "Boundary condition"
    annotation (Placement(transformation(extent={{170,-58},{190,-38}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducNor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*nor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{234,44},{214,64}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducCor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*cor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{234,-60},{214,-40}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducSou(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*sou.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{230,-136},{210,-116}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirNor(
    redeclare package Medium = MediumAir,
    m_flow=0.3*nor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{224,8},{244,28}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirCor(
    redeclare package Medium = MediumAir,
    m_flow=0.3*cor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{238,-42},{258,-22}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirSou(
    redeclare package Medium = MediumAir,
    m_flow=0.3*sou.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{242,-106},{262,-86}})));
  CCC.Fluid.HeatExchangers.BaseClasses.FanCoilUnit fanCoilUnit(
    redeclare package Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mFcu_flow_nominal/3,
    m2_flow_nominal=0.136,
    Q_flow_nominal=500,
    T_a1_nominal=328.15,
    T_a2_nominal=293.15)
    annotation (Placement(transformation(extent={{146,-266},{166,-246}})));

  Buildings.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    m_flow_nominal={mHp_flow_nominal,-mTankHx_flow_nominal,-mFcu_flow_nominal},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-4})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    m_flow_nominal={mFcu_flow_nominal,-mFcu_flow_nominal/3,-mFcu_flow_nominal*2
        /3},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={72,-122})));

  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    m_flow_nominal={mFcu_flow_nominal*2/3,-mFcu_flow_nominal/3,-
        mFcu_flow_nominal/3},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={64,-176})));

  Buildings.Fluid.Movers.FlowControlled_m_flow pumpHpSupply(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    m_flow_nominal=mTankHx_flow_nominal,
    nominalValuesDefineDefaultPressureCurve=true) "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-58,-32})));

  CCC.Fluid.HeatExchangers.BaseClasses.FanCoilUnit fanCoilUnit1(
    redeclare package Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mFcu_flow_nominal/3,
    m2_flow_nominal=0.136,
    Q_flow_nominal=500,
    T_a1_nominal=328.15,
    T_a2_nominal=293.15)
    annotation (Placement(transformation(extent={{290,-218},{310,-198}})));

  CCC.Fluid.HeatExchangers.BaseClasses.FanCoilUnit fanCoilUnit2(
    redeclare package Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mFcu_flow_nominal/3,
    m2_flow_nominal=0.136,
    Q_flow_nominal=500,
    T_a1_nominal=328.15,
    T_a2_nominal=293.15)
    annotation (Placement(transformation(extent={{418,-356},{438,-336}})));

  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    m_flow_nominal={mFcu_flow_nominal*2/3,-mFcu_flow_nominal,mFcu_flow_nominal/
        3},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={4,-222})));

  Buildings.Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    m_flow_nominal={mFcu_flow_nominal/3,-mFcu_flow_nominal*2/3,
        mFcu_flow_nominal/3},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,-274})));

  Buildings.Fluid.FixedResistances.Junction jun5(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    m_flow_nominal={mTankHx_flow_nominal,-mHp_flow_nominal,mFcu_flow_nominal},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,-184})));

  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpReturn(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={48,-76})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,-138})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuReturn(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-46,-224})));
  Modelica.Blocks.Sources.Constant const1(k=0.5)
    annotation (Placement(transformation(extent={{-150,-28},{-130,-8}})));
  Modelica.Blocks.Sources.Constant const3(k=0.1)
    annotation (Placement(transformation(extent={{114,-180},{134,-160}})));
  Modelica.Blocks.Sources.Constant const5(k=0.136)
    annotation (Placement(transformation(extent={{102,-342},{122,-322}})));
  Modelica.Blocks.Sources.Constant const7(k=0.1)
    annotation (Placement(transformation(extent={{250,-184},{270,-164}})));
  Modelica.Blocks.Sources.Constant const8(k=0.1)
    annotation (Placement(transformation(extent={{368,-316},{388,-296}})));
  Modelica.Blocks.Sources.Constant const9(k=0.136)
    annotation (Placement(transformation(extent={{284,-256},{304,-236}})));
  Modelica.Blocks.Sources.Constant const10(k=0.136)
    annotation (Placement(transformation(extent={{306,-392},{326,-372}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{404,-56},{424,-36}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
  Modelica.Blocks.Routing.RealPassThrough TOut
    annotation (Placement(transformation(extent={{456,-50},{476,-30}})));
equation
  connect(booleanConstant1.y, cCC_HP_wTSup_ctr_withPowerData_3D.Mode)
    annotation (Line(points={{85,74},{90,74},{90,56},{29.2,56}}, color={255,0,
          255}));
  connect(const6.y, cCC_HP_wTSup_ctr_withPowerData_3D.TSupSet) annotation (Line(
        points={{-97,52},{-97,50.1},{6.9,50.1}}, color={0,0,127}));
  connect(booleanConstant.y, cCC_HP_wTSup_ctr_withPowerData_3D.IO) annotation (
      Line(points={{-45,82},{0,82},{0,53.6},{6.8,53.6}}, color={255,0,255}));
  connect(hpPump.ports[1], cCC_HP_wTSup_ctr_withPowerData_3D.port_a)
    annotation (Line(points={{24,24},{34,24},{34,62},{29,62}}, color={0,127,255}));
  connect(cCC_HP_wTSup_ctr_withPowerData_3D.port_b, tempHpSupply.port_a)
    annotation (Line(points={{7,61.8},{-4,61.8},{-4,40},{-46,40},{-46,34}},
        color={0,127,255}));
  connect(tan.portHex_b, tempTankHxReturn.port_a) annotation (Line(points={{-14,
          -58.2},{-4,-58.2},{-4,-62},{4,-62}}, color={0,127,255}));
  connect(boundary.ports[1], tan.port_b) annotation (Line(points={{-60,-86},{-50,
          -86},{-50,-51},{-34,-51}}, color={0,127,255}));
  connect(const2.y, conservationEquation.Q_flow) annotation (Line(points={{-23,-96},
          {16,-96},{16,-100},{18,-100}},      color={0,0,127}));
  connect(tan.port_a, tempTankOutlet.port_a) annotation (Line(points={{-14,-51},
          {-14,-52},{2,-52},{2,-46},{76,-46}},   color={0,127,255}));
  connect(qIntGai.y, nor.qGai_flow) annotation (Line(points={{135,80},{282,80},
          {282,78},{290,78}}, color={0,0,127}));
  connect(qIntGai.y, cor.qGai_flow) annotation (Line(points={{135,80},{156,80},
          {156,2},{286,2},{286,4},{294,4}}, color={0,0,127}));
  connect(qIntGai.y, sou.qGai_flow) annotation (Line(points={{135,80},{156,80},{
          156,2},{286,2},{286,-48},{336,-48},{336,-76},{346,-76}},
                                                color={0,0,127}));
  connect(nor.ports[1], ducNor.port_a) annotation (Line(points={{310.5,48.9},{
          310.5,36},{234,36},{234,54}},
                                  color={0,127,255}));
  connect(ducNor.port_b, pAtm.ports[1]) annotation (Line(points={{214,54},{208,
          54},{208,-49.3333},{190,-49.3333}}, color={0,127,255}));
  connect(cor.ports[1], ducCor.port_a) annotation (Line(points={{314.5,-25.1},{
          314,-25.1},{314,-46},{234,-46},{234,-50}}, color={0,127,255}));
  connect(ducCor.port_b, pAtm.ports[2]) annotation (Line(points={{214,-50},{212,
          -50},{212,-48},{190,-48}}, color={0,127,255}));
  connect(ducSou.port_b, pAtm.ports[3]) annotation (Line(points={{210,-126},{
          200,-126},{200,-46.6667},{190,-46.6667}}, color={0,127,255}));
  connect(sou.ports[1], ducSou.port_a) annotation (Line(points={{366.5,-105.1},
          {366.5,-114},{310,-114},{310,-126},{230,-126}},
                                 color={0,127,255}));
  connect(building.weaBus, freshAirNor.weaBus) annotation (Line(
      points={{124,42},{222,42},{222,34},{214,34},{214,18.2},{224,18.2}},
      color={255,204,51},
      thickness=0.5));
  connect(building.weaBus, freshAirCor.weaBus) annotation (Line(
      points={{124,42},{158,42},{158,22},{238,22},{238,-31.8}},
      color={255,204,51},
      thickness=0.5));
  connect(building.weaBus, freshAirSou.weaBus) annotation (Line(
      points={{124,42},{134,42},{134,36},{166,36},{166,-95.8},{242,-95.8}},
      color={255,204,51},
      thickness=0.5));
  connect(freshAirNor.ports[1], nor.ports[2]) annotation (Line(points={{244,18},
          {290,18},{290,36},{311.5,36},{311.5,48.9}},
                                                  color={0,127,255}));
  connect(freshAirCor.ports[1], cor.ports[2]) annotation (Line(points={{258,-32},
          {266,-32},{266,-46},{315.5,-46},{315.5,-25.1}},
                                                      color={0,127,255}));
  connect(freshAirSou.ports[1], sou.ports[2]) annotation (Line(points={{262,-96},
          {316,-96},{316,-105.1},{367.5,-105.1}},        color={0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_a) annotation (Line(points={{96,-46},
          {106,-46}},                       color={0,127,255}));
  connect(tempHpSupply.port_b, jun.port_1) annotation (Line(points={{-46,14},{-46,
          10},{-50,10},{-50,6}}, color={0,127,255}));
  connect(jun.port_3, conservationEquation.ports[1]) annotation (Line(points={{-60,-4},
          {-94,-4},{-94,-120},{29,-120},{29,-116}},color={0,127,255}));
  connect(jun1.port_3, jun2.port_1) annotation (Line(points={{72,-132},{72,-160},
          {48,-160},{48,-176},{54,-176}}, color={0,127,255}));
  connect(jun.port_2, pumpHpSupply.port_a) annotation (Line(points={{-50,-14},{-54,
          -14},{-54,-22},{-58,-22}}, color={0,127,255}));
  connect(tan.portHex_a, pumpHpSupply.port_b) annotation (Line(points={{-14,-54.42},
          {-8,-54.42},{-8,-54},{-2,-54},{-2,-42},{-58,-42}}, color={0,127,255}));
  connect(jun4.port_2, jun3.port_1) annotation (Line(points={{38,-274},{20,-274},
          {20,-222},{14,-222}}, color={0,127,255}));
  connect(tempTankHxReturn.port_b, jun5.port_1) annotation (Line(points={{24,-62},
          {30,-62},{30,-90},{2,-90},{2,-166},{-82,-166},{-82,-184},{-76,-184}},
        color={0,127,255}));
  connect(jun5.port_2, tempHpReturn.port_a) annotation (Line(points={{-56,-184},
          {4,-184},{4,-86},{48,-86}}, color={0,127,255}));
  connect(tempHpReturn.port_b, boundary2.ports[1]) annotation (Line(points={{48,
          -66},{32,-66},{32,-23},{52,-23}}, color={0,127,255}));
  connect(tempHpReturn.T, hpPump.T_in) annotation (Line(points={{37,-76},{38,-76},
          {38,-6},{20,-6},{20,2}}, color={0,0,127}));
  connect(conservationEquation.ports[2], tempFcuSupply.port_a) annotation (Line(
        points={{31,-116},{31,-118},{24,-118},{24,-138},{30,-138}}, color={0,127,
          255}));
  connect(tempFcuSupply.port_b, jun1.port_1) annotation (Line(points={{50,-138},
          {56,-138},{56,-122},{62,-122}}, color={0,127,255}));
  connect(jun3.port_2, tempFcuReturn.port_a) annotation (Line(points={{-6,-222},
          {-8,-222},{-8,-224},{-36,-224}}, color={0,127,255}));
  connect(tempFcuReturn.port_b, jun5.port_3) annotation (Line(points={{-56,-224},
          {-66,-224},{-66,-194}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary1.ports[1]) annotation (Line(points={{126,-46},
          {128,-46},{128,-41},{134,-41}}, color={0,127,255}));
  connect(const1.y, pumpHpSupply.m_flow_in) annotation (Line(points={{-129,-18},
          {-82,-18},{-82,-20},{-38,-20},{-38,-32},{-46,-32}}, color={0,0,127}));
  connect(building.weaBus, weaBus) annotation (Line(
      points={{124,42},{140,42},{140,14},{414,14},{414,-46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus.TDryBul, TOut.u) annotation (Line(
      points={{414,-46},{414,-40},{454,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TOut.y, cCC_HP_wTSup_ctr_withPowerData_3D.TOutAir) annotation (Line(
        points={{477,-40},{514,-40},{514,50.7},{29.3,50.7}}, color={0,0,127}));
  connect(jun1.port_2, fanCoilUnit.port_a1) annotation (Line(points={{82,-122},
          {92,-122},{92,-251.6},{145.8,-251.6}}, color={0,127,255}));
  connect(nor.ports[3], fanCoilUnit.port_a2) annotation (Line(points={{312.5,
          48.9},{312.5,36},{292,36},{292,20},{252,20},{252,-20},{204,-20},{204,
          -204},{220,-204},{220,-261.2},{166.2,-261.2}}, color={0,127,255}));
  connect(const3.y, fanCoilUnit.WaterMassFlow) annotation (Line(points={{135,
          -170},{135,-172},{144,-172},{144,-248.2}}, color={0,0,127}));
  connect(fanCoilUnit.AirMassFlow, const5.y) annotation (Line(points={{144,
          -264.8},{140,-264.8},{140,-332},{123,-332}}, color={0,0,127}));
  connect(fanCoilUnit.port_b1, jun3.port_3) annotation (Line(points={{166.2,
          -251.6},{172,-251.6},{172,-236},{156,-236},{156,-228},{28,-228},{28,
          -212},{4,-212}}, color={0,127,255}));
  connect(fanCoilUnit.port_b2, nor.ports[4]) annotation (Line(points={{145.8,
          -261},{313.5,-261},{313.5,48.9}}, color={0,127,255}));
  connect(const7.y, fanCoilUnit1.WaterMassFlow) annotation (Line(points={{271,
          -174},{271,-176},{288,-176},{288,-200.2}}, color={0,0,127}));
  connect(const9.y, fanCoilUnit1.AirMassFlow) annotation (Line(points={{305,
          -246},{305,-248},{308,-248},{308,-228},{288,-228},{288,-216.8}},
        color={0,0,127}));
  connect(fanCoilUnit1.port_a1, jun2.port_2) annotation (Line(points={{289.8,
          -203.6},{224,-203.6},{224,-200},{112,-200},{112,-220},{88,-220},{88,
          -176},{74,-176}}, color={0,127,255}));
  connect(fanCoilUnit1.port_b2, cor.ports[3]) annotation (Line(points={{289.8,
          -213},{284,-213},{284,-196},{292,-196},{292,-188},{316.5,-188},{316.5,
          -25.1}}, color={0,127,255}));
  connect(fanCoilUnit1.port_a2, cor.ports[4]) annotation (Line(points={{310.2,
          -213.2},{316,-213.2},{316,-200},{320,-200},{320,-188},{317.5,-188},{
          317.5,-25.1}}, color={0,127,255}));
  connect(fanCoilUnit1.port_b1, jun4.port_3) annotation (Line(points={{310.2,
          -203.6},{326,-203.6},{326,-264},{48,-264}}, color={0,127,255}));
  connect(const8.y, fanCoilUnit2.WaterMassFlow) annotation (Line(points={{389,
          -306},{389,-308},{396,-308},{396,-338.2},{416,-338.2}}, color={0,0,
          127}));
  connect(const10.y, fanCoilUnit2.AirMassFlow) annotation (Line(points={{327,
          -382},{370,-382},{370,-388},{416,-388},{416,-354.8}}, color={0,0,127}));
  connect(fanCoilUnit2.port_b2, sou.ports[3]) annotation (Line(points={{417.8,
          -351},{368.5,-351},{368.5,-105.1}}, color={0,127,255}));
  connect(fanCoilUnit2.port_a2, sou.ports[4]) annotation (Line(points={{438.2,
          -351.2},{502,-351.2},{502,-148},{369.5,-148},{369.5,-105.1}}, color={
          0,127,255}));
  connect(jun2.port_3, fanCoilUnit2.port_a1) annotation (Line(points={{64,-186},
          {64,-341.6},{417.8,-341.6}}, color={0,127,255}));
  connect(jun4.port_1, fanCoilUnit2.port_b1) annotation (Line(points={{58,-274},
          {454,-274},{454,-341.6},{438.2,-341.6}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -400},{560,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-400},{560,
            100}})),
    experiment(
      StartTime=21427200,
      StopTime=21470400,
      Interval=300,
      __Dymola_Algorithm="Dassl"));
end ArisMultiFamilyOriginal;
