within CCC_test.Examples;
model calculateCOP
  Modelica.Blocks.Interfaces.RealInput QUse
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealOutput COP
    annotation (Placement(transformation(extent={{100,-8},{120,12}})));
  Modelica.Blocks.Interfaces.RealInput ElePow
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));

equation
  COP = if ElePow<=0 then 0 else QUse/ElePow;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end calculateCOP;
