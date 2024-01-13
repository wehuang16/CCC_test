within CCC_test.Examples;
model FanCoilUnitPidNoMoverEffectivenessSimple
    replaceable package Medium1 = Buildings.Media.Water "Medium 1 in the component";
      replaceable package Medium2 = Buildings.Media.Air "Medium 2 in the component";
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  replaceable parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.126
    "Nominal mass flow rate for Medium 1";
  replaceable parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=0.126
    "Nominal mass flow rate for Medium 2";
  //replaceable parameter Modelica.Units.SI.Temperature T_a1_nominal=273.15+20
    //"Nominal temperature at port a1";
  //replaceable parameter Modelica.Units.SI.Temperature T_a2_nominal=273.15+20
    //"Nominal temperature at port a2";
  //replaceable parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=500
    //"Nominal heat flow rate (positive for heat transfer from 1 to 2)";
  //replaceable parameter Modelica.Units.SI.Temperature zone_temp_setpoint=273.15+20
    //"Zone air temperature setpoint";
          replaceable parameter Modelica.Units.SI.Pressure dp1_nominal
    "Nominal pressure drop for Medium 1";

  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuAirSupply(redeclare package
      Medium = Medium2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,-28})));

  CCC.Fluid.HeatExchangers.VariableEffectiveness hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=dp1_nominal,
    dp2_nominal=0)
    annotation (Placement(transformation(extent={{-8,-4},{12,16}})));

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
        origin={-80,28})));
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
  Modelica.Blocks.Sources.Constant const6(k=0.8)
    annotation (Placement(transformation(extent={{-48,42},{-28,62}})));
equation
  connect(port_a1, port_a1)
    annotation (Line(points={{-102,44},{-102,44}}, color={0,127,255}));
  connect(hex.port_b1, tempFcuWaterReturn.port_a) annotation (Line(points={{12,12},
          {34,12},{34,38},{40,38}}, color={0,127,255}));
  connect(hex.port_b2, tempFcuAirReturn.port_a) annotation (Line(points={{-8,0},{
          -48,0},{-48,-14},{-54,-14}},   color={0,127,255}));
  connect(tempFcuWaterSupply.T, TempWaterSupply) annotation (Line(points={{-80,39},
          {-80,70},{-92,70},{-92,100},{-64,100},{-64,96},{-50,96},{-50,110}},
                                        color={0,0,127}));
  connect(tempFcuWaterReturn.T, TempWaterReturn) annotation (Line(points={{50,49},
          {50,96},{58,96},{58,110}}, color={0,0,127}));
  connect(tempFcuAirReturn.T, TempAirReturn) annotation (Line(points={{-64,-25},
          {-64,-96},{-54,-96},{-54,-110}}, color={0,0,127}));
  connect(tempFcuAirSupply.T, TempAirSupply) annotation (Line(points={{74,-39},
          {74,-96},{36,-96},{36,-110}},color={0,0,127}));
  connect(tempFcuWaterSupply.port_a, port_a1) annotation (Line(points={{-90,28},
          {-102,28},{-102,44}}, color={0,127,255}));
  connect(tempFcuAirSupply.port_a, port_a2) annotation (Line(points={{84,-28},{
          102,-28},{102,-52}}, color={0,127,255}));
  connect(tempFcuWaterReturn.port_b, port_b1) annotation (Line(points={{60,38},
          {86,38},{86,44},{102,44}}, color={0,127,255}));
  connect(tempFcuAirReturn.port_b, port_b2) annotation (Line(points={{-74,-14},
          {-102,-14},{-102,-50}}, color={0,127,255}));
  connect(tempFcuWaterSupply.port_b, hex.port_a1) annotation (Line(points={{-70,28},
          {-14,28},{-14,12},{-8,12}},     color={0,127,255}));
  connect(hex.port_a2, tempFcuAirSupply.port_b) annotation (Line(points={{12,0},{
          58,0},{58,-28},{64,-28}},   color={0,127,255}));
  connect(const6.y, hex.eps) annotation (Line(points={{-27,52},{-24,52},{-24,7.1},
          {-10,7.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnitPidNoMoverEffectivenessSimple;
