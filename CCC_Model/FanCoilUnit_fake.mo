within CCC_test.CCC_Model;
model FanCoilUnit_fake
    replaceable package Medium1 = MediumPropyleneGlycol "Medium 1 in the component";
      replaceable package Medium2 = Buildings.Media.Air "Medium 2 in the component";
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  replaceable parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.11827
    "Nominal mass flow rate for Medium 1";
  replaceable parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=0.14951
    "Nominal mass flow rate for Medium 2";
  //replaceable parameter Modelica.Units.SI.Temperature T_a1_nominal=273.15+20
    //"Nominal temperature at port a1";
  //replaceable parameter Modelica.Units.SI.Temperature T_a2_nominal=273.15+20
    //"Nominal temperature at port a2";
  //replaceable parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=500
    //"Nominal heat flow rate (positive for heat transfer from 1 to 2)";
  replaceable parameter Modelica.Units.SI.Temperature zone_temp_cooling_setpoint=273.15+22
    "Zone air temperature setpoint";
     replaceable parameter Modelica.Units.SI.Temperature zone_temp_heating_setpoint=273.15+20
    "Zone air temperature setpoint";
          replaceable parameter Modelica.Units.SI.Pressure dp1_nominal=5000
    "Nominal pressure drop for Medium 1";
          replaceable parameter Modelica.Units.SI.Pressure dp2_nominal=2.2
    "Nominal pressure drop for Medium 2";
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuAirSupply(redeclare package
      Medium = Medium2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,-28})));

  Buildings.Fluid.HeatExchangers.ConstantEffectiveness
                                                 hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp1_nominal=dp1_nominal,
    dp2_nominal=dp2_nominal,
    eps=0.45)
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
    annotation (Placement(transformation(extent={{-60,42},{-40,62}})));
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
  CCC.Controls.SetpointController_variableSetpoint setpointController(
    gain_value=m1_flow_nominal,
    reverseActing=false,
    conPID(yMin=0.001))
    annotation (Placement(transformation(extent={{68,72},{88,92}})));
  Modelica.Blocks.Interfaces.BooleanOutput FcuModeBoolean
    "true for heating; false for cooling; output the previous state if in deadband"
                                          annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-120,-80})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-12,60},{8,80}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,74},{40,94}})));
  CCC.Fluid.HeatExchangers.BaseClasses.FanCoilUnitHysteresis fanCoilUnitDoubleHysteresis(
      zone_temp_cooling_setpoint=zone_temp_cooling_setpoint,
      zone_temp_heating_setpoint=zone_temp_heating_setpoint)
    annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{120,-116},{140,-96}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{80,-180},{100,-160}})));
  Modelica.Blocks.Interfaces.RealInput TZon "Zone air temperature" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={44,-120})));
  Modelica.Blocks.Tables.CombiTable1Ds HeatingSetpointDiff(table=[273.15 + 35,5;
        273.15 + 45,10], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-52,112},{-32,132}})));
  Modelica.Blocks.Tables.CombiTable1Ds CoolingSetpointDiff(table=[273.15 + 7,5;
        273.15 + 16,2; 273.15 + 18.3,0.9], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-22,100},{-2,120}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{50,106},{70,126}})));
  Modelica.Blocks.Interfaces.IntegerOutput FcuMode
    "-1 is cooling, 0 is deadband, 1 is heating" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-72,-120})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{122,-42},{142,-22}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{164,-46},{184,-26}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       0.5) annotation (Placement(transformation(extent={{164,-76},{184,-56}})));
  CCC.Controls.EnergyFlowSensor energyFlowSensor(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-180,90},{-160,110}})));
  Modelica.Blocks.Interfaces.RealOutput HeatingThermalPowerDelivered
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,92})));
  Modelica.Blocks.Math.Gain EffectiveThermalEnergyDelivered(k=-1)
    annotation (Placement(transformation(extent={{-260,48},{-240,68}})));
  CCC.Controls.SetpointController_variableSetpoint_reverseCapable setpointController1(
      gain_value=m2_flow_nominal)
    annotation (Placement(transformation(extent={{4,-86},{24,-66}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-40,-106},{-20,-86}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{-210,-84},{-190,-64}})));
  Modelica.Blocks.Sources.Constant const1(k=zone_temp_heating_setpoint)
    annotation (Placement(transformation(extent={{-268,-50},{-248,-30}})));
  Modelica.Blocks.Sources.Constant const2(k=zone_temp_cooling_setpoint)
    annotation (Placement(transformation(extent={{-274,-104},{-254,-84}})));
  Modelica.Blocks.Interfaces.RealOutput CoolingThermalPowerDelivered
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,70})));
  CCC.Controls.SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{-222,48},{-202,68}})));
  Modelica.Blocks.Sources.Constant const3(k=5)
    annotation (Placement(transformation(extent={{4,136},{24,156}})));
