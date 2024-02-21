within CCC_test.HIL_testing;
model testSetpointBlock

constant Integer numZon=3 "Total number of served VAV boxes";
    parameter Modelica.Units.SI.Temperature THeaOff=285.15
    "Heating setpoint during off";
  parameter Modelica.Units.SI.Temperature TCooOff=303.15
    "Cooling setpoint during off";
  hil_flexlab_model.Test1.BaseClasses1.ModeAndSetPoints                TZonSet[numZon](
    final TZonHeaOn=fill(273.15 + 21.1, numZon),
    final TZonHeaOff=fill(THeaOff, numZon),
    TZonCooOn=fill(273.15 + 23.3, numZon),
    final TZonCooOff=fill(TCooOff, numZon)) "Zone setpoint temperature"
    annotation (Placement(transformation(extent={{22,-6},{42,14}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep(final nout=
        numZon) "Replicate real input"
    annotation (Placement(transformation(extent={{-74,22},{-54,42}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(final nout=
        numZon)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-78,-12},{-58,8}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep1(final nout=
        numZon) "Replicate real input"
    annotation (Placement(transformation(extent={{-52,-44},{-32,-24}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-106,-50},{-86,-30}})));
  Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy=3600*{5,22})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-132,34},{-112,54}})));
equation
  connect(reaRep.y, TZonSet.tNexOcc) annotation (Line(points={{-52,32},{12,32},
          {12,13},{20,13}}, color={0,0,127}));
  connect(booRep.y, TZonSet.uOcc) annotation (Line(points={{-56,-2},{12,-2},{12,
          10.025},{20,10.025}}, color={255,0,255}));
  connect(reaRep1.y, TZonSet.TZon) annotation (Line(points={{-30,-34},{-22,-34},
          {-22,7},{20,7}}, color={0,0,127}));
  connect(const.y, reaRep1.u) annotation (Line(points={{-85,-40},{-64,-40},{-64,
          -34},{-54,-34}}, color={0,0,127}));
  connect(occSch.tNexNonOcc, reaRep.u) annotation (Line(points={{-111,44},{-84,
          44},{-84,32},{-76,32}}, color={0,0,127}));
  connect(occSch.occupied, booRep.u) annotation (Line(points={{-111,38},{-90,38},
          {-90,-2},{-80,-2}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testSetpointBlock;
