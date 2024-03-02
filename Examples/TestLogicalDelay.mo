within CCC_test.Examples;
model TestLogicalDelay


  Modelica.Blocks.Logical.LogicalDelay logicalDelay(delayTime(displayUnit="h")=
         43200) annotation (Placement(transformation(extent={{-24,0},{-4,20}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period(displayUnit="h")=
      93600, startTime(displayUnit="s") = 0)
    annotation (Placement(transformation(extent={{-94,-4},{-74,16}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{36,0},{56,20}})));
  Modelica.Blocks.Logical.Pre pre1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={38,-16})));
  CCC.Controls.SingleLogicalDelay singleLogicalDelay(delayTime(displayUnit="h")=
         43200)
    annotation (Placement(transformation(extent={{-26,-60},{-6,-40}})));
equation
  connect(booleanPulse.y, logicalDelay.u) annotation (Line(points={{-73,6},{-36,
          6},{-36,10},{-26,10}}, color={255,0,255}));
  connect(logicalDelay.y1, logicalSwitch.u1)
    annotation (Line(points={{-3,16},{-3,18},{34,18}}, color={255,0,255}));
  connect(logicalDelay.y2, logicalSwitch.u3)
    annotation (Line(points={{-3,4},{-3,2},{34,2}}, color={255,0,255}));
  connect(logicalSwitch.y, pre1.u) annotation (Line(points={{57,10},{74,10},{74,
          -16},{50,-16}}, color={255,0,255}));
  connect(pre1.y, logicalSwitch.u2) annotation (Line(points={{27,-16},{20,-16},{
          20,10},{34,10}}, color={255,0,255}));
  connect(booleanPulse.y, singleLogicalDelay.u) annotation (Line(points={{-73,6},
          {-38,6},{-38,-50},{-28,-50}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestLogicalDelay;
