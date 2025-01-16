within CCC_test.Example2;
model testDoubleScaleUpContainer
  testDoubleScaleUp testDoubleScaleUp1[5]
    annotation (Placement(transformation(extent={{-52,-34},{-32,-14}})));
  Modelica.Blocks.Sources.Constant const[2](k={1:1:2})
    annotation (Placement(transformation(extent={{-92,-26},{-72,-6}})));
  Modelica.Blocks.Sources.Constant const1[2](k={1:1:2})
    annotation (Placement(transformation(extent={{-14,-20},{6,0}})));
  testDoubleScaleUp testDoubleScaleUp2
    annotation (Placement(transformation(extent={{38,-28},{58,-8}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-56,-4},{-36,16}})));
  Modelica.Blocks.Routing.DeMultiplex3 deMultiplex3_1
    annotation (Placement(transformation(extent={{22,0},{42,20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testDoubleScaleUpContainer;
