within CCC_test.ESTCP2.AdiabaticPads.BaseClasses.Characteristics;
function Pressure "Pressure vs. air speed"
  extends Modelica.Icons.Function;
  input
    CCC_test.ESTCP2.AdiabaticPads.BaseClasses.Characteristics.PressureParameters
    per "Pressure performance data";
  input Real v "Air speed";
  input Real d[:] "Derivatives at support points for spline interpolation";
  output Real dp(final quantity="Pressure") "Pressure drop";

protected
  Integer n = size(per.v, 1) "Number of data points";
  Integer i "Integer to select data interval";
algorithm
  if n == 1 then
    dp := per.dp[1];
  else
    i :=1;
    for j in 1:n-1 loop
       if v > per.v[j] then
         i := j;
       end if;
    end for;
    // Extrapolate or interpolate the data
    dp:=Buildings.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
                x=v,
                x1=per.v[i],
                x2=per.v[i + 1],
                y1=per.dp[i],
                y2=per.dp[i + 1],
                y1d=d[i],
                y2d=d[i+1]);
  end if;

  annotation(smoothOrder=1,
              Documentation(info="<html>
<p>
This function is similar to
<a href=\"modelica://Buildings.Fluid.Movers.BaseClasses.Characteristics.efficiency\">
Buildings.Fluid.Movers.BaseClasses.Characteristics.efficiency</a>,
but takes the motor part load ratio
<i>y=P<sub>ele</sub> &frasl; P<sub>ele,nominal</sub></i>
instead of volumetric flow rate <i>V&#775;</i> as input
and does not consider the speed of the mover.
</p>
</html>",
revisions="<html>
<ul>
<li>
March 2, 2022, by Hongxiang Fu:<br/>
First implementation.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/2668\">#2668</a>.
</li>
</ul>
</html>"));
end Pressure;
