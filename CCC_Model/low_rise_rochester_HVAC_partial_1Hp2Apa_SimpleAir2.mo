within CCC_test.CCC_Model;
model low_rise_rochester_HVAC_partial_1Hp2Apa_SimpleAir2
            extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
   parameter Integer numHeaPum=1 "number of heat pumps";
   parameter Integer numApa=2 "number of apartments";
parameter Integer numZon=54 "number of zones";
         parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

                  parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  CCC.Fluid.BaseClasses.low_rise_rochester_designbuilder
                                      low_rise_rochester_designbuilder
    annotation (Placement(transformation(extent={{16,-2},{36,18}})));
  CCC.Controls.MultipleHeatPumpZoneController multipleHeatPumpZoneController(numHeaPum
      =numHeaPum, numApa=numApa)
    annotation (Placement(transformation(extent={{-118,-24},{-64,-4}})));
  .CCC.Fluid.BaseClasses.TrcWaterTankGroup_1Tank trcWaterTankGroup_1Tank[numApa](
    TankTempSetpoint=320.15,
    TempSetpointHpDeadbandBelow=-7,
    TempSetpointHpDeadbandAbove=3,
    TempSetpointResistanceDeadbandBelow=-7,
    TempSetpointResistanceDeadbandAbove=3,
    ResistanceHeatingPower=12000)
    annotation (Placement(transformation(extent={{36,48},{66,72}})));
  .CCC.Fluid.BaseClasses.Trc_heat_pump_group trc_heat_pump_group(numHeaPum=
        numHeaPum)
    annotation (Placement(transformation(extent={{-48,4},{-20,24}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    V=0.001,
    nPorts=numApa+1)  annotation (Placement(transformation(extent={{-20,48},{0,68}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    V=0.001,
    nPorts=numApa+1)  annotation (Placement(transformation(extent={{-78,44},{-58,64}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booScaRep(nout=
        numApa)
    annotation (Placement(transformation(extent={{-52,-54},{-32,-34}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    V=0.001,
    nPorts=numApa+1)         annotation (Placement(transformation(extent={{-20,-26},{0,-6}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol4(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    V=0.001,
    nPorts=numApa+1)         annotation (Placement(transformation(extent={{-202,-16},{-182,4}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator    reaScaRep(nout=
        numApa)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-90})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conRea1[24](k={1.1,0.64,1.05,
        0.6,1.3,0.5,1.3,1.1,1.05,0.6,1.3,0.5,0.6,1.3,0.5,1.3,1.08,1.05,0.6,1.3,0.5,
        1.25,1.4,0.3})         "Real inputs"
    annotation (Placement(transformation(extent={{-30,110},{-10,130}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conRea2(k=273.15 + 55)
    "Real inputs"
    annotation (Placement(transformation(extent={{-190,102},{-170,122}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conRea3(k=273.15 + 50)
    "Real inputs"
    annotation (Placement(transformation(extent={{-174,68},{-154,88}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conRea4(k=273.15 + 7)
    "Real inputs"
    annotation (Placement(transformation(extent={{-168,30},{-148,50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conRea5[6](k={1.1,1.08,1.05,
        0.6,1.3,0.5}) "Real inputs"
    annotation (Placement(transformation(extent={{46,118},{66,138}})));
  CCC.Fluid.BaseClasses.TRC_1BufferTank_3fcus_SimpleConstantAir
                                              tRC_1BufferTank_3fcus_SimpleConstantAir
                                                                   [numApa](
      zone_temp_cooling_setpoint=297.04, zone_temp_heating_setpoint=294.26)
    annotation (Placement(transformation(extent={{20,-58},{68,-26}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner[48]
        annotation (Placement(transformation(extent={{118,18},{138,38}})));
equation
  connect(trcWaterTankGroup_1Tank.RequestDhw, multipleHeatPumpZoneController.reqDomHotWat)
    annotation (Line(points={{58.4,74},{58.4,82},{-120,82},{-120,-6}},
                color={255,127,0}));
  connect(multipleHeatPumpZoneController.comHeaPumMod, trc_heat_pump_group.comHeaPumMod)
    annotation (Line(points={{-62,-13.8},{-52,-13.8},{-52,6},{-58,6},{-58,13.8},
          {-49.8,13.8}}, color={255,127,0}));
  connect(trc_heat_pump_group.port_b1, vol1.ports[1]) annotation (Line(points={{-19.8,
          19.8},{-10,19.8},{-10,48}},             color={0,127,255}));
  connect(vol1.ports[2:numApa+1], trcWaterTankGroup_1Tank.port_a) annotation (Line(
        points={{-10,48},{-8,48},{-8,34},{35,34},{35,58.4}},   color={0,127,255}));
  connect(trc_heat_pump_group.port_a1, vol2.ports[1]) annotation (Line(points={{-48.4,
          19.8},{-48.4,38},{-68,38},{-68,44}},             color={0,127,255}));
  connect(trcWaterTankGroup_1Tank.port_b, vol2.ports[2:numApa+1]) annotation (Line(
        points={{66.6,62.2},{86,62.2},{86,78},{-88,78},{-88,44},{-68,44}},
        color={0,127,255}));
  connect(multipleHeatPumpZoneController.heaCooMod, booScaRep.u) annotation (
      Line(points={{-62,-21.8},{-62,-44},{-54,-44}}, color={255,0,255}));
  connect(trc_heat_pump_group.port_b2, vol3.ports[1]) annotation (Line(points={{-19.8,8},
          {-14,8},{-14,-2},{-24,-2},{-24,-30},{-10,-30},{-10,-26}},
        color={0,127,255}));
  connect(trc_heat_pump_group.port_a2, vol4.ports[1]) annotation (Line(points={{-48.2,8},
          {-48.2,-30},{-192,-30},{-192,-16}},                color={0,127,255}));
  connect(low_rise_rochester_designbuilder.TOut, reaScaRep.u) annotation (Line(
        points={{25.8,19.2},{25.8,24},{84,24},{84,-102},{40,-102}}, color={0,0,127}));
  connect(low_rise_rochester_designbuilder.TOut, trc_heat_pump_group.TOutAir)
    annotation (Line(points={{25.8,19.2},{25.8,42},{-27,42},{-27,26.2}}, color={
          0,0,127}));
  connect(trc_heat_pump_group.TSubSet_dhw, conRea2.y) annotation (Line(points={{
          -40.4,26.2},{-40.4,112},{-168,112}}, color={0,0,127}));
  connect(trc_heat_pump_group.TSubSet_sch, conRea3.y) annotation (Line(points={{
          -35.6,26.2},{-35.6,78},{-152,78}}, color={0,0,127}));
  connect(trc_heat_pump_group.TSubSet_scc, conRea4.y) annotation (Line(points={{
          -31.2,26.2},{-31.2,40},{-146,40}}, color={0,0,127}));
  connect(conRea1[1:numApa].y, trcWaterTankGroup_1Tank.hotWatScaFac)
    annotation (Line(points={{-8,120},{0,120},{0,72},{24,72},{24,69.2},{32,69.2}},
        color={0,0,127}));
  connect(tRC_1BufferTank_3fcus_SimpleConstantAir.port_a5, vol3.ports[2:numApa
     + 1]) annotation (Line(points={{28,-25.8},{30,-25.8},{30,-18},{-10,-18},{-10,
          -26}}, color={0,127,255}));
  connect(tRC_1BufferTank_3fcus_SimpleConstantAir.port_b5, vol4.ports[2:numApa
     + 1]) annotation (Line(points={{28,-58.2},{28,-62},{-192,-62},{-192,-16}},
        color={0,127,255}));
  connect(booScaRep.y, tRC_1BufferTank_3fcus_SimpleConstantAir.heaCooMod)
    annotation (Line(points={{-30,-44},{8,-44},{8,-39.8},{17.6,-39.8}}, color={
          255,0,255}));
  connect(reaScaRep.y, tRC_1BufferTank_3fcus_SimpleConstantAir.TOut)
    annotation (Line(points={{40,-78},{40,-66},{44.8,-66},{44.8,-60}}, color={0,
          0,127}));
  connect(tRC_1BufferTank_3fcus_SimpleConstantAir.RequestSpaCon,
    multipleHeatPumpZoneController.reqSpaCon) annotation (Line(points={{59.4,-60},
          {60,-60},{60,-78},{-148,-78},{-148,-18.6},{-120.2,-18.6}}, color={255,
          127,0}));

  connect(low_rise_rochester_designbuilder.TAir[2:4],
    tRC_1BufferTank_3fcus_SimpleConstantAir[1].TZoneAir) annotation (Line(
        points={{38,1.72727},{46,1.72727},{46,6},{45.8,6},{45.8,-24.8}}, color=
          {0,0,127}));

  connect(low_rise_rochester_designbuilder.TAir[5:7],
    tRC_1BufferTank_3fcus_SimpleConstantAir[2].TZoneAir) annotation (Line(
        points={{38,1.83636},{46,1.83636},{46,6},{45.8,6},{45.8,-24.8}}, color=
          {0,0,127}));
/*
connect(low_rise_rochester_designbuilder.TAir[44:46], tRC_1BufferTank_3fcus[3].TZoneAir)
annotation (Line(points={{38,3.25455},{46,3.25455},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));

connect(low_rise_rochester_designbuilder.TAir[47:49], tRC_1BufferTank_3fcus[4].TZoneAir)
annotation (Line(points={{38,3.36364},{46,3.36364},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));

connect(low_rise_rochester_designbuilder.TAir[50:52], tRC_1BufferTank_3fcus[5].TZoneAir)
annotation (Line(points={{38,3.47273},{46,3.47273},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));

connect(low_rise_rochester_designbuilder.TAir[53:55], tRC_1BufferTank_3fcus[6].TZoneAir)
annotation (Line(points={{38,3.58182},{46,3.58182},{46,6},{45.8,6},{45.8,-24.8}},
color={0,0,127}));
*/
  connect(low_rise_rochester_designbuilder.port_b[2:4],
    tRC_1BufferTank_3fcus_SimpleConstantAir[1].port_a) annotation (Line(points=
          {{36.4,15.3636},{56,15.3636},{56,-8},{14,-8},{14,-31.4},{19.4,-31.4}},
        color={0,127,255}));

  connect(low_rise_rochester_designbuilder.port_b[5:7],
    tRC_1BufferTank_3fcus_SimpleConstantAir[2].port_a) annotation (Line(points=
          {{36.4,15.4182},{56,15.4182},{56,-8},{14,-8},{14,-31.4},{19.4,-31.4}},
        color={0,127,255}));
/*
connect(low_rise_rochester_designbuilder.port_b[44:46], tRC_1BufferTank_3fcus[3].port_a)
annotation (Line(points={{36.4,16.1273},{56,16.1273},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_b[47:49], tRC_1BufferTank_3fcus[4].port_a)
annotation (Line(points={{36.4,16.1818},{56,16.1818},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_b[50:52], tRC_1BufferTank_3fcus[5].port_a)
annotation (Line(points={{36.4,16.2364},{56,16.2364},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_b[53:55], tRC_1BufferTank_3fcus[6].port_a)
annotation (Line(points={{36.4,16.2909},{56,16.2909},{56,-8},{14,-8},{14,-31.4},
          {19.4,-31.4}},
               color={0,127,255}));
               */

  connect(low_rise_rochester_designbuilder.port_a[2:4],
    tRC_1BufferTank_3fcus_SimpleConstantAir[1].port_b) annotation (Line(points=
          {{15.6,15.3636},{8,15.3636},{8,-12},{74,-12},{74,-31.4},{68.6,-31.4}},
        color={0,127,255}));

  connect(low_rise_rochester_designbuilder.port_a[5:7],
    tRC_1BufferTank_3fcus_SimpleConstantAir[2].port_b) annotation (Line(points=
          {{15.6,15.4182},{8,15.4182},{8,-12},{74,-12},{74,-31.4},{68.6,-31.4}},
        color={0,127,255}));
/*
connect(low_rise_rochester_designbuilder.port_a[44:46], tRC_1BufferTank_3fcus[3].port_b)
annotation (Line(points={{15.6,16.1273},{8,16.1273},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_a[47:49], tRC_1BufferTank_3fcus[4].port_b)
annotation (Line(points={{15.6,16.1818},{8,16.1818},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_a[50:52], tRC_1BufferTank_3fcus[5].port_b)
annotation (Line(points={{15.6,16.2364},{8,16.2364},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));

connect(low_rise_rochester_designbuilder.port_a[53:55], tRC_1BufferTank_3fcus[6].port_b)
annotation (Line(points={{15.6,16.2909},{8,16.2909},{8,-12},{74,-12},{74,-31.4},
          {68.6,-31.4}},
               color={0,127,255}));
*/
  connect(low_rise_rochester_designbuilder.port_b[8:55],
    trc_custom_air_conditioner.port_a) annotation (Line(points={{36.4,16.2909},
          {36.4,14},{110,14},{110,20.6},{117.6,20.6}}, color={0,127,255}));
  connect(low_rise_rochester_designbuilder.port_a[8:55],
    trc_custom_air_conditioner.port_b) annotation (Line(points={{15.6,16.2909},
          {15.6,28},{148,28},{148,20.4},{138.8,20.4}}, color={0,127,255}));
  connect(low_rise_rochester_designbuilder.TAir[8:55],
    trc_custom_air_conditioner.ZAT) annotation (Line(points={{38,3.58182},{74,
          3.58182},{74,4},{104,4},{104,34.4},{116,34.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end low_rise_rochester_HVAC_partial_1Hp2Apa_SimpleAir2;
