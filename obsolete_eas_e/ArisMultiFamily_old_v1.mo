within CCC_test.obsolete_eas_e;
model ArisMultiFamily_old_v1
    extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  parameter Modelica.Units.SI.MassFlowRate mOccupant_flow_nominal=0.126
    "Occupant hot water usage nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mFcu_flow_nominal=0.06111
    "Fan coil units total glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mTankHx_flow_nominal=0.92
    "Water tank heat exchanger glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mHp_flow_nominal=mFcu_flow_nominal+mTankHx_flow_nominal
    "Heat pump glycol nominal mass flow rate";
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_HP_3D_integrated(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-82,72},{-62,88}})));
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_HP_3D_integrated1(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-80,44},{-60,60}})));
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_HP_3D_integrated2(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-80,18},{-60,34}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=327.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{-10,-116},{10,-96}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=318.15,
    redeclare package MediumHex = MediumPropyleneGlycol (property_T=293.15, X_a=
           0.4),
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=mTankHx_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={-32,-25})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2
    annotation (Placement(transformation(extent={{-136,112},{-116,132}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-152,50},{-132,70}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.1,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-128,-48},{-108,-28}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{58,-8},{78,12}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{88,-6},{108,14}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{144,-32},{124,-14}})));
  CCC.Fluid.BaseClasses.FlowRouterSupply flowRouterSupply(redeclare package
      Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{-4,2},{16,22}})));
  CCC.Fluid.BaseClasses.FlowRouterReturn flowRouterReturn(redeclare package
      Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{-136,-2},{-116,18}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{70,70},{90,90}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{200,132},{220,152}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=4) annotation (Placement(transformation(extent={{192,86},{232,126}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducNor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*nor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{200,50},{180,70}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirNor(
    redeclare package Medium = MediumAir,
    m_flow=0.3*nor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{172,12},{192,32}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm(
    redeclare package Medium = MediumAir,
    p=101300,
    nPorts=2)   "Boundary condition"
    annotation (Placement(transformation(extent={{122,32},{142,52}})));
  CCC.Fluid.BaseClasses.HpModeSelector hpModeSelector
    annotation (Placement(transformation(extent={{-190,100},{-170,120}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-220,90},{-200,110}})));
  CCC_test.obsolete_eas_e.FanCoilUnitPidNoMover fanCoilUnitPidNoMover(
    redeclare package Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.06111,
    zone_temp_setpoint=291.15,
    dp1_nominal(displayUnit="kPa") = 10600,
    m2_flow_nominal=0.05333,
    Q_flow_nominal=2549.7177,
    T_a1_nominal=343.15,
    T_a2_nominal=293.15)
    annotation (Placement(transformation(extent={{200,-80},{220,-60}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{96,122},{116,142}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
  Modelica.Blocks.Routing.RealPassThrough TOut
    annotation (Placement(transformation(extent={{142,124},{162,144}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpHpSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
      m_flow_nominal=mTankHx_flow_nominal) "pump"        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={36,-48})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpReturn(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-132,-92})));
  Modelica.Fluid.Sources.Boundary_pT      hpPump(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-164,-24})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-114,-74},{-134,-56}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-54,-118},{-34,-98}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuReturn(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-134,-140})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,50})));
  Modelica.Blocks.Sources.Constant const4(k=5)
    annotation (Placement(transformation(extent={{38,-88},{58,-68}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=300,
    yMin=0,
    reverseActing=false)
    annotation (Placement(transformation(extent={{68,-90},{88,-70}})));
  Modelica.Blocks.Math.Gain        gain(k=mTankHx_flow_nominal)
    annotation (Placement(transformation(extent={{110,-80},{130,-60}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{50,-122},{70,-102}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempBufTanSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={96,-126})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-8})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="FlexLab-X3-ZoneA-Core-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=4)
    annotation (Placement(transformation(extent={{254,-6},{294,34}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducNor1(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*cor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{278,-56},{258,-36}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirNor1(
    redeclare package Medium = MediumAir,
    m_flow=0.3*cor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{256,-112},{276,-92}})));
  CCC_test.obsolete_eas_e.FanCoilUnitPidNoMover fanCoilUnitPidNoMover1(
    redeclare package Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.06111,
    zone_temp_setpoint=291.15,
    dp1_nominal(displayUnit="kPa") = 10600,
    m2_flow_nominal=0.05333,
    Q_flow_nominal=2549.7177,
    T_a1_nominal=343.15,
    T_a2_nominal=293.15)
    annotation (Placement(transformation(extent={{208,-154},{228,-134}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        MediumPropyleneGlycol (property_T=293.15, X_a=0.4), m_flow_nominal=
        0.06111)
    annotation (Placement(transformation(extent={{162,-78},{182,-58}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium =
        MediumAir, m_flow_nominal=0.05333)       annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={172,-102})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={128,-116})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,-170})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan2(redeclare package Medium =
        MediumPropyleneGlycol (property_T=293.15, X_a=0.4), m_flow_nominal=
        0.06111)
    annotation (Placement(transformation(extent={{138,-146},{158,-126}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan3(redeclare package Medium =
        MediumAir, m_flow_nominal=0.05333)       annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={174,-150})));
equation
  connect(booleanConstant2.y, aixlib_HP_3D_integrated.IO) annotation (Line(
        points={{-115,122},{-90,122},{-90,80.8},{-83.4,80.8}}, color={255,0,255}));
  connect(booleanConstant2.y, aixlib_HP_3D_integrated1.IO) annotation (Line(
        points={{-115,122},{-90,122},{-90,52.8},{-81.4,52.8}}, color={255,0,255}));
  connect(booleanConstant2.y, aixlib_HP_3D_integrated2.IO) annotation (Line(
        points={{-115,122},{-90,122},{-90,26.8},{-81.4,26.8}}, color={255,0,255}));
  connect(const6.y, aixlib_HP_3D_integrated.TSupSet) annotation (Line(points={{
          -131,60},{-83.1,60},{-83.1,76.88}}, color={0,0,127}));
  connect(const6.y, aixlib_HP_3D_integrated1.TSupSet) annotation (Line(points={
          {-131,60},{-86,60},{-86,48.88},{-81.1,48.88}}, color={0,0,127}));
  connect(const6.y, aixlib_HP_3D_integrated2.TSupSet) annotation (Line(points={
          {-131,60},{-92,60},{-92,22.88},{-81.1,22.88}}, color={0,0,127}));
  connect(boundary.ports[1], tan.port_b) annotation (Line(points={{-108,-38},{
          -48,-38},{-48,-25},{-42,-25}}, color={0,127,255}));
  connect(tan.port_a, tempTankOutlet.port_a) annotation (Line(points={{-22,-25},
          {-22,-26},{52,-26},{52,2},{58,2}}, color={0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_a)
    annotation (Line(points={{78,2},{78,4},{88,4}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary1.ports[1]) annotation (Line(points={{108,4},
          {116,4},{116,-23},{124,-23}}, color={0,127,255}));
  connect(qIntGai.y, nor.qGai_flow) annotation (Line(points={{221,142},{226,142},
          {226,158},{180,158},{180,116},{190,116}}, color={0,0,127}));
  connect(ducNor.port_b, pAtm.ports[1]) annotation (Line(points={{180,60},{148,
          60},{148,41},{142,41}}, color={0,127,255}));
  connect(ducNor.port_a, nor.ports[1]) annotation (Line(points={{200,60},{210.5,
          60},{210.5,86.9}}, color={0,127,255}));
  connect(freshAirNor.ports[1], nor.ports[2]) annotation (Line(points={{192,22},
          {204,22},{204,26},{211.5,26},{211.5,86.9}}, color={0,127,255}));
  connect(building.weaBus, freshAirNor.weaBus) annotation (Line(
      points={{90,80},{114,80},{114,22.2},{172,22.2}},
      color={255,204,51},
      thickness=0.5));
  connect(booleanConstant1.y, hpModeSelector.SpaceConditioningMode) annotation (
     Line(points={{-199,100},{-199,104.6},{-192,104.6}}, color={255,0,255}));
  connect(hpModeSelector.y3, aixlib_HP_3D_integrated.Mode) annotation (Line(
        points={{-169,107.8},{-60.8,107.8},{-60.8,81.6}}, color={255,0,255}));
  connect(hpModeSelector.y5, aixlib_HP_3D_integrated2.Mode) annotation (Line(
        points={{-169,102.6},{-54,102.6},{-54,27.6},{-58.8,27.6}}, color={255,0,
          255}));
  connect(hpModeSelector.y4, aixlib_HP_3D_integrated1.Mode) annotation (Line(
        points={{-169,105},{-52,105},{-52,53.6},{-58.8,53.6}}, color={255,0,255}));
  connect(hpModeSelector.y, flowRouterReturn.u) annotation (Line(points={{-169,
          117.6},{-169,16.7},{-138,16.7}}, color={0,0,127}));
  connect(hpModeSelector.y1, flowRouterReturn.u1) annotation (Line(points={{
          -169,114.8},{-169,12.9},{-138.2,12.9}}, color={0,0,127}));
  connect(hpModeSelector.y2, flowRouterReturn.u2) annotation (Line(points={{
          -169,112},{-169,9.1},{-138,9.1}}, color={0,0,127}));
  connect(hpModeSelector.y, flowRouterSupply.u) annotation (Line(points={{-169,
          117.6},{-174,117.6},{-174,16},{-146,16},{-146,28},{-88,28},{-88,38},{
          -14,38},{-14,20.7},{-6,20.7}}, color={0,0,127}));
  connect(hpModeSelector.y1, flowRouterSupply.u1) annotation (Line(points={{
          -169,114.8},{-174,114.8},{-174,12},{-144,12},{-144,24},{-116,24},{
          -116,26},{-94,26},{-94,28},{-86,28},{-86,38},{-48,38},{-48,36},{-12,
          36},{-12,16.9},{-6.2,16.9}}, color={0,0,127}));
  connect(hpModeSelector.y2, flowRouterSupply.u2) annotation (Line(points={{
          -169,112},{-174,112},{-174,10},{-146,10},{-146,-10},{-24,-10},{-24,
          13.1},{-6,13.1}}, color={0,0,127}));
  connect(building.weaBus, weaBus) annotation (Line(
      points={{90,80},{106,80},{106,132}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus.TDryBul, TOut.u) annotation (Line(
      points={{106,132},{124,132},{124,134},{140,134}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TOut.y, aixlib_HP_3D_integrated1.TOutAir) annotation (Line(points={{
          163,134},{168,134},{168,102},{-30,102},{-30,50},{-52,50},{-52,49.36},
          {-58.7,49.36}}, color={0,0,127}));
  connect(TOut.y, aixlib_HP_3D_integrated2.TOutAir) annotation (Line(points={{
          163,134},{168,134},{168,102},{-30,102},{-30,50},{-52,50},{-52,23.36},
          {-58.7,23.36}}, color={0,0,127}));
  connect(TOut.y, aixlib_HP_3D_integrated.TOutAir) annotation (Line(points={{
          163,134},{168,134},{168,102},{-30,102},{-30,77.36},{-60.7,77.36}},
        color={0,0,127}));
  connect(pumpHpSupply.port_b, tan.portHex_a) annotation (Line(points={{36,-58},
          {20,-58},{20,-70},{-14,-70},{-14,-28.42},{-22,-28.42}}, color={0,127,
          255}));
  connect(hpPump.ports[1], flowRouterReturn.port_a1) annotation (Line(points={{
          -164,-14},{-164,-4},{-136.4,-4},{-136.4,0.6}}, color={0,127,255}));
  connect(boundary2.ports[1], tempHpReturn.port_b) annotation (Line(points={{
          -134,-65},{-148,-65},{-148,-66},{-158,-66},{-158,-92},{-142,-92}},
        color={0,127,255}));
  connect(tan.portHex_b, tempHpReturn.port_a) annotation (Line(points={{-22,
          -32.2},{-22,-92},{-122,-92}}, color={0,127,255}));
  connect(tempHpReturn.T, hpPump.T_in) annotation (Line(points={{-132,-103},{
          -132,-104},{-168,-104},{-168,-36}}, color={0,0,127}));
  connect(const2.y, conservationEquation.Q_flow) annotation (Line(points={{-33,
          -108},{-20,-108},{-20,-100},{-12,-100}}, color={0,0,127}));
  connect(tempFcuReturn.port_b, flowRouterReturn.port_a) annotation (Line(
        points={{-144,-140},{-164,-140},{-164,-138},{-190,-138},{-190,6},{
          -136.4,6}}, color={0,127,255}));
  connect(nor.TAir, fanCoilUnitPidNoMover.zonAirTem) annotation (Line(points={{
          233,124},{238,124},{238,-58},{192,-58},{192,-70},{190,-70},{190,-78.8},
          {198,-78.8}}, color={0,0,127}));
  connect(nor.ports[3], fanCoilUnitPidNoMover.port_a2) annotation (Line(points=
          {{212.5,86.9},{212.5,84},{214,84},{214,74},{154,74},{154,-86},{228,
          -86},{228,-75.2},{220.2,-75.2}}, color={0,127,255}));
  connect(flowRouterSupply.port_b1, tempHpSupply.port_a) annotation (Line(
        points={{16.6,7.8},{18,7.8},{18,34},{16,34},{16,50},{22,50}}, color={0,
          127,255}));
  connect(tempHpSupply.port_b, pumpHpSupply.port_a) annotation (Line(points={{
          42,50},{48,50},{48,-32},{36,-32},{36,-38}}, color={0,127,255}));
  connect(const4.y, conPID.u_s) annotation (Line(points={{59,-78},{62,-78},{62,
          -80},{66,-80}}, color={0,0,127}));
  connect(gain.u, conPID.y) annotation (Line(points={{108,-70},{98,-70},{98,-80},
          {89,-80}}, color={0,0,127}));
  connect(gain.y, pumpHpSupply.m_flow_in) annotation (Line(points={{131,-70},{
          134,-70},{134,-68},{138,-68},{138,-50},{48,-50},{48,-48}}, color={0,0,
          127}));
  connect(add.y, conPID.u_m) annotation (Line(points={{71,-112},{71,-102},{78,
          -102},{78,-92}}, color={0,0,127}));
  connect(tempHpSupply.T, add.u1) annotation (Line(points={{32,61},{36,61},{36,
          -106},{48,-106}}, color={0,0,127}));
  connect(tempHpReturn.T, add.u2) annotation (Line(points={{-132,-103},{-132,
          -118},{48,-118}}, color={0,0,127}));
  connect(conservationEquation.ports[1], tempBufTanSupply.port_a) annotation (
      Line(points={{-1,-116},{-1,-130},{80,-130},{80,-126},{86,-126}}, color={0,
          127,255}));
  connect(flowRouterSupply.port_b, tempFcuSupply.port_a) annotation (Line(
        points={{16.4,18.4},{20,18.4},{20,2}}, color={0,127,255}));
  connect(tempFcuSupply.port_b, conservationEquation.ports[2]) annotation (Line(
        points={{20,-18},{20,-56},{16,-56},{16,-122},{1,-122},{1,-116}}, color=
          {0,127,255}));
  connect(qIntGai.y, cor.qGai_flow) annotation (Line(points={{221,142},{242,142},
          {242,24},{252,24}}, color={0,0,127}));
  connect(cor.ports[1], ducNor1.port_a) annotation (Line(points={{272.5,-5.1},{
          272.5,-30},{284,-30},{284,-46},{278,-46}}, color={0,127,255}));
  connect(ducNor1.port_b, pAtm.ports[2]) annotation (Line(points={{258,-46},{
          228,-46},{228,-28},{142,-28},{142,43}}, color={0,127,255}));
  connect(freshAirNor1.ports[1], cor.ports[2]) annotation (Line(points={{276,
          -102},{282,-102},{282,-5.1},{273.5,-5.1}}, color={0,127,255}));
  connect(building.weaBus, freshAirNor1.weaBus) annotation (Line(
      points={{90,80},{256,80},{256,-101.8}},
      color={255,204,51},
      thickness=0.5));
  connect(cor.TAir, fanCoilUnitPidNoMover1.zonAirTem) annotation (Line(points={
          {295,32},{302,32},{302,-152.8},{206,-152.8}}, color={0,0,127}));
  connect(fanCoilUnitPidNoMover1.port_a2, cor.ports[3]) annotation (Line(points=
         {{228.2,-149.2},{274.5,-149.2},{274.5,-5.1}}, color={0,127,255}));
  connect(fan.port_b, fanCoilUnitPidNoMover.port_a1) annotation (Line(points={{
          182,-68},{182,-65.6},{199.8,-65.6}}, color={0,127,255}));
  connect(fanCoilUnitPidNoMover.m_flow_water, fan.m_flow_in) annotation (Line(
        points={{221.2,-61.8},{226,-61.8},{226,-48},{172,-48},{172,-56}}, color=
         {0,0,127}));
  connect(fanCoilUnitPidNoMover.port_b2, fan1.port_a) annotation (Line(points={
          {199.8,-75},{199.8,-76},{188,-76},{188,-102},{182,-102}}, color={0,
          127,255}));
  connect(fan1.port_b, nor.ports[4]) annotation (Line(points={{162,-102},{146,
          -102},{146,-104},{128,-104},{128,86.9},{213.5,86.9}}, color={0,127,
          255}));
  connect(fanCoilUnitPidNoMover.m_flow_air, fan1.m_flow_in) annotation (Line(
        points={{221.2,-78.2},{236,-78.2},{236,-114},{172,-114}}, color={0,0,
          127}));
  connect(tempBufTanSupply.port_b, jun3.port_1) annotation (Line(points={{106,
          -126},{112,-126},{112,-116},{118,-116}}, color={0,127,255}));
  connect(jun3.port_2, fan.port_a) annotation (Line(points={{138,-116},{148,
          -116},{148,-68},{162,-68}}, color={0,127,255}));
  connect(fanCoilUnitPidNoMover.port_b1, jun1.port_3) annotation (Line(points={
          {220.2,-65.6},{240,-65.6},{240,-110},{58,-110},{58,-160}}, color={0,
          127,255}));
  connect(fanCoilUnitPidNoMover1.port_b1, jun1.port_1) annotation (Line(points=
          {{228.2,-139.6},{234,-139.6},{234,-170},{68,-170}}, color={0,127,255}));
  connect(tempFcuReturn.port_a, jun1.port_2) annotation (Line(points={{-124,
          -140},{42,-140},{42,-170},{48,-170}}, color={0,127,255}));
  connect(fan3.port_a, fanCoilUnitPidNoMover1.port_b2) annotation (Line(points=
          {{184,-150},{186,-150},{186,-149},{207.8,-149}}, color={0,127,255}));
  connect(fan3.port_b, cor.ports[4]) annotation (Line(points={{164,-150},{164,
          -5.1},{275.5,-5.1}}, color={0,127,255}));
  connect(fanCoilUnitPidNoMover1.m_flow_air, fan3.m_flow_in) annotation (Line(
        points={{229.2,-152.2},{229.2,-162},{174,-162}}, color={0,0,127}));
  connect(jun3.port_3, fan2.port_a) annotation (Line(points={{128,-126},{128,
          -136},{138,-136}}, color={0,127,255}));
  connect(fan2.port_b, fanCoilUnitPidNoMover1.port_a1) annotation (Line(points=
          {{158,-136},{202,-136},{202,-139.6},{207.8,-139.6}}, color={0,127,255}));
  connect(fanCoilUnitPidNoMover1.m_flow_water, fan2.m_flow_in) annotation (Line(
        points={{229.2,-135.8},{236,-135.8},{236,-126},{148,-126},{148,-124}},
        color={0,0,127}));
  connect(aixlib_HP_3D_integrated.port_b, flowRouterSupply.port_a) annotation (
      Line(points={{-61.2,85.44},{-20,85.44},{-20,9.8},{-4.6,9.8}}, color={0,
          127,255}));
  connect(aixlib_HP_3D_integrated1.port_b, flowRouterSupply.port_a1)
    annotation (Line(points={{-59.2,57.44},{-59.2,60},{-18,60},{-18,7.4},{-4.4,
          7.4}}, color={0,127,255}));
  connect(aixlib_HP_3D_integrated2.port_b, flowRouterSupply.port_a2)
    annotation (Line(points={{-59.2,31.44},{-22,31.44},{-22,4},{-4.4,4}}, color=
         {0,127,255}));
  connect(aixlib_HP_3D_integrated.port_a, flowRouterReturn.port_b) annotation (
      Line(points={{-83,85.6},{-94,85.6},{-94,14.4},{-115.6,14.4}}, color={0,
          127,255}));
  connect(aixlib_HP_3D_integrated1.port_a, flowRouterReturn.port_b1)
    annotation (Line(points={{-81,57.6},{-98,57.6},{-98,8.4},{-115.6,8.4}},
        color={0,127,255}));
  connect(aixlib_HP_3D_integrated2.port_a, flowRouterReturn.port_b2)
    annotation (Line(points={{-81,31.6},{-100,31.6},{-100,0},{-115.6,0}}, color=
         {0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -220},{260,160}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-220},{260,
            160}})),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisMultiFamily_old_v1;
