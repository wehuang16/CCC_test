within CCC_test.Examples;
model testLatch
  Buildings.Controls.OBC.CDL.Logical.Latch lat
    "Output true when there is setpoint change and maintain the true output until the suppresiong time has passed"
    annotation (Placement(transformation(extent={{60,-16},{80,4}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 10800,1; 21600,0; 32400,1; 43200,0; 54000,1; 64800,0; 75600,1;
        86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-86,-6},{-66,14}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-24,-12},{-4,8}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    table=[0,0; 21600,0; 24000,1; 43200,1; 50000,0; 64800,0; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-74,-36},{-54,-16}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1
    annotation (Placement(transformation(extent={{-24,-52},{-4,-32}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false)
    annotation (Placement(transformation(extent={{-6,-80},{14,-60}})));
equation
  connect(combiTimeTable.y[1], realToBoolean.u) annotation (Line(points={{-65,4},
          {-36,4},{-36,-2},{-26,-2}}, color={0,0,127}));
  connect(realToBoolean.y, lat.u) annotation (Line(points={{-3,-2},{48,-2},{48,
          -6},{58,-6}}, color={255,0,255}));
  connect(combiTimeTable1.y[1], realToBoolean1.u) annotation (Line(points={{-53,
          -26},{-36,-26},{-36,-42},{-26,-42}}, color={0,0,127}));
  connect(realToBoolean1.y, lat.clr)
    annotation (Line(points={{-3,-42},{58,-42},{58,-12}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testLatch;
