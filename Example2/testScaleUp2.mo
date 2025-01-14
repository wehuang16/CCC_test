within CCC_test.Example2;
model testScaleUp2
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Blocks.Sources.Constant const[4](k=4:-1:1)
    annotation (Placement(transformation(extent={{-32,54},{-12,74}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/Data/energyPlusFiles/MidriseApartmentModern_6A_USA_MN_MINNEAPOLIS_V960_v2.idf"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"),
    epwName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-110,-14},{-90,6}})));

  zoneContainer zoneContainer1[2](zoneName={"G SW Apartment","G NW Apartment"})
    annotation (Placement(transformation(extent={{22,-24},{42,-4}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testScaleUp2;
