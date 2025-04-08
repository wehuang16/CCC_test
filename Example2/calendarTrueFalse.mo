within CCC_test.Example2;
model calendarTrueFalse
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable seasonSwitchover(
    table=[0,1; 90,0; 258,1; 365,1],
    timeScale=86400,
    period=31536000)
    annotation (Placement(transformation(extent={{-20,-6},{0,14}})));
  Modelica.Blocks.Sources.CombiTimeTable dataTest(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://campus_chiller_plant/Resources/TES_trend_updated.txt"),
    columns=2:20,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-222,22},{-202,42}})));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=7138800,
      StopTime=7894980,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end calendarTrueFalse;
