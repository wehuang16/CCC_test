within CCC_test.Examples;
model testUnitDelay


    parameter Real TZonSetNominal(unit="K")=273.15+23
    "Nominal zone air temperature setpoint";

      parameter Real TMaxSet(unit="K")=273.15+27
    "Maximum zone cooling temperature setpoint";
      parameter Real samplePeriod(unit="s")=300
    "Sample period of the demand flexibility control";
       parameter Real TRatThreshold=0.5
    "Threshold of zone air temperature setpoint difference below which ratcheting is triggerd";
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=300, final
      y_start=TZonSetNominal)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-86,-26},{-66,-6}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    "Increase setpoint by amount of value defined from reset logic"
    annotation (Placement(transformation(extent={{-26,-32},{-6,-12}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    table=[0,-0.3; 21600,-0.3; 24000,0.5; 43200,0.5; 50000,0.5; 64800,-0.3;
        86400,-0.3],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-86,-66},{-66,-46}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant maxSetCon(k=TMaxSet)
    "Maximum setpoint constant"
    annotation (Placement(transformation(extent={{-12,-82},{8,-62}})));
  Buildings.Controls.OBC.CDL.Reals.Min min1
    "Reset setpoint should not be higher than the maximum setpoint"
    annotation (Placement(transformation(extent={{28,-52},{48,-32}})));
  Buildings.Controls.OBC.CDL.Reals.Max maxInp
    "Reset setpoint should not be lower than the minimum setpoint"
    annotation (Placement(transformation(extent={{68,-52},{88,-32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minSetCon(k=TZonSetNominal)
    "Minimum setpoint constant"
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
equation
  connect(uniDel.y,add1. u1)
    annotation (Line(points={{-64,-16},{-28,-16}},
      color={0,0,127}));
  connect(combiTimeTable1.y[1], add1.u2) annotation (Line(points={{-65,-56},{-36,
          -56},{-36,-28},{-28,-28}}, color={0,0,127}));
  connect(maxSetCon.y,min1. u2)
    annotation (Line(points={{10,-72},{18,-72},{18,-48},{26,-48}},
      color={0,0,127}));
  connect(add1.y, min1.u1) annotation (Line(points={{-4,-22},{14,-22},{14,-38},
          {26,-38},{26,-36}}, color={0,0,127}));
  connect(minSetCon.y, maxInp.u2)
    annotation (Line(points={{52,-80},{66,-80},{66,-48}}, color={0,0,127}));
  connect(min1.y, maxInp.u1) annotation (Line(points={{50,-42},{58,-42},{58,-36},
          {66,-36}}, color={0,0,127}));
  connect(maxInp.y, uniDel.u) annotation (Line(points={{90,-42},{94,-42},{94,
          -40},{104,-40},{104,24},{-88,24},{-88,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testUnitDelay;
