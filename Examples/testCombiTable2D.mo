within CCC_test.Examples;
model testCombiTable2D
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds(table=[0.0,5,10; 2,1,4; 4,
        25,100])
    annotation (Placement(transformation(extent={{-32,18},{-12,38}})));
  Modelica.Blocks.Sources.Step step(
    height=4,
    offset=2,
    startTime=4320)
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  Modelica.Blocks.Sources.Step step1(
    height=5,
    offset=5,
    startTime=4320)
    annotation (Placement(transformation(extent={{-78,-22},{-58,-2}})));
equation
  connect(step.y, combiTable2Ds.u1) annotation (Line(points={{-61,40},{-44,40},
          {-44,34},{-34,34}}, color={0,0,127}));
  connect(step1.y, combiTable2Ds.u2) annotation (Line(points={{-57,-12},{-42,
          -12},{-42,22},{-34,22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testCombiTable2D;
