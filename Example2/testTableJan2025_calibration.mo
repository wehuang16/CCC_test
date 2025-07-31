within CCC_test.Example2;
model testTableJan2025_calibration

  package MediumAir = Buildings.Media.Air;
   package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+20, X_a=
            0.4);
  Modelica.Blocks.Sources.CombiTimeTable MassFieldData(
    tableOnFile=true,
    timeScale(displayUnit="min") = 60,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC/Resources/Data/MassFieldData/WooleyJan2025data_interpolated.txt"),
    columns=2:11)                                                                                                                                                                                                         annotation (
    Placement(transformation(origin={50,46},   extent = {{-200, -70}, {-180, -50}}, rotation=0)));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter Q_flow_experiment(k=1000)
    annotation (Placement(transformation(extent={{-8,16},{12,36}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{36,-52},{56,-32}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gal2(k=1/4184)
    annotation (Placement(transformation(extent={{198,-32},{218,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{58,24},{78,44}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.01)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Buildings.Controls.OBC.CDL.Reals.Max max2
    annotation (Placement(transformation(extent={{76,-68},{96,-48}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div1
    annotation (Placement(transformation(extent={{120,-16},{140,4}})));
  Buildings.Controls.OBC.CDL.Reals.Min mass
    annotation (Placement(transformation(extent={{234,-60},{254,-40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0.8)
    annotation (Placement(transformation(extent={{100,-106},{120,-86}})));
  CCC.Fluid.HeatPumps.SimpleHeatPump_TimerControl
    simpleHeatPump_TimerControl(
    redeclare package Medium_con = MediumWater,
    delayOnTime=600,
    TSupSetHeatingLower=320.25)
    annotation (Placement(transformation(extent={{-66,-148},{-46,-128}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=17000)
    annotation (Placement(transformation(extent={{-162,-128},{-142,-108}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=2)
    annotation (Placement(transformation(extent={{-142,-174},{-122,-154}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con4(k=true)
    annotation (Placement(transformation(extent={{-42,-192},{-22,-172}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(
    redeclare package Medium = MediumWater,
    addPowerToMedium=false,
    m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{-226,-138},{-206,-118}})));
  Buildings.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = MediumWater,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-272,-138},{-252,-116}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant pump_flow_rate(k=0.36)
    "pump_flow_rate in unit of kg/s"
    annotation (Placement(transformation(extent={{-318,-68},{-298,-48}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumWater, nPorts=1)
                annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=180,
        origin={44,-129})));
  CCC.Controls.ModeController modeController
    annotation (Placement(transformation(extent={{-88,-78},{-68,-58}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean annotation (
    Placement(transformation(origin={-116,-76},  extent = {{10, -10}, {-10, 10}}, rotation=180)));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=0.36)
    annotation (Placement(transformation(extent={{-234,-76},{-214,-56}})));
  Buildings.Controls.OBC.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-314,-130},{-294,-110}})));
equation
  connect(MassFieldData.y[3], Q_flow_experiment.u) annotation (Line(points={{-129,
          -14},{-20,-14},{-20,26},{-10,26}}, color={0,0,127}));
  connect(MassFieldData.y[6], sub.u1) annotation (Line(points={{-129,-14},{24,-14},
          {24,-36},{34,-36}},                         color={0,0,127}));
  connect(MassFieldData.y[5], sub.u2) annotation (Line(points={{-129,-14},{24,-14},
          {24,-48},{34,-48}},                         color={0,0,127}));
  connect(sub.y, max2.u1) annotation (Line(points={{58,-42},{66,-42},{66,-52},{
          74,-52}}, color={0,0,127}));
  connect(Q_flow_experiment.y, max1.u1) annotation (Line(points={{14,26},{46,26},
          {46,40},{56,40}}, color={0,0,127}));
  connect(con.y, max1.u2) annotation (Line(points={{12,-70},{20,-70},{20,18},{
          48,18},{48,28},{56,28}}, color={0,0,127}));
  connect(con.y, max2.u2) annotation (Line(points={{12,-70},{20,-70},{20,-64},{
          74,-64}}, color={0,0,127}));
  connect(max1.y, div1.u1) annotation (Line(points={{80,34},{110,34},{110,0},{
          118,0}}, color={0,0,127}));
  connect(max2.y, div1.u2) annotation (Line(points={{98,-58},{110,-58},{110,-12},
          {118,-12}}, color={0,0,127}));
  connect(con1.y, mass.u2) annotation (Line(points={{122,-96},{222,-96},{222,
          -56},{232,-56}}, color={0,0,127}));
  connect(div1.y, gal2.u) annotation (Line(points={{142,-6},{186,-6},{186,-22},
          {196,-22}}, color={0,0,127}));
  connect(gal2.y, mass.u1) annotation (Line(points={{220,-22},{230,-22},{230,
          -34},{224,-34},{224,-44},{232,-44}}, color={0,0,127}));
  connect(con2.y, simpleHeatPump_TimerControl.effective_heat_pump_capacity_heating)
    annotation (Line(points={{-140,-118},{-72,-118},{-72,-124.7},{-67.1,-124.7}},
        color={0,0,127}));
  connect(con2.y, simpleHeatPump_TimerControl.effective_heat_pump_capacity_cooling)
    annotation (Line(points={{-140,-118},{-72,-118},{-72,-128.9},{-67.1,-128.9}},
        color={0,0,127}));
  connect(con3.y, simpleHeatPump_TimerControl.COP_heating) annotation (Line(
        points={{-120,-164},{-74,-164},{-74,-142.7},{-67.1,-142.7}}, color={0,0,
          127}));
  connect(con3.y, simpleHeatPump_TimerControl.COP_cooling) annotation (Line(
        points={{-120,-164},{-74,-164},{-74,-146.9},{-67.1,-146.9}}, color={0,0,
          127}));
  connect(bou.ports[1],mov. port_a) annotation (Line(points={{-252,-127},{-232,
          -127},{-232,-128},{-226,-128}},
                                color={0,127,255}));
  connect(mov.port_b, simpleHeatPump_TimerControl.port_a) annotation (Line(
        points={{-206,-128},{-168,-128},{-168,-134.6},{-67,-134.6}}, color={0,0,
          127}));
  connect(simpleHeatPump_TimerControl.port_b, bou1.ports[1]) annotation (Line(
        points={{-45.2,-134.8},{28,-134.8},{28,-129},{34,-129}}, color={0,127,
          255}));
  connect(MassFieldData.y[9], modeController.Mode) annotation (Line(points={{
          -129,-14},{-100,-14},{-100,-64},{-90,-64}}, color={0,0,127}));
  connect(realToBoolean.y, modeController.defrostStatus) annotation (Line(
        points={{-105,-76},{-100,-76},{-100,-72},{-90,-72}}, color={255,0,255}));
  connect(MassFieldData.y[8], realToBoolean.u) annotation (Line(points={{-129,
          -14},{-124,-14},{-124,-60},{-136,-60},{-136,-76},{-128,-76}}, color={
          0,0,127}));
  connect(modeController.IO, simpleHeatPump_TimerControl.OnOff) annotation (
      Line(points={{-66,-72},{-58,-72},{-58,-106},{-90,-106},{-90,-138.6},{
          -67.2,-138.6}}, color={255,0,255}));
  connect(modeController.newMode, simpleHeatPump_TimerControl.Mode) annotation
    (Line(points={{-66,-64},{-30,-64},{-30,-139.6},{-44.8,-139.6}}, color={255,
          0,255}));
  connect(booToRea.y, mov.m_flow_in) annotation (Line(points={{-212,-66},{-204,
          -66},{-204,-106},{-216,-106},{-216,-116}}, color={0,0,127}));
  connect(modeController.IO, booToRea.u) annotation (Line(points={{-66,-72},{
          -56,-72},{-56,-32},{-236,-32},{-236,-66}}, color={255,0,255}));
  connect(from_degC.y, bou.T_in) annotation (Line(points={{-292,-120},{-282,
          -120},{-282,-122.6},{-274,-122.6}}, color={0,0,127}));
  connect(MassFieldData.y[5], from_degC.u) annotation (Line(points={{-129,-14},
          {-124,-14},{-124,-30},{-326,-30},{-326,-120},{-316,-120}}, color={0,0,
          127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=2677200,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testTableJan2025_calibration;
