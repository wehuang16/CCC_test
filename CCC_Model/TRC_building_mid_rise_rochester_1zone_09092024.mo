within CCC_test.CCC_Model;
model TRC_building_mid_rise_rochester_1zone_09092024

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
        "modelica://CCC/Resources/Data/energyPlusFiles/ASHRAE901_ApartmentMidRise_STD2022_Rochester.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-140,-12},{-120,8}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName="M SW Apartment",
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TRC_building_mid_rise_rochester_1zone_09092024;
