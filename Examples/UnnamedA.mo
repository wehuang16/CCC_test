within CCC_test.Examples;
model UnnamedA

  Modelica.Blocks.Sources.CombiTimeTable u1(
    table=[0,180; 43200,225; 86400,240],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y1(start=210) annotation (Placement(
        transformation(extent={{100,-20},{140,20}}), iconTransformation(extent={
            {100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=270, uMin=210)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(t=1, h=3.2)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=3,
      realFalse=0)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=2400,
      final y_start=210)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
equation
  connect(lim.y, y1)
    annotation (Line(points={{82,0},{120,0}}, color={0,0,127}));
  connect(y1, sub.u1) annotation (Line(points={{120,0},{90,0},{90,16},{-82,16},{
          -82,6}}, color={0,0,127}));
  connect(u1.y[1], sub.u2) annotation (Line(points={{-99,0},{-92,0},{-92,-6},{-82,
          -6}}, color={0,0,127}));
  connect(sub.y, lesThr.u) annotation (Line(points={{-58,0},{-50,0},{-50,-30},{-42,
          -30}}, color={0,0,127}));
  connect(lesThr.y, booToRea.u)
    annotation (Line(points={{-18,-30},{-12,-30}}, color={255,0,255}));
  connect(booToRea.y, add2.u2) annotation (Line(points={{12,-30},{14,-30},{14,-16},
          {18,-16}}, color={0,0,127}));
  connect(add2.y, lim.u) annotation (Line(points={{42,-10},{50,-10},{50,0},{58,0}},
        color={0,0,127}));
  connect(uniDel.y, add2.u1)
    annotation (Line(points={{2,0},{10,0},{10,-4},{18,-4}}, color={0,0,127}));
  connect(uniDel.u, y1) annotation (Line(points={{-22,0},{-30,0},{-30,16},{90,16},
          {90,0},{120,0}}, color={0,0,127}));
  annotation (uses(Modelica(version="4.0.0"), Buildings(version="10.0.0")),
  experiment(StopTime=86400, Tolerance=1E-6));
end UnnamedA;
