within CCC_test.Examples;
model testHvacBlock



            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
              hil_flexlab_model.BaseClasses.Guideline36            hvac(
    redeclare final package MediumA = MediumA,
    redeclare final package MediumW = MediumW,
    final VRoo={VRooSou,VRooNor,VRooCor},
    final AFlo={AFloSou,AFloNor,AFloCor},
    final mCooVAV_flow_nominal=mCooVAV_flow_nominal,
    final THeaWatInl_nominal=THeaWatInl_nominal) "HVAC system"
    annotation (Placement(transformation(extent={{-64,-4},{24,46}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testHvacBlock;
