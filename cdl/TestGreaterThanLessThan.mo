within CCC_test.cdl;
model TestGreaterThanLessThan
  Buildings.Controls.OBC.CDL.Reals.Greater gre(h=1)
                                               "Greater than"
    annotation (Placement(transformation(extent={{-4,4},{16,24}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=5)
    "Allowed deviation constant"
    annotation (Placement(transformation(extent={{-80,-8},{-60,12}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin      sin(
    amplitude=3,
    freqHz=1/43200,
    offset=6)
    "Allowed deviation constant"
    annotation (Placement(transformation(extent={{-80,38},{-60,58}})));
  Buildings.Controls.OBC.CDL.Reals.Less    les(h=1)
                                               "Greater than"
    annotation (Placement(transformation(extent={{6,-56},{26,-36}})));
equation
  connect(con1.y, gre.u2) annotation (Line(points={{-58,2},{-32,2},{-32,6},{-6,
          6}}, color={0,0,127}));
  connect(sin.y, gre.u1) annotation (Line(points={{-58,48},{-32,48},{-32,14},{
          -6,14}}, color={0,0,127}));
  connect(sin.y, les.u1) annotation (Line(points={{-58,48},{-26,48},{-26,-46},{
          4,-46}}, color={0,0,127}));
  connect(con1.y, les.u2) annotation (Line(points={{-58,2},{-28,2},{-28,-54},{4,
          -54}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestGreaterThanLessThan;
