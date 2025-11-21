within CCC_test.g36_pressure_request_study;
model rogue_zone_logic_simple
  Buildings.Controls.OBC.CDL.Interfaces.RealInput vav_damper_position
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput rogue_zone_flag
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=0.85, uHigh=0.95)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=3600)
    annotation (Placement(transformation(extent={{-36,-12},{-16,8}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(delayTime=172800)
    annotation (Placement(transformation(extent={{26,-48},{46,-28}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-20,-52},{0,-32}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{62,-46},{82,-26}})));
equation
  connect(vav_damper_position, hys.u)
    annotation (Line(points={{-120,0},{-80,0}}, color={0,0,127}));
  connect(hys.y, truDel.u) annotation (Line(points={{-56,0},{-46,0},{-46,-2},{
          -38,-2}}, color={255,0,255}));
  connect(truDel.y, not1.u) annotation (Line(points={{-14,-2},{-6,-2},{-6,-28},
          {-32,-28},{-32,-42},{-22,-42}}, color={255,0,255}));
  connect(not1.y, truDel1.u) annotation (Line(points={{2,-42},{14,-42},{14,-38},
          {24,-38}}, color={255,0,255}));
  connect(truDel1.y, not2.u)
    annotation (Line(points={{48,-38},{48,-36},{60,-36}}, color={255,0,255}));
  connect(not2.y, rogue_zone_flag) annotation (Line(points={{84,-36},{94,-36},{
          94,0},{120,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end rogue_zone_logic_simple;
