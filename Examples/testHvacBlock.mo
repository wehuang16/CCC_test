within CCC_test.Examples;
model testHvacBlock



            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.BaseClasses.MultiSplitValveControl multiSplitValveControl
    annotation (Placement(transformation(extent={{-16,-4},{4,16}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testHvacBlock;
