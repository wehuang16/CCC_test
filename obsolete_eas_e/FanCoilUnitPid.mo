within CCC_test.obsolete_eas_e;
model FanCoilUnitPid
    replaceable package Medium1 = Buildings.Media.Water "Medium 1 in the component";
      replaceable package Medium2 = Buildings.Media.Air "Medium 2 in the component";
  replaceable parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.126
    "Nominal mass flow rate for Medium 1";
  replaceable parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=0.126
    "Nominal mass flow rate for Medium 2";
  replaceable parameter Modelica.Units.SI.Temperature T_a1_nominal=273.15+20
    "Nominal temperature at port a1";
  replaceable parameter Modelica.Units.SI.Temperature T_a2_nominal=273.15+20
    "Nominal temperature at port a2";
  replaceable parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=500
    "Nominal heat flow rate (positive for heat transfer from 1 to 2)";
  replaceable parameter Modelica.Units.SI.Temperature zone_temp_setpoint=273.15+20
    "Zone air temperature setpoint";
          replaceable parameter Modelica.Units.SI.Pressure dp1_nominal
    "Nominal pressure drop for Medium 1";
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuAirSupply(redeclare package
      Medium = Medium2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,-28})));

  Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=dp1_nominal,
    dp2_nominal=0,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=Q_flow_nominal,
    T_a1_nominal=T_a1_nominal,
    T_a2_nominal=T_a2_nominal)
    annotation (Placement(transformation(extent={{-8,-6},{12,14}})));

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
        origin={-80,26})));
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
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-58,70},{-38,90}})));
  Modelica.Blocks.Sources.Constant const4(k=5)
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Math.Gain        gain(k=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-18,70},{2,90}})));
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
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-48,16},{-28,36}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium =
        Medium2, m_flow_nominal=m2_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-14})));
  Modelica.Blocks.Sources.Constant const1(k=6)
    annotation (Placement(transformation(extent={{-72,38},{-52,58}})));
equation
  connect(port_a1, port_a1)
    annotation (Line(points={{-102,44},{-102,44}}, color={0,127,255}));
  connect(hex.port_b1, tempFcuWaterReturn.port_a) annotation (Line(points={{12,10},
          {34,10},{34,38},{40,38}}, color={0,127,255}));
  connect(hex.port_b2, tempFcuAirReturn.port_a) annotation (Line(points={{-8,-2},
          {-48,-2},{-48,-14},{-54,-14}}, color={0,127,255}));
  connect(tempFcuWaterSupply.T, TempWaterSupply) annotation (Line(points={{-80,37},
          {-80,70},{-92,70},{-92,100},{-64,100},{-64,96},{-50,96},{-50,110}},
                                        color={0,0,127}));
  connect(tempFcuWaterReturn.T, TempWaterReturn) annotation (Line(points={{50,49},
          {50,96},{58,96},{58,110}}, color={0,0,127}));
  connect(tempFcuAirReturn.T, TempAirReturn) annotation (Line(points={{-64,-25},
          {-64,-96},{-54,-96},{-54,-110}}, color={0,0,127}));
  connect(tempFcuAirSupply.T, TempAirSupply) annotation (Line(points={{74,-39},
          {74,-96},{36,-96},{36,-110}},color={0,0,127}));
  connect(const4.y, conPID.u_s) annotation (Line(points={{-67,84},{-64,84},{-64,
          80},{-60,80}}, color={0,0,127}));
  connect(tempFcuWaterSupply.T, add.u1) annotation (Line(points={{-80,37},{-80,
          70},{-92,70},{-92,100},{-64,100},{-64,96},{-30,96},{-30,56},{-12,56}},
                                                color={0,0,127}));
  connect(tempFcuWaterReturn.T, add.u2) annotation (Line(points={{50,49},{18,49},
          {18,34},{-12,34},{-12,44}}, color={0,0,127}));
  connect(conPID1.y, gain1.u)
    annotation (Line(points={{23,-64},{46,-64}}, color={0,0,127}));
  connect(zonAirSet.y, conPID1.u_s)
    annotation (Line(points={{-29,-64},{0,-64}}, color={0,0,127}));
  connect(zonAirTem, conPID1.u_m) annotation (Line(points={{-120,-88},{-56,-88},
          {-56,-90},{12,-90},{12,-76}}, color={0,0,127}));
  connect(conPID.y, gain.u)
    annotation (Line(points={{-37,80},{-20,80}}, color={0,0,127}));
  connect(tempFcuWaterSupply.port_a, port_a1) annotation (Line(points={{-90,26},
          {-102,26},{-102,44}}, color={0,127,255}));
  connect(tempFcuAirSupply.port_a, port_a2) annotation (Line(points={{84,-28},{
          102,-28},{102,-52}}, color={0,127,255}));
  connect(gain.y, fan.m_flow_in) annotation (Line(points={{3,80},{6,80},{6,64},
          {-38,64},{-38,38}},
                            color={0,0,127}));
  connect(fan1.port_a, tempFcuAirReturn.port_b)
    annotation (Line(points={{-80,-14},{-74,-14}}, color={0,127,255}));
  connect(fan1.port_b, port_b2) annotation (Line(points={{-100,-14},{-104,-14},
          {-104,-50},{-102,-50}}, color={0,127,255}));
  connect(tempFcuAirSupply.port_b, hex.port_a2) annotation (Line(points={{64,
          -28},{18,-28},{18,-2},{12,-2}}, color={0,127,255}));
  connect(gain1.y, fan1.m_flow_in) annotation (Line(points={{69,-64},{70,-64},{
          70,-36},{-90,-36},{-90,-26}}, color={0,0,127}));
  connect(tempFcuWaterSupply.port_b, fan.port_a)
    annotation (Line(points={{-70,26},{-48,26}}, color={0,127,255}));
  connect(fan.port_b, hex.port_a1) annotation (Line(points={{-28,26},{-14,26},{
          -14,10},{-8,10}}, color={0,127,255}));
  connect(tempFcuWaterReturn.port_b, port_b1) annotation (Line(points={{60,38},
          {86,38},{86,44},{102,44}}, color={0,127,255}));
  connect(const1.y, conPID.u_m)
    annotation (Line(points={{-51,48},{-48,48},{-48,68}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnitPid;
