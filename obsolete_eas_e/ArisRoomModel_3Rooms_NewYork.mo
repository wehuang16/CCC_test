within CCC_test.obsolete_eas_e;
model ArisRoomModel_3Rooms_NewYork
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/Data/energyPlusFiles/400_3rd_Street_v1.0_Aprt_4R_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{118,90},{138,110}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{236,172},{256,192}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="Level4:4RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=4) annotation (Placement(transformation(extent={{240,106},{280,146}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducNor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*nor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{248,70},{228,90}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirNor(
    redeclare package Medium = MediumAir,
    m_flow=0.3*nor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{220,32},{240,52}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm(
    redeclare package Medium = MediumAir,
    p=101300,
    nPorts=3)   "Boundary condition"
    annotation (Placement(transformation(extent={{170,52},{190,72}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="Level4:4RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=4)
    annotation (Placement(transformation(extent={{302,14},{342,54}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducCor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*cor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{326,-36},{306,-16}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirCor(
    redeclare package Medium = MediumAir,
    m_flow=0.3*cor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{304,-92},{324,-72}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{144,142},{164,162}}),
        iconTransformation(extent={{286,104},{306,124}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor1(
    zoneName="Level4:4RBedroom2Q1",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=4) annotation (Placement(transformation(extent={{400,118},{440,158}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducNor1(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*nor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{386,110},{366,130}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirNor1(
    redeclare package Medium = MediumAir,
    m_flow=0.3*nor1.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{366,78},{386,98}})));
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
  connect(ducNor.port_b,pAtm. ports[1]) annotation (Line(points={{228,80},{196,
          80},{196,60.6667},{190,60.6667}},
                                  color={0,127,255}));
  connect(ducNor.port_a,nor. ports[1]) annotation (Line(points={{248,80},{258.5,
          80},{258.5,106.9}},color={0,127,255}));
  connect(freshAirNor.ports[1],nor. ports[2]) annotation (Line(points={{240,42},
          {259.5,42},{259.5,106.9}},                  color={0,127,255}));
  connect(building.weaBus,freshAirNor. weaBus) annotation (Line(
      points={{138,100},{210,100},{210,42.2},{220,42.2}},
      color={255,204,51},
      thickness=0.5));
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
  connect(cor.ports[1], ducCor.port_a) annotation (Line(points={{320.5,14.9},{
          320.5,-10},{332,-10},{332,-26},{326,-26}},
                                               color={0,127,255}));
  connect(ducCor.port_b, pAtm.ports[2]) annotation (Line(points={{306,-26},{196,
          -26},{196,62},{190,62}},     color={0,127,255}));
  connect(freshAirCor.ports[1], cor.ports[2]) annotation (Line(points={{324,-82},
          {334,-82},{334,8},{321.5,8},{321.5,14.9}},
                                                 color={0,127,255}));
  connect(building.weaBus, freshAirCor.weaBus) annotation (Line(
      points={{138,100},{290,100},{290,-81.8},{304,-81.8}},
      color={255,204,51},
      thickness=0.5));
  connect(qIntGai.y, nor1.qGai_flow) annotation (Line(points={{257,182},{262,
          182},{262,150},{390,150},{390,148},{398,148}}, color={0,0,127}));
  connect(ducNor1.port_b, pAtm.ports[3]) annotation (Line(points={{366,120},{
          286,120},{286,26},{196,26},{196,63.3333},{190,63.3333}},
                                                             color={0,127,255}));
  connect(nor1.ports[1], ducNor1.port_a) annotation (Line(points={{418.5,118.9},
          {418.5,112},{394,112},{394,120},{386,120}},
                                                   color={0,127,255}));
  connect(nor1.ports[2], freshAirNor1.ports[1]) annotation (Line(points={{419.5,
          118.9},{418,118.9},{418,90},{386,90},{386,88}}, color={0,127,255}));
  connect(building.weaBus, freshAirNor1.weaBus) annotation (Line(
      points={{138,100},{290,100},{290,88.2},{366,88.2}},
      color={255,204,51},
      thickness=0.5));
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
  connect(port_a1, nor.ports[3]) annotation (Line(points={{96,158},{260.5,158},
          {260.5,106.9}}, color={0,127,255}));
  connect(port_b1, nor.ports[4]) annotation (Line(points={{526,162},{398,162},{
          398,168},{261.5,168},{261.5,106.9}}, color={0,127,255}));
  connect(port_a2, cor.ports[3]) annotation (Line(points={{94,84},{118,84},{118,
          76},{322.5,76},{322.5,14.9}}, color={0,127,255}));
  connect(port_b2, cor.ports[4]) annotation (Line(points={{524,88},{432,88},{
          432,84},{323.5,84},{323.5,14.9}}, color={0,127,255}));
  connect(port_a3, nor1.ports[3]) annotation (Line(points={{96,12},{256,12},{
          256,16},{420.5,16},{420.5,118.9}}, color={0,127,255}));
  connect(port_b3, nor1.ports[4]) annotation (Line(points={{524,18},{474,18},{
          474,30},{421.5,30},{421.5,118.9}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,200}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,200}})));
end ArisRoomModel_3Rooms_NewYork;
