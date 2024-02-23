within CCC_test.StanfordHybrid;
model Hybrid_2024_test2

   package MediumW = Buildings.Media.Water "Medium model for 9% prop glycol mix with water";
  package MediumA = Buildings.Media.Air "Medium model for air";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.8;
  parameter Modelica.Units.SI.MassFlowRate mTes_flow_nominal=0.8;
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal = 1000
                                                                     "Nominal pressure drop of fully open valve";
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal = 1000 "pressure drop of pipe and other resistances that are in series" annotation(Dialog(group="System Specifications"));
  BaseClasses.Tes_hybrid_alternative      hot_PCM(
    redeclare package Medium = MediumW,
    mTes_flow_nominal=1,
    k=matPro.kPCMLow,
    c=matPro.cPCMLow,
    d=matPro.dPCMLow,
    TSol=matPro.TSolLow,
    TLiq=matPro.TLiqLow,
    T_start=320.15,
    LHea=matPro.LHeaLow,
    Tes_nominal(displayUnit="kWh") = 32400000)    annotation (Placement(transformation(
        extent={{-13,-18},{13,18}},
        rotation=180,
        origin={7,-44})));
  BaseClasses.Tes_hybrid_alternative      cold_PCM(
    redeclare package Medium = MediumW,
    mTes_flow_nominal=1,
    k=matPro.kPCMCoo,
    c=matPro.cPCMCoo,
    d=matPro.dPCMCoo,
    TSol=matPro.TSolCoo,
    TLiq=matPro.TLiqCoo,
    T_start=285.15,
    LHea=matPro.LHeaCoo,
    Tes_nominal(displayUnit="kWh") = 32400000)     annotation (Placement(transformation(
        extent={{-13,-18},{13,18}},
        rotation=180,
        origin={9,40})));
  Buildings.Fluid.FixedResistances.Junction spl2(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{-9,9},{9,-9}},
        rotation=0,
        origin={-57,-67})));
  Buildings.Fluid.FixedResistances.Junction spl1(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{-9,9},{9,-9}},
        rotation=0,
        origin={-131,-67})));
  HeatPumps.Aixlib_AirToWaterHeatPump_3D AWHP(
    redeclare package Medium_eva = MediumA,
    redeclare package Medium_con = MediumW,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-288,36},{-250,62}})));
  Buildings.Fluid.FixedResistances.Junction spl5(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-56,56})));
  CCC.Fluid.BaseClasses.ArisRoomModel_1Room RoomModel
    annotation (Placement(transformation(extent={{-338,-42},{-296,-12}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA4(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=0,
        origin={-172,-68})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA5(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-9,10},{9,-10}},
        rotation=0,
        origin={-97,-68})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-170,26})));
  Buildings.Fluid.FixedResistances.Junction spl4(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal*{1,1,-1},
    dp_nominal={0,0,0}) "Flow splitter for supply" annotation (Placement(
        transformation(
        extent={{-11,11},{11,-11}},
        rotation=180,
        origin={-171,89})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumW,
    use_T_in=false,
    T=295.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-326,81})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA2(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{9,7},{-9,-7}},
        rotation=270,
        origin={-57,-11})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA1(
    redeclare package Medium = MediumW,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-11,10},{11,-10}},
        rotation=270,
        origin={-54,19})));
  Modelica.Blocks.Sources.Constant V4_out(k=1)
    annotation (Placement(transformation(extent={{-198,-124},{-178,-104}})));
  Modelica.Blocks.Sources.Constant V5_out(k=1)
    annotation (Placement(transformation(extent={{-122,-124},{-102,-104}})));
  Modelica.Blocks.Sources.Constant V2_out(k=1)
    annotation (Placement(transformation(extent={{-104,-8},{-84,12}})));
  Modelica.Blocks.Sources.Constant V1_out(k=0)
    annotation (Placement(transformation(extent={{-116,34},{-96,54}})));
  Modelica.Blocks.Sources.Constant P_out(k=0)
    annotation (Placement(transformation(extent={{-144,12},{-124,32}})));
  Modelica.Blocks.Sources.Constant T_out(k=273.15 + 25)
    annotation (Placement(transformation(extent={{-250,14},{-230,34}})));
  Modelica.Blocks.Sources.Constant T_sup_set(k=273.15 + 8)
    annotation (Placement(transformation(extent={{-330,26},{-310,46}})));
  Modelica.Blocks.Sources.BooleanConstant T_out1(k=false)
    annotation (Placement(transformation(extent={{-254,-64},{-234,-44}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumA,
    use_T_in=false,
    T=295.15)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-318,-83})));
  HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{-14,72},{6,92}})));
  HeatExchangers.FanCoilUnit_hysteresis_air_control
    fanCoilUnit_hysteresis_air_control(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=0.2,
    m2_flow_nominal=0.07589,
    zone_temp_setpoint=294.15,
    dp1_nominal(displayUnit="Pa") = 4394)
    annotation (Placement(transformation(extent={{-268,-32},{-248,-12}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = MediumW,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-224,-4})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumA,
    m_flow_nominal=1,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-286,-66})));
  Modelica.Blocks.Sources.Constant const346(k=0)
    annotation (Placement(transformation(extent={{-254,-108},{-234,-88}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump2(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-220,64})));
  Modelica.Blocks.Sources.Constant const836(k=0.8)
    annotation (Placement(transformation(extent={{-286,92},{-266,112}})));
equation

  connect(valA4.port_2, spl1.port_1) annotation (Line(points={{-162,-68},{-150,-68},
          {-150,-67},{-140,-67}}, color={0,127,255}));

  connect(spl1.port_2, valA5.port_1) annotation (Line(points={{-122,-67},{-114,-67},
          {-114,-68},{-106,-68}}, color={0,127,255}));
  connect(valA5.port_2, spl2.port_1) annotation (Line(points={{-88,-68},{-74,-68},
          {-74,-67},{-66,-67}}, color={0,127,255}));
  connect(spl4.port_3, pump.port_a) annotation (Line(points={{-171,78},{-172,78},
          {-172,54},{-170,54},{-170,36}},
                                color={0,127,255}));
  connect(spl4.port_1, spl5.port_2)
    annotation (Line(points={{-160,89},{-56,89},{-56,66}}, color={0,127,255}));
  connect(pump.port_b, valA4.port_3) annotation (Line(points={{-170,16},{-172,16},
          {-172,-60}}, color={0,127,255}));

  connect(valA2.port_1, spl2.port_3)
    annotation (Line(points={{-57,-20},{-57,-58}}, color={0,127,255}));
  connect(V4_out.y, valA4.y) annotation (Line(points={{-177,-114},{-172,-114},{-172,
          -77.6}}, color={0,0,127}));
  connect(V5_out.y, valA5.y) annotation (Line(points={{-101,-114},{-97,-114},{-97,
          -80}}, color={0,0,127}));
  connect(V1_out.y, valA1.y) annotation (Line(points={{-95,44},{-76,44},{-76,19},
          {-66,19}},   color={0,0,127}));
  connect(V2_out.y, valA2.y) annotation (Line(points={{-83,2},{-76,2},{-76,-11},
          {-65.4,-11}}, color={0,0,127}));
  connect(P_out.y, pump.m_flow_in) annotation (Line(points={{-123,22},{-118,22},
          {-118,6},{-152,6},{-152,22},{-150,22},{-150,26},{-158,26}}, color={0,0,
          127}));
  connect(T_out.y, AWHP.TOutAir) annotation (Line(points={{-229,24},{-224,24},{
          -224,44.71},{-247.53,44.71}},
                                   color={0,0,127}));
  connect(T_sup_set.y, AWHP.TSupSet) annotation (Line(points={{-309,36},{-294,
          36},{-294,43.93},{-290.09,43.93}},
                                         color={0,0,127}));
  connect(T_out1.y, AWHP.Mode) annotation (Line(points={{-233,-54},{-208,-54},{
          -208,-18},{-206,-18},{-206,51.6},{-247.72,51.6}},
                                                       color={255,0,255}));
  connect(boundary1.ports[1], pump.port_a) annotation (Line(points={{-316,81},{
          -188,81},{-188,42},{-170,42},{-170,36}}, color={0,127,255}));
  connect(RoomModel.ZoneTAir2, fanCoilUnit_hysteresis_air_control.TZon)
    annotation (Line(points={{-318.4,-11},{-318.4,2},{-256,2},{-256,-34},{-253.6,
          -34}}, color={0,0,127}));
  connect(fanCoilUnit_hysteresis_air_control.port_b1, valA5.port_3) annotation (
     Line(points={{-247.8,-17.6},{-97,-17.6},{-97,-58}}, color={0,127,255}));
  connect(RoomModel.port_b2, fanCoilUnit_hysteresis_air_control.port_a2)
    annotation (Line(points={{-295.6,-23.2},{-280,-23.2},{-280,-38},{-234,-38},{
          -234,-27.2},{-247.8,-27.2}}, color={0,127,255}));
  connect(spl4.port_2, AWHP.port_a) annotation (Line(points={{-182,89},{-289.9,89},
          {-289.9,58.1}}, color={0,127,255}));
  connect(pump1.port_a, spl1.port_3) annotation (Line(points={{-214,-4},{-131,-4},
          {-131,-58}}, color={0,127,255}));
  connect(pump1.port_b, fanCoilUnit_hysteresis_air_control.port_a1) annotation (
     Line(points={{-234,-4},{-268.2,-4},{-268.2,-17.6}}, color={0,127,255}));
  connect(fanCoilUnit_hysteresis_air_control.port_b2, fan.port_a) annotation (
      Line(points={{-268.2,-27},{-268.2,-28},{-282,-28},{-282,-50},{-270,-50},{-270,
          -66},{-276,-66}}, color={0,127,255}));
  connect(fan.port_b, RoomModel.port_a2) annotation (Line(points={{-296,-66},{-306,
          -66},{-306,-58},{-332,-58},{-332,-23.6},{-338.6,-23.6}}, color={0,127,
          255}));
  connect(spl5.port_3, cold_PCM.port_b) annotation (Line(points={{-46,56},{-10,
          56},{-10,51.4545},{-4,51.4545}},
                                       color={0,127,255}));
  connect(hot_PCM.port_b, valA2.port_3) annotation (Line(points={{-6,-32.5455},
          {-18,-32.5455},{-18,-24},{-50,-24},{-50,-11}},color={0,127,255}));
  connect(hot_PCM.port_a, spl2.port_2) annotation (Line(points={{-6,-54.8},{-42,
          -54.8},{-42,-67},{-48,-67}}, color={0,127,255}));
  connect(const346.y, pump1.m_flow_in) annotation (Line(points={{-233,-98},{-220,
          -98},{-220,-16},{-224,-16}}, color={0,0,127}));
  connect(const346.y, fan.m_flow_in) annotation (Line(points={{-233,-98},{-233,-78},
          {-286,-78}}, color={0,0,127}));
  connect(AWHP.port_b, pump2.port_a) annotation (Line(points={{-248.48,57.84},{-236,
          57.84},{-236,64},{-230,64}}, color={0,127,255}));
  connect(pump2.port_b, valA4.port_1) annotation (Line(points={{-210,64},{-208,64},
          {-208,-20},{-188,-20},{-188,-68},{-182,-68}}, color={0,127,255}));
  connect(const836.y, pump2.m_flow_in) annotation (Line(points={{-265,102},{-242,
          102},{-242,98},{-220,98},{-220,76}}, color={0,0,127}));
  connect(spl5.port_1, valA1.port_1) annotation (Line(points={{-56,46},{-56,36},
          {-54,36},{-54,30}}, color={0,127,255}));
  connect(valA1.port_3, cold_PCM.port_a) annotation (Line(points={{-44,19},{-12,
          19},{-12,29.2},{-4,29.2}}, color={0,127,255}));
  connect(valA1.port_2, valA2.port_2) annotation (Line(points={{-54,8},{-54,4},{
          -57,4},{-57,-2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,-100},
            {40,100}})),  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-340,-100},{40,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Hybrid_2024_test2;
