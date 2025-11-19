within CCC_test.cdl;
model testSampleBlock
  Buildings.Controls.OBC.CDL.Discrete.Sampler sam(samplePeriod=735)
    annotation (Placement(transformation(extent={{-32,12},{-12,32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin(
    amplitude=50,
    freqHz=1/21600,
    offset=50)
    annotation (Placement(transformation(extent={{-74,14},{-54,34}})));
equation
  connect(sin.y, sam.u) annotation (Line(points={{-52,24},{-44,24},{-44,22},{
          -34,22}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testSampleBlock;
