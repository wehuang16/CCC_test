within CCC_test.Examples;
model testAnyBlock
  HpModeSelectorTest hpModeSelectorTest
    annotation (Placement(transformation(extent={{-4,20},{16,40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
equation
  connect(booleanConstant1.y, hpModeSelectorTest.u) annotation (Line(points={{
          -39,20},{-16,20},{-16,24.6},{-6,24.6}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testAnyBlock;
