within CCC_test.Examples;
model block_level1
  parameter Real value1=5;
  Modelica.Blocks.Sources.Constant              const(k=value1)
    "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-78,-4},{-58,16}})));
  Modelica.Blocks.Sources.Constant              const1(k=3)
    "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-60,-42},{-40,-22}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{8,-24},{28,-4}})));
  Modelica.Blocks.Interfaces.RealOutput output1
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  block_level2 block_level2_1
    annotation (Placement(transformation(extent={{-12,50},{8,70}})));
equation
  connect(const.y, add.u1)
    annotation (Line(points={{-57,6},{0,6},{0,-8},{6,-8}}, color={0,0,127}));
  connect(const1.y, add.u2) annotation (Line(points={{-39,-32},{0,-32},{0,-20},
          {6,-20}}, color={0,0,127}));
  connect(add.y, output1) annotation (Line(points={{29,-14},{94,-14},{94,0},{
          110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end block_level1;
