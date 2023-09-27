within CCC_test.Examples;
model test_FMU_export_withInputOutput
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  Modelica.Blocks.Interfaces.RealInput T_in
    annotation (Placement(transformation(extent={{-140,2},{-100,42}})));
  Modelica.Blocks.Interfaces.RealOutput T_out
    annotation (Placement(transformation(extent={{100,16},{120,36}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-28,8},{-8,28}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-80,-24},{-60,-4}})));
equation
  connect(T_in, add.u1) annotation (Line(points={{-120,22},{-76,22},{-76,24},{
          -30,24}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-59,-14},{-46,-14},{-46,12},
          {-30,12}}, color={0,0,127}));
  connect(add.y, T_out) annotation (Line(points={{-7,18},{46,18},{46,26},{110,
          26}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=60));
end test_FMU_export_withInputOutput;
