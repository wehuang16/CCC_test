within CCC_test.Examples;
model Hybrid_2024_v3_test3

   package MediumW = Buildings.Media.Water "Medium model for 9% prop glycol mix with water";
  package MediumA = Buildings.Media.Air "Medium model for air";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.8;
  parameter Modelica.Units.SI.MassFlowRate mTes_flow_nominal=0.8;
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal = 1000
                                                                     "Nominal pressure drop of fully open valve";
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal = 1000 "pressure drop of pipe and other resistances that are in series" annotation(Dialog(group="System Specifications"));

    parameter Modelica.Units.SI.Time chargeStart_Tes = 1*3*3600 "Continue charging at 3am" annotation(Dialog(group="State Schedule: Summer"));
  parameter Modelica.Units.SI.Time chargeEnd_Tes = 1*7.5*3600 "Stop charging at 7:30am"  annotation(Dialog(group="State Schedule: Summer"));
  parameter Modelica.Units.SI.Time dischargeStart_Tes = 1*12*3600 "Begin discharging at 12pm"  annotation(Dialog(group="State Schedule: Summer"));
  parameter Modelica.Units.SI.Time dischargeEnd_Tes = 1*20*3600 "Stop discharging at 8pm"  annotation(Dialog(group="State Schedule: Summer"));

   Modelica.Blocks.Sources.CombiTimeTable SchTes(
    table=[0,2; chargeStart_Tes,0; chargeEnd_Tes,2; dischargeStart_Tes,1;
        dischargeEnd_Tes,2; 24*3600,2],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "TES charging and discharging schedule for cooling"
    annotation (Placement(transformation(extent={{-332,72},{-312,92}})));

  CCC.Fluid.Plants.BaseClasses.Tes_hybrid_alternative hot_PCM(
    redeclare package Medium = MediumW,
    mTes_flow_nominal=1,
    k=matPro.kPCMLow,
    c=matPro.cPCMLow,
    d=matPro.dPCMLow,
    TSol=matPro.TSolLow,
    TLiq=matPro.TLiqLow,
    T_start=322.15,
    LHea=matPro.LHeaLow,
    Tes_nominal(displayUnit="kWh") = 32400000) annotation (Placement(
        transformation(
        extent={{-13,-18},{13,18}},
        rotation=180,
        origin={141,-120})));
  CCC.Fluid.Plants.BaseClasses.Tes_hybrid_alternative cold_PCM(
    redeclare package Medium = MediumW,
    mTes_flow_nominal=1,
    k=matPro.kPCMCoo,
    c=matPro.cPCMCoo,
    d=matPro.dPCMCoo,
    TSol=matPro.TSolCoo,
    TLiq=matPro.TLiqCoo,
    T_start=283.15,
    LHea=matPro.LHeaCoo,
    Tes_nominal(displayUnit="kWh") = 32400000) annotation (Placement(
        transformation(
        extent={{-13,-18},{13,18}},
        rotation=180,
        origin={143,-36})));
  Buildings.Fluid.FixedResistances.Junction spl2(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{-9,9},{9,-9}},
        rotation=0,
        origin={77,-143})));
  Buildings.Fluid.FixedResistances.Junction spl1(
    redeclare package Medium = MediumW,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    m_flow_nominal=m_flow_nominal*{1,-1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{-9,9},{9,-9}},
        rotation=0,
        origin={5,-143})));
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D AWHP(
    redeclare package Medium_eva = MediumA,
    redeclare package Medium_con = MediumW,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-154,-40},{-116,-14}})));
  Buildings.Fluid.FixedResistances.Junction spl5(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={78,-20})));
  CCC.Fluid.BaseClasses.ArisRoomModel_1Room RoomModel
    annotation (Placement(transformation(extent={{-204,-118},{-162,-88}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA4(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=0,
        origin={-38,-144})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA5(
    redeclare package Medium = MediumW,
    y_start=0,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-9,10},{9,-10}},
        rotation=0,
        origin={45,-144})));
  Buildings.Fluid.Movers.SpeedControlled_y     pump(
    redeclare package Medium = MediumW,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-36,-50})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA2(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{9,7},{-9,-7}},
        rotation=270,
        origin={77,-87})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA1(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-11,10},{11,-10}},
        rotation=270,
        origin={80,-57})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumA,
    use_T_in=false,
    T=295.15)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-184,-159})));
  CCC.Fluid.HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{152,72},{172,92}})));
  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnit_hysteresis_air_control(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m2_flow_nominal=0.07589,
    dp1_nominal(displayUnit="Pa") = 4394)
    annotation (Placement(transformation(extent={{-134,-106},{-114,-86}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumA,
    m_flow_nominal=0.3,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-152,-142})));
  CCC.Controls.hybrid_2024_controller hybrid_2024_controller(SchandFCU_and_PCM(
        table=[0,0,1; 1,8,10; 2,7,6; 3,10,10; 4,1,0.0; 5,0.0,0.0; 6,0.0,0.0; 7,
          4,9; 8,3,2; 9,9,9]))
    annotation (Placement(transformation(extent={{-282,22},{-258,54}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{-230,-24},{-210,-4}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{-238,-132},{-218,-112}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal3(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{-224,-72},{-204,-52}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal1
    annotation (Placement(transformation(extent={{-348,-92},{-328,-72}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-320,-92},{-300,-72}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1
    annotation (Placement(transformation(extent={{-280,-90},{-260,-70}})));
  Buildings.Fluid.Sensors.MassFlowRate       mFloRet(redeclare package Medium =
        Buildings.Media.Water)
                   annotation (Placement(transformation(
        extent={{9,-8},{-9,8}},
        rotation=0,
        origin={9,14})));
  Buildings.Fluid.Sensors.MassFlowRate       mFloRet1(redeclare package Medium =
        Buildings.Media.Water)
                   annotation (Placement(transformation(
        extent={{9,-8},{-9,8}},
        rotation=0,
        origin={-67,16})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA3(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{11.5,10.5},{-11.5,-10.5}},
        rotation=180,
        origin={-34.5,12.5})));
  Buildings.Fluid.Sensors.MassFlowRate       mFloRet2(redeclare package Medium =
        Buildings.Media.Water)
                   annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=0,
        origin={-18,-142})));
  Buildings.Fluid.Sensors.MassFlowRate       mFloRet3(redeclare package Medium =
        Buildings.Media.Water)
                   annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=270,
        origin={-54,-116})));
  Buildings.Fluid.Sensors.MassFlowRate       mFloRet4(redeclare package Medium =
        Buildings.Media.Water)
                   annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=90,
        origin={6,-116})));
  Buildings.Fluid.Movers.SpeedControlled_y     pump2(
    redeclare package Medium = MediumW,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{9,-9},{-9,9}},
        rotation=0,
        origin={-119,-5})));
  Buildings.Fluid.Sensors.MassFlowRate       mFloRet5(redeclare package Medium =
        Buildings.Media.Water)
                   annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=0,
        origin={26,-144})));
  CCC.Controls.FlowConstraintBreaker flowConstraintBreaker
    annotation (Placement(transformation(extent={{-138,-14},{-150,-2}})));
