within CCC_test.Examples;
model test3WayValve
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val
    annotation (Placement(transformation(extent={{-28,16},{-8,36}})));
  Buildings.Fluid.Actuators.Valves.TwoWayQuickOpening val1
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end test3WayValve;
