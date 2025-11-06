within CCC_test.Example2;
model linearSetpointControlContainer
  cdl.linearSetpointControl linearSetpointControl1
    annotation (Placement(transformation(extent={{62,-28},{82,-8}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=24)
    annotation (Placement(transformation(extent={{-102,2},{-82,22}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=28)
    annotation (Placement(transformation(extent={{-44,26},{-24,46}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=4*3600)
    annotation (Placement(transformation(extent={{-92,-40},{-72,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=2*3600)
    annotation (Placement(transformation(extent={{-58,-82},{-38,-62}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.TimeTable
                                         loadShedMode(table=[0,0; 3600*14,1;
        3600*18,0; 3600*24,0], period=86400)
    annotation (Placement(transformation(extent={{-48,-24},{-28,-4}})));
equation
  connect(con1.y, linearSetpointControl1.TZonCooSetMax)
    annotation (Line(points={{-22,36},{60,36},{60,-9}}, color={0,0,127}));
  connect(con.y, linearSetpointControl1.TZonCooSetNominal) annotation (Line(
        points={{-80,12},{50,12},{50,-14.6},{60.4,-14.6}}, color={0,0,127}));
  connect(con2.y, linearSetpointControl1.LoadShedTime) annotation (Line(points=
          {{-70,-30},{50,-30},{50,-22.4},{60.2,-22.4}}, color={0,0,127}));
  connect(con3.y, linearSetpointControl1.ReboundTime) annotation (Line(points={
          {-36,-72},{52,-72},{52,-26.6},{60,-26.6}}, color={0,0,127}));
  connect(loadShedMode.y[1], linearSetpointControl1.LoadShed) annotation (Line(
        points={{-26,-14},{46,-14},{46,-18},{60,-18}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=259200,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end linearSetpointControlContainer;
