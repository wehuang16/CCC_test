within CCC_test.Example3;
model testAnyBlock
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp ram(
    height=Modelica.Constants.pi,                   duration=86400, startTime=0)
    annotation (Placement(transformation(extent={{0,58},{20,78}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con[2](k={2,1})
    annotation (Placement(transformation(extent={{-76,-8},{-56,12}})));
  Modelica.Blocks.Tables.CombiTable2Ds systemModePre(table=[-999,-1,0,1; 0,0,0,
        0; 1,5,0,1; 2,2,2,4; 3,8,6,6; 4,7,0,3], extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    "0=do nothing; 1=chiller serves load; 2=chiller charge tes; 3= tes serves load; 4=hybrid charge; 5=hybrid serves"
    annotation (Placement(transformation(extent={{-16,-60},{4,-40}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID
    annotation (Placement(transformation(extent={{-84,-66},{-64,-46}})));
equation
  connect(con[1].y, systemModePre.u1) annotation (Line(points={{-54,2},{-26,2},
          {-26,-44},{-18,-44}}, color={0,0,127}));
  connect(con[2].y, systemModePre.u2) annotation (Line(points={{-54,2},{-26,2},
          {-26,-56},{-18,-56}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
    StartTime=0,
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
