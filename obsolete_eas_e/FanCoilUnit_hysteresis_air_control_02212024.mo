within CCC_test.obsolete_eas_e;
model FanCoilUnit_hysteresis_air_control_02212024
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
  replaceable parameter Modelica.Units.SI.Temperature zone_temp_setpoint=273.15+21
    "Zone air temperature setpoint";
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
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-54,44},{-34,64}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_water annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={112,82})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_air annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={112,-82})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds_heating(table=[0.0,273.15
         + 0,273.15 + 10,273.15 + 20; 273.15 + 30,0.5731,0.5449,0.4522; 273.15
         + 50,0.595,0.5869,0.5731; 273.15 + 70,0.6042,0.6004,0.595],
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-122,-6},{-102,14}})));
  CCC.Controls.SetpointController_constantSetpoint setpointController(
    gain_value=m1_flow_nominal,
    setpoint=5,
    reverseActing=false,
    conPID(yMin=0.005))
    annotation (Placement(transformation(extent={{68,72},{88,92}})));
  CCC.Controls.SetpointController_constantSetpoint_reverseCapable setpointController1(
      gain_value=m2_flow_nominal, setpoint=zone_temp_setpoint)
    annotation (Placement(transformation(extent={{8,-80},{28,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput ModeCommandFcu
    "true for heating; false for cooling" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-120,-80})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-44,-94},{-24,-74}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-12,60},{8,80}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,74},{40,94}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=zone_temp_setpoint - 1,
      uHigh=zone_temp_setpoint + 1)
    annotation (Placement(transformation(extent={{124,8},{144,28}})));
  Modelica.Blocks.Logical.Not ModeCommand "true for heating; false for cooling"
    annotation (Placement(transformation(extent={{136,-30},{156,-10}})));
  FanCoilUnitDoubleHysteresis_old fanCoilUnitDoubleHysteresis(
      zone_temp_setpoint=zone_temp_setpoint)
    annotation (Placement(transformation(extent={{86,-116},{106,-96}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{120,-116},{140,-96}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{80,-180},{100,-160}})));
  Modelica.Blocks.Interfaces.RealInput TZon "Zone air temperature" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={44,-120})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds_cooling(table=[0.0,273.15
         + 20,273.15 + 25; 273.15 + 7,0.6,0.5; 273.15 + 15,0.7,0.6],
      extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-154,-44},{-134,-24}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-52,2},{-32,22}})));
