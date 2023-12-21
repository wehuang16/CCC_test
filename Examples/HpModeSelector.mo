within CCC_test.Examples;
model HpModeSelector
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
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch1
    annotation (Placement(transformation(extent={{52,-34},{72,-14}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold
      =0.5) annotation (Placement(transformation(extent={{-2,62},{18,82}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(
      threshold=0.5)
    annotation (Placement(transformation(extent={{0,24},{20,44}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(
      threshold=0.5)
    annotation (Placement(transformation(extent={{-4,-18},{16,2}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch2
    annotation (Placement(transformation(extent={{62,-64},{82,-44}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch3
    annotation (Placement(transformation(extent={{60,-96},{80,-76}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-84,-98},{-64,-78}})));
equation
  connect(const2.y, y) annotation (Line(points={{-53,84},{94,84},{94,76},{110,
          76}}, color={0,0,127}));
  connect(const3.y, y2) annotation (Line(points={{-61,8},{94,8},{94,20},{110,20}},
        color={0,0,127}));
  connect(const1.y, y1) annotation (Line(points={{-53,46},{94,46},{94,48},{110,
          48}}, color={0,0,127}));
  connect(const2.y, greaterEqualThreshold.u) annotation (Line(points={{-53,84},
          {-12,84},{-12,72},{-4,72}}, color={0,0,127}));
  connect(const1.y, greaterEqualThreshold1.u) annotation (Line(points={{-53,46},
          {-10,46},{-10,34},{-2,34}}, color={0,0,127}));
  connect(const3.y, greaterEqualThreshold2.u) annotation (Line(points={{-61,8},
          {-14,8},{-14,-8},{-6,-8}}, color={0,0,127}));
  connect(logicalSwitch1.y, y3) annotation (Line(points={{73,-24},{94,-24},{94,
          -22},{110,-22}}, color={255,0,255}));
  connect(logicalSwitch2.y, y4) annotation (Line(points={{83,-54},{92,-54},{92,
          -50},{110,-50}}, color={255,0,255}));
  connect(logicalSwitch3.y, y5) annotation (Line(points={{81,-86},{94,-86},{94,
          -74},{110,-74}}, color={255,0,255}));
  connect(u, logicalSwitch1.u1) annotation (Line(points={{-120,-54},{-120,-24},
          {40,-24},{40,-16},{50,-16}}, color={255,0,255}));
  connect(u, logicalSwitch2.u1) annotation (Line(points={{-120,-54},{-120,-24},
          {40,-24},{40,-40},{52,-40},{52,-42},{54,-42},{54,-46},{60,-46}},
        color={255,0,255}));
  connect(u, logicalSwitch3.u1) annotation (Line(points={{-120,-54},{50,-54},{
          50,-78},{58,-78}}, color={255,0,255}));
  connect(booleanConstant.y, logicalSwitch1.u3) annotation (Line(points={{-63,
          -88},{-24,-88},{-24,-52},{44,-52},{44,-38},{42,-38},{42,-32},{50,-32}},
        color={255,0,255}));
  connect(booleanConstant.y, logicalSwitch2.u3) annotation (Line(points={{-63,
          -88},{-24,-88},{-24,-52},{52,-52},{52,-62},{60,-62}}, color={255,0,
          255}));
  connect(booleanConstant.y, logicalSwitch3.u3) annotation (Line(points={{-63,
          -88},{48,-88},{48,-94},{58,-94}}, color={255,0,255}));
  connect(greaterEqualThreshold.y, logicalSwitch1.u2) annotation (Line(points={
          {19,72},{24,72},{24,66},{50,66},{50,-24}}, color={255,0,255}));
  connect(greaterEqualThreshold1.y, logicalSwitch2.u2) annotation (Line(points=
          {{21,34},{28,34},{28,-64},{52,-64},{52,-70},{60,-70},{60,-54}}, color
        ={255,0,255}));
  connect(greaterEqualThreshold2.y, logicalSwitch3.u2) annotation (Line(points=
          {{17,-8},{32,-8},{32,-86},{58,-86}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HpModeSelector;
