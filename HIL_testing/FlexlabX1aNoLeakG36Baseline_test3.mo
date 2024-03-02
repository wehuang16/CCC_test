within CCC_test.HIL_testing;
model FlexlabX1aNoLeakG36Baseline_test3
  "DR mode - Variable air volume flow system with terminal reheat and five thermal zones at Flexlab X1 cell"
  extends Modelica.Icons.Example;
  extends CCC_test.HIL_testing.PartialOpenLoopX1aNoLeakage_test3(
    flo(
      idfName=Modelica.Utilities.Files.loadResource(
          "modelica://hil_flexlab_model/Resources/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
      epwName=Modelica.Utilities.Files.loadResource(
          "modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.epw"),
      weaName=Modelica.Utilities.Files.loadResource(
          "modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.mos")),
    weaDat(filNam=Modelica.Utilities.Files.loadResource(
          "modelica://hil_flexlab_model/Resources/weatherdata/US_Berkeley_20210913.mos")),
    dpRetDuc1(dp_nominal=30.3));

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

  hil_flexlab_model.Test1.Plants1.Controls.Controller conVAVNor(
    V_flow_nominal=mNor_flow_nominal/1.2,
    AFlo=AFloNor,
    final samplePeriod=samplePeriod) "Controller for terminal unit north zone"
    annotation (Placement(transformation(extent={{654,4},{674,24}})));
  hil_flexlab_model.Test1.Plants1.Controls.Controller conVAVCor(
    V_flow_nominal=mCor_flow_nominal/1.2,
    AFlo=AFloCor,
    final samplePeriod=samplePeriod) "Controller for terminal unit mid zone"
    annotation (Placement(transformation(extent={{780,104},{800,124}})));
  hil_flexlab_model.Test1.Plants1.Controls.Controller conVAVSou(
    V_flow_nominal=mSou_flow_nominal/1.2,
    AFlo=AFloSou,
    final samplePeriod=samplePeriod) "Controller for terminal unit south zone"
    annotation (Placement(transformation(extent={{1020,32},{1040,52}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      freStaSetPoi1(k=273.15
         + 3) "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yFreHeaCoi(final k=0)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{0,-192},{20,-172}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yFreHeaCoi1(final k=1)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{-4,-254},{16,-234}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yFreHeaCoi2(final k=
        0.5)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{222,-24},{242,-4}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yFreHeaCoi3(final k=
        273.15 + 20)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{468,90},{488,110}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      yFreCooCoi4(final k=
        273.15 + 24)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{424,20},{444,40}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=7)
    annotation (Placement(transformation(extent={{610,-70},{630,-50}})));
equation
  connect(TRooAir.y2[1], conVAVCor.TZon) annotation (Line(
      points={{511,170},{766,170},{766,114},{778,114}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TSupNor.T, conVAVNor.TDis) annotation (Line(points={{697,90},{638,90},
          {638,8},{652,8}},   color={0,0,127}));
  connect(TSupCor.T, conVAVCor.TDis) annotation (Line(points={{869,94},{762,94},
          {762,108},{778,108}},
                              color={0,0,127}));
  connect(TSupSou.T, conVAVSou.TDis) annotation (Line(points={{1069,90},{1002,90},
          {1002,36},{1018,36}},     color={0,0,127}));
  connect(conVAVNor.yDam,nor.yVAV)  annotation (Line(points={{676,20},{688,20},
          {688,46},{694,46}},color={0,0,127}));
  connect(conVAVNor.yVal,nor.yVal)  annotation (Line(points={{676,15},{684,15},
          {684,30},{694,30}},   color={0,0,127}));
  connect(conVAVCor.yVal, cor.yVal) annotation (Line(points={{802,115},{808,115},
          {808,36},{866,36}},   color={0,0,127}));
  connect(conVAVCor.yDam, cor.yVAV) annotation (Line(points={{802,120},{836,120},
          {836,52},{866,52}}, color={0,0,127}));
  connect(conVAVSou.yDam, sou.yVAV) annotation (Line(points={{1042,48},{1048,48},
          {1048,44},{1066,44}},       color={0,0,127}));
  connect(conVAVSou.yVal, sou.yVal) annotation (Line(points={{1042,43},{1042,40},
          {1056,40},{1056,28},{1066,28}},
                                      color={0,0,127}));

  connect(VSupNor_flow.V_flow,conVAVNor. VDis_flow) annotation (Line(points={{697,128},
          {632,128},{632,12},{652,12}},      color={0,0,127}));
  connect(VSupCor_flow.V_flow, conVAVCor.VDis_flow) annotation (Line(points={{869,134},
          {764,134},{764,112},{778,112}},        color={0,0,127}));
  connect(VSupSou_flow.V_flow, conVAVSou.VDis_flow) annotation (Line(points={{1069,
          128},{1008,128},{1008,40},{1018,40}},      color={0,0,127}));
  connect(TSup.T,conVAVNor. TSupAHU) annotation (Line(points={{340,-29},{340,-20},
          {546,-20},{546,6},{652,6}},   color={0,0,127}));
  connect(TSup.T, conVAVCor.TSupAHU) annotation (Line(points={{340,-29},{340,-20},
          {764,-20},{764,106},{778,106}},    color={0,0,127}));
  connect(TSup.T, conVAVSou.TSupAHU) annotation (Line(points={{340,-29},{340,-20},
          {678,-20},{678,34},{1018,34}},   color={0,0,127}));
  connect(conVAVNor.yDam_actual, nor.y_actual) annotation (Line(points={{652,10},
          {642,10},{642,72},{746,72},{746,54},{740,54}}, color={0,0,127}));
  connect(conVAVCor.yDam_actual, cor.y_actual) annotation (Line(points={{778,110},
          {770,110},{770,74},{876,74},{876,60},{912,60}},color={0,0,127}));
  connect(conVAVSou.yDam_actual, sou.y_actual) annotation (Line(points={{1018,38},
          {1012,38},{1012,68},{1126,68},{1126,52},{1112,52}}, color={0,0,127}));
  connect(conVAVSou.TZon, TRooAir.y1[1]) annotation (Line(points={{1018,42},{
          980,42},{980,177},{511,177}}, color={0,0,127}));
  connect(conVAVNor.TZon, TRooAir.y3[1]) annotation (Line(points={{652,14},{646,
          14},{646,163},{511,163}}, color={0,0,127}));
  connect(yFreHeaCoi.y, gaiHeaCoi.u)
    annotation (Line(points={{22,-182},{98,-182},{98,-210}}, color={0,0,127}));
  connect(yFreHeaCoi1.y, gaiCooCoi.u)
    annotation (Line(points={{18,-244},{18,-248},{98,-248}}, color={0,0,127}));
  connect(yFreHeaCoi2.y, fanSup.y)
    annotation (Line(points={{244,-14},{244,-28},{310,-28}}, color={0,0,127}));
  connect(yFreHeaCoi3.y, conVAVCor.TZonHeaSet) annotation (Line(points={{490,
          100},{680,100},{680,112},{778,112},{778,124}}, color={0,0,127}));
  connect(yFreCooCoi4.y, conVAVCor.TZonCooSet) annotation (Line(points={{446,30},
          {512,30},{512,96},{608,96},{608,112},{736,112},{736,122},{778,122}},
        color={0,0,127}));
  connect(yFreHeaCoi3.y, conVAVNor.TZonHeaSet) annotation (Line(points={{490,
          100},{490,112},{652,112},{652,24}}, color={0,0,127}));
  connect(yFreHeaCoi3.y, conVAVSou.TZonHeaSet) annotation (Line(points={{490,
          100},{490,112},{768,112},{768,88},{856,88},{856,72},{904,72},{904,80},
          {992,80},{992,52},{1018,52}}, color={0,0,127}));
  connect(yFreCooCoi4.y, conVAVNor.TZonCooSet) annotation (Line(points={{446,30},
          {458,30},{458,12},{652,12},{652,22}}, color={0,0,127}));
  connect(yFreCooCoi4.y, conVAVSou.TZonCooSet) annotation (Line(points={{446,30},
          {474,30},{474,14},{1018,14},{1018,50}}, color={0,0,127}));
  connect(integerConstant.y, conVAVNor.uOpeMod) annotation (Line(points={{631,
          -60},{631,-64},{652,-64},{652,4}}, color={255,127,0}));
  connect(integerConstant.y, conVAVSou.uOpeMod) annotation (Line(points={{631,
          -60},{631,-64},{656,-64},{656,-16},{840,-16},{840,8},{984,8},{984,32},
          {1018,32}}, color={255,127,0}));
  connect(integerConstant.y, conVAVCor.uOpeMod) annotation (Line(points={{631,
          -60},{716,-60},{716,-106},{784,-106},{784,104},{778,104}}, color={255,
          127,0}));
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
end FlexlabX1aNoLeakG36Baseline_test3;
