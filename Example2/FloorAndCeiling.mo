within CCC_test.Example2;
model FloorAndCeiling
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=3)
    annotation (Placement(transformation(extent={{-122,-84},{-102,-64}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2[5](k=5:-1:1)
    "Integer inputs"
    annotation (Placement(transformation(extent={{-88,-40},{-68,-20}})));
  Buildings.Controls.OBC.CDL.Integers.LessEqual intLesEqu[5]
    annotation (Placement(transformation(extent={{-24,-46},{-4,-26}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep(nout=5)
    annotation (Placement(transformation(extent={{-78,-82},{-58,-62}})));
equation
  connect(conInt.y, intScaRep.u) annotation (Line(points={{-100,-74},{-88,-74},
          {-88,-72},{-80,-72}}, color={255,127,0}));
  connect(conInt2.y, intLesEqu.u1) annotation (Line(points={{-66,-30},{-44,-30},
          {-44,-36},{-26,-36},{-26,-36}}, color={255,127,0}));
  connect(intScaRep.y, intLesEqu.u2) annotation (Line(points={{-56,-72},{-34,
          -72},{-34,-44},{-26,-44}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FloorAndCeiling;
