within CCC_test.Example2;
model equal_spacing
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2[4](k=4:-1:1)
    "Integer inputs"
    annotation (Placement(transformation(extent={{-126,58},{-106,78}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1[4](k={3,2,5,7})
    "Integer inputs"
    annotation (Placement(transformation(extent={{6,-24},{26,-4}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end equal_spacing;
