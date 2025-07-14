within CCC_test.Example2;
model testHeatPumpCopBlock
  CCC.Fluid.Plants.BaseClasses.CalculateHeatPumpCop calculateHeatPumpCop
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-88,28},{-68,48}})));
  Modelica.Blocks.Sources.Constant const1(k=5)
    annotation (Placement(transformation(extent={{-78,-20},{-58,0}})));
  Modelica.Blocks.Sources.Constant const2(k=5)
    annotation (Placement(transformation(extent={{-58,-80},{-38,-60}})));
equation
  connect(const.y, calculateHeatPumpCop.outside_air_temperature) annotation (
      Line(points={{-67,38},{-6,38},{-6,4.6},{4,4.6}}, color={0,0,127}));
  connect(const1.y, calculateHeatPumpCop.supply_water_temperature) annotation (
      Line(points={{-57,-10},{-6,-10},{-6,-1},{4,-1}}, color={0,0,127}));
  connect(const2.y, calculateHeatPumpCop.compressor_speed)
    annotation (Line(points={{-37,-70},{4,-70},{4,-7}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testHeatPumpCopBlock;
