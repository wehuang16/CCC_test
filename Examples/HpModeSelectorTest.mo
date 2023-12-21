within CCC_test.Examples;
model HpModeSelectorTest
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,66},{120,86}})));
  Modelica.Blocks.Interfaces.RealOutput y1
    annotation (Placement(transformation(extent={{100,38},{120,58}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput y3
    annotation (Placement(transformation(extent={{100,-32},{120,-12}})));
  Modelica.Blocks.Interfaces.BooleanOutput y4
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput y5
    annotation (Placement(transformation(extent={{100,-84},{120,-64}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    "true for heating, false for cooling"
    annotation (Placement(transformation(extent={{-140,-74},{-100,-34}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{-74,74},{-54,94}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{-82,-2},{-62,18}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-74,36},{-54,56}})));
equation
  connect(const2.y, y) annotation (Line(points={{-53,84},{94,84},{94,76},{110,
          76}}, color={0,0,127}));
  connect(const3.y, y2) annotation (Line(points={{-61,8},{94,8},{94,20},{110,20}},
        color={0,0,127}));
  connect(const1.y, y1) annotation (Line(points={{-53,46},{94,46},{94,48},{110,
          48}}, color={0,0,127}));
  connect(u, y3) annotation (Line(points={{-120,-54},{-120,-22},{110,-22}},
        color={255,0,255}));
  connect(u, y4) annotation (Line(points={{-120,-54},{94,-54},{94,-50},{110,-50}},
        color={255,0,255}));
  connect(u, y5) annotation (Line(points={{-120,-54},{94,-54},{94,-74},{110,-74}},
        color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HpModeSelectorTest;
