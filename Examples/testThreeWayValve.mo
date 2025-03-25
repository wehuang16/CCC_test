within CCC_test.Examples;
model testThreeWayValve
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-12,-101})));
  Buildings.Fluid.Movers.SpeedControlled_y     pumpFcuWaterSupply(redeclare
      package Medium = MediumPropyleneGlycol,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per,
                                              addPowerToMedium=false)                  "pump"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={34,-80})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear
                                                val(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=100)
    annotation (Placement(transformation(extent={{30,-22},{50,-2}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-54,-84},{-34,-64}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    duration=43200,
    offset=1,
    startTime=21600)
    annotation (Placement(transformation(extent={{12,40},{32,60}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-28,-5})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{15,-14},{-15,14}},
        rotation=0,
        origin={189,-8})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dpValve_nominal=100)
    annotation (Placement(transformation(extent={{98,-14},{118,6}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{106,54},{126,74}})));
equation
  connect(ramp.y, val.y)
    annotation (Line(points={{33,50},{40,50},{40,0}}, color={0,0,127}));
  connect(const1.y, pumpFcuWaterSupply.y) annotation (Line(points={{-33,-74},{
          18,-74},{18,-58},{34,-58},{34,-68}}, color={0,0,127}));
  connect(boundary2.ports[1], pumpFcuWaterSupply.port_a) annotation (Line(
        points={{-2,-101},{-2,-102},{18,-102},{18,-80},{24,-80}}, color={0,127,
          255}));
  connect(pumpFcuWaterSupply.port_b, val.port_3) annotation (Line(points={{44,
          -80},{58,-80},{58,-22},{40,-22}}, color={0,127,255}));
  connect(boundary1.ports[1], val.port_1) annotation (Line(points={{-18,-5},{
          -18,-6},{24,-6},{24,-12},{30,-12}}, color={0,127,255}));
  connect(val.port_2, val1.port_a) annotation (Line(points={{50,-12},{74,-12},{
          74,-4},{98,-4}}, color={0,127,255}));
  connect(val1.port_b, boundary3.ports[1]) annotation (Line(points={{118,-4},{
          168,-4},{168,-8},{174,-8}}, color={0,127,255}));
  connect(const2.y, val1.y) annotation (Line(points={{127,64},{132,64},{132,18},
          {108,18},{108,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testThreeWayValve;
