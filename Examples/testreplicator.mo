within CCC_test.Examples;
model testreplicator
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep1(final nout=
       2)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-34,0},{-14,20}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-92,-12},{-72,8}})));
equation
  connect(booleanConstant.y, booRep1.u) annotation (Line(points={{-71,-2},{-44,
          -2},{-44,10},{-36,10}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testreplicator;
