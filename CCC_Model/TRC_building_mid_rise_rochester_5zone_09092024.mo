within CCC_test.CCC_Model;
model TRC_building_mid_rise_rochester_5zone_09092024

        extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.MassFlowRate mOut_flow_nominal=0.04
    "Outdoor air mass flow rate, assuming constant infiltration air flow rate";
  parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

              parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/MultifamilyMidrise_v1.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-140,-12},{-120,8}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName="L2 SW Apartment",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-40,48},{0,88}})));
  Buildings.Fluid.Sources.Boundary_pT
                            pAtm(redeclare package Medium = MediumAir,
                                                                    nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{-100,18},{-80,38}})));
  Buildings.Fluid.FixedResistances.PressureDrop
                                      duc(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-50,18},{-70,38}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData
                                           freshAir(
    redeclare package Medium = MediumAir,
    m_flow=mOut_flow_nominal,
    nPorts=1)
    "Outside air supply"
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Modelica.Blocks.Sources.Constant qIntGai1[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-100,68},{-80,88}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner1(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{100,54},{120,74}})));
  Modelica.Blocks.Sources.Constant qIntGai2[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-86,-52},{-66,-32}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon2(
    redeclare package Medium = MediumAir,
    zoneName="T SW Apartment",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-26,-72},{14,-32}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner2(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{114,-66},{134,-46}})));
  Modelica.Blocks.Sources.Constant qIntGai3[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-98,-120},{-78,-100}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon3(
    redeclare package Medium = MediumAir,
    zoneName="G SW Apartment",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-38,-140},{2,-100}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner3(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{102,-134},{122,-114}})));
  Modelica.Blocks.Sources.Constant qIntGai4[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-96,-186},{-76,-166}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon4(
    redeclare package Medium = MediumAir,
    zoneName="L2 NW Apartment",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-36,-206},{4,-166}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner4(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{104,-200},{124,-180}})));
  Modelica.Blocks.Sources.Constant qIntGai5[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-102,-276},{-82,-256}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon5(
    redeclare package Medium = MediumAir,
    zoneName="L2 S1 Apartment",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-42,-296},{-2,-256}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner5(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{98,-290},{118,-270}})));
equation
  connect(building.weaBus,freshAir.weaBus)
    annotation (Line(points={{-120,-2},{-110,-2},{-110,-1.8},{-100,-1.8}},
                                                                      color={255,204,51},thickness=0.5));
  connect(duc.port_a, zon1.ports[1]) annotation (Line(points={{-50,28},{-21.5,
          28},{-21.5,48.9}},
                         color={0,127,255}));
  connect(freshAir.ports[1], zon1.ports[2]) annotation (Line(points={{-80,-2},{
          -20.5,-2},{-20.5,48.9}},
                             color={0,127,255}));
  connect(duc.port_b,pAtm.ports[1])
    annotation (Line(points={{-70,28},{-80,28}},color={0,127,255}));
  connect(zon1.qGai_flow, qIntGai1.y)
    annotation (Line(points={{-42,78},{-79,78}}, color={0,0,127}));
  connect(zon1.ports[3], trc_custom_air_conditioner1.port_a) annotation (Line(
        points={{-19.5,48.9},{-19.5,46},{40,46},{40,56.6},{99.6,56.6}}, color={
          0,127,255}));
  connect(trc_custom_air_conditioner1.port_b, zon1.ports[4]) annotation (Line(
        points={{120.8,56.4},{124,56.4},{124,48.9},{-18.5,48.9}}, color={0,127,
          255}));
  connect(zon1.TAir, trc_custom_air_conditioner1.ZAT) annotation (Line(points={
          {1,86},{90,86},{90,70.4},{98,70.4}}, color={0,0,127}));
  connect(zon2.qGai_flow, qIntGai2.y)
    annotation (Line(points={{-28,-42},{-65,-42}}, color={0,0,127}));
  connect(zon2.TAir, trc_custom_air_conditioner2.ZAT) annotation (Line(points={
          {15,-34},{104,-34},{104,-49.6},{112,-49.6}}, color={0,0,127}));
  connect(zon2.ports[3], trc_custom_air_conditioner2.port_a) annotation (Line(
        points={{-5.5,-71.1},{-5.5,-74},{108,-74},{108,-63.4},{113.6,-63.4}},
        color={0,127,255}));
  connect(trc_custom_air_conditioner2.port_b, zon2.ports[4]) annotation (Line(
        points={{134.8,-63.6},{138,-63.6},{138,-78},{-4.5,-78},{-4.5,-71.1}},
        color={0,127,255}));
  connect(zon3.qGai_flow, qIntGai3.y)
    annotation (Line(points={{-40,-110},{-77,-110}}, color={0,0,127}));
  connect(zon3.TAir, trc_custom_air_conditioner3.ZAT) annotation (Line(points={
          {3,-102},{92,-102},{92,-117.6},{100,-117.6}}, color={0,0,127}));
  connect(zon3.ports[3], trc_custom_air_conditioner3.port_a) annotation (Line(
        points={{-17.5,-139.1},{-17.5,-142},{96,-142},{96,-131.4},{101.6,-131.4}},
        color={0,127,255}));
  connect(trc_custom_air_conditioner3.port_b, zon3.ports[4]) annotation (Line(
        points={{122.8,-131.6},{126,-131.6},{126,-146},{-16.5,-146},{-16.5,
          -139.1}}, color={0,127,255}));
  connect(zon4.qGai_flow, qIntGai4.y)
    annotation (Line(points={{-38,-176},{-75,-176}}, color={0,0,127}));
  connect(zon4.TAir, trc_custom_air_conditioner4.ZAT) annotation (Line(points={
          {5,-168},{94,-168},{94,-183.6},{102,-183.6}}, color={0,0,127}));
  connect(zon4.ports[3], trc_custom_air_conditioner4.port_a) annotation (Line(
        points={{-15.5,-205.1},{-15.5,-208},{98,-208},{98,-197.4},{103.6,-197.4}},
        color={0,127,255}));
  connect(trc_custom_air_conditioner4.port_b, zon4.ports[4]) annotation (Line(
        points={{124.8,-197.6},{128,-197.6},{128,-212},{-14.5,-212},{-14.5,
          -205.1}}, color={0,127,255}));
  connect(zon5.qGai_flow, qIntGai5.y)
    annotation (Line(points={{-44,-266},{-81,-266}}, color={0,0,127}));
  connect(zon5.TAir, trc_custom_air_conditioner5.ZAT) annotation (Line(points={
          {-1,-258},{86,-258},{86,-273.6},{96,-273.6}}, color={0,0,127}));
  connect(zon5.ports[3], trc_custom_air_conditioner5.port_a) annotation (Line(
        points={{-21.5,-295.1},{-21.5,-302},{92,-302},{92,-287.4},{97.6,-287.4}},
        color={0,127,255}));
  connect(trc_custom_air_conditioner5.port_b, zon5.ports[4]) annotation (Line(
        points={{118.8,-287.6},{124,-287.6},{124,-302},{-20.5,-302},{-20.5,
          -295.1}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TRC_building_mid_rise_rochester_5zone_09092024;
