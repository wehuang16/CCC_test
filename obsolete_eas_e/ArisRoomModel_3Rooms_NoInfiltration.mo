within CCC_test.obsolete_eas_e;
model ArisRoomModel_3Rooms_NoInfiltration
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/Data/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{118,90},{138,110}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{236,172},{256,192}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=3) annotation (Placement(transformation(extent={{240,106},{280,146}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="FlexLab-X3-ZoneA-Core-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=3)
    annotation (Placement(transformation(extent={{302,14},{342,54}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{144,142},{164,162}}),
        iconTransformation(extent={{286,104},{306,124}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor1(
    zoneName="FlexLab-X3-ZoneB-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=3) annotation (Placement(transformation(extent={{400,118},{440,158}})));
  Modelica.Blocks.Interfaces.RealOutput TOut
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={142,210})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTAir1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={224,210})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTAir2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={296,210})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTAir3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={380,210})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{86,148},{106,168}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{516,152},{536,172}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{84,74},{104,94}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{514,78},{534,98}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{86,2},{106,22}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{514,8},{534,28}})));
equation
  connect(qIntGai.y,nor. qGai_flow) annotation (Line(points={{257,182},{262,182},
          {262,150},{228,150},{228,136},{238,136}}, color={0,0,127}));
  connect(building.weaBus,weaBus)  annotation (Line(
      points={{138,100},{154,100},{154,152}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(qIntGai.y,cor. qGai_flow) annotation (Line(points={{257,182},{262,182},
          {262,150},{294,150},{294,52},{292,52},{292,44},{300,44}},
                              color={0,0,127}));
  connect(qIntGai.y, nor1.qGai_flow) annotation (Line(points={{257,182},{262,
          182},{262,150},{390,150},{390,148},{398,148}}, color={0,0,127}));
  connect(weaBus.TDryBul, TOut) annotation (Line(
      points={{154.05,152.05},{154.05,194},{142,194},{142,210}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(nor.TAir, ZoneTAir1) annotation (Line(points={{281,144},{281,152},{
          224,152},{224,210}},                                         color={0,
          0,127}));
  connect(cor.TAir, ZoneTAir2) annotation (Line(points={{343,52},{348,52},{348,
          192},{296,192},{296,210}},
                         color={0,0,127}));
  connect(nor1.TAir, ZoneTAir3) annotation (Line(points={{441,156},{446,156},{
          446,192},{380,192},{380,210}},color={0,0,127}));
  connect(port_a1, nor.ports[2]) annotation (Line(points={{96,158},{260,158},{
          260,106.9}},    color={0,127,255}));
  connect(port_a2, cor.ports[2]) annotation (Line(points={{94,84},{118,84},{118,
          76},{322,76},{322,14.9}},     color={0,127,255}));
  connect(port_a3, nor1.ports[2]) annotation (Line(points={{96,12},{256,12},{
          256,16},{420,16},{420,118.9}},     color={0,127,255}));
  connect(nor.ports[3], port_b1) annotation (Line(points={{261.333,106.9},{
          261.333,108},{526,108},{526,162}}, color={0,127,255}));
  connect(cor.ports[3], port_b2) annotation (Line(points={{323.333,14.9},{
          323.333,88},{524,88}}, color={0,127,255}));
  connect(nor1.ports[3], port_b3) annotation (Line(points={{421.333,118.9},{540,
          118.9},{540,18},{524,18}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,200}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,200}})));
end ArisRoomModel_3Rooms_NoInfiltration;
