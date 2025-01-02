within CCC_test.Example2;
model testWeatherFile
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"))
    annotation (Placement(transformation(extent={{-32,10},{-12,30}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testWeatherFile;
