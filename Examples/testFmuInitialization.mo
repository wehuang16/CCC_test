within CCC_test.Examples;
model testFmuInitialization
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{12,-20},{32,0}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-42,26},{-22,46}})));
equation
  connect(const.y, add.u1) annotation (Line(points={{-21,36},{4,36},{4,-4},{10,
          -4}}, color={0,0,127}));
  connect(u, add.u2) annotation (Line(points={{-120,0},{2,0},{2,-16},{10,-16}},
        color={0,0,127}));
  connect(add.y, y) annotation (Line(points={{33,-10},{94,-10},{94,0},{110,0}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testFmuInitialization;
