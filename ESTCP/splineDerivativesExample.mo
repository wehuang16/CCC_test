within CCC_test.ESTCP;
model splineDerivativesExample
  Real[5] x = {1, 2, 3, 4, 5};
  Real[5] y = {1, 3, 7, 9, 10};
  Real[5] d;
  Real y1;

  //Real x_in = 2.4;
  //Integer i "Integer to select data interval";
  //Integer n = size(x, 1) "Number of data points";
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp
                                   ram(
    height=3,
    duration=0.5,
    offset=1,
    startTime=0.25)
    annotation (Placement(transformation(extent={{-24,-2},{-4,18}})));

equation
  d =  Buildings.Utilities.Math.Functions.splineDerivatives(x,y);
  y1 = Buildings.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
                x=ram.y,
                x1=2,
                x2=3,
                y1=3,
                y2=7,
                y1d=3,
                y2d=3);
  /*
  i =  1;
  for j in 1:n-1 loop
     if x_in > x[j] then
       i =  j;
     else
       i=-1;
     end if;
  end for;
  */

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end splineDerivativesExample;
