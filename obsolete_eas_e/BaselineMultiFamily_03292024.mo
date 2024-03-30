within CCC_test.obsolete_eas_e;
model BaselineMultiFamily_03292024
      extends Modelica.Icons.Example;
  package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  CCC.Fluid.BaseClasses.ArisRoomModel_3Rooms arisRoomModel
    annotation (Placement(transformation(extent={{34,20},{76,50}})));
  CCC.Fluid.BaseClasses.BaselineHeatPumpConfiguration baselineHeatPumpConfiguration
    annotation (Placement(transformation(extent={{-76,34},{-56,54}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaselineMultiFamily_03292024;
