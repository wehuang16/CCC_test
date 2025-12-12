within CCC_test.Example3;
model testAnyBlock
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp ram(duration=86400, startTime=0)
    annotation (Placement(transformation(extent={{-42,-6},{-22,14}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=0,
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
