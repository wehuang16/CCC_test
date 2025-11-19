within CCC_test.StanfordHybrid;
model MultiplicationAddition
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{-4,-34},{16,-14}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{-62,28},{-42,48}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u3
    annotation (Placement(transformation(extent={{-140,-88},{-100,-48}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u1
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u2
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  connect(u1, mul.u1) annotation (Line(points={{-120,70},{-72,70},{-72,44},{-64,
          44}}, color={0,0,127}));
  connect(u2, mul.u2) annotation (Line(points={{-120,0},{-72,0},{-72,32},{-64,
          32}}, color={0,0,127}));
  connect(mul.y, add2.u1) annotation (Line(points={{-40,38},{-14,38},{-14,-18},
          {-6,-18}}, color={0,0,127}));
  connect(u3, add2.u2) annotation (Line(points={{-120,-68},{-14,-68},{-14,-30},
          {-6,-30}}, color={0,0,127}));
  connect(add2.y, y) annotation (Line(points={{18,-24},{94,-24},{94,0},{120,0}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiplicationAddition;
