within CCC_test.trim_and_respond;
model TrimAndRespondVersionSelf
  Buildings.Controls.OBC.CDL.Discrete.Sampler sam(samplePeriod=300)
    annotation (Placement(transformation(extent={{-46,-30},{-26,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{12,-26},{32,-6}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.01)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(samplePeriod=10, y_start
      =5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-16,82})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpointCommand
    annotation (Placement(transformation(extent={{120,-58},{160,-18}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpointActual
    annotation (Placement(transformation(extent={{116,14},{156,54}})));
equation
  connect(sam.y,add2. u2)
    annotation (Line(points={{-24,-20},{2,-20},{2,-22},{10,-22}},
                                                          color={0,0,127}));
  connect(con.y,add2. u1) annotation (Line(points={{-38,40},{2,40},{2,-10},{10,
          -10}},color={0,0,127}));
  connect(add2.y, setpointCommand)
    annotation (Line(points={{34,-16},{68,-16},{68,-38},{140,-38}},
                                                            color={0,0,127}));
  connect(add2.y, uniDel.u) annotation (Line(points={{34,-16},{64,-16},{64,82},
          {-4,82}}, color={0,0,127}));
  connect(uniDel.y, sam.u) annotation (Line(points={{-28,82},{-66,82},{-66,84},
          {-116,84},{-116,-20},{-48,-20}}, color={0,0,127}));
  connect(uniDel.y, setpointActual) annotation (Line(points={{-28,82},{-40,82},
          {-40,108},{122,108},{122,34},{136,34}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TrimAndRespondVersionSelf;
