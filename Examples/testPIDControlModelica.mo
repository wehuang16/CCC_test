within CCC_test.Examples;
model testPIDControlModelica

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Blocks.Sources.Constant const1(k=5)
    annotation (Placement(transformation(extent={{-98,16},{-78,36}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=1.25,
    duration=60,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{2,66},{22,86}})));
  Modelica.Blocks.Sources.CombiTimeTable
                                   combiTimeTable(
    table=[0,4; 21600,4; 21600,5; 43200,5; 43200,7; 64800,7; 64800,5; 86400,5],

    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-28,-52},{-8,-32}})));
  Modelica.Blocks.Sources.Constant const2(k=5)
    annotation (Placement(transformation(extent={{-74,-22},{-54,-2}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    strict=true)
    annotation (Placement(transformation(extent={{-10,14},{10,34}})));
equation
  connect(const1.y, PID.u_s) annotation (Line(points={{-77,26},{-20,26},{-20,24},
          {-12,24}}, color={0,0,127}));
  connect(combiTimeTable.y[1], PID.u_m)
    annotation (Line(points={{-7,-42},{0,-42},{0,12}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPIDControlModelica;
