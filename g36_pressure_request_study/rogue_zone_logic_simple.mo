within CCC_test.g36_pressure_request_study;
model rogue_zone_logic_simple

parameter Modelica.Units.SI.Time startTime=2.00448e+07 "startTime of system";
  parameter Modelica.Units.SI.Time rogue_zone_time=86400 "Time to flag rogue zone";

  parameter Real fraction_active=0.7 "fraction active";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput vav_damper_position
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput rogue_zone_flag
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=0.85, uHigh=0.95)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAve(delta=rogue_zone_time)
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(uLow=fraction_active - 0.05,
      uHigh=fraction_active)
    annotation (Placement(transformation(extent={{62,40},{82,60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp ram(duration=rogue_zone_time,
      startTime=startTime)
    annotation (Placement(transformation(extent={{16,82},{36,102}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{62,74},{82,94}})));
equation
  connect(vav_damper_position, hys.u)
    annotation (Line(points={{-120,0},{-80,0}}, color={0,0,127}));
  connect(hys.y, booToRea.u) annotation (Line(points={{-56,0},{-44,0},{-44,40},
          {-32,40}}, color={255,0,255}));
  connect(booToRea.y, movAve.u) annotation (Line(points={{-8,40},{12,40},{12,60},
          {28,60}}, color={0,0,127}));
  connect(hys1.y, rogue_zone_flag) annotation (Line(points={{84,50},{94,50},{94,
          0},{120,0}}, color={255,0,255}));
  connect(ram.y, mul.u1) annotation (Line(points={{38,92},{50,92},{50,90},{60,90}},
        color={0,0,127}));
  connect(movAve.y, mul.u2) annotation (Line(points={{52,60},{58,60},{58,78},{60,
          78}}, color={0,0,127}));
  connect(mul.y, hys1.u) annotation (Line(points={{84,84},{72,84},{72,50},{60,50}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end rogue_zone_logic_simple;
