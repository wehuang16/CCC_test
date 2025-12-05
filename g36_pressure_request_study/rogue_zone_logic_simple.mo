within CCC_test.g36_pressure_request_study;
model rogue_zone_logic_simple
  Buildings.Controls.OBC.CDL.Interfaces.RealInput vav_damper_position
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput rogue_zone_flag
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=0.85, uHigh=0.95)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAve(delta=86400)
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(uLow=0.65, uHigh=0.7)
    annotation (Placement(transformation(extent={{62,40},{82,60}})));
equation
  connect(vav_damper_position, hys.u)
    annotation (Line(points={{-120,0},{-80,0}}, color={0,0,127}));
  connect(hys.y, booToRea.u) annotation (Line(points={{-56,0},{-44,0},{-44,40},
          {-32,40}}, color={255,0,255}));
  connect(booToRea.y, movAve.u) annotation (Line(points={{-8,40},{12,40},{12,60},
          {28,60}}, color={0,0,127}));
  connect(movAve.y, hys1.u) annotation (Line(points={{52,60},{58,60},{58,50},{
          60,50}}, color={0,0,127}));
  connect(hys1.y, rogue_zone_flag) annotation (Line(points={{84,50},{94,50},{94,
          0},{120,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end rogue_zone_logic_simple;
