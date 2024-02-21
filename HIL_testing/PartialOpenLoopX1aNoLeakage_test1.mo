within CCC_test.HIL_testing;
partial model PartialOpenLoopX1aNoLeakage_test1
  "Validated Partial model of variable air volume flow system with terminal reheat and 3 VAV zones at flexlab x1a"

  package MediumA = Buildings.Media.Air "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

  constant Integer numZon=3 "Total number of served VAV boxes";
  constant Real leakageFrac=0.2 "Leakage fraction of AHU upstream duct";
  parameter Modelica.Units.SI.Volume VRooCor=flo.VRooCor "Room volume core";
  parameter Modelica.Units.SI.Volume VRooSou=flo.VRooSou "Room volume south";
  parameter Modelica.Units.SI.Volume VRooNor=flo.VRooNor "Room volume north";
  //parameter Modelica.Units.SI.Volume VRooPle=AFloPle*flo.hRoo "Room volume plenum";

  parameter Modelica.Units.SI.Area AFloCor=flo.cor.AFlo "Floor area core";
  parameter Modelica.Units.SI.Area AFloSou=flo.sou.AFlo "Floor area south";
  parameter Modelica.Units.SI.Area AFloNor=flo.nor.AFlo "Floor area north";
  //parameter Modelica.Units.SI.Area AFloPle=flo.ple.AFlo "Floor area plenum";

  parameter Modelica.Units.SI.Area AFlo[numZon]={flo.cor.AFlo,flo.sou.AFlo,
      flo.nor.AFlo} "Floor area of each zone";
  final parameter Modelica.Units.SI.Area ATot=sum(AFlo) "Total floor area";

  constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";
    parameter Modelica.Units.SI.MassFlowRate mCor_flow_nominal=0.106*1.2
    "Design mass flow rate core";
  parameter Modelica.Units.SI.MassFlowRate mSou_flow_nominal=0.189*1.2
    "Design mass flow rate perimeter 1";
  parameter Modelica.Units.SI.MassFlowRate mNor_flow_nominal=0.106*1.2
    "Design mass flow rate perimeter 3";
 // parameter Modelica.Units.SI.MassFlowRate mCor_flow_nominal=6*VRooCor*conv
 //   "Design mass flow rate core";
 // parameter Modelica.Units.SI.MassFlowRate mSou_flow_nominal=6*VRooSou*conv
 //   "Design mass flow rate perimeter 1";
 // parameter Modelica.Units.SI.MassFlowRate mPle_flow_nominal=9*VRooPle*conv
 //   "Design mass flow rate perimeter 2";
 // parameter Modelica.Units.SI.MassFlowRate mNor_flow_nominal=6*VRooNor*conv
 //   "Design mass flow rate perimeter 3";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1.0*(mCor_flow_nominal
       + mSou_flow_nominal + mNor_flow_nominal) "Nominal mass flow rate";
  parameter Modelica.Units.SI.Angle lat=37.87*3.14159/180 "Latitude";

  parameter Modelica.Units.SI.Temperature THeaOn=293.15
    "Heating setpoint during on";
  parameter Modelica.Units.SI.Temperature THeaOff=285.15
    "Heating setpoint during off";
  parameter Modelica.Units.SI.Temperature TCooOn=273.15 + 23.3
    "Cooling setpoint during on";
  parameter Modelica.Units.SI.Temperature TCooOff=303.15
    "Cooling setpoint during off";
  parameter Modelica.Units.SI.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";
  parameter Real yFanMin = 0.1 "Minimum fan speed";

//  parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_nominal= 2.5*yFanMin*m_flow_nominal*1000*(20 - 4)
//    "Nominal capacity of heating coil";

  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Evaluate=true);

  parameter Boolean use_windPressure=true "Set to true to enable wind pressure";

  parameter Boolean sampleModel=true
    "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
    annotation (Evaluate=true, Dialog(tab=
          "Experimental (may be changed in future releases)"));

