within CCC_test.Examples;
model testFmuInitialization9
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-114,68},{-94,88}})));
  Modelica.Blocks.Sources.Constant const1(k=7)
    annotation (Placement(transformation(extent={{-114,30},{-94,50}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{4,-8},{24,12}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-34,50},{-14,70}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{56,26},{76,46}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-88,-48},{-68,-28}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-22},{-100,18}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-12},{120,8}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    annotation (Placement(transformation(extent={{100,-58},{120,-38}})));
  realSwitch realSwitch1
    annotation (Placement(transformation(extent={{-18,-66},{2,-46}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{-84,-98},{-64,-78}})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=1,
    f=0.00166666666,
    offset=0.5)
    annotation (Placement(transformation(extent={{-8,-100},{12,-80}})));
  realSwitch realSwitch2
    annotation (Placement(transformation(extent={{44,-96},{64,-76}})));
equation
  connect(const.y, add.u1) annotation (Line(points={{-93,78},{-42,78},{-42,66},
          {-36,66}}, color={0,0,127}));
  connect(const1.y, add.u2) annotation (Line(points={{-93,40},{-42,40},{-42,54},
          {-36,54}}, color={0,0,127}));
  connect(u, product1.u2) annotation (Line(points={{-120,-2},{-118,-2},{-118,-4},
          {2,-4}}, color={0,0,127}));
  connect(add.y, product1.u1)
    annotation (Line(points={{-13,60},{-4,60},{-4,8},{2,8}}, color={0,0,127}));
  connect(product1.y, add1.u1)
    annotation (Line(points={{25,2},{48,2},{48,42},{54,42}}, color={0,0,127}));
  connect(const1.y, add1.u2) annotation (Line(points={{-93,40},{46,40},{46,30},
          {54,30}}, color={0,0,127}));
  connect(add1.y, y) annotation (Line(points={{77,36},{96,36},{96,-2},{110,-2}},
        color={0,0,127}));
  connect(const2.y, realSwitch1.u1) annotation (Line(points={{-67,-38},{-20,-38},
          {-20,-49.8}}, color={0,0,127}));
  connect(const3.y, realSwitch1.u3) annotation (Line(points={{-63,-88},{-28,-88},
          {-28,-64.2},{-20.2,-64.2}}, color={0,0,127}));
  connect(u, realSwitch1.u2) annotation (Line(points={{-120,-2},{-94,-2},{-94,
          -57},{-20,-57}}, color={0,0,127}));
  connect(realSwitch1.y, y2) annotation (Line(points={{3,-55.8},{3,-54},{94,-54},
          {94,-48},{110,-48}}, color={0,0,127}));
  connect(sine.y, realSwitch2.u2) annotation (Line(points={{13,-90},{34,-90},{
          34,-87},{42,-87}}, color={0,0,127}));
  connect(const2.y, realSwitch2.u1) annotation (Line(points={{-67,-38},{-40,-38},
          {-40,-26},{26,-26},{26,-79.8},{42,-79.8}}, color={0,0,127}));
  connect(const3.y, realSwitch2.u3) annotation (Line(points={{-63,-88},{-14,-88},
          {-14,-104},{41.8,-104},{41.8,-94.2}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFmuInitialization9;
