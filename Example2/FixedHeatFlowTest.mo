within CCC_test.Example2;
model FixedHeatFlowTest


        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    annotation (Placement(transformation(extent={{-52,8},{-32,28}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    V=100,
    nPorts=1)
    annotation (Placement(transformation(extent={{2,10},{22,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin(amplitude=1000, freqHz=1/
        43200)
    annotation (Placement(transformation(extent={{-124,14},{-104,34}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{22,-62},{42,-42}})));
equation
  connect(preHeaFlo.port, vol.heatPort) annotation (Line(points={{-32,18},{-4,18},
          {-4,20},{2,20}}, color={191,0,0}));
  connect(sin.y, preHeaFlo.Q_flow) annotation (Line(points={{-102,24},{-62,24},
          {-62,18},{-52,18}}, color={0,0,127}));
  connect(vol.ports[1], bou.ports[1]) annotation (Line(points={{12,10},{12,-36},
          {46,-36},{46,-52},{42,-52}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end FixedHeatFlowTest;
