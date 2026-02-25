within CCC_test.Example3;
model testAnyBlock
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp ram(
    height=Modelica.Constants.pi,                   duration=86400, startTime=0)
    annotation (Placement(transformation(extent={{0,58},{20,78}})));
  Buildings.Controls.OBC.DemandFlexibility.Subsequences.SelectLargestValues
    selectLargestValues
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[5](k={2,2,2,2,2})
    annotation (Placement(transformation(extent={{-76,-8},{-56,12}})));
equation
  connect(con.y, selectLargestValues.u) annotation (Line(points={{-54,2},{-34,2},
          {-34,0},{-14,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=0,
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
