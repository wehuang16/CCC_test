within CCC_test.Example2;
model ckAValidation2D_LoadInput_validation

  package MediumAir = Buildings.Media.Air;
   package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+20, X_a=
            0.5);
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
  Buildings.Controls.OBC.CDL.Reals.Subtract WatTemDif
    "supply and return water temperature difference"
    annotation (Placement(transformation(extent={{36,-52},{56,-32}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gal2(k=1/3530.2)
    annotation (Placement(transformation(extent={{200,-32},{220,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{58,24},{78,44}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.01)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Buildings.Controls.OBC.CDL.Reals.Max max2
    annotation (Placement(transformation(extent={{76,-68},{96,-48}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div1
    annotation (Placement(transformation(extent={{120,-16},{140,4}})));
  Buildings.Controls.OBC.CDL.Reals.Min mass_flow_calculated
    annotation (Placement(transformation(extent={{234,-60},{254,-40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0.8)
    annotation (Placement(transformation(extent={{100,-106},{120,-86}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=17000)
    annotation (Placement(transformation(extent={{-162,-114},{-142,-94}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=1.9)
    annotation (Placement(transformation(extent={{-142,-174},{-122,-154}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(
    redeclare package Medium = MediumPropyleneGlycol,
    addPowerToMedium=false,
    m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{76,-148},{96,-128}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumPropyleneGlycol,
    use_T_in=true,
    nPorts=1)   annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=0,
        origin={-52,-179})));
  CCC.Controls.ModeController modeController
    annotation (Placement(transformation(extent={{-88,-78},{-68,-58}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean annotation (
    Placement(transformation(origin={-116,-76},  extent = {{10, -10}, {-10, 10}}, rotation=180)));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=0.43)
    annotation (Placement(transformation(extent={{-234,-76},{-214,-56}})));
  Buildings.Controls.OBC.CDL.Reals.Divide COP_raw
    annotation (Placement(transformation(extent={{280,116},{300,136}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=0.01)
    annotation (Placement(transformation(extent={{194,80},{214,100}})));
  Buildings.Controls.OBC.CDL.Reals.Max max3
    annotation (Placement(transformation(extent={{240,84},{260,104}})));
  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAveCop(delta=1800)
    annotation (Placement(transformation(extent={{404,116},{424,136}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter Pel_experiment(k=1000)
    annotation (Placement(transformation(extent={{52,82},{72,102}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con6(k=8500)
    annotation (Placement(transformation(extent={{-140,-138},{-120,-118}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter mass_flow_measured(k=
        0.00006309*1039.06)
    annotation (Placement(transformation(extent={{150,-130},{170,-110}})));
  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAveThermal(delta=1800)
    annotation (Placement(transformation(extent={{-6,90},{14,110}})));
  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAveThermalExperiment(delta=
        3600)
    annotation (Placement(transformation(extent={{116,86},{136,106}})));
  Modelica.Blocks.Continuous.Integrator thermal_energy_experiment(k=1/3600000)
    annotation (Placement(transformation(extent={{74,130},{94,150}})));
  Modelica.Blocks.Continuous.Integrator electrical_energy_experiment(k=1/
        3600000)
    annotation (Placement(transformation(extent={{138,130},{158,150}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=2000)
    annotation (Placement(transformation(extent={{260,164},{280,184}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{346,174},{366,194}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con9(k=0)
    annotation (Placement(transformation(extent={{314,144},{334,164}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter COP(k=1)
    annotation (Placement(transformation(extent={{352,104},{372,124}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con7(k=273.15 + 6)
    annotation (Placement(transformation(extent={{-144,-212},{-124,-192}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con8(k=273.15 + 63.6)
    annotation (Placement(transformation(extent={{-258,-296},{-238,-276}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con10(k=273.15 + 58)
    annotation (Placement(transformation(extent={{-258,-208},{-238,-188}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con11(k=-10)
    annotation (Placement(transformation(extent={{-258,-172},{-238,-152}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con12(k=0)
    annotation (Placement(transformation(extent={{-258,-246},{-238,-226}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=0.5,
    V=0.01,
    nPorts=2)                                                  "Mixing volume"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={182,-164})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow fixHeaFlo(T_ref=
        293.15)
    "Fixed heat flow rate"
    annotation (Placement(transformation(extent={{198,-136},{218,-116}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gal1(k=-1)
    annotation (Placement(transformation(extent={{152,-84},{172,-64}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[273.15 + 5,0.0;
        273.15 + 6,1; 273.15 + 79,1; 273.15 + 80,0], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{292,-120},{312,-100}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{264,-186},{284,-166}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply
                                          mul
    annotation (Placement(transformation(extent={{276,-80},{296,-60}})));
  Buildings.Controls.OBC.UnitConversions.From_degC from_degC2
    annotation (Placement(transformation(extent={{-82,-126},{-62,-106}})));
  Buildings.Fluid.Sources.Boundary_pT bou2(redeclare package Medium =
        MediumPropyleneGlycol, nPorts=1)
                annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=0,
        origin={182,-247})));
  Buildings.Controls.OBC.UnitConversions.To_degC   to_degC
    annotation (Placement(transformation(extent={{274,-224},{294,-204}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
    return_water_temperature_simulation
    annotation (Placement(transformation(extent={{328,-286},{368,-246}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
    return_water_temperature_experiment
    annotation (Placement(transformation(extent={{94,-320},{134,-280}})));
equation
  connect(MassFieldData.y[3], Q_flow_experiment.u) annotation (Line(points={{-129,
          -14},{-20,-14},{-20,26},{-10,26}}, color={0,0,127}));
  connect(MassFieldData.y[6], WatTemDif.u1) annotation (Line(points={{-129,-14},
          {24,-14},{24,-36},{34,-36}}, color={0,0,127}));
  connect(MassFieldData.y[5], WatTemDif.u2) annotation (Line(points={{-129,-14},
          {24,-14},{24,-48},{34,-48}}, color={0,0,127}));
  connect(WatTemDif.y, max2.u1) annotation (Line(points={{58,-42},{66,-42},{66,
          -52},{74,-52}}, color={0,0,127}));
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
  connect(con1.y, mass_flow_calculated.u2) annotation (Line(points={{122,-96},{
          222,-96},{222,-56},{232,-56}}, color={0,0,127}));
  connect(div1.y, gal2.u) annotation (Line(points={{142,-6},{186,-6},{186,-22},
          {198,-22}}, color={0,0,127}));
  connect(gal2.y, mass_flow_calculated.u1) annotation (Line(points={{222,-22},{
          230,-22},{230,-34},{224,-34},{224,-44},{232,-44}}, color={0,0,127}));
  connect(MassFieldData.y[9], modeController.Mode) annotation (Line(points={{
          -129,-14},{-100,-14},{-100,-64},{-90,-64}}, color={0,0,127}));
  connect(realToBoolean.y, modeController.defrostStatus) annotation (Line(
        points={{-105,-76},{-100,-76},{-100,-72},{-90,-72}}, color={255,0,255}));
  connect(MassFieldData.y[8], realToBoolean.u) annotation (Line(points={{-129,
          -14},{-124,-14},{-124,-60},{-136,-60},{-136,-76},{-128,-76}}, color={
          0,0,127}));
  connect(booToRea.y, mov.m_flow_in) annotation (Line(points={{-212,-66},{-212,
          -68},{-172,-68},{-172,-148},{64,-148},{64,-120},{86,-120},{86,-126}},
                                                     color={0,0,127}));
  connect(modeController.IO, booToRea.u) annotation (Line(points={{-66,-72},{
          -56,-72},{-56,-32},{-236,-32},{-236,-66}}, color={255,0,255}));
  connect(con5.y, max3.u2) annotation (Line(points={{216,90},{230,90},{230,88},
          {238,88}},      color={0,0,127}));
  connect(max3.y, COP_raw.u2) annotation (Line(points={{262,94},{272,94},{272,
          112},{270,112},{270,120},{278,120}}, color={0,0,127}));
  connect(MassFieldData.y[1], Pel_experiment.u) annotation (Line(points={{-129,
          -14},{24,-14},{24,60},{40,60},{40,92},{50,92}},   color={0,0,127}));
  connect(MassFieldData.y[10], mass_flow_measured.u) annotation (Line(points={{
          -129,-14},{-18,-14},{-18,-112},{138,-112},{138,-120},{148,-120}},
        color={0,0,127}));
  connect(movAveThermal.u, Q_flow_experiment.u) annotation (Line(points={{-8,
          100},{-14,100},{-14,26},{-10,26}}, color={0,0,127}));
  connect(Q_flow_experiment.y, movAveThermalExperiment.u) annotation (Line(
        points={{14,26},{46,26},{46,70},{104,70},{104,96},{114,96}}, color={0,0,
          127}));
  connect(Q_flow_experiment.y, thermal_energy_experiment.u) annotation (Line(
        points={{14,26},{26,26},{26,130},{72,130},{72,140}}, color={0,0,127}));
  connect(Pel_experiment.y, electrical_energy_experiment.u) annotation (Line(
        points={{74,92},{100,92},{100,138},{128,138},{128,140},{136,140}},
        color={0,0,127}));
  connect(Q_flow_experiment.y, COP_raw.u1) annotation (Line(points={{14,26},{26,
          26},{26,130},{64,130},{64,156},{268,156},{268,132},{278,132}}, color=
          {0,0,127}));
  connect(Pel_experiment.y, max3.u1) annotation (Line(points={{74,92},{100,92},
          {100,112},{230,112},{230,100},{238,100}}, color={0,0,127}));
  connect(Pel_experiment.y, greThr.u) annotation (Line(points={{74,92},{100,92},
          {100,112},{232,112},{232,174},{258,174}}, color={0,0,127}));
  connect(greThr.y, swi.u2) annotation (Line(points={{282,174},{336,174},{336,
          184},{344,184}}, color={255,0,255}));
  connect(COP_raw.y, swi.u1)
    annotation (Line(points={{302,126},{302,192},{344,192}}, color={0,0,127}));
  connect(con9.y, swi.u3) annotation (Line(points={{336,154},{336,164},{344,164},
          {344,176}}, color={0,0,127}));
  connect(swi.y, COP.u) annotation (Line(points={{368,184},{356,184},{356,114},
          {350,114}}, color={0,0,127}));
  connect(COP.y, movAveCop.u) annotation (Line(points={{374,114},{396,114},{396,
          126},{402,126}}, color={0,0,127}));
  connect(fixHeaFlo.port, vol.heatPort) annotation (Line(points={{218,-126},{
          218,-154},{182,-154}}, color={191,0,0}));
  connect(Q_flow_experiment.y, gal1.u) annotation (Line(points={{14,26},{48,26},
          {48,72},{152,72},{152,-56},{144,-56},{144,-74},{150,-74}}, color={0,0,
          127}));
  connect(vol.heatPort, temperatureSensor.port) annotation (Line(points={{182,
          -154},{184,-154},{184,-156},{224,-156},{224,-160},{252,-160},{252,
          -176},{264,-176}}, color={191,0,0}));
  connect(temperatureSensor.T, combiTable1Ds.u) annotation (Line(points={{285,
          -176},{292,-176},{292,-128},{284,-128},{284,-110},{290,-110}}, color=
          {0,0,127}));
  connect(gal1.y, mul.u1) annotation (Line(points={{174,-74},{264,-74},{264,-64},
          {274,-64}}, color={0,0,127}));
  connect(combiTable1Ds.y[1], mul.u2) annotation (Line(points={{313,-110},{328,
          -110},{328,-76},{274,-76}}, color={0,0,127}));
  connect(mul.y, fixHeaFlo.Q_flow) annotation (Line(points={{298,-70},{356,-70},
          {356,-84},{198,-84},{198,-126}}, color={0,0,127}));
  connect(bou1.ports[1], mov.port_a) annotation (Line(points={{-42,-179},{-12,
          -179},{-12,-152},{68,-152},{68,-138},{76,-138}}, color={0,127,255}));
  connect(mov.port_b, vol.ports[1]) annotation (Line(points={{96,-138},{96,-140},
          {160,-140},{160,-163},{172,-163}}, color={0,0,127}));
  connect(from_degC2.y, bou1.T_in) annotation (Line(points={{-60,-116},{-52,
          -116},{-52,-160},{-72,-160},{-72,-174.6},{-64,-174.6}}, color={0,0,
          127}));
  connect(MassFieldData.y[6], from_degC2.u) annotation (Line(points={{-129,-14},
          {-129,-16},{-124,-16},{-124,-60},{-136,-60},{-136,-96},{-92,-96},{-92,
          -116},{-84,-116}}, color={0,0,127}));
  connect(vol.ports[2], bou2.ports[1]) annotation (Line(points={{172,-165},{164,
          -165},{164,-228},{200,-228},{200,-247},{192,-247}}, color={0,127,255}));
  connect(temperatureSensor.T, to_degC.u) annotation (Line(points={{285,-176},{
          292,-176},{292,-196},{260,-196},{260,-214},{272,-214}}, color={0,0,
          127}));
  connect(return_water_temperature_simulation, to_degC.y) annotation (Line(
        points={{348,-266},{348,-214},{296,-214}}, color={0,0,127}));
  connect(MassFieldData.y[5], return_water_temperature_experiment) annotation (
      Line(points={{-129,-14},{-129,-16},{-124,-16},{-124,-60},{-136,-60},{-136,
          -96},{-20,-96},{-20,-112},{140,-112},{140,-268},{114,-268},{114,-300}},
        color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=2677200,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ckAValidation2D_LoadInput_validation;
