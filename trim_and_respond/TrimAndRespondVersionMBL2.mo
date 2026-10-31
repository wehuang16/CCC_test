within CCC_test.trim_and_respond;
model TrimAndRespondVersionMBL2
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{-82,0},{-62,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable timTab(
    table=[0,2; 12,2; 18,2; 24,0],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    timeScale=3600)
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(samplePeriod=3600, y_start=
        0)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,10})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput numZon annotation (Placement(
        transformation(extent={{100,-10},{140,30}}), iconTransformation(extent=
            {{116,14},{156,54}})));
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=16,uMin=0)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
equation
  connect(uniDel.y, numZon)
    annotation (Line(points={{42,10},{120,10}}, color={0,0,127}));
  connect(uniDel.y, add2.u1) annotation (Line(points={{42,10},{50,10},{50,62},{
          -120,62},{-120,16},{-84,16}}, color={0,0,127}));
  connect(timTab.y[1], add2.u2) annotation (Line(points={{-118,-10},{-92,-10},{
          -92,4},{-84,4}}, color={0,0,127}));
  connect(add2.y, lim.u)
    annotation (Line(points={{-60,10},{-42,10}}, color={0,0,127}));
  connect(lim.y, uniDel.u)
    annotation (Line(points={{-18,10},{18,10}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TrimAndRespondVersionMBL2;
