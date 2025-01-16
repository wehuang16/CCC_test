within CCC_test.Example2;
model testDoubleScaleUp
  Modelica.Blocks.Interfaces.RealInput u[2]
    annotation (Placement(transformation(extent={{-140,-18},{-100,24}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{102,-10},{122,10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-16,-4},{4,16}})));
equation
  connect(u[1], add.u1) annotation (Line(points={{-120,-2.25},{-120,2},{-26,2},
          {-26,12},{-18,12}}, color={0,0,127}));
  connect(u[2], add.u2)
    annotation (Line(points={{-120,8.25},{-120,0},{-18,0}}, color={0,0,127}));
  connect(add.y, y)
    annotation (Line(points={{5,6},{96,6},{96,0},{112,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testDoubleScaleUp;
