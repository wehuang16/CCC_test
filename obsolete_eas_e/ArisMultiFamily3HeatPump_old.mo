within CCC_test.obsolete_eas_e;
model ArisMultiFamily3HeatPump_old
  extends Modelica.Icons.Example;
  extends ArisHeatPumpConfiguration;
  extends ArisRoomModel(
    nor(nPorts=4),
    cor(nPorts=4),
    nor1(nPorts=4),
    cor1(nPorts=4));
  extends ArisWaterTankGroup;
  extends ArisBufferTankGroup;
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k=false)
    annotation (Placement(transformation(extent={{-114,102},{-94,122}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant3(k=true)
    annotation (Placement(transformation(extent={{-112,70},{-92,90}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant4(k=false)
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-112,8},{-92,28}})));
equation
  connect(flowRouterSupply.port_b1,jun2.port_1)  annotation (Line(points={{140.6,
          -44.2},{148,-44.2},{148,-72},{-96,-72},{-96,-100},{-74,-100}}, color={
          0,127,255}));
  connect(TOut1.y, TOut1.u)
    annotation (Line(points={{87,60},{110,60},{110,60}}, color={0,0,127}));
  connect(flowConstraintBreaker2.port_b, flowRouterReturn.port_a1) annotation (
      Line(points={{-106,-225.6},{-118,-225.6},{-118,-218},{-146,-218},{-146,-51.4},
          {-12.4,-51.4}}, color={0,127,255}));
  connect(flowRouterSupply.port_b, jun3.port_1) annotation (Line(points={{140.4,
          -33.6},{186,-33.6},{186,-192},{214,-192}}, color={0,127,255}));
  connect(flowConstraintBreaker.port_b, flowRouterReturn.port_a) annotation (
      Line(points={{192,-369.6},{-132,-369.6},{-132,-46},{-12.4,-46}}, color={0,
          127,255}));
  connect(fan.port_b, nor.ports[3]) annotation (Line(points={{410,-116},{414,
          -116},{414,-88},{260,-88},{260,106.9}}, color={0,127,255}));
  connect(fanCoilUnit.port_a2, nor.ports[4]) annotation (Line(points={{440.2,
          -175.2},{242,-175.2},{242,106.9},{260,106.9}}, color={0,127,255}));
  connect(fan2.port_b, cor.ports[3]) annotation (Line(points={{470,-186},{470,
          14.9},{322,14.9}}, color={0,127,255}));
  connect(fanCoilUnit1.port_a2, cor.ports[4]) annotation (Line(points={{490.2,
          -245.2},{322,-245.2},{322,14.9}}, color={0,127,255}));
  connect(fan4.port_b, nor1.ports[3]) annotation (Line(points={{530,-244},{530,
          112},{420,112},{420,118.9}}, color={0,127,255}));
  connect(fanCoilUnit2.port_a2, nor1.ports[4]) annotation (Line(points={{560.2,
          -303.2},{420,-303.2},{420,118.9}}, color={0,127,255}));
  connect(fan5.port_b, cor1.ports[3]) annotation (Line(points={{590,-314},{590,
          24},{482,24},{482,26.9}}, color={0,127,255}));
  connect(fanCoilUnit3.port_a2, cor1.ports[4]) annotation (Line(points={{610.2,
          -373.2},{654,-373.2},{654,26.9},{482,26.9}}, color={0,127,255}));
  connect(fanCoilUnit.zonAirTem, nor.TAir) annotation (Line(points={{418,-178.8},
          {410,-178.8},{410,-180},{334,-180},{334,144},{281,144}}, color={0,0,
          127}));
  connect(fanCoilUnit1.zonAirTem, cor.TAir) annotation (Line(points={{468,
          -248.8},{454,-248.8},{454,-250},{372,-250},{372,52},{343,52}}, color=
          {0,0,127}));
  connect(fanCoilUnit2.zonAirTem, nor1.TAir) annotation (Line(points={{538,
          -306.8},{526,-306.8},{526,156},{441,156}}, color={0,0,127}));
  connect(fanCoilUnit3.zonAirTem, cor1.TAir) annotation (Line(points={{588,
          -376.8},{580,-376.8},{580,64},{503,64}}, color={0,0,127}));
  connect(booleanConstant2.y, hpModeSelector.ModeHp1) annotation (Line(points={
          {-93,112},{-84,112},{-84,88},{-67,88},{-67,66}}, color={255,0,255}));
  connect(booleanConstant3.y, hpModeSelector.ModeHp2) annotation (Line(points={
          {-91,80},{-84,80},{-84,63},{-67,63}}, color={255,0,255}));
  connect(booleanConstant4.y, hpModeSelector.ModeHp3) annotation (Line(points={
          {-89,50},{-76,50},{-76,59.8},{-67.2,59.8}}, color={255,0,255}));
  connect(booleanConstant1.y, hpModeSelector.SpaceConditioningMode) annotation (
     Line(points={{-91,18},{-68,18},{-68,52.6}}, color={255,0,255}));
  connect(TOut1.y, TOut1.u) annotation (Line(points={{87,60},{204,60},{204,60},
          {110,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {380,140}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{380,140}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisMultiFamily3HeatPump_old;
