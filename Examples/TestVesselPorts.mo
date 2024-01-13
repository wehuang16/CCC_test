within CCC_test.Examples;
model TestVesselPorts

            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[3](redeclare
      each package Medium = MediumAir) "Fluid inlets and outlets" annotation (
      Placement(transformation(
        extent={{40,-10},{-40,10}},
        rotation=180,
        origin={18,8}), iconTransformation(
        extent={{40,-9},{-40,9}},
        rotation=180,
        origin={0,-191})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-116,43})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     fan(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-68,39})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-16,30},{4,50}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(redeclare package Medium =
        MediumPropyleneGlycol, use_T_in=false)
    annotation (Placement(transformation(extent={{122,22},{102,40}})));
  Modelica.Blocks.Sources.Constant const1(k=0.9)
    annotation (Placement(transformation(extent={{-70,-16},{-50,4}})));
equation
  connect(boundary2.ports[1], fan.port_a) annotation (Line(points={{-106,43},{
          -90,43},{-90,36},{-78,36},{-78,39}}, color={0,127,255}));
  connect(fan.port_b, tempTankOutlet.port_a) annotation (Line(points={{-58,39},
          {-37,39},{-37,40},{-16,40}}, color={0,127,255}));
  connect(tempTankOutlet.port_b, ports[1]) annotation (Line(points={{4,40},{
          4.66667,40},{4.66667,8}}, color={0,127,255}));
  connect(fan.m_flow_in, const1.y) annotation (Line(points={{-68,28.2},{-68,8},
          {-49,8},{-49,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestVesselPorts;
