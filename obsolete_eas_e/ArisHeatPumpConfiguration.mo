within CCC_test.obsolete_eas_e;
model ArisHeatPumpConfiguration
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_HP_3D_integrated(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{42,20},{62,36}})));
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_HP_3D_integrated1(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{44,-8},{64,8}})));
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_HP_3D_integrated2(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{44,-34},{64,-18}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  CCC.Fluid.BaseClasses.FlowRouterSupply flowRouterSupply(redeclare package
      Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{120,-50},{140,-30}})));
  CCC.Fluid.BaseClasses.FlowRouterReturn flowRouterReturn(redeclare package
      Medium1 = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{-12,-54},{8,-34}})));
  CCC.Fluid.BaseClasses.HpModeSelector hpModeSelector
    annotation (Placement(transformation(extent={{-66,48},{-46,68}})));
  Modelica.Blocks.Routing.RealPassThrough TOut1 "outdoor air temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={98,60})));
equation
  connect(const6.y,aixlib_HP_3D_integrated. TSupSet) annotation (Line(points={{1,10},{
          34,10},{34,24.88},{40.9,24.88}},    color={0,0,127}));
  connect(const6.y,aixlib_HP_3D_integrated1. TSupSet) annotation (Line(points={{1,10},{
          38,10},{38,-3.12},{42.9,-3.12}},               color={0,0,127}));
  connect(const6.y,aixlib_HP_3D_integrated2. TSupSet) annotation (Line(points={{1,10},{
          38,10},{38,-29.12},{42.9,-29.12}},             color={0,0,127}));
  connect(hpModeSelector.y3,aixlib_HP_3D_integrated. Mode) annotation (Line(
        points={{-45,55.8},{63.2,55.8},{63.2,29.6}},      color={255,0,255}));
  connect(hpModeSelector.y5,aixlib_HP_3D_integrated2. Mode) annotation (Line(
        points={{-45,50.6},{72,50.6},{72,-24.4},{65.2,-24.4}},     color={255,0,
          255}));
  connect(hpModeSelector.y4,aixlib_HP_3D_integrated1. Mode) annotation (Line(
        points={{-45,53},{65.2,53},{65.2,1.6}},                color={255,0,255}));
  connect(hpModeSelector.y,flowRouterReturn. u) annotation (Line(points={{-45,
          65.6},{-34,65.6},{-34,-35.3},{-14,-35.3}},
                                           color={0,0,127}));
  connect(hpModeSelector.y1,flowRouterReturn. u1) annotation (Line(points={{-45,
          62.8},{-34,62.8},{-34,-39.1},{-14.2,-39.1}},
                                                  color={0,0,127}));
  connect(hpModeSelector.y2,flowRouterReturn. u2) annotation (Line(points={{-45,60},
          {-32,60},{-32,-42.9},{-14,-42.9}},color={0,0,127}));
  connect(hpModeSelector.y,flowRouterSupply. u) annotation (Line(points={{-45,
          65.6},{-34,65.6},{-34,-12},{110,-12},{110,-31.3},{118,-31.3}},
                                         color={0,0,127}));
  connect(hpModeSelector.y1,flowRouterSupply. u1) annotation (Line(points={{-45,
          62.8},{-34,62.8},{-34,-12},{108,-12},{108,-35.1},{117.8,-35.1}},
                                       color={0,0,127}));
  connect(hpModeSelector.y2,flowRouterSupply. u2) annotation (Line(points={{-45,60},
          {-32,60},{-32,-14},{108,-14},{108,-38.9},{118,-38.9}},
                            color={0,0,127}));
  connect(aixlib_HP_3D_integrated.port_b,flowRouterSupply. port_a) annotation (
      Line(points={{62.8,33.44},{110,33.44},{110,-42.2},{119.4,-42.2}},
                                                                    color={0,
          127,255}));
  connect(aixlib_HP_3D_integrated1.port_b,flowRouterSupply. port_a1)
    annotation (Line(points={{64.8,5.44},{110,5.44},{110,-44.6},{119.6,-44.6}},
                 color={0,127,255}));
  connect(aixlib_HP_3D_integrated2.port_b,flowRouterSupply. port_a2)
    annotation (Line(points={{64.8,-20.56},{110,-20.56},{110,-48},{119.6,-48}},
                                                                          color=
         {0,127,255}));
  connect(aixlib_HP_3D_integrated.port_a,flowRouterReturn. port_b) annotation (
      Line(points={{41,33.6},{14,33.6},{14,-37.6},{8.4,-37.6}},     color={0,
          127,255}));
  connect(aixlib_HP_3D_integrated1.port_a,flowRouterReturn. port_b1)
    annotation (Line(points={{43,5.6},{14,5.6},{14,-43.6},{8.4,-43.6}},
        color={0,127,255}));
  connect(aixlib_HP_3D_integrated2.port_a,flowRouterReturn. port_b2)
    annotation (Line(points={{43,-20.4},{14,-20.4},{14,-52},{8.4,-52}},   color=
         {0,127,255}));
  connect(TOut1.y, aixlib_HP_3D_integrated.TOutAir) annotation (Line(points={{
          87,60},{70,60},{70,25.36},{63.3,25.36}}, color={0,0,127}));
  connect(TOut1.y, aixlib_HP_3D_integrated1.TOutAir) annotation (Line(points={{
          87,60},{70,60},{70,-2.64},{65.3,-2.64}}, color={0,0,127}));
  connect(TOut1.y, aixlib_HP_3D_integrated2.TOutAir) annotation (Line(points={{
          87,60},{70,60},{70,-28.64},{65.3,-28.64}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
            100}})));
end ArisHeatPumpConfiguration;
