within CCC_test.Examples;
model SelectorBlock
  final parameter Real constant_value=if PCMType==PCMDict.PCM58C then 58
 else
     if PCMType==PCMDict.PCM48C then 48 else if PCMType==PCMDict.PCM35C then 35
 else
     0;
  parameter PCMDict PCMType;
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-4},{120,16}})));
  Modelica.Blocks.Sources.Constant const(k=constant_value)
    annotation (Placement(transformation(extent={{-8,8},{12,28}})));

equation
  connect(const.y, y) annotation (Line(points={{13,18},{94,18},{94,6},{110,6}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SelectorBlock;
