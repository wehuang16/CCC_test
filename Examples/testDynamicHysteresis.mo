within CCC_test.Examples;
model testDynamicHysteresis
  CCC.Controls.HysteresisDynamic hysteresisDynamic
    annotation (Placement(transformation(extent={{-30,-4},{-10,16}})));
  Modelica.Blocks.Sources.Constant const2(k=3)
    annotation (Placement(transformation(extent={{-98,34},{-78,54}})));
  Modelica.Blocks.Sources.Constant const1(k=7)
    annotation (Placement(transformation(extent={{-106,-58},{-86,-38}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    f=0.00011574074,
    phase=0,
    offset=5) annotation (Placement(transformation(extent={{-82,2},{-62,22}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=7)
    annotation (Placement(transformation(extent={{48,-46},{68,-26}})));
equation
  connect(const2.y, hysteresisDynamic.uLow) annotation (Line(points={{-77,44},{
          -40,44},{-40,12.8},{-32,12.8}}, color={0,0,127}));
  connect(const1.y, hysteresisDynamic.uHigh) annotation (Line(points={{-85,-48},
          {-40,-48},{-40,-1.6},{-32,-1.6}}, color={0,0,127}));
  connect(sine.y, hysteresisDynamic.u) annotation (Line(points={{-61,12},{-42,
          12},{-42,6},{-32,6}}, color={0,0,127}));
  connect(sine.y, hysteresis.u) annotation (Line(points={{-61,12},{-42,12},{-42,
          -36},{46,-36}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testDynamicHysteresis;
