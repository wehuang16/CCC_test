within CCC_test.Examples;
model cdlExample1
  Buildings.Controls.OBC.CDL.Discrete.UnitDelay uniDel(final samplePeriod=180, y_start=
        210)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-106,14},{-86,34}})));
  Buildings.Controls.OBC.CDL.Reals.Add add1
    "Increase setpoint by amount of value defined from reset logic"
    annotation (Placement(transformation(extent={{-46,8},{-26,28}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput myOutput1 annotation (
      Placement(transformation(extent={{110,-10},{150,30}}), iconTransformation(
          extent={{100,-20},{140,20}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    table=[0,0.15; 10800,0.25; 21600,-0.1; 32400,0.05; 43200,0; 54000,-0.15;
        64800,0.2; 75600,-0.05; 86400,0.1],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-162,-6},{-142,14}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter valueToIncrease(k=1)
    annotation (Placement(transformation(extent={{-104,-30},{-72,2}})));
  Buildings.Controls.OBC.CDL.Reals.Limiter lim(uMax=270, uMin=210)
    annotation (Placement(transformation(extent={{36,6},{56,26}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(
    table=[0,0; 10800,0; 21600,3; 22500,0; 32400,0; 43200,3; 43260,0; 54000,0;
        64795,3; 65100,0; 75600,0; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-180,-58},{-160,-38}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse pul(
    amplitude=3,
    width=900/10800,
    period=10800,
    shift=-60)
    annotation (Placement(transformation(extent={{-144,-84},{-124,-64}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse pul1(
    amplitude=3,
    width=900/10800,
    period=10800,
    shift=0)
    annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse pul2(
    amplitude=3,
    width=300/10800,
    period=10800,
    shift=-60)
    annotation (Placement(transformation(extent={{-44,-84},{-24,-64}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler   sam(final samplePeriod=180)
    "Output the input signal with a unit delay"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-116,-34})));
equation
  connect(uniDel.y, add1.u1)
    annotation (Line(points={{-84,24},{-48,24}}, color={0,0,127}));
  connect(valueToIncrease.y, add1.u2) annotation (Line(points={{-68.8,-14},{-56,
          -14},{-56,12},{-48,12}}, color={0,0,127}));
  connect(add1.y, lim.u) annotation (Line(points={{-24,18},{26,18},{26,16},{34,
          16}}, color={0,0,127}));
  connect(uniDel.u, lim.y) annotation (Line(points={{-108,24},{-112,24},{-112,
          46},{58,46},{58,16}}, color={0,0,127}));
  connect(lim.y, myOutput1) annotation (Line(points={{58,16},{58,24},{104,24},{
          104,10},{130,10}}, color={0,0,127}));
  connect(valueToIncrease.u, sam.y) annotation (Line(points={{-107.2,-14},{-116,
          -14},{-116,-22}}, color={0,0,127}));
  connect(sam.u, pul2.y) annotation (Line(points={{-116,-46},{-116,-58},{-12,
          -58},{-12,-74},{-22,-74}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end cdlExample1;
