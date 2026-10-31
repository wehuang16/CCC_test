within CCC_test.trim_and_respond;
model TrimAndRespondVersionMBL3
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable timTab(
    table=[0,1,0,0,-1,0; 3,1,0,-1,-1,0; 6,1,0,-1,0,1; 9,0,-1,-1,0,1; 12,0,-1,0,1,
        0; 15,0,-1,0,1,-1; 18,-1,0,0,1,0; 21,-1,1,1,0,0; 24,1,0,0,-1,0],
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    timeScale=3600)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys[5](each uLow=-0.5, each uHigh
      =0.5)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput inside_list[5]
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{-330,-104},{-290,-64}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput addRemoveRequest[5]
    annotation (Placement(transformation(extent={{100,30},{140,70}}),
        iconTransformation(extent={{-330,-104},{-290,-64}})));
equation
  connect(timTab.y, hys.u) annotation (Line(points={{-78,0},{-2,0}},
                   color={0,0,127}));
  connect(hys.y, inside_list) annotation (Line(points={{22,0},{120,0}},
                      color={255,0,255}));
  connect(timTab.y, addRemoveRequest) annotation (Line(points={{-78,0},{-40,0},
          {-40,50},{120,50}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TrimAndRespondVersionMBL3;
