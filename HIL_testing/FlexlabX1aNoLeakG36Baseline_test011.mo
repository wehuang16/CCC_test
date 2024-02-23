within CCC_test.HIL_testing;
model FlexlabX1aNoLeakG36Baseline_test011
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
  ModeAndSetPoints                                      TZonSet[numZon](
    final TZonHeaOn=fill(273.15 + 21.1, numZon),
    final TZonHeaOff=fill(THeaOff, numZon),
    TZonCooOn=fill(273.15 + 23.3, numZon),
    final TZonCooOff=fill(TCooOff, numZon)) "Zone setpoint temperature"
    annotation (Placement(transformation(extent={{-32,322},{-12,342}})));
  Zone
    zonOutAirSet[numZon](
    final AFlo=AFlo,
    final have_occSen=fill(false, numZon),
    final have_winSen=fill(false, numZon),
    final desZonPop={0.05*AFlo[i] for i in 1:numZon},
    final minZonPriFlo=minZonPriFlo)
    "Zone level calculation of the minimum outdoor airflow setpoint"
    annotation (Placement(transformation(extent={{228,414},{248,434}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator
                                                    reaRep1(final nout=numZon)
    "Replicate design uncorrected minimum outdoor airflow setpoint"
    annotation (Placement(transformation(extent={{480,478},{500,498}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator
                                                       booRep1(final nout=
        numZon)
    "Replicate signal whether the outdoor airflow is required"
    annotation (Placement(transformation(extent={{480,438},{500,458}})));
  Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.OutdoorAirFlow.SumZone
    zonToSys(final numZon=numZon) "Sum up zone calculation output"
    annotation (Placement(transformation(extent={{274,420},{294,440}})));
  hil_flexlab_model.Test1.BaseClasses1.Controls.Controller_G36 conAHU(
    final pMaxSet=410,
    final yFanMin=yFanMin,
    final VPriSysMax_flow=VPriSysMax_flow,
    final peaSysPop=1.2*sum({0.05*AFlo[i] for i in 1:numZon}),
    numIgnReqSupTem=0) "AHU controller"
    annotation (Placement(transformation(extent={{360,418},{440,546}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-124,446},{-144,466}})));
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
  connect(TDis.y, zonOutAirSet.TDis) annotation (Line(points={{131,286},{132,
          286},{132,421},{226,421}},
                                color={0,0,127}));
  connect(VDis_flow.y, zonOutAirSet.VDis_flow) annotation (Line(points={{197,252},
          {210,252},{210,418},{226,418}}, color={0,0,127}));
  connect(zonOutAirSet.VUncOut_flow_nominal, reaRep1.y) annotation (Line(points={{226,415},
          {216,415},{216,358},{514,358},{514,488},{502,488}},           color={0,
          0,127}));
  connect(zonOutAirSet.uReqOutAir, booRep1.y) annotation (Line(points={{226,427},
          {204,427},{204,352},{510,352},{510,448},{502,448}}, color={255,0,255}));
  connect(flo.TRooAir, zonOutAirSet.TZon) annotation (Line(points={{675,228.8},{
          1072,228.8},{1072,620},{210,620},{210,424},{226,424}},   color={0,0,127}));
  connect(zonOutAirSet.yDesZonPeaOcc, zonToSys.uDesZonPeaOcc) annotation (Line(
        points={{250,433},{262,433},{262,438},{272,438}}, color={0,0,127}));
  connect(zonOutAirSet.VDesPopBreZon_flow, zonToSys.VDesPopBreZon_flow)
    annotation (Line(points={{250,430},{262,430},{262,436},{272,436}},
                                                   color={0,0,127}));
  connect(zonOutAirSet.VDesAreBreZon_flow, zonToSys.VDesAreBreZon_flow)
    annotation (Line(points={{250,427},{262,427},{262,434},{272,434}}, color={0,
          0,127}));
  connect(zonOutAirSet.yDesPriOutAirFra, zonToSys.uDesPriOutAirFra) annotation (
     Line(points={{250,424},{262,424},{262,428},{272,428}}, color={0,0,127}));
  connect(zonOutAirSet.VUncOutAir_flow, zonToSys.VUncOutAir_flow) annotation (
      Line(points={{250,421},{262,421},{262,426},{272,426}}, color={0,0,127}));
  connect(zonOutAirSet.yPriOutAirFra, zonToSys.uPriOutAirFra)
    annotation (Line(points={{250,418},{262,418},{262,424},{272,424}},
                                                   color={0,0,127}));
  connect(zonOutAirSet.VPriAir_flow, zonToSys.VPriAir_flow) annotation (Line(
        points={{250,415},{262,415},{262,422},{272,422}}, color={0,0,127}));
  connect(zonToSys.ySumDesZonPop, conAHU.sumDesZonPop) annotation (Line(points={{296,439},
          {296,522},{356,522},{356,521.529}},           color={0,0,127}));
  connect(zonToSys.VSumDesPopBreZon_flow, conAHU.VSumDesPopBreZon_flow)
    annotation (Line(points={{296,436},{298,436},{298,515.882},{356,515.882}},
        color={0,0,127}));
  connect(zonToSys.VSumDesAreBreZon_flow, conAHU.VSumDesAreBreZon_flow)
    annotation (Line(points={{296,433},{300,433},{300,510.235},{356,510.235}},
        color={0,0,127}));
  connect(zonToSys.yDesSysVenEff, conAHU.uDesSysVenEff) annotation (Line(points={{296,430},
          {302,430},{302,504.588},{356,504.588}},           color={0,0,127}));
  connect(zonToSys.VSumUncOutAir_flow, conAHU.VSumUncOutAir_flow) annotation (
      Line(points={{296,427},{303,427},{303,498.941},{356,498.941}}, color={0,0,
          127}));
  connect(zonToSys.uOutAirFra_max, conAHU.uOutAirFra_max) annotation (Line(
        points={{296,424},{302,424},{302,487.647},{356,487.647}}, color={0,0,127}));
  connect(zonToSys.VSumSysPriAir_flow, conAHU.VSumSysPriAir_flow) annotation (
      Line(points={{296,421},{304,421},{304,493.294},{356,493.294}}, color={0,0,
          127}));
  connect(TOut.y, conAHU.TOut) annotation (Line(points={{-279,180},{18.5,180},{
          18.5,538.471},{356,538.471}},
                                   color={0,0,127}));
  connect(TZonSet[1].yOpeMod, conAHU.uOpeMod) annotation (Line(points={{-10,325},
          {158,325},{158,438.706},{356,438.706}}, color={255,127,0}));
  connect(conAHU.VDesUncOutAir_flow, reaRep1.u) annotation (Line(points={{444,
          508.353},{447,508.353},{447,488},{478,488}},
                                              color={0,0,127}));
  connect(conAHU.yReqOutAir, booRep1.u) annotation (Line(points={{444,474.471},
          {444,448},{478,448}},color={255,0,255}));
  connect(conAHU.yAveOutAirFraPlu, zonToSys.yAveOutAirFraPlu) annotation (Line(
        points={{444,497.059},{430,497.059},{430,414},{266,414},{266,432},{272,
          432}},
        color={0,0,127}));
  connect(TZonSet[1].TZonCooSet, conAHU.TZonCooSet) annotation (Line(points={{-10,339},
          {174,339},{174,544.118},{356,544.118}},      color={0,0,127}));
  connect(TZonSet[1].TZonHeaSet, conAHU.TZonHeaSet) annotation (Line(points={{-10,332},
          {174,332},{174,549.765},{356,549.765}},      color={0,0,127}));
  connect(cooSetDR.y[1], add.u2) annotation (Line(points={{-121,410},{-92,410},
          {-92,450},{-122,450}}, color={0,0,127}));
  connect(TZonSet[1].TZonCooSet, add.u1) annotation (Line(points={{-10,339},{8,
          339},{8,462},{-122,462}}, color={0,0,127}));
  connect(TZonSet[1].TZonHeaSet, add1.u1) annotation (Line(points={{-10,332},{
          -64,332},{-64,286},{-120,286}}, color={0,0,127}));
  connect(heaSetDR.y[1], add1.u2) annotation (Line(points={{-119,232},{-66,232},
          {-66,274},{-120,274}}, color={0,0,127}));
  connect(zonOutAirSet.nOcc, integerConstant.y) annotation (Line(points={{226,
          433},{168,433},{168,432},{-224,432},{-224,534},{-239,534}}, color={
          255,127,0}));
  connect(zonOutAirSet.uWin, booleanConstant.y) annotation (Line(points={{226,
          430},{144,430},{144,470},{-234,470},{-234,488},{-243,488}}, color={
          255,0,255}));
  connect(booleanConstant1.y, conAHU.u_UnOcc) annotation (Line(points={{-245,
          416},{-208,416},{-208,420},{355.6,420},{355.6,415.741}}, color={255,0,
          255}));
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
  connect(integerConstant1.y, conAHU.uZonTemResReq) annotation (Line(points={{323,392},
          {336,392},{336,433.059},{356,433.059}},      color={255,127,0}));
  connect(integerConstant1.y, conAHU.uZonPreResReq) annotation (Line(points={{323,392},
          {336,392},{336,427.412},{356,427.412}},      color={255,127,0}));
  connect(ductStaPre.y, conAHU.ducStaPre) annotation (Line(points={{-131,114},{
          152,114},{152,532.824},{356,532.824}},
                                             color={0,0,127}));
  connect(TOutCut.y, conAHU.TOutCut) annotation (Line(points={{-79,202},{10,202},
          {10,222},{100,222},{100,470.706},{356,470.706}}, color={0,0,127}));
  connect(VOut_flow.y, conAHU.VOut_flow) annotation (Line(points={{-137,50},{
          -98,50},{-98,68},{-61,68},{-61,218},{-18,218},{-18,454},{356,454},{
          356,453.765}},
        color={0,0,127}));
  connect(TMix1.y, conAHU.TMix) annotation (Line(points={{-25,68},{8,68},{8,70},
          {40,70},{40,446.235},{356,446.235}}, color={0,0,127}));
  connect(TSup1.y, conAHU.TSup) annotation (Line(points={{153,66},{174,66},{174,
          72},{194,72},{194,476},{356,476},{356,476.353}}, color={0,0,127}));
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
end FlexlabX1aNoLeakG36Baseline_test011;
