within CCC_test.Examples;
model cdlExample1
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=180,
      final y_start=21)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-106,14},{-86,34}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    "Increase setpoint by amount of value defined from reset logic"
    annotation (Placement(transformation(extent={{-46,8},{-26,28}})));
  Buildings.Controls.OBC.CDL.Reals.Min min1
    "Reset setpoint should not be higher than the maximum setpoint"
    annotation (Placement(transformation(extent={{-8,2},{12,22}})));
  Buildings.Controls.OBC.CDL.Reals.Max maxInp
    "Reset setpoint should not be lower than the minimum setpoint"
    annotation (Placement(transformation(extent={{32,2},{52,22}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant maxSetCon(k=270)
    "Maximum setpoint constant"
    annotation (Placement(transformation(extent={{-48,-28},{-28,-8}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minSetCon(k=210)
    "Minimum setpoint constant"
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput myOutput1 annotation (
      Placement(transformation(extent={{110,-10},{150,30}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    table=[0,0.15; 10800,0.25; 21600,-0.1; 32400,0.05; 43200,0; 54000,-0.15;
        64800,0.2; 75600,-0.05; 86400,0.1],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-162,-6},{-142,14}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter valueToIncrease(k=1)
    annotation (Placement(transformation(extent={{-120,-30},{-88,2}})));
equation
  connect(uniDel.y,add1. u1)
    annotation (Line(points={{-84,24},{-48,24}},
      color={0,0,127}));
  connect(minSetCon.y,maxInp. u2)
    annotation (Line(points={{14,-18},{24,-18},{24,-2},{22,-2},{22,6},{30,6}},
      color={0,0,127}));
  connect(maxSetCon.y,min1. u2)
    annotation (Line(points={{-26,-18},{-18,-18},{-18,6},{-10,6}},
      color={0,0,127}));
  connect(add1.y,min1. u1)
    annotation (Line(points={{-24,18},{-10,18}},
                                               color={0,0,127}));
  connect(min1.y,maxInp. u1)
    annotation (Line(points={{14,12},{22,12},{22,18},{30,18}},
                                                             color={0,0,127}));
  connect(maxInp.y,uniDel. u) annotation (Line(points={{54,12},{54,40},{-116,40},
          {-116,24},{-108,24}},   color={0,0,127}));
  connect(maxInp.y, myOutput1) annotation (Line(points={{54,12},{54,20},{104,20},
          {104,10},{130,10}}, color={0,0,127}));
  connect(valueToIncrease.y, add1.u2) annotation (Line(points={{-84.8,-14},{-58,
          -14},{-58,12},{-48,12}}, color={0,0,127}));
  connect(combiTimeTable1.y[1], valueToIncrease.u) annotation (Line(points={{
          -141,4},{-134,4},{-134,-14},{-123.2,-14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end cdlExample1;
