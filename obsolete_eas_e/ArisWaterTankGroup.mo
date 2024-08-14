within CCC_test.obsolete_eas_e;
model ArisWaterTankGroup
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.05,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-94,-156},{-74,-136}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=315.15,
    redeclare package MediumHex = MediumPropyleneGlycol,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=1)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={-26,-143})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{44,-152},{64,-132}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{102,-144},{122,-124}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=2)
    annotation (Placement(transformation(extent={{178,-150},{158,-132}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.04,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-104,-202},{-84,
            -182}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=315.15,
    redeclare package MediumHex = MediumPropyleneGlycol,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=1)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={-36,-189})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet1(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{34,-198},{54,-178}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{92,-190},{112,-170}})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={2,-1,-1},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-64,-100})));
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal={1,-2,1},
    dp_nominal={1,-1,1})  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-48,-226})));
  Buildings.Fluid.Movers.FlowControlled_m_flow tankPump(redeclare package
      Medium = MediumPropyleneGlycol, m_flow_nominal=1) "pump" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,-100})));
  Buildings.Fluid.Movers.FlowControlled_m_flow tankPump1(redeclare package
      Medium = MediumPropyleneGlycol, m_flow_nominal=1) "pump" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-52,-164})));
  CCC.Controls.SetpointController_constantSetpoint setpointController(
    gain_value=0.92,
    setpoint=273.15 + 45,
    reverseActing=true)
    annotation (Placement(transformation(extent={{32,-118},{52,-98}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempTanBot
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={8,-126})));
  CCC.Controls.SetpointController_constantSetpoint setpointController1(
    gain_value=0.92,
    setpoint=273.15 + 45,
    reverseActing=true)
    annotation (Placement(transformation(extent={{26,-238},{46,-218}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempTanBot1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,-208})));
  CCC.Controls.FlowConstraintBreaker flowConstraintBreaker2(redeclare package
      Medium = MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-96,-224})));
equation
  connect(boundary.ports[1], tan.port_b) annotation (Line(points={{-74,-146},{
          -60,-146},{-60,-143},{-36,-143}}, color={0,127,255}));
  connect(tan.port_a, tempTankOutlet.port_a) annotation (Line(points={{-16,-143},
          {14,-143},{14,-142},{44,-142}}, color={0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_a) annotation (Line(points={{64,
          -142},{96,-142},{96,-134},{102,-134}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary1.ports[1]) annotation (Line(points={{122,
          -134},{152,-134},{152,-141.9},{158,-141.9}}, color={0,127,255}));
  connect(senMasFlo1.port_b, boundary1.ports[2]) annotation (Line(points={{112,
          -180},{150,-180},{150,-140.1},{158,-140.1}}, color={0,127,255}));
  connect(boundary2.ports[1], tan1.port_b) annotation (Line(points={{-84,-192},
          {-52,-192},{-52,-189},{-46,-189}}, color={0,127,255}));
  connect(tan1.port_a, tempTankOutlet1.port_a) annotation (Line(points={{-26,
          -189},{4,-189},{4,-188},{34,-188}}, color={0,127,255}));
  connect(tempTankOutlet1.port_b, senMasFlo1.port_a) annotation (Line(points={{
          54,-188},{86,-188},{86,-180},{92,-180}}, color={0,127,255}));
  connect(tan.portHex_b, jun1.port_1) annotation (Line(points={{-16,-150.2},{
          -10,-150.2},{-10,-192},{-20,-192},{-20,-226},{-38,-226}}, color={0,
          127,255}));
  connect(tan1.portHex_b, jun1.port_3) annotation (Line(points={{-26,-196.2},{
          -20,-196.2},{-20,-210},{-48,-210},{-48,-216}}, color={0,127,255}));
  connect(jun2.port_2, tankPump.port_a)
    annotation (Line(points={{-54,-100},{-44,-100}}, color={0,127,255}));
  connect(tankPump.port_b, tan.portHex_a) annotation (Line(points={{-24,-100},{
          -10,-100},{-10,-146.42},{-16,-146.42}}, color={0,127,255}));
  connect(jun2.port_3, tankPump1.port_a) annotation (Line(points={{-64,-110},{
          -64,-148},{-68,-148},{-68,-164},{-62,-164}}, color={0,127,255}));
  connect(tankPump1.port_b, tan1.portHex_a) annotation (Line(points={{-42,-164},
          {-20,-164},{-20,-192.42},{-26,-192.42}}, color={0,127,255}));
  connect(tan.heaPorVol[5], tempTanBot.port) annotation (Line(points={{-26,
          -142.784},{-26,-158},{-8,-158},{-8,-126},{-2,-126}}, color={191,0,0}));
  connect(tempTanBot.T, setpointController.measurement) annotation (Line(points=
         {{19,-126},{19,-109.2},{30,-109.2}}, color={0,0,127}));
  connect(setpointController.command, tankPump.m_flow_in) annotation (Line(
        points={{53,-107.4},{58,-107.4},{58,-78},{-34,-78},{-34,-88}}, color={0,
          0,127}));
  connect(tan1.heaPorVol[5], tempTanBot1.port) annotation (Line(points={{-36,
          -188.784},{-36,-208},{-8,-208}}, color={191,0,0}));
  connect(tempTanBot1.T, setpointController1.measurement) annotation (Line(
        points={{13,-208},{18,-208},{18,-224},{16,-224},{16,-229.2},{24,-229.2}},
        color={0,0,127}));
  connect(setpointController1.command, tankPump1.m_flow_in) annotation (Line(
        points={{47,-227.4},{52,-227.4},{52,-204},{18,-204},{18,-142},{-10,-142},
          {-10,-128},{-52,-128},{-52,-152}}, color={0,0,127}));
  connect(jun1.port_2, flowConstraintBreaker2.port_a) annotation (Line(points={
          {-58,-226},{-71.8,-226},{-71.8,-225.6},{-85.6,-225.6}}, color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -300},{180,-60}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-300},{180,
            -60}})));
end ArisWaterTankGroup;
