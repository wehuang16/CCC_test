within CCC_test.Examples;
model testAnyBlock

            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Controls.SeparateHeatingCoolingThermalEnergy
    separateHeatingCoolingThermalEnergy[3]
    annotation (Placement(transformation(extent={{-6,0},{14,20}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,15; 21600,15; 21600,30; 43200,30; 43200,-9; 64800,-9; 64800,0;
        86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-70,2},{-50,22}})));
  Modelica.Blocks.Sources.Constant const(k=-6)
    annotation (Placement(transformation(extent={{-54,-36},{-34,-16}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3)
    annotation (Placement(transformation(extent={{40,0},{52,12}})));
  Modelica.Blocks.Sources.Constant const1(k=4)
    annotation (Placement(transformation(extent={{-60,-64},{-40,-44}})));
  Modelica.Blocks.Sources.Constant const2(k=9)
    annotation (Placement(transformation(extent={{-44,-96},{-24,-76}})));
  Modelica.Blocks.Math.MultiSum multiSum1(nu=3)
    annotation (Placement(transformation(extent={{44,-32},{56,-20}})));
equation
  connect(const.y, separateHeatingCoolingThermalEnergy[1].EffectiveThermalEnergy)
    annotation (Line(points={{-33,-26},{-18,-26},{-18,10},{-8,10}}, color={0,0,
          127}));
  connect(const1.y, separateHeatingCoolingThermalEnergy[2].EffectiveThermalEnergy)
    annotation (Line(points={{-39,-54},{-18,-54},{-18,10},{-8,10}}, color={0,0,
          127}));
  connect(const2.y, separateHeatingCoolingThermalEnergy[3].EffectiveThermalEnergy)
    annotation (Line(points={{-23,-86},{-18,-86},{-18,10},{-8,10}}, color={0,0,
          127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy, multiSum.u)
    annotation (Line(points={{16,13.6},{34,13.6},{34,6},{40,6}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy, multiSum1.u[
    1:3]) annotation (Line(points={{16,4.2},{16,-24.6},{44,-24.6}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
