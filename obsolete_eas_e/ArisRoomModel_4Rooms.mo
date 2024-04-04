within CCC_test.obsolete_eas_e;
model ArisRoomModel_4Rooms
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{118,90},{138,110}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{236,172},{256,192}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone nor(
    zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone",
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
    nPorts=4)   "Boundary condition"
    annotation (Placement(transformation(extent={{170,52},{190,72}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="FlexLab-X3-ZoneA-Core-Zone Thermal Zone",
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
    zoneName="FlexLab-X3-ZoneB-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=4) annotation (Placement(transformation(extent={{400,118},{440,158}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor1(
    zoneName="FlexLab-X3-ZoneB-Core-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=4)
    annotation (Placement(transformation(extent={{462,26},{502,66}})));
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
  Buildings.Fluid.FixedResistances.PressureDrop ducCor1(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*cor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{486,-24},{466,-4}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirCor1(
    redeclare package Medium = MediumAir,
    m_flow=0.3*cor1.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{464,-80},{484,-60}})));
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
  Modelica.Blocks.Interfaces.RealOutput ZoneTAir4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={464,210})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a4(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{88,-62},{108,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b4(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{516,-56},{536,-36}})));
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
          80},{196,60.5},{190,60.5}},
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
          -26},{196,61.5},{190,61.5}}, color={0,127,255}));
  connect(freshAirCor.ports[1], cor.ports[2]) annotation (Line(points={{324,-82},
          {334,-82},{334,8},{321.5,8},{321.5,14.9}},
                                                 color={0,127,255}));
  connect(building.weaBus, freshAirCor.weaBus) annotation (Line(
      points={{138,100},{290,100},{290,-81.8},{304,-81.8}},
      color={255,204,51},
      thickness=0.5));
  connect(qIntGai.y, nor1.qGai_flow) annotation (Line(points={{257,182},{262,
          182},{262,150},{390,150},{390,148},{398,148}}, color={0,0,127}));
  connect(qIntGai.y, cor1.qGai_flow) annotation (Line(points={{257,182},{262,
          182},{262,150},{294,150},{294,72},{452,72},{452,56},{460,56}}, color=
          {0,0,127}));
  connect(cor1.ports[1], ducCor1.port_a) annotation (Line(points={{480.5,26.9},
          {480.5,2},{492,2},{492,-14},{486,-14}},
                                               color={0,127,255}));
  connect(ducCor1.port_b, pAtm.ports[3]) annotation (Line(points={{466,-14},{
          300,-14},{300,-26},{196,-26},{196,62.5},{190,62.5}}, color={0,127,255}));
  connect(ducNor1.port_b, pAtm.ports[4]) annotation (Line(points={{366,120},{
          286,120},{286,26},{196,26},{196,63.5},{190,63.5}}, color={0,127,255}));
  connect(nor1.ports[1], ducNor1.port_a) annotation (Line(points={{418.5,118.9},
          {418.5,112},{394,112},{394,120},{386,120}},
                                                   color={0,127,255}));
  connect(nor1.ports[2], freshAirNor1.ports[1]) annotation (Line(points={{419.5,
          118.9},{418,118.9},{418,90},{386,90},{386,88}}, color={0,127,255}));
  connect(cor1.ports[2], freshAirCor1.ports[1]) annotation (Line(points={{481.5,
          26.9},{481.5,2},{492,2},{492,-70},{484,-70}},
                                                      color={0,127,255}));
  connect(building.weaBus, freshAirNor1.weaBus) annotation (Line(
      points={{138,100},{290,100},{290,88.2},{366,88.2}},
      color={255,204,51},
      thickness=0.5));
  connect(building.weaBus, freshAirCor1.weaBus) annotation (Line(
      points={{138,100},{290,100},{290,-82},{296,-82},{296,-98},{454,-98},{454,
          -69.8},{464,-69.8}},
      color={255,204,51},
      thickness=0.5));
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
  connect(cor1.TAir, ZoneTAir4)
    annotation (Line(points={{503,64},{508,64},{508,196},{464,196},{464,210}},
                                                           color={0,0,127}));
  connect(port_a4, cor1.ports[3]) annotation (Line(points={{98,-52},{492,-52},{
          492,2},{482.5,2},{482.5,26.9}}, color={0,127,255}));
  connect(port_b4, cor1.ports[4]) annotation (Line(points={{526,-46},{492,-46},
          {492,2},{483.5,2},{483.5,26.9}}, color={0,127,255}));
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
end ArisRoomModel_4Rooms;
