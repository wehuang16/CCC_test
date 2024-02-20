within CCC_test.Examples;
model testFloor
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
//Buildings.ThermalZones.EnergyPlus_9_6_0.UsersGuide.Installation
  hil_flexlab_model.ThermalZones.Floor floor1(
    redeclare package Medium = MediumAir,
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://hil_flexlab_model/Resources/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{-56,-14},{-10,12}})));

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.mos"),
      computeWetBulbTemperature=false) "Weather data reader"
    annotation (Placement(transformation(extent={{-92,32},{-72,52}})));
equation
  connect(weaDat.weaBus, floor1.weaBus) annotation (Line(
      points={{-72,42},{-54,42},{-54,44},{-27,44},{-27,16}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testFloor;
