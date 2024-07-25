within CCC_test.Examples;
model cdlExample6
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
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(t=1)
    annotation (Placement(transformation(extent={{-42,-112},{-22,-92}})));
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
    annotation (Placement(transformation(extent={{30,-138},{50,-118}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput myOutput2 annotation (
      Placement(transformation(extent={{106,-42},{146,-2}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=150)
    annotation (Placement(transformation(extent={{14,-106},{34,-86}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter valueToIncrease(k=1)
    annotation (Placement(transformation(extent={{-120,-30},{-88,2}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{40,-108},{60,-88}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(delayTime=150)
    annotation (Placement(transformation(extent={{72,-108},{92,-88}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{102,-108},{122,-88}})));
  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol(trueHoldDuration=
        135)
    annotation (Placement(transformation(extent={{-14,-144},{6,-124}})));
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
  connect(lesThr.u, subt.y) annotation (Line(points={{-44,-102},{-52,-102},{-52,
          -88},{-50,-88},{-50,-80},{-58,-80}},
                           color={0,0,127}));
  connect(maxInp.y, subt.u1) annotation (Line(points={{54,12},{54,40},{-116,40},
          {-116,8},{-134,8},{-134,-66},{-90,-66},{-90,-74},{-82,-74}}, color={0,
          0,127}));
  connect(combiTimeTable2.y[1], subt.u2) annotation (Line(points={{-141,-64},{
          -136,-64},{-136,-86},{-82,-86}}, color={0,0,127}));
  connect(con.y, swi.u1) annotation (Line(points={{100,-74},{118,-74},{118,-94},
          {126,-94}}, color={0,0,127}));
  connect(con1.y, swi.u3) annotation (Line(points={{52,-128},{118,-128},{118,
          -110},{126,-110}}, color={0,0,127}));
  connect(combiTimeTable2.y[1], myOutput2) annotation (Line(points={{-141,-64},
          {-92,-64},{-92,-40},{78,-40},{78,-22},{126,-22}}, color={0,0,127}));
  connect(valueToIncrease.y, add1.u2) annotation (Line(points={{-84.8,-14},{-58,
          -14},{-58,12},{-48,12}}, color={0,0,127}));
  connect(swi.y, valueToIncrease.u) annotation (Line(points={{150,-102},{158,
          -102},{158,-56},{-130,-56},{-130,-22},{-132,-22},{-132,-14},{-123.2,
          -14}}, color={0,0,127}));
  connect(not1.y, truDel1.u)
    annotation (Line(points={{62,-98},{70,-98}}, color={255,0,255}));
  connect(truDel1.y, not2.u)
    annotation (Line(points={{94,-98},{100,-98}}, color={255,0,255}));
  connect(truDel.y, not1.u)
    annotation (Line(points={{36,-96},{36,-98},{38,-98}}, color={255,0,255}));
  connect(not2.y, swi.u2) annotation (Line(points={{124,-98},{124,-102},{126,
          -102}}, color={255,0,255}));
  connect(lesThr.y, truFalHol.u) annotation (Line(points={{-20,-102},{-12,-102},
          {-12,-120},{-26,-120},{-26,-134},{-16,-134}}, color={255,0,255}));
  connect(truFalHol.y, truDel.u) annotation (Line(points={{8,-134},{16,-134},{
          16,-110},{2,-110},{2,-96},{12,-96}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end cdlExample6;
