within CCC_test.Example2;
model TRC_building_low_rise_rochester

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
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/US+MF+CZ6A+gasfurnace+slab+IECC_2021_original_V960.idf"),
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
    zoneName="living_unit1_FrontRow_BottomFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,20},{82,60}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner1(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
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
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea1(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-140,16},{-120,36}})));
  Modelica.Blocks.Sources.Constant qIntGai2[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-52},{2,-32}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon2(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_FrontRow_BottomFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,-72},{82,-32}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner2(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
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
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea2(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=94.5270437847315)
    annotation (Placement(transformation(extent={{-140,-76},{-120,-56}})));
  Modelica.Blocks.Sources.Constant qIntGai3[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-154},{2,-134}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon3(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_FrontRow_BottomFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,-174},{82,-134}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner3(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
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
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea3(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-140,-178},{-120,-158}})));
  Modelica.Blocks.Sources.Constant qIntGai4[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-20,-246},{0,-226}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon4(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_BackRow_BottomFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{40,-266},{80,-226}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner4(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
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
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea4(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-142,-270},{-122,-250}})));
  Modelica.Blocks.Sources.Constant qIntGai5[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-342},{6,-322}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon5(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_BackRow_BottomFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-362},{86,-322}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner5(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
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
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea5(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=94.5270437847315)
    annotation (Placement(transformation(extent={{-136,-366},{-116,-346}})));
  Modelica.Blocks.Sources.Constant qIntGai6[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-432},{6,-412}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon6(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_BackRow_BottomFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-452},{86,-412}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner6(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
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
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea6(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-136,-456},{-116,-436}})));
  Modelica.Blocks.Sources.Constant qIntGai7[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-530},{4,-510}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon7(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_FrontRow_MiddleFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-550},{84,-510}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner7(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{130,-540},{150,-520}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm7(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-138,-528},{-118,-508}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc7(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-70,-528},{-90,-508}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir7(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-90,-558},{-70,-538}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea7(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=47.0121201801723)
    annotation (Placement(transformation(extent={{-138,-554},{-118,-534}})));
  Modelica.Blocks.Sources.Constant qIntGai8[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-626},{2,-606}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon8(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_FrontRow_MiddleFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,-646},{82,-606}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner8(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{128,-636},{148,-616}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm8(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-140,-624},{-120,-604}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc8(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-72,-624},{-92,-604}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir8(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-92,-654},{-72,-634}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea8(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=34.1906328583071)
    annotation (Placement(transformation(extent={{-140,-650},{-120,-630}})));
  Modelica.Blocks.Sources.Constant qIntGai9[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-736},{4,-716}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon9(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_FrontRow_MiddleFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-756},{84,-716}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner9(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{130,-746},{150,-726}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm9(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-138,-734},{-118,-714}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc9(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-70,-734},{-90,-714}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir9(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-90,-764},{-70,-744}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea9(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=47.0121201801723)
    annotation (Placement(transformation(extent={{-138,-760},{-118,-740}})));
  Modelica.Blocks.Sources.Constant qIntGai10
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-840},{4,-820}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon10(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_BackRow_MiddleFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-860},{84,-820}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner10(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{130,-850},{150,-830}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm10(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-138,-838},{-118,-818}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc10(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-70,-838},{-90,-818}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir10(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-90,-868},{-70,-848}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea10(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=47.0121201801723)
    annotation (Placement(transformation(extent={{-138,-864},{-118,-844}})));
  Modelica.Blocks.Sources.Constant qIntGai11
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-940},{6,-920}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon11(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_BackRow_MiddleFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-960},{86,-920}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner11(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{132,-950},{152,-930}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm11(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-136,-938},{-116,-918}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc11(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-68,-938},{-88,-918}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir11(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-88,-968},{-68,-948}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea11(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=34.1906328583071)
    annotation (Placement(transformation(extent={{-136,-964},{-116,-944}})));
  Modelica.Blocks.Sources.Constant qIntGai12
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-12,-1030},{8,-1010}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon12(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_BackRow_MiddleFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{48,-1050},{88,-1010}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner12(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{134,-1040},{154,-1020}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm12(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-134,-1028},{-114,-1008}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc12(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-66,-1028},{-86,-1008}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir12(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-86,-1058},{-66,-1038}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea12(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=47.0121201801723)
    annotation (Placement(transformation(extent={{-134,-1054},{-114,-1034}})));
  Modelica.Blocks.Sources.Constant qIntGai13
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-1134},{6,-1114}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon13(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_FrontRow_TopFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-1154},{86,-1114}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner13(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{132,-1144},{152,-1124}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm13(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-136,-1132},{-116,-1112}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc13(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-68,-1132},{-88,-1112}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir13(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-88,-1162},{-68,-1142}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea13(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-136,-1158},{-116,-1138}})));
  Modelica.Blocks.Sources.Constant qIntGai14
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-1222},{6,-1202}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon14(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_FrontRow_TopFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-1242},{86,-1202}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner14(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{132,-1232},{152,-1212}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm14(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-136,-1220},{-116,-1200}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc14(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-68,-1220},{-88,-1200}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir14(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-88,-1250},{-68,-1230}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea14(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=94.5270437847315)
    annotation (Placement(transformation(extent={{-136,-1246},{-116,-1226}})));
  Modelica.Blocks.Sources.Constant qIntGai15
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{6,-1318},{26,-1298}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon15(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_FrontRow_TopFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{66,-1338},{106,-1298}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner15(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{152,-1328},{172,-1308}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm15(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-116,-1316},{-96,-1296}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc15(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-48,-1316},{-68,-1296}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir15(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-68,-1346},{-48,-1326}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea15(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-116,-1342},{-96,-1322}})));
  Modelica.Blocks.Sources.Constant qIntGai16
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-4,-1410},{16,-1390}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon16(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_BackRow_TopFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{56,-1430},{96,-1390}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner16(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{142,-1420},{162,-1400}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm16(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-126,-1408},{-106,-1388}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc16(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-58,-1408},{-78,-1388}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir16(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-78,-1438},{-58,-1418}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea16(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-126,-1434},{-106,-1414}})));
  Modelica.Blocks.Sources.Constant qIntGai17
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-8,-1520},{12,-1500}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon17(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_BackRow_TopFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{52,-1540},{92,-1500}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner17(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{138,-1530},{158,-1510}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm17(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-130,-1518},{-110,-1498}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc17(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-62,-1518},{-82,-1498}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir17(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-82,-1548},{-62,-1528}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea17(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=94.5270437847315)
    annotation (Placement(transformation(extent={{-130,-1544},{-110,-1524}})));
  Modelica.Blocks.Sources.Constant qIntGai18
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-10,-1620},{10,-1600}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon18(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_BackRow_TopFloor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{50,-1640},{90,-1600}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner18(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{136,-1630},{156,-1610}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm18(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-132,-1618},{-112,-1598}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc18(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-64,-1618},{-84,-1598}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir18(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-84,-1648},{-64,-1628}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea18(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=107.348531106597)
    annotation (Placement(transformation(extent={{-132,-1644},{-112,-1624}})));
  Modelica.Blocks.Sources.Constant qIntGai19
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-1712},{6,-1692}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon19(
    redeclare package Medium = MediumAir,
    zoneName="Breezeway",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-1732},{86,-1692}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner19(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{132,-1722},{152,-1702}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm19(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-136,-1710},{-116,-1690}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc19(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-68,-1710},{-88,-1690}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir19(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-88,-1740},{-68,-1720}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea19(
    staCoe=0.00029,
    winCoe=0.000231,
    effAirLeaAre=0)
    annotation (Placement(transformation(extent={{-136,-1736},{-116,-1716}})));
  Modelica.Blocks.Sources.Constant qIntGai20
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-1798},{4,-1778}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon20(
    redeclare package Medium = MediumAir,
    zoneName="attic",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-1818},{84,-1778}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner20(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{130,-1808},{150,-1788}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm20(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-138,-1796},{-118,-1776}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc20(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-70,-1796},{-90,-1776}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir20(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-90,-1826},{-70,-1806}})));
  CCC.Controls.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea20(
    staCoe=0.000435,
    winCoe=0.000271,
    effAirLeaAre=33300)
    annotation (Placement(transformation(extent={{-138,-1822},{-118,-1802}})));
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
    annotation (Line(points={{-118,26},{-100,26},{-100,30},{-92,30}},  color={0,
          0,127}));
  connect(zon1.TAir, infiltration_EffectiveLeakageArea1.zonAirTem) annotation (
      Line(points={{83,58},{88,58},{88,78},{-148,78},{-148,38},{-150,38},{-150,
          30.2},{-142,30.2}},       color={0,0,127}));
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
  connect(building.weaBus,infiltration_EffectiveLeakageArea2. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-71.4},{-140.4,-71.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea2.infFloRat,freshAir2. m_flow_in)
    annotation (Line(points={{-118,-66},{-100,-66},{-100,-62},{-92,-62}},
                                                                       color={0,
          0,127}));
  connect(zon2.TAir,infiltration_EffectiveLeakageArea2. zonAirTem) annotation (
      Line(points={{83,-34},{88,-34},{88,-22},{-150,-22},{-150,-61.8},{-142,
          -61.8}},                  color={0,0,127}));
  connect(freshAir2.ports[1], zon2.ports[4]) annotation (Line(points={{-72,-70},
          {36,-70},{36,-78},{62.8,-78},{62.8,-71.1}}, color={0,127,255}));
  connect(duc2.port_a, zon2.ports[5]) annotation (Line(points={{-72,-40},{-24,
          -40},{-24,-78},{63.6,-78},{63.6,-71.1}}, color={0,127,255}));
  connect(zon3.qGai_flow,qIntGai3. y)
    annotation (Line(points={{40,-144},{3,-144}},  color={0,0,127}));
  connect(zon3.TAir,trc_custom_air_conditioner3. ZAT) annotation (Line(points={{83,-136},
          {118,-136},{118,-147.6},{126,-147.6}},       color={0,0,127}));
  connect(trc_custom_air_conditioner3.port_b,zon3. ports[3]) annotation (Line(
        points={{148.8,-161.6},{154,-161.6},{154,-180},{62,-180},{62,-173.1}},
        color={0,127,255}));
  connect(zon3.ports[2],trc_custom_air_conditioner3. port_a) annotation (Line(
        points={{61.2,-173.1},{61.2,-180},{122,-180},{122,-161.4},{127.6,-161.4}},
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
      Line(points={{83,-136},{88,-136},{88,-124},{-150,-124},{-150,-163.8},{
          -142,-163.8}},            color={0,0,127}));
  connect(freshAir3.ports[1], zon3.ports[4]) annotation (Line(points={{-72,-172},
          {36,-172},{36,-180},{62.8,-180},{62.8,-173.1}}, color={0,127,255}));
  connect(duc3.port_a, zon3.ports[5]) annotation (Line(points={{-72,-142},{-24,
          -142},{-24,-180},{63.6,-180},{63.6,-173.1}}, color={0,127,255}));
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
  connect(zon7.qGai_flow,qIntGai7. y)
    annotation (Line(points={{42,-520},{5,-520}},  color={0,0,127}));
  connect(zon7.TAir,trc_custom_air_conditioner7. ZAT) annotation (Line(points={{85,-512},
          {120,-512},{120,-523.6},{128,-523.6}},       color={0,0,127}));
  connect(trc_custom_air_conditioner7.port_b,zon7. ports[3]) annotation (Line(
        points={{150.8,-537.6},{156,-537.6},{156,-556},{64,-556},{64,-549.1}},
        color={0,127,255}));
  connect(zon7.ports[2],trc_custom_air_conditioner7. port_a) annotation (Line(
        points={{63.2,-549.1},{63.2,-556},{124,-556},{124,-537.4},{129.6,-537.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir7. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-452},{-142,-452},{-142,-502},{-100,-502},
          {-100,-547.8},{-90,-547.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc7.port_b,pAtm7. ports[1])
    annotation (Line(points={{-90,-518},{-118,-518}},
                                                 color={0,127,255}));
  connect(building.weaBus,infiltration_EffectiveLeakageArea7. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-549.4},{-138.4,-549.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea7.infFloRat,freshAir7. m_flow_in)
    annotation (Line(points={{-116,-544},{-98,-544},{-98,-540},{-90,-540}},
                                                                       color={0,
          0,127}));
  connect(zon7.TAir,infiltration_EffectiveLeakageArea7. zonAirTem) annotation (
      Line(points={{85,-512},{90,-512},{90,-500},{-148,-500},{-148,-539.8},{
          -140,-539.8}},            color={0,0,127}));
  connect(freshAir7.ports[1], zon7.ports[4]) annotation (Line(points={{-70,-548},
          {38,-548},{38,-556},{64.8,-556},{64.8,-549.1}}, color={0,127,255}));
  connect(duc7.port_a, zon7.ports[5]) annotation (Line(points={{-70,-518},{-22,
          -518},{-22,-556},{65.6,-556},{65.6,-549.1}}, color={0,127,255}));
  connect(zon8.qGai_flow,qIntGai8. y)
    annotation (Line(points={{40,-616},{3,-616}},  color={0,0,127}));
  connect(zon8.TAir,trc_custom_air_conditioner8. ZAT) annotation (Line(points={{83,-608},
          {116,-608},{116,-619.6},{126,-619.6}},       color={0,0,127}));
  connect(trc_custom_air_conditioner8.port_b,zon8. ports[3]) annotation (Line(
        points={{148.8,-633.6},{156,-633.6},{156,-664},{62,-664},{62,-645.1}},
        color={0,127,255}));
  connect(zon8.ports[2],trc_custom_air_conditioner8. port_a) annotation (Line(
        points={{61.2,-645.1},{61.2,-660},{116,-660},{116,-633.4},{127.6,-633.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir8. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-596},{-100,-596},{-100,-643.8},{-92,
          -643.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc8.port_b,pAtm8. ports[1])
    annotation (Line(points={{-92,-614},{-120,-614}},
                                                 color={0,127,255}));
  connect(building.weaBus,infiltration_EffectiveLeakageArea8. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-645.4},{-140.4,
          -645.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea8.infFloRat,freshAir8. m_flow_in)
    annotation (Line(points={{-118,-640},{-118,-636},{-92,-636}},      color={0,
          0,127}));
  connect(zon8.TAir,infiltration_EffectiveLeakageArea8. zonAirTem) annotation (
      Line(points={{83,-608},{83,-596},{-156,-596},{-156,-635.8},{-142,-635.8}},
                                    color={0,0,127}));
  connect(freshAir8.ports[1], zon8.ports[4]) annotation (Line(points={{-72,-644},
          {32,-644},{32,-660},{62.8,-660},{62.8,-645.1}}, color={0,127,255}));
  connect(duc8.port_a, zon8.ports[5]) annotation (Line(points={{-72,-614},{-72,
          -616},{-32,-616},{-32,-664},{63.6,-664},{63.6,-645.1}}, color={0,127,
          255}));
  connect(zon9.qGai_flow,qIntGai9. y)
    annotation (Line(points={{42,-726},{5,-726}},  color={0,0,127}));
  connect(zon9.TAir,trc_custom_air_conditioner9. ZAT) annotation (Line(points={{85,-718},
          {85,-729.6},{128,-729.6}},                   color={0,0,127}));
  connect(trc_custom_air_conditioner9.port_b,zon9. ports[3]) annotation (Line(
        points={{150.8,-743.6},{160,-743.6},{160,-768},{64,-768},{64,-755.1}},
        color={0,127,255}));
  connect(zon9.ports[2],trc_custom_air_conditioner9. port_a) annotation (Line(
        points={{63.2,-755.1},{63.2,-768},{129.6,-768},{129.6,-743.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir9. weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-708},{-100,-708},
          {-100,-753.8},{-90,-753.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc9.port_b,pAtm9. ports[1])
    annotation (Line(points={{-90,-724},{-118,-724}},
                                                 color={0,127,255}));
  connect(building.weaBus,infiltration_EffectiveLeakageArea9. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-755.4},{-138.4,
          -755.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea9.infFloRat,freshAir9. m_flow_in)
    annotation (Line(points={{-116,-750},{-116,-746},{-90,-746}},      color={0,
          0,127}));
  connect(zon9.TAir,infiltration_EffectiveLeakageArea9. zonAirTem) annotation (
      Line(points={{85,-718},{85,-720},{96,-720},{96,-704},{-148,-704},{-148,
          -745.8},{-140,-745.8}},   color={0,0,127}));
  connect(freshAir9.ports[1], zon9.ports[4]) annotation (Line(points={{-70,-754},
          {32,-754},{32,-768},{64.8,-768},{64.8,-755.1}}, color={0,127,255}));
  connect(duc9.port_a, zon9.ports[5]) annotation (Line(points={{-70,-724},{-28,
          -724},{-28,-768},{65.6,-768},{65.6,-755.1}}, color={0,127,255}));
  connect(zon10.qGai_flow, qIntGai10.y)
    annotation (Line(points={{42,-830},{5,-830}}, color={0,0,127}));
  connect(zon10.TAir, trc_custom_air_conditioner10.ZAT) annotation (Line(points=
         {{85,-822},{85,-833.6},{128,-833.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner10.port_b, zon10.ports[3]) annotation (Line(
        points={{150.8,-847.6},{160,-847.6},{160,-872},{64,-872},{64,-859.1}},
        color={0,127,255}));
  connect(zon10.ports[2], trc_custom_air_conditioner10.port_a) annotation (Line(
        points={{63.2,-859.1},{63.2,-872},{129.6,-872},{129.6,-847.4}}, color={
          0,127,255}));
  connect(building.weaBus, freshAir10.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-812},{-100,-812},
          {-100,-857.8},{-90,-857.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc10.port_b, pAtm10.ports[1])
    annotation (Line(points={{-90,-828},{-118,-828}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea10.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-859.4},{-138.4,
          -859.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea10.infFloRat, freshAir10.m_flow_in)
    annotation (Line(points={{-116,-854},{-116,-850},{-90,-850}}, color={0,0,
          127}));
  connect(zon10.TAir, infiltration_EffectiveLeakageArea10.zonAirTem)
    annotation (Line(points={{85,-822},{85,-824},{96,-824},{96,-808},{-148,-808},
          {-148,-849.8},{-140,-849.8}}, color={0,0,127}));
  connect(freshAir10.ports[1], zon10.ports[4]) annotation (Line(points={{-70,
          -858},{32,-858},{32,-872},{64.8,-872},{64.8,-859.1}}, color={0,127,
          255}));
  connect(duc10.port_a, zon10.ports[5]) annotation (Line(points={{-70,-828},{
          -28,-828},{-28,-872},{65.6,-872},{65.6,-859.1}}, color={0,127,255}));
  connect(zon11.qGai_flow, qIntGai11.y)
    annotation (Line(points={{44,-930},{7,-930}}, color={0,0,127}));
  connect(zon11.TAir, trc_custom_air_conditioner11.ZAT) annotation (Line(points=
         {{87,-922},{87,-933.6},{130,-933.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner11.port_b, zon11.ports[3]) annotation (Line(
        points={{152.8,-947.6},{160,-947.6},{160,-972},{66,-972},{66,-959.1}},
        color={0,127,255}));
  connect(zon11.ports[2], trc_custom_air_conditioner11.port_a) annotation (Line(
        points={{65.2,-959.1},{65.2,-972},{120,-972},{120,-947.4},{131.6,-947.4}},
        color={0,127,255}));
  connect(building.weaBus, freshAir11.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-908},{-96,-908},
          {-96,-957.8},{-88,-957.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc11.port_b, pAtm11.ports[1])
    annotation (Line(points={{-88,-928},{-116,-928}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea11.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-959.4},{-136.4,
          -959.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea11.infFloRat, freshAir11.m_flow_in)
    annotation (Line(points={{-114,-954},{-114,-950},{-88,-950}}, color={0,0,
          127}));
  connect(zon11.TAir, infiltration_EffectiveLeakageArea11.zonAirTem)
    annotation (Line(points={{87,-922},{87,-924},{100,-924},{100,-908},{-152,
          -908},{-152,-949.8},{-138,-949.8}}, color={0,0,127}));
  connect(freshAir11.ports[1], zon11.ports[4]) annotation (Line(points={{-68,
          -958},{-68,-960},{36,-960},{36,-972},{66.8,-972},{66.8,-959.1}},
        color={0,127,255}));
  connect(duc11.port_a, zon11.ports[5]) annotation (Line(points={{-68,-928},{
          -28,-928},{-28,-972},{67.6,-972},{67.6,-959.1}}, color={0,127,255}));
  connect(zon12.qGai_flow, qIntGai12.y)
    annotation (Line(points={{46,-1020},{9,-1020}}, color={0,0,127}));
  connect(zon12.TAir, trc_custom_air_conditioner12.ZAT) annotation (Line(points=
         {{89,-1012},{132,-1012},{132,-1023.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner12.port_b, zon12.ports[3]) annotation (Line(
        points={{154.8,-1037.6},{164,-1037.6},{164,-1068},{68,-1068},{68,
          -1049.1}}, color={0,127,255}));
  connect(zon12.ports[2], trc_custom_air_conditioner12.port_a) annotation (Line(
        points={{67.2,-1049.1},{67.2,-1064},{133.6,-1064},{133.6,-1037.4}},
        color={0,127,255}));
  connect(building.weaBus, freshAir12.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-996},{-96,-996},
          {-96,-1047.8},{-86,-1047.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc12.port_b, pAtm12.ports[1])
    annotation (Line(points={{-86,-1018},{-114,-1018}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea12.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1049.4},{-134.4,
          -1049.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea12.infFloRat, freshAir12.m_flow_in)
    annotation (Line(points={{-112,-1044},{-112,-1040},{-86,-1040}}, color={0,0,
          127}));
  connect(zon12.TAir, infiltration_EffectiveLeakageArea12.zonAirTem)
    annotation (Line(points={{89,-1012},{89,-1000},{-144,-1000},{-144,-1039.8},
          {-136,-1039.8}}, color={0,0,127}));
  connect(freshAir12.ports[1], zon12.ports[4]) annotation (Line(points={{-66,
          -1048},{36,-1048},{36,-1064},{68.8,-1064},{68.8,-1049.1}}, color={0,
          127,255}));
  connect(duc12.port_a, zon12.ports[5]) annotation (Line(points={{-66,-1018},{
          -60,-1018},{-60,-1068},{69.6,-1068},{69.6,-1049.1}}, color={0,127,255}));
  connect(zon13.qGai_flow, qIntGai13.y)
    annotation (Line(points={{44,-1124},{7,-1124}}, color={0,0,127}));
  connect(zon13.TAir, trc_custom_air_conditioner13.ZAT) annotation (Line(points=
         {{87,-1116},{120,-1116},{120,-1127.6},{130,-1127.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner13.port_b, zon13.ports[3]) annotation (Line(
        points={{152.8,-1141.6},{160,-1141.6},{160,-1172},{66,-1172},{66,
          -1153.1}}, color={0,127,255}));
  connect(zon13.ports[2], trc_custom_air_conditioner13.port_a) annotation (Line(
        points={{65.2,-1153.1},{65.2,-1168},{120,-1168},{120,-1141.4},{131.6,
          -1141.4}}, color={0,127,255}));
  connect(building.weaBus, freshAir13.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1100},{-96,
          -1100},{-96,-1151.8},{-88,-1151.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc13.port_b, pAtm13.ports[1])
    annotation (Line(points={{-88,-1122},{-116,-1122}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea13.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1153.4},{-136.4,
          -1153.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea13.infFloRat, freshAir13.m_flow_in)
    annotation (Line(points={{-114,-1148},{-114,-1144},{-88,-1144}}, color={0,0,
          127}));
  connect(zon13.TAir, infiltration_EffectiveLeakageArea13.zonAirTem)
    annotation (Line(points={{87,-1116},{87,-1104},{-152,-1104},{-152,-1143.8},
          {-138,-1143.8}}, color={0,0,127}));
  connect(freshAir13.ports[1], zon13.ports[4]) annotation (Line(points={{-68,
          -1152},{36,-1152},{36,-1168},{66.8,-1168},{66.8,-1153.1}}, color={0,
          127,255}));
  connect(duc13.port_a, zon13.ports[5]) annotation (Line(points={{-68,-1122},{
          -68,-1124},{-28,-1124},{-28,-1172},{67.6,-1172},{67.6,-1153.1}},
        color={0,127,255}));
  connect(zon14.qGai_flow, qIntGai14.y)
    annotation (Line(points={{44,-1212},{7,-1212}}, color={0,0,127}));
  connect(zon14.TAir, trc_custom_air_conditioner14.ZAT) annotation (Line(points=
         {{87,-1204},{120,-1204},{120,-1215.6},{130,-1215.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner14.port_b, zon14.ports[3]) annotation (Line(
        points={{152.8,-1229.6},{160,-1229.6},{160,-1260},{66,-1260},{66,
          -1241.1}}, color={0,127,255}));
  connect(zon14.ports[2], trc_custom_air_conditioner14.port_a) annotation (Line(
        points={{65.2,-1241.1},{65.2,-1256},{120,-1256},{120,-1229.4},{131.6,
          -1229.4}}, color={0,127,255}));
  connect(building.weaBus, freshAir14.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1188},{-96,
          -1188},{-96,-1239.8},{-88,-1239.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc14.port_b, pAtm14.ports[1])
    annotation (Line(points={{-88,-1210},{-116,-1210}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea14.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1241.4},{-136.4,
          -1241.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea14.infFloRat, freshAir14.m_flow_in)
    annotation (Line(points={{-114,-1236},{-114,-1232},{-88,-1232}}, color={0,0,
          127}));
  connect(zon14.TAir, infiltration_EffectiveLeakageArea14.zonAirTem)
    annotation (Line(points={{87,-1204},{87,-1192},{-152,-1192},{-152,-1231.8},
          {-138,-1231.8}}, color={0,0,127}));
  connect(freshAir14.ports[1], zon14.ports[4]) annotation (Line(points={{-68,
          -1240},{36,-1240},{36,-1256},{66.8,-1256},{66.8,-1241.1}}, color={0,
          127,255}));
  connect(duc14.port_a, zon14.ports[5]) annotation (Line(points={{-68,-1210},{
          -68,-1212},{-28,-1212},{-28,-1260},{67.6,-1260},{67.6,-1241.1}},
        color={0,127,255}));
  connect(zon15.qGai_flow, qIntGai15.y)
    annotation (Line(points={{64,-1308},{27,-1308}}, color={0,0,127}));
  connect(zon15.TAir, trc_custom_air_conditioner15.ZAT) annotation (Line(points=
         {{107,-1300},{128,-1300},{128,-1311.6},{150,-1311.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner15.port_b, zon15.ports[3]) annotation (Line(
        points={{172.8,-1325.6},{178,-1325.6},{178,-1337.1},{86,-1337.1}},
        color={0,127,255}));
  connect(zon15.ports[2], trc_custom_air_conditioner15.port_a) annotation (Line(
        points={{85.2,-1337.1},{85.2,-1340},{146,-1340},{146,-1325.4},{151.6,
          -1325.4}}, color={0,127,255}));
  connect(building.weaBus, freshAir15.weaBus) annotation (Line(
      points={{-218,28},{-128,28},{-128,-1338},{-122,-1338},{-122,-1348},{-78,
          -1348},{-78,-1335.8},{-68,-1335.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc15.port_b, pAtm15.ports[1])
    annotation (Line(points={{-68,-1306},{-96,-1306}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea15.weaBus)
    annotation (Line(
      points={{-218,28},{-128,28},{-128,-1337.4},{-116.4,-1337.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea15.infFloRat, freshAir15.m_flow_in)
    annotation (Line(points={{-94,-1332},{-76,-1332},{-76,-1328},{-68,-1328}},
        color={0,0,127}));
  connect(zon15.TAir, infiltration_EffectiveLeakageArea15.zonAirTem)
    annotation (Line(points={{107,-1300},{112,-1300},{112,-1280},{-124,-1280},{
          -124,-1320},{-126,-1320},{-126,-1327.8},{-118,-1327.8}}, color={0,0,
          127}));
  connect(freshAir15.ports[1], zon15.ports[4]) annotation (Line(points={{-48,
          -1336},{60,-1336},{60,-1344},{86.8,-1344},{86.8,-1337.1}}, color={0,
          127,255}));
  connect(duc15.port_a, zon15.ports[5]) annotation (Line(points={{-48,-1306},{
          -4,-1306},{-4,-1336},{60,-1336},{60,-1344},{87.6,-1344},{87.6,-1337.1}},
        color={0,127,255}));
  connect(zon16.qGai_flow, qIntGai16.y)
    annotation (Line(points={{54,-1400},{17,-1400}}, color={0,0,127}));
  connect(zon16.TAir, trc_custom_air_conditioner16.ZAT) annotation (Line(points=
         {{97,-1392},{140,-1392},{140,-1403.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner16.port_b, zon16.ports[3]) annotation (Line(
        points={{162.8,-1417.6},{172,-1417.6},{172,-1448},{76,-1448},{76,
          -1429.1}}, color={0,127,255}));
  connect(zon16.ports[2], trc_custom_air_conditioner16.port_a) annotation (Line(
        points={{75.2,-1429.1},{75.2,-1444},{141.6,-1444},{141.6,-1417.4}},
        color={0,127,255}));
  connect(building.weaBus, freshAir16.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1376},{-88,
          -1376},{-88,-1427.8},{-78,-1427.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc16.port_b, pAtm16.ports[1])
    annotation (Line(points={{-78,-1398},{-106,-1398}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea16.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1429.4},{-126.4,
          -1429.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea16.infFloRat, freshAir16.m_flow_in)
    annotation (Line(points={{-104,-1424},{-104,-1420},{-78,-1420}}, color={0,0,
          127}));
  connect(zon16.TAir, infiltration_EffectiveLeakageArea16.zonAirTem)
    annotation (Line(points={{97,-1392},{97,-1380},{-136,-1380},{-136,-1419.8},
          {-128,-1419.8}}, color={0,0,127}));
  connect(freshAir16.ports[1], zon16.ports[4]) annotation (Line(points={{-58,
          -1428},{44,-1428},{44,-1444},{76.8,-1444},{76.8,-1429.1}}, color={0,
          127,255}));
  connect(duc16.port_a, zon16.ports[5]) annotation (Line(points={{-58,-1398},{
          -52,-1398},{-52,-1448},{77.6,-1448},{77.6,-1429.1}}, color={0,127,255}));
  connect(zon17.qGai_flow, qIntGai17.y)
    annotation (Line(points={{50,-1510},{13,-1510}}, color={0,0,127}));
  connect(zon17.TAir, trc_custom_air_conditioner17.ZAT) annotation (Line(points=
         {{93,-1502},{93,-1513.6},{136,-1513.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner17.port_b, zon17.ports[3]) annotation (Line(
        points={{158.8,-1527.6},{168,-1527.6},{168,-1552},{72,-1552},{72,
          -1539.1}}, color={0,127,255}));
  connect(zon17.ports[2], trc_custom_air_conditioner17.port_a) annotation (Line(
        points={{71.2,-1539.1},{71.2,-1552},{137.6,-1552},{137.6,-1527.4}},
        color={0,127,255}));
  connect(building.weaBus, freshAir17.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1492},{-92,-1492},{-92,-1537.8},{-82,-1537.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc17.port_b, pAtm17.ports[1])
    annotation (Line(points={{-82,-1508},{-110,-1508}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea17.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1539.4},{-130.4,-1539.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea17.infFloRat, freshAir17.m_flow_in)
    annotation (Line(points={{-108,-1534},{-108,-1530},{-82,-1530}}, color={0,0,
          127}));
  connect(zon17.TAir, infiltration_EffectiveLeakageArea17.zonAirTem)
    annotation (Line(points={{93,-1502},{93,-1504},{104,-1504},{104,-1488},{
          -140,-1488},{-140,-1529.8},{-132,-1529.8}}, color={0,0,127}));
  connect(freshAir17.ports[1], zon17.ports[4]) annotation (Line(points={{-62,
          -1538},{40,-1538},{40,-1552},{72.8,-1552},{72.8,-1539.1}}, color={0,
          127,255}));
  connect(duc17.port_a, zon17.ports[5]) annotation (Line(points={{-62,-1508},{
          -20,-1508},{-20,-1552},{73.6,-1552},{73.6,-1539.1}}, color={0,127,255}));
  connect(zon18.qGai_flow, qIntGai18.y)
    annotation (Line(points={{48,-1610},{11,-1610}}, color={0,0,127}));
  connect(zon18.TAir, trc_custom_air_conditioner18.ZAT) annotation (Line(points=
         {{91,-1602},{91,-1613.6},{134,-1613.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner18.port_b, zon18.ports[3]) annotation (Line(
        points={{156.8,-1627.6},{164,-1627.6},{164,-1652},{70,-1652},{70,
          -1639.1}}, color={0,127,255}));
  connect(zon18.ports[2], trc_custom_air_conditioner18.port_a) annotation (Line(
        points={{69.2,-1639.1},{69.2,-1652},{124,-1652},{124,-1627.4},{135.6,
          -1627.4}}, color={0,127,255}));
  connect(building.weaBus, freshAir18.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1592},{-92,-1592},{-92,-1637.8},{-84,-1637.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc18.port_b, pAtm18.ports[1])
    annotation (Line(points={{-84,-1608},{-112,-1608}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea18.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1639.4},{-132.4,-1639.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea18.infFloRat, freshAir18.m_flow_in)
    annotation (Line(points={{-110,-1634},{-110,-1630},{-84,-1630}}, color={0,0,
          127}));
  connect(zon18.TAir, infiltration_EffectiveLeakageArea18.zonAirTem)
    annotation (Line(points={{91,-1602},{91,-1604},{104,-1604},{104,-1588},{
          -148,-1588},{-148,-1629.8},{-134,-1629.8}}, color={0,0,127}));
  connect(freshAir18.ports[1], zon18.ports[4]) annotation (Line(points={{-64,
          -1638},{-64,-1640},{40,-1640},{40,-1652},{70.8,-1652},{70.8,-1639.1}},
        color={0,127,255}));
  connect(duc18.port_a, zon18.ports[5]) annotation (Line(points={{-64,-1608},{
          -24,-1608},{-24,-1652},{71.6,-1652},{71.6,-1639.1}}, color={0,127,255}));
  connect(zon19.qGai_flow, qIntGai19.y)
    annotation (Line(points={{44,-1702},{7,-1702}}, color={0,0,127}));
  connect(zon19.TAir, trc_custom_air_conditioner19.ZAT) annotation (Line(points=
         {{87,-1694},{87,-1705.6},{130,-1705.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner19.port_b, zon19.ports[3]) annotation (Line(
        points={{152.8,-1719.6},{160,-1719.6},{160,-1744},{66,-1744},{66,
          -1731.1}}, color={0,127,255}));
  connect(zon19.ports[2], trc_custom_air_conditioner19.port_a) annotation (Line(
        points={{65.2,-1731.1},{65.2,-1744},{120,-1744},{120,-1719.4},{131.6,
          -1719.4}}, color={0,127,255}));
  connect(building.weaBus, freshAir19.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1684},{-96,-1684},{-96,
          -1729.8},{-88,-1729.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc19.port_b, pAtm19.ports[1])
    annotation (Line(points={{-88,-1700},{-116,-1700}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea19.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1712},{-148,-1712},{-148,
          -1731.4},{-136.4,-1731.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea19.infFloRat, freshAir19.m_flow_in)
    annotation (Line(points={{-114,-1726},{-114,-1722},{-88,-1722}}, color={0,0,
          127}));
  connect(zon19.TAir, infiltration_EffectiveLeakageArea19.zonAirTem)
    annotation (Line(points={{87,-1694},{87,-1696},{100,-1696},{100,-1680},{
          -152,-1680},{-152,-1721.8},{-138,-1721.8}}, color={0,0,127}));
  connect(freshAir19.ports[1], zon19.ports[4]) annotation (Line(points={{-68,
          -1730},{-68,-1732},{36,-1732},{36,-1744},{66.8,-1744},{66.8,-1731.1}},
        color={0,127,255}));
  connect(duc19.port_a, zon19.ports[5]) annotation (Line(points={{-68,-1700},{
          -28,-1700},{-28,-1744},{67.6,-1744},{67.6,-1731.1}}, color={0,127,255}));
  connect(zon20.qGai_flow, qIntGai20.y)
    annotation (Line(points={{42,-1788},{5,-1788}}, color={0,0,127}));
  connect(zon20.TAir, trc_custom_air_conditioner20.ZAT) annotation (Line(points=
         {{85,-1780},{128,-1780},{128,-1791.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner20.port_b, zon20.ports[3]) annotation (Line(
        points={{150.8,-1805.6},{160,-1805.6},{160,-1836},{64,-1836},{64,
          -1817.1}}, color={0,127,255}));
  connect(zon20.ports[2], trc_custom_air_conditioner20.port_a) annotation (Line(
        points={{63.2,-1817.1},{63.2,-1832},{129.6,-1832},{129.6,-1805.4}},
        color={0,127,255}));
  connect(building.weaBus, freshAir20.weaBus) annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1712},{-148,-1712},{-148,
          -1768},{-100,-1768},{-100,-1815.8},{-90,-1815.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc20.port_b, pAtm20.ports[1])
    annotation (Line(points={{-90,-1786},{-118,-1786}}, color={0,127,255}));
  connect(building.weaBus, infiltration_EffectiveLeakageArea20.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1712},{-148,-1712},{-148,
          -1817.4},{-138.4,-1817.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea20.infFloRat, freshAir20.m_flow_in)
    annotation (Line(points={{-116,-1812},{-116,-1808},{-90,-1808}}, color={0,0,
          127}));
  connect(zon20.TAir, infiltration_EffectiveLeakageArea20.zonAirTem)
    annotation (Line(points={{85,-1780},{85,-1768},{-148,-1768},{-148,-1807.8},
          {-140,-1807.8}}, color={0,0,127}));
  connect(freshAir20.ports[1], zon20.ports[4]) annotation (Line(points={{-70,
          -1816},{32,-1816},{32,-1832},{64.8,-1832},{64.8,-1817.1}}, color={0,
          127,255}));
  connect(duc20.port_a, zon20.ports[5]) annotation (Line(points={{-70,-1786},{
          -64,-1786},{-64,-1836},{65.6,-1836},{65.6,-1817.1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=15552000,
      StopTime=15638400,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end TRC_building_low_rise_rochester;
