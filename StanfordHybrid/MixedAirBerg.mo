within CCC_test.StanfordHybrid;
model MixedAirBerg "Free response of room model"
  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Air "Medium model";

  parameter Buildings.HeatTransfer.Data.Solids.Plywood matWoo(
    x=0.01,
    k=0.11,
    d=544,
    nStaRef=1) "Wood for exterior construction"
    annotation (Placement(transformation(extent={{40,110},{60,130}})));
  parameter Buildings.HeatTransfer.Data.Solids.Concrete matCon(
    x=0.1,
    k=1.311,
    c=836,
    nStaRef=5) "Concrete"
    annotation (Placement(transformation(extent={{40,140},{60,160}})));
  parameter Buildings.HeatTransfer.Data.Solids.Generic matIns(
    x=0.087,
    k=0.049,
    c=836.8,
    d=265,
    nStaRef=5) "Steelframe construction with insulation"
    annotation (Placement(transformation(extent={{80,110},{100,130}})));
  parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp(
    x=0.0127,
    k=0.16,
    c=830,
    d=784,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp2(
    x=0.025,
    k=0.16,
    c=830,
    d=784,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matFur(x=0.15, nStaRef=5)
    "Material for furniture"
    annotation (Placement(transformation(extent={{80,170},{100,190}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matCarTra(
    x=0.215/0.11,
    k=0.11,
    d=544,
    nStaRef=1) "Wood for floor"
    annotation (Placement(transformation(extent={{40,170},{60,190}})));
  parameter Buildings.HeatTransfer.Data.Resistances.Carpet matCar "Carpet"
    annotation (Placement(transformation(extent={{78,42},{98,62}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear glaSys(
    UFra=2,
    shade=Buildings.HeatTransfer.Data.Shades.Gray(),
    haveInteriorShade=false,
    haveExteriorShade=false) "Data record for the glazing system"
    annotation (Placement(transformation(extent={{80,140},{100,160}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(
    final nLay=1,
    material={matBergSip},
    absSol_a=0.7,
    absSol_b=0.7,
    roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Smooth)
    "Exterior construction"
    annotation (Placement(transformation(extent={{-70,142},{-50,162}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(
    final nLay=1,
    material={matGyp2}) "Interior wall construction"
    annotation (Placement(transformation(extent={{102,46},{122,66}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFlo(
    final nLay=1,
    material={matCon}) "Floor construction (opa_a is carpet)"
    annotation (Placement(transformation(extent={{124,46},{144,66}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFur(
    final nLay=1,
    material={matFur}) "Construction for internal mass of furniture"
    annotation (Placement(transformation(extent={{160,42},{180,62}})));

  parameter String weaFil = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
   "Weather data file";

   parameter Modelica.Units.SI.Length LengthFlo=6.096 "length of floor";
   parameter Modelica.Units.SI.Length WidthFlo=6.096 "width of floor";
  parameter Modelica.Units.SI.Volume VRoo= AFlo*hRoo "Room volum";
  parameter Modelica.Units.SI.Height hRoo=2.4384 "Room height";
  parameter Modelica.Units.SI.Length hWin=1.5 "Height of windows";
  parameter Real winWalRat(min=0.01,max=0.99) = 0.33
    "Window to wall ratio for exterior walls";
  parameter Modelica.Units.SI.Area AFlo=LengthFlo*WidthFlo "Floor area";

  Buildings.ThermalZones.Detailed.MixedAir roo(
    datConExt(
      layers={conRoof,conExtWal,conExtWal,conExtWal,conExtWal},
      A={LengthFlo*WidthFlo,LengthFlo*hRoo,LengthFlo*hRoo,WidthFlo*hRoo,
          WidthFlo*hRoo},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.S,
          Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.E}),
    datConBou(
      layers={conFloor},
      each A=LengthFlo*WidthFlo,
      each til=Buildings.Types.Tilt.Floor,
      each azi=Buildings.Types.Azimuth.S),
    redeclare package Medium = Medium,
    AFlo=AFlo,
    hRoo=hRoo,
    nConExt=5,
    nConExtWin=0,
    nConPar=0,
    nConBou=1,
    nSurBou=0,
    linearizeRadiation=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPorts=2) "Floor"
    annotation (Placement(transformation(extent={{66,-66},{106,-26}})));

  Modelica.Blocks.Sources.Constant qConGai_flow(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant qRadGai_flow(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1 "Multiplex"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.Constant qLatGai_flow(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(zoneName="BERG Thermal Zone",
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{260,-48},{300,-8}})));
  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{236,48},{256,68}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{204,-26},{224,-6}}),
        iconTransformation(extent={{286,104},{306,124}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/Data/energyPlusFiles/BERG_Envelope_HMB_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/Half_Moon_Bay.epw"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/Half_Moon_Bay.mos"))
    annotation (Placement(transformation(extent={{118,-34},{138,-14}})));

  parameter Buildings.HeatTransfer.Data.Solids.Plywood matBergSip(
    x=0.053975,
    k=0.0204764,
    c=2343.04,
    d=37.4832042950667,
    nStaRef=1) "Wood for exterior construction"
    annotation (Placement(transformation(extent={{-34,148},{-14,168}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matBergRoof(
    x=0.0762,
    k=0.0253792,
    c=2343.04,
    d=37.4832042950667,
    nStaRef=1) "Wood for exterior construction"
    annotation (Placement(transformation(extent={{-32,80},{-12,100}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conRoof(
    final nLay=1,
    material={matBergRoof},
    absSol_a=0.7,
    absSol_b=0.7,
    roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Smooth)
    "Exterior construction"
    annotation (Placement(transformation(extent={{-72,80},{-52,100}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFloor(
    final nLay=1,
    material={matBergFloor},
    absSol_a=0.7,
    absSol_b=0.7,
    roughness_a=Buildings.HeatTransfer.Types.SurfaceRoughness.Smooth)
    "Exterior construction"
    annotation (Placement(transformation(extent={{-70,52},{-50,72}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matBergFloor(
    x=0.0762,
    k=0.0253792,
    c=2343.04,
    d=37.4832042950667,
    nStaRef=1) "Wood for exterior construction"
    annotation (Placement(transformation(extent={{-30,52},{-10,72}})));
  Buildings.Fluid.FixedResistances.PressureDrop
                                      duc(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=47*6/3600*1.2)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{20,-66},{40,-46}})));
  Buildings.Fluid.Sources.MassFlowSource_T
                                 bou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=0,
    nPorts=1,
    T=293.15) "Boundary condition"
    annotation (Placement(transformation(extent={{-58,-154},{-38,-134}})));
  Buildings.Fluid.Sources.Outside
                        freshAir(redeclare package Medium = Medium, nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{-8,-90},{12,-70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-16,-164},{4,-144}})));
  CalculateInflitration calculateInflitration
    annotation (Placement(transformation(extent={{-154,-118},{-134,-98}})));
  Modelica.Blocks.Sources.Constant const(k=6)
    annotation (Placement(transformation(extent={{-226,-130},{-206,-110}})));
  Modelica.Blocks.Math.Gain UnitConversion(k=1/1000*1.2)
    "from L/s to kg/s assuming 1.2kg/m3 air"
    annotation (Placement(transformation(extent={{-126,-148},{-106,-128}})));
  Modelica.Blocks.Math.Gain NegativeSign(k=-1)
    annotation (Placement(transformation(extent={{-88,-176},{-68,-156}})));
equation
  connect(qRadGai_flow.y, multiplex3_1.u1[1])  annotation (Line(
      points={{-39,10},{-30,10},{-30,-23},{-22,-23}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow.y, multiplex3_1.u2[1]) annotation (Line(
      points={{-39,-30},{-22,-30}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(qLatGai_flow.y, multiplex3_1.u3[1])  annotation (Line(
      points={{-39,-70},{-30,-70},{-30,-37},{-22,-37}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_1.y, roo.qGai_flow) annotation (Line(
      points={{1,-30},{60,-30},{60,-38},{64.4,-38}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(qIntGai.y,cor. qGai_flow) annotation (Line(points={{257,58},{262,58},{
          262,0},{250,0},{250,-18},{258,-18}},
                              color={0,0,127}));
  connect(building.weaBus,weaBus)  annotation (Line(
      points={{138,-24},{198,-24},{198,-16},{214,-16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, roo.weaBus) annotation (Line(
      points={{214,-16},{198,-16},{198,-24},{144,-24},{144,-40},{112,-40},{112,
          -28.1},{103.9,-28.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(freshAir.ports[1],duc. port_a)
    annotation (Line(points={{12,-80},{14,-80},{14,-56},{20,-56}},
                                                 color={0,127,255}));
  connect(weaBus, freshAir.weaBus) annotation (Line(
      points={{214,-16},{198,-16},{198,-24},{144,-24},{144,-96},{-18,-96},{-18,
          -79.8},{-8,-79.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(duc.port_b, roo.ports[1]) annotation (Line(points={{40,-56},{56,-56},
          {56,-57},{71,-57}}, color={0,127,255}));
  connect(bou.ports[1], senTem.port_a) annotation (Line(points={{-38,-144},{-22,
          -144},{-22,-154},{-16,-154}}, color={0,127,255}));
  connect(senTem.port_b, roo.ports[2]) annotation (Line(points={{4,-154},{16,
          -154},{16,-94},{56,-94},{56,-55},{71,-55}}, color={0,127,255}));
  connect(weaBus.winSpe, calculateInflitration.WindSpeed) annotation (Line(
      points={{214.05,-15.95},{216,-15.95},{216,-186},{-182,-186},{-182,-103.4},
          {-156.2,-103.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, calculateInflitration.AverageTempeatureDifference)
    annotation (Line(points={{-205,-120},{-166,-120},{-166,-112.4},{-156,-112.4}},
        color={0,0,127}));
  connect(calculateInflitration.AirInfiltration, UnitConversion.u) annotation (
      Line(points={{-133,-108},{-133,-130},{-136,-130},{-136,-138},{-128,-138}},
        color={0,0,127}));
  connect(UnitConversion.y, NegativeSign.u) annotation (Line(points={{-105,-138},
          {-100,-138},{-100,-166},{-90,-166}}, color={0,0,127}));
  connect(NegativeSign.y, bou.m_flow_in) annotation (Line(points={{-67,-166},{
          -67,-144},{-68,-144},{-68,-136},{-60,-136}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {200,200}})),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/Detailed/Examples/MixedAirFreeResponse.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model illustrates the use of the room model
<a href=\"modelica://Buildings.ThermalZones.Detailed.MixedAir\">
Buildings.ThermalZones.Detailed.MixedAir</a>.
</p>
<p>
The geometry, materials and constructions of the model are consistent with those of
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.Floor\">
Buildings.Examples.VAVReheat.BaseClasses.Floor</a>
but here they are modeled as a single thermal zone.
The model is representative for one floor of the
new construction medium office building for Chicago, IL,
as described in the set of DOE Commercial Building Benchmarks.
There are four perimeter zones and one core zone.
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
</p>
<p>
For a comparison between the one-zone and five-zone model, see
<a href=\"modelica://Buildings.ThermalZones.Detailed.Validation.SingleZoneFloorWithHeating\">
Buildings.ThermalZones.Detailed.Validation.SingleZoneFloorWithHeating</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 10, 2020, by Michael Wetter:<br/>
Changed room model geometry and construction material.
</li>
<li>
October 29, 2016, by Michael Wetter:<br/>
Changed example to place a state at the surface,
and removed computation of the wet bulb temperature
as it is not needed.<br/>
Added thermal resistance of soil, because at the connector
<code>surf_conBou</code>, there is now a state variable, and
hence the temperature cannot be prescribed if its initial value
is specified.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/565\">issue 565</a>.
</li>
<li>
March 26, 2015, by Michael Wetter:<br/>
Set initialization of <code>conOut</code>
to be steady-state initialization.
</li>
<li>
February 12, 2015, by Michael Wetter:<br/>
Set initial temperature to be <i>22</i>&deg;C to add
propagation of the initial temperature to this test case.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
September 11, 2014, by Michael Wetter:<br/>
Changed assignment of <code>layers</code> in <code>conOut</code>
as <code>layers</code> is no longer replaceable.
</li>
<li>
May 1, 2013, by Michael Wetter:<br/>
Declared the parameter record to be a parameter, as declaring its elements
to be parameters does not imply that the whole record has the variability of a parameter.
</li>
<li>
December 14, 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StartTime=24192000,
      StopTime=24364800,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end MixedAirBerg;
