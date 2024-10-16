within CCC_test.Example2;
model TRC_building_mid_rise_rochester

          extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

       parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

  parameter Modelica.Units.SI.MassFlowRate mOut_flow_nominal=0.17
    "Outdoor air mass flow rate, assuming constant infiltration air flow rate";

                  parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/Data/energyPlusFiles/MidriseApartmentModern_6A_USA_MN_MINNEAPOLIS_V960_v2.idf"),
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
    zoneName="G SW Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,20},{82,60}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner1(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate1(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-140,16},{-120,36}})));
  Modelica.Blocks.Sources.Constant qIntGai2[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-52},{2,-32}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon2(
    redeclare package Medium = MediumAir,
    zoneName="G NW Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,-72},{82,-32}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner2(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate2(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-140,-76},{-120,-56}})));
  Modelica.Blocks.Sources.Constant qIntGai3[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-154},{2,-134}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon3(
    redeclare package Medium = MediumAir,
    zoneName="Office",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,-174},{82,-134}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner3(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate3(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-140,-178},{-120,-158}})));
  Modelica.Blocks.Sources.Constant qIntGai4[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-20,-246},{0,-226}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon4(
    redeclare package Medium = MediumAir,
    zoneName="G NE Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{40,-266},{80,-226}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner4(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate4(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-142,-270},{-122,-250}})));
  Modelica.Blocks.Sources.Constant qIntGai5[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-342},{6,-322}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon5(
    redeclare package Medium = MediumAir,
    zoneName="G N1 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-362},{86,-322}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner5(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate5(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-136,-366},{-116,-346}})));
  Modelica.Blocks.Sources.Constant qIntGai6[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-432},{6,-412}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon6(
    redeclare package Medium = MediumAir,
    zoneName="G N2 Apartment",
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate6(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-136,-456},{-116,-436}})));
  Modelica.Blocks.Sources.Constant qIntGai7[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-530},{4,-510}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon7(
    redeclare package Medium = MediumAir,
    zoneName="G S1 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-550},{84,-510}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner7(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate7(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-138,-554},{-118,-534}})));
  Modelica.Blocks.Sources.Constant qIntGai8[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,-626},{2,-606}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon8(
    redeclare package Medium = MediumAir,
    zoneName="G S2 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,-646},{82,-606}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner8(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate8(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-140,-650},{-120,-630}})));
  Modelica.Blocks.Sources.Constant qIntGai9[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-736},{4,-716}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon9(
    redeclare package Medium = MediumAir,
    zoneName="M SW Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-756},{84,-716}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner9(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate9(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-138,-760},{-118,-740}})));
  Modelica.Blocks.Sources.Constant qIntGai10
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-840},{4,-820}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon10(
    redeclare package Medium = MediumAir,
    zoneName="M NW Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{44,-860},{84,-820}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner10(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate10(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-138,-864},{-118,-844}})));
  Modelica.Blocks.Sources.Constant qIntGai11
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-940},{6,-920}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon11(
    redeclare package Medium = MediumAir,
    zoneName="M SE Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-960},{86,-920}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner11(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate11(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-136,-964},{-116,-944}})));
  Modelica.Blocks.Sources.Constant qIntGai12
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-12,-1030},{8,-1010}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon12(
    redeclare package Medium = MediumAir,
    zoneName="M NE Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{48,-1050},{88,-1010}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner12(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate12(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-134,-1054},{-114,-1034}})));
  Modelica.Blocks.Sources.Constant qIntGai13
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-1134},{6,-1114}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon13(
    redeclare package Medium = MediumAir,
    zoneName="M N1 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-1154},{86,-1114}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner13(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate13(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-136,-1158},{-116,-1138}})));
  Modelica.Blocks.Sources.Constant qIntGai14
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-1222},{6,-1202}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon14(
    redeclare package Medium = MediumAir,
    zoneName="M N2 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{46,-1242},{86,-1202}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner14(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate14(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-136,-1246},{-116,-1226}})));
  Modelica.Blocks.Sources.Constant qIntGai15
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{6,-1318},{26,-1298}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon15(
    redeclare package Medium = MediumAir,
    zoneName="M S1 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{66,-1338},{106,-1298}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner15(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate15(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-116,-1342},{-96,-1322}})));
  Modelica.Blocks.Sources.Constant qIntGai16
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-4,-1410},{16,-1390}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon16(
    redeclare package Medium = MediumAir,
    zoneName="M S2 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{56,-1430},{96,-1390}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner16(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate16(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-126,-1434},{-106,-1414}})));
  Modelica.Blocks.Sources.Constant qIntGai17
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-8,-1520},{12,-1500}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon17(
    redeclare package Medium = MediumAir,
    zoneName="T SW Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{52,-1540},{92,-1500}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner17(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate17(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-130,-1544},{-110,-1524}})));
  Modelica.Blocks.Sources.Constant qIntGai18
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-10,-1620},{10,-1600}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon18(
    redeclare package Medium = MediumAir,
    zoneName="T NW Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{50,-1640},{90,-1600}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner18(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate18(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-132,-1644},{-112,-1624}})));
  Modelica.Blocks.Sources.Constant qIntGai19
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-14,-1712},{6,-1692}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon19(
    redeclare package Medium = MediumAir,
    zoneName="T SE Apartment",
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate19(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-136,-1736},{-116,-1716}})));
  Modelica.Blocks.Sources.Constant qIntGai20
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-16,-1798},{4,-1778}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon20(
    redeclare package Medium = MediumAir,
    zoneName="T NE Apartment",
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
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate20(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.02847)
    annotation (Placement(transformation(extent={{-138,-1822},{-118,-1802}})));
  Modelica.Blocks.Sources.Constant qIntGai21
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-24,-1898},{-4,-1878}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon21(
    redeclare package Medium = MediumAir,
    zoneName="T N1 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{36,-1918},{76,-1878}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner21(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{122,-1908},{142,-1888}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm21(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-146,-1896},{-126,-1876}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc21(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-78,-1896},{-98,-1876}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir21(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-98,-1926},{-78,-1906}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate21(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-146,-1922},{-126,-1902}})));
  Modelica.Blocks.Sources.Constant qIntGai22
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-30,-2018},{-10,-1998}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon22(
    redeclare package Medium = MediumAir,
    zoneName="T N2 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{30,-2038},{70,-1998}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner22(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{116,-2028},{136,-2008}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm22(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-152,-2016},{-132,-1996}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc22(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-84,-2016},{-104,-1996}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir22(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-104,-2046},{-84,-2026}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate22(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-152,-2042},{-132,-2022}})));
  Modelica.Blocks.Sources.Constant qIntGai23
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-34,-2134},{-14,-2114}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon23(
    redeclare package Medium = MediumAir,
    zoneName="T S1 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{26,-2154},{66,-2114}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner23(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{112,-2144},{132,-2124}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm23(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-156,-2132},{-136,-2112}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc23(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-88,-2132},{-108,-2112}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir23(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-108,-2162},{-88,-2142}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate23(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-156,-2158},{-136,-2138}})));
  Modelica.Blocks.Sources.Constant qIntGai24
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-44,-2248},{-24,-2228}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon24(
    redeclare package Medium = MediumAir,
    zoneName="T S2 Apartment",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{16,-2268},{56,-2228}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner24(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{102,-2258},{122,-2238}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm24(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-166,-2246},{-146,-2226}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc24(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-98,-2246},{-118,-2226}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir24(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-118,-2276},{-98,-2256}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate24(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.01714)
    annotation (Placement(transformation(extent={{-166,-2272},{-146,-2252}})));
  Modelica.Blocks.Sources.Constant qIntGai25
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-38,-2358},{-18,-2338}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon25(
    redeclare package Medium = MediumAir,
    zoneName="T Corridor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{22,-2378},{62,-2338}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner25(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{108,-2368},{128,-2348}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm25(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-160,-2356},{-140,-2336}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc25(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-92,-2356},{-112,-2336}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir25(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-112,-2386},{-92,-2366}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate25(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.00455)
    annotation (Placement(transformation(extent={{-160,-2382},{-140,-2362}})));
  Modelica.Blocks.Sources.Constant qIntGai26
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-30,-2468},{-10,-2448}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon26(
    redeclare package Medium = MediumAir,
    zoneName="G Corridor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{30,-2488},{70,-2448}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner26(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{116,-2478},{136,-2458}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm26(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-152,-2466},{-132,-2446}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc26(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-84,-2466},{-104,-2446}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir26(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-104,-2496},{-84,-2476}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate26(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.00329)
    annotation (Placement(transformation(extent={{-152,-2490},{-132,-2470}})));
  Modelica.Blocks.Sources.Constant qIntGai27
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-40,-2576},{-20,-2556}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon27(
    redeclare package Medium = MediumAir,
    zoneName="M Corridor",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{20,-2596},{60,-2556}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner27(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet,
    HeaCooCap=0)
    annotation (Placement(transformation(extent={{106,-2586},{126,-2566}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm27(redeclare package Medium =
        MediumAir, nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{-162,-2574},{-142,-2554}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc27(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-94,-2574},{-114,-2554}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir27(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=mOut_flow_nominal,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-114,-2604},{-94,-2584}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate27(
    A=0,
    B=0,
    C=0.224,
    D=0,
    desFloRat=0.00455)
    annotation (Placement(transformation(extent={{-162,-2600},{-142,-2580}})));
  CCC.Controls.Infiltration_DesignFlowRate infiltration_DesignFlowRate26_door(
    A=1,
    B=0,
    C=0,
    D=0,
    desFloRat=0.32753)
    annotation (Placement(transformation(extent={{-154,-2522},{-134,-2502}})));
  Modelica.Blocks.Math.Add add26
    annotation (Placement(transformation(extent={{-118,-2532},{-98,-2512}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable26(
    table=[0,0; 6*3600,0.131; 7*3600,1; 8*3600,0.131; 17*3600,1; 18*3600,0.131;
        22*3600,0; 24*3600,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-236,-2572},{-216,-2552}})));
  Modelica.Blocks.Math.Product product26
    annotation (Placement(transformation(extent={{-200,-2564},{-180,-2544}})));
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
  connect(building.weaBus, infiltration_DesignFlowRate1.weaBus) annotation (
      Line(
      points={{-218,28},{-152,28},{-152,20.6},{-140.4,20.6}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate1.infFloRat, freshAir1.m_flow_in)
    annotation (Line(points={{-118,26},{-100,26},{-100,30},{-92,30}}, color={0,0,
          127}));
  connect(zon1.TAir, infiltration_DesignFlowRate1.zonAirTem) annotation (Line(
        points={{83,58},{88,58},{88,78},{-148,78},{-148,38},{-150,38},{-150,30.2},
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
  connect(building.weaBus,infiltration_DesignFlowRate2. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-71.4},{-140.4,-71.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate2.infFloRat,freshAir2. m_flow_in)
    annotation (Line(points={{-118,-66},{-100,-66},{-100,-62},{-92,-62}},
                                                                       color={0,
          0,127}));
  connect(zon2.TAir,infiltration_DesignFlowRate2. zonAirTem) annotation (
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
  connect(building.weaBus,infiltration_DesignFlowRate3. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-173.4},{-140.4,-173.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate3.infFloRat,freshAir3. m_flow_in)
    annotation (Line(points={{-118,-168},{-100,-168},{-100,-164},{-92,-164}},
                                                                       color={0,
          0,127}));
  connect(zon3.TAir,infiltration_DesignFlowRate3. zonAirTem) annotation (
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
  connect(building.weaBus,infiltration_DesignFlowRate4. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-265.4},{-142.4,-265.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate4.infFloRat,freshAir4. m_flow_in)
    annotation (Line(points={{-120,-260},{-102,-260},{-102,-256},{-94,-256}},
                                                                       color={0,
          0,127}));
  connect(zon4.TAir,infiltration_DesignFlowRate4. zonAirTem) annotation (
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
  connect(building.weaBus,infiltration_DesignFlowRate5. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-361.4},{-136.4,-361.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate5.infFloRat,freshAir5. m_flow_in)
    annotation (Line(points={{-114,-356},{-96,-356},{-96,-352},{-88,-352}},
                                                                       color={0,
          0,127}));
  connect(zon5.TAir,infiltration_DesignFlowRate5. zonAirTem) annotation (
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
  connect(building.weaBus,infiltration_DesignFlowRate6. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-451.4},{-136.4,-451.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate6.infFloRat,freshAir6. m_flow_in)
    annotation (Line(points={{-114,-446},{-96,-446},{-96,-442},{-88,-442}},
                                                                       color={0,
          0,127}));
  connect(zon6.TAir,infiltration_DesignFlowRate6. zonAirTem) annotation (
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
  connect(building.weaBus,infiltration_DesignFlowRate7. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-146,20},{-146,-54},{-152,-54},{
          -152,-266},{-148,-266},{-148,-549.4},{-138.4,-549.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate7.infFloRat,freshAir7. m_flow_in)
    annotation (Line(points={{-116,-544},{-98,-544},{-98,-540},{-90,-540}},
                                                                       color={0,
          0,127}));
  connect(zon7.TAir,infiltration_DesignFlowRate7. zonAirTem) annotation (
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
  connect(building.weaBus,infiltration_DesignFlowRate8. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-645.4},{-140.4,
          -645.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate8.infFloRat,freshAir8. m_flow_in)
    annotation (Line(points={{-118,-640},{-118,-636},{-92,-636}},      color={0,
          0,127}));
  connect(zon8.TAir,infiltration_DesignFlowRate8. zonAirTem) annotation (
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
  connect(building.weaBus,infiltration_DesignFlowRate9. weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-755.4},{-138.4,
          -755.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate9.infFloRat,freshAir9. m_flow_in)
    annotation (Line(points={{-116,-750},{-116,-746},{-90,-746}},      color={0,
          0,127}));
  connect(zon9.TAir,infiltration_DesignFlowRate9. zonAirTem) annotation (
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
  connect(building.weaBus, infiltration_DesignFlowRate10.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-859.4},{-138.4,
          -859.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate10.infFloRat, freshAir10.m_flow_in)
    annotation (Line(points={{-116,-854},{-116,-850},{-90,-850}}, color={0,0,
          127}));
  connect(zon10.TAir, infiltration_DesignFlowRate10.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate11.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-959.4},{-136.4,
          -959.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate11.infFloRat, freshAir11.m_flow_in)
    annotation (Line(points={{-114,-954},{-114,-950},{-88,-950}}, color={0,0,
          127}));
  connect(zon11.TAir, infiltration_DesignFlowRate11.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate12.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1049.4},{-134.4,
          -1049.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate12.infFloRat, freshAir12.m_flow_in)
    annotation (Line(points={{-112,-1044},{-112,-1040},{-86,-1040}}, color={0,0,
          127}));
  connect(zon12.TAir, infiltration_DesignFlowRate12.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate13.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1153.4},{-136.4,
          -1153.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate13.infFloRat, freshAir13.m_flow_in)
    annotation (Line(points={{-114,-1148},{-114,-1144},{-88,-1144}}, color={0,0,
          127}));
  connect(zon13.TAir, infiltration_DesignFlowRate13.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate14.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1241.4},{-136.4,
          -1241.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate14.infFloRat, freshAir14.m_flow_in)
    annotation (Line(points={{-114,-1236},{-114,-1232},{-88,-1232}}, color={0,0,
          127}));
  connect(zon14.TAir, infiltration_DesignFlowRate14.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate15.weaBus)
    annotation (Line(
      points={{-218,28},{-128,28},{-128,-1337.4},{-116.4,-1337.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate15.infFloRat, freshAir15.m_flow_in)
    annotation (Line(points={{-94,-1332},{-76,-1332},{-76,-1328},{-68,-1328}},
        color={0,0,127}));
  connect(zon15.TAir, infiltration_DesignFlowRate15.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate16.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1429.4},{-126.4,
          -1429.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate16.infFloRat, freshAir16.m_flow_in)
    annotation (Line(points={{-104,-1424},{-104,-1420},{-78,-1420}}, color={0,0,
          127}));
  connect(zon16.TAir, infiltration_DesignFlowRate16.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate17.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1539.4},{-130.4,-1539.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate17.infFloRat, freshAir17.m_flow_in)
    annotation (Line(points={{-108,-1534},{-108,-1530},{-82,-1530}}, color={0,0,
          127}));
  connect(zon17.TAir, infiltration_DesignFlowRate17.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate18.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1639.4},{-132.4,-1639.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate18.infFloRat, freshAir18.m_flow_in)
    annotation (Line(points={{-110,-1634},{-110,-1630},{-84,-1630}}, color={0,0,
          127}));
  connect(zon18.TAir, infiltration_DesignFlowRate18.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate19.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1712},{-148,-1712},{-148,
          -1731.4},{-136.4,-1731.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate19.infFloRat, freshAir19.m_flow_in)
    annotation (Line(points={{-114,-1726},{-114,-1722},{-88,-1722}}, color={0,0,
          127}));
  connect(zon19.TAir, infiltration_DesignFlowRate19.zonAirTem)
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
  connect(building.weaBus, infiltration_DesignFlowRate20.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20},{-148,20},{-148,-56},{-152,-56},{
          -152,-268},{-148,-268},{-148,-628},{-152,-628},{-152,-1428},{-140,
          -1428},{-140,-1620},{-144,-1620},{-144,-1712},{-148,-1712},{-148,
          -1817.4},{-138.4,-1817.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate20.infFloRat, freshAir20.m_flow_in)
    annotation (Line(points={{-116,-1812},{-116,-1808},{-90,-1808}}, color={0,0,
          127}));
  connect(zon20.TAir, infiltration_DesignFlowRate20.zonAirTem)
    annotation (Line(points={{85,-1780},{85,-1768},{-148,-1768},{-148,-1807.8},
          {-140,-1807.8}}, color={0,0,127}));
  connect(freshAir20.ports[1], zon20.ports[4]) annotation (Line(points={{-70,
          -1816},{32,-1816},{32,-1832},{64.8,-1832},{64.8,-1817.1}}, color={0,
          127,255}));
  connect(duc20.port_a, zon20.ports[5]) annotation (Line(points={{-70,-1786},{
          -64,-1786},{-64,-1836},{65.6,-1836},{65.6,-1817.1}}, color={0,127,255}));
  connect(zon21.qGai_flow,qIntGai21. y)
    annotation (Line(points={{34,-1888},{-3,-1888}},color={0,0,127}));
  connect(zon21.TAir,trc_custom_air_conditioner21. ZAT) annotation (Line(points={{77,
          -1880},{120,-1880},{120,-1891.6}},     color={0,0,127}));
  connect(trc_custom_air_conditioner21.port_b,zon21. ports[3]) annotation (Line(
        points={{142.8,-1905.6},{152,-1905.6},{152,-1936},{56,-1936},{56,-1917.1}},
                     color={0,127,255}));
  connect(zon21.ports[2],trc_custom_air_conditioner21. port_a) annotation (Line(
        points={{55.2,-1917.1},{55.2,-1932},{121.6,-1932},{121.6,-1905.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir21. weaBus) annotation (Line(
      points={{-218,28},{-156,28},{-156,-156},{-160,-156},{-160,-368},{-156,-368},
          {-156,-728},{-160,-728},{-160,-1528},{-148,-1528},{-148,-1720},{-152,-1720},
          {-152,-1812},{-156,-1812},{-156,-1868},{-108,-1868},{-108,-1915.8},{-98,
          -1915.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc21.port_b,pAtm21. ports[1])
    annotation (Line(points={{-98,-1886},{-126,-1886}}, color={0,127,255}));
  connect(building.weaBus,infiltration_DesignFlowRate21. weaBus)
    annotation (Line(
      points={{-218,28},{-156,28},{-156,-156},{-160,-156},{-160,-368},{-156,-368},
          {-156,-728},{-160,-728},{-160,-1528},{-148,-1528},{-148,-1720},{-152,-1720},
          {-152,-1812},{-156,-1812},{-156,-1917.4},{-146.4,-1917.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate21.infFloRat,freshAir21. m_flow_in)
    annotation (Line(points={{-124,-1912},{-124,-1908},{-98,-1908}}, color={0,0,
          127}));
  connect(zon21.TAir,infiltration_DesignFlowRate21. zonAirTem)
    annotation (Line(points={{77,-1880},{77,-1868},{-156,-1868},{-156,-1907.8},{
          -148,-1907.8}},  color={0,0,127}));
  connect(freshAir21.ports[1],zon21. ports[4]) annotation (Line(points={{-78,-1916},
          {24,-1916},{24,-1932},{56.8,-1932},{56.8,-1917.1}},        color={0,
          127,255}));
  connect(duc21.port_a,zon21. ports[5]) annotation (Line(points={{-78,-1886},{-72,
          -1886},{-72,-1936},{57.6,-1936},{57.6,-1917.1}},     color={0,127,255}));
  connect(zon22.qGai_flow,qIntGai22. y)
    annotation (Line(points={{28,-2008},{-9,-2008}},color={0,0,127}));
  connect(zon22.TAir,trc_custom_air_conditioner22. ZAT) annotation (Line(points={{71,
          -2000},{114,-2000},{114,-2011.6}},     color={0,0,127}));
  connect(trc_custom_air_conditioner22.port_b,zon22. ports[3]) annotation (Line(
        points={{136.8,-2025.6},{146,-2025.6},{146,-2056},{50,-2056},{50,-2037.1}},
                     color={0,127,255}));
  connect(zon22.ports[2],trc_custom_air_conditioner22. port_a) annotation (Line(
        points={{49.2,-2037.1},{49.2,-2052},{115.6,-2052},{115.6,-2025.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir22. weaBus) annotation (Line(
      points={{-218,28},{-166,28},{-166,-200},{-162,-200},{-162,-276},{-166,-276},
          {-166,-488},{-162,-488},{-162,-848},{-166,-848},{-166,-1648},{-154,-1648},
          {-154,-1840},{-158,-1840},{-158,-1932},{-162,-1932},{-162,-1988},{-114,
          -1988},{-114,-2035.8},{-104,-2035.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc22.port_b,pAtm22. ports[1])
    annotation (Line(points={{-104,-2006},{-132,-2006}},color={0,127,255}));
  connect(building.weaBus,infiltration_DesignFlowRate22. weaBus)
    annotation (Line(
      points={{-218,28},{-166,28},{-166,-200},{-162,-200},{-162,-276},{-166,-276},
          {-166,-488},{-162,-488},{-162,-848},{-166,-848},{-166,-1648},{-154,-1648},
          {-154,-1840},{-158,-1840},{-158,-1932},{-162,-1932},{-162,-2037.4},{-152.4,
          -2037.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate22.infFloRat,freshAir22. m_flow_in)
    annotation (Line(points={{-130,-2032},{-130,-2028},{-104,-2028}},color={0,0,
          127}));
  connect(zon22.TAir,infiltration_DesignFlowRate22. zonAirTem)
    annotation (Line(points={{71,-2000},{71,-1988},{-162,-1988},{-162,-2027.8},{
          -154,-2027.8}},  color={0,0,127}));
  connect(freshAir22.ports[1],zon22. ports[4]) annotation (Line(points={{-84,-2036},
          {18,-2036},{18,-2052},{50.8,-2052},{50.8,-2037.1}},        color={0,
          127,255}));
  connect(duc22.port_a,zon22. ports[5]) annotation (Line(points={{-84,-2006},{-78,
          -2006},{-78,-2056},{51.6,-2056},{51.6,-2037.1}},     color={0,127,255}));
  connect(zon23.qGai_flow,qIntGai23. y)
    annotation (Line(points={{24,-2124},{-13,-2124}},
                                                    color={0,0,127}));
  connect(zon23.TAir,trc_custom_air_conditioner23. ZAT) annotation (Line(points={{67,
          -2116},{110,-2116},{110,-2127.6}},     color={0,0,127}));
  connect(trc_custom_air_conditioner23.port_b,zon23. ports[3]) annotation (Line(
        points={{132.8,-2141.6},{142,-2141.6},{142,-2172},{46,-2172},{46,-2153.1}},
                     color={0,127,255}));
  connect(zon23.ports[2],trc_custom_air_conditioner23. port_a) annotation (Line(
        points={{45.2,-2153.1},{45.2,-2168},{111.6,-2168},{111.6,-2141.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir23. weaBus) annotation (Line(
      points={{-218,28},{-170,28},{-170,-316},{-166,-316},{-166,-392},{-170,-392},
          {-170,-604},{-166,-604},{-166,-964},{-170,-964},{-170,-1764},{-158,-1764},
          {-158,-1956},{-162,-1956},{-162,-2048},{-166,-2048},{-166,-2104},{-118,
          -2104},{-118,-2151.8},{-108,-2151.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc23.port_b,pAtm23. ports[1])
    annotation (Line(points={{-108,-2122},{-136,-2122}},color={0,127,255}));
  connect(building.weaBus,infiltration_DesignFlowRate23. weaBus)
    annotation (Line(
      points={{-218,28},{-170,28},{-170,-316},{-166,-316},{-166,-392},{-170,-392},
          {-170,-604},{-166,-604},{-166,-964},{-170,-964},{-170,-1764},{-158,-1764},
          {-158,-1956},{-162,-1956},{-162,-2048},{-166,-2048},{-166,-2153.4},{-156.4,
          -2153.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate23.infFloRat,freshAir23. m_flow_in)
    annotation (Line(points={{-134,-2148},{-134,-2144},{-108,-2144}},color={0,0,
          127}));
  connect(zon23.TAir,infiltration_DesignFlowRate23. zonAirTem)
    annotation (Line(points={{67,-2116},{67,-2104},{-166,-2104},{-166,-2143.8},{
          -158,-2143.8}},  color={0,0,127}));
  connect(freshAir23.ports[1],zon23. ports[4]) annotation (Line(points={{-88,-2152},
          {14,-2152},{14,-2168},{46.8,-2168},{46.8,-2153.1}},        color={0,
          127,255}));
  connect(duc23.port_a,zon23. ports[5]) annotation (Line(points={{-88,-2122},{-82,
          -2122},{-82,-2172},{47.6,-2172},{47.6,-2153.1}},     color={0,127,255}));
  connect(zon24.qGai_flow,qIntGai24. y)
    annotation (Line(points={{14,-2238},{-23,-2238}},
                                                    color={0,0,127}));
  connect(zon24.TAir,trc_custom_air_conditioner24. ZAT) annotation (Line(points={{57,
          -2230},{100,-2230},{100,-2241.6}},     color={0,0,127}));
  connect(trc_custom_air_conditioner24.port_b,zon24. ports[3]) annotation (Line(
        points={{122.8,-2255.6},{132,-2255.6},{132,-2286},{36,-2286},{36,-2267.1}},
                     color={0,127,255}));
  connect(zon24.ports[2],trc_custom_air_conditioner24. port_a) annotation (Line(
        points={{35.2,-2267.1},{35.2,-2282},{101.6,-2282},{101.6,-2255.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir24. weaBus) annotation (Line(
      points={{-218,28},{-180,28},{-180,-430},{-176,-430},{-176,-506},{-180,-506},
          {-180,-718},{-176,-718},{-176,-1078},{-180,-1078},{-180,-1878},{-168,-1878},
          {-168,-2070},{-172,-2070},{-172,-2162},{-176,-2162},{-176,-2218},{-128,
          -2218},{-128,-2265.8},{-118,-2265.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc24.port_b,pAtm24. ports[1])
    annotation (Line(points={{-118,-2236},{-146,-2236}},color={0,127,255}));
  connect(building.weaBus,infiltration_DesignFlowRate24. weaBus)
    annotation (Line(
      points={{-218,28},{-180,28},{-180,-430},{-176,-430},{-176,-506},{-180,-506},
          {-180,-718},{-176,-718},{-176,-1078},{-180,-1078},{-180,-1878},{-168,-1878},
          {-168,-2070},{-172,-2070},{-172,-2162},{-176,-2162},{-176,-2267.4},{-166.4,
          -2267.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate24.infFloRat,freshAir24. m_flow_in)
    annotation (Line(points={{-144,-2262},{-144,-2258},{-118,-2258}},color={0,0,
          127}));
  connect(zon24.TAir,infiltration_DesignFlowRate24. zonAirTem)
    annotation (Line(points={{57,-2230},{57,-2218},{-176,-2218},{-176,-2257.8},{
          -168,-2257.8}},  color={0,0,127}));
  connect(freshAir24.ports[1],zon24. ports[4]) annotation (Line(points={{-98,-2266},
          {4,-2266},{4,-2282},{36.8,-2282},{36.8,-2267.1}},          color={0,
          127,255}));
  connect(duc24.port_a,zon24. ports[5]) annotation (Line(points={{-98,-2236},{-92,
          -2236},{-92,-2286},{37.6,-2286},{37.6,-2267.1}},     color={0,127,255}));
  connect(zon25.qGai_flow,qIntGai25. y)
    annotation (Line(points={{20,-2348},{-17,-2348}},
                                                    color={0,0,127}));
  connect(zon25.TAir,trc_custom_air_conditioner25. ZAT) annotation (Line(points={{63,
          -2340},{106,-2340},{106,-2351.6}},     color={0,0,127}));
  connect(trc_custom_air_conditioner25.port_b,zon25. ports[3]) annotation (Line(
        points={{128.8,-2365.6},{138,-2365.6},{138,-2396},{42,-2396},{42,-2377.1}},
                     color={0,127,255}));
  connect(zon25.ports[2],trc_custom_air_conditioner25. port_a) annotation (Line(
        points={{41.2,-2377.1},{41.2,-2392},{107.6,-2392},{107.6,-2365.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir25. weaBus) annotation (Line(
      points={{-218,28},{-174,28},{-174,-540},{-170,-540},{-170,-616},{-174,-616},
          {-174,-828},{-170,-828},{-170,-1188},{-174,-1188},{-174,-1988},{-162,-1988},
          {-162,-2180},{-166,-2180},{-166,-2272},{-170,-2272},{-170,-2328},{-122,
          -2328},{-122,-2375.8},{-112,-2375.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc25.port_b,pAtm25. ports[1])
    annotation (Line(points={{-112,-2346},{-140,-2346}},color={0,127,255}));
  connect(building.weaBus,infiltration_DesignFlowRate25. weaBus)
    annotation (Line(
      points={{-218,28},{-174,28},{-174,-540},{-170,-540},{-170,-616},{-174,-616},
          {-174,-828},{-170,-828},{-170,-1188},{-174,-1188},{-174,-1988},{-162,-1988},
          {-162,-2180},{-166,-2180},{-166,-2272},{-170,-2272},{-170,-2377.4},{-160.4,
          -2377.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate25.infFloRat,freshAir25. m_flow_in)
    annotation (Line(points={{-138,-2372},{-138,-2368},{-112,-2368}},color={0,0,
          127}));
  connect(zon25.TAir,infiltration_DesignFlowRate25. zonAirTem)
    annotation (Line(points={{63,-2340},{63,-2328},{-170,-2328},{-170,-2367.8},{
          -162,-2367.8}},  color={0,0,127}));
  connect(freshAir25.ports[1],zon25. ports[4]) annotation (Line(points={{-92,-2376},
          {10,-2376},{10,-2392},{42.8,-2392},{42.8,-2377.1}},        color={0,
          127,255}));
  connect(duc25.port_a,zon25. ports[5]) annotation (Line(points={{-92,-2346},{-86,
          -2346},{-86,-2396},{43.6,-2396},{43.6,-2377.1}},     color={0,127,255}));
  connect(zon26.qGai_flow,qIntGai26. y)
    annotation (Line(points={{28,-2458},{-9,-2458}},color={0,0,127}));
  connect(zon26.TAir,trc_custom_air_conditioner26. ZAT) annotation (Line(points={{71,
          -2450},{114,-2450},{114,-2461.6}},     color={0,0,127}));
  connect(trc_custom_air_conditioner26.port_b,zon26. ports[3]) annotation (Line(
        points={{136.8,-2475.6},{146,-2475.6},{146,-2506},{50,-2506},{50,-2487.1}},
                     color={0,127,255}));
  connect(zon26.ports[2],trc_custom_air_conditioner26. port_a) annotation (Line(
        points={{49.2,-2487.1},{49.2,-2502},{115.6,-2502},{115.6,-2475.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir26. weaBus) annotation (Line(
      points={{-218,28},{-166,28},{-166,-650},{-162,-650},{-162,-726},{-166,-726},
          {-166,-938},{-162,-938},{-162,-1298},{-166,-1298},{-166,-2098},{-154,-2098},
          {-154,-2290},{-158,-2290},{-158,-2382},{-162,-2382},{-162,-2438},{-114,
          -2438},{-114,-2485.8},{-104,-2485.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc26.port_b,pAtm26. ports[1])
    annotation (Line(points={{-104,-2456},{-132,-2456}},color={0,127,255}));
  connect(building.weaBus,infiltration_DesignFlowRate26. weaBus)
    annotation (Line(
      points={{-218,28},{-166,28},{-166,-650},{-162,-650},{-162,-726},{-166,
          -726},{-166,-938},{-162,-938},{-162,-1298},{-166,-1298},{-166,-2098},
          {-154,-2098},{-154,-2290},{-158,-2290},{-158,-2382},{-162,-2382},{
          -162,-2485.4},{-152.4,-2485.4}},
      color={255,204,51},
      thickness=0.5));
  connect(zon26.TAir,infiltration_DesignFlowRate26. zonAirTem)
    annotation (Line(points={{71,-2450},{71,-2438},{-162,-2438},{-162,-2475.8},
          {-154,-2475.8}}, color={0,0,127}));
  connect(freshAir26.ports[1],zon26. ports[4]) annotation (Line(points={{-84,-2486},
          {18,-2486},{18,-2502},{50.8,-2502},{50.8,-2487.1}},        color={0,
          127,255}));
  connect(duc26.port_a,zon26. ports[5]) annotation (Line(points={{-84,-2456},{-78,
          -2456},{-78,-2506},{51.6,-2506},{51.6,-2487.1}},     color={0,127,255}));
  connect(zon27.qGai_flow,qIntGai27. y)
    annotation (Line(points={{18,-2566},{-19,-2566}},
                                                    color={0,0,127}));
  connect(zon27.TAir,trc_custom_air_conditioner27. ZAT) annotation (Line(points={{61,
          -2558},{104,-2558},{104,-2569.6}},     color={0,0,127}));
  connect(trc_custom_air_conditioner27.port_b,zon27. ports[3]) annotation (Line(
        points={{126.8,-2583.6},{136,-2583.6},{136,-2614},{40,-2614},{40,-2595.1}},
                     color={0,127,255}));
  connect(zon27.ports[2],trc_custom_air_conditioner27. port_a) annotation (Line(
        points={{39.2,-2595.1},{39.2,-2610},{105.6,-2610},{105.6,-2583.4}},
        color={0,127,255}));
  connect(building.weaBus,freshAir27. weaBus) annotation (Line(
      points={{-218,28},{-176,28},{-176,-758},{-172,-758},{-172,-834},{-176,-834},
          {-176,-1046},{-172,-1046},{-172,-1406},{-176,-1406},{-176,-2206},{-164,
          -2206},{-164,-2398},{-168,-2398},{-168,-2490},{-172,-2490},{-172,-2546},
          {-124,-2546},{-124,-2593.8},{-114,-2593.8}},
      color={255,204,51},
      thickness=0.5));
  connect(duc27.port_b,pAtm27. ports[1])
    annotation (Line(points={{-114,-2564},{-142,-2564}},color={0,127,255}));
  connect(building.weaBus,infiltration_DesignFlowRate27. weaBus)
    annotation (Line(
      points={{-218,28},{-176,28},{-176,-758},{-172,-758},{-172,-834},{-176,-834},
          {-176,-1046},{-172,-1046},{-172,-1406},{-176,-1406},{-176,-2206},{-164,
          -2206},{-164,-2398},{-168,-2398},{-168,-2490},{-172,-2490},{-172,-2595.4},
          {-162.4,-2595.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate27.infFloRat,freshAir27. m_flow_in)
    annotation (Line(points={{-140,-2590},{-140,-2586},{-114,-2586}},color={0,0,
          127}));
  connect(zon27.TAir,infiltration_DesignFlowRate27. zonAirTem)
    annotation (Line(points={{61,-2558},{61,-2546},{-172,-2546},{-172,-2585.8},{
          -164,-2585.8}},  color={0,0,127}));
  connect(freshAir27.ports[1],zon27. ports[4]) annotation (Line(points={{-94,-2594},
          {8,-2594},{8,-2610},{40.8,-2610},{40.8,-2595.1}},          color={0,
          127,255}));
  connect(duc27.port_a,zon27. ports[5]) annotation (Line(points={{-94,-2564},{-88,
          -2564},{-88,-2614},{41.6,-2614},{41.6,-2595.1}},     color={0,127,255}));
  connect(infiltration_DesignFlowRate26_door.zonAirTem,
    infiltration_DesignFlowRate26.zonAirTem) annotation (Line(points={{-156,
          -2507.8},{-156,-2476},{-160,-2476},{-160,-2475.8},{-154,-2475.8}},
        color={0,0,127}));
  connect(infiltration_DesignFlowRate26_door.weaBus,
    infiltration_DesignFlowRate26.weaBus) annotation (Line(
      points={{-154.4,-2517.4},{-162,-2517.4},{-162,-2486},{-158,-2486},{-158,
          -2485.4},{-152.4,-2485.4}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_DesignFlowRate26.infFloRat, add26.u1) annotation (Line(
        points={{-130,-2480},{-130,-2498},{-120,-2498},{-120,-2516}}, color={0,
          0,127}));
  connect(add26.y, freshAir26.m_flow_in) annotation (Line(points={{-97,-2522},{
          -94,-2522},{-94,-2478},{-104,-2478}}, color={0,0,127}));
  connect(infiltration_DesignFlowRate26_door.infFloRat, product26.u1)
    annotation (Line(points={{-132,-2512},{-167,-2512},{-167,-2548},{-202,-2548}},
        color={0,0,127}));
  connect(combiTimeTable26.y[1], product26.u2) annotation (Line(points={{-215,
          -2562},{-215,-2560},{-202,-2560}}, color={0,0,127}));
  connect(product26.y, add26.u2) annotation (Line(points={{-179,-2554},{-150,
          -2554},{-150,-2528},{-120,-2528}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end TRC_building_mid_rise_rochester;
