within CCC_test.Examples;
model HeatCapacitySensor
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-6,8},{14,28}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    m_flow=1,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-76,19})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 21)
    annotation (Placement(transformation(extent={{-70,56},{-50,76}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{92,-2},{72,16}})));
  Buildings.Fluid.Sensors.DensityTwoPort senDen1(redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=0.2)
    annotation (Placement(transformation(extent={{-46,8},{-26,28}})));
equation
  connect(const1.y, hea.TSet)
    annotation (Line(points={{-49,66},{-8,66},{-8,26}}, color={0,0,127}));
  connect(hea.port_b, boundary4.ports[1]) annotation (Line(points={{14,18},{46,18},
          {46,7},{72,7}}, color={0,127,255}));
  connect(boundary2.ports[1], senDen1.port_a) annotation (Line(points={{-66,19},
          {-56,19},{-56,18},{-46,18}}, color={0,127,255}));
  connect(senDen1.port_b, hea.port_a) annotation (Line(points={{-26,18},{-16,19},
          {-16,18},{-6,18}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end HeatCapacitySensor;
