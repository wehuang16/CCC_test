within CCC_test.ESTCP;
model wet_pad_example

  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  wet_pad wet_pad1(redeclare package Medium = MediumAir, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{34,-2},{54,18}})));
  Buildings.Fluid.Movers.SpeedControlled_y pumpFcuWaterSupply(
    redeclare package Medium = MediumAir,
    redeclare each Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW15 per,
    addPowerToMedium=false) "pump" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-52,2})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-116,-11})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-114,46},{-94,66}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium =
        MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={156,-7})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temIn(redeclare package Medium =
        MediumAir, m_flow_nominal=1) annotation (Placement(transformation(
          extent={{-16,-8},{4,12}}, rotation=0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temOut(redeclare package Medium =
        MediumAir, m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,12})));
equation
  connect(const1.y, pumpFcuWaterSupply.y) annotation (Line(points={{-93,56},{
          -93,36},{-52,36},{-52,14}},
                                  color={0,0,127}));
  connect(boundary2.ports[1], pumpFcuWaterSupply.port_a) annotation (Line(
        points={{-106,-11},{-88,-11},{-88,2},{-62,2}}, color={0,127,255}));
  connect(pumpFcuWaterSupply.port_b, temIn.port_a) annotation (Line(points={{
          -42,2},{-28,2},{-28,2},{-16,2}}, color={0,127,255}));
  connect(temIn.port_b, wet_pad1.port_a)
    annotation (Line(points={{4,2},{20,2},{20,8},{34,8}}, color={0,127,255}));
  connect(wet_pad1.port_b, temOut.port_a) annotation (Line(points={{54,8},{68,8},
          {68,12},{80,12}}, color={0,127,255}));
  connect(temOut.port_b, boundary1.ports[1]) annotation (Line(points={{100,12},
          {124,12},{124,-7},{146,-7}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end wet_pad_example;