equation
  connect(port_a1, port_a1)
    annotation (Line(points={{-102,44},{-102,44}}, color={0,127,255}));
  connect(hex.port_b1, tempFcuWaterReturn.port_a) annotation (Line(points={{12,12},
          {34,12},{34,38},{40,38}}, color={0,127,255}));
  connect(hex.port_b2, tempFcuAirReturn.port_a) annotation (Line(points={{-8,0},{
          -48,0},{-48,-14},{-54,-14}},   color={0,127,255}));
  connect(tempFcuWaterSupply.T, add.u1) annotation (Line(points={{-80,39},{-80,60},
          {-56,60}},                            color={0,0,127}));
  connect(tempFcuWaterReturn.T, add.u2) annotation (Line(points={{50,49},{50,52},
          {14,52},{14,40},{-56,40},{-56,48}},
                                      color={0,0,127}));
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
  connect(tempFcuWaterSupply.T, combiTable2Ds_heating.u1) annotation (Line(
        points={{-80,39},{-104,39},{-104,40},{-124,40},{-124,10}}, color={0,0,
          127}));
  connect(tempFcuAirSupply.T, combiTable2Ds_heating.u2) annotation (Line(points=
         {{74,-39},{-36,-39},{-36,-26},{-124,-26},{-124,-2}}, color={0,0,127}));
  connect(setpointController.command, m_flow_water) annotation (Line(points={{89,82.6},
          {100.5,82.6},{100.5,82},{112,82}},        color={0,0,127}));
  connect(not1.y, setpointController1.reverse) annotation (Line(points={{-23,-84},
          {-2,-84},{-2,-86},{6,-86},{6,-77.4}}, color={255,0,255}));
  connect(add.y, switch1.u1) annotation (Line(points={{-33,54},{-34,54},{-34,58},
          {-28,58},{-28,92},{18,92}}, color={0,0,127}));
  connect(switch1.y, setpointController.measurement) annotation (Line(points={{41,
          84},{56,84},{56,80.8},{66,80.8}}, color={0,0,127}));
  connect(add.y, gain.u) annotation (Line(points={{-33,54},{-34,54},{-34,58},{-28,
          58},{-28,70},{-14,70}}, color={0,0,127}));
  connect(gain.y, switch1.u3)
    annotation (Line(points={{9,70},{18,70},{18,76}}, color={0,0,127}));
  connect(hysteresis.y, ModeCommand.u) annotation (Line(points={{145,18},{150,18},
          {150,0},{126,0},{126,-20},{134,-20}}, color={255,0,255}));
  connect(ModeCommand.y, ModeCommandFcu) annotation (Line(points={{157,-20},{157,
          -124},{-94,-124},{-94,-80},{-120,-80}}, color={255,0,255}));
  connect(ModeCommand.y, not1.u) annotation (Line(points={{157,-20},{157,-124},{
          -40,-124},{-40,-96},{-52,-96},{-52,-92},{-54,-92},{-54,-84},{-46,-84}},
        color={255,0,255}));
  connect(ModeCommand.y, switch1.u2) annotation (Line(points={{157,-20},{164,-20},
          {164,64},{18,64},{18,84}}, color={255,0,255}));
  connect(fanCoilUnitDoubleHysteresis.RunFcuAirSide, switch2.u2) annotation (
      Line(points={{108,-105.2},{113,-105.2},{113,-106},{118,-106}}, color={255,
          0,255}));
  connect(setpointController1.command, switch2.u1) annotation (Line(points={{29,
          -69.4},{96,-69.4},{96,-92},{100,-92},{100,-94},{110,-94},{110,-98},{
          118,-98}}, color={0,0,127}));
  connect(const.y, switch2.u3) annotation (Line(points={{101,-170},{106,-170},{
          106,-122},{118,-122},{118,-114}}, color={0,0,127}));
  connect(switch2.y, m_flow_air) annotation (Line(points={{141,-106},{146,-106},
          {146,-82},{112,-82}}, color={0,0,127}));
  connect(TZon, fanCoilUnitDoubleHysteresis.TZon) annotation (Line(points={{44,
          -120},{76,-120},{76,-104.6},{84,-104.6}}, color={0,0,127}));
  connect(hysteresis.u, TZon) annotation (Line(points={{122,18},{112,18},{112,
          -38},{116,-38},{116,-68},{44,-68},{44,-120}}, color={0,0,127}));
  connect(setpointController1.measurement, TZon) annotation (Line(points={{6,
          -71.2},{-6,-71.2},{-6,-120},{44,-120}}, color={0,0,127}));
  connect(tempFcuWaterSupply.T, combiTable2Ds_cooling.u1) annotation (Line(
        points={{-80,39},{-122,39},{-122,-28},{-156,-28}}, color={0,0,127}));
  connect(tempFcuAirSupply.T, combiTable2Ds_cooling.u2) annotation (Line(points=
         {{74,-39},{74,-58},{-156,-58},{-156,-40}}, color={0,0,127}));
  connect(combiTable2Ds_heating.y, switch3.u1) annotation (Line(points={{-101,4},
          {-64,4},{-64,20},{-54,20}}, color={0,0,127}));
  connect(combiTable2Ds_cooling.y, switch3.u3) annotation (Line(points={{-133,
          -34},{-100,-34},{-100,-10},{-80,-10},{-80,2},{-62,2},{-62,4},{-54,4}},
        color={0,0,127}));
  connect(switch3.y, hex.eps) annotation (Line(points={{-31,12},{-18,12},{-18,
          7.1},{-10,7.1}}, color={0,0,127}));
  connect(ModeCommand.y, switch3.u2) annotation (Line(points={{157,-20},{172,
          -20},{172,-18},{182,-18},{182,-48},{-54,-48},{-54,12}}, color={255,0,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnit_hysteresis_air_control_02212024;
