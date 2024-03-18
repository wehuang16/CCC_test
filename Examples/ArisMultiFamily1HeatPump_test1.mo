within CCC_test.Examples;
model ArisMultiFamily1HeatPump_test1
    extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankFcuGroup
    annotation (Placement(transformation(extent={{42,-6},{90,26}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_contained(
    TankTempSetpoint=327.55,
    TempSetpointHpDeadbandBelow=-5,
    TempSetpointHpDeadbandAbove=2,
    TempSetpointResistanceDeadbandBelow=-5,
    TempSetpointResistanceDeadbandAbove=2,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{18,-72},{48,-48}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_1HeatPump arisHeatPumpConfiguration_1HeatPump
    annotation (Placement(transformation(extent={{-40,48},{-14,68}})));
  CCC.Fluid.BaseClasses.ArisRoomModel_3Rooms_NoInfiltration_NewYork arisRoomModel
    annotation (Placement(transformation(extent={{48,54},{90,84}})));
  Modelica.Blocks.Sources.Step     step(
    height=51,
    offset=273.15 + 10,
    startTime=475200)
    annotation (Placement(transformation(extent={{-130,52},{-110,72}})));
  Modelica.Blocks.Sources.BooleanStep
                                   booleanStep(startTime=475200, startValue=
        false)
    annotation (Placement(transformation(extent={{-150,20},{-130,40}})));
equation
  connect(arisRoomModel.TOut, arisHeatPumpConfiguration_1HeatPump.TOut)
    annotation (Line(points={{52.2,85},{52.2,86},{-6,86},{-6,58.2},{-13,58.2}},
        color={0,0,127}));
  connect(arisHeatPumpConfiguration_1HeatPump.port_b1, arisBufferTankFcuGroup.port_a5)
    annotation (Line(points={{-13.6,66.2},{42,66.2},{42,26.2},{50,26.2}}, color=
         {0,127,255}));
  connect(arisBufferTankFcuGroup.port_b5, arisHeatPumpConfiguration_1HeatPump.port_a1)
    annotation (Line(points={{50,-6.2},{48,-6.2},{48,-16},{-50,-16},{-50,72},{-40.4,
          72},{-40.4,66.2}}, color={0,127,255}));
  connect(arisHeatPumpConfiguration_1HeatPump.port_b2,
    arisWaterTankGroup_contained.port_a) annotation (Line(points={{-13.6,49.4},
          {-8,49.4},{-8,-59.6},{17.6,-59.6}}, color={0,127,255}));
  connect(arisWaterTankGroup_contained.port_b,
    arisHeatPumpConfiguration_1HeatPump.port_a2) annotation (Line(points={{48.4,
          -59.8},{60,-59.8},{60,-88},{-40.4,-88},{-40.4,49.4}}, color={0,127,
          255}));
  connect(arisRoomModel.TOut, arisBufferTankFcuGroup.TOut) annotation (Line(
        points={{52.2,85},{52.2,88},{102,88},{102,-18},{66.8,-18},{66.8,-8}},
        color={0,0,127}));
  connect(arisWaterTankGroup_contained.RequestDhw, arisBufferTankFcuGroup.DhwRequestPriority)
    annotation (Line(points={{40.4,-46},{38,-46},{38,-10},{12,-10},{12,24.6},{
          40,24.6}}, color={255,0,255}));
  connect(arisRoomModel.ZoneTAir1, arisBufferTankFcuGroup.ZoneTAir1)
    annotation (Line(points={{60.4,85},{60.4,88},{46,88},{46,78},{44,78},{44,
          27.2},{67.8,27.2}}, color={0,0,127}));
  connect(arisRoomModel.ZoneTAir2, arisBufferTankFcuGroup.ZoneTAir2)
    annotation (Line(points={{67.6,85},{67.6,88},{46,88},{46,27.2},{75,27.2}},
        color={0,0,127}));
  connect(arisRoomModel.ZoneTAir3, arisBufferTankFcuGroup.ZoneTAir3)
    annotation (Line(points={{76,85},{76,88},{94,88},{94,80},{92,80},{92,27.2},
          {83.4,27.2}}, color={0,0,127}));
  connect(arisWaterTankGroup_contained.RequestDhw,
    arisHeatPumpConfiguration_1HeatPump.DhwRequestPriority) annotation (Line(
        points={{40.4,-46},{38,-46},{38,-10},{12,-10},{12,24},{-26.2,24},{-26.2,
          46}}, color={255,0,255}));
  connect(arisBufferTankFcuGroup.port_b1, arisRoomModel.port_a1) annotation (
      Line(points={{90.6,20.6},{94,20.6},{94,48},{56,48},{56,79.8},{47.6,79.8}},
        color={0,127,255}));
  connect(arisBufferTankFcuGroup.port_b2, arisRoomModel.port_a2) annotation (
      Line(points={{90.4,13.2},{98,13.2},{98,40},{66,40},{66,72.4},{47.4,72.4}},
        color={0,127,255}));
  connect(arisBufferTankFcuGroup.port_b3, arisRoomModel.port_a3) annotation (
      Line(points={{90.4,6.2},{108,6.2},{108,52},{72,52},{72,65.2},{47.6,65.2}},
        color={0,127,255}));
  connect(arisRoomModel.port_b1, arisBufferTankFcuGroup.port_a1) annotation (
      Line(points={{90.6,80.2},{116,80.2},{116,38},{30,38},{30,20.6},{41.4,20.6}},
        color={0,127,255}));
  connect(arisRoomModel.port_b2, arisBufferTankFcuGroup.port_a2) annotation (
      Line(points={{90.4,72.8},{120,72.8},{120,36},{26,36},{26,13.2},{41.2,13.2}},
        color={0,127,255}));
  connect(arisRoomModel.port_b3, arisBufferTankFcuGroup.port_a3) annotation (
      Line(points={{90.4,65.8},{124,65.8},{124,32},{20,32},{20,6},{41.4,6}},
        color={0,127,255}));
  connect(step.y, arisHeatPumpConfiguration_1HeatPump.TSupSet) annotation (Line(
        points={{-109,62},{-48,62},{-48,56.6},{-41,56.6}}, color={0,0,127}));
  connect(booleanStep.y, arisHeatPumpConfiguration_1HeatPump.ModeHp)
    annotation (Line(points={{-129,30},{-46,30},{-46,61.8},{-41,61.8}}, color={
          255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisMultiFamily1HeatPump_test1;
