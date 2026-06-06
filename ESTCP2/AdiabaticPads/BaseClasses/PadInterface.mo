within CCC_test.ESTCP2.AdiabaticPads.BaseClasses;
model PadInterface

  parameter CCC_test.ESTCP2.AdiabaticPads.Data.Generic per
    annotation (Placement(transformation(extent={{26,20},{46,42}})));
  final parameter Real etaDer[size(per.efficiency.v,1)]=
    Buildings.Utilities.Math.Functions.splineDerivatives(
    x=per.efficiency.v,
    y=per.efficiency.eta,
    ensureMonotonicity=Buildings.Utilities.Math.Functions.isMonotonic(
      x=per.efficiency.eta,
      strict=false));
  final parameter Real dpDer[size(per.pressure.v,1)]=
    Buildings.Utilities.Math.Functions.splineDerivatives(
    x=per.pressure.v,
    y=per.pressure.dp,
    ensureMonotonicity=Buildings.Utilities.Math.Functions.isMonotonic(
      x=per.pressure.dp,
      strict=false));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput v annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput eta annotation (Placement(
        transformation(extent={{100,30},{140,70}}),  iconTransformation(extent={{100,30},
            {140,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput dp annotation (Placement(
        transformation(extent={{100,-70},{140,-30}}), iconTransformation(extent={{100,-70},
            {140,-30}})));
equation

  eta =
    CCC_test.ESTCP2.AdiabaticPads.BaseClasses.Characteristics.SaturationEfficiency(
    per=per.efficiency,
    v=v,
    d=etaDer);
  dp = CCC_test.ESTCP2.AdiabaticPads.BaseClasses.Characteristics.Pressure(
    per=per.pressure,
    v=v,
    d=dpDer);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PadInterface;
