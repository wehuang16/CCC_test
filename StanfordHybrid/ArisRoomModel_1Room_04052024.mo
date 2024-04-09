within CCC_test.StanfordHybrid;
model ArisRoomModel_1Room_04052024
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/BERG_Envelope_HMB_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/Half_Moon_Bay.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/Half_Moon_Bay.mos"))
    annotation (Placement(transformation(extent={{118,90},{138,110}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{236,172},{256,192}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm(
    redeclare package Medium = MediumAir,
    p=101300,
    nPorts=1)   "Boundary condition"
    annotation (Placement(transformation(extent={{170,52},{190,72}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="BERG Thermal Zone",
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
  Modelica.Blocks.Interfaces.RealOutput TOut
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={142,210})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTAir2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={296,210})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{84,74},{104,94}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{514,78},{534,98}})));
equation
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
  connect(ducCor.port_b, pAtm.ports[1]) annotation (Line(points={{306,-26},{196,
          -26},{196,62},{190,62}},     color={0,127,255}));
  connect(freshAirCor.ports[1], cor.ports[2]) annotation (Line(points={{324,-82},
          {334,-82},{334,8},{321.5,8},{321.5,14.9}},
                                                 color={0,127,255}));
  connect(building.weaBus, freshAirCor.weaBus) annotation (Line(
      points={{138,100},{290,100},{290,-81.8},{304,-81.8}},
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
  connect(cor.TAir, ZoneTAir2) annotation (Line(points={{343,52},{348,52},{348,
          192},{296,192},{296,210}},
                         color={0,0,127}));
  connect(port_a2, cor.ports[3]) annotation (Line(points={{94,84},{118,84},{118,
          76},{322.5,76},{322.5,14.9}}, color={0,127,255}));
  connect(port_b2, cor.ports[4]) annotation (Line(points={{524,88},{432,88},{
          432,84},{323.5,84},{323.5,14.9}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,200}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,200}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisRoomModel_1Room_04052024;
