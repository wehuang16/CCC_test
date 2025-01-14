within CCC_test.Example2;
model zoneContainer
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
    parameter String zoneName="";
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName=zoneName,
    nPorts=5) "Thermal zone"
    annotation (Placement(transformation(extent={{22,-2},{62,38}})));
  Modelica.Blocks.Sources.Constant qIntGai1[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-78,18},{-58,38}})));
equation
  connect(zon1.qGai_flow,qIntGai1. y)
    annotation (Line(points={{20,28},{-57,28}},    color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end zoneContainer;
