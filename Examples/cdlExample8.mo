within CCC_test.Examples;
model cdlExample8
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
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(t=1)
    annotation (Placement(transformation(extent={{-18,-106},{2,-86}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
    table=[0,205; 43200,265; 86400,290],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-162,-74},{-142,-54}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract subt
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{128,-112},{148,-92}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=3)
    annotation (Placement(transformation(extent={{78,-84},{98,-64}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0)
    annotation (Placement(transformation(extent={{152,-164},{172,-144}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput myOutput2 annotation (
      Placement(transformation(extent={{106,-42},{146,-2}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter valueToIncrease(k=1)
    annotation (Placement(transformation(extent={{-120,-30},{-88,2}})));
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=270, uMin=210)
    annotation (Placement(transformation(extent={{14,28},{34,48}})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel1(final samplePeriod=300,
      final y_start=210)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={56,-22})));
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel2(final samplePeriod=300,
      final y_start=210)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={58,12})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=150)
    annotation (Placement(transformation(extent={{-30,-162},{-10,-142}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-4,-164},{16,-144}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(delayTime=150)
    annotation (Placement(transformation(extent={{28,-164},{48,-144}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{58,-164},{78,-144}})));
equation
  connect(uniDel.y,add1. u1)
    annotation (Line(points={{-84,24},{-48,24}},
      color={0,0,127}));
  connect(lesThr.u, subt.y) annotation (Line(points={{-20,-96},{-50,-96},{-50,
          -80},{-58,-80}}, color={0,0,127}));
  connect(combiTimeTable2.y[1], subt.u2) annotation (Line(points={{-141,-64},{
          -136,-64},{-136,-86},{-82,-86}}, color={0,0,127}));
  connect(con.y, swi.u1) annotation (Line(points={{100,-74},{118,-74},{118,-94},
          {126,-94}}, color={0,0,127}));
  connect(con1.y, swi.u3) annotation (Line(points={{174,-154},{182,-154},{182,
          -118},{126,-118},{126,-110}},
                             color={0,0,127}));
  connect(combiTimeTable2.y[1], myOutput2) annotation (Line(points={{-141,-64},
          {-92,-64},{-92,-40},{78,-40},{78,-22},{126,-22}}, color={0,0,127}));
  connect(valueToIncrease.y, add1.u2) annotation (Line(points={{-84.8,-14},{-58,
          -14},{-58,12},{-48,12}}, color={0,0,127}));
  connect(swi.y, valueToIncrease.u) annotation (Line(points={{150,-102},{158,
          -102},{158,-56},{-130,-56},{-130,-22},{-132,-22},{-132,-14},{-123.2,
          -14}}, color={0,0,127}));
  connect(add1.y, lim.u) annotation (Line(points={{-24,18},{2,18},{2,38},{12,38}},
        color={0,0,127}));
  connect(lim.y, myOutput1) annotation (Line(points={{36,38},{94,38},{94,10},{
          130,10}}, color={0,0,127}));
  connect(uniDel1.y, subt.u1)
    annotation (Line(points={{56,-34},{56,-74},{-82,-74}}, color={0,0,127}));
  connect(uniDel.u, uniDel1.y) annotation (Line(points={{-108,24},{-124,24},{
          -124,-34},{56,-34}}, color={0,0,127}));
  connect(uniDel2.y, uniDel1.u) annotation (Line(points={{58,0},{58,-4},{56,-4},
          {56,-10}}, color={0,0,127}));
  connect(lim.y, uniDel2.u)
    annotation (Line(points={{36,38},{58,38},{58,24}}, color={0,0,127}));
  connect(truDel.y, not1.u) annotation (Line(points={{-8,-152},{-8,-154},{-6,
          -154}}, color={255,0,255}));
  connect(not1.y, truDel1.u)
    annotation (Line(points={{18,-154},{26,-154}}, color={255,0,255}));
  connect(truDel1.y, not2.u)
    annotation (Line(points={{50,-154},{56,-154}}, color={255,0,255}));
  connect(lesThr.y, truDel.u) annotation (Line(points={{4,-96},{12,-96},{12,
          -134},{-40,-134},{-40,-152},{-32,-152}}, color={255,0,255}));
  connect(not2.y, swi.u2) annotation (Line(points={{80,-154},{116,-154},{116,
          -102},{126,-102}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end cdlExample8;
