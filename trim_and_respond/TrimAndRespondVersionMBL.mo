within CCC_test.trim_and_respond;
model TrimAndRespondVersionMBL
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{12,-26},{32,-6}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin      sin(
    amplitude=1,
    freqHz=1/43200,
    offset=1)
    annotation (Placement(transformation(extent={{-56,-82},{-36,-62}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(samplePeriod=3600,
      y_start=5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-16,82})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpointCommand
    annotation (Placement(transformation(extent={{120,-58},{160,-18}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpointActual
    annotation (Placement(transformation(extent={{116,14},{156,54}})));
equation
  connect(sin.y,add2. u1) annotation (Line(points={{-34,-72},{2,-72},{2,-10},{
          10,-10}},
                color={0,0,127}));
  connect(add2.y, setpointCommand)
    annotation (Line(points={{34,-16},{68,-16},{68,-38},{140,-38}},
                                                            color={0,0,127}));
  connect(add2.y, uniDel.u) annotation (Line(points={{34,-16},{64,-16},{64,82},
          {-4,82}}, color={0,0,127}));
  connect(uniDel.y, setpointActual) annotation (Line(points={{-28,82},{-40,82},
          {-40,108},{122,108},{122,34},{136,34}}, color={0,0,127}));
  connect(uniDel.y, add2.u2) annotation (Line(points={{-28,82},{-80,82},{-80,78},
          {-120,78},{-120,-22},{10,-22}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TrimAndRespondVersionMBL;
