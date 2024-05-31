within CCC_test.Examples;
model testFan

              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

   parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.4813;
   parameter Modelica.Units.SI.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-50,3})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={132,1})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=0.15,
    duration=64800,
    offset=0)
    annotation (Placement(transformation(extent={{-50,42},{-30,62}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.15,
    dp_nominal=2.2)
    annotation (Placement(transformation(extent={{46,-8},{66,12}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    addPowerToMedium=false,
    redeclare package Medium = MediumAir,
    per(pressure(V_flow={0,0.8022}, dp={1604,0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Supply air fan"
    annotation (Placement(transformation(extent={{-12,-6},{8,14}})));

equation
  connect(res.port_b, boundary1.ports[1]) annotation (Line(points={{66,2},{95,2},
          {95,1},{122,1}}, color={0,127,255}));
  connect(boundary2.ports[1], fanSup.port_a) annotation (Line(points={{-40,3},{-26,
          3},{-26,4},{-12,4}}, color={0,127,255}));
  connect(fanSup.port_b, res.port_a)
    annotation (Line(points={{8,4},{10,4},{10,2},{46,2}}, color={0,127,255}));
  connect(ramp.y, fanSup.y)
    annotation (Line(points={{-29,52},{-2,52},{-2,16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFan;
