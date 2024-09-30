within CCC_test.Example2;
model ArisBufferTankGroup_1BufferTank_1Fcu_test
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
    parameter Modelica.Units.SI.MassFlowRate fcu_water_flow_nominal=0.11827;
parameter Modelica.Units.SI.MassFlowRate fcu_air_flow_nominal=0.14951;
  replaceable parameter Modelica.Units.SI.Temperature zone_temp_cooling_setpoint=273.15+22
    "Zone air temperature setpoint";
     replaceable parameter Modelica.Units.SI.Temperature zone_temp_heating_setpoint=273.15+20
    "Zone air temperature setpoint";

  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnit_hysteresis_air_control(
    redeclare package Medium1 = MediumPropyleneGlycol,
    m1_flow_nominal=fcu_water_flow_nominal,
    m2_flow_nominal=fcu_air_flow_nominal,
    zone_temp_cooling_setpoint=zone_temp_cooling_setpoint,
    zone_temp_heating_setpoint=zone_temp_heating_setpoint,
    dp1_nominal(displayUnit="Pa"),
    dp2_nominal(displayUnit="Pa") = 0)
    annotation (Placement(transformation(extent={{418,-180},{438,-160}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=fcu_water_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{366,-186},{386,-166}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumAir,
    m_flow_nominal=fcu_air_flow_nominal,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={410,-126})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{226,-200},{246,-180}})));
  CCC.Controls.SetpointController_variableSetpoint_reverseCapable setpointController10(
      gain_value=0.92)
    annotation (Placement(transformation(extent={{174,-192},{194,-172}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{144,-164},{164,-144}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{636,-164},{656,-144}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a5(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{230,-108},{250,-88}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b5(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{230,-432},{250,-412}})));
  Modelica.Blocks.Interfaces.BooleanOutput ModeBufferTankCommand
    "true for heating; false for cooling" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={302,-440})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{316,-376},{336,-356}})));
  Modelica.Blocks.Interfaces.RealInput TOut "outdoor air temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={408,-440})));
  Modelica.Blocks.Tables.CombiTable1Ds heatingTable(table=[273.15 - 6.7,273.15
         + 45; 273.15 + 4.4,273.15 + 35],   extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={406,-368})));
  Modelica.Blocks.Tables.CombiTable1Ds coolingTable(table=[273.15 + 21.1,273.15
         + 18.3; 273.15 + 37.8,273.15 + 7.2], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={482,-376})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={446,-330})));
  Modelica.Blocks.Interfaces.BooleanInput DhwRequestPriority
    "True if domestic hot water is requested, so that domestic hot water should be prioritized and we shut off water supply to space conditioning buffer tanks"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={140,-114})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={202,-100})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{128,-76},{148,-56}})));
  Modelica.Blocks.Interfaces.RealOutput BufferTankTempSetpoint annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={140,-368})));
  Buildings.Fluid.Storage.Stratified tan(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    VTan=0.15*1.5,
    hTan=0.764,
    dIns=0.05,
    nSeg=2,
    T_start=308.15)
    annotation (Placement(transformation(extent={{304,-74},{324,-54}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempBufferTanTop
    "top tank tempearture" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={382,-48})));
  Modelica.Blocks.Interfaces.RealInput TZoneAir annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={418,-88})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 48)
    annotation (Placement(transformation(extent={{378,-348},{398,-328}})));
  Buildings.Fluid.Sensors.VolumeFlowRate BufTanFlo(redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{254,-200},{274,-180}})));
  Buildings.Fluid.Sensors.VolumeFlowRate FCUWatFlo1(redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{332,-146},{352,-126}})));
  Modelica.Blocks.Interfaces.RealOutput BufferTankTemp annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={140,-412})));
  CCC.Controls.SingleLogicalDelay singleLogicalDelay1(delayTime(displayUnit="h")
       = 43200)
    annotation (Placement(transformation(extent={{520,-248},{540,-228}})));
  Modelica.Fluid.Sources.Boundary_pT boundary5(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={540,-171})));
