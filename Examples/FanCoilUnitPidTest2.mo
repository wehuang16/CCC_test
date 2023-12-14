within CCC_test.Examples;
model FanCoilUnitPidTest2
    replaceable package Medium1 = Buildings.Media.Water "Medium 1 in the component";
      replaceable package Medium2 = Buildings.Media.Air "Medium 2 in the component";
  replaceable parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.126
    "Nominal mass flow rate for Medium 1";
  replaceable parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=0.126
    "Nominal mass flow rate for Medium 2";
  replaceable parameter Modelica.Units.SI.Temperature T_a1_nominal=273.15+55
    "Nominal temperature at port a1";
  replaceable parameter Modelica.Units.SI.Temperature T_a2_nominal=273.15+20
    "Nominal temperature at port a2";
  replaceable parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=500
    "Nominal heat flow rate (positive for heat transfer from 1 to 2)";
  replaceable parameter Modelica.Units.SI.Temperature zone_temp_setpoint=273.15+20
    "Zone air temperature setpoint";
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

  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=10,
    dp2_nominal=10,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_a1_nominal,
    T_a2_nominal=T_a2_nominal)
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
  Modelica.Blocks.Interfaces.RealInput zonAirTem
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
  Modelica.Blocks.Sources.Constant const4(k=5)
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica.Blocks.Math.Gain        gain1(k=m2_flow_nominal)
    annotation (Placement(transformation(extent={{48,-74},{68,-54}})));
  Buildings.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{2,-74},{22,-54}})));
  Modelica.Blocks.Sources.Constant zonAirSet(k=zone_temp_setpoint)
    annotation (Placement(transformation(extent={{-50,-74},{-30,-54}})));
  Modelica.Blocks.Sources.Constant const2(k=0.136*0.2)
    annotation (Placement(transformation(extent={{-136,62},{-116,82}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-52,76},{-32,96}})));
  Modelica.Blocks.Math.Gain        gain(k=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-12,74},{8,94}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-14,44},{6,64}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 45)
    annotation (Placement(transformation(extent={{-146,28},{-126,48}})));
  Modelica.Blocks.Sources.Constant const3(k=273.15 + 43)
    annotation (Placement(transformation(extent={{-148,-8},{-128,12}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = Medium1,
    use_T_in=false,
    T=316.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={98,19})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpFcuWaterSupply1(
    redeclare package Medium = Medium1,
    m_flow_nominal=0.126,
    nominalValuesDefineDefaultPressureCurve=true) "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={136,20})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuWaterSupplyyttu(redeclare
      package Medium = Medium1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={170,20})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = Medium1,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{238,2},{218,20}})));
  Modelica.Blocks.Sources.Constant const5(k=0.05)
    annotation (Placement(transformation(extent={{120,58},{140,78}})));
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
  connect(tempFcuWaterSupply.T, TempWaterSupply) annotation (Line(points={{-34,37},
          {-34,96},{-50,96},{-50,110}}, color={0,0,127}));
  connect(tempFcuWaterReturn.T, TempWaterReturn) annotation (Line(points={{50,49},
          {50,96},{58,96},{58,110}}, color={0,0,127}));
  connect(tempFcuAirReturn.T, TempAirReturn) annotation (Line(points={{-64,-25},
          {-64,-96},{-54,-96},{-54,-110}}, color={0,0,127}));
  connect(tempFcuAirSupply.T, TempAirSupply) annotation (Line(points={{38,-37},{
          38,-96},{36,-96},{36,-110}}, color={0,0,127}));
  connect(conPID1.y, gain1.u)
    annotation (Line(points={{23,-64},{46,-64}}, color={0,0,127}));
  connect(zonAirSet.y, conPID1.u_s)
    annotation (Line(points={{-29,-64},{0,-64}}, color={0,0,127}));
  connect(zonAirTem, conPID1.u_m) annotation (Line(points={{-120,-88},{-56,-88},
          {-56,-90},{12,-90},{12,-76}}, color={0,0,127}));
  connect(gain1.y, fanFcuAirSupply.m_flow_in)
    annotation (Line(points={{69,-64},{72,-64},{72,-32}}, color={0,0,127}));
  connect(const2.y, pumpFcuWaterSupply.m_flow_in) annotation (Line(points={{-115,
          72},{-92,72},{-92,66},{-54,66},{-54,60},{-52,60},{-52,38},{-68,38}},
        color={0,0,127}));
  connect(conPID.y, gain.u) annotation (Line(points={{-31,86},{-22,86},{-22,84},
          {-14,84}}, color={0,0,127}));
  connect(boundary2.ports[1], pumpFcuWaterSupply1.port_a) annotation (Line(
        points={{108,19},{117,19},{117,20},{126,20}}, color={0,127,255}));
  connect(pumpFcuWaterSupply1.port_b, tempFcuWaterSupplyyttu.port_b)
    annotation (Line(points={{146,20},{180,20}}, color={0,127,255}));
  connect(tempFcuWaterSupplyyttu.port_b, boundary4.ports[1]) annotation (Line(
        points={{180,20},{212,20},{212,11},{218,11}}, color={0,127,255}));
  connect(const5.y, pumpFcuWaterSupply1.m_flow_in) annotation (Line(points={{141,
          68},{146,68},{146,40},{136,40},{136,32}}, color={0,0,127}));
  connect(tempFcuWaterReturn.T, add.u2) annotation (Line(points={{50,49},{50,52},
          {22,52},{22,44},{8,44},{8,42},{-24,42},{-24,48},{-16,48}}, color={0,0,
          127}));
  connect(tempFcuWaterSupply.T, add.u1) annotation (Line(points={{-34,37},{-34,
          40},{-26,40},{-26,60},{-16,60}}, color={0,0,127}));
  connect(const4.y, conPID.u_s)
    annotation (Line(points={{-67,84},{-67,86},{-54,86}}, color={0,0,127}));
  connect(conPID.u_m, add.y) annotation (Line(points={{-42,74},{-42,66},{-24,66},
          {-24,68},{12,68},{12,54},{7,54}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnitPidTest2;
