within CCC_test.Examples;
model parallelValvesContainer

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  hil_flexlab_model.Test1.BaseClasses1.ParallelValvesFlowAdjustment
    parallelValves2_1
    annotation (Placement(transformation(extent={{-24,14},{-4,34}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=64800,
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
equation
  connect(ramp.y, parallelValves2_1.CoolingSignal) annotation (Line(points={{
          -51,30},{-36,30},{-36,24},{-26,24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end parallelValvesContainer;
