within CCC_test.ESTCP;
block IconExample
  "Relief damper control for AHUs using actuated dampers without fan"

  parameter Real relDam_min
    "Relief-damper position that maintains a building pressure of 12 Pa while the economizer damper is positioned to provide minimum outdoor air while the supply fan is at minimum speed";
  parameter Real relDam_max
    "Relief-damper position that maintains a building pressure of 12 Pa while the economizer damper is fully open and the fan speed is at cooling maximum";
  parameter Real posHys=0.05
    "Hysteresis for damper position check"
    annotation (__cdl(ValueInReference=false), Dialog(tab="Advanced"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uOutDam_min(
    final min=0,
    final max=1,
    final unit="1")
    "Outdoor air damper minimum position"
    annotation (Placement(transformation(extent={{-160,80},{-120,120}}),
        iconTransformation(extent={{-140,10},{-100,50}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uOutDam(
    final min=0,
    final max=1,
    final unit="1")
    "Outdoor damper position"
    annotation (Placement(transformation(extent={{-160,-100},{-120,-60}}),
        iconTransformation(extent={{-140,-50},{-100,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelDam(
    final unit="1",
    final min=0,
    final max=1)
    "Relief damper commanded position"
    annotation (Placement(transformation(extent={{120,-60},{160,-20}}),
      iconTransformation(extent={{100,-50},{140,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelDam1(
    final unit="1",
    final min=0,
    final max=1)
    "Relief damper commanded position"
    annotation (Placement(transformation(extent={{120,30},{160,70}}),
      iconTransformation(extent={{100,8},{140,48}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a annotation (Placement(
        transformation(extent={{-318,58},{-298,78}}), iconTransformation(extent
          ={{-120,70},{-100,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b annotation (Placement(
        transformation(extent={{-316,40},{-296,60}}), iconTransformation(extent
          ={{100,70},{120,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1 annotation (Placement(
        transformation(extent={{-302,6},{-282,26}}), iconTransformation(extent=
            {{-120,-90},{-100,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1 annotation (Placement(
        transformation(extent={{-320,-56},{-300,-36}}), iconTransformation(
          extent={{100,-90},{120,-70}})));
equation

annotation (
  defaultComponentName = "relDam",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
    graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid)}),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,120}})),
 Documentation(info="<html>
<p>
Sequence for controlling actuated relief damper <code>yRelDam</code> for AHUs using
actuated relief damper without a fan.
It is implemented according to Section 5.18.8 of ASHRAE Guideline G36, May 2020.
</p>
<p>
In Section 3.2.2.3, find the relief damper position setpoint limits:
</p>
<ul>
<li>
<code>relDam_min</code>: the relief damper position that maintainx a building pressure
of 12 Pa (0.05 in. of water) while the economizer is positioned to provide minimum
outdoor airflow while the supply fan is at minimum speed.
</li>
<li>
<code>relDam_max</code>: the relief damper position that maintainx a building pressure
of 12 Pa (0.05 in. of water) while the economizer damper is fully open and the fan
speed is at cooling maximum.
</li>
</ul>
<p>
Relief damper shall be enabled when the associated supply fan is proven on and any
outdoor air damper is open, and disabled and closed otherwise.
</p>
<p>
Relief damper position shall be reset lineary from <code>relDam_min</code> to
<code>relDam_max</code> as the commanded economizer damper position goes from
<code>uOutDam_min</code> to 100% open.
</p>
<p align=\"center\">
<img alt=\"Image of the relief damper control chart for single zone AHU\"
src=\"modelica://Buildings/Resources/Images/Controls/OBC/ASHRAE/G36/AHUs/SingleZone/VAV/SetPoints/ReliefDamper.png\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
May 20, 2021, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end IconExample;
