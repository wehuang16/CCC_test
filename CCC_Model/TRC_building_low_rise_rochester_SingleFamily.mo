within CCC_test.CCC_Model;
model TRC_building_low_rise_rochester_SingleFamily

          extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

       parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

                  parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/Data/energyPlusFiles/US+SF+CZ6A+gasfurnace+slab+IECC_2021_V960.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-150,20},{-130,40}})));

  Modelica.Blocks.Sources.Constant qIntGai1[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-106,42},{-86,62}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-46,22},{-6,62}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner1(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{94,28},{114,48}})));
equation
  connect(zon1.qGai_flow,qIntGai1. y)
    annotation (Line(points={{-48,52},{-85,52}},   color={0,0,127}));
  connect(zon1.TAir,trc_custom_air_conditioner1. ZAT) annotation (Line(points={{-5,60},
          {84,60},{84,44.4},{92,44.4}},                color={0,0,127}));
  connect(trc_custom_air_conditioner1.port_b,zon1. ports[4]) annotation (Line(
        points={{114.8,30.4},{118,30.4},{118,16},{-24.5,16},{-24.5,22.9}},
        color={0,127,255}));
  connect(zon1.ports[3],trc_custom_air_conditioner1. port_a) annotation (Line(
        points={{-25.5,22.9},{-25.5,20},{88,20},{88,30.6},{93.6,30.6}},
        color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TRC_building_low_rise_rochester_SingleFamily;
