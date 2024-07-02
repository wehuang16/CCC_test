within CCC_test.HIL_testing;
model TestTrimAndRespond
  TrimAndRespond
    staPreSetRes(
    final iniSet=120,
    final minSet=45,
    final maxSet=250,
    final delTim=0,
    final samplePeriod=180,
    final numIgnReq=0,
    final triAmo=-12,
    final resAmo=25,
    final maxRes=32)
    "Static pressure setpoint reset using trim and respond logic"
    annotation (Placement(transformation(extent={{-16,22},{4,42}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-86,34},{-66,54}})));
  Modelica.Blocks.Sources.IntegerStep integerStep(startTime=3600)
    annotation (Placement(transformation(extent={{-64,-6},{-44,14}})));
equation
  connect(booleanConstant.y, staPreSetRes.uDevSta) annotation (Line(points={{
          -65,44},{-28,44},{-28,40},{-18,40}}, color={255,0,255}));
  connect(integerStep.y, staPreSetRes.numOfReq) annotation (Line(points={{-43,4},
          {-26,4},{-26,24},{-18,24}}, color={255,127,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=7200,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestTrimAndRespond;
