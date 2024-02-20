within CCC_test.StanfordHybrid;
model FcuUnitTest2
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Blocks.Sources.Constant T_zon(k=273.15 + 17)
    annotation (Placement(transformation(extent={{46,-88},{66,-68}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=311.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{84,44},{64,62}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={58,19})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-82,63})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumAir,
    use_T_in=true,
    T=311.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={100,-45})));
  CCC.Fluid.BaseClasses.FCU  fCU
    annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
equation
  connect(boundary4.T_in, T_zon.y) annotation (Line(points={{112,-41.4},{120,
          -41.4},{120,-78},{67,-78}}, color={0,0,127}));
  connect(T_zon.y, fCU.TZon) annotation (Line(points={{67,-78},{72,-78},{72,-14},
          {-14,-14},{-14,-5.25},{-10.7368,-5.25}}, color={0,0,127}));
  connect(boundary3.ports[1], fCU.port_a5) annotation (Line(points={{-72,63},{
          -5.78947,63},{-5.78947,13.25}}, color={0,127,255}));
  connect(fCU.port_b5, boundary1.ports[1]) annotation (Line(points={{-5.78947,
          -9.25},{-5.78947,52},{68,52},{68,53},{64,53}}, color={0,127,255}));
  connect(fCU.port_b1, boundary2.ports[1]) annotation (Line(points={{10.5263,
          4.5},{72,4.5},{72,19},{68,19}}, color={0,127,255}));
  connect(boundary4.ports[1], fCU.port_a1) annotation (Line(points={{90,-45},{
          62,-45},{62,-42},{28,-42},{28,-0.5},{10.5263,-0.5}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FcuUnitTest2;
