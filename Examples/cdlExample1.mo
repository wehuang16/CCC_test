within CCC_test.Examples;
model cdlExample1
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=180, final
      y_start=210)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-106,14},{-86,34}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    "Increase setpoint by amount of value defined from reset logic"
    annotation (Placement(transformation(extent={{-46,8},{-26,28}})));
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
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=270, uMin=210)
    annotation (Placement(transformation(extent={{36,6},{56,26}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
    table=[0,0; 10800,0; 21600,3; 22500,0; 32400,0; 43200,3; 43260,0; 54000,0;
        64795,3; 65100,0; 75600,0; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-182,-58},{-162,-38}})));
equation
  connect(uniDel.y,add1. u1)
    annotation (Line(points={{-84,24},{-48,24}},
      color={0,0,127}));
  connect(valueToIncrease.y, add1.u2) annotation (Line(points={{-84.8,-14},{-58,
          -14},{-58,12},{-48,12}}, color={0,0,127}));
  connect(add1.y, lim.u) annotation (Line(points={{-24,18},{26,18},{26,16},{34,
          16}}, color={0,0,127}));
  connect(lim.y, myOutput1) annotation (Line(points={{58,16},{104,16},{104,10},
          {130,10}}, color={0,0,127}));
  connect(combiTimeTable2.y[1], valueToIncrease.u) annotation (Line(points={{
          -161,-48},{-134,-48},{-134,-14},{-123.2,-14}}, color={0,0,127}));
  connect(lim.y, uniDel.u) annotation (Line(points={{58,16},{68,16},{68,52},{
          -122,52},{-122,24},{-108,24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end cdlExample1;
