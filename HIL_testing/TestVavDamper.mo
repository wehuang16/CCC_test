within CCC_test.HIL_testing;
model TestVavDamper
             package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.Actuators.Dampers.Exponential         vav(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.2775,
    dpDamper_nominal=220 + 20)           "VAV box for room" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,40})));
  Buildings.Fluid.Sources.Boundary_pT souCoo1(redeclare package Medium =
        MediumAir, nPorts=1)
              "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,38})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo1(redeclare package Medium =
        MediumAir, nPorts=1)
              "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={112,0})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    redeclare package Medium = MediumAir,
    redeclare Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW12 per,
    addPowerToMedium=false)                                    "Supply air fan"
    annotation (Placement(transformation(extent={{-30,26},{-10,46}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=43200,
    offset=0,
    startTime=21600)
    annotation (Placement(transformation(extent={{-8,70},{12,90}})));
  Modelica.Blocks.Sources.Constant
                               const1(k=0.126)
    annotation (Placement(transformation(extent={{-66,66},{-46,86}})));
equation
  connect(vav.port_b, sinCoo1.ports[1])
    annotation (Line(points={{42,40},{112,40},{112,10}}, color={0,127,255}));
  connect(souCoo1.ports[1], fanSup.port_a) annotation (Line(points={{-62,38},{
          -60,38},{-60,36},{-30,36}}, color={0,127,255}));
  connect(fanSup.port_b, vav.port_a)
    annotation (Line(points={{-10,36},{22,36},{22,40}}, color={0,127,255}));
  connect(ramp.y, vav.y)
    annotation (Line(points={{13,80},{32,80},{32,52}}, color={0,0,127}));
  connect(const1.y, fanSup.y)
    annotation (Line(points={{-45,76},{-20,76},{-20,48}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestVavDamper;
