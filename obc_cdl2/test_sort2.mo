within CCC_test.obc_cdl2;
model test_sort2

  Buildings.Controls.OBC.CDL.Reals.Sort sort(ascending=true, nin=5)
    "Output the indices of the sorted vector in ascending order"
    annotation (Placement(transformation(extent={{18,8},{38,28}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=13)
    annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=7)
    annotation (Placement(transformation(extent={{-86,74},{-66,94}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp     ram(
    height=32,
    duration=1,
    offset=-16)
    annotation (Placement(transformation(extent={{-76,-12},{-56,8}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=2)
    annotation (Placement(transformation(extent={{-46,-86},{-26,-66}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=3)
    annotation (Placement(transformation(extent={{0,-96},{20,-76}})));
equation
  connect(con1.y, sort.u[1]) annotation (Line(points={{-64,84},{-24,84},{-24,17.2},
          {16,17.2}}, color={0,0,127}));
  connect(con2.y, sort.u[2]) annotation (Line(points={{-56,40},{-20,40},{-20,
          17.6},{16,17.6}},
                      color={0,0,127}));
  connect(ram.y, sort.u[3]) annotation (Line(points={{-54,-2},{-18,-2},{-18,18},
          {16,18}}, color={0,0,127}));
  connect(con4.y, sort.u[4]) annotation (Line(points={{-24,-76},{-6,-76},{-6,18.4},
          {16,18.4}}, color={0,0,127}));
  connect(con5.y, sort.u[5]) annotation (Line(points={{22,-86},{20,-86},{20,18.8},
          {16,18.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_sort2;
