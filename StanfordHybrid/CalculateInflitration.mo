within CCC_test.StanfordHybrid;
model CalculateInflitration
  Modelica.Blocks.Interfaces.RealInput WindSpeed
    annotation (Placement(transformation(extent={{-142,26},{-102,66}})));
  Modelica.Blocks.Interfaces.RealInput AverageTempeatureDifference
    annotation (Placement(transformation(extent={{-140,-64},{-100,-24}})));
  Modelica.Blocks.Interfaces.RealOutput AirInfiltration=sqrt(0.000145*AverageTempeatureDifference+0.000246*WindSpeed*WindSpeed)*1*247.09628/1000 "in unit of L/s"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CalculateInflitration;