//  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow heaCoi(
//    redeclare package Medium1 = MediumW,
//    redeclare package Medium2 = MediumA,
//    UA_nominal = QHeaCoi_nominal/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
//      T_a1=45,
//      T_b1=35,
//      T_a2=3,
//      T_b2=20),
//    m2_flow_nominal=m_flow_nominal,
//    allowFlowReversal1=false,
//    allowFlowReversal2=allowFlowReversal,
//    dp1_nominal=0,
//    dp2_nominal=200 + 200 + 100 + 40,
//    m1_flow_nominal=QHeaCoi_nominal/4200/10,
//    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
//    "Heating coil"
//    annotation (Placement(transformation(extent={{118,-36},{98,-56}})));

  Modelica.Blocks.Routing.RealPassThrough TOut(y(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC",
      min=0))
    annotation (Placement(transformation(extent={{-300,170},{-280,190}})));
  Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy=3600*{6,19})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-318,-220},{-298,-200}})));

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("Resources/weatherdata/US_Berkeley_2021_0822.mos"))
    annotation (Placement(transformation(extent={{-360,170},{-340,190}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{-330,170},{-310,190}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
/*
  Results res(
    final A=ATot,
    PFan=fanSup.P + 0,
    PCooSen=cooCoi.QSen2_flow,
    PHea=heaCoi.Q2_flow*1.2,
    PCooLat=cooCoi.QLat2_flow) "Results of the simulation";
    
    
    */

    //PHea=heaCoi.Q2_flow + cor.terHea.Q_flow + sou.terHea.Q_flow + nor.terHea.Q_flow,

  /*fanRet*/

protected
  model Results "Model to store the results of the simulation"
    parameter Modelica.Units.SI.Area A "Floor area";
    input Modelica.Units.SI.Power PFan "Fan energy";
    input Modelica.Units.SI.Power PHea "Heating energy";
    input Modelica.Units.SI.Power PCooSen "Sensible cooling energy";
    input Modelica.Units.SI.Power PCooLat "Latent cooling energy";

    Real EFan(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Fan energy";
    Real EHea(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Heating energy";
    Real ECooSen(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Sensible cooling energy";
    Real ECooLat(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Latent cooling energy";
    Real ECoo(unit="J/m2") "Total cooling energy";
  equation

    A*der(EFan) = PFan;
    A*der(EHea) = PHea;
    A*der(ECooSen) = PCooSen;
    A*der(ECooLat) = PCooLat;
    ECoo = ECooSen + ECooLat;

  end Results;
public
  FakeFloor flo(nout=numZon)
    annotation (Placement(transformation(extent={{654,218},{674,238}})));
equation
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-340,180},{-320,180}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaBus.TDryBul, TOut.u) annotation (Line(
      points={{-319.95,180.05},{-310,180.05},{-310,180},{-302,180}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-380,
            -400},{1420,600}}), graphics={Line(points={{310,404}}, color={28,
              108,200}), Line(
          points={{34,406}},
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
The figure below shows the schematic diagram of the HVAC system
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavSchematics.png\" border=\"1\"/>
</p>
<p>
Most of the HVAC control in this model is open loop.
Two models that extend this model, namely
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>
and
<a href=\"modelica://Buildings.Examples.VAVReheat.Guideline36\">
Buildings.Examples.VAVReheat.Guideline36</a>
add closed loop control. See these models for a description of
the control sequence.
</p>
<p>
To model the heat transfer through the building envelope,
a model of five interconnected rooms is used.
The five room model is representative of one floor of the
new construction medium office building for Chicago, IL,
as described in the set of DOE Commercial Building Benchmarks
(Deru et al, 2009). There are four perimeter zones and one core zone.
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
The thermal room model computes transient heat conduction through
walls, floors and ceilings and long-wave radiative heat exchange between
surfaces. The convective heat transfer coefficient is computed based
on the temperature difference between the surface and the room air.
There is also a layer-by-layer short-wave radiation,
long-wave radiation, convection and conduction heat transfer model for the
windows. The model is similar to the
Window 5 model and described in TARCOG 2006.
</p>
<p>
Each thermal zone can have air flow from the HVAC system, through leakages of the building envelope (except for the core zone) and through bi-directional air exchange through open doors that connect adjacent zones. The bi-directional air exchange is modeled based on the differences in static pressure between adjacent rooms at a reference height plus the difference in static pressure across the door height as a function of the difference in air density.
Infiltration is a function of the
flow imbalance of the HVAC system.
</p>
<h4>References</h4>
<p>
Deru M., K. Field, D. Studer, K. Benne, B. Griffith, P. Torcellini,
 M. Halverson, D. Winiarski, B. Liu, M. Rosenberg, J. Huang, M. Yazdanian, and D. Crawley.
<i>DOE commercial building research benchmarks for commercial buildings</i>.
Technical report, U.S. Department of Energy, Energy Efficiency and
Renewable Energy, Office of Building Technologies, Washington, DC, 2009.
</p>
<p>
TARCOG 2006: Carli, Inc., TARCOG: Mathematical models for calculation
of thermal performance of glazing systems with our without
shading devices, Technical Report, Oct. 17, 2006.
</p>
</html>", revisions="<html>
<ul>
<li>
September 26, 2017, by Michael Wetter:<br/>
Separated physical model from control to facilitate implementation of alternate control
sequences.
</li>
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
</html>"));
end PartialOpenLoopX1aNoLeakage_test1;
