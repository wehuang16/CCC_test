within CCC_test.Examples;
model testAixLibHeatPump
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);


  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={100,-3})));
  Modelica.Blocks.Sources.CombiTimeTable
                                   combiTimeTable(
    table=[0.0,0.1; 800,0.1; 800,0; 6000,0; 6300,0.8; 6600,0; 8640,0],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-158,-8},{-138,12}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-0.52,
    duration=4320,
    offset=0.52,
    startTime=2160)
    annotation (Placement(transformation(extent={{-110,60},{-90,80}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_m_flow_in=true,
    use_T_in=false,
    m_flow=0.52,
    T=322.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-54,35})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,-74})));
  Modelica.Blocks.Sources.Constant TSet(final k=273.15 + 54)
                                                   annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-44,-30})));
  Modelica.Blocks.Sources.BooleanConstant bool
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.BooleanConstant bool1(k=true)
    annotation (Placement(transformation(extent={{8,44},{28,64}})));
  Modelica.Blocks.Sources.Step     step(
    height=-0.52,
    offset=0.52,
    startTime=4320)
    annotation (Placement(transformation(extent={{-152,52},{-132,72}})));
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D
                                         aixlib_HP_3D_integrated(
    redeclare package Medium_eva = MediumAir,
    redeclare package Medium_con = MediumPropyleneGlycol,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-4,-32},{16,-16}})));
  Modelica.Blocks.Sources.Constant TSet1(final k=273.15 + 2)
                                                   annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={52,-58})));
equation
  connect(TSet.y, aixlib_HP_3D_integrated.TSupSet) annotation (Line(points={{
          -35.2,-30},{-35.2,-27.12},{-5.1,-27.12}}, color={0,0,127}));
  connect(TSet1.y, aixlib_HP_3D_integrated.TOutAir) annotation (Line(points={{
          60.8,-58},{64,-58},{64,-26.64},{17.3,-26.64}}, color={0,0,127}));
  connect(bool.y, aixlib_HP_3D_integrated.OnOff) annotation (Line(points={{-79,
          -20},{-56,-20},{-56,-22.4},{-5.2,-22.4}}, color={255,0,255}));
  connect(bool1.y, aixlib_HP_3D_integrated.Mode) annotation (Line(points={{29,
          54},{32,54},{32,-22.4},{17.2,-22.4}}, color={255,0,255}));
  connect(boundary1.ports[1], aixlib_HP_3D_integrated.port_a) annotation (Line(
        points={{-44,35},{-10,35},{-10,-18.4},{-5,-18.4}}, color={0,127,255}));
  connect(aixlib_HP_3D_integrated.port_b, boundary2.ports[1]) annotation (Line(
        points={{16.8,-18.56},{86,-18.56},{86,-3},{90,-3}}, color={0,127,255}));
  connect(combiTimeTable.y[1], boundary1.m_flow_in)
    annotation (Line(points={{-137,2},{-64,2},{-64,27.8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAixLibHeatPump;
