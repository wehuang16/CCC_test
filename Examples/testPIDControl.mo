within CCC_test.Examples;
model testPIDControl

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Blocks.Sources.Constant const1(k=5)
    annotation (Placement(transformation(extent={{-84,22},{-64,42}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=1.25,
    duration=60,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{2,66},{22,86}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Blocks.Sources.Constant const2(k=4)
    annotation (Placement(transformation(extent={{-32,-54},{-12,-34}})));
equation
  connect(conPID.u_m, const2.y) annotation (Line(points={{-20,18},{-20,-30},{
          -11,-30},{-11,-44}}, color={0,0,127}));
  connect(const1.y, conPID.u_s)
    annotation (Line(points={{-63,32},{-32,32},{-32,30}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPIDControl;
