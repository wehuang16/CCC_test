within CCC_test.Examples;
model testOurdoorDamper
  hil_flexlab_model.Test1.Plants1.Controls.OutdoorDamperPositionBlock
                                              outdoorDamperPositionBlock
    annotation (Placement(transformation(extent={{-2,32},{18,52}})));
  Modelica.Blocks.Sources.Ramp                      freStaSetPoi2(duration=
        43200, startTime=21600)
              "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{-56,36},{-36,56}})));
  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol(trueHoldDuration=
        600)              "10 min on/off delay"
    annotation (Placement(transformation(extent={{56,-24},{76,-4}})));
protected
  Modelica.Blocks.Logical.Hysteresis          hysteresis(final uLow=-1, final
      uHigh=0)
    "Outdoor air temperature hysteresis for both fixed and differential dry bulb temperature cutoff conditions"
    annotation (Placement(transformation(extent={{-24,-24},{-4,-4}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical nor"
    annotation (Placement(transformation(extent={{18,-24},{38,-4}})));
equation
  connect(freStaSetPoi2.y, outdoorDamperPositionBlock.ReturnDamperPosition)
    annotation (Line(points={{-35,46},{-14,46},{-14,42},{-4,42}}, color={0,0,
          127}));
  connect(hysteresis.y, not1.u)
    annotation (Line(points={{-3,-14},{16,-14}}, color={255,0,255}));
  connect(not1.y, truFalHol.u)
    annotation (Line(points={{40,-14},{54,-14}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testOurdoorDamper;
