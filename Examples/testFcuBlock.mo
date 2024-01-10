within CCC_test.Examples;
model testFcuBlock
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=293.15, X_a=
            0.4);
  CCC.Fluid.HeatExchangers.VariableEffectiveness hex(
    redeclare package Medium1 = MediumPropyleneGlycol,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.1222,
    m2_flow_nominal=0.07589,
    dp1_nominal=7742,
    dp2_nominal=0)
    annotation (Placement(transformation(extent={{-14,-4},{6,16}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testFcuBlock;
