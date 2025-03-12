within CCC_test.Bakersfield_Model;
model TesPlant
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{-60,38},{-40,58}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov
    annotation (Placement(transformation(extent={{-62,-16},{-42,4}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov1
    annotation (Placement(transformation(extent={{-56,-58},{-36,-38}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov2
    annotation (Placement(transformation(extent={{-62,-104},{-42,-84}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TesPlant;
