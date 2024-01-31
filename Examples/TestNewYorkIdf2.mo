within CCC_test.Examples;
model TestNewYorkIdf2
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{-56,22},{-36,42}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=4) annotation (Placement(transformation(extent={{32,6},{72,46}})));
  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-26,46},{-6,66}})));
equation
  connect(qIntGai.y, nor.qGai_flow) annotation (Line(points={{-5,56},{20,56},{20,
          36},{30,36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestNewYorkIdf2;
