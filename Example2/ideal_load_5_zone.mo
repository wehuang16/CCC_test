within CCC_test.Example2;
model ideal_load_5_zone

          extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

       parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

  parameter Modelica.Units.SI.MassFlowRate mOut_flow_nominal=0.005
    "Outdoor air mass flow rate, assuming constant infiltration air flow rate";

                  parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/Data/energyPlusFiles/5Zone_IdealLoadsAirSystems_ReturnPlenum.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-238,18},{-218,38}})));

  Modelica.Blocks.Sources.Constant qIntGai1[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName="SPACE1-1",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,20},{82,60}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner1(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=50000)
    annotation (Placement(transformation(extent={{128,30},{148,50}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm1(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-140,42},{-120,62}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc1(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-72,42},{-92,62}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir1(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-92,12},{-72,32}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_EffectiveLeakageArea1(
    A=0,
    B=0,
    C=0.2237,
    D=0,
    desFloRat=0.032)
    annotation (Placement(transformation(extent={{-140,16},{-120,36}})));
  Modelica.Blocks.Sources.Constant qIntGai2[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-52},{2,-32}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon2(
    redeclare package Medium = MediumAir,
    zoneName="SPACE2-1",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,-72},{82,-32}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner2(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=50000)
    annotation (Placement(transformation(extent={{128,-62},{148,-42}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm2(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc2(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-72,-50},{-92,-30}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir2(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-92,-80},{-72,-60}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_EffectiveLeakageArea2(
    A=0,
    B=0,
    C=0.2237,
    D=0,
    desFloRat=0.014)
    annotation (Placement(transformation(extent={{-140,-76},{-120,-56}})));
  Modelica.Blocks.Sources.Constant qIntGai3[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-154},{2,-134}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon3(
    redeclare package Medium = MediumAir,
    zoneName="SPACE3-1",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{40,-174},{80,-134}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner3(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=50000)
    annotation (Placement(transformation(extent={{128,-164},{148,-144}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm3(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-140,-152},{-120,-132}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc3(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-72,-152},{-92,-132}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir3(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-92,-182},{-72,-162}})));
  CCC.Controls.Infiltration_DesignFlowRate       infiltration_EffectiveLeakageArea3(
    A=0,
    B=0,
    C=0.2237,
    D=0,
    desFloRat=0.032)
    annotation (Placement(transformation(extent={{-140,-178},{-120,-158}})));
  Modelica.Blocks.Sources.Constant qIntGai4[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-20,-246},{0,-226}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon4(
    redeclare package Medium = MediumAir,
    zoneName="SPACE4-1",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{40,-266},{80,-226}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner4(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=50000)
    annotation (Placement(transformation(extent={{126,-256},{146,-236}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm4(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-142,-244},{-122,-224}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc4(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-74,-244},{-94,-224}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir4(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-94,-274},{-74,-254}})));
  CCC.Controls.Infiltration_DesignFlowRate       infiltration_EffectiveLeakageArea4(
    A=0,
    B=0,
    C=0.2237,
    D=0,
    desFloRat=0.014)
    annotation (Placement(transformation(extent={{-142,-270},{-122,-250}})));
  Modelica.Blocks.Sources.Constant qIntGai5[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-342},{6,-322}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon5(
    redeclare package Medium = MediumAir,
    zoneName="SPACE5-1",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-362},{86,-322}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner5(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=50000)
    annotation (Placement(transformation(extent={{132,-352},{152,-332}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm5(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-136,-340},{-116,-320}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc5(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-68,-340},{-88,-320}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir5(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-88,-370},{-68,-350}})));
  CCC.Controls.Infiltration_DesignFlowRate       infiltration_EffectiveLeakageArea5(
    A=0,
    B=0,
    C=0.2237,
    D=0,
    desFloRat=0.062)
    annotation (Placement(transformation(extent={{-136,-366},{-116,-346}})));
  Modelica.Blocks.Sources.Constant qIntGai6[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-432},{6,-412}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon6(
    redeclare package Medium = MediumAir,
    zoneName="PLENUM-1",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-452},{86,-412}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner6(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{132,-442},{152,-422}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm6(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-136,-430},{-116,-410}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc6(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-68,-430},{-88,-410}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir6(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-88,-460},{-68,-440}})));
  CCC.Controls.Infiltration_DesignFlowRate       infiltration_EffectiveLeakageArea6(
    A=0,
    B=0,
    C=0.2237,
    D=0,
    desFloRat=0)
    annotation (Placement(transformation(extent={{-136,-456},{-116,-436}})));
equation
  connect(zon1.qGai_flow,qIntGai1. y)
    annotation (Line(points={{40,50},{3,50}},      color={0,0,127}));
  connect(zon1.TAir,trc_custom_air_conditioner1. ZAT) annotation (Line(points={{83,58},
          {104,58},{104,46.4},{126,46.4}},             color={0,0,127}));
  connect(trc_custom_air_conditioner1.port_b,zon1. ports[3]) annotation (Line(
        points={{148.8,32.4},{154,32.4},{154,20.9},{62,20.9}},
        color={0,127,255}));
  connect(zon1.ports[2],trc_custom_air_conditioner1. port_a) annotation (Line(
        points={{61.2,20.9},{61.2,18},{122,18},{122,32.6},{127.6,32.6}},
        color={0,127,255}));
  connect(building.weaBus, freshAir1.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,10},{-102,10},{-102,
          22.2},{-92,22.2}},
      color={255,204,51},
      thickness=0.5));
  connect(duc1.port_b, pAtm1.ports[1])
    annotation (Line(points={{-92,52},{-120,52}},color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea1.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20.6},{-140.4,20.6}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea1.infFloRat, freshAir1.m_flow_in)
    annotation (Line(points={{-118,26},{-100,26},{-100,30},{-92,30}}, color={0,0,
          127}));
  connect(zon1.TAir, infiltration_EffectiveLeakageArea1.zonAirTem) annotation (
      Line(points={{83,58},{88,58},{88,78},{-148,78},{-148,38},{-150,38},{-150,30.2},
          {-142,30.2}}, color={0,0,127}));
  connect(freshAir1.ports[1], zon1.ports[4]) annotation (Line(points={{-72,22},
          {36,22},{36,14},{62.8,14},{62.8,20.9}}, color={0,127,255}));
  connect(duc1.port_a, zon1.ports[5]) annotation (Line(points={{-72,52},{-28,52},
          {-28,22},{36,22},{36,14},{63.6,14},{63.6,20.9}}, color={0,127,255}));
  connect(zon2.qGai_flow,qIntGai2. y)
    annotation (Line(points={{40,-42},{3,-42}},    color={0,0,127}));
  connect(zon2.TAir,trc_custom_air_conditioner2. ZAT) annotation (Line(points={{83,-34},
          {118,-34},{118,-45.6},{126,-45.6}},          color={0,0,127}));
  connect(trc_custom_air_conditioner2.port_b,zon2. ports[3]) annotation (Line(
        points={{148.8,-59.6},{154,-59.6},{154,-78},{62,-78},{62,-71.1}},
        color={0,127,255}));
  connect(zon2.ports[2],trc_custom_air_conditioner2. port_a) annotation (Line(
        points={{61.2,-71.1},{61.2,-78},{122,-78},{122,-59.4},{127.6,-59.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir2. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,10},{-102,10},{-102,
          -69.8},{-92,-69.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc2.port_b,pAtm2. ports[1])
    annotation (Line(points={{-92,-40},{-120,-40}},
                                                 color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea2.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{-152,
          -71.4},{-140.4,-71.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea2.infFloRat, freshAir2.m_flow_in)
    annotation (Line(points={{-118,-66},{-100,-66},{-100,-62},{-92,-62}}, color=
         {0,0,127}));
  connect(zon2.TAir, infiltration_EffectiveLeakageArea2.zonAirTem) annotation (
      Line(points={{83,-34},{88,-34},{88,-22},{-150,-22},{-150,-61.8},{-142,-61.8}},
        color={0,0,127}));
  connect(freshAir2.ports[1], zon2.ports[4]) annotation (Line(points={{-72,-70},
          {36,-70},{36,-78},{62.8,-78},{62.8,-71.1}}, color={0,127,255}));
  connect(duc2.port_a, zon2.ports[5]) annotation (Line(points={{-72,-40},{-24,
          -40},{-24,-78},{63.6,-78},{63.6,-71.1}}, color={0,127,255}));
  connect(zon3.qGai_flow,qIntGai3. y)
    annotation (Line(points={{38,-144},{3,-144}},  color={0,0,127}));
  connect(zon3.TAir,trc_custom_air_conditioner3. ZAT) annotation (Line(points={{81,-136},
          {118,-136},{118,-147.6},{126,-147.6}},       color={0,0,127}));
  connect(trc_custom_air_conditioner3.port_b,zon3. ports[3]) annotation (Line(
        points={{148.8,-161.6},{154,-161.6},{154,-180},{60,-180},{60,-173.1}},
        color={0,127,255}));
  connect(zon3.ports[2],trc_custom_air_conditioner3. port_a) annotation (Line(
        points={{59.2,-173.1},{59.2,-180},{122,-180},{122,-161.4},{127.6,-161.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir3. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-72},{-146,-72},{-146,-126},{-102,-126},{-102,-171.8},{-92,
          -171.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc3.port_b,pAtm3. ports[1])
    annotation (Line(points={{-92,-142},{-120,-142}},
                                                 color={0,127,255}));
  connect(building.weaBus,infiltration_EffectiveLeakageArea3. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-173.4},{-140.4,-173.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea3.infFloRat,freshAir3. m_flow_in)
    annotation (Line(points={{-118,-168},{-100,-168},{-100,-164},{-92,-164}},
                                                                       color={0,
          0,127}));
  connect(zon3.TAir,infiltration_EffectiveLeakageArea3. zonAirTem) annotation (
      Line(points={{81,-136},{88,-136},{88,-124},{-150,-124},{-150,-163.8},{-142,
          -163.8}},                 color={0,0,127}));
  connect(freshAir3.ports[1], zon3.ports[4]) annotation (Line(points={{-72,-172},
          {36,-172},{36,-180},{60.8,-180},{60.8,-173.1}}, color={0,127,255}));
  connect(duc3.port_a, zon3.ports[5]) annotation (Line(points={{-72,-142},{-24,-142},
          {-24,-180},{61.6,-180},{61.6,-173.1}},       color={0,127,255}));
  connect(zon4.qGai_flow,qIntGai4. y)
    annotation (Line(points={{38,-236},{1,-236}},  color={0,0,127}));
  connect(zon4.TAir,trc_custom_air_conditioner4. ZAT) annotation (Line(points={{81,-228},
          {116,-228},{116,-239.6},{124,-239.6}},       color={0,0,127}));
  connect(trc_custom_air_conditioner4.port_b,zon4. ports[3]) annotation (Line(
        points={{146.8,-253.6},{152,-253.6},{152,-272},{60,-272},{60,-265.1}},
        color={0,127,255}));
  connect(zon4.ports[2],trc_custom_air_conditioner4. port_a) annotation (Line(
        points={{59.2,-265.1},{59.2,-272},{120,-272},{120,-253.4},{125.6,-253.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir4. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-174},{-146,-174},{-146,-218},{-104,-218},{-104,-263.8},{-94,
          -263.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc4.port_b,pAtm4. ports[1])
    annotation (Line(points={{-94,-234},{-122,-234}},
                                                 color={0,127,255}));
  connect(building.weaBus,infiltration_EffectiveLeakageArea4. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-265.4},{-142.4,-265.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea4.infFloRat,freshAir4. m_flow_in)
    annotation (Line(points={{-120,-260},{-102,-260},{-102,-256},{-94,-256}},
                                                                       color={0,
          0,127}));
  connect(zon4.TAir,infiltration_EffectiveLeakageArea4. zonAirTem) annotation (
      Line(points={{81,-228},{86,-228},{86,-216},{-152,-216},{-152,-255.8},{
          -144,-255.8}},            color={0,0,127}));
  connect(freshAir4.ports[1], zon4.ports[4]) annotation (Line(points={{-74,-264},
          {34,-264},{34,-272},{60.8,-272},{60.8,-265.1}}, color={0,127,255}));
  connect(duc4.port_a, zon4.ports[5]) annotation (Line(points={{-74,-234},{-26,
          -234},{-26,-272},{61.6,-272},{61.6,-265.1}}, color={0,127,255}));
  connect(zon5.qGai_flow,qIntGai5. y)
    annotation (Line(points={{44,-332},{7,-332}},  color={0,0,127}));
  connect(zon5.TAir,trc_custom_air_conditioner5. ZAT) annotation (Line(points={{87,-324},
          {122,-324},{122,-335.6},{130,-335.6}},       color={0,0,127}));
  connect(trc_custom_air_conditioner5.port_b,zon5. ports[3]) annotation (Line(
        points={{152.8,-349.6},{158,-349.6},{158,-368},{66,-368},{66,-361.1}},
        color={0,127,255}));
  connect(zon5.ports[2],trc_custom_air_conditioner5. port_a) annotation (Line(
        points={{65.2,-361.1},{65.2,-368},{126,-368},{126,-349.4},{131.6,-349.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir5. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-314},{-98,-314},{-98,-359.8},{-88,
          -359.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc5.port_b,pAtm5. ports[1])
    annotation (Line(points={{-88,-330},{-116,-330}},
                                                 color={0,127,255}));
  connect(building.weaBus,infiltration_EffectiveLeakageArea5. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-361.4},{-136.4,-361.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea5.infFloRat,freshAir5. m_flow_in)
    annotation (Line(points={{-114,-356},{-96,-356},{-96,-352},{-88,-352}},
                                                                       color={0,
          0,127}));
  connect(zon5.TAir,infiltration_EffectiveLeakageArea5. zonAirTem) annotation (
      Line(points={{87,-324},{92,-324},{92,-312},{-146,-312},{-146,-351.8},{
          -138,-351.8}},            color={0,0,127}));
  connect(freshAir5.ports[1], zon5.ports[4]) annotation (Line(points={{-68,-360},
          {40,-360},{40,-368},{66.8,-368},{66.8,-361.1}}, color={0,127,255}));
  connect(duc5.port_a, zon5.ports[5]) annotation (Line(points={{-68,-330},{-20,
          -330},{-20,-368},{67.6,-368},{67.6,-361.1}}, color={0,127,255}));
  connect(zon6.qGai_flow,qIntGai6. y)
    annotation (Line(points={{44,-422},{7,-422}},  color={0,0,127}));
  connect(zon6.TAir,trc_custom_air_conditioner6. ZAT) annotation (Line(points={{87,-414},
          {122,-414},{122,-425.6},{130,-425.6}},       color={0,0,127}));
  connect(trc_custom_air_conditioner6.port_b,zon6. ports[3]) annotation (Line(
        points={{152.8,-439.6},{158,-439.6},{158,-458},{66,-458},{66,-451.1}},
        color={0,127,255}));
  connect(zon6.ports[2],trc_custom_air_conditioner6. port_a) annotation (Line(
        points={{65.2,-451.1},{65.2,-458},{126,-458},{126,-439.4},{131.6,-439.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir6. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-362},{-142,-362},{-142,-404},{-98,-404},
          {-98,-449.8},{-88,-449.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc6.port_b,pAtm6. ports[1])
    annotation (Line(points={{-88,-420},{-116,-420}},
                                                 color={0,127,255}));
  connect(building.weaBus,infiltration_EffectiveLeakageArea6. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-451.4},{-136.4,-451.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea6.infFloRat,freshAir6. m_flow_in)
    annotation (Line(points={{-114,-446},{-96,-446},{-96,-442},{-88,-442}},
                                                                       color={0,
          0,127}));
  connect(zon6.TAir,infiltration_EffectiveLeakageArea6. zonAirTem) annotation (
      Line(points={{87,-414},{92,-414},{92,-402},{-146,-402},{-146,-441.8},{
          -138,-441.8}},            color={0,0,127}));
  connect(freshAir6.ports[1], zon6.ports[4]) annotation (Line(points={{-68,-450},
          {40,-450},{40,-458},{66.8,-458},{66.8,-451.1}}, color={0,127,255}));
  connect(duc6.port_a, zon6.ports[5]) annotation (Line(points={{-68,-420},{-20,
          -420},{-20,-458},{67.6,-458},{67.6,-451.1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end ideal_load_5_zone;
