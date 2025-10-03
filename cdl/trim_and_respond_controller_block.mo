within CCC_test.cdl;
model trim_and_respond_controller_block
  Buildings.Controls.OBC.CDL.Interfaces.RealInput setpointCurrentValue
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput setpointCommand
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler sam(samplePeriod=300)
    annotation (Placement(transformation(extent={{-20,-8},{0,12}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{38,-4},{58,16}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=1)
    annotation (Placement(transformation(extent={{-34,52},{-14,72}})));
equation
  connect(setpointCurrentValue, sam.u) annotation (Line(points={{-120,0},{-30,0},
          {-30,2},{-22,2}}, color={0,0,127}));
  connect(sam.y, add2.u2)
    annotation (Line(points={{2,2},{28,2},{28,0},{36,0}}, color={0,0,127}));
  connect(con.y, add2.u1) annotation (Line(points={{-12,62},{28,62},{28,12},{36,
          12}}, color={0,0,127}));
  connect(add2.y, setpointCommand)
    annotation (Line(points={{60,6},{94,6},{94,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end trim_and_respond_controller_block;
