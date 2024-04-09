within CCC_test.StanfordHybrid;
model TestHybridZone

      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/Data/energyPlusFiles/BERG_Envelope_HMB_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/Half_Moon_Bay.epw"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://CCC/Resources/weatherdata/Half_Moon_Bay.mos"))
    annotation (Placement(transformation(extent={{-118,-36},{-98,-16}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{0,46},{20,66}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="BERG Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{24,-48},{64,-8}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{-32,-28},{-12,-8}}),
        iconTransformation(extent={{286,104},{306,124}})));
  Buildings.ThermalZones.Detailed.MixedAir mixedAir
    annotation (Placement(transformation(extent={{10,-106},{50,-66}})));
  Modelica.Blocks.Sources.Constant uSha(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-48,-66},{-28,-46}})));
equation
  connect(building.weaBus,weaBus)  annotation (Line(
      points={{-98,-26},{-38,-26},{-38,-18},{-22,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(qIntGai.y,cor. qGai_flow) annotation (Line(points={{21,56},{26,56},{
          26,-4},{12,-4},{12,-18},{22,-18}},
                              color={0,0,127}));
  connect(qIntGai.y, mixedAir.qGai_flow) annotation (Line(points={{21,56},{-4,
          56},{-4,-78},{8.4,-78}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestHybridZone;
