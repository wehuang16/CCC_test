within CCC_test.cdl;
model testBlock
  trim_and_respond_controller_block trim_and_respond_controller_block1
    annotation (Placement(transformation(extent={{-2,-2},{18,18}})));
  data_point_block data_point_block1
    annotation (Placement(transformation(extent={{50,0},{70,20}})));
equation
  connect(trim_and_respond_controller_block1.setpointCommand, data_point_block1.setpointCommand)
    annotation (Line(points={{20,8},{40,8},{40,10},{48,10}}, color={0,0,127}));
  connect(data_point_block1.setpoint, trim_and_respond_controller_block1.setpointCurrentValue)
    annotation (Line(points={{72,10},{82,10},{82,-38},{-4,-38},{-4,8}}, color={
          0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testBlock;
