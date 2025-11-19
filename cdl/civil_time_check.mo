within CCC_test.cdl;
model civil_time_check
  Buildings.Controls.OBC.CDL.Reals.Sources.CivilTime civTim
    annotation (Placement(transformation(extent={{-62,4},{-42,24}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.CalendarTime calTim(zerTim=Buildings.Controls.OBC.CDL.Types.ZeroTime.NY2050)
    annotation (Placement(transformation(extent={{-44,62},{-24,82}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end civil_time_check;
