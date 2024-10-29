within CCC_test.EP_MO_compare;
model ideal_load_1_zone

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

                  parameter Real TCooSet(unit="K")=273.15+26
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+20
    "Zone heating temperature setpoint";
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://CCC_test/Resources/Data/energyPlusFiles/1zone_model.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_International.Falls.Intl.AP.727470_TMY3.mos"),

    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_International.Falls.Intl.AP.727470_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-238,18},{-218,38}})));

  Modelica.Blocks.Sources.Constant qIntGai1[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName="BLOCK1:ZONE1",
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{42,20},{82,60}})));
  Baseclasses.Trc_custom_air_conditioner           trc_custom_air_conditioner1(
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
  Baseclasses.Infiltration_EffectiveLeakageArea infiltration_EffectiveLeakageArea
    annotation (Placement(transformation(extent={{-140,16},{-120,36}})));
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
  connect(building.weaBus, infiltration_EffectiveLeakageArea.weaBus)
    annotation (Line(
      points={{-218,28},{-152,28},{-152,20.6},{-140.4,20.6}},
      color={255,204,51},
      thickness=0.5));
  connect(infiltration_EffectiveLeakageArea.infFloRat, freshAir1.m_flow_in)
    annotation (Line(points={{-118,26},{-100,26},{-100,30},{-92,30}}, color={0,
          0,127}));
  connect(zon1.TAir, infiltration_EffectiveLeakageArea.zonAirTem) annotation (
      Line(points={{83,58},{88,58},{88,78},{-148,78},{-148,38},{-150,38},{-150,
          30.2},{-142,30.2}}, color={0,0,127}));
  connect(freshAir1.ports[1], zon1.ports[4]) annotation (Line(points={{-72,22},
          {36,22},{36,14},{62.8,14},{62.8,20.9}}, color={0,127,255}));
  connect(duc1.port_a, zon1.ports[5]) annotation (Line(points={{-72,52},{-28,52},
          {-28,22},{36,22},{36,14},{63.6,14},{63.6,20.9}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=900,
      __Dymola_Algorithm="Dassl"));
end ideal_load_1_zone;
