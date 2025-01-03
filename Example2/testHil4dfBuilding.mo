within CCC_test.Example2;
model testHil4dfBuilding

       package MediumW = Buildings.Media.Water "Medium model for 9% prop glycol mix with water";
  package MediumA = Buildings.Media.Air "Medium model for air";
  hil_flexlab_model.Test1.ThermalZones.Floor
                     flo(
    nor(T_start=294.96),
    cor(T_start=294.96),
    sou(T_start=294.96),
    idfName=Modelica.Utilities.Files.loadResource("modelica://hil_flexlab_model/Resources/energyPlusFiles/X1-2021-V8_v2_NoInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource("modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.mos"),
    ele(T_start=294.96),
    clo(T_start=294.96),
    ple(T_start=294.96),
    redeclare final package Medium = MediumA)
    "Model of a floor of the building that is served by this VAV system"
    annotation (Placement(transformation(extent={{-100,-56},{94,54}})));

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{-192,-24},{-172,-4}})));
equation
  connect(weaDat.weaBus, flo.weaBus) annotation (Line(
      points={{-172,-14},{-128,-14},{-128,70.9231},{22.3043,70.9231}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=0,
      StopTime=31536000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testHil4dfBuilding;
