within CCC_test.Examples;
model ArisRoomModel_3Rooms_NoInfiltration_NewYork_test
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/400_3rd_Street_v1.0_Aprt_4R_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{118,90},{138,110}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{236,172},{256,192}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="Level4:4RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=2) annotation (Placement(transformation(extent={{240,106},{280,146}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="Level4:4RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{302,14},{342,54}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{144,142},{164,162}}),
        iconTransformation(extent={{286,104},{306,124}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor1(
    zoneName="Level4:4RBedroom2Q1",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=2) annotation (Placement(transformation(extent={{400,118},{440,158}})));
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
      points={{154,152},{154,194},{142,194},{142,210}},
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
  connect(port_a1, nor.ports[1]) annotation (Line(points={{96,158},{200,158},{
          200,94},{259,94},{259,106.9}}, color={0,127,255}));
  connect(nor.ports[2], port_b1) annotation (Line(points={{261,106.9},{261,120},
          {526,120},{526,162}}, color={0,127,255}));
  connect(port_a2, cor.ports[1]) annotation (Line(points={{94,84},{180,84},{180,
          16},{321,16},{321,14.9}}, color={0,127,255}));
  connect(cor.ports[2], port_b2) annotation (Line(points={{323,14.9},{323,88},{
          524,88}}, color={0,127,255}));
  connect(port_a3, nor1.ports[1]) annotation (Line(points={{96,12},{419,12},{
          419,118.9}}, color={0,127,255}));
  connect(nor1.ports[2], port_b3) annotation (Line(points={{421,118.9},{421,18},
          {524,18}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,200}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,200}})));
end ArisRoomModel_3Rooms_NoInfiltration_NewYork_test;
