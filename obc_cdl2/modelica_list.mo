within CCC_test.obc_cdl2;
model modelica_list
  parameter Integer nVal(min=1)=5
    "Number of values to compare";
protected
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant numSeq[nVal](final k={i
        for i in nVal:-1:1})
    "A numerical sequence from one up to the number of values"
    annotation (Placement(transformation(extent={{-26,-6},{-6,14}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end modelica_list;
