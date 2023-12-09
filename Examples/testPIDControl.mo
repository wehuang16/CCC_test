within CCC_test.Examples;
model testPIDControl
  Modelica.Blocks.Sources.Constant const1(k=100)
    annotation (Placement(transformation(extent={{-74,22},{-54,42}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=30,
    duration=4320,
    offset=90,
    startTime=2160)
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=300,
    yMin=0.1,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-14,6},{6,26}})));
equation
  connect(const1.y, conPID.u_s) annotation (Line(points={{-53,32},{-26,32},{-26,
          16},{-16,16}}, color={0,0,127}));
  connect(ramp.y, conPID.u_m)
    annotation (Line(points={{-45,0},{-4,0},{-4,4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPIDControl;
