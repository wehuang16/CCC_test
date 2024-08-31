within CCC_test.Examples;
model block_level2_partial
  parameter Real value2=12;
  Modelica.Blocks.Sources.Constant              const1(k=100)
    "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-42},{-40,-22}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{8,-24},{28,-4}})));
  Modelica.Blocks.Interfaces.RealOutput output2
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(const1.y, add.u2) annotation (Line(points={{-39,-32},{0,-32},{0,-20},{
          6,-20}}, color={0,0,127}));
  connect(add.y, output2) annotation (Line(points={{29,-14},{94,-14},{94,0},{110,
          0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end block_level2_partial;
