within CCC_test.Examples;
model testTrueDelay
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=225)
    annotation (Placement(transformation(extent={{-8,-8},{12,12}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 10800,1; 21600,0; 32400,1; 43200,0; 54000,1; 64800,0; 75600,1;
        86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-124,-10},{-104,10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(combiTimeTable.y[1], realToBoolean.u)
    annotation (Line(points={{-103,0},{-62,0}}, color={0,0,127}));
  connect(realToBoolean.y, truDel.u) annotation (Line(points={{-39,0},{-18,0},{
          -18,2},{-10,2}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testTrueDelay;
