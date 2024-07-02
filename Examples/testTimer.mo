within CCC_test.Examples;
model testTimer
  Buildings.Controls.OBC.CDL.Logical.Timer tim(t=60)
    annotation (Placement(transformation(extent={{-40,2},{-20,22}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    table=[0,0; 21600,0; 24000,1; 43200,1; 50000,0; 64800,0; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-150,-10},{-130,10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1
    annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 10800,1; 21600,0; 32400,1; 43200,0; 54000,1; 64800,0; 75600,1;
        86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-156,36},{-136,56}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-92,36},{-72,56}})));
  Buildings.Controls.OBC.CDL.Logical.TimerAccumulating accTim(t=60)
    annotation (Placement(transformation(extent={{-34,-60},{-14,-40}})));
equation
  connect(combiTimeTable1.y[1], realToBoolean1.u) annotation (Line(points={{
          -129,0},{-112,0},{-112,-16},{-102,-16}}, color={0,0,127}));
  connect(combiTimeTable.y[1], realToBoolean.u)
    annotation (Line(points={{-135,46},{-94,46}}, color={0,0,127}));
  connect(realToBoolean.y, tim.u) annotation (Line(points={{-71,46},{-52,46},{
          -52,12},{-42,12}}, color={255,0,255}));
  connect(realToBoolean.y, accTim.u) annotation (Line(points={{-71,46},{-52,46},
          {-52,-50},{-36,-50}}, color={255,0,255}));
  connect(realToBoolean1.y, accTim.reset) annotation (Line(points={{-79,-16},{
          -54,-16},{-54,-58},{-36,-58}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testTimer;
