within CCC_test.Examples;
model Hybrid_2024_v3_test2C

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

  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear valA4(
    redeclare package Medium = MediumW,
    riseTime=1,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=0,
        origin={-44,-144})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false,
    dp_nominal=10000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-36,-50})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumW,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-208,27})));
  CCC.Fluid.HeatExchangers.Data.MAPR matPro
    annotation (Placement(transformation(extent={{152,72},{172,92}})));
  CCC.Controls.hybrid_2024_controller hybrid_2024_controller(SchandFCU_and_PCM(
        table=[0,0,1; 1,8,10; 2,7,6; 3,10,10; 4,1,0.0; 5,0.0,0.0; 6,0.0,0.0; 7,
          4,9; 8,3,2; 9,9,9]))
    annotation (Placement(transformation(extent={{-282,22},{-258,54}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{-230,-24},{-210,-4}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal3(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{-224,-72},{-204,-52}})));
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
    riseTime=1,
    m_flow_nominal=mTes_flow_nominal,
    dpValve_nominal=dpValve_nominal) "Valve for discharge" annotation (
      Placement(transformation(
        extent={{9.5,10.5},{-9.5,-10.5}},
        rotation=180,
        origin={-36.5,16.5})));
  Buildings.Fluid.Sensors.MassFlowRate       mFloRet3(redeclare package Medium =
        Buildings.Media.Water)
                   annotation (Placement(transformation(
        extent={{-8,-6},{8,6}},
        rotation=270,
        origin={-54,-116})));
  Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow
                                               pump2(
    redeclare package Medium = MediumW,
    allowFlowReversal=true,
    riseTime=1,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{9,-9},{-9,9}},
        rotation=0,
        origin={-119,-7})));
  Modelica.Blocks.Sources.IntegerConstant
                                     integerConstant(k=1)
    annotation (Placement(transformation(extent={{-368,34},{-348,54}})));
  Modelica.Blocks.Sources.BooleanConstant
                                     booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-336,2},{-316,22}})));
  Modelica.Blocks.Sources.Constant   const(k=1.01)
    annotation (Placement(transformation(extent={{-332,-40},{-312,-20}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumW,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-170,-109})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumW,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-114,-31})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumW,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-88,-69})));
equation

  connect(pump.port_b, valA4.port_3) annotation (Line(points={{-36,-60},{-44,
          -60},{-44,-136}},
                       color={0,127,255}));

  connect(SchTes.y[1], hybrid_2024_controller.scheduleInput) annotation (Line(
        points={{-311,82},{-294,82},{-294,51.8667},{-284.2,51.8667}}, color={0,
          0,127}));
  connect(hybrid_2024_controller.valA4, valA4.y) annotation (Line(points={{-257,
          43.3333},{-257,-176},{-44,-176},{-44,-153.6}}, color={0,0,127}));
  connect(hybrid_2024_controller.CP1, booleanToReal1.u) annotation (Line(points={{-257,
          34.8},{-257,-14},{-232,-14}},       color={255,0,255}));
  connect(booleanToReal1.y, pump.m_flow_in) annotation (Line(points={{-209,-14},
          {-164,-14},{-164,-50},{-48,-50},{-48,-38},{-14,-38},{-14,-50},{-24,
          -50}},
        color={0,0,127}));
  connect(hybrid_2024_controller.HP, booleanToReal3.u) annotation (Line(points={{-257,
          30.5333},{-257,-62},{-226,-62}},        color={255,0,255}));
  connect(valA4.y, valA3.y) annotation (Line(points={{-44,-153.6},{-44,-176},{
          -68,-176},{-68,2},{-52,2},{-52,32},{-36.5,32},{-36.5,29.1}},
                                                                 color={0,0,127}));
  connect(mFloRet3.port_b, valA4.port_1) annotation (Line(points={{-54,-124},{
          -54,-144}},            color={0,127,255}));
  connect(pump2.port_a, mFloRet1.port_b) annotation (Line(points={{-110,-7},{
          -110,-8},{-100,-8},{-100,16},{-76,16}}, color={0,127,255}));
  connect(pump2.m_flow_in, booleanToReal3.y) annotation (Line(points={{-119,3.8},
          {-134,3.8},{-134,2},{-176,2},{-176,-62},{-203,-62}}, color={0,0,127}));
  connect(integerConstant.y, hybrid_2024_controller.FCUmode) annotation (Line(
        points={{-347,44},{-292,44},{-292,41.2},{-284,41.2}},     color={255,
          127,0}));
  connect(booleanConstant.y, hybrid_2024_controller.FCUbool) annotation (Line(
        points={{-315,12},{-294,12},{-294,32.6667},{-284,32.6667}}, color={255,
          0,255}));
  connect(mFloRet.port_b, valA3.port_2) annotation (Line(points={{0,14},{-2,14},
          {-2,16.5},{-27,16.5}}, color={0,127,255}));
  connect(valA3.port_1, mFloRet1.port_a) annotation (Line(points={{-46,16.5},{
          -52,16.5},{-52,16},{-58,16}}, color={0,127,255}));
  connect(const.y, hybrid_2024_controller.SOChotPCM) annotation (Line(points={{
          -311,-30},{-290,-30},{-290,16},{-292,16},{-292,28.4},{-284,28.4}},
        color={0,0,127}));
  connect(const.y, hybrid_2024_controller.SOCcoldPCM) annotation (Line(points={
          {-311,-30},{-290,-30},{-290,16},{-292,16},{-292,24.1333},{-284,
          24.1333}}, color={0,0,127}));
  connect(valA4.port_2, mFloRet.port_a) annotation (Line(points={{-34,-144},{-6,
          -144},{-6,-134},{42,-134},{42,14},{18,14}}, color={0,127,255}));
  connect(boundary1.ports[1], pump2.port_b) annotation (Line(points={{-198,27},
          {-172,27},{-172,-7},{-128,-7}}, color={0,127,255}));
  connect(boundary2.ports[1], mFloRet3.port_a) annotation (Line(points={{-160,
          -109},{-160,-110},{-66,-110},{-66,-102},{-54,-102},{-54,-108}}, color=
         {0,127,255}));
  connect(valA3.port_3, boundary3.ports[1]) annotation (Line(points={{-36.5,6},
          {-36.5,4},{-70,4},{-70,-31},{-104,-31}}, color={0,127,255}));
  connect(boundary4.ports[1], pump.port_a) annotation (Line(points={{-78,-69},{
          -78,-70},{-12,-70},{-12,-32},{-36,-32},{-36,-40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-380,-180},
            {180,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-380,-180},{180,100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Hybrid_2024_v3_test2C;
