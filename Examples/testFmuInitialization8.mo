within CCC_test.Examples;
model testFmuInitialization8
  Modelica.Blocks.Interfaces.BooleanInput
                                       u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        y2
    annotation (Placement(transformation(extent={{100,-56},{120,-36}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-4,-62},{16,-42}})));
equation
  connect(u, y) annotation (Line(points={{-120,0},{110,0}}, color={255,0,255}));
  connect(u, not1.u) annotation (Line(points={{-120,0},{-12,0},{-12,-52},{-6,
          -52}}, color={255,0,255}));
  connect(not1.y, y2) annotation (Line(points={{17,-52},{94,-52},{94,-46},{110,
          -46}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFmuInitialization8;
