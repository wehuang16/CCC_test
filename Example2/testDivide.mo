within CCC_test.Example2;
model testDivide
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=0.5)
    annotation (Placement(transformation(extent={{26,-4},{46,16}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div1
    annotation (Placement(transformation(extent={{114,24},{134,44}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=-1)
    annotation (Placement(transformation(extent={{28,-44},{48,-24}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=5)
    annotation (Placement(transformation(extent={{46,42},{66,62}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin(freqHz=1/21600)
    annotation (Placement(transformation(extent={{-156,14},{-136,34}})));
equation
  connect(greThr.y, swi.u2)
    annotation (Line(points={{48,6},{64,6},{64,0},{72,0}}, color={255,0,255}));
  connect(swi.y, div1.u2) annotation (Line(points={{96,0},{104,0},{104,28},{112,
          28}}, color={0,0,127}));
  connect(con1.y, div1.u1) annotation (Line(points={{68,52},{104,52},{104,40},{
          112,40}}, color={0,0,127}));
  connect(con3.y, swi.u3) annotation (Line(points={{50,-34},{64,-34},{64,-8},{
          72,-8}}, color={0,0,127}));
  connect(sin.y, greThr.u) annotation (Line(points={{-134,24},{14,24},{14,6},{
          24,6}}, color={0,0,127}));
  connect(sin.y, swi.u1) annotation (Line(points={{-134,24},{64,24},{64,8},{72,
          8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testDivide;
