within CCC_test.obsolete_eas_e;
model ArisMultiFamily_FullBuilding
    extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_R4
    annotation (Placement(transformation(extent={{118,86},{166,118}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_R4(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{276,94},{306,118}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_R4
    annotation (Placement(transformation(extent={{204,98},{230,118}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_R4(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{68,102},{88,122}})));
  Modelica.Blocks.Sources.Constant LivingRoomGain(k=0)
    annotation (Placement(transformation(extent={{-6,-196},{14,-176}})));
  CCC_test.obsolete_eas_e.ArisRoomModel_8apartments_NoInfiltration_NewYork
    arisRoomModel_8apartments_NoInfiltration_NewYork
    annotation (Placement(transformation(extent={{-16,-142},{34,140}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_R1(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{84,-126},{104,-106}})));
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_R1
    annotation (Placement(transformation(extent={{134,-142},{182,-110}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_R1
    annotation (Placement(transformation(extent={{220,-130},{246,-110}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_R1(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{292,-134},{322,-110}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_L1(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{-102,-140},{-82,-120}})));
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_L1
    annotation (Placement(transformation(extent={{-168,-144},{-120,-112}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_L1
    annotation (Placement(transformation(extent={{-224,-136},{-198,-116}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_L1(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{-276,-146},{-246,-122}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_L2(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{-90,-58},{-70,-38}})));
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_L2
    annotation (Placement(transformation(extent={{-156,-62},{-108,-30}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_L2
    annotation (Placement(transformation(extent={{-210,-56},{-184,-36}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_L2(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{-260,-60},{-230,-36}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_L3(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{-98,20},{-78,40}})));
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_L3
    annotation (Placement(transformation(extent={{-164,16},{-116,48}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_L3
    annotation (Placement(transformation(extent={{-218,22},{-192,42}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_L3(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{-268,18},{-238,42}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_L4(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{-98,104},{-78,124}})));
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_L4
    annotation (Placement(transformation(extent={{-164,100},{-116,132}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_L4
    annotation (Placement(transformation(extent={{-218,106},{-192,126}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_L4(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{-268,102},{-238,126}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_R2(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{66,-56},{86,-36}})));
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_R2
    annotation (Placement(transformation(extent={{116,-72},{164,-40}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_R2
    annotation (Placement(transformation(extent={{202,-60},{228,-40}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_R2(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{274,-64},{304,-40}})));
  CCC.Fluid.BaseClasses.HpSetpointController hpSetpointController_R3(
    SpaceHeatingTempDelta=6,
    SpaceCoolingTempDelta=-6,
    DomesticHotWaterTempDelta=6)
    annotation (Placement(transformation(extent={{66,20},{86,40}})));
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup_R3
    annotation (Placement(transformation(extent={{116,4},{164,36}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_R3
    annotation (Placement(transformation(extent={{202,16},{228,36}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_R3(
    TankTempSetpoint=322.15,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{274,12},{304,36}})));
equation
  connect(arisHeatPumpConfiguration_R4.port_b1, arisBufferTankFcuGroup_R4.port_a5)
    annotation (Line(points={{230.4,116.2},{236,116.2},{236,124},{126,124},{126,
          118.2}}, color={0,127,255}));
  connect(arisBufferTankFcuGroup_R4.port_b5, arisHeatPumpConfiguration_R4.port_a1)
    annotation (Line(points={{126,85.8},{126,76},{192,76},{192,116.2},{203.6,116.2}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_R4.port_b2, arisWaterTankGroup_R4.port_a)
    annotation (Line(points={{230.4,99.4},{264,99.4},{264,106.4},{275.6,106.4}},
        color={0,127,255}));
  connect(arisWaterTankGroup_R4.port_b, arisHeatPumpConfiguration_R4.port_a2)
    annotation (Line(points={{306.4,106.2},{308,106.2},{308,92},{270,92},{270,90},
          {198,90},{198,99.4},{203.6,99.4}}, color={0,127,255}));
  connect(arisWaterTankGroup_R4.RequestDhw, arisBufferTankFcuGroup_R4.DhwRequestPriority)
    annotation (Line(points={{298.4,120},{298.4,58},{90,58},{90,104},{52,104},{52,
          164},{50,164},{50,182},{114,182},{114,176},{116,176},{116,116.6}},
        color={255,0,255}));
  connect(hpSetpointController_R4.ModeHp, arisHeatPumpConfiguration_R4.ModeHp)
    annotation (Line(points={{90,116.8},{108,116.8},{108,122},{118,122},{118,128},
          {203,128},{203,111.8}}, color={255,0,255}));
  connect(hpSetpointController_R4.TSupSet, arisHeatPumpConfiguration_R4.TSupSet)
    annotation (Line(points={{90,107.2},{108,107.2},{108,70},{194,70},{194,106.6},
          {203,106.6}}, color={0,0,127}));
  connect(arisBufferTankFcuGroup_R4.BufferTankTempSetpoint,
    hpSetpointController_R4.BufferTankTempSetpoint) annotation (Line(points={{116,
          91.2},{104,91.2},{104,126},{94,126},{94,128},{66,128},{66,119.8}},
        color={0,0,127}));
  connect(arisWaterTankGroup_R4.HotWaterTankTempSetpoint,
    hpSetpointController_R4.HotWaterTankTempSetpoint) annotation (Line(points={{
          274,98.8},{266,98.8},{266,134},{64,134},{64,128},{58,128},{58,114.6},{
          66,114.6}}, color={0,0,127}));
  connect(arisWaterTankGroup_R4.RequestDhw, hpSetpointController_R4.RequestDhw)
    annotation (Line(points={{298.4,120},{298.4,62},{90,62},{90,86},{52,86},{52,
          130},{66,130},{66,109.6}}, color={255,0,255}));
  connect(arisBufferTankFcuGroup_R4.ModeBufferTankCommand,
    hpSetpointController_R4.ModeBufferTankCommand) annotation (Line(points={{132.2,
          84},{132.2,78},{126,78},{126,80},{118,80},{118,78},{96,78},{96,88},{92,
          88},{92,92},{60,92},{60,105},{66,105}}, color={255,0,255}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_RLiv4)
    annotation (Line(points={{15,-186},{40,-186},{40,114.876},{34.2381,114.876}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_R4.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RLiv4)
    annotation (Line(points={{143.8,119.2},{143.8,136},{44,136},{44,97.4436},{
          34.9524,97.4436}},
                     color={0,0,127}));
  connect(arisBufferTankFcuGroup_R4.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedA4)
    annotation (Line(points={{151,119.2},{151,140},{42,140},{42,86},{44,86},{44,
          78.9855},{35.1905,78.9855}}, color={0,0,127}));
  connect(arisBufferTankFcuGroup_R4.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedB4)
    annotation (Line(points={{159.4,119.2},{159.4,122},{168,122},{168,66},{48,
          66},{48,58.9891},{34.9524,58.9891}},
                                           color={0,0,127}));
  connect(arisBufferTankFcuGroup_R4.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RLiv4) annotation (
      Line(points={{166.6,112.6},{168,112.6},{168,126},{106,126},{106,128},{46,
          128},{46,109.236},{34.3571,109.236}},
                                           color={0,127,255}));
  connect(arisBufferTankFcuGroup_R4.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedA4) annotation (
     Line(points={{166.4,105.2},{168,105.2},{168,78},{118,78},{118,84},{44,84},
          {44,89.7527},{35.0714,89.7527}},color={0,127,255}));
  connect(arisBufferTankFcuGroup_R4.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedB4) annotation (
     Line(points={{166.4,98.2},{168,98.2},{168,71.8073},{35.0714,71.8073}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_R4.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{54,144},{54,74},{142.8,74},{142.8,84}},
                                                        color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_R4.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{54,144},{54,74},{202,74},{202,96},{231,96},{231,108.2}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_R4.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RLiv4) annotation (
      Line(points={{117.4,112.6},{102,112.6},{102,100},{46,100},{46,103.084},{
          34.7143,103.084}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_R4.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedA4) annotation (
     Line(points={{117.2,105.2},{100,105.2},{100,94},{44,94},{44,83.6},{34.9524,
          83.6}}, color={0,127,255}));
  connect(arisBufferTankFcuGroup_R4.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedB4) annotation (
     Line(points={{117.4,98},{102,98},{102,65.1418},{35.1905,65.1418}}, color={0,
          127,255}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_RLiv3)
    annotation (Line(points={{15,-186},{40,-186},{40,44.6327},{34.4762,44.6327}},
        color={0,0,127}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_RLiv2)
    annotation (Line(points={{15,-186},{40,-186},{40,-20.9964},{34.4762,
          -20.9964}},                                                    color=
          {0,0,127}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_RLiv1)
    annotation (Line(points={{15,-186},{40,-186},{40,-86.6255},{35.1905,
          -86.6255}},
        color={0,0,127}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_LLiv4)
    annotation (Line(points={{15,-186},{40,-186},{40,158},{-22,158},{-22,
          115.902},{-16.9524,115.902}},
                  color={0,0,127}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_LLiv3)
    annotation (Line(points={{15,-186},{40,-186},{40,158},{-22,158},{-22,
          46.6836},{-16.9524,46.6836}},                       color={0,0,127}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_LLiv2)
    annotation (Line(points={{15,-186},{40,-186},{40,158},{-22,158},{-22,
          -20.9964},{-16.7143,-20.9964}},                   color={0,0,127}));
  connect(LivingRoomGain.y, arisRoomModel_8apartments_NoInfiltration_NewYork.SensibleGain_LLiv1)
    annotation (Line(points={{15,-186},{20,-186},{20,-148},{-24,-148},{-24,
          -85.6},{-17.1905,-85.6}},                                    color={0,
          0,127}));

    connect(arisHeatPumpConfiguration_R1.port_b1, arisBufferTankFcuGroup_R1.port_a5)
    annotation (Line(points={{246.4,-111.8},{248,-111.8},{248,-104},{142,-104},{
          142,-109.8}},
                   color={0,127,255}));
  connect(arisBufferTankFcuGroup_R1.port_b5, arisHeatPumpConfiguration_R1.port_a1)
    annotation (Line(points={{142,-142.2},{142,-152},{210,-152},{210,-111.8},{219.6,
          -111.8}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_R1.port_b2, arisWaterTankGroup_R1.port_a)
    annotation (Line(points={{246.4,-128.6},{282,-128.6},{282,-121.6},{291.6,-121.6}},
        color={0,127,255}));
  connect(arisWaterTankGroup_R1.port_b, arisHeatPumpConfiguration_R1.port_a2)
    annotation (Line(points={{322.4,-121.8},{324,-121.8},{324,-136},{214,-136},{
          214,-128.6},{219.6,-128.6}},       color={0,127,255}));
  connect(arisWaterTankGroup_R1.RequestDhw, arisBufferTankFcuGroup_R1.DhwRequestPriority)
    annotation (Line(points={{314.4,-108},{324,-108},{324,-190},{78,-190},{78,-118},
          {72,-118},{72,-100},{132,-100},{132,-111.4}},
        color={255,0,255}));
  connect(hpSetpointController_R1.ModeHp, arisHeatPumpConfiguration_R1.ModeHp)
    annotation (Line(points={{106,-111.2},{124,-111.2},{124,-104},{140,-104},{140,
          -102},{219,-102},{219,-116.2}},
                                  color={255,0,255}));
  connect(hpSetpointController_R1.TSupSet, arisHeatPumpConfiguration_R1.TSupSet)
    annotation (Line(points={{106,-120.8},{118,-120.8},{118,-106},{212,-106},{212,
          -121.4},{219,-121.4}},
                        color={0,0,127}));
  connect(arisBufferTankFcuGroup_R1.BufferTankTempSetpoint,
    hpSetpointController_R1.BufferTankTempSetpoint) annotation (Line(points={{132,
          -136.8},{132,-148},{74,-148},{74,-108.2},{82,-108.2}},
        color={0,0,127}));
  connect(arisWaterTankGroup_R1.HotWaterTankTempSetpoint,
    hpSetpointController_R1.HotWaterTankTempSetpoint) annotation (Line(points={{290,
          -129.2},{248,-129.2},{248,-154},{76,-154},{76,-113.4},{82,-113.4}},
                      color={0,0,127}));
  connect(arisWaterTankGroup_R1.RequestDhw, hpSetpointController_R1.RequestDhw)
    annotation (Line(points={{314.4,-108},{314.4,-100},{134,-100},{134,-98},{70,
          -98},{70,-118.4},{82,-118.4}},
                                     color={255,0,255}));
  connect(arisBufferTankFcuGroup_R1.ModeBufferTankCommand,
    hpSetpointController_R1.ModeBufferTankCommand) annotation (Line(points={{148.2,
          -144},{148.2,-150},{82,-150},{82,-123}},color={255,0,255}));
  connect(arisBufferTankFcuGroup_R1.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RLiv1)
    annotation (Line(points={{159.8,-108.8},{159.8,-94},{46,-94},{46,-104.058},
          {35.1905,-104.058}},
                     color={0,0,127}));
  connect(arisBufferTankFcuGroup_R1.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedA1)
    annotation (Line(points={{167,-108.8},{167,-90},{35.4286,-90},{35.4286,
          -122.516}},                  color={0,0,127}));
  connect(arisBufferTankFcuGroup_R1.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedB1)
    annotation (Line(points={{175.4,-108.8},{175.4,-106},{122,-106},{122,-114},
          {120,-114},{120,-138},{42,-138},{42,-142.513},{35.1905,-142.513}},
                                           color={0,0,127}));
  connect(arisBufferTankFcuGroup_R1.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RLiv1) annotation (
      Line(points={{182.6,-115.4},{184,-115.4},{184,-96},{162,-96},{162,
          -92.2655},{35.3095,-92.2655}},   color={0,127,255}));
  connect(arisBufferTankFcuGroup_R1.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedA1) annotation (
     Line(points={{182.4,-122.8},{184,-122.8},{184,-98},{136,-98},{136,-96},{48,
          -96},{48,-111.749},{35.3095,-111.749}},
                                          color={0,127,255}));
  connect(arisBufferTankFcuGroup_R1.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedB1) annotation (
     Line(points={{182.4,-129.8},{188,-129.8},{188,-156},{84,-156},{84,-129.695},
          {35.3095,-129.695}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_R1.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{54,144},{54,74},{250,74},{250,-160},{158.8,-160},{158.8,
          -144}},                                       color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_R1.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{54,144},{54,74},{247,74},{247,-119.8}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_R1.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RLiv1) annotation (
      Line(points={{133.4,-115.4},{118,-115.4},{118,-110},{116,-110},{116,
          -98.4182},{34.9524,-98.4182}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_R1.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedA1) annotation (
     Line(points={{133.2,-122.8},{114,-122.8},{114,-132},{46,-132},{46,-117.902},
          {35.1905,-117.902}},
                  color={0,127,255}));
  connect(arisBufferTankFcuGroup_R1.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedB1) annotation (
     Line(points={{133.4,-130},{70,-130},{70,-136.36},{34.9524,-136.36}},
                                                                        color={0,
          127,255}));

  connect(arisHeatPumpConfiguration_R2.port_b1, arisBufferTankFcuGroup_R2.port_a5)
    annotation (Line(points={{228.4,-41.8},{228.4,-34},{124,-34},{124,-39.8}},
                   color={0,127,255}));
  connect(arisBufferTankFcuGroup_R2.port_b5, arisHeatPumpConfiguration_R2.port_a1)
    annotation (Line(points={{124,-72.2},{124,-82},{201.6,-82},{201.6,-41.8}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_R2.port_b2, arisWaterTankGroup_R2.port_a)
    annotation (Line(points={{228.4,-58.6},{262,-58.6},{262,-51.6},{273.6,-51.6}},
        color={0,127,255}));
  connect(arisWaterTankGroup_R2.port_b, arisHeatPumpConfiguration_R2.port_a2)
    annotation (Line(points={{304.4,-51.8},{310,-51.8},{310,-70},{201.6,-70},{201.6,
          -58.6}},                           color={0,127,255}));
  connect(arisWaterTankGroup_R2.RequestDhw, arisBufferTankFcuGroup_R2.DhwRequestPriority)
    annotation (Line(points={{296.4,-38},{296.4,-30},{114,-30},{114,-41.4}},
        color={255,0,255}));
  connect(hpSetpointController_R2.ModeHp, arisHeatPumpConfiguration_R2.ModeHp)
    annotation (Line(points={{88,-41.2},{88,-30},{116,-30},{116,-34},{122,-34},{
          122,-32},{201,-32},{201,-46.2}},
                                  color={255,0,255}));
  connect(hpSetpointController_R2.TSupSet, arisHeatPumpConfiguration_R2.TSupSet)
    annotation (Line(points={{88,-50.8},{108,-50.8},{108,-28},{201,-28},{201,-51.4}},
                        color={0,0,127}));
  connect(arisBufferTankFcuGroup_R2.BufferTankTempSetpoint,
    hpSetpointController_R2.BufferTankTempSetpoint) annotation (Line(points={{114,
          -66.8},{102,-66.8},{102,-28},{64,-28},{64,-38.2}},
        color={0,0,127}));
  connect(arisWaterTankGroup_R2.HotWaterTankTempSetpoint,
    hpSetpointController_R2.HotWaterTankTempSetpoint) annotation (Line(points={{272,
          -59.2},{238,-59.2},{238,-24},{64,-24},{64,-43.4}},
                      color={0,0,127}));
  connect(arisWaterTankGroup_R2.RequestDhw, hpSetpointController_R2.RequestDhw)
    annotation (Line(points={{296.4,-38},{296.4,-30},{114,-30},{114,-34},{70,-34},
          {70,-30},{56,-30},{56,-34},{54,-34},{54,-48.4},{64,-48.4}},
                                     color={255,0,255}));
  connect(arisBufferTankFcuGroup_R2.ModeBufferTankCommand,
    hpSetpointController_R2.ModeBufferTankCommand) annotation (Line(points={{130.2,
          -74},{130.2,-84},{100,-84},{100,-64},{64,-64},{64,-53}},
                                                  color={255,0,255}));
  connect(arisBufferTankFcuGroup_R2.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RLiv2)
    annotation (Line(points={{141.8,-38.8},{141.8,-26},{48,-26},{48,-38.4291},{
          35.1905,-38.4291}},
                     color={0,0,127}));
  connect(arisBufferTankFcuGroup_R2.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedA2)
    annotation (Line(points={{149,-38.8},{149,-22},{44,-22},{44,-56.8873},{
          35.4286,-56.8873}},          color={0,0,127}));
  connect(arisBufferTankFcuGroup_R2.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedB2)
    annotation (Line(points={{157.4,-38.8},{157.4,-36},{106,-36},{106,-76.8836},
          {35.1905,-76.8836}},             color={0,0,127}));
  connect(arisBufferTankFcuGroup_R2.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RLiv2) annotation (
      Line(points={{164.6,-45.4},{164.6,-18},{42,-18},{42,-26.6364},{34.5952,
          -26.6364}},                      color={0,127,255}));
  connect(arisBufferTankFcuGroup_R2.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedA2) annotation (
     Line(points={{164.4,-52.8},{166,-52.8},{166,-26},{62,-26},{62,-24},{42,-24},
          {42,-46.12},{35.3095,-46.12}},  color={0,127,255}));
  connect(arisBufferTankFcuGroup_R2.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedB2) annotation (
     Line(points={{164.4,-59.8},{166,-59.8},{166,-34},{98,-34},{98,-64.0655},{
          35.3095,-64.0655}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_R2.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{54,144},{54,74},{248,74},{248,-84},{140.8,-84},{140.8,
          -74}},                                        color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_R2.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{54,144},{54,74},{248,74},{248,-49.8},{229,-49.8}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_R2.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RLiv2) annotation (
      Line(points={{115.4,-45.4},{96,-45.4},{96,-24},{46,-24},{46,-32.7891},{
          34.9524,-32.7891}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_R2.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedA2) annotation (
     Line(points={{115.2,-52.8},{96,-52.8},{96,-62},{42,-62},{42,-52.2727},{
          35.1905,-52.2727}},
                  color={0,127,255}));
  connect(arisBufferTankFcuGroup_R2.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedB2) annotation (
     Line(points={{115.4,-60},{46,-60},{46,-71.2436},{35.4286,-71.2436}},
                                                                        color={0,
          127,255}));

  connect(arisHeatPumpConfiguration_R3.port_b1, arisBufferTankFcuGroup_R3.port_a5)
    annotation (Line(points={{228.4,34.2},{230,34.2},{230,38},{194,38},{194,40},
          {170,40},{170,42},{124,42},{124,36.2}},
                   color={0,127,255}));
  connect(arisBufferTankFcuGroup_R3.port_b5, arisHeatPumpConfiguration_R3.port_a1)
    annotation (Line(points={{124,3.8},{124,-4},{176,-4},{176,34.2},{201.6,34.2}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_R3.port_b2, arisWaterTankGroup_R3.port_a)
    annotation (Line(points={{228.4,17.4},{262,17.4},{262,24.4},{273.6,24.4}},
        color={0,127,255}));
  connect(arisWaterTankGroup_R3.port_b, arisHeatPumpConfiguration_R3.port_a2)
    annotation (Line(points={{304.4,24.2},{310,24.2},{310,6},{201.6,6},{201.6,17.4}},
                                             color={0,127,255}));
  connect(arisWaterTankGroup_R3.RequestDhw, arisBufferTankFcuGroup_R3.DhwRequestPriority)
    annotation (Line(points={{296.4,38},{296.4,44},{114,44},{114,34.6}},
        color={255,0,255}));
  connect(hpSetpointController_R3.ModeHp, arisHeatPumpConfiguration_R3.ModeHp)
    annotation (Line(points={{88,34.8},{106,34.8},{106,42},{201,42},{201,29.8}},
                                  color={255,0,255}));
  connect(hpSetpointController_R3.TSupSet, arisHeatPumpConfiguration_R3.TSupSet)
    annotation (Line(points={{88,25.2},{100,25.2},{100,40},{170,40},{170,24.6},{
          201,24.6}},   color={0,0,127}));
  connect(arisBufferTankFcuGroup_R3.BufferTankTempSetpoint,
    hpSetpointController_R3.BufferTankTempSetpoint) annotation (Line(points={{114,9.2},
          {56,9.2},{56,37.8},{64,37.8}},
        color={0,0,127}));
  connect(arisWaterTankGroup_R3.HotWaterTankTempSetpoint,
    hpSetpointController_R3.HotWaterTankTempSetpoint) annotation (Line(points={{272,
          16.8},{238,16.8},{238,46},{58,46},{58,42},{54,42},{54,32.6},{64,32.6}},
                      color={0,0,127}));
  connect(arisWaterTankGroup_R3.RequestDhw, hpSetpointController_R3.RequestDhw)
    annotation (Line(points={{296.4,38},{296.4,44},{102,44},{102,46},{58,46},{58,
          27.6},{64,27.6}},          color={255,0,255}));
  connect(arisBufferTankFcuGroup_R3.ModeBufferTankCommand,
    hpSetpointController_R3.ModeBufferTankCommand) annotation (Line(points={{130.2,2},
          {130.2,-4},{112,-4},{112,2},{100,2},{100,12},{58,12},{58,23},{64,23}},
                                                  color={255,0,255}));
  connect(arisBufferTankFcuGroup_R3.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RLiv3)
    annotation (Line(points={{141.8,37.2},{141.8,50},{35.1905,50},{35.1905,27.2}},
                     color={0,0,127}));
  connect(arisBufferTankFcuGroup_R3.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedA3)
    annotation (Line(points={{149,37.2},{149,40},{104,40},{104,8.74182},{
          35.4286,8.74182}},           color={0,0,127}));
  connect(arisBufferTankFcuGroup_R3.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_RBedB3)
    annotation (Line(points={{157.4,37.2},{157.4,40},{102,40},{102,-11.2545},{
          35.1905,-11.2545}},              color={0,0,127}));
  connect(arisBufferTankFcuGroup_R3.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RLiv3) annotation (
      Line(points={{164.6,30.6},{166,30.6},{166,48},{44,48},{44,38.9927},{
          34.5952,38.9927}},               color={0,127,255}));
  connect(arisBufferTankFcuGroup_R3.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedA3) annotation (
     Line(points={{164.4,23.2},{164.4,42},{70,42},{70,44},{35.3095,44},{35.3095,
          19.5091}},                      color={0,127,255}));
  connect(arisBufferTankFcuGroup_R3.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_RBedB3) annotation (
     Line(points={{164.4,16.2},{166,16.2},{166,42},{106,42},{106,1.56364},{
          35.3095,1.56364}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_R3.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{54,144},{54,74},{196,74},{196,40},{248,40},{248,-8},{
          140.8,-8},{140.8,2}},                         color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_R3.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{54,144},{54,74},{196,74},{196,40},{234,40},{234,26.2},{
          229,26.2}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_R3.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RLiv3) annotation (
      Line(points={{115.4,30.6},{98,30.6},{98,44},{54,44},{54,42},{46,42},{46,
          32.84},{34.9524,32.84}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_R3.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedA3) annotation (
     Line(points={{115.2,23.2},{96,23.2},{96,13.3564},{35.1905,13.3564}},
                  color={0,127,255}));
  connect(arisBufferTankFcuGroup_R3.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_RBedB3) annotation (
     Line(points={{115.4,16},{46,16},{46,-5.10182},{34.4762,-5.10182}}, color={0,
          127,255}));

  connect(arisHeatPumpConfiguration_L1.port_b1, arisBufferTankFcuGroup_L1.port_a5)
    annotation (Line(points={{-197.6,-117.8},{-180,-117.8},{-180,-111.8},{-160,
          -111.8}},color={0,127,255}));
  connect(arisBufferTankFcuGroup_L1.port_b5, arisHeatPumpConfiguration_L1.port_a1)
    annotation (Line(points={{-160,-144.2},{-160,-150},{-230,-150},{-230,-117.8},
          {-224.4,-117.8}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_L1.port_b2, arisWaterTankGroup_L1.port_a)
    annotation (Line(points={{-197.6,-134.6},{-196,-134.6},{-196,-138},{-240,
          -138},{-240,-152},{-286,-152},{-286,-133.6},{-276.4,-133.6}},
        color={0,127,255}));
  connect(arisWaterTankGroup_L1.port_b, arisHeatPumpConfiguration_L1.port_a2)
    annotation (Line(points={{-245.6,-133.8},{-235,-133.8},{-235,-134.6},{
          -224.4,-134.6}},                   color={0,127,255}));
  connect(arisWaterTankGroup_L1.RequestDhw, arisBufferTankFcuGroup_L1.DhwRequestPriority)
    annotation (Line(points={{-253.6,-120},{-253.6,-92},{-170,-92},{-170,-113.4}},
        color={255,0,255}));
  connect(hpSetpointController_L1.ModeHp, arisHeatPumpConfiguration_L1.ModeHp)
    annotation (Line(points={{-80,-125.2},{-72,-125.2},{-72,-102},{-234,-102},{
          -234,-122.2},{-225,-122.2}},
                                  color={255,0,255}));
  connect(hpSetpointController_L1.TSupSet, arisHeatPumpConfiguration_L1.TSupSet)
    annotation (Line(points={{-80,-134.8},{-80,-154},{-232,-154},{-232,-127.4},
          {-225,-127.4}},
                        color={0,0,127}));
  connect(arisBufferTankFcuGroup_L1.BufferTankTempSetpoint,
    hpSetpointController_L1.BufferTankTempSetpoint) annotation (Line(points={{-170,
          -138.8},{-178,-138.8},{-178,-152},{-112,-152},{-112,-122.2},{-104,
          -122.2}},
        color={0,0,127}));
  connect(arisWaterTankGroup_L1.HotWaterTankTempSetpoint,
    hpSetpointController_L1.HotWaterTankTempSetpoint) annotation (Line(points={{-278,
          -141.2},{-288,-141.2},{-288,-158},{-136,-158},{-136,-150},{-114,-150},
          {-114,-127.4},{-104,-127.4}},
                      color={0,0,127}));
  connect(arisWaterTankGroup_L1.RequestDhw, hpSetpointController_L1.RequestDhw)
    annotation (Line(points={{-253.6,-120},{-253.6,-92},{-170,-92},{-170,-106},
          {-118,-106},{-118,-146},{-104,-146},{-104,-132.4}},
                                     color={255,0,255}));
  connect(arisBufferTankFcuGroup_L1.ModeBufferTankCommand,
    hpSetpointController_L1.ModeBufferTankCommand) annotation (Line(points={{-153.8,
          -146},{-153.8,-152},{-104,-152},{-104,-137}},
                                                  color={255,0,255}));
  connect(arisBufferTankFcuGroup_L1.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LLiv1)
    annotation (Line(points={{-142.2,-110.8},{-142.2,-108},{-26,-108},{-26,
          -104.058},{-17.4286,-104.058}},
                     color={0,0,127}));
  connect(arisBufferTankFcuGroup_L1.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedA1)
    annotation (Line(points={{-135,-110.8},{-136,-110.8},{-136,-100},{-68,-100},
          {-68,-123.029},{-17.1905,-123.029}},
                                       color={0,0,127}));
  connect(arisBufferTankFcuGroup_L1.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedB1)
    annotation (Line(points={{-126.6,-110.8},{-126.6,-108},{-114,-108},{-114,
          -114},{-22,-114},{-22,-140.975},{-17.1905,-140.975}},
                                           color={0,0,127}));
  connect(arisBufferTankFcuGroup_L1.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LLiv1) annotation (
      Line(points={{-119.4,-117.4},{-118,-117.4},{-118,-102},{-22,-102},{-22,
          -91.7527},{-17.3095,-91.7527}},  color={0,127,255}));
  connect(arisBufferTankFcuGroup_L1.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedA1) annotation (
     Line(points={{-119.6,-124.8},{-114,-124.8},{-114,-111.749},{-16.3571,
          -111.749}},                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_L1.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedB1) annotation (
     Line(points={{-119.6,-131.8},{-119.6,-156},{-66,-156},{-66,-130.207},{
          -16.5952,-130.207}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_L1.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{54,144},{54,74},{-143.2,74},{-143.2,-146}},
                                                        color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_L1.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{-22,144},{-22,120},{-152,120},{-152,-125.8},{-197,
          -125.8}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_L1.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LLiv1) annotation (
      Line(points={{-168.6,-117.4},{-178,-117.4},{-178,-98},{-142,-98},{-142,
          -88},{-26,-88},{-26,-98.4182},{-16.9524,-98.4182}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_L1.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedA1) annotation (
     Line(points={{-168.8,-124.8},{-176,-124.8},{-176,-106},{-166,-106},{-166,
          -108},{-114,-108},{-114,-116},{-26,-116},{-26,-117.902},{-16.4762,
          -117.902}},
                  color={0,127,255}));
  connect(arisBufferTankFcuGroup_L1.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedB1) annotation (
     Line(points={{-168.6,-132},{-182,-132},{-182,-160},{-26,-160},{-26,-136.36},
          {-16.4762,-136.36}},                                          color={0,
          127,255}));

  connect(arisHeatPumpConfiguration_L2.port_b1, arisBufferTankFcuGroup_L2.port_a5)
    annotation (Line(points={{-183.6,-37.8},{-182,-37.8},{-182,-24},{-148,-24},
          {-148,-29.8}},
                   color={0,127,255}));
  connect(arisBufferTankFcuGroup_L2.port_b5, arisHeatPumpConfiguration_L2.port_a1)
    annotation (Line(points={{-148,-62.2},{-148,-64},{-216,-64},{-216,-37.8},{
          -210.4,-37.8}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_L2.port_b2, arisWaterTankGroup_L2.port_a)
    annotation (Line(points={{-183.6,-54.6},{-182,-54.6},{-182,-30},{-230,-30},
          {-230,-26},{-266,-26},{-266,-47.6},{-260.4,-47.6}},
        color={0,127,255}));
  connect(arisWaterTankGroup_L2.port_b, arisHeatPumpConfiguration_L2.port_a2)
    annotation (Line(points={{-229.6,-47.8},{-216,-47.8},{-216,-54.6},{-210.4,
          -54.6}},                           color={0,127,255}));
  connect(arisWaterTankGroup_L2.RequestDhw, arisBufferTankFcuGroup_L2.DhwRequestPriority)
    annotation (Line(points={{-237.6,-34},{-237.6,-24},{-180,-24},{-180,-30},{
          -166,-30},{-166,-31.4},{-158,-31.4}},
        color={255,0,255}));
  connect(hpSetpointController_L2.ModeHp, arisHeatPumpConfiguration_L2.ModeHp)
    annotation (Line(points={{-68,-43.2},{-62,-43.2},{-62,-22},{-211,-22},{-211,
          -42.2}},                color={255,0,255}));
  connect(hpSetpointController_L2.TSupSet, arisHeatPumpConfiguration_L2.TSupSet)
    annotation (Line(points={{-68,-52.8},{-60,-52.8},{-60,-20},{-178,-20},{-178,
          -62},{-211,-62},{-211,-47.4}},
                        color={0,0,127}));
  connect(arisBufferTankFcuGroup_L2.BufferTankTempSetpoint,
    hpSetpointController_L2.BufferTankTempSetpoint) annotation (Line(points={{-158,
          -56.8},{-164,-56.8},{-164,-44},{-166,-44},{-166,-26},{-142,-26},{-142,
          -24},{-102,-24},{-102,-32},{-92,-32},{-92,-40.2}},
        color={0,0,127}));
  connect(arisWaterTankGroup_L2.HotWaterTankTempSetpoint,
    hpSetpointController_L2.HotWaterTankTempSetpoint) annotation (Line(points={{-262,
          -55.2},{-270,-55.2},{-270,-16},{-102,-16},{-102,-30},{-92,-30},{-92,
          -45.4}},    color={0,0,127}));
  connect(arisWaterTankGroup_L2.RequestDhw, hpSetpointController_L2.RequestDhw)
    annotation (Line(points={{-237.6,-34},{-237.6,-24},{-180,-24},{-180,-30},{
          -164,-30},{-164,-26},{-92,-26},{-92,-50.4}},
                                     color={255,0,255}));
  connect(arisBufferTankFcuGroup_L2.ModeBufferTankCommand,
    hpSetpointController_L2.ModeBufferTankCommand) annotation (Line(points={{-141.8,
          -64},{-141.8,-72},{-100,-72},{-100,-55},{-92,-55}},
                                                  color={255,0,255}));
  connect(arisBufferTankFcuGroup_L2.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LLiv2)
    annotation (Line(points={{-130.2,-28.8},{-130.2,-26},{-100,-26},{-100,-18},
          {-26,-18},{-26,-36},{-24,-36},{-24,-39.4545},{-17.4286,-39.4545}},
                     color={0,0,127}));
  connect(arisBufferTankFcuGroup_L2.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedA2)
    annotation (Line(points={{-123,-28.8},{-124,-28.8},{-124,-14},{-58,-14},{
          -58,-50},{-26,-50},{-26,-58.9382},{-17.4286,-58.9382}},
                                       color={0,0,127}));
  connect(arisBufferTankFcuGroup_L2.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedB2)
    annotation (Line(points={{-114.6,-28.8},{-114.6,-26},{-106,-26},{-106,
          -76.8836},{-17.4286,-76.8836}},  color={0,0,127}));
  connect(arisBufferTankFcuGroup_L2.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LLiv2) annotation (
      Line(points={{-107.4,-35.4},{-107.4,-34},{-90,-34},{-90,-32},{-24,-32},{
          -24,-27.1491},{-16.8333,-27.1491}},
                                           color={0,127,255}));
  connect(arisBufferTankFcuGroup_L2.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedA2) annotation (
     Line(points={{-107.6,-42.8},{-100,-42.8},{-100,-34},{-22,-34},{-22,
          -47.1455},{-16.8333,-47.1455}}, color={0,127,255}));
  connect(arisBufferTankFcuGroup_L2.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedB2) annotation (
     Line(points={{-107.6,-49.8},{-102,-49.8},{-102,-65.6036},{-16.8333,
          -65.6036}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_L2.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{-20,144},{-20,-22},{-28,-22},{-28,-86},{-131.2,-86},{
          -131.2,-64}},                                 color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_L2.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{-20,144},{-20,-22},{-28,-22},{-28,-86},{-166,-86},{-166,
          -45.8},{-183,-45.8}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_L2.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LLiv2) annotation (
      Line(points={{-156.6,-35.4},{-164,-35.4},{-164,-26},{-100,-26},{-100,
          -33.8145},{-16.9524,-33.8145}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_L2.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedA2) annotation (
     Line(points={{-156.8,-42.8},{-164,-42.8},{-164,-26},{-98,-26},{-98,-24},{
          -26,-24},{-26,-48},{-24,-48},{-24,-53.2982},{-16.7143,-53.2982}},
                  color={0,127,255}));
  connect(arisBufferTankFcuGroup_L2.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedB2) annotation (
     Line(points={{-156.6,-50},{-164,-50},{-164,-72.2691},{-16.7143,-72.2691}},
                                                                        color={0,
          127,255}));

  connect(arisHeatPumpConfiguration_L3.port_b1, arisBufferTankFcuGroup_L3.port_a5)
    annotation (Line(points={{-191.6,40.2},{-191.6,30},{-170,30},{-170,48.2},{
          -156,48.2}},
                   color={0,127,255}));
  connect(arisBufferTankFcuGroup_L3.port_b5, arisHeatPumpConfiguration_L3.port_a1)
    annotation (Line(points={{-156,15.8},{-220,15.8},{-220,40.2},{-218.4,40.2}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_L3.port_b2, arisWaterTankGroup_L3.port_a)
    annotation (Line(points={{-191.6,23.4},{-191.6,2},{-274,2},{-274,30.4},{
          -268.4,30.4}},
        color={0,127,255}));
  connect(arisWaterTankGroup_L3.port_b, arisHeatPumpConfiguration_L3.port_a2)
    annotation (Line(points={{-237.6,30.2},{-224,30.2},{-224,23.4},{-218.4,23.4}},
                                             color={0,127,255}));
  connect(arisWaterTankGroup_L3.RequestDhw, arisBufferTankFcuGroup_L3.DhwRequestPriority)
    annotation (Line(points={{-245.6,44},{-172,44},{-172,46},{-166,46},{-166,
          46.6}},
        color={255,0,255}));
  connect(hpSetpointController_L3.ModeHp, arisHeatPumpConfiguration_L3.ModeHp)
    annotation (Line(points={{-76,34.8},{-64,34.8},{-64,60},{-219,60},{-219,
          35.8}},                 color={255,0,255}));
  connect(hpSetpointController_L3.TSupSet, arisHeatPumpConfiguration_L3.TSupSet)
    annotation (Line(points={{-76,25.2},{-66,25.2},{-66,-2},{-190,-2},{-190,12},
          {-219,12},{-219,30.6}},
                        color={0,0,127}));
  connect(arisBufferTankFcuGroup_L3.BufferTankTempSetpoint,
    hpSetpointController_L3.BufferTankTempSetpoint) annotation (Line(points={{-166,
          21.2},{-166,-4},{-104,-4},{-104,37.8},{-100,37.8}},
        color={0,0,127}));
  connect(arisWaterTankGroup_L3.HotWaterTankTempSetpoint,
    hpSetpointController_L3.HotWaterTankTempSetpoint) annotation (Line(points={{-270,
          22.8},{-272,22.8},{-272,4},{-166,4},{-166,0},{-162,0},{-162,-6},{-154,
          -6},{-154,-8},{-102,-8},{-102,32.6},{-100,32.6}},
                      color={0,0,127}));
  connect(arisWaterTankGroup_L3.RequestDhw, hpSetpointController_L3.RequestDhw)
    annotation (Line(points={{-245.6,44},{-172,44},{-172,46},{-110,46},{-110,18},
          {-102,18},{-102,8},{-100,8},{-100,27.6}},
                                     color={255,0,255}));
  connect(arisBufferTankFcuGroup_L3.ModeBufferTankCommand,
    hpSetpointController_L3.ModeBufferTankCommand) annotation (Line(points={{-149.8,
          14},{-149.8,0},{-106,0},{-106,23},{-100,23}},
                                                  color={255,0,255}));
  connect(arisBufferTankFcuGroup_L3.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LLiv3)
    annotation (Line(points={{-138.2,49.2},{-138.2,44},{-17.6667,44},{-17.6667,
          28.2255}}, color={0,0,127}));
  connect(arisBufferTankFcuGroup_L3.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedA3)
    annotation (Line(points={{-131,49.2},{-128,49.2},{-128,48},{-62,48},{-62,
          8.22909},{-17.1905,8.22909}},color={0,0,127}));
  connect(arisBufferTankFcuGroup_L3.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedB3)
    annotation (Line(points={{-122.6,49.2},{-122.6,44},{-106,44},{-106,-9.71636},
          {-17.1905,-9.71636}},            color={0,0,127}));
  connect(arisBufferTankFcuGroup_L3.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LLiv3) annotation (
      Line(points={{-115.4,42.6},{-115.4,36},{-104,36},{-104,40.5309},{-17.0714,
          40.5309}},                       color={0,127,255}));
  connect(arisBufferTankFcuGroup_L3.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedA3) annotation (
     Line(points={{-115.6,35.2},{-115.6,30},{-104,30},{-104,38},{-17.0714,38},{
          -17.0714,20.5345}},             color={0,127,255}));
  connect(arisBufferTankFcuGroup_L3.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedB3) annotation (
     Line(points={{-115.6,28.2},{-115.6,2.07636},{-17.0714,2.07636}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_L3.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{-20,144},{-20,-22},{-28,-22},{-28,-86},{-166,-86},{-166,
          -46},{-168,-46},{-168,-4},{-148,-4},{-148,0},{-139.2,0},{-139.2,14}},
                                                        color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_L3.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{-20,144},{-20,-22},{-28,-22},{-28,-86},{-166,-86},{-166,
          -46},{-168,-46},{-168,10},{-182,10},{-182,32.2},{-191,32.2}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_L3.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LLiv3) annotation (
      Line(points={{-164.6,42.6},{-168,42.6},{-168,44},{-106,44},{-106,33.8655},
          {-17.1905,33.8655}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_L3.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedA3) annotation (
     Line(points={{-164.8,35.2},{-168,35.2},{-168,44},{-106,44},{-106,36},{-28,
          36},{-28,14.3818},{-16.9524,14.3818}},
                  color={0,127,255}));
  connect(arisBufferTankFcuGroup_L3.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedB3) annotation (
     Line(points={{-164.6,28},{-170,28},{-170,-6},{-164,-6},{-164,-12},{-28,-12},
          {-28,-5.10182},{-16.4762,-5.10182}},                          color={0,
          127,255}));

  connect(arisHeatPumpConfiguration_L4.port_b1, arisBufferTankFcuGroup_L4.port_a5)
    annotation (Line(points={{-191.6,124.2},{-191.6,138},{-156,138},{-156,132.2}},
                   color={0,127,255}));
  connect(arisBufferTankFcuGroup_L4.port_b5, arisHeatPumpConfiguration_L4.port_a1)
    annotation (Line(points={{-156,99.8},{-156,98},{-190,98},{-190,128},{-218.4,
          128},{-218.4,124.2}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_L4.port_b2, arisWaterTankGroup_L4.port_a)
    annotation (Line(points={{-191.6,107.4},{-191.6,100},{-274,100},{-274,98},{
          -278,98},{-278,114.4},{-268.4,114.4}},
        color={0,127,255}));
  connect(arisWaterTankGroup_L4.port_b, arisHeatPumpConfiguration_L4.port_a2)
    annotation (Line(points={{-237.6,114.2},{-224,114.2},{-224,107.4},{-218.4,
          107.4}},                           color={0,127,255}));
  connect(arisWaterTankGroup_L4.RequestDhw, arisBufferTankFcuGroup_L4.DhwRequestPriority)
    annotation (Line(points={{-245.6,128},{-245.6,136},{-176,136},{-176,130.6},
          {-166,130.6}},
        color={255,0,255}));
  connect(hpSetpointController_L4.ModeHp, arisHeatPumpConfiguration_L4.ModeHp)
    annotation (Line(points={{-76,118.8},{-70,118.8},{-70,138},{-154,138},{-154,
          140},{-196,140},{-196,132},{-224,132},{-224,119.8},{-219,119.8}},
                                  color={255,0,255}));
  connect(hpSetpointController_L4.TSupSet, arisHeatPumpConfiguration_L4.TSupSet)
    annotation (Line(points={{-76,109.2},{-70,109.2},{-70,90},{-219,90},{-219,
          114.6}},      color={0,0,127}));
  connect(arisBufferTankFcuGroup_L4.BufferTankTempSetpoint,
    hpSetpointController_L4.BufferTankTempSetpoint) annotation (Line(points={{-166,
          105.2},{-166,100},{-174,100},{-174,136},{-110,136},{-110,130},{-100,
          130},{-100,121.8}},
        color={0,0,127}));
  connect(arisWaterTankGroup_L4.HotWaterTankTempSetpoint,
    hpSetpointController_L4.HotWaterTankTempSetpoint) annotation (Line(points={{-270,
          106.8},{-276,106.8},{-276,112},{-272,112},{-272,116},{-274,116},{-274,
          140},{-198,140},{-198,142},{-110,142},{-110,116.6},{-100,116.6}},
                      color={0,0,127}));
  connect(arisWaterTankGroup_L4.RequestDhw, hpSetpointController_L4.RequestDhw)
    annotation (Line(points={{-245.6,128},{-245.6,136},{-108,136},{-108,100},{
          -104,100},{-104,98},{-100,98},{-100,111.6}},
                                     color={255,0,255}));
  connect(arisBufferTankFcuGroup_L4.ModeBufferTankCommand,
    hpSetpointController_L4.ModeBufferTankCommand) annotation (Line(points={{-149.8,
          98},{-149.8,92},{-110,92},{-110,107},{-100,107}},
                                                  color={255,0,255}));
  connect(arisBufferTankFcuGroup_L4.ZoneTAir1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LLiv4)
    annotation (Line(points={{-138.2,133.2},{-138.2,136},{-66,136},{-66,97.4436},
          {-17.6667,97.4436}},
                     color={0,0,127}));
  connect(arisBufferTankFcuGroup_L4.ZoneTAir2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedA4)
    annotation (Line(points={{-131,133.2},{-124,133.2},{-124,136},{-110,136},{
          -110,77.96},{-17.4286,77.96}},
                                       color={0,0,127}));
  connect(arisBufferTankFcuGroup_L4.ZoneTAir3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.ZoneTemp_LBedB4)
    annotation (Line(points={{-122.6,133.2},{-122.6,136},{-110,136},{-110,88},{
          -17.4286,88},{-17.4286,60.0145}},color={0,0,127}));
  connect(arisBufferTankFcuGroup_L4.port_b1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LLiv4) annotation (
      Line(points={{-115.4,126.6},{-115.4,128},{-98,128},{-98,130},{-64,130},{
          -64,109.749},{-17.0714,109.749}},color={0,127,255}));
  connect(arisBufferTankFcuGroup_L4.port_b2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedA4) annotation (
     Line(points={{-115.6,119.2},{-115.6,122},{-110,122},{-110,94},{-24,94},{
          -24,89.7527},{-17.0714,89.7527}},
                                          color={0,127,255}));
  connect(arisBufferTankFcuGroup_L4.port_b3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_a_LBedB4) annotation (
     Line(points={{-115.6,112.2},{-115.6,71.2945},{-17.0714,71.2945}},
        color={0,127,255}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisBufferTankFcuGroup_L4.TOut) annotation (Line(points={{9.2381,142.051},{
          9.2381,144},{-20,144},{-20,92},{-120,92},{-120,88},{-139.2,88},{
          -139.2,98}},                                  color={0,0,127}));
  connect(arisRoomModel_8apartments_NoInfiltration_NewYork.TOut,
    arisHeatPumpConfiguration_L4.TOut) annotation (Line(points={{9.2381,142.051},
          {9.2381,144},{-20,144},{-20,92},{-120,92},{-120,88},{-140,88},{-140,
          92},{-174,92},{-174,100},{-186,100},{-186,116.2},{-191,116.2}},
        color={0,0,127}));
  connect(arisBufferTankFcuGroup_L4.port_a1,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LLiv4) annotation (
      Line(points={{-164.6,126.6},{-172,126.6},{-172,136},{-104,136},{-104,140},
          {-62,140},{-62,103.084},{-17.1905,103.084}},
                     color={0,127,255}));
  connect(arisBufferTankFcuGroup_L4.port_a2,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedA4) annotation (
     Line(points={{-164.8,119.2},{-176,119.2},{-176,88},{-142,88},{-142,83.6},{
          -16.9524,83.6}},
                  color={0,127,255}));
  connect(arisBufferTankFcuGroup_L4.port_a3,
    arisRoomModel_8apartments_NoInfiltration_NewYork.port_b_LBedB4) annotation (
     Line(points={{-164.6,112},{-172,112},{-172,90},{-28,90},{-28,64.6291},{
          -16.7143,64.6291}},                                           color={0,
          127,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisMultiFamily_FullBuilding;