equation
  connect(port_a1, port_a1)
    annotation (Line(points={{-102,44},{-102,44}}, color={0,127,255}));
  connect(hex.port_b1, tempFcuWaterReturn.port_a) annotation (Line(points={{12,12},
          {34,12},{34,38},{40,38}}, color={0,127,255}));
  connect(hex.port_b2, tempFcuAirReturn.port_a) annotation (Line(points={{-8,0},{
          -48,0},{-48,-14},{-54,-14}},   color={0,127,255}));
  connect(tempFcuWaterSupply.T, add.u1) annotation (Line(points={{-80,39},{-80,
          60},{-70,60},{-70,58},{-62,58}},      color={0,0,127}));
  connect(tempFcuWaterReturn.T, add.u2) annotation (Line(points={{50,49},{50,52},
          {48,52},{48,54},{-32,54},{-32,102},{-74,102},{-74,46},{-62,46}},
                                      color={0,0,127}));
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
  connect(setpointController.command, m_flow_water) annotation (Line(points={{89,82.6},
          {100.5,82.6},{100.5,82},{112,82}},        color={0,0,127}));
  connect(add.y, switch1.u1) annotation (Line(points={{-39,52},{-30,52},{-30,70},
          {-22,70},{-22,92},{18,92}}, color={0,0,127}));
  connect(switch1.y, setpointController.measurement) annotation (Line(points={{41,
          84},{56,84},{56,80.8},{66,80.8}}, color={0,0,127}));
  connect(add.y, gain.u) annotation (Line(points={{-39,52},{-30,52},{-30,70},{
          -14,70}},               color={0,0,127}));
  connect(gain.y, switch1.u3)
    annotation (Line(points={{9,70},{18,70},{18,76}}, color={0,0,127}));
  connect(const.y, switch2.u3) annotation (Line(points={{101,-170},{106,-170},{
          106,-122},{118,-122},{118,-114}}, color={0,0,127}));
  connect(switch2.y, m_flow_air) annotation (Line(points={{141,-106},{146,-106},
          {146,-82},{112,-82}}, color={0,0,127}));
  connect(TZon, fanCoilUnitDoubleHysteresis.TZon) annotation (Line(points={{44,-120},
          {44,11.4},{98,11.4}},                     color={0,0,127}));
  connect(tempFcuWaterSupply.T, HeatingSetpointDiff.u) annotation (Line(points=
          {{-80,39},{-80,60},{-72,60},{-72,100},{-64,100},{-64,122},{-54,122}},
        color={0,0,127}));
  connect(tempFcuWaterSupply.T, CoolingSetpointDiff.u) annotation (Line(points=
          {{-80,39},{-80,60},{-72,60},{-72,100},{-28,100},{-28,94},{-24,94},{
          -24,110}}, color={0,0,127}));
  connect(switch4.y, setpointController.setpoint) annotation (Line(points={{71,
          116},{76,116},{76,98},{58,98},{58,85.4},{66,85.4}}, color={0,0,127}));
  connect(fanCoilUnitDoubleHysteresis.FcuMode, integerToReal.u) annotation (
      Line(points={{122,10.8},{130,10.8},{130,-18},{110,-18},{110,-32},{120,-32}},
        color={255,127,0}));
  connect(integerToReal.y, abs1.u) annotation (Line(points={{143,-32},{156,-32},
          {156,-36},{162,-36}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, switch2.u2) annotation (Line(points={{185,-66},
          {170,-66},{170,-124},{118,-124},{118,-106}}, color={255,0,255}));
  connect(abs1.y, greaterEqualThreshold.u) annotation (Line(points={{185,-36},{185,
          -54},{154,-54},{154,-66},{162,-66}}, color={0,0,127}));
  connect(fanCoilUnitDoubleHysteresis.FcuModeBoolean, switch4.u2) annotation (
      Line(points={{122,15.8},{132,15.8},{132,18},{144,18},{144,134},{48,134},{48,
          116}}, color={255,0,255}));
  connect(fanCoilUnitDoubleHysteresis.FcuModeBoolean, switch1.u2) annotation (
      Line(points={{122,15.8},{144,15.8},{144,104},{6,104},{6,84},{18,84}},
        color={255,0,255}));
  connect(fanCoilUnitDoubleHysteresis.FcuModeBoolean, FcuModeBoolean)
    annotation (Line(points={{122,15.8},{148,15.8},{148,16},{188,16},{188,-136},
          {-120,-136},{-120,-80}}, color={255,0,255}));
  connect(fanCoilUnitDoubleHysteresis.FcuMode, FcuMode) annotation (Line(points=
         {{122,10.8},{136,10.8},{136,-120},{-72,-120}}, color={255,127,0}));
  connect(port_a1, energyFlowSensor.port_a) annotation (Line(points={{-102,44},
          {-186,44},{-186,99.6},{-180.2,99.6}}, color={0,127,255}));
  connect(energyFlowSensor.port_b, tempFcuWaterSupply.port_a) annotation (Line(
        points={{-159.8,99.6},{-152,99.6},{-152,36},{-120,36},{-120,28},{-90,28}},
        color={0,127,255}));
  connect(tempFcuWaterReturn.T, energyFlowSensor.TempSupply) annotation (Line(
        points={{50,49},{50,74},{8,74},{8,62},{-70,62},{-70,124},{-160,124},{
          -160,111.2},{-169.8,111.2}}, color={0,0,127}));
  connect(energyFlowSensor.Q_flow, EffectiveThermalEnergyDelivered.u)
    annotation (Line(points={{-169.4,89},{-169.4,88},{-272,88},{-272,58},{-262,
          58}}, color={0,0,127}));
  connect(setpointController1.command, switch2.u1) annotation (Line(points={{25,
          -75.4},{96,-75.4},{96,-98},{118,-98}}, color={0,0,127}));
  connect(TZon, setpointController1.measurement) annotation (Line(points={{44,-120},
          {44,-96},{-10,-96},{-10,-77.2},{2,-77.2}},       color={0,0,127}));
  connect(not1.y, setpointController1.reverse) annotation (Line(points={{-19,-96},
          {-12,-96},{-12,-92},{-6,-92},{-6,-94},{2,-94},{2,-82.6}},      color=
          {255,0,255}));
  connect(fanCoilUnitDoubleHysteresis.FcuModeBoolean, not1.u) annotation (Line(
        points={{122,15.8},{142,15.8},{142,12},{152,12},{152,-132},{-42,-132},{
          -42,-96}}, color={255,0,255}));
  connect(fanCoilUnitDoubleHysteresis.FcuModeBoolean, switch5.u2) annotation (
      Line(points={{122,15.8},{182,15.8},{182,10},{190,10},{190,-144},{-240,
          -144},{-240,-74},{-212,-74}}, color={255,0,255}));
  connect(switch5.y, setpointController1.setpoint) annotation (Line(points={{-189,
          -74},{-142,-74},{-142,-102},{-96,-102},{-96,-94},{-52,-94},{-52,-72},
          {2,-72}},      color={0,0,127}));
  connect(const1.y, switch5.u1) annotation (Line(points={{-247,-40},{-220,-40},
          {-220,-66},{-212,-66}}, color={0,0,127}));
  connect(const2.y, switch5.u3) annotation (Line(points={{-253,-94},{-220,-94},
          {-220,-82},{-212,-82}}, color={0,0,127}));
  connect(EffectiveThermalEnergyDelivered.y,
    separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-239,58},{-224,58}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy,
    HeatingThermalPowerDelivered) annotation (Line(points={{-200,61.6},{-126,
          61.6},{-126,92},{-110,92}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy,
    CoolingThermalPowerDelivered) annotation (Line(points={{-200,52.2},{-150,
          52.2},{-150,70},{-110,70}}, color={0,0,127}));
  connect(const3.y, switch4.u1) annotation (Line(points={{25,146},{40,146},{40,
          124},{48,124}}, color={0,0,127}));
  connect(const3.y, switch4.u3) annotation (Line(points={{25,146},{40,146},{40,
          108},{48,108}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnit_fake;
