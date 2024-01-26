within CCC_test.Examples;
model TestLogicalDelay
  Modelica.Blocks.Logical.LogicalDelay logicalDelay(delayTime(displayUnit="h")
       = 43200) annotation (Placement(transformation(extent={{-22,4},{-2,24}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period(displayUnit="h") =
      93600, startTime(displayUnit="s") = 0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Logical.Xor xor
    annotation (Placement(transformation(extent={{26,4},{46,24}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{58,2},{78,22}})));
  Buildings.Controls.Discrete.BooleanDelay del(samplePeriod(displayUnit="h") =
      7200) annotation (Placement(transformation(extent={{-22,-60},{-2,-40}})));
equation
  connect(booleanPulse.y, logicalDelay.u) annotation (Line(points={{-59,0},{-32,
          0},{-32,14},{-24,14}}, color={255,0,255}));
  connect(logicalDelay.y1, xor.u1) annotation (Line(points={{-1,20},{14,20},{14,
          14},{24,14}}, color={255,0,255}));
  connect(logicalDelay.y2, xor.u2)
    annotation (Line(points={{-1,8},{-1,6},{24,6}}, color={255,0,255}));
  connect(xor.y, not1.u)
    annotation (Line(points={{47,14},{47,12},{56,12}}, color={255,0,255}));
  connect(booleanPulse.y, del.u) annotation (Line(points={{-59,0},{-34,0},{-34,
          -50},{-24,-50}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestLogicalDelay;
