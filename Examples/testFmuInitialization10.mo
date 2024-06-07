within CCC_test.Examples;
model testFmuInitialization10
  Modelica.Blocks.Interfaces.BooleanInput
                                       u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-62,20},{-42,40}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        y2
    annotation (Placement(transformation(extent={{100,-56},{120,-36}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{0,-12},{20,8}})));
  Modelica.Blocks.Sources.Constant const1(k=7)
    annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
  Modelica.Blocks.Logical.LogicalSwitch switch2
    annotation (Placement(transformation(extent={{12,-86},{32,-66}})));
  Modelica.Blocks.Sources.BooleanConstant
                                   booleanConstant(k=false)
    annotation (Placement(transformation(extent={{-78,-72},{-58,-52}})));
  Modelica.Blocks.Sources.BooleanConstant
                                   booleanConstant1(k=true)
    annotation (Placement(transformation(extent={{-50,-94},{-30,-74}})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=1,
    f=0.00833333333,
    offset=0.5)
    annotation (Placement(transformation(extent={{138,44},{158,64}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{58,76},{78,96}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{62,26},{82,46}})));
  realSwitch realSwitch2
    annotation (Placement(transformation(extent={{190,28},{210,48}})));
equation
  connect(const.y, switch1.u1) annotation (Line(points={{-41,30},{-22,30},{-22,
          6},{-2,6},{-2,6}}, color={0,0,127}));
  connect(const1.y, switch1.u3)
    annotation (Line(points={{-49,-26},{-2,-26},{-2,-10}}, color={0,0,127}));
  connect(u, switch1.u2) annotation (Line(points={{-120,0},{-118,0},{-118,-2},{
          -2,-2}}, color={255,0,255}));
  connect(u, switch2.u2) annotation (Line(points={{-120,0},{-8,0},{-8,-76},{10,
          -76}}, color={255,0,255}));
  connect(booleanConstant.y, switch2.u1) annotation (Line(points={{-57,-62},{2,
          -62},{2,-68},{10,-68}}, color={255,0,255}));
  connect(booleanConstant1.y, switch2.u3)
    annotation (Line(points={{-29,-84},{10,-84}}, color={255,0,255}));
  connect(switch2.y, y2) annotation (Line(points={{33,-76},{96,-76},{96,-46},{
          110,-46}}, color={255,0,255}));
  connect(switch1.y, y) annotation (Line(points={{21,-2},{96,-2},{96,0},{110,0}},
        color={0,0,127}));
  connect(const2.y, realSwitch2.u1) annotation (Line(points={{79,86},{106,86},{
          106,98},{172,98},{172,44.2},{188,44.2}}, color={0,0,127}));
  connect(sine.y, realSwitch2.u2) annotation (Line(points={{159,54},{118,54},{
          118,37},{188,37}}, color={0,0,127}));
  connect(const3.y, realSwitch2.u3) annotation (Line(points={{83,36},{132,36},{
          132,20},{187.8,20},{187.8,29.8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFmuInitialization10;
