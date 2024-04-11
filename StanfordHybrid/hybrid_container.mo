within CCC_test.StanfordHybrid;
model hybrid_container
  Hybrid_2024_v5_test hybrid_2024_v5_test
    annotation (Placement(transformation(extent={{-30,-4},{26,24}})));
  Modelica.Blocks.Sources.Constant T_zon(k=1)
    annotation (Placement(transformation(extent={{-90,16},{-70,36}})));
  Modelica.Blocks.Sources.BooleanConstant
                                   T_zon1(k=false)
    annotation (Placement(transformation(extent={{-82,-16},{-62,4}})));
equation
  connect(T_zon.y, hybrid_2024_v5_test.schedule_input) annotation (Line(points=
          {{-69,26},{-40,26},{-40,15.4},{-32,15.4}}, color={0,0,127}));
  connect(T_zon1.y, hybrid_2024_v5_test.mpc_enable) annotation (Line(points={{
          -61,-6},{-40,-6},{-40,6.8},{-32.2,6.8}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end hybrid_container;
