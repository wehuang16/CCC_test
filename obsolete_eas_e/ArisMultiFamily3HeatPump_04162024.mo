within CCC_test.obsolete_eas_e;
model ArisMultiFamily3HeatPump_04162024
    extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.BaseClasses.ArisBufferTankGroup_1BufferTank_3Fcus arisBufferTankGroup_contained
    annotation (Placement(transformation(extent={{42,-6},{90,26}})));
  CCC.Fluid.BaseClasses.ArisWaterTankGroup_1Tank arisWaterTankGroup_contained
    annotation (Placement(transformation(extent={{18,-72},{48,-48}})));
  CCC.Fluid.BaseClasses.ArisHeatPumpConfiguration_3HeatPumps arisHeatPumpConfiguration_contained
    annotation (Placement(transformation(extent={{-40,48},{-14,68}})));
  CCC_test.obsolete_eas_e.ArisRoomModel_3Rooms arisRoomModel_contained
    annotation (Placement(transformation(extent={{48,54},{90,84}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-92,52},{-72,72}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k=false)
    annotation (Placement(transformation(extent={{-92,14},{-72,34}})));
equation
  connect(booleanConstant.y, arisHeatPumpConfiguration_contained.ModeHp1)
    annotation (Line(points={{-71,62},{-56,62},{-56,61.8},{-41,61.8}}, color={
          255,0,255}));
  connect(booleanConstant.y, arisHeatPumpConfiguration_contained.SpaceConditioningMode)
    annotation (Line(points={{-71,62},{-50,62},{-50,53},{-42,53}}, color={255,0,
          255}));
  connect(booleanConstant1.y, arisHeatPumpConfiguration_contained.ModeHp2)
    annotation (Line(points={{-71,24},{-54,24},{-54,58.8},{-41,58.8}}, color={
          255,0,255}));
  connect(booleanConstant1.y, arisHeatPumpConfiguration_contained.ModeHp3)
    annotation (Line(points={{-71,24},{-54,24},{-54,58},{-48,58},{-48,55.6},{
          -41,55.6}}, color={255,0,255}));
  connect(arisRoomModel_contained.TOut, arisHeatPumpConfiguration_contained.TOut)
    annotation (Line(points={{52.2,85},{52.2,86},{-6,86},{-6,58.2},{-13,58.2}},
        color={0,0,127}));
  connect(arisHeatPumpConfiguration_contained.port_b1,
    arisBufferTankGroup_contained.port_a5) annotation (Line(points={{-13.6,66.2},
          {42,66.2},{42,26.2},{50,26.2}}, color={0,127,255}));
  connect(arisBufferTankGroup_contained.port_b5,
    arisHeatPumpConfiguration_contained.port_a1) annotation (Line(points={{50,
          -6.2},{48,-6.2},{48,-16},{-50,-16},{-50,72},{-40.4,72},{-40.4,66.2}},
        color={0,127,255}));
  connect(arisHeatPumpConfiguration_contained.port_b2,
    arisWaterTankGroup_contained.port_a) annotation (Line(points={{-13.6,49.4},
          {-8,49.4},{-8,-59.6},{17.6,-59.6}}, color={0,127,255}));
  connect(arisWaterTankGroup_contained.port_b,
    arisHeatPumpConfiguration_contained.port_a2) annotation (Line(points={{48.4,
          -59.8},{60,-59.8},{60,-88},{-40.4,-88},{-40.4,49.4}}, color={0,127,
          255}));
  connect(arisRoomModel_contained.port_a1, arisBufferTankGroup_contained.port_a1)
    annotation (Line(points={{47.6,79.8},{40,79.8},{40,30},{38,30},{38,20.6},{
          41.4,20.6}}, color={0,127,255}));
  connect(arisRoomModel_contained.port_a2, arisBufferTankGroup_contained.port_a2)
    annotation (Line(points={{47.4,72.4},{38,72.4},{38,32},{36,32},{36,13.2},{
          41.2,13.2}}, color={0,127,255}));
  connect(arisRoomModel_contained.port_a3, arisBufferTankGroup_contained.port_a3)
    annotation (Line(points={{47.6,65.2},{36,65.2},{36,34},{34,34},{34,6},{41.4,
          6}}, color={0,127,255}));
  connect(arisRoomModel_contained.port_b1, arisBufferTankGroup_contained.port_b1)
    annotation (Line(points={{90.6,80.2},{94,80.2},{94,20.6},{90.6,20.6}},
        color={0,127,255}));
  connect(arisRoomModel_contained.port_b2, arisBufferTankGroup_contained.port_b2)
    annotation (Line(points={{90.4,72.8},{96,72.8},{96,13.2},{90.4,13.2}},
        color={0,127,255}));
  connect(arisRoomModel_contained.port_b3, arisBufferTankGroup_contained.port_b3)
    annotation (Line(points={{90.4,65.8},{98,65.8},{98,6.2},{90.4,6.2}}, color=
          {0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisMultiFamily3HeatPump_04162024;
