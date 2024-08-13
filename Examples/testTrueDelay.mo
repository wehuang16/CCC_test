within CCC_test.Examples;
model testTrueDelay
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 10800,1; 21600,0; 32400,1; 43200,0; 54000,1; 64800,0; 75600,1;
        86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-124,-10},{-104,10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Logical.LogicalDelay logicalDelay(delayTime=1500)
    annotation (Placement(transformation(extent={{26,-40},{46,-20}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{64,-36},{84,-16}})));
  Modelica.Blocks.Logical.LogicalDelay logicalDelay1(delayTime=1500)
    annotation (Placement(transformation(extent={{94,-60},{114,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{126,-36},{146,-16}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput
                                                   myOutput1 annotation (
      Placement(transformation(extent={{166,-38},{206,2}}),  iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput myInput1 annotation (
      Placement(transformation(extent={{118,0},{158,40}}), iconTransformation(
          extent={{100,-20},{140,20}})));
equation
  connect(combiTimeTable.y[1], realToBoolean.u)
    annotation (Line(points={{-103,0},{-62,0}}, color={0,0,127}));
  connect(logicalDelay.y1, not1.u)
    annotation (Line(points={{47,-24},{47,-26},{62,-26}}, color={255,0,255}));
  connect(not1.y, logicalDelay1.u) annotation (Line(points={{86,-26},{94,-26},{
          94,-36},{90,-36},{90,-42},{84,-42},{84,-50},{92,-50}}, color={255,0,
          255}));
  connect(realToBoolean.y, logicalDelay.u) annotation (Line(points={{-39,0},{14,
          0},{14,-30},{24,-30}}, color={255,0,255}));
  connect(not2.y, myOutput1) annotation (Line(points={{148,-26},{160,-26},{160,
          -18},{186,-18}}, color={255,0,255}));
  connect(realToBoolean.y, myInput1) annotation (Line(points={{-39,0},{112,0},{
          112,20},{138,20}}, color={255,0,255}));
  connect(logicalDelay1.y1, not2.u) annotation (Line(points={{115,-44},{122,-44},
          {122,-34},{116,-34},{116,-26},{124,-26}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testTrueDelay;
