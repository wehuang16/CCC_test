within CCC_test.obsolete_hil_flexlab_model.ThermalZones;
model Floor_spawnExperiment_Flexlab "Model of a floor of the building"
  extends CCC_test.obsolete_hil_flexlab_model.ThermalZones.PartialFloor(
    VRooCor=cor.V,
    VRooSou=sou.V,
    VRooNor=nor.V,
    AFloCor=cor.AFlo,
    AFloSou=sou.AFlo,
    AFloNor=nor.AFlo,
    opeSouCor(wOpe=9),
    opeNorCor(wOpe=9),
    leaSou(s=27.69/18.46),
    leaNor(s=27.69/18.46));
//    VRooCor=51.018,
//    VRooSou=51.016,
//    VRooNor=53.999,
//    VRooCor=456.455,
//    VRooSou=346.022,
//    VRooNor=346.022,

  final parameter Modelica.Units.SI.Area AFlo=AFloCor + AFloSou + AFloNor  "Total floor area";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorSou
    "Heat port to air volume South"
    annotation (Placement(transformation(extent={{106,-46},{126,-26}}),iconTransformation(extent={{128,-36},{148,-16}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorNor
    "Heat port to air volume North"
    annotation (Placement(transformation(extent={{106,114},{126,134}}),iconTransformation(extent={{126,106},{146,126}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorCor
    "Heat port to air volume corridor"
    annotation (Placement(transformation(extent={{106,36},{126,56}}),iconTransformation(extent={{130,38},{150,58}})));
  Modelica.Units.SI.Temperature TAirCor=cor.TAir "Air temperature corridor";
  Modelica.Units.SI.Temperature TAirSou=sou.TAir "Air temperature south zone";
  Modelica.Units.SI.Temperature TAirNor=nor.TAir "Air temperature north zone";
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone sou(
    redeclare package Medium = Medium,
    nPorts=5,
        zoneName="FlexLab-X3-ZoneA-South-Zone Thermal Zone") "South zone"
    annotation (Placement(transformation(extent={{144,-44},{184,-4}})));
    //    zoneName="Perimeter_ZN_1") "South zone"

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    redeclare package Medium = Medium,
    nPorts=5,
        zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone") "North zone"
    annotation (Placement(transformation(extent={{144,116},{184,156}})));
    //    zoneName="Perimeter_ZN_3") "North zone"

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    redeclare package Medium = Medium,
    nPorts=7,
           zoneName="FlexLab-X3-ZoneA-Core-Zone Thermal Zone") "Core zone"
    annotation (Placement(transformation(extent={{144,60},{184,100}})));
    // zoneName="Core_ZN") "Core zone"

  parameter String idfName=Modelica.Utilities.Files.loadResource(
    "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/RefBldgSmallOffice/RefBldgSmallOfficeNew2004_Chicago.idf")
    "Name of the IDF file";
  parameter String epwName=Modelica.Utilities.Files.loadResource(
    "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw")
    "Name of the weather file";
  parameter String weaName=Modelica.Utilities.Files.loadResource(
    "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    "Name of the weather file";

protected
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=idfName,
    epwName=epwName,
    weaName=weaName,
    computeWetBulbTemperature=false) "Building-level declarations"
    annotation (Placement(transformation(extent={{140,460},{160,480}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant qGai_flow[3](
    k={0,0,0})
    "Internal heat gain (computed already in EnergyPlus"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));

initial equation
  assert(
    abs(
      cor.V-VRooCor) < 0.01,
    "Volumes don't match. These had to be entered manually to avoid using a non-literal value.");
  assert(
    abs(
      sou.V-VRooSou) < 0.01,
    "Volumes don't match. These had to be entered manually to avoid using a non-literal value.");
  assert(
    abs(
      nor.V-VRooNor) < 0.01,
    "Volumes don't match. These had to be entered manually to avoid using a non-literal value.");

  // Other models may override the assignment for AFlo. Hence we check below for consistency.
  assert(
    abs(
      cor.AFlo-AFloCor) < 0.01,
    "Areas don't match. Make sure model that overrides these parameter defaults uses the same values as the idf file uses.");
  assert(
    abs(
      sou.AFlo-AFloSou) < 0.01,
    "Areas don't match. Make sure model that overrides these parameter defaults uses the same values as the idf file uses.");
  assert(
    abs(
      nor.AFlo-AFloNor) < 0.01,
    "Areas don't match. Make sure model that overrides these parameter defaults uses the same values as the idf file uses.");

equation
  connect(sou.heaPorAir,temAirSou.port)
    annotation (Line(points={{164,-24},{224,-24},{224,100},{264,100},{264,350},{290,350}},color={191,0,0},smooth=Smooth.None));
  connect(nor.heaPorAir,temAirNor.port)
    annotation (Line(points={{164,136},{164,136},{164,290},{292,290}},color={191,0,0},smooth=Smooth.None));
  connect(cor.heaPorAir,temAirCor.port)
    annotation (Line(points={{164,80},{164,228},{294,228}},color={191,0,0},smooth=Smooth.None));
  connect(sou.ports[1],portsSou[1])
    annotation (Line(points={{162.4,-43.1},{164,-43.1},{164,-54},{86,-54},{86,-36},
          {85,-36}},                                                                         color={0,127,255},smooth=Smooth.None));
  connect(sou.ports[2],portsSou[2])
    annotation (Line(points={{163.2,-43.1},{164,-43.1},{164,-54},{86,-54},{86,-36},
          {95,-36}},                                                                          color={0,127,255},smooth=Smooth.None));
  connect(nor.ports[1],portsNor[1])
    annotation (Line(points={{162.4,116.9},{164,116.9},{164,106},{88,106},{88,124},
          {85,124}},                                                                         color={0,127,255},smooth=Smooth.None));
  connect(nor.ports[2],portsNor[2])
    annotation (Line(points={{163.2,116.9},{164,116.9},{164,106},{88,106},{88,124},
          {95,124}},                                                                          color={0,127,255},smooth=Smooth.None));
  connect(cor.ports[1],portsCor[1])
    annotation (Line(points={{162.286,60.9},{164,60.9},{164,26},{90,26},{90,46},
          {85,46}},                                                                      color={0,127,255},smooth=Smooth.None));
  connect(cor.ports[2],portsCor[2])
    annotation (Line(points={{162.857,60.9},{164,60.9},{164,26},{90,26},{90,46},
          {95,46}},                                                                       color={0,127,255},smooth=Smooth.None));
  connect(leaSou.port_b,sou.ports[3])
    annotation (Line(points={{-22,400},{-2,400},{-2,-72},{134,-72},{134,-54},{164,-54},{164,-43.1}},color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(leaNor.port_b,nor.ports[3])
    annotation (Line(points={{-20,320},{138,320},{138,116.9},{164,116.9}},color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(opeSouCor.port_b1,cor.ports[3])
    annotation (Line(points={{104,16},{164,16},{164,34},{163.429,34},{163.429,
          60.9}},                                                                    color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(opeSouCor.port_a2,cor.ports[4])
    annotation (Line(points={{104,4},{164,4},{164,60.9},{164,60.9}},    color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(opeSouCor.port_a1,sou.ports[4])
    annotation (Line(points={{84,16},{74,16},{74,-20},{134,-20},{134,-54},{162,-54},
          {162,-46},{164,-46},{164,-43.1},{164.8,-43.1}},                                                                          color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(opeSouCor.port_b2,sou.ports[5])
    annotation (Line(points={{84,4},{74,4},{74,-20},{134,-20},{134,-54},{164,-54},
          {164,-43.1},{165.6,-43.1}},                                                                        color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(opeNorCor.port_b1,nor.ports[4])
    annotation (Line(points={{100,90},{108,90},{108,106},{164,106},{164,116.9},{
          164.8,116.9}},                                                                      color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(opeNorCor.port_a2,nor.ports[5])
    annotation (Line(points={{100,78},{108,78},{108,106},{164,106},{164,116.9},{
          165.6,116.9}},                                                                      color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(opeNorCor.port_a1,cor.ports[5])
    annotation (Line(points={{80,90},{76,90},{76,60},{142,60},{142,60.9},{
          164.571,60.9}},                                                                color={0,127,255},smooth=Smooth.None));
  connect(opeNorCor.port_b2,cor.ports[6])
    annotation (Line(points={{80,78},{76,78},{76,60},{142,60},{142,60.9},{
          165.143,60.9}},                                                                color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(cor.ports[7], senRelPre.port_a)
    annotation (Line(points={{165.714,60.9},{164,60.9},{164,24},{128,24},{128,
          250},{60,250}},                                                                    color={0,127,255},smooth=Smooth.None,thickness=0.5));
  connect(sou.qGai_flow,qGai_flow.y)
    annotation (Line(points={{142,-14},{64,-14},{64,-30},{-118,-30}},color={0,0,127}));
  connect(cor.qGai_flow,qGai_flow.y)
    annotation (Line(points={{142,90},{130,90},{130,110},{-60,110},{-60,-30},{-118,-30}},color={0,0,127}));
  connect(nor.qGai_flow,qGai_flow.y)
    annotation (Line(points={{142,146},{-60,146},{-60,-30},{-118,-30}},color={0,0,127}));
  connect(sou.heaPorAir,heaPorSou)
    annotation (Line(points={{164,-24},{140,-24},{140,-36},{116,-36}},color={191,0,0}));
  connect(nor.heaPorAir,heaPorNor)
    annotation (Line(points={{164,136},{116,136},{116,124}},color={191,0,0}));
  connect(cor.heaPorAir,heaPorCor)
    annotation (Line(points={{164,80},{116,80},{116,46}},color={191,0,0}));
  annotation (
    Diagram(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-160,-100},{380,500}},
        initialScale=0.1)),
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-80,-80},{380,180}}),
      graphics={
        Rectangle(
          extent={{-80,-80},{380,180}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,160},{360,-60}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{0,-80},{294,-60}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-74},{294,-66}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{8,8},{294,100}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,88},{280,22}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-56,170},{20,94},{12,88},{-62,162},{-56,170}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{290,16},{366,-60},{358,-66},{284,8},{290,16}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{284,96},{360,168},{368,162},{292,90},{284,96}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,120},{-60,-20}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-74,120},{-66,-20}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-64,-56},{18,22},{26,16},{-58,-64},{-64,-56}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{360,122},{380,-18}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{366,122},{374,-18}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,170},{296,178}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,160},{296,180}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,166},{296,174}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Bitmap(
          extent={{192,-58},{342,-18}},
          fileName="modelica://Buildings/Resources/Images/ThermalZones/EnergyPlus/spawn_icon_darkbluetxmedres.png",
          visible=not usePrecompiledFMU)}),
    Documentation(
      info="<html>
<p>
Model of a floor that consists
of five thermal zones.
</p>
<p>
The five room model is representative of one floor of the
new construction small office building for Chicago, IL,
as described in the set of DOE Commercial Building Benchmarks
(Deru et al, 2009). There are four perimeter zones and one core zone.
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
</p>
<p>
Each thermal zone can have air flow from the HVAC system,
through leakages of the building envelope (except for the core zone)
and through bi-directional air exchange through open doors that connect adjacent zones.
The bi-directional air exchange is modeled based on the differences in
static pressure between adjacent rooms at a reference height plus the
difference in static pressure across the door height as a function of the difference in air density.
Infiltration is a function of the
flow imbalance of the HVAC system.
</p>
<h4>Implementation</h4>
<p>
Compared to the base class, which has been built for the models in
<a href=\"modelica://Buildings.Examples.VAVReheat\">
Buildings.Examples.VAVReheat</a> which are for a larger building,
the instances of
<a href=\"modelica://Buildings.Airflow.Multizone.DoorOpen\">
Buildings.Airflow.Multizone.DoorOpen</a> are made smaller.
Their length has been reduced proportionally
to the difference in length of the walls of the core zone of the two buildings.
See also <a href=\"modelica://Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SmallOffice\">
Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SmallOffice</a>
for a description of the differences in these buildings.
</p>
<h4>References</h4>
<p>
Deru M., K. Field, D. Studer, K. Benne, B. Griffith, P. Torcellini,
 M. Halverson, D. Winiarski, B. Liu, M. Rosenberg, J. Huang, M. Yazdanian, and D. Crawley.
<i>DOE commercial building research benchmarks for commercial buildings</i>.
Technical report, U.S. Department of Energy, Energy Efficiency and
Renewable Energy, Office of Building Technologies, Washington, DC, 2009.
</p>
</html>",
      revisions="<html>
<ul>
<li>
February 16, 2022, by Michael Wetter:<br/>
Removed assertion on <code>opeWesCor.wOpe</code> as there is no need to enforce this width.
</li>
<li>
April 30, 2021, by Michael Wetter:<br/>
Reformulated replaceable class and introduced floor areas in base class
to avoid access of components that are not in the constraining type.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2471\">issue #2471</a>.
</li>
<li>
November 15, 2019, by Milica Grahovac:<br/>
Added extend from a partial floor model.
</li>
<li>
May 1, 2013, by Michael Wetter:<br/>
Declared the parameter record to be a parameter, as declaring its elements
to be parameters does not imply that the whole record has the variability of a parameter.
</li>
</ul>
</html>"));
end Floor_spawnExperiment_Flexlab;