equation

  connect(valA5.port_2, spl2.port_1) annotation (Line(points={{54,-144},{48,
          -144},{48,-143},{68,-143}},
                                color={0,127,255}));
  connect(pump.port_b, valA4.port_3) annotation (Line(points={{-36,-60},{-38,-60},
          {-38,-136}}, color={0,127,255}));

  connect(valA2.port_1, spl2.port_3)
    annotation (Line(points={{77,-96},{77,-134}},  color={0,127,255}));
  connect(RoomModel.ZoneTAir2, fanCoilUnit_hysteresis_air_control.TZon)
    annotation (Line(points={{-184.4,-87},{-184.4,-82},{-144,-82},{-144,-118},{
          -119.6,-118},{-119.6,-108}},
                 color={0,0,127}));
  connect(fanCoilUnit_hysteresis_air_control.port_b1, valA5.port_3) annotation (
     Line(points={{-113.8,-91.6},{-106,-91.6},{-106,-128},{45,-128},{45,-134}},
                                                         color={0,127,255}));
  connect(RoomModel.port_b2, fanCoilUnit_hysteresis_air_control.port_a2)
    annotation (Line(points={{-161.6,-99.2},{-146,-99.2},{-146,-118},{-108,-118},
          {-108,-101.2},{-113.8,-101.2}},
                                       color={0,127,255}));
  connect(fanCoilUnit_hysteresis_air_control.port_b2, fan.port_a) annotation (
      Line(points={{-134.2,-101},{-134.2,-104},{-144,-104},{-144,-126},{-136,
          -126},{-136,-142},{-142,-142}},
                            color={0,127,255}));
  connect(fan.port_b, RoomModel.port_a2) annotation (Line(points={{-162,-142},{-210,
          -142},{-210,-99.6},{-204.6,-99.6}},                      color={0,127,
          255}));
  connect(spl5.port_3, cold_PCM.port_b) annotation (Line(points={{88,-20},{124,
          -20},{124,-24.5455},{130,-24.5455}},
                                       color={0,127,255}));
  connect(hot_PCM.port_b, valA2.port_3) annotation (Line(points={{128,-108.545},
          {92,-108.545},{92,-87},{84,-87}},             color={0,127,255}));
  connect(hot_PCM.port_a, spl2.port_2) annotation (Line(points={{128,-130.8},{92,
          -130.8},{92,-143},{86,-143}},color={0,127,255}));
  connect(spl5.port_1, valA1.port_1) annotation (Line(points={{78,-30},{78,-40},
          {80,-40},{80,-46}}, color={0,127,255}));
  connect(valA1.port_3, cold_PCM.port_a) annotation (Line(points={{90,-57},{90,-58},
          {124,-58},{124,-46.8},{130,-46.8}},
                                     color={0,127,255}));
  connect(valA1.port_2, valA2.port_2) annotation (Line(points={{80,-68},{80,-72},
          {77,-72},{77,-78}},
                            color={0,127,255}));
  connect(fanCoilUnit_hysteresis_air_control.FcuModeBoolean, AWHP.Mode)
    annotation (Line(points={{-136,-104},{-144,-104},{-144,-46},{-106,-46},{
          -106,-24.4},{-113.72,-24.4}},
                                      color={255,0,255}));
  connect(SchTes.y[1], hybrid_2024_controller.scheduleInput) annotation (Line(
        points={{-311,82},{-294,82},{-294,51.8667},{-284.2,51.8667}}, color={0,
          0,127}));
  connect(hybrid_2024_controller.FCUmode, fanCoilUnit_hysteresis_air_control.FcuMode)
    annotation (Line(points={{-284,41.2},{-292,41.2},{-292,-144},{-168,-144},{
          -168,-162},{-131.2,-162},{-131.2,-108}},
                                              color={255,127,0}));
  connect(fanCoilUnit_hysteresis_air_control.FcuModeBoolean,
    hybrid_2024_controller.FCUbool) annotation (Line(points={{-136,-104},{-144,
          -104},{-144,-46},{-294,-46},{-294,32.6667},{-284,32.6667}}, color={
          255,0,255}));
  connect(hybrid_2024_controller.SOChotPCM, hot_PCM.SOC) annotation (Line(
        points={{-284,28.4},{-78,28.4},{-78,-105.273},{127,-105.273}}, color={0,
          0,127}));
  connect(cold_PCM.SOC, hybrid_2024_controller.SOCcoldPCM) annotation (Line(
        points={{129,-21.2727},{128,-21.2727},{128,-8},{-70,-8},{-70,8},{-176,8},
          {-176,20},{-252,20},{-252,12},{-284,12},{-284,24.1333}}, color={0,0,
          127}));
  connect(hybrid_2024_controller.valA1, valA1.y) annotation (Line(points={{-257,
          51.8667},{-16,51.8667},{-16,-57},{68,-57}}, color={0,0,127}));
  connect(hybrid_2024_controller.valA2, valA2.y) annotation (Line(points={{-257,
          47.6},{-12,47.6},{-12,-78},{64,-78},{64,-87},{68.6,-87}}, color={0,0,
          127}));
  connect(hybrid_2024_controller.valA4, valA4.y) annotation (Line(points={{-257,
          43.3333},{-257,-176},{-38,-176},{-38,-153.6}}, color={0,0,127}));
  connect(hybrid_2024_controller.valA5, valA5.y) annotation (Line(points={{-257,
          39.0667},{-257,-158},{-260,-158},{-260,-178},{45,-178},{45,-156}},
        color={0,0,127}));
  connect(hybrid_2024_controller.CP1, booleanToReal1.u) annotation (Line(points={{-257,
          34.8},{-257,-14},{-232,-14}},       color={255,0,255}));
  connect(hybrid_2024_controller.HP, booleanToReal3.u) annotation (Line(points={{-257,
          30.5333},{-257,-62},{-226,-62}},        color={255,0,255}));
  connect(fanCoilUnit_hysteresis_air_control.FcuMode, integerToReal1.u)
    annotation (Line(points={{-131.2,-108},{-131.2,-162},{-168,-162},{-168,-144},
          {-292,-144},{-292,-98},{-358,-98},{-358,-82},{-350,-82}}, color={255,127,
          0}));
  connect(integerToReal1.y, abs1.u)
    annotation (Line(points={{-327,-82},{-322,-82}}, color={0,0,127}));
  connect(abs1.y, realToBoolean1.u) annotation (Line(points={{-299,-82},{-299,-80},
          {-282,-80}}, color={0,0,127}));
  connect(realToBoolean1.y, booleanToReal2.u) annotation (Line(points={{-259,-80},
          {-250,-80},{-250,-122},{-240,-122}}, color={255,0,255}));
  connect(AWHP.TSupSet, hybrid_2024_controller.HPset) annotation (Line(points={{-156.09,
          -32.07},{-166,-32.07},{-166,26.2667},{-257,26.2667}},          color=
          {0,0,127}));
  connect(RoomModel.TOut, AWHP.TOutAir) annotation (Line(points={{-199.8,-87},{-142,
          -87},{-142,-48},{-104,-48},{-104,-31.29},{-113.53,-31.29}}, color={0,0,
          127}));
  connect(spl5.port_2, mFloRet.port_a)
    annotation (Line(points={{78,-10},{78,14},{18,14}}, color={0,127,255}));
  connect(valA4.y, valA3.y) annotation (Line(points={{-38,-153.6},{-38,-176},{
          -64,-176},{-64,-124},{-62,-124},{-62,-100},{-64,-100},{-64,2},{-52,2},
          {-52,34},{-34.5,34},{-34.5,25.1}},                     color={0,0,127}));
  connect(spl1.port_1, mFloRet2.port_b) annotation (Line(points={{-4,-143},{-8,
          -143},{-8,-142},{-10,-142}}, color={0,127,255}));
  connect(valA4.port_2, mFloRet2.port_a) annotation (Line(points={{-28,-144},{
          -28,-142},{-26,-142}}, color={0,127,255}));
  connect(mFloRet3.port_b, valA4.port_1) annotation (Line(points={{-54,-124},{
          -54,-144},{-48,-144}}, color={0,127,255}));
  connect(mFloRet4.port_a, spl1.port_3) annotation (Line(points={{6,-124},{6,
          -128},{5,-128},{5,-134}}, color={0,127,255}));
  connect(mFloRet4.port_b, fanCoilUnit_hysteresis_air_control.port_a1)
    annotation (Line(points={{6,-108},{6,-102},{-104,-102},{-104,-80},{-140,-80},
          {-140,-91.6},{-134.2,-91.6}}, color={0,127,255}));
  connect(AWHP.port_b, mFloRet3.port_a) annotation (Line(points={{-114.48,
          -18.16},{-62,-18.16},{-62,-100},{-54,-100},{-54,-108}}, color={0,127,
          255}));
  connect(pump2.port_a, mFloRet1.port_b) annotation (Line(points={{-110,-5},{
          -110,-8},{-100,-8},{-100,16},{-76,16}}, color={0,127,255}));
  connect(valA5.port_1, mFloRet5.port_b)
    annotation (Line(points={{36,-144},{34,-144}}, color={0,127,255}));
  connect(spl1.port_2, mFloRet5.port_a) annotation (Line(points={{14,-143},{14,
          -144},{18,-144}}, color={0,127,255}));
  connect(AWHP.port_a, flowConstraintBreaker.port_b) annotation (Line(points={{
          -155.9,-17.9},{-160,-17.9},{-160,-7},{-150,-7.04}}, color={0,127,255}));
  connect(flowConstraintBreaker.port_a, pump2.port_b) annotation (Line(points={{-137.76,
          -7.04},{-132.88,-7.04},{-132.88,-5},{-128,-5}},          color={0,127,
          255}));
  connect(valA3.port_2, mFloRet.port_b)
    annotation (Line(points={{-23,12.5},{-23,14},{0,14}}, color={0,127,255}));
  connect(valA3.port_1, mFloRet1.port_a) annotation (Line(points={{-46,12.5},{
          -54,12.5},{-54,16},{-58,16}}, color={0,127,255}));
  connect(valA3.port_3, pump.port_a) annotation (Line(points={{-34.5,2},{-34.5,
          0},{-36,0},{-36,-40}}, color={0,127,255}));
  connect(pump2.y, booleanToReal3.y) annotation (Line(points={{-119,5.8},{-203,
          5.8},{-203,-62}}, color={0,0,127}));
  connect(booleanToReal1.y, pump.y) annotation (Line(points={{-209,-14},{-168,
          -14},{-168,-44},{-106,-44},{-106,-48},{-48,-48},{-48,-38},{-14,-38},{
          -14,-50},{-24,-50}}, color={0,0,127}));
  connect(fanCoilUnit_hysteresis_air_control.m_flow_air, fan.m_flow_in)
    annotation (Line(points={{-112.8,-104.2},{-112.8,-154},{-152,-154}}, color=
          {0,0,127}));
  connect(hybrid_2024_controller.HP, AWHP.OnOff) annotation (Line(points={{-257,
          30.5333},{-156.28,30.5333},{-156.28,-24.4}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-380,-180},
            {180,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-380,-180},{180,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Hybrid_2024_v3_test3;
