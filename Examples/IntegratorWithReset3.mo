within CCC_test.Examples;
model IntegratorWithReset3 "Test model for integrator with reset"
  Buildings.Controls.OBC.CDL.Reals.IntegratorWithReset intDef(final
      y_start=-2)
    "Integrator with default values"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cons(final k=0)
    "Constant as source term"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booleanPulse(
    final width=0.5,
    final period=0.2)
    "Boolean pulse"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.SampleTrigger sampleTrigger(final
      period=30)
    "Sample trigger"
    annotation (Placement(transformation(extent={{-78,24},{-58,44}})));

  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=30,
      final y_start=0)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{54,12},{74,32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant cons1(final k=1)
    "Constant as source term"
    annotation (Placement(transformation(extent={{-76,-28},{-56,-8}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    annotation (Placement(transformation(extent={{-22,-20},{-2,0}})));
equation
  connect(cons.y,intDef.u)
    annotation (Line(points={{-38,70},{-2,70}},color={0,0,127}));
  connect(sampleTrigger.y,intDef.trigger)
    annotation (Line(points={{-56,34},{10,34},{10,58}},                  color={255,0,255}));
  connect(intDef.y, uniDel.u) annotation (Line(points={{22,70},{42,70},{42,22},
          {52,22}}, color={0,0,127}));
  connect(cons1.y, add2.u1) annotation (Line(points={{-54,-18},{-34,-18},{-34,
          -4},{-24,-4}}, color={0,0,127}));
  connect(uniDel.y, add2.u2) annotation (Line(points={{76,22},{88,22},{88,-60},
          {-24,-60},{-24,-16}}, color={0,0,127}));
  connect(add2.y, intDef.y_reset_in) annotation (Line(points={{0,-10},{8,-10},{
          8,62},{-2,62}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=1080,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/CDL/Reals/Validation/IntegratorWithReset.mos" "Simulate and plot"),
    Documentation(
      info="<html>
<p>
This model tests the implementation of
<a href=\"modelica://Buildings.Controls.OBC.CDL.Reals.IntegratorWithReset\">
Buildings.Controls.OBC.CDL.Reals.IntegratorWithReset</a>
with and without reset, and with different start values
and reset values.
</p>
<p>
The integrator <code>intWitRes1</code> is triggered by a sample trigger
which becomes true at <i>t=0</i>, while <code>intWitRes2</code> is triggered
by a boolean pulse with is true at <i>t=0</i>.
Hence, <code>intWitRes1</code> starts with <code>y(0)=y_reset</code> while
<code>intWitRes2</code> starts with <code>y(0)=y_start</code>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
March 23, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}));
end IntegratorWithReset3;
