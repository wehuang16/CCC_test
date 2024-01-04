within CCC_test.Baseclasses;
model FanCoilUnitEps
    replaceable package Medium1 = Buildings.Media.Water "Medium 1 in the component";
      replaceable package Medium2 = Buildings.Media.Air "Medium 2 in the component";
  replaceable parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.126
    "Nominal mass flow rate for Medium 1";
         replaceable parameter Modelica.Units.SI.Pressure dp1_nominal
    "Nominal pressure drop for Medium 1";
  replaceable parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=0.126
    "Nominal mass flow rate for Medium 2";
  replaceable parameter Modelica.Units.SI.Temperature T_a1_nominal=273.15+20
    "Nominal temperature at port a1";
  replaceable parameter Modelica.Units.SI.Temperature T_a2_nominal=273.15+20
    "Nominal temperature at port a2";
  replaceable parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=500
    "Nominal heat flow rate (positive for heat transfer from 1 to 2)";

  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuAirSupply(redeclare package
      Medium = Medium2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={38,-26})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpFcuWaterSupply(
    redeclare package Medium = Medium1,
    m_flow_nominal=m1_flow_nominal,
    nominalValuesDefineDefaultPressureCurve=true) "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-68,26})));

  ConstantEffectiveness                                  hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=dp1_nominal,
    dp2_nominal=0)
    annotation (Placement(transformation(extent={{-8,-6},{12,14}})));

  Buildings.Fluid.Movers.FlowControlled_m_flow fanFcuAirSupply(
    redeclare package Medium = Medium2,
    m_flow_nominal=m2_flow_nominal,
    nominalValuesDefineDefaultPressureCurve=true) "Fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={72,-20})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuWaterReturn(redeclare
      package Medium = Medium1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,38})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuWaterSupply(redeclare
      package Medium = Medium1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,26})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuAirReturn(redeclare package
      Medium = Medium2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,-14})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-112,34},{-92,54}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{92,34},{112,54}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{92,-62},{112,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium2)
    annotation (Placement(transformation(extent={{-112,-60},{-92,-40}})));
  Modelica.Blocks.Interfaces.RealInput WaterMassFlow
    annotation (Placement(transformation(extent={{-140,58},{-100,98}})));
  Modelica.Blocks.Interfaces.RealInput AirMassFlow
    annotation (Placement(transformation(extent={{-140,-108},{-100,-68}})));
  Modelica.Blocks.Interfaces.RealOutput TempAirReturn annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-54,-110})));
  Modelica.Blocks.Interfaces.RealOutput TempAirSupply annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={36,-110})));
  Modelica.Blocks.Interfaces.RealOutput TempWaterSupply annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,110})));
  Modelica.Blocks.Interfaces.RealOutput TempWaterReturn annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={58,110})));
  Modelica.Blocks.Interfaces.RealInput eps
    annotation (Placement(transformation(extent={{-140,-18},{-100,22}})));
equation
  connect(port_a1, port_a1)
    annotation (Line(points={{-102,44},{-102,44}}, color={0,127,255}));
  connect(port_a1, pumpFcuWaterSupply.port_a) annotation (Line(points={{-102,44},
          {-82,44},{-82,26},{-78,26}}, color={0,127,255}));
  connect(pumpFcuWaterSupply.port_b, tempFcuWaterSupply.port_a)
    annotation (Line(points={{-58,26},{-44,26}}, color={0,127,255}));
  connect(tempFcuWaterSupply.port_b, hex.port_a1) annotation (Line(points={{-24,
          26},{-14,26},{-14,10},{-8,10}}, color={0,127,255}));
  connect(hex.port_b1, tempFcuWaterReturn.port_a) annotation (Line(points={{12,10},
          {34,10},{34,38},{40,38}}, color={0,127,255}));
  connect(tempFcuWaterReturn.port_b, port_b1) annotation (Line(points={{60,38},{
          86,38},{86,44},{102,44}}, color={0,127,255}));
  connect(port_a2, fanFcuAirSupply.port_a) annotation (Line(points={{102,-52},{90,
          -52},{90,-20},{82,-20}}, color={0,127,255}));
  connect(fanFcuAirSupply.port_b, tempFcuAirSupply.port_a) annotation (Line(
        points={{62,-20},{56,-20},{56,-22},{48,-22},{48,-26}}, color={0,127,255}));
  connect(tempFcuAirSupply.port_b, hex.port_a2) annotation (Line(points={{28,-26},
          {22,-26},{22,-12},{12,-12},{12,-2}}, color={0,127,255}));
  connect(hex.port_b2, tempFcuAirReturn.port_a) annotation (Line(points={{-8,-2},
          {-48,-2},{-48,-14},{-54,-14}}, color={0,127,255}));
  connect(tempFcuAirReturn.port_b, port_b2) annotation (Line(points={{-74,-14},{
          -88,-14},{-88,-50},{-102,-50}}, color={0,127,255}));
  connect(AirMassFlow, fanFcuAirSupply.m_flow_in)
    annotation (Line(points={{-120,-88},{72,-88},{72,-32}}, color={0,0,127}));
  connect(tempFcuWaterSupply.T, TempWaterSupply) annotation (Line(points={{-34,37},
          {-34,96},{-50,96},{-50,110}}, color={0,0,127}));
  connect(tempFcuWaterReturn.T, TempWaterReturn) annotation (Line(points={{50,49},
          {50,96},{58,96},{58,110}}, color={0,0,127}));
  connect(tempFcuAirReturn.T, TempAirReturn) annotation (Line(points={{-64,-25},
          {-64,-96},{-54,-96},{-54,-110}}, color={0,0,127}));
  connect(tempFcuAirSupply.T, TempAirSupply) annotation (Line(points={{38,-37},{
          38,-96},{36,-96},{36,-110}}, color={0,0,127}));
  connect(WaterMassFlow, pumpFcuWaterSupply.m_flow_in) annotation (Line(points=
          {{-120,78},{-94,78},{-94,76},{-68,76},{-68,38}}, color={0,0,127}));
  connect(hex.eps, eps) annotation (Line(points={{-10,5.1},{-94,5.1},{-94,2},{
          -120,2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnitEps;
