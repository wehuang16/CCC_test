within CCC_test.CCC_Model;
model testTableValues
  Modelica.Blocks.Sources.CombiTimeTable mainsWaterTemp(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/Hot_Water_Consumption/mains_water_temperature.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-18,18},{2,38}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{48,18},{68,38}})));
  Modelica.Blocks.Sources.CombiTimeTable hotWaterDraw(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/Hot_Water_Consumption/yearly_draw_profile_full_5min.txt"),
    columns=2:19,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-22,-28},{-2,-8}})));
  Modelica.Blocks.Sources.CombiTimeTable zoneLoad(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/other/low_rise_rochester_ideal_load_modelica_15min.txt"),
    columns=2:56,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-12,-78},{8,-58}})));
equation
  connect(mainsWaterTemp.y[1],from_degC. u)
    annotation (Line(points={{3,28},{46,28}},      color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testTableValues;
