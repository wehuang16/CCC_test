within CCC_test.ESTCP2.AdiabaticPads.Data;
record Generic "Generic data record for movers"
  extends Modelica.Icons.Record;

  parameter
    CCC_test.ESTCP2.AdiabaticPads.BaseClasses.Characteristics.SaturationEfficiencyParameters
    efficiency(v={0}, eta={0.7}) "Saturation efficiency vs. air speed";

  parameter
    CCC_test.ESTCP2.AdiabaticPads.BaseClasses.Characteristics.PressureParameters
    pressure(v={0}, dp={20}) "Pressure vs. air speed";

  annotation (
  defaultComponentPrefixes = "parameter",
  defaultComponentName = "per",
  Documentation(revisions="<html>
<ul>
<li>
August 20, 2024, by Hongxiang Fu:<br/>
Now the function
<a href=\"modelica://Buildings.Fluid.Movers.BaseClasses.Euler.getPeak\">
Buildings.Fluid.Movers.BaseClasses.Euler.getPeak</a>
is not called unless the Euler number method is selected.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1912\">IBPSA, #1912</a>.
</li>
<li>
April 8, 2024, by Hongxiang Fu:<br/>
Default efficiency methods now depend on whether a pressure curve is available.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3819\">#3819</a>.
</li>
<li>
March 29, 2023, by Hongxiang Fu:<br/>
Deleted angular speed parameters with the unit rpm.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1704\">IBPSA, #1704</a>.
</li>
<li>
March 1, 2022, by Hongxiang Fu:<br/>
<ul>
<li>
Modified the record to allow separate specifications of different
efficiency variables.
</li>
<li>
Added parameters for computation using Euler number.
</li>
<li>
Added parameters for providing the motor efficiency as an array
vs. motor part load ratio.
</li>
<li>
Moved the computation of <code>V_flow_max</code> here from
<a href=\"modelica://Buildings.Fluid.Movers.BaseClasses.PartialFlowMachine\">
Buildings.Fluid.Movers.BaseClasses.PartialFlowMachine</a>
and <code>dpMax</code> here from
<a href=\"modelica://Buildings.Fluid.Movers.BaseClasses.FlowMachineInterface\">
Buildings.Fluid.Movers.BaseClasses.FlowMachineInterface</a>
</li>
</ul>
These are for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2668\">#2668</a>.
</li>
<li>
February 19, 2016, by Filip Jorissen:<br/>
Refactored model such that <code>SpeedControlled_Nrpm</code>,
<code>SpeedControlled_y</code> and <code>FlowControlled</code>
are integrated into one record.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/417\">#417</a>.
</li>
<li>
February 17, 2016, by Michael Wetter:<br/>
Changed parameter <code>N_nominal</code> to
<code>speed_rpm_nominal</code> as it is the same quantity as <code>speeds_rmp</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
January 19, 2016, by Filip Jorissen:<br/>
Added parameter <code>speeds_rpm</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/396\">#396</a>.
</li>
<li>
February 13, 2015, by Michael Wetter:<br/>
Updated documentation.
</li>
<li>
January 6, 2015, by Michael Wetter:<br/>
Revised record for OpenModelica.
</li>
<li>
November 22, 2014 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Record containing parameters for pumps or fans.
</p>
<h4>Typical use</h4>
<p>
This record may be used to assign for example fan performance data using
declaration such as
</p>
<pre>
  Buildings.Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = Medium,
      per(pressure(V_flow={0,m_flow_nominal,2*m_flow_nominal}/1.2,
                   dp={2*dp_nominal,dp_nominal,0}))) \"Fan\";
</pre>
<p>
This data record can be used with
<a href=\"modelica://Buildings.Fluid.Movers.SpeedControlled_y\">
Buildings.Fluid.Movers.SpeedControlled_y</a>,
<a href=\"modelica://Buildings.Fluid.Movers.FlowControlled_dp\">
Buildings.Fluid.Movers.FlowControlled_dp</a>,
<a href=\"modelica://Buildings.Fluid.Movers.FlowControlled_m_flow\">
Buildings.Fluid.Movers.FlowControlled_m_flow</a>.
</p>
<p>
An example that uses manufacturer data can be found in
<a href=\"modelica://Buildings.Fluid.Movers.Validation.Pump_y_stratos\">
Buildings.Fluid.Movers.Validation.Pump_y_stratos</a>.
</p>
<h4>Declaration of the peak condition</h4>
<p>
The variable <code>peak</code> is intentionally declared in a way that each of its
element is declared individually. If it was delcared the same way as does
<code>peak_internal</code>, Modelica would prevent the modification of its
specific elements with the following error message:<br/>
<code>
Record has a value, and attempt to modify specific elements.<br/>
The element modification of e.g. V_flow will be ignored.<br/>
</code>
The other variable <code>peak_internal</code> uses a function call to compute its
default values. By passing them to <code>peak</code> one by one, the model can
both have default values and also allow the user to override them easily.
See <a href=\"https://github.com/modelica/ModelicaSpecification/issues/791\">
Modelica Specification issue #791</a>.
</p>
</html>"));
end Generic;
