within CCC_test.Examples;
model OutputNotZero
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{16,-8},{36,12}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-58,-54},{-38,-34}})));
equation
  connect(u, abs1.u)
    annotation (Line(points={{-120,0},{-88,0}}, color={0,0,127}));
  connect(greaterThreshold.u, abs1.y)
    annotation (Line(points={{-38,0},{-65,0}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-15,0},{6,0},{6,2},{14,2}}, color={255,0,255}));
  connect(u, switch1.u1) annotation (Line(points={{-120,0},{-96,0},{-96,14},{4,
          14},{4,10},{14,10}}, color={0,0,127}));
  connect(const.y, switch1.u3)
    annotation (Line(points={{-37,-44},{14,-44},{14,-6}}, color={0,0,127}));
  connect(switch1.y, y)
    annotation (Line(points={{37,2},{96,2},{96,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OutputNotZero;
