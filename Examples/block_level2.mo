within CCC_test.Examples;
model block_level2
  extends CCC_test.Examples.block_level2_partial;
  Modelica.Blocks.Sources.Constant const(final k=value2)
    annotation (Placement(transformation(extent={{-56,14},{-36,34}})));
equation
  connect(const.y, add.u1)
    annotation (Line(points={{-35,24},{0,24},{0,-8},{6,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end block_level2;
