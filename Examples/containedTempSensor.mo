within CCC_test.Examples;
model containedTempSensor

      replaceable package Medium1 = Buildings.Media.Water "Medium 1 in the component";
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-112,16},{-92,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{92,16},{112,36}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuWaterSupply(redeclare
      package Medium = Medium1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-8,24})));
equation
  connect(port_a1, tempFcuWaterSupply.port_a) annotation (Line(points={{-102,26},
          {-100,26},{-100,24},{-18,24}}, color={0,127,255}));
  connect(tempFcuWaterSupply.port_b, port_b1) annotation (Line(points={{2,24},{88,
          24},{88,26},{102,26}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end containedTempSensor;
