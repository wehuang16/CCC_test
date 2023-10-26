within CCC_test.Baseclasses;
model HeatCapacitySensor
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  Modelica.Fluid.Interfaces.FluidPort_a port_a
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.2,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-14,34},{6,54}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium
      = MediumWater, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-54,4},{-34,24}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumWater, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{28,-6},{48,14}})));
equation
  connect(port_a, senTem1.port_a) annotation (Line(points={{-102,0},{-78,0},{
          -78,14},{-54,14}}, color={0,127,255}));
  connect(senTem1.port_b, hea.port_a) annotation (Line(points={{-34,14},{-24,14},
          {-24,44},{-14,44}}, color={0,127,255}));
  connect(hea.port_b, senTem.port_a) annotation (Line(points={{6,44},{18,44},{
          18,4},{28,4}}, color={0,127,255}));
  connect(senTem.port_b, port_b) annotation (Line(points={{48,4},{76,4},{76,0},
          {104,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatCapacitySensor;
