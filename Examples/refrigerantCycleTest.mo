within CCC_test.Examples;
model refrigerantCycleTest


        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;



  IBPSA.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.EuropeanNorm2D
    europeanNorm2D
    annotation (Placement(transformation(extent={{-48,20},{-28,40}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end refrigerantCycleTest;
