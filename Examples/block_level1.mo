within CCC_test.Examples;
model block_level1

  extends CCC_test.Examples.block_level1_partial(redeclare
      CCC_test.Examples.block_level2 block_level2_1(final value2=value2));
  Modelica.Blocks.Sources.Constant              const2(k=5 + 4)
    "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-34,-94},{-14,-74}})));
  Modelica.Blocks.Sources.Constant              const3(k=-1)
    "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-16,-132},{4,-112}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{52,-114},{72,-94}})));
equation
  connect(const2.y, add1.u1) annotation (Line(points={{-13,-84},{44,-84},{44,-98},
          {50,-98}}, color={0,0,127}));
  connect(const3.y, add1.u2) annotation (Line(points={{5,-122},{44,-122},{44,-110},
          {50,-110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end block_level1;
