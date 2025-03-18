within CCC_test.Example2;
model calendarTrueFalse
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable seasonSwitchover(
    table=[0,1; 90,0; 258,1; 365,1],
    timeScale=86400,
    period=31536000)
    annotation (Placement(transformation(extent={{-20,-6},{0,14}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=63072000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end calendarTrueFalse;
