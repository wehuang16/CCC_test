within CCC_test.HIL_testing;
block OperationMode_v0 "Block that outputs the operation mode"

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
  Buildings.Controls.OBC.CDL.Interfaces.RealInput tNexOcc(
    final unit="s",
    final quantity="Time")
    "Time to next occupied period"
    annotation (Placement(transformation(extent={{-300,270},{-260,310}}),
        iconTransformation(extent={{-140,80},{-100,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput maxCooDowTim(
    final unit="s",
    final quantity="Time") "Maximum cool-down time among all the zones"
    annotation (Placement(transformation(extent={{-300,210},{-260,250}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput maxWarUpTim(
    final unit="s",
    final quantity="Time") "Maximum warm-up time among all the zones"
    annotation (Placement(transformation(extent={{-300,130},{-260,170}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput occHeaHigMin
    "True when the occupied heating setpoint temperature is higher than the minimum zone temperature"
    annotation (Placement(transformation(extent={{-300,90},{-260,130}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput maxHigOccCoo
    "True when the maximum zone temperature is higher than the occupied cooling setpoint"
    annotation (Placement(transformation(extent={{-300,60},{-260,100}}),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yOpeMod
    "Operation mode"
    annotation (Placement(transformation(extent={{460,-40},{500,0}}),
        iconTransformation(extent={{100,-20},{140,20}})));

protected
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant occModInd(final k=
        Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.Types.OperationModes.occupied)
    "Occupied mode "
    annotation (Placement(transformation(extent={{200,300},{220,320}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant unoPerInd(
    final k=0)
    "Index to indicate unoccupied period"
    annotation (Placement(transformation(extent={{100,250},{120,270}})));
  Buildings.Controls.OBC.CDL.Reals.Switch   corCooDowTim "Corrected cool down period"
    annotation (Placement(transformation(extent={{-20,200},{0,220}})));
  Buildings.Controls.OBC.CDL.Reals.Switch   corWarUpTim "Corrected warm-up period"
    annotation (Placement(transformation(extent={{-20,160},{0,180}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys2(
    final pre_y_start=true,
    final uHigh=0,
    final uLow=-60)
    "Hysteresis that outputs if the maximum cool-down time is more than the allowed cool-down time"
    annotation (Placement(transformation(extent={{-100,200},{-80,220}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys3(
    final pre_y_start=true,
    final uHigh=0,
    final uLow=-60)
    "Hysteresis that outputs if the maximum warm-up time is more than allowed warm-up time"
    annotation (Placement(transformation(extent={{-100,160},{-80,180}})));
  Modelica.Blocks.Math.Add                  add5(
    final k1=-1)
    "Calculate differential between time-to-next-occupancy and the cool-down time"
    annotation (Placement(transformation(extent={{40,210},{60,230}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys4(
    final pre_y_start=false,
    final uHigh=0,
    final uLow=-60)
    "Hysteresis to activate the cool-down model"
    annotation (Placement(transformation(extent={{80,210},{100,230}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys5(
    final pre_y_start=false,
    final uHigh=0,
    final uLow=-60)
    "Hysteresis to activate the warm-up model"
    annotation (Placement(transformation(extent={{80,170},{100,190}})));
  Modelica.Blocks.Math.Add                  add6(
    final k1=-1)
    "Calculate differential between time-to-next-occupancy and the warm-up time"
    annotation (Placement(transformation(extent={{40,170},{60,190}})));
  hil_flexlab_model.Test1.BaseClasses1.AddParameter addPar2(final p=
        preWarCooTim, final k=-1)
    "Calculate the differential between maximum cool down time and the allowed maximum cool down time"
    annotation (Placement(transformation(extent={{-140,200},{-120,220}})));
  hil_flexlab_model.Test1.BaseClasses1.AddParameter addPar3(final p=
        preWarCooTim, final k=-1)
    "Calculate the differential between maximum warm-up time and the allowed maximum warm-up time"
    annotation (Placement(transformation(extent={{-140,160},{-120,180}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant maxWarCooTime(
    final k=preWarCooTim)
    "Allowed maximum warm-up or cool-down time"
    annotation (Placement(transformation(extent={{-200,180},{-180,200}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat3
    "Hold true when it should be in warm-up mode"
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat4
    "Hold true when it should be in cool-down mode"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt "Sum of two integer inputs"
    annotation (Placement(transformation(extent={{300,190},{320,210}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt1 "Sum of two integer inputs"
    annotation (Placement(transformation(extent={{360,240},{380,260}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger occMod
    "Convert Real number to Integer number"
    annotation (Placement(transformation(extent={{300,270},{320,290}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1(final
      integerTrue=Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.Types.OperationModes.warmUp)
    "Convert Boolean to Integer number"
    annotation (Placement(transformation(extent={{260,170},{280,190}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt(final
      integerTrue=Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.Types.OperationModes.coolDown)
    "Convert Boolean to Integer number"
    annotation (Placement(transformation(extent={{260,210},{280,230}})));
  Buildings.Controls.OBC.CDL.Logical.And and1 "Check if the warm-up time should be activated"
    annotation (Placement(transformation(extent={{200,170},{220,190}})));
  Buildings.Controls.OBC.CDL.Logical.And and2 "Check if the cool-down time should be activated"
    annotation (Placement(transformation(extent={{200,210},{220,230}})));
  Buildings.Controls.OBC.CDL.Logical.Or3 or3
    "Check if it is in Occupied, Cool-down, or Warm-up mode"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Buildings.Controls.OBC.CDL.Reals.Switch   swi
    "Switch between occupied mode index and unoccupied period index"
    annotation (Placement(transformation(extent={{260,270},{280,290}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3 "Logical not"
    annotation (Placement(transformation(extent={{120,190},{140,210}})));
  Buildings.Controls.OBC.CDL.Logical.Not not4 "Logical not"
    annotation (Placement(transformation(extent={{120,150},{140,170}})));

equation
  connect(swi.y, occMod.u)
    annotation (Line(points={{282,280},{298,280}},
      color={0,0,127}));
  connect(occModInd.y, swi.u1)
    annotation (Line(points={{222,310},{240,310},{240,288},{258,288}},
      color={0,0,127}, pattern=LinePattern.Dash));
  connect(unoPerInd.y, swi.u3)
    annotation (Line(points={{122,260},{150,260},{150,272},{258,272}},
      color={0,0,127}, pattern=LinePattern.Dash));
  connect(and2.y, booToInt.u)
    annotation (Line(points={{222,220},{258,220}}, color={255,0,255}));
  connect(and1.y, booToInt1.u)
    annotation (Line(points={{222,180},{258,180}}, color={255,0,255}));
  connect(and2.y, or3.u2)
    annotation (Line(points={{222,220},{230,220},{230,100},{-20,100},{-20,30},{-2,
          30}},
      color={255,0,255}));
  connect(and1.y, or3.u1)
    annotation (Line(points={{222,180},{240,180},{240,90},{-10,90},{-10,38},{-2,
          38}},
      color={255,0,255}));
  connect(uOcc, swi.u2)
    annotation (Line(points={{-280,330},{-220,330},{-220,280},{258,280}},
      color={255,0,255}));
  connect(uOcc, or3.u3)
    annotation (Line(points={{-280,330},{-220,330},{-220,22},{-2,22}},
      color={255,0,255}));
  connect(hys2.y, corCooDowTim.u2)
    annotation (Line(points={{-78,210},{-22,210}},          color={255,0,255}));
  connect(hys3.y, corWarUpTim.u2)
    annotation (Line(points={{-78,170},{-22,170}},          color={255,0,255}));
  connect(add5.y, hys4.u)
    annotation (Line(points={{61,220},{78,220}},            color={0,0,127}));
  connect(hys4.y, and2.u1)
    annotation (Line(points={{102,220},{198,220}},
      color={255,0,255}));
  connect(tNexOcc, add5.u1)
    annotation (Line(points={{-280,290},{20,290},{20,226},{38,226}},
      color={0,0,127}));
  connect(corCooDowTim.y, add5.u2)
    annotation (Line(points={{2,210},{30,210},{30,214},{38,214}},
      color={0,0,127}));
  connect(tNexOcc, add6.u1)
    annotation (Line(points={{-280,290},{20,290},{20,186},{38,186}},
      color={0,0,127}));
  connect(corWarUpTim.y, add6.u2)
    annotation (Line(points={{2,170},{20,170},{20,174},{38,174}},
      color={0,0,127}));
  connect(add6.y, hys5.u)
    annotation (Line(points={{61,180},{78,180}},            color={0,0,127}));
  connect(hys5.y, and1.u1)
    annotation (Line(points={{102,180},{198,180}}, color={255,0,255}));
  connect(addPar2.y, hys2.u)
    annotation (Line(points={{-118,210},{-102,210}},
                                                   color={0,0,127}));
  connect(addPar3.y, hys3.u)
    annotation (Line(points={{-118,170},{-102,170}},
                                                   color={0,0,127}));
  connect(maxWarCooTime.y, corCooDowTim.u3)
    annotation (Line(points={{-178,190},{-60,190},{-60,202},{-22,202}},
      color={0,0,127}));
  connect(maxWarCooTime.y, corWarUpTim.u3)
    annotation (Line(points={{-178,190},{-60,190},{-60,162},{-22,162}},
      color={0,0,127}));
  connect(lat3.y, and1.u2)
    annotation (Line(points={{-78,110},{188,110},{188,172},{198,172}},
      color={255,0,255}));
  connect(lat4.y, and2.u2)
    annotation (Line(points={{-78,80},{-30,80},{-30,120},{180,120},{180,212},{198,
          212}},
      color={255,0,255}));
  connect(hys4.y, not3.u)
    annotation (Line(points={{102,220},{110,220},{110,200},{118,200}},
      color={255,0,255}));
  connect(hys5.y, not4.u)
    annotation (Line(points={{102,180},{110,180},{110,160},{118,160}},
      color={255,0,255}));
  connect(not4.y, lat3.clr)
    annotation (Line(points={{142,160},{160,160},{160,140},{-140,140},{-140,104},
          {-102,104}},
                color={255,0,255}));
  connect(not3.y, lat4.clr)
    annotation (Line(points={{142,200},{170,200},{170,130},{-160,130},{-160,74},
          {-102,74}},
                color={255,0,255}));
  connect(maxCooDowTim, addPar2.u) annotation (Line(points={{-280,230},{-160,230},
          {-160,210},{-142,210}}, color={0,0,127}));
  connect(maxCooDowTim, corCooDowTim.u1) annotation (Line(points={{-280,230},{-60,
          230},{-60,218},{-22,218}}, color={0,0,127}));
  connect(maxWarUpTim, addPar3.u) annotation (Line(points={{-280,150},{-160,150},
          {-160,170},{-142,170}}, color={0,0,127}));
  connect(maxWarUpTim, corWarUpTim.u1) annotation (Line(points={{-280,150},{-40,
          150},{-40,178},{-22,178}}, color={0,0,127}));
  connect(occHeaHigMin, lat3.u)
    annotation (Line(points={{-280,110},{-102,110}}, color={255,0,255}));
  connect(maxHigOccCoo, lat4.u)
    annotation (Line(points={{-280,80},{-102,80}}, color={255,0,255}));
  connect(booToInt.y, addInt.u1) annotation (Line(points={{282,220},{290,220},{290,
          206},{298,206}}, color={255,127,0}));
  connect(booToInt1.y, addInt.u2) annotation (Line(points={{282,180},{290,180},{
          290,194},{298,194}}, color={255,127,0}));
  connect(occMod.y, addInt1.u1) annotation (Line(points={{322,280},{340,280},{340,
          256},{358,256}}, color={255,127,0}));
  connect(addInt.y, addInt1.u2) annotation (Line(points={{322,200},{340,200},{340,
          244},{358,244}}, color={255,127,0}));

  connect(addInt1.y, yOpeMod) annotation (Line(points={{382,250},{406,250},{406,
          -20},{480,-20}}, color={255,127,0}));
annotation (
  defaultComponentName = "opeModSel",
  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-360},{460,360}}),
        graphics={
        Rectangle(
          extent={{-258,188},{458,112}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-258,268},{458,192}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
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
          textString="Occupied mode"),
        Text(
          extent={{324,-224},{396,-246}},
          textColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Setup mode"),
        Text(
          extent={{250,170},{338,146}},
          textColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Warm-up mode"),
        Text(
          extent={{188,262},{276,234}},
          textColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Cool-down mode")}),
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
end OperationMode_v0;
