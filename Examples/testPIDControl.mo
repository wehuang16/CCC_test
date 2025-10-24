within CCC_test.Examples;
model testPIDControl

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Blocks.Sources.Constant const1(k=5)
    annotation (Placement(transformation(extent={{-130,14},{-110,34}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=1.25,
    duration=60,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{2,66},{22,86}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Blocks.Sources.Pulse    pulse(
    amplitude=10,
    period=21600,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-32,-54},{-12,-34}})));
  Modelica.Blocks.Sources.Constant const2(k=5)
    annotation (Placement(transformation(extent={{-74,-22},{-54,-2}})));
equation
  connect(const1.y, conPID.u_s) annotation (Line(points={{-109,24},{-42,24},{-42,
          30},{-32,30}}, color={0,0,127}));
  connect(pulse.y, conPID.u_m) annotation (Line(points={{-11,-44},{0,-44},{0,18},
          {-20,18}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPIDControl;
