within CCC_test.obc_cdl2;
model test_sort
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[5](k={7,13,-999,2,3})
    annotation (Placement(transformation(extent={{-86,8},{-66,28}})));

  Buildings.Controls.OBC.CDL.Reals.Sort sort(ascending=true, nin=5)
    "Output the indices of the sorted vector in ascending order"
    annotation (Placement(transformation(extent={{18,8},{38,28}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1[5](k={false,false,
        true,false,false})
    annotation (Placement(transformation(extent={{-158,-64},{-138,-44}})));
  Buildings.Controls.OBC.CDL.Reals.Sort sort1(ascending=true, nin=5)
    "Output the indices of the sorted vector in ascending order"
    annotation (Placement(transformation(extent={{30,-62},{50,-42}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=999)
    annotation (Placement(transformation(extent={{-178,-8},{-158,12}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi[5]
    annotation (Placement(transformation(extent={{-44,-66},{-24,-46}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=5)
    annotation (Placement(transformation(extent={{-108,-32},{-88,-12}})));
equation
  connect(con.y, sort.u) annotation (Line(points={{-64,18},{-44,18},{-44,18},{
          16,18}},   color={0,0,127}));
  connect(con1.y, swi.u2) annotation (Line(points={{-136,-54},{-56,-54},{-56,-56},
          {-46,-56}}, color={255,0,255}));
  connect(con.y, swi.u3) annotation (Line(points={{-64,18},{-60,18},{-60,-66},{-46,
          -66},{-46,-64}}, color={0,0,127}));
  connect(swi.y, sort1.u) annotation (Line(points={{-22,-56},{4,-56},{4,-52},{
          28,-52}},    color={0,0,127}));
  connect(con2.y, reaScaRep.u) annotation (Line(points={{-156,2},{-134,2},{-134,
          -22},{-110,-22}}, color={0,0,127}));
  connect(reaScaRep.y, swi.u1) annotation (Line(points={{-86,-22},{-68,-22},{-68,
          -48},{-46,-48}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test_sort;
