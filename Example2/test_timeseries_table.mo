within CCC_test.Example2;
model test_timeseries_table
  Modelica.Blocks.Sources.CombiTimeTable zoneLoad(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/other/low_rise_thermal_power.txt"),
    columns=2:56,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-110,-16},{-90,4}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{130,-20},{150,2}})));
equation
  connect(zoneLoad.y[56], y) annotation (Line(points={{-89,-6},{124,-6},{124,-9},
          {140,-9}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end test_timeseries_table;
