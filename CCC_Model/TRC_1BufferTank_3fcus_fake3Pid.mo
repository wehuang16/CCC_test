within CCC_test.CCC_Model;
model TRC_1BufferTank_3fcus_fake3Pid
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
   parameter Modelica.Units.SI.MassFlowRate mHP_flow_nominal=0.92 "Nominal mass flow rate from the heat pump";
    parameter Modelica.Units.SI.MassFlowRate fcu_water_flow_nominal=0.11827;
parameter Modelica.Units.SI.MassFlowRate fcu_air_flow_nominal=0.14951;
  replaceable parameter Modelica.Units.SI.Temperature zone_temp_cooling_setpoint=273.15+23.89
    "Zone air temperature setpoint";
     replaceable parameter Modelica.Units.SI.Temperature zone_temp_heating_setpoint=273.15+21.11
    "Zone air temperature setpoint";

  Modelica.Fluid.Interfaces.FluidPort_a port_a[3](redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{144,-164},{164,-144}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b[3](redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{636,-164},{656,-144}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a5(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{230,-108},{250,-88}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b5(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{230,-432},{250,-412}})));
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
  Modelica.Blocks.Interfaces.RealOutput BufferTankTempSetpoint annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={140,-368})));
  Buildings.Fluid.Storage.Stratified tan(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    VTan=0.05*1.5,
    hTan=0.764,
    dIns=0.05,
    nSeg=2,
    T_start=308.15)
    annotation (Placement(transformation(extent={{304,-116},{324,-96}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempBufferTanTop
    "top tank tempearture" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={374,-42})));
  Modelica.Blocks.Interfaces.RealInput TZoneAir[3] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={418,-88})));
  Buildings.Fluid.Sensors.VolumeFlowRate BufTanFlo(redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{254,-200},{274,-180}})));
  Buildings.Fluid.Sensors.VolumeFlowRate FCUWatFlo[3](redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{324,16},{344,36}})));
  Modelica.Blocks.Interfaces.RealOutput BufferTankTemp annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={140,-412})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput heaCooMod
    "system heating cooling mode" annotation (Placement(transformation(extent={{120,
            -300},{160,-260}}),      iconTransformation(extent={{116,-258},{156,
            -218}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHP_flow_nominal,
    dpValve_nominal=1)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={240,-132})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre(h=5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={500,-282})));
  Buildings.Controls.OBC.CDL.Reals.Less les(h=5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={388,-292})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={418,-230})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput RequestSpaCon
    "1=heating; 0=deadband; -1=cooling" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={554,-440})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{586,-214},{606,-194}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{584,-270},{604,-250}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-1)
    annotation (Placement(transformation(extent={{528,-216},{548,-196}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=1)
    annotation (Placement(transformation(extent={{534,-178},{554,-158}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=0)
    annotation (Placement(transformation(extent={{540,-316},{560,-296}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal    booToRea
    annotation (Placement(transformation(extent={{286,-248},{306,-228}})));
  Buildings.Controls.OBC.CDL.Logical.Xor xor
    annotation (Placement(transformation(extent={{210,-298},{230,-278}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{250,-296},{270,-276}})));
  Buildings.Controls.OBC.CDL.Logical.Switch logSwi1
    annotation (Placement(transformation(extent={{330,-296},{350,-276}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=false)
    annotation (Placement(transformation(extent={{248,-326},{268,-306}})));
  CCC.Fluid.BaseClasses.BufferTankModeController2 bufferTankModeController2_1
    annotation (Placement(transformation(extent={{626,50},{646,70}})));
  CCC.Fluid.HeatExchangers.FanCoilUnitConstantEps fanCoilUnitConstantEps[3](
    redeclare package Medium1 = MediumPropyleneGlycol,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=fcu_water_flow_nominal,
    m2_flow_nominal=fcu_air_flow_nominal,
    temp_water_diff=5,
    dp1_nominal=10,
    dp2_nominal=10,
    eps=0.45) annotation (Placement(transformation(extent={{478,12},{498,32}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           pump[3](
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=fcu_water_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{380,14},{400,34}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           fan[3](
    redeclare package Medium = MediumAir,
    m_flow_nominal=fcu_air_flow_nominal,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{542,-40},{562,-20}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3
    annotation (Placement(transformation(extent={{156,-244},{176,-224}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(delayTime=120)
    annotation (Placement(transformation(extent={{194,-240},{214,-220}})));
  Buildings.Controls.OBC.CDL.Logical.Not not4
    annotation (Placement(transformation(extent={{234,-244},{254,-224}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=120)
    annotation (Placement(transformation(extent={{528,-244},{548,-224}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conInt3[3](k=
        zone_temp_cooling_setpoint)
    annotation (Placement(transformation(extent={{406,-36},{426,-16}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conInt4[3](k=
        zone_temp_heating_setpoint)
    annotation (Placement(transformation(extent={{444,-44},{464,-24}})));
equation
  connect(TOut, heatingTable.u) annotation (Line(points={{408,-440},{408,-388},
          {406,-388},{406,-380}}, color={0,0,127}));
  connect(TOut, coolingTable.u) annotation (Line(points={{408,-440},{408,-398},
          {482,-398},{482,-388}}, color={0,0,127}));
  connect(BufferTankTempSetpoint, BufferTankTempSetpoint)
    annotation (Line(points={{140,-368},{140,-368}}, color={0,0,127}));
  connect(switch1.y, BufferTankTempSetpoint) annotation (Line(points={{446,-319},
          {304,-319},{304,-346},{166,-346},{166,-368},{140,-368}}, color={0,0,
          127}));
  connect(tempBufferTanTop.port, tan.heaPorVol[1]) annotation (Line(points={{364,-42},
          {336,-42},{336,-106.15},{314,-106.15}},
                                            color={191,0,0}));
  connect(tempBufferTanTop.T, BufferTankTemp) annotation (Line(points={{385,-42},
          {388,-42},{388,-260},{368,-260},{368,-444},{140,-444},{140,-412}},
                                                                color={0,0,127}));
  connect(BufTanFlo.port_b, tan.port_a) annotation (Line(points={{274,-190},{
          286,-190},{286,-38},{314,-38},{314,-96}}, color={0,127,255}));
  connect(tan.port_b, port_b5) annotation (Line(points={{314,-116},{314,-422},{
          240,-422}}, color={0,127,255}));
  connect(port_a5, val.port_a)
    annotation (Line(points={{240,-98},{240,-122}}, color={0,127,255}));
  connect(val.port_b, BufTanFlo.port_a) annotation (Line(points={{240,-142},{
          240,-190},{254,-190}}, color={0,127,255}));
  connect(tempBufferTanTop.T, les.u1) annotation (Line(points={{385,-42},{388,
          -42},{388,-260},{368,-260},{368,-312},{388,-312},{388,-304}},
                                       color={0,0,127}));
  connect(gre.u1, tempBufferTanTop.T) annotation (Line(points={{500,-294},{500,
          -300},{468,-300},{468,-128},{388,-128},{388,-42},{385,-42}},
                                      color={0,0,127}));
  connect(les.y, logSwi.u1) annotation (Line(points={{388,-280},{388,-264},{410,
          -264},{410,-242}},
                  color={255,0,255}));
  connect(gre.y, logSwi.u3) annotation (Line(points={{500,-270},{500,-264},{426,
          -264},{426,-242}},            color={255,0,255}));
  connect(conInt1.y, intSwi.u1) annotation (Line(points={{556,-168},{576,-168},
          {576,-196},{584,-196}}, color={255,127,0}));
  connect(conInt.y, intSwi.u3) annotation (Line(points={{550,-206},{574,-206},{
          574,-212},{584,-212}}, color={255,127,0}));
  connect(conInt2.y, intSwi1.u3) annotation (Line(points={{562,-306},{574,-306},
          {574,-268},{582,-268}}, color={255,127,0}));
  connect(intSwi.y, intSwi1.u1) annotation (Line(points={{608,-204},{616,-204},
          {616,-244},{582,-244},{582,-252}}, color={255,127,0}));
  connect(intSwi1.y, RequestSpaCon) annotation (Line(points={{606,-260},{612,
          -260},{612,-440},{554,-440}}, color={255,127,0}));
  connect(heaCooMod, xor.u1) annotation (Line(points={{140,-280},{198,-280},{198,
          -288},{208,-288}}, color={255,0,255}));
  connect(xor.y, not2.u) annotation (Line(points={{232,-288},{240,-288},{240,-286},
          {248,-286}}, color={255,0,255}));
  connect(not2.y, logSwi1.u2)
    annotation (Line(points={{272,-286},{328,-286}}, color={255,0,255}));
  connect(logSwi.y, logSwi1.u1) annotation (Line(points={{418,-218},{418,-212},
          {354,-212},{354,-270},{322,-270},{322,-278},{328,-278}},
                      color={255,0,255}));
  connect(con.y, logSwi1.u3) annotation (Line(points={{270,-316},{320,-316},{320,
          -294},{328,-294}}, color={255,0,255}));
  connect(booToRea.y, val.y) annotation (Line(points={{308,-238},{308,-140},{304,
          -140},{304,-132},{252,-132}}, color={0,0,127}));
  connect(tan.port_a, FCUWatFlo[1].port_a) annotation (Line(points={{314,-96},{
          324,-96},{324,26}}, color={0,127,255}));
  connect(tan.port_a, FCUWatFlo[2].port_a) annotation (Line(points={{314,-96},{
          324,-96},{324,26}}, color={0,127,255}));
  connect(tan.port_a, FCUWatFlo[3].port_a) annotation (Line(points={{314,-96},{324,
          -96},{324,26}},     color={0,127,255}));
  connect(bufferTankModeController2_1.ModeBufferTank, intSwi.u2) annotation (
      Line(points={{648,59.8},{674,59.8},{674,-204},{584,-204}}, color={255,0,
          255}));
  connect(bufferTankModeController2_1.ModeBufferTank, switch1.u2) annotation (
      Line(points={{648,59.8},{658,59.8},{658,-364},{446,-364},{446,-342}},
        color={255,0,255}));
  connect(bufferTankModeController2_1.ModeBufferTank, logSwi.u2) annotation (
      Line(points={{648,59.8},{672,59.8},{672,58},{694,58},{694,-286},{418,-286},
          {418,-242}}, color={255,0,255}));
  connect(bufferTankModeController2_1.ModeBufferTank, xor.u2) annotation (Line(
        points={{648,59.8},{660,59.8},{660,74},{94,74},{94,-302},{208,-302},{
          208,-296}}, color={255,0,255}));
  connect(heatingTable.y[1], switch1.u1) annotation (Line(points={{406,-357},{406,
          -344},{428,-344},{428,-352},{438,-352},{438,-342}}, color={0,0,127}));
  connect(heatingTable.y[1], les.u2) annotation (Line(points={{406,-357},{406,-312},
          {396,-312},{396,-304}}, color={0,0,127}));
  connect(coolingTable.y[1], switch1.u3) annotation (Line(points={{482,-365},{482,
          -342},{454,-342}}, color={0,0,127}));
  connect(coolingTable.y[1], gre.u2) annotation (Line(points={{482,-365},{482,-308},
          {508,-308},{508,-294}}, color={0,0,127}));
  connect(fanCoilUnitConstantEps.port_a2, port_a) annotation (Line(points={{
          498.111,16.8},{520,16.8},{520,14},{542,14},{542,44},{154,44},{154,
          -154}}, color={0,127,255}));
  connect(FCUWatFlo.port_b, pump.port_a) annotation (Line(points={{344,26},{372,
          26},{372,24},{380,24}}, color={0,127,255}));
  connect(pump.port_b, fanCoilUnitConstantEps.port_a1) annotation (Line(points=
          {{400,24},{472,24},{472,26},{477.889,26}}, color={0,127,255}));
  connect(fanCoilUnitConstantEps.port_b2, fan.port_a) annotation (Line(points={
          {477.889,16.6},{480,16.6},{480,-30},{542,-30}}, color={0,127,255}));
  connect(fan.port_b, port_b) annotation (Line(points={{562,-30},{586,-30},{586,
          -34},{602,-34},{602,-154},{646,-154}}, color={0,127,255}));
  connect(logSwi1.y,not3. u) annotation (Line(points={{352,-286},{344,-286},{344,
          -204},{138,-204},{138,-234},{154,-234}}, color={255,0,255}));
  connect(not3.y,truDel1. u) annotation (Line(points={{178,-234},{178,-214},{192,
          -214},{192,-230}},     color={255,0,255}));
  connect(truDel1.y,not4. u) annotation (Line(points={{216,-230},{224,-230},{224,
          -234},{232,-234}},     color={255,0,255}));
  connect(not4.y, booToRea.u) annotation (Line(points={{256,-234},{270,-234},{270,
          -238},{284,-238}},     color={255,0,255}));
  connect(truDel.y, intSwi1.u2) annotation (Line(points={{550,-234},{566,-234},{
          566,-260},{582,-260}},  color={255,0,255}));
  connect(logSwi.y,truDel. u) annotation (Line(points={{418,-218},{518,-218},{518,
          -234},{526,-234}},
                      color={255,0,255}));
  connect(fanCoilUnitConstantEps.m_flow_air, fan.m_flow_in) annotation (Line(
        points={{498.667,13.8},{498.667,4},{552,4},{552,-18}}, color={0,0,127}));
  connect(pump.m_flow_in, fanCoilUnitConstantEps.m_flow_water) annotation (Line(
        points={{390,36},{388,36},{388,50},{498.667,50},{498.667,30.2}}, color=
          {0,0,127}));
  connect(TZoneAir, fanCoilUnitConstantEps.TZon) annotation (Line(points={{418,
          -88},{494.889,-88},{494.889,10}}, color={0,0,127}));
  connect(fanCoilUnitConstantEps[1].port_b1, tan.port_b) annotation (Line(
        points={{498.111,26.4},{498.111,-116},{314,-116}}, color={0,127,255}));
  connect(fanCoilUnitConstantEps[2].port_b1, tan.port_b) annotation (Line(
        points={{498.111,26.4},{498.111,-116},{314,-116}}, color={0,127,255}));
  connect(fanCoilUnitConstantEps[3].port_b1, tan.port_b) annotation (Line(
        points={{498.111,26.4},{498.111,-116},{314,-116}}, color={0,127,255}));
  connect(fanCoilUnitConstantEps.FcuMode, bufferTankModeController2_1.ModeFcu)
    annotation (Line(points={{482,10},{478,10},{478,-22},{616,-22},{616,60},{
          624,60}}, color={255,127,0}));
  connect(conInt4.y, fanCoilUnitConstantEps.zone_temp_heating_setpoint)
    annotation (Line(points={{466,-34},{476,-34},{476,-36},{485.889,-36},{
          485.889,9.8}}, color={0,0,127}));
  connect(conInt3.y, fanCoilUnitConstantEps.zone_temp_cooling_setpoint)
    annotation (Line(points={{428,-26},{460,-26},{460,-14},{490.111,-14},{
          490.111,10}}, color={0,0,127}));
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
end TRC_1BufferTank_3fcus_fake3Pid;
