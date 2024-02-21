within CCC_test.HIL_testing;
model FlexlabX1aNoLeakG36Baseline_test02
  "DR mode - Variable air volume flow system with terminal reheat and five thermal zones at Flexlab X1 cell"
  extends Modelica.Icons.Example;
  extends CCC_test.HIL_testing.PartialOpenLoopX1aNoLeakage_test01(
                                                           occSch(occupancy=3600
          *{5,22}), weaDat(filNam=Modelica.Utilities.Files.loadResource("modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.mos")));

//  extends BaseClasses.PartialOpenLoopX1aV1(min(nin=3),
//      ave(nin=3));

  parameter Modelica.Units.SI.VolumeFlowRate VPriSysMax_flow=m_flow_nominal/1.2
    "Maximum expected system primary airflow rate at design stage";
  parameter Modelica.Units.SI.VolumeFlowRate minZonPriFlo[numZon]={
      mCor_flow_nominal,mSou_flow_nominal,mNor_flow_nominal}/1.2 "Minimum expected zone primary flow rate";
  parameter Modelica.Units.SI.Time samplePeriod=120
    "Sample period of component, set to the same value as the trim and respond that process yPreSetReq";
  parameter Modelica.Units.SI.PressureDifference dpDisRetMax=40
    "Maximum return fan discharge static pressure setpoint";

  Modelica.Blocks.Routing.Multiplex3 TDis "Discharge air temperatures"
    annotation (Placement(transformation(extent={{110,276},{130,296}})));
  Modelica.Blocks.Routing.Multiplex3 VDis_flow
    "Air flow rate at the terminal boxes"
    annotation (Placement(transformation(extent={{176,242},{196,262}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yOutDam(k=1)
    "Outdoor air damper control signal"
    annotation (Placement(transformation(extent={{-46,-16},{-26,4}})));

  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep(final nout=numZon)
    "Replicate real input"
    annotation (Placement(transformation(extent={{-144,350},{-124,370}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(final nout=numZon)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-148,316},{-128,336}})));
  hil_flexlab_model.Test1.BaseClasses1.ModeAndSetPoints TZonSet[numZon](
    final TZonHeaOn=fill(273.15 + 21.1, numZon),
    final TZonHeaOff=fill(THeaOff, numZon),
    TZonCooOn=fill(273.15 + 23.3, numZon),
    final TZonCooOff=fill(TCooOff, numZon)) "Zone setpoint temperature"
    annotation (Placement(transformation(extent={{-32,322},{-12,342}})));
  Modelica.Blocks.Sources.CombiTimeTable cooSetDR(
    table=[0,0; 5,0; 5,2.2; 6,2.2; 6,1.7; 7,1.7; 7,0; 24,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600) "cooling schedule for demand response"
    annotation (Placement(transformation(extent={{-142,400},{-122,420}})));
  Modelica.Blocks.Sources.CombiTimeTable heaSetDR(
    table=[0,0; 5,0; 5,-3.3; 6,-3.3; 6,-1.7; 7,-1.7; 7,0; 24,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600) "heating schedule for demand response"
    annotation (Placement(transformation(extent={{-140,222},{-120,242}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-122,270},{-142,290}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant[numZon](k=false)
    annotation (Placement(transformation(extent={{-264,478},{-244,498}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant[numZon](k=0)
    annotation (Placement(transformation(extent={{-260,524},{-240,544}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k=false)
    "if building is unoccupied"
    annotation (Placement(transformation(extent={{-266,406},{-246,426}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 13)
    annotation (Placement(transformation(extent={{56,288},{76,308}})));
  Modelica.Blocks.Sources.Constant const1(k=0.06)
    annotation (Placement(transformation(extent={{112,242},{132,262}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant1(k=3)
    annotation (Placement(transformation(extent={{302,382},{322,402}})));
  Modelica.Blocks.Sources.Constant VOut_flow(k=0.04)
    annotation (Placement(transformation(extent={{-158,40},{-138,60}})));
  Modelica.Blocks.Sources.Constant ductStaPre(k=350)
    annotation (Placement(transformation(extent={{-152,104},{-132,124}})));
  Modelica.Blocks.Sources.Constant TOutCut(k=273.15 + 24)
    annotation (Placement(transformation(extent={{-100,192},{-80,212}})));
  Modelica.Blocks.Sources.Constant TSup1(k=273.15 + 10)
    annotation (Placement(transformation(extent={{132,56},{152,76}})));
  Modelica.Blocks.Sources.Constant TMix1(k=273.15 + 19.5)
    annotation (Placement(transformation(extent={{-46,58},{-26,78}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yOutDam1(k=0.6)
    "Outdoor air damper control signal"
    annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yOutDam2(k=0.3)
    "Outdoor air damper control signal"
    annotation (Placement(transformation(extent={{-88,-34},{-68,-14}})));
  Modelica.Blocks.Sources.Constant FanSpeed1(k=0.3)
    annotation (Placement(transformation(extent={{160,-4},{180,16}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           fanSup1(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)                "Supply air fan"
    annotation (Placement(transformation(extent={{294,8},{314,28}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb2(
    redeclare package Medium = MediumA,
    T=293.15,
    nPorts=1)   "Ambient conditions"
    annotation (Placement(transformation(extent={{224,-22},{246,0}})));
  Buildings.Fluid.Sources.Boundary_pT
                                  amb3(redeclare package Medium = MediumA,
      nPorts=1) "Ambient conditions"
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=180,
        origin={393,-17})));
equation

  connect(occSch.occupied, booRep.u) annotation (Line(points={{-297,-216},{-232,
          -216},{-232,326},{-150,326}}, color={255,0,255}));
  connect(flo.TRooAir, TZonSet.TZon) annotation (Line(points={{675,228.8},{1096,
          228.8},{1096,604},{-54,604},{-54,335},{-34,335}},       color={0,0,127}));
  connect(TZonSet[1].TZonHeaSet, add1.u1) annotation (Line(points={{-10,332},{
          -64,332},{-64,286},{-120,286}}, color={0,0,127}));
  connect(heaSetDR.y[1], add1.u2) annotation (Line(points={{-119,232},{-66,232},
          {-66,274},{-120,274}}, color={0,0,127}));
  connect(booRep.y, TZonSet.uOcc) annotation (Line(points={{-126,326},{-126,
          338.025},{-34,338.025}}, color={255,0,255}));
  connect(reaRep.u, occSch.tNexNonOcc) annotation (Line(points={{-146,360},{-212,
          360},{-212,64},{-278,64},{-278,-210},{-297,-210}}, color={0,0,127}));
  connect(TZonSet.tNexOcc, reaRep.y) annotation (Line(points={{-34,341},{-46,341},
          {-46,350},{-122,350},{-122,360}}, color={0,0,127}));
  connect(const.y, TDis.u1[1]) annotation (Line(points={{77,298},{92.5,298},{92.5,
          293},{108,293}}, color={0,0,127}));
  connect(const.y, TDis.u2[1])
    annotation (Line(points={{77,298},{77,286},{108,286}}, color={0,0,127}));
  connect(const.y, TDis.u3[1]) annotation (Line(points={{77,298},{88,298},{88,279},
          {108,279}}, color={0,0,127}));
  connect(const1.y, VDis_flow.u1[1]) annotation (Line(points={{133,252},{153.5,252},
          {153.5,259},{174,259}}, color={0,0,127}));
  connect(const1.y, VDis_flow.u2[1])
    annotation (Line(points={{133,252},{174,252}}, color={0,0,127}));
  connect(const1.y, VDis_flow.u3[1])
    annotation (Line(points={{133,252},{133,245},{174,245}}, color={0,0,127}));
  connect(amb2.ports[1], fanSup1.port_a) annotation (Line(points={{246,-11},{
          272,-11},{272,18},{294,18}}, color={0,127,255}));
  connect(fanSup1.port_b, amb3.ports[1]) annotation (Line(points={{314,18},{368,
          18},{368,-17},{382,-17}}, color={0,127,255}));
  connect(FanSpeed1.y, fanSup1.m_flow_in) annotation (Line(points={{181,6},{208,
          6},{208,56},{304,56},{304,30}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-320},{1400,
            640}}), graphics={Line(
          points={{508,144}},
          color={0,127,255},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
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
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoopFlexlabX1a\">
BaseClasses.PartialOpenLoopFlexlabX1a</a>
for a description of the HVAC system and the building envelope.
</p>
<p>
The control is based on ASHRAE Guideline 36, and implemented
using the sequences from the library
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1\">
Buildings.Controls.OBC.ASHRAE.G36_PR1</a> for
multi-zone VAV systems with economizer. The schematic diagram of the HVAC and control
sequence is shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavControlSchematics.png\" border=\"1\"/>
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
Note that this model, because of the frequent time sampling,
has longer computing time than
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
The reason is that the time integrator cannot make large steps
because it needs to set a time step each time the control samples
its input.
</p>
</html>", revisions="<html>
<ul>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&circ;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36.mos"
        "Simulate and plot"),
    experiment(
      StartTime=21513600,
      StopTime=21600000,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end FlexlabX1aNoLeakG36Baseline_test02;