equation
  connect(pump.port_b, fanCoilUnit_hysteresis_air_control.port_a1) annotation (
      Line(points={{386,-176},{412,-176},{412,-165.6},{417.8,-165.6}}, color={0,
          127,255}));
  connect(fanCoilUnit_hysteresis_air_control.m_flow_water, pump.m_flow_in)
    annotation (Line(points={{439.2,-161.8},{439.2,-152},{376,-152},{376,-164}},
        color={0,0,127}));
  connect(fanCoilUnit_hysteresis_air_control.port_b2, fan.port_a) annotation (
      Line(points={{417.8,-175},{410,-175},{410,-136}}, color={0,127,255}));
  connect(fanCoilUnit_hysteresis_air_control.m_flow_air, fan.m_flow_in)
    annotation (Line(points={{439.2,-178.2},{439.2,-188},{396,-188},{396,-144},
          {392,-144},{392,-126},{398,-126}}, color={0,0,127}));
  connect(port_a, fanCoilUnit_hysteresis_air_control.port_a2) annotation (Line(
        points={{154,-154},{226,-154},{226,-168},{236,-168},{236,-170},{238,-170},
          {238,-172},{264,-172},{264,-166},{352,-166},{352,-194},{446,-194},{
          446,-175.2},{438.2,-175.2}}, color={0,127,255}));
  connect(port_a5, pump2.port_a) annotation (Line(points={{240,-98},{240,-172},
          {234,-172},{234,-170},{220,-170},{220,-190},{226,-190}},
                                             color={0,127,255}));
  connect(not1.y, setpointController10.reverse) annotation (Line(points={{337,
          -366},{337,-368},{344,-368},{344,-384},{368,-384},{368,-404},{424,
          -404},{424,-252},{160,-252},{160,-188.6},{172,-188.6}},
                                 color={255,0,255}));
  connect(TOut, heatingTable.u) annotation (Line(points={{408,-440},{408,-388},
          {406,-388},{406,-380}}, color={0,0,127}));
  connect(TOut, coolingTable.u) annotation (Line(points={{408,-440},{408,-398},
          {482,-398},{482,-388}}, color={0,0,127}));
  connect(switch1.u3, coolingTable.y[1]) annotation (Line(points={{454,-342},{
          454,-360},{482,-360},{482,-365}}, color={0,0,127}));
  connect(switch1.y, setpointController10.setpoint) annotation (Line(points={{
          446,-319},{446,-312},{116,-312},{116,-178},{172,-178}}, color={0,0,
          127}));
  connect(const1.y, switch2.u1) annotation (Line(points={{149,-66},{182,-66},{
          182,-92},{190,-92}}, color={0,0,127}));
  connect(DhwRequestPriority, switch2.u2) annotation (Line(points={{140,-114},{
          180,-114},{180,-100},{190,-100}}, color={255,0,255}));
  connect(setpointController10.command, switch2.u3) annotation (Line(points={{
          195,-181.4},{200,-181.4},{200,-116},{190,-116},{190,-108}}, color={0,
          0,127}));
  connect(switch2.y, pump2.m_flow_in) annotation (Line(points={{213,-100},{222,
          -100},{222,-152},{236,-152},{236,-178}},                     color={0,
          0,127}));
  connect(BufferTankTempSetpoint, BufferTankTempSetpoint)
    annotation (Line(points={{140,-368},{140,-368}}, color={0,0,127}));
  connect(switch1.y, BufferTankTempSetpoint) annotation (Line(points={{446,-319},
          {304,-319},{304,-346},{166,-346},{166,-368},{140,-368}}, color={0,0,
          127}));
  connect(tempBufferTanTop.T, setpointController10.measurement) annotation (
      Line(points={{393,-48},{382,-48},{382,-82},{316,-82},{316,-76},{302,-76},
          {302,-68},{178,-68},{178,-170},{164,-170},{164,-183.2},{172,-183.2}},
        color={0,0,127}));
  connect(tempBufferTanTop.port, tan.heaPorVol[1]) annotation (Line(points={{
          372,-48},{314,-48},{314,-64.15}}, color={191,0,0}));
  connect(fanCoilUnit_hysteresis_air_control.port_b1, tan.port_b) annotation (
      Line(points={{438.2,-165.6},{468,-165.6},{468,-74},{314,-74}}, color={0,
          127,255}));
  connect(pump2.port_b, BufTanFlo.port_a)
    annotation (Line(points={{246,-190},{254,-190}}, color={0,127,255}));
  connect(BufTanFlo.port_b, tan.port_b) annotation (Line(points={{274,-190},{
          310,-190},{310,-80},{330,-80},{330,-74},{314,-74}}, color={0,127,255}));
  connect(tan.port_a, FCUWatFlo1.port_a) annotation (Line(points={{314,-54},{
          296,-54},{296,-136},{332,-136}}, color={0,127,255}));
  connect(FCUWatFlo1.port_b, pump.port_a) annotation (Line(points={{352,-136},{
          366,-136},{366,-176}}, color={0,127,255}));
  connect(tan.port_a, port_b5) annotation (Line(points={{314,-54},{296,-54},{
          296,-66},{276,-66},{276,-422},{240,-422}}, color={0,127,255}));
  connect(heatingTable.y[1], switch1.u1) annotation (Line(points={{406,-357},{
          406,-354},{438,-354},{438,-342}}, color={0,0,127}));
  connect(tempBufferTanTop.T, BufferTankTemp) annotation (Line(points={{393,-48},
          {422,-48},{422,-36},{450,-36},{450,-412},{140,-412}}, color={0,0,127}));
  connect(fanCoilUnit_hysteresis_air_control.FcuModeBoolean,
    singleLogicalDelay1.u) annotation (Line(points={{416,-178},{416,-180},{408,
          -180},{408,-208},{512,-208},{512,-238},{518,-238}}, color={255,0,255}));
  connect(singleLogicalDelay1.y, switch1.u2) annotation (Line(points={{542,-238},
          {548,-238},{548,-256},{424,-256},{424,-360},{446,-360},{446,-342}},
        color={255,0,255}));
  connect(singleLogicalDelay1.y, not1.u) annotation (Line(points={{542,-238},{
          548,-238},{548,-256},{424,-256},{424,-404},{368,-404},{368,-384},{308,
          -384},{308,-366},{314,-366}}, color={255,0,255}));
  connect(singleLogicalDelay1.y, ModeBufferTankCommand) annotation (Line(points
        ={{542,-238},{548,-238},{548,-256},{424,-256},{424,-404},{368,-404},{
          368,-384},{316,-384},{316,-408},{302,-408},{302,-440}}, color={255,0,
          255}));
  connect(fan.port_b, port_b) annotation (Line(points={{410,-116},{410,-110},{
          630,-110},{630,-154},{646,-154}}, color={0,0,127}));
  connect(fanCoilUnit_hysteresis_air_control.TZon, TZoneAir) annotation (Line(
        points={{432.4,-182},{432,-182},{432,-210},{504,-210},{504,-88},{418,
          -88}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{160,
            -420},{640,-100}}), graphics={
        Rectangle(
          extent={{388,-238},{254,-244}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{206,-190},{286,-230}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{206,-270},{286,-310}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{246,-166},{242,-190}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{328,-334},{248,-338}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{252,-310},{248,-334}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{206,-230},{286,-270}},
          lineColor={255,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{236,-240},{256,-260}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Rectangle(
          extent={{296,-182},{286,-316}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{206,-184},{196,-318}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{198,-182},{296,-190}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{198,-310},{296,-318}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{272,-178},{348,-178},{346,-178}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{302,-244},{302,-178},{304,-178}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{268,-324},{316,-324},{316,-178}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{206,-190},{286,-230}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{206,-270},{286,-310}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{246,-154},{242,-190}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{382,-332},{248,-338}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{252,-310},{248,-334}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{206,-230},{286,-270}},
          lineColor={255,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{236,-240},{256,-260}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Rectangle(
          extent={{296,-182},{286,-316}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{206,-184},{196,-318}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{198,-182},{296,-190}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{198,-310},{296,-318}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{272,-178},{348,-178},{346,-178}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{302,-244},{302,-178},{304,-178}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{268,-324},{316,-324},{316,-178}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{384,-140},{584,-172}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{458,-114},{542,-198}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{484,-120},{484,-190},{536,-156},{484,-120}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{488,-140},{520,-172}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          visible=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
          fillColor={0,100,199}),
        Rectangle(
          extent={{388,-228},{588,-260}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{462,-202},{546,-286}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{488,-208},{488,-278},{540,-244},{488,-208}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{492,-228},{524,-260}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          visible=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
          fillColor={0,100,199}),
        Rectangle(
          extent={{384,-318},{584,-350}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{458,-292},{542,-376}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{484,-298},{484,-368},{536,-334},{484,-298}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{488,-318},{520,-350}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          visible=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
          fillColor={0,100,199}),
        Rectangle(
          extent={{380,-154},{244,-160}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{160,-420},{640,
            -100}})));
end ArisBufferTankGroup_1BufferTank_1Fcu_test;
