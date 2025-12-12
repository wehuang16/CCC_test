within CCC_test.g36_pressure_request_study;
model Guideline36Winter_case5
  "Variable air volume flow system with terminal reheat and five thermal zones controlled using an ASHRAE G36 controller"
  extends Modelica.Icons.Example;
  extends Buildings.Examples.VAVReheat.BaseClasses.HVACBuilding(
    mCor_flow_nominal=ACHCor*VRooCor*conv,
    mSou_flow_nominal=ACHSou*VRooSou*conv,
    mEas_flow_nominal=ACHEas*VRooEas*conv,
    mNor_flow_nominal=ACHNor*VRooNor*conv,
    mWes_flow_nominal=ACHWes*VRooWes*conv,
    redeclare CCC_test.g36_pressure_request_study.Guideline36 hvac(VAVBox(vav(
            y_start=0.2)), rogue_zone_logic_simple1(rogue_zone_time(each
            displayUnit="d") = 345600, fraction_active=0.99999)),
    redeclare
      CCC_test.g36_pressure_request_study.Floor
      flo,
    weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://CCC_test/Resources/weatherdata/USA_FL_Tampa.Intl.AP.722110_TMY3.mos")));

  parameter Real ACHCor(final unit="1/h")=4
    "Design air change per hour core";
  parameter Real ACHSou(final unit="1/h")=4
    "Design air change per hour south";
  parameter Real ACHEas(final unit="1/h")=6
    "Design air change per hour east";
  parameter Real ACHNor(final unit="1/h")=4
    "Design air change per hour north";
  parameter Real ACHWes(final unit="1/h")=6
    "Design air change per hour west";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-112,96},{-92,116}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2
    annotation (Placement(transformation(extent={{-112,78},{-92,98}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow3
    annotation (Placement(transformation(extent={{-112,58},{-92,78}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow4
    annotation (Placement(transformation(extent={{-112,44},{-92,64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow5
    annotation (Placement(transformation(extent={{-112,28},{-92,48}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=790)
    annotation (Placement(transformation(extent={{-202,108},{-182,128}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=-310)
    annotation (Placement(transformation(extent={{-202,74},{-182,94}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=140)
    annotation (Placement(transformation(extent={{-200,44},{-180,64}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=-1010)
    annotation (Placement(transformation(extent={{-200,14},{-180,34}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=390)
    annotation (Placement(transformation(extent={{-202,-22},{-182,-2}})));
equation
  connect(prescribedHeatFlow1.port, flo.heaPorSou) annotation (Line(points={{-92,106},
          {-58,106},{-58,30},{53.1739,30},{53.1739,48.3077}},      color={191,0,
          0}));
  connect(prescribedHeatFlow2.port, flo.heaPorEas) annotation (Line(points={{-92,88},
          {-62,88},{-62,94},{84,94},{84,84},{94,84},{94,63.6923},{82.087,
          63.6923}},
        color={191,0,0}));
  connect(prescribedHeatFlow3.port, flo.heaPorNor) annotation (Line(points={{-92,68},
          {14,68},{14,84},{52.8696,84},{52.8696,70.1538}},     color={191,0,0}));
  connect(prescribedHeatFlow4.port, flo.heaPorWes) annotation (Line(points={{-92,
          54},{14,54},{14,63.6923},{28.2174,63.6923}}, color={191,0,0}));
  connect(prescribedHeatFlow5.port, flo.heaPorCor) annotation (Line(points={{-92,38},
          {-14,38},{-14,88},{53.4783,88},{53.4783,59.6923}},     color={191,0,0}));
  connect(con.y, prescribedHeatFlow1.Q_flow) annotation (Line(points={{-180,118},
          {-166,118},{-166,106},{-112,106}}, color={0,0,127}));
  connect(con1.y, prescribedHeatFlow2.Q_flow)
    annotation (Line(points={{-180,84},{-146,84},{-146,88},{-112,88}},
                                                   color={0,0,127}));
  connect(con2.y, prescribedHeatFlow3.Q_flow) annotation (Line(points={{-178,54},
          {-166,54},{-166,68},{-112,68}}, color={0,0,127}));
  connect(con3.y, prescribedHeatFlow4.Q_flow) annotation (Line(points={{-178,24},
          {-166,24},{-166,54},{-112,54}}, color={0,0,127}));
  connect(con4.y, prescribedHeatFlow5.Q_flow) annotation (Line(points={{-180,-12},
          {-168,-12},{-168,38},{-112,38}},color={0,0,127}));
  annotation (
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/Examples/SmallOffice/Guideline36Winter.mos" "Simulate and plot"),
    experiment(
      StartTime=2.00448e+07,
      StopTime=2.03904e+07,
      Interval=60,
      Tolerance=1e-07,
      __Dymola_Algorithm="Dassl"),
    Icon(
      coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true)),
    Documentation(
      info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC\">
Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC</a>
for a description of the HVAC system,
and see the model
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SmallOffice.BaseClasses.Floor\">
Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SmallOffice.BaseClasses.Floor</a>
for a description of the building envelope.
</p>
<p>
The control is based on ASHRAE Guideline 36, and implemented
using the sequences from the library
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36\">
Buildings.Controls.OBC.ASHRAE.G36</a> for
multi-zone VAV systems with economizer. The schematic diagram of the HVAC and control
sequence is shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavControlSchematics.png\" border=\"1\"/>
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SmallOffice.ASHRAE2006Winter\">
Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SmallOffice.ASHRAE2006Winter</a>..
Note that this model, because of the frequent time sampling,
has longer computing time than
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
The reason is that the time integrator cannot make large steps
because it needs to set a time step each time the control samples
its input.
</p>
</html>",
      revisions="<html>
<ul>
<li>
December 20, 2021, by Michael Wetter:<br/>
Changed parameter declarations and added optimal start up.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2829\">issue #2829</a>.
</li>
<li>
October 4, 2021, by Michael Wetter:<br/>
Refactored <a href=\"modelica://Buildings.Examples.VAVReheat\">Buildings.Examples.VAVReheat</a>
and its base classes to separate building from HVAC model.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2652\">issue #2652</a>.
</li>
<li>
September 3, 2021, by Michael Wetter:<br/>
Updated documentation.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2600\">issue #2600</a>.
</li>
<li>
November 25, 2019, by Milica Grahovac:<br/>
Impementation of <a href=\"modelica://Buildings.Examples.VAVReheat.Guideline36\">
Buildings.Examples.VAVReheat.Guideline36</a> model with an EnergyPlus thermal zone instance.
</li>
</ul>
</html>"));
end Guideline36Winter_case5;
