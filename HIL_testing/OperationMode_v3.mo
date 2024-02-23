within CCC_test.HIL_testing;
block OperationMode_v3 "Block that outputs the operation mode"

  parameter Boolean have_winSen
    "Check if the zone has window status sensor"
    annotation(Dialog(group="Sensors"));
  parameter Integer numZon(min=1) "Number of zones";
  parameter Real preWarCooTim(unit="s") = 10800
    "Maximum cool-down or warm-up time";
  parameter Real TZonFreProOn(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") = 277.55
    "Threshold zone temperature value to activate freeze protection mode";
  parameter Real TZonFreProOff(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") = 280.35
    "Threshold zone temperature value to finish the freeze protection mode";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOcc
    "Zone occupancy status: true=occupied, false=unoccupied"
    annotation (Placement(transformation(extent={{-300,310},{-260,350}}),
        iconTransformation(extent={{-140,100},{-100,140}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput    yOpeMod
    "Operation mode"
    annotation (Placement(transformation(extent={{460,-40},{500,0}}),
        iconTransformation(extent={{100,-20},{140,20}})));

  Modelica.Blocks.Sources.Constant const(k=3600*5)
    annotation (Placement(transformation(extent={{170,170},{190,190}})));
protected
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant occModInd(final k=
        Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.Types.OperationModes.occupied)
    "Occupied mode "
    annotation (Placement(transformation(extent={{200,300},{220,320}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant unoPerInd(
    final k=0)
    "Index to indicate unoccupied period"
    annotation (Placement(transformation(extent={{100,250},{120,270}})));

equation

  connect(const.y, yOpeMod) annotation (Line(points={{191,180},{232,180},{232,
          176},{304,176},{304,-20},{480,-20}}, color={0,0,127}));
annotation (
  defaultComponentName = "opeModSel",
  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-360},{460,360}}),
        graphics={
        Rectangle(
          extent={{-258,348},{458,272}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{336,332},{426,314}},
          textColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Occupied mode")}),
   Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,80},{-52,68}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="maxCooDowTim"),
        Text(
          extent={{-98,64},{-56,54}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="maxWarUpTim"),
        Text(
          extent={{58,12},{96,-10}},
          textColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="yOpeMod"),
        Text(
          extent={{-120,144},{100,106}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-98,94},{-74,82}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="tNexOcc"),
        Text(
          extent={{-100,104},{-82,96}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uOcc"),
        Text(
          extent={{-98,42},{-50,30}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="occHeaHigMin"),
        Text(
          extent={{-98,24},{-48,12}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="maxHigOccCoo"),
        Text(
          extent={{-98,-14},{-60,-24}},
          textColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="totColZon"),
        Text(
          extent={{-98,-32},{-48,-44}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="unoHeaHigMin"),
        Text(
          extent={{-98,-56},{-70,-64}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="TZonMax"),
        Text(
          extent={{-100,-76},{-70,-84}},
          textColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="TZonMin"),
        Text(
          extent={{-98,-96},{-66,-104}},
          textColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="totHotZon"),
        Text(
          extent={{-98,-112},{-48,-124}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="maxHigUnoCoo"),
        Text(
          visible=have_winSen,
          extent={{-98,8},{-68,-4}},
          textColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uWinSta")}),
   Documentation(info="<html>
<p>
This block outputs VAV system operation mode. It is implemented according to
ASHRAE guideline G36, PART 5.C.6 (zone group operating modes).
The block has the modes listed below.
</p>
<h4>Occupied Mode</h4>
<p>
A Zone Group is in the <i>occupied mode</i> when
occupancy input <code>uOcc</code> is true. This input shall be retrieved from
other sequences that specifies occupancy variation and time remaining to the
next occupied period <code>tNexOcc</code>.
</p>
<h4>Warmup Mode</h4>
<p>
Warmup mode shall start based on the zone with the longest calculated warm up
time <code>warUpTim</code> requirement, but no earlier than 3 hours before
the start of the scheduled occupied period, and shall end at the scheduled
occupied start time. Zones where the window switch indicates that a window
is open shall be ignored. Note that for each zone, the optimal warm-up time
<code>warUpTim</code> shall be obtained from an <i>Optimal Start</i>
sequences, computed in a separate block.
The figure below shows the sequence.
</p>
<p align=\"center\">
<img alt=\"Image of warm-up mode definition\"
src=\"modelica://Buildings/Resources/Images/Controls/OBC/ASHRAE/G36_PR1/Generic/OperationMode/Warm-upModeDefinition.png\"/>
</p>
<h4>Cool-Down Mode</h4>
<p>
Cool-down mode shall start based on the zone with the longest calculated
cool-down time <code>cooDowTim</code> requirement, but no earlier than 3 hours
before the start of the scheduled occupied period, and shall end at the
scheduled occupied start time. Zones where the window switch indicates that a
window is open shall be ignored. Note that the each zone <code>cooDowTim</code>
shall be obtained from an <i>Optimal Start</i> sequences, computed in a
separate block.
</p>
<p align=\"center\">
<img alt=\"Image of cool-down mode definition\"
src=\"modelica://Buildings/Resources/Images/Controls/OBC/ASHRAE/G36_PR1/Generic/OperationMode/Cool-downModeDefinition.png\"/>
</p>
<h4>Setback Mode</h4>
<p>
During <i>unoccupied mode</i>, if any 5 zones (or all zones, if fewer than 5)
in the zone group fall below their unoccupied heating setpoints
<code>TZonHeaSetUno</code>, the zone group shall enter <i>setback mode</i> until
all spaces in the zone group are <i>1.1</i> &deg;C (<i>2</i> &deg;F) above their
unoccupied setpoints.
</p>
<p align=\"center\">
<img alt=\"Image of setback mode definition\"
src=\"modelica://Buildings/Resources/Images/Controls/OBC/ASHRAE/G36_PR1/Generic/OperationMode/SetbackModeDefinition.png\"/>
</p>
<h4>Freeze Protection Setback Mode</h4>
<p>
During <i>unoccupied Mode</i>, if any single zone falls below <i>4.4</i> &deg;C
(<i>40</i> &deg;F), the zone group shall enter <i>setback mode</i> until all zones
are above <i>7.2</i> &deg;C (<i>45</i> &deg;F), and a Level 3 alarm
<code>yFreProSta</code> shall be set.
</p>
<h4>Setup Mode</h4>
<p>
During <i>unoccupied mode</i>, if any 5 zones (or all zones, if fewer than 5)
in the zone group rise above their unoccupied cooling setpoints <code>TZonCooSetUno</code>,
the zone group shall enter <i>setup mode</i> until all spaces in the zone group
are <i>1.1</i> &deg;C (<i>2</i> &deg;F) below their unoccupied setpoints. Zones
where the window switch indicates that a window is open shall be ignored.
</p>
<p align=\"center\">
<img alt=\"Image of setup mode definition\"
src=\"modelica://Buildings/Resources/Images/Controls/OBC/ASHRAE/G36_PR1/Generic/OperationMode/SetupModeDefinition.png\"/>
</p>
<h4>Unoccupied Mode</h4>
<p>
<i>Unoccupied mode</i> shall be active if the zone group is not in any other mode.
</p>
</html>",revisions="<html>
<ul>
<li>
March 09, 2020, by Jianjun Hu:<br/>
Reimplemented to remove the vector-valued calculations.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1709\">#1709</a>.
</li>
<li>
April 13, 2019, by Michael Wetter:<br/>
Corrected wrong time in the documentation of the parameters.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1409\">#1409</a>.
</li>
<li>
June 19, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end OperationMode_v3;
