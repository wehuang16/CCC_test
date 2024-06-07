within CCC_test.Examples;
model testFmuInitialization4
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-114,70},{-94,90}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    annotation (Placement(transformation(extent={{100,-56},{120,-36}})));
  Modelica.Blocks.Sources.Constant const1(k=7)
    annotation (Placement(transformation(extent={{-114,32},{-94,52}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{4,-6},{24,14}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-34,52},{-14,72}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{56,28},{76,48}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-16,-64},{4,-44}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{-90,-58},{-70,-38}})));
equation
  connect(const.y, add.u1) annotation (Line(points={{-93,80},{-42,80},{-42,68},
          {-36,68}}, color={0,0,127}));
  connect(const1.y, add.u2) annotation (Line(points={{-93,42},{-42,42},{-42,56},
          {-36,56}}, color={0,0,127}));
  connect(u, product1.u2) annotation (Line(points={{-120,0},{-118,0},{-118,-2},
          {2,-2}}, color={0,0,127}));
  connect(add.y, product1.u1) annotation (Line(points={{-13,62},{-4,62},{-4,10},
          {2,10}}, color={0,0,127}));
  connect(product1.y, add1.u1)
    annotation (Line(points={{25,4},{48,4},{48,44},{54,44}}, color={0,0,127}));
  connect(const1.y, add1.u2) annotation (Line(points={{-93,42},{46,42},{46,32},
          {54,32}}, color={0,0,127}));
  connect(add1.y, y) annotation (Line(points={{77,38},{96,38},{96,0},{110,0}},
        color={0,0,127}));
  connect(u, add2.u2) annotation (Line(points={{-120,0},{-24,0},{-24,-60},{-18,
          -60}}, color={0,0,127}));
  connect(const2.y, add2.u1)
    annotation (Line(points={{-69,-48},{-18,-48}}, color={0,0,127}));
  connect(add2.y, y2) annotation (Line(points={{5,-54},{94,-54},{94,-46},{110,
          -46}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFmuInitialization4;
