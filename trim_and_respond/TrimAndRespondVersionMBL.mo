within CCC_test.trim_and_respond;
model TrimAndRespondVersionMBL
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin      sin(
    amplitude=1,
    freqHz=1/43200,
    offset=1)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(samplePeriod=3600,
      y_start=5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,10})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpointCommand
    annotation (Placement(transformation(extent={{100,-50},{140,-10}}),
        iconTransformation(extent={{120,-58},{160,-18}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpointActual
    annotation (Placement(transformation(extent={{100,-10},{140,30}}),
        iconTransformation(extent={{116,14},{156,54}})));
equation
  connect(add2.y, setpointCommand)
    annotation (Line(points={{-18,10},{0,10},{0,-30},{120,-30}},
                                                            color={0,0,127}));
  connect(add2.y, uniDel.u) annotation (Line(points={{-18,10},{18,10}},
                    color={0,0,127}));
  connect(uniDel.y, setpointActual) annotation (Line(points={{42,10},{120,10}},
                                                  color={0,0,127}));
  connect(uniDel.y, add2.u1) annotation (Line(points={{42,10},{60,10},{60,80},{
          -60,80},{-60,16},{-42,16}}, color={0,0,127}));
  connect(sin.y, add2.u2) annotation (Line(points={{-78,-10},{-60,-10},{-60,4},
          {-42,4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TrimAndRespondVersionMBL;
