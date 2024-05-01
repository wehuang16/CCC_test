within CCC_test.obsolete_eas_e;
model ArisRoomModel_8apartments_NoInfiltration_NewYork_v2_04302024
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/Data/energyPlusFiles/400_3rd_Street_v2.2_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC/Resources/weatherdata/USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.mos"))
    annotation (Placement(transformation(extent={{270,88},{290,108}})));

  Modelica.Blocks.Sources.Constant HeatGain_LBed1[3](each k=0)
    annotation (Placement(transformation(extent={{130,-56},{150,-36}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB1(
    zoneName="Level1:1LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=4)
    annotation (Placement(transformation(extent={{190,-62},{230,-22}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv1(
    zoneName="Level1:1LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=4) annotation (Placement(transformation(extent={{206,80},{246,120}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{296,140},{316,160}}),
        iconTransformation(extent={{286,104},{306,124}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA1(
    zoneName="Level1:1LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=4)
    annotation (Placement(transformation(extent={{186,14},{226,54}})));
  Modelica.Blocks.Interfaces.RealOutput TOut[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={312,1008})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_BedA[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-26}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,342})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_Liv[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,654})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_BedB[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-96}), iconTransformation(
        extent={{-11,11},{11,-11}},
        rotation=180,
        origin={85,-35})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Liv[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{76,828},{106,856}}),
        iconTransformation(extent={{76,828},{106,856}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Liv[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{78,722},{98,742}}),
        iconTransformation(extent={{78,722},{98,742}})));
  Modelica.Blocks.Interfaces.RealOutput RelHum[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={316,-112})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_Liv[8] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={86,934}), iconTransformation(extent={{76,924},{96,944}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv1(each k=0)
    annotation (Placement(transformation(extent={{130,84},{150,104}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv1(each k=0)
    annotation (Placement(transformation(extent={{136,36},{156,56}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_BedA[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{80,-2},{110,26}}),
        iconTransformation(extent={{74,536},{104,564}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_BedB[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{70,214},{100,242}}),
        iconTransformation(extent={{70,214},{100,242}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_BedA[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{84,430},{104,450}}),
        iconTransformation(extent={{84,430},{104,450}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_BedB[8](redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{78,96},{98,116}}),
        iconTransformation(extent={{78,96},{98,116}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed1[3](each k=0)
    annotation (Placement(transformation(extent={{376,-92},{396,-72}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB1(
    zoneName="Level1:1RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{438,-74},{478,-34}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv1(
    zoneName="Level1:1RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2) annotation (Placement(transformation(extent={{454,68},{494,108}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA1(
    zoneName="Level1:1RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{434,2},{474,42}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv1(each k=0)
    annotation (Placement(transformation(extent={{360,66},{380,86}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv1(each k=0)
    annotation (Placement(transformation(extent={{362,22},{382,42}})));
  Modelica.Blocks.Sources.Constant HeatGain_LBed2[3](each k=0)
    annotation (Placement(transformation(extent={{128,194},{148,214}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB2(
    zoneName="Level2:2LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{188,188},{228,228}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv2(
    zoneName="Level2:2LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{204,330},{244,370}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA2(
    zoneName="Level2:2LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{184,264},{224,304}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv2(each k=0)
    annotation (Placement(transformation(extent={{126,334},{146,354}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv2(each k=0)
    annotation (Placement(transformation(extent={{134,286},{154,306}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed2[3](each k=0)
    annotation (Placement(transformation(extent={{380,162},{400,182}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB2(
    zoneName="Level2:2RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{452,158},{492,198}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv2(
    zoneName="Level2:2RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{468,300},{508,340}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA2(
    zoneName="Level2:2RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{448,234},{488,274}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv2(each k=0)
    annotation (Placement(transformation(extent={{364,320},{384,340}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv2(each k=0)
    annotation (Placement(transformation(extent={{366,276},{386,296}})));
  Modelica.Blocks.Sources.Constant HeatGain_LBed3[3](each k=0)
    annotation (Placement(transformation(extent={{130,456},{150,476}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB3(
    zoneName="Level3:3LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{202,456},{242,496}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv3(
    zoneName="Level3:3LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{214,598},{254,638}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA3(
    zoneName="Level3:3LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{196,532},{236,572}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv3(each k=0)
    annotation (Placement(transformation(extent={{128,596},{148,616}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv3(each k=0)
    annotation (Placement(transformation(extent={{136,548},{156,568}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed3[3](each k=0)
    annotation (Placement(transformation(extent={{372,420},{392,440}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB3(
    zoneName="Level3:3RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{444,416},{484,456}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv3(
    zoneName="Level3:3RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{460,558},{500,598}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA3(
    zoneName="Level3:3RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{440,492},{480,532}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv3(each k=0)
    annotation (Placement(transformation(extent={{356,578},{376,598}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv3(each k=0)
    annotation (Placement(transformation(extent={{358,534},{378,554}})));
  Modelica.Blocks.Sources.Constant HeatGain_LBed4[3](each k=0)
    annotation (Placement(transformation(extent={{128,728},{148,748}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB4(
    zoneName="Level4:4LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{204,744},{244,784}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv4(
    zoneName="Level4:4LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{220,886},{260,926}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA4(
    zoneName="Level4:4LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{200,820},{240,860}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv4(each k=0)
    annotation (Placement(transformation(extent={{126,868},{146,888}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv4(each k=0)
    annotation (Placement(transformation(extent={{134,820},{154,840}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed4[3](each k=0)
    annotation (Placement(transformation(extent={{378,696},{398,716}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB4(
    zoneName="Level4:4RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{442,706},{482,746}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv4(
    zoneName="Level4:4RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{458,848},{498,888}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA4(
    zoneName="Level4:4RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{438,782},{478,822}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv4(each k=0)
    annotation (Placement(transformation(extent={{362,852},{382,872}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv4(each k=0)
    annotation (Placement(transformation(extent={{364,808},{384,828}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=8) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={314,940})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=8) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={332,2})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Stairs1(
    zoneName="Level4:Stairs",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{646,958},{686,998}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Basement(
    zoneName="Basement:Basement",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{652,730},{692,770}})));
  Modelica.Blocks.Sources.Constant HeatGain_OtherZones[3](each k=0)
    annotation (Placement(transformation(extent={{580,734},{600,754}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm_Liv(redeclare package Medium =
        MediumAir, nPorts=8) "Boundary condition"
    annotation (Placement(transformation(extent={{-76,144},{-56,164}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc_Liv[8](
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    m_flow_nominal=0.005,
    linearized=true,
    from_dp=true,
    dp_nominal=100) "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-10,146},{-30,166}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir_Liv[8](
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-56,104},{-36,124}})));
  CCC.Controls.DesignInfiltration designInfiltration_Liv[8]
    annotation (Placement(transformation(extent={{-122,112},{-102,132}})));
  CCC.Controls.DesignInfiltration designInfiltration_BedA[8]
    annotation (Placement(transformation(extent={{-138,20},{-118,40}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm_BedA(redeclare package Medium =
        MediumAir, nPorts=8) "Boundary condition"
    annotation (Placement(transformation(extent={{-92,52},{-72,72}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc_BedA[8](
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    m_flow_nominal=0.005,
    linearized=true,
    from_dp=true,
    dp_nominal=100) "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-26,54},{-46,74}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir_BedA[8](
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-72,12},{-52,32}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAir_BedB[8](
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-78,-92},{-58,-72}})));
  CCC.Controls.DesignInfiltration designInfiltration_BedB[8]
    annotation (Placement(transformation(extent={{-144,-84},{-124,-64}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm_BedB(redeclare package Medium =
        MediumAir, nPorts=8) "Boundary condition"
    annotation (Placement(transformation(extent={{-98,-52},{-78,-32}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc_BedB[8](
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    m_flow_nominal=0.005,
    linearized=true,
    from_dp=true,
    dp_nominal=100) "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-32,-50},{-52,-30}})));
equation
  connect(HeatGain_LBed1.y, LBedB1.qGai_flow) annotation (Line(points={{151,-46},
          {188,-46},{188,-32}},           color={0,0,127}));
  connect(building.weaBus,weaBus)  annotation (Line(
      points={{290,98},{306,98},{306,150}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(HeatGain_LBed1.y, LBedA1.qGai_flow) annotation (Line(points={{151,-46},
          {151,-48},{184,-48},{184,44}},                    color={0,0,127}));
  connect(RadiantGain_LLiv1.y, LLiv1.qGai_flow[1]) annotation (Line(points={{151,94},
          {164,94},{164,109.333},{204,109.333}},     color={0,0,127}));
  connect(LatentGain_LLiv1.y, LLiv1.qGai_flow[3]) annotation (Line(points={{157,46},
          {164,46},{164,110.667},{204,110.667}},     color={0,0,127}));
  connect(port_a_Liv[1], LLiv1.ports[1]) annotation (Line(points={{84.4375,842},
          {116,842},{116,588},{264,588},{264,72},{224.5,72},{224.5,80.9}},
                                         color={0,127,255}));
  connect(port_b_Liv[1], LLiv1.ports[2]) annotation (Line(points={{88,727.625},{
          116,727.625},{116,588},{264,588},{264,80.9},{225.5,80.9}},
                                         color={0,127,255}));
  connect(port_a_BedA[1], LBedA1.ports[1]) annotation (Line(points={{88.4375,12},
          {176,12},{176,14.9},{204.5,14.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[1], LBedA1.ports[2]) annotation (Line(points={{94,435.625},
          {176,435.625},{176,14.9},{205.5,14.9}},     color={0,127,255}));
  connect(port_a_BedB[1], LBedB1.ports[1]) annotation (Line(points={{78.4375,228},
          {56,228},{56,-44},{124,-44},{124,-64},{180,-64},{180,-61.1},{208.5,-61.1}},
                                   color={0,127,255}));
  connect(port_b_BedB[1], LBedB1.ports[2]) annotation (Line(points={{88,101.625},
          {56,101.625},{56,-44},{124,-44},{124,-64},{180,-64},{180,-61.1},{209.5,
          -61.1}},                                              color={0,127,255}));
  connect(HeatGain_RBed1.y, RBedB1.qGai_flow) annotation (Line(points={{397,-82},
          {397,-84},{400,-84},{400,-44},{436,-44}},
                                          color={0,0,127}));
  connect(HeatGain_RBed1.y, RBedA1.qGai_flow) annotation (Line(points={{397,-82},
          {397,-84},{400,-84},{400,-44},{424,-44},{424,32},{432,32}},
                                        color={0,0,127}));
  connect(RadiantGain_RLiv1.y, RLiv1.qGai_flow[1]) annotation (Line(points={{381,76},
          {420,76},{420,97.3333},{452,97.3333}},         color={0,0,127}));
  connect(LatentGain_RLiv1.y, RLiv1.qGai_flow[3]) annotation (Line(points={{383,32},
          {388,32},{388,44},{400,44},{400,76},{420,76},{420,98.6667},{452,
          98.6667}},                                                   color={0,
          0,127}));
  connect(HeatGain_LBed2.y, LBedB2.qGai_flow) annotation (Line(points={{149,204},
          {172,204},{172,218},{186,218}}, color={0,0,127}));
  connect(HeatGain_LBed2.y, LBedA2.qGai_flow) annotation (Line(points={{149,204},
          {172,204},{172,294},{182,294}}, color={0,0,127}));
  connect(RadiantGain_LLiv2.y, LLiv2.qGai_flow[1]) annotation (Line(points={{147,344},
          {184,344},{184,359.333},{202,359.333}},          color={0,0,127}));
  connect(LatentGain_LLiv2.y, LLiv2.qGai_flow[3]) annotation (Line(points={{155,296},
          {168,296},{168,344},{184,344},{184,360.667},{202,360.667}},
                                                       color={0,0,127}));
  connect(HeatGain_RBed2.y, RBedB2.qGai_flow) annotation (Line(points={{401,172},
          {408,172},{408,188},{450,188}}, color={0,0,127}));
  connect(HeatGain_RBed2.y, RBedA2.qGai_flow) annotation (Line(points={{401,172},
          {408,172},{408,188},{440,188},{440,224},{446,224},{446,264}},
                                                              color={0,0,127}));
  connect(RadiantGain_RLiv2.y, RLiv2.qGai_flow[1]) annotation (Line(points={{385,330},
          {385,336},{424,336},{424,329.333},{466,329.333}},    color={0,0,127}));
  connect(LatentGain_RLiv2.y, RLiv2.qGai_flow[3]) annotation (Line(points={{387,286},
          {448,286},{448,330.667},{466,330.667}},      color={0,0,127}));
  connect(HeatGain_LBed3.y, LBedB3.qGai_flow) annotation (Line(points={{151,466},
          {172,466},{172,486},{200,486}}, color={0,0,127}));
  connect(HeatGain_LBed3.y, LBedA3.qGai_flow) annotation (Line(points={{151,466},
          {172,466},{172,562},{194,562}}, color={0,0,127}));
  connect(RadiantGain_LLiv3.y, LLiv3.qGai_flow[1]) annotation (Line(points={{149,606},
          {188,606},{188,627.333},{212,627.333}},          color={0,0,127}));
  connect(LatentGain_LLiv3.y, LLiv3.qGai_flow[3]) annotation (Line(points={{157,558},
          {168,558},{168,608},{188,608},{188,628.667},{212,628.667}},
                                                       color={0,0,127}));
  connect(HeatGain_RBed3.y, RBedB3.qGai_flow) annotation (Line(points={{393,430},
          {400,430},{400,446},{442,446}}, color={0,0,127}));
  connect(HeatGain_RBed3.y, RBedA3.qGai_flow) annotation (Line(points={{393,430},
          {400,430},{400,448},{432,448},{432,480},{438,480},{438,522}},
                                                              color={0,0,127}));
  connect(RadiantGain_RLiv3.y, RLiv3.qGai_flow[1]) annotation (Line(points={{377,588},
          {377,572},{396,572},{396,587.333},{458,587.333}},
                                                 color={0,0,127}));
  connect(LatentGain_RLiv3.y, RLiv3.qGai_flow[3]) annotation (Line(points={{379,544},
          {440,544},{440,588.667},{458,588.667}},      color={0,0,127}));
  connect(HeatGain_LBed4.y, LBedB4.qGai_flow) annotation (Line(points={{149,738},
          {172,738},{172,774},{202,774}}, color={0,0,127}));
  connect(HeatGain_LBed4.y, LBedA4.qGai_flow) annotation (Line(points={{149,738},
          {172,738},{172,850},{198,850}}, color={0,0,127}));
  connect(RadiantGain_LLiv4.y, LLiv4.qGai_flow[1]) annotation (Line(points={{147,878},
          {168,878},{168,832},{196,832},{196,915.333},{218,915.333}},
                                                           color={0,0,127}));
  connect(LatentGain_LLiv4.y, LLiv4.qGai_flow[3]) annotation (Line(points={{155,830},
          {196,830},{196,916.667},{218,916.667}},      color={0,0,127}));
  connect(HeatGain_RBed4.y, RBedB4.qGai_flow) annotation (Line(points={{399,706},
          {432,706},{432,736},{440,736}}, color={0,0,127}));
  connect(HeatGain_RBed4.y, RBedA4.qGai_flow) annotation (Line(points={{399,706},
          {432,706},{432,772},{428,772},{428,812},{436,812}},
                                                    color={0,0,127}));
  connect(RadiantGain_RLiv4.y, RLiv4.qGai_flow[1]) annotation (Line(points={{383,862},
          {420,862},{420,877.333},{456,877.333}},              color={0,0,127}));
  connect(LatentGain_RLiv4.y, RLiv4.qGai_flow[3]) annotation (Line(points={{385,818},
          {385,844},{440,844},{440,878.667},{456,878.667}},
                                                       color={0,0,127}));
  connect(SensibleGain_Liv[1], LLiv1.qGai_flow[2]) annotation (Line(points={{86,
          929.625},{292,929.625},{292,332},{356,332},{356,312},{440,312},{440,
          148},{444,148},{444,136},{188,136},{188,110},{204,110}},     color={0,
          0,127}));
  connect(LLiv1.TAir, ZoneTemp_Liv[1]) annotation (Line(points={{247,118},{252,
          118},{252,76},{90,76},{90,35.625}},
                                         color={0,0,127}));
  connect(LBedA1.TAir, ZoneTemp_BedA[1]) annotation (Line(points={{227,52},{232,
          52},{232,-20},{176,-20},{176,-30.375},{90,-30.375}},
                                           color={0,0,127}));
  connect(LBedB1.TAir, ZoneTemp_BedB[1]) annotation (Line(points={{231,-24},{
          244,-24},{244,-100.375},{90,-100.375}},
                                              color={0,0,127}));

  connect(port_a_Liv[2], LLiv2.ports[1]) annotation (Line(points={{86.3125,842},
          {116,842},{116,588},{264,588},{264,324},{240,324},{240,330.9},{223,
          330.9}},                       color={0,127,255}));
  connect(port_b_Liv[2], LLiv2.ports[2]) annotation (Line(points={{88,728.875},
          {116,728.875},{116,588},{264,588},{264,324},{240,324},{240,330.9},{
          225,330.9}},                   color={0,127,255}));
  connect(port_a_BedA[2], LBedA2.ports[1]) annotation (Line(points={{90.3125,12},
          {176,12},{176,264.9},{203,264.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[2], LBedA2.ports[2]) annotation (Line(points={{94,436.875},
          {176,436.875},{176,264.9},{205,264.9}},     color={0,127,255}));
  connect(port_a_BedB[2], LBedB2.ports[1]) annotation (Line(points={{80.3125,
          228},{120,228},{120,188.9},{207,188.9}},
                                   color={0,127,255}));
  connect(port_b_BedB[2], LBedB2.ports[2]) annotation (Line(points={{88,102.875},
          {88,184},{172,184},{172,188.9},{209,188.9}},          color={0,127,255}));
  connect(SensibleGain_Liv[2], LLiv2.qGai_flow[2]) annotation (Line(points={{86,
          930.875},{292,930.875},{292,376},{192,376},{192,360},{202,360}},
                                                                       color={0,
          0,127}));
  connect(LLiv2.TAir, ZoneTemp_Liv[2]) annotation (Line(points={{245,368},{245,
          372},{252,372},{252,76},{90,76},{90,36.875}},
                                         color={0,0,127}));
  connect(LBedA2.TAir, ZoneTemp_BedA[2]) annotation (Line(points={{225,302},{
          228,302},{228,232},{112,232},{112,256},{60,256},{60,-29.125},{90,
          -29.125}},                       color={0,0,127}));
  connect(LBedB2.TAir, ZoneTemp_BedB[2]) annotation (Line(points={{229,226},{
          252,226},{252,-56},{248,-56},{248,-99.125},{90,-99.125}},
                                              color={0,0,127}));

  connect(port_a_Liv[3], LLiv3.ports[1]) annotation (Line(points={{88.1875,842},
          {116,842},{116,588},{200,588},{200,598.9},{233,598.9}},
                                         color={0,127,255}));
  connect(port_b_Liv[3], LLiv3.ports[2]) annotation (Line(points={{88,730.125},
          {116,730.125},{116,588},{200,588},{200,598.9},{235,598.9}},
                                         color={0,127,255}));
  connect(port_a_BedA[3], LBedA3.ports[1]) annotation (Line(points={{92.1875,12},
          {176,12},{176,444},{180,444},{180,532.9},{215,532.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[3], LBedA3.ports[2]) annotation (Line(points={{94,438.125},
          {176,438.125},{176,444},{180,444},{180,532.9},{217,532.9}},
                                                      color={0,127,255}));
  connect(port_a_BedB[3], LBedB3.ports[1]) annotation (Line(points={{82.1875,
          228},{312,228},{312,480},{248,480},{248,456.9},{221,456.9}},
                                   color={0,127,255}));
  connect(port_b_BedB[3], LBedB3.ports[2]) annotation (Line(points={{88,104.125},
          {88,204},{112,204},{112,228},{312,228},{312,480},{248,480},{248,456.9},
          {223,456.9}},                                         color={0,127,255}));
  connect(SensibleGain_Liv[3], LLiv3.qGai_flow[2]) annotation (Line(points={{86,
          932.125},{292,932.125},{292,644},{200,644},{200,628},{212,628}},
                                                                       color={0,
          0,127}));
  connect(LLiv3.TAir, ZoneTemp_Liv[3]) annotation (Line(points={{255,636},{264,
          636},{264,604},{260,604},{260,32},{90,32},{90,38.125}},
                                         color={0,0,127}));
  connect(LBedA3.TAir, ZoneTemp_BedA[3]) annotation (Line(points={{237,570},{
          237,576},{60,576},{60,-27.875},{90,-27.875}},
                                           color={0,0,127}));
  connect(LBedB3.TAir, ZoneTemp_BedB[3]) annotation (Line(points={{243,494},{
          256,494},{256,-92},{248,-92},{248,-97.875},{90,-97.875}},
                                              color={0,0,127}));

  connect(port_a_Liv[4], LLiv4.ports[1]) annotation (Line(points={{90.0625,842},
          {116,842},{116,812},{252,812},{252,886.9},{239,886.9}},
                                         color={0,127,255}));
  connect(port_b_Liv[4], LLiv4.ports[2]) annotation (Line(points={{88,731.375},
          {88,816},{128,816},{128,812},{252,812},{252,886.9},{241,886.9}},
                                         color={0,127,255}));
  connect(port_a_BedA[4], LBedA4.ports[1]) annotation (Line(points={{94.0625,12},
          {176,12},{176,444},{180,444},{180,820.9},{219,820.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[4], LBedA4.ports[2]) annotation (Line(points={{94,439.375},
          {180,439.375},{180,820.9},{221,820.9}},     color={0,127,255}));
  connect(port_a_BedB[4], LBedB4.ports[1]) annotation (Line(points={{84.0625,
          228},{312,228},{312,656},{223,656},{223,744.9}},
                                   color={0,127,255}));
  connect(port_b_BedB[4], LBedB4.ports[2]) annotation (Line(points={{88,105.375},
          {88,204},{112,204},{112,228},{312,228},{312,656},{225,656},{225,744.9}},
                                                                color={0,127,255}));
  connect(SensibleGain_Liv[4], LLiv4.qGai_flow[2]) annotation (Line(points={{86,
          933.375},{208,933.375},{208,916},{218,916}},                 color={0,
          0,127}));
  connect(LLiv4.TAir, ZoneTemp_Liv[4]) annotation (Line(points={{261,924},{264,
          924},{264,604},{260,604},{260,32},{90,32},{90,39.375}},
                                         color={0,0,127}));
  connect(LBedA4.TAir, ZoneTemp_BedA[4]) annotation (Line(points={{241,858},{
          241,864},{172,864},{172,900},{60,900},{60,-26.625},{90,-26.625}},
                                           color={0,0,127}));
  connect(LBedB4.TAir, ZoneTemp_BedB[4]) annotation (Line(points={{245,782},{
          268,782},{268,-96.625},{90,-96.625}},
                                              color={0,0,127}));

  connect(port_a_Liv[5], RLiv1.ports[1]) annotation (Line(points={{91.9375,842},
          {116,842},{116,276},{356,276},{356,304},{456,304},{456,300},{476,300},
          {476,288},{512,288},{512,68.9},{473,68.9}},
                                         color={0,127,255}));
  connect(port_b_Liv[5], RLiv1.ports[2]) annotation (Line(points={{88,732.625},
          {116,732.625},{116,276},{356,276},{356,304},{444,304},{444,180},{448,
          180},{448,120},{444,120},{444,56},{475,56},{475,68.9}},
                                         color={0,127,255}));
  connect(port_a_BedA[5], RBedA1.ports[1]) annotation (Line(points={{95.9375,12},
          {180,12},{180,28},{352,28},{352,2.9},{453,2.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[5], RBedA1.ports[2]) annotation (Line(points={{94,440.625},
          {176,440.625},{176,28},{352,28},{352,2.9},{455,2.9}},
                                                      color={0,127,255}));
  connect(port_a_BedB[5], RBedB1.ports[1]) annotation (Line(points={{85.9375,
          228},{312,228},{312,168},{368,168},{368,156},{440,156},{440,56},{488,
          56},{488,-36},{492,-36},{492,-88},{457,-88},{457,-73.1}},
                                   color={0,127,255}));
  connect(port_b_BedB[5], RBedB1.ports[2]) annotation (Line(points={{88,106.625},
          {88,204},{112,204},{112,228},{312,228},{312,168},{368,168},{368,156},
          {440,156},{440,56},{488,56},{488,-36},{492,-36},{492,-88},{459,-88},{
          459,-73.1}},                                          color={0,127,255}));
  connect(SensibleGain_Liv[5], RLiv1.qGai_flow[2]) annotation (Line(points={{86,
          934.625},{292,934.625},{292,332},{356,332},{356,312},{440,312},{440,
          148},{444,148},{444,98},{452,98}},                           color={0,
          0,127}));
  connect(RLiv1.TAir, ZoneTemp_Liv[5]) annotation (Line(points={{495,106},{495,
          112},{312,112},{312,132},{260,132},{260,32},{90,32},{90,40.625}},
                                         color={0,0,127}));
  connect(RBedA1.TAir, ZoneTemp_BedA[5]) annotation (Line(points={{475,40},{480,
          40},{480,-32},{240,-32},{240,-25.375},{90,-25.375}},
                                           color={0,0,127}));
  connect(RBedB1.TAir, ZoneTemp_BedB[5]) annotation (Line(points={{479,-36},{
          496,-36},{496,-136},{244,-136},{244,-95.375},{90,-95.375}},
                                              color={0,0,127}));

  connect(port_a_Liv[6], RLiv2.ports[1]) annotation (Line(points={{93.8125,842},
          {116,842},{116,276},{356,276},{356,304},{456,304},{456,300.9},{487,
          300.9}},                       color={0,127,255}));
  connect(port_b_Liv[6], RLiv2.ports[2]) annotation (Line(points={{88,733.875},
          {116,733.875},{116,276},{356,276},{356,304},{456,304},{456,300.9},{
          489,300.9}},                   color={0,127,255}));
  connect(port_a_BedA[6], RBedA2.ports[1]) annotation (Line(points={{97.8125,12},
          {180,12},{180,220},{467,220},{467,234.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[6], RBedA2.ports[2]) annotation (Line(points={{94,441.875},
          {176,441.875},{176,232},{180,232},{180,220},{469,220},{469,234.9}},
                                                      color={0,127,255}));
  connect(port_a_BedB[6], RBedB2.ports[1]) annotation (Line(points={{87.8125,
          228},{312,228},{312,168},{368,168},{368,156},{440,156},{440,158.9},{
          471,158.9}},             color={0,127,255}));
  connect(port_b_BedB[6], RBedB2.ports[2]) annotation (Line(points={{88,107.875},
          {88,204},{112,204},{112,228},{312,228},{312,168},{368,168},{368,156},
          {440,156},{440,158.9},{473,158.9}},                   color={0,127,255}));
  connect(SensibleGain_Liv[6], RLiv2.qGai_flow[2]) annotation (Line(points={{86,
          935.875},{292,935.875},{292,332},{356,332},{356,312},{448,312},{448,
          330},{466,330}},                                             color={0,
          0,127}));
  connect(RLiv2.TAir, ZoneTemp_Liv[6]) annotation (Line(points={{509,338},{512,
          338},{512,296},{436,296},{436,132},{260,132},{260,32},{90,32},{90,
          41.875}},                      color={0,0,127}));
  connect(RBedA2.TAir, ZoneTemp_BedA[6]) annotation (Line(points={{489,272},{
          492,272},{492,232},{264,232},{264,20},{240,20},{240,-24.125},{90,
          -24.125}},                       color={0,0,127}));
  connect(RBedB2.TAir, ZoneTemp_BedB[6]) annotation (Line(points={{493,196},{
          504,196},{504,-32},{244,-32},{244,-84},{248,-84},{248,-94.125},{90,
          -94.125}},                          color={0,0,127}));

  connect(port_a_Liv[7], RLiv3.ports[1]) annotation (Line(points={{95.6875,842},
          {116,842},{116,812},{312,812},{312,840},{448,840},{448,836},{516,836},
          {516,558.9},{479,558.9}},      color={0,127,255}));
  connect(port_b_Liv[7], RLiv3.ports[2]) annotation (Line(points={{88,735.125},
          {114,735.125},{114,540},{346,540},{346,564},{442,564},{442,548},{481,
          548},{481,558.9}},             color={0,127,255}));
  connect(port_a_BedA[7], RBedA3.ports[1]) annotation (Line(points={{99.6875,12},
          {176,12},{176,444},{180,444},{180,492.9},{459,492.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[7], RBedA3.ports[2]) annotation (Line(points={{94,443.125},
          {176,443.125},{176,444},{180,444},{180,492.9},{461,492.9}},
                                                      color={0,127,255}));
  connect(port_a_BedB[7], RBedB3.ports[1]) annotation (Line(points={{89.6875,
          228},{312,228},{312,408},{432,408},{432,416.9},{463,416.9}},
                                   color={0,127,255}));
  connect(port_b_BedB[7], RBedB3.ports[2]) annotation (Line(points={{88,109.125},
          {88,204},{112,204},{112,228},{312,228},{312,408},{432,408},{432,416.9},
          {465,416.9}},                                         color={0,127,255}));
  connect(SensibleGain_Liv[7], RLiv3.qGai_flow[2]) annotation (Line(points={{86,
          937.125},{292,937.125},{292,588},{348,588},{348,572},{396,572},{396,
          588},{458,588}},                                             color={0,
          0,127}));
  connect(RLiv3.TAir, ZoneTemp_Liv[7]) annotation (Line(points={{501,596},{504,
          596},{504,476},{260,476},{260,32},{90,32},{90,43.125}},
                                         color={0,0,127}));
  connect(RBedA3.TAir, ZoneTemp_BedA[7]) annotation (Line(points={{481,530},{
          484,530},{484,488},{60,488},{60,-22.875},{90,-22.875}},
                                           color={0,0,127}));
  connect(RBedB3.TAir, ZoneTemp_BedB[7]) annotation (Line(points={{485,454},{
          252,454},{252,-56},{248,-56},{248,-92.875},{90,-92.875}},
                                              color={0,0,127}));

  connect(port_a_Liv[8], RLiv4.ports[1]) annotation (Line(points={{97.5625,842},
          {116,842},{116,812},{312,812},{312,840},{448,840},{448,848.9},{477,
          848.9}},                       color={0,127,255}));
  connect(port_b_Liv[8], RLiv4.ports[2]) annotation (Line(points={{88,736.375},
          {88,816},{128,816},{128,812},{312,812},{312,840},{448,840},{448,848.9},
          {479,848.9}},                  color={0,127,255}));
  connect(port_a_BedA[8], RBedA4.ports[1]) annotation (Line(points={{101.562,12},
          {180,12},{180,756},{436,756},{436,772},{457,772},{457,782.9}},
                                    color={0,127,255}));
  connect(port_b_BedA[8], RBedA4.ports[2]) annotation (Line(points={{94,444.375},
          {180,444.375},{180,756},{436,756},{436,772},{459,772},{459,782.9}},
                                                      color={0,127,255}));
  connect(port_a_BedB[8], RBedB4.ports[1]) annotation (Line(points={{91.5625,
          228},{312,228},{312,612},{500,612},{500,706.9},{461,706.9}},
                                   color={0,127,255}));
  connect(port_b_BedB[8], RBedB4.ports[2]) annotation (Line(points={{88,110.375},
          {88,204},{112,204},{112,228},{312,228},{312,612},{463,612},{463,706.9}},
                                                                color={0,127,255}));
  connect(SensibleGain_Liv[8], RLiv4.qGai_flow[2]) annotation (Line(points={{86,
          938.375},{292,938.375},{292,878},{456,878}},                 color={0,
          0,127}));
  connect(RLiv4.TAir, ZoneTemp_Liv[8]) annotation (Line(points={{499,886},{499,
          900},{260,900},{260,32},{90,32},{90,44.375}},
                                         color={0,0,127}));
  connect(RBedA4.TAir, ZoneTemp_BedA[8]) annotation (Line(points={{479,820},{
          508,820},{508,-21.625},{90,-21.625}},
                                           color={0,0,127}));
  connect(RBedB4.TAir, ZoneTemp_BedB[8]) annotation (Line(points={{483,744},{
          248,744},{248,-91.625},{90,-91.625}},
                                              color={0,0,127}));

  connect(weaBus.TDryBul, replicator.u) annotation (Line(
      points={{306.05,150.05},{306.05,928},{314,928}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(replicator.y, TOut) annotation (Line(points={{314,951},{314,992},{312,
          992},{312,1008}}, color={0,0,127}));
  connect(weaBus.relHum, replicator1.u) annotation (Line(
      points={{306.05,150.05},{306.05,14},{332,14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(replicator1.y, RelHum) annotation (Line(points={{332,-9},{332,-96},{316,
          -96},{316,-112}}, color={0,0,127}));
  connect(HeatGain_OtherZones.y, Basement.qGai_flow) annotation (Line(points={{
          601,744},{640,744},{640,760},{650,760}}, color={0,0,127}));
  connect(HeatGain_OtherZones.y, Stairs1.qGai_flow) annotation (Line(points={{
          601,744},{640,744},{640,824},{636,824},{636,988},{644,988}}, color={0,
          0,127}));
  connect(designInfiltration_Liv.infFloRat, freshAir_Liv.m_flow_in)
    annotation (Line(points={{-100,122},{-56,122}}, color={0,0,127}));
  connect(pAtm_Liv.ports[1:8], duc_Liv.port_b) annotation (Line(points={{-56,155.75},
          {-43,155.75},{-43,156},{-30,156}}, color={0,127,255}));
  connect(weaBus, designInfiltration_Liv[1].weaBus) annotation (Line(
      points={{306,150},{0,150},{0,136},{-96,136},{-96,140},{-128,140},{-128,128},
          {-132,128},{-132,116.6},{-122.4,116.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, freshAir_Liv[1].weaBus) annotation (Line(
      points={{306,150},{0,150},{0,136},{-56,136},{-56,114.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(designInfiltration_Liv[1].zonAirTem, LLiv1.TAir) annotation (Line(
        points={{-124,126.2},{-136,126.2},{-136,96},{72,96},{72,80},{124,80},{124,
          76},{247,76},{247,118}}, color={0,0,127}));
  connect(freshAir_Liv[1].ports[1], LLiv1.ports[3]) annotation (Line(points={{-36,114},
          {52,114},{52,-16},{76,-16},{76,-8},{180,-8},{180,68},{226.5,68},{226.5,
          80.9}}, color={0,127,255}));
  connect(duc_Liv[1].port_a, LLiv1.ports[4]) annotation (Line(points={{-10,156},
          {56,156},{56,148},{52,148},{52,-16},{76,-16},{76,-8},{180,-8},{180,68},
          {227.5,68},{227.5,80.9}}, color={0,127,255}));
  connect(duc_BedA.port_b, pAtm_BedA.ports[1:8]) annotation (Line(points={{-46,64},
          {-62,64},{-62,62},{-72,62},{-72,63.75}}, color={0,127,255}));
  connect(duc_BedB.port_b, pAtm_BedB.ports[1:8]) annotation (Line(points={{-52,-40},
          {-65,-40},{-65,-40.25},{-78,-40.25}}, color={0,127,255}));
  connect(designInfiltration_BedA.infFloRat, freshAir_BedA.m_flow_in)
    annotation (Line(points={{-116,30},{-72,30}}, color={0,0,127}));
  connect(designInfiltration_BedB.infFloRat, freshAir_BedB.m_flow_in)
    annotation (Line(points={{-122,-74},{-78,-74}}, color={0,0,127}));
  connect(designInfiltration_BedA[1].zonAirTem, LBedA1.TAir) annotation (Line(
        points={{-140,34.2},{-138,34.2},{-138,80},{227,80},{227,52}}, color={0,0,
          127}));
  connect(designInfiltration_BedB[1].zonAirTem, LBedB1.TAir) annotation (Line(
        points={{-146,-69.8},{-140,-69.8},{-140,-8},{231,-8},{231,-24}}, color={
          0,0,127}));
  connect(freshAir_BedA.ports[1], LBedA1.ports[3]) annotation (Line(points={{-52,
          22},{80,22},{80,8},{206.5,8},{206.5,14.9}}, color={0,127,255}));
  connect(duc_BedA[1].port_a, LBedA1.ports[4]) annotation (Line(points={{-26,64},
          {176,64},{176,14.9},{207.5,14.9}}, color={0,127,255}));
  connect(freshAir_BedB.ports[1], LBedB1.ports[3]) annotation (Line(points={{-58,
          -82},{74,-82},{74,-78},{210.5,-78},{210.5,-61.1}}, color={0,127,255}));
  connect(duc_BedB[1].port_a, LBedB1.ports[4]) annotation (Line(points={{-32,-40},
          {56,-40},{56,-44},{124,-44},{124,-64},{180,-64},{180,-61.1},{211.5,-61.1}},
        color={0,127,255}));
  connect(weaBus, designInfiltration_BedA[1].weaBus) annotation (Line(
      points={{306,150},{0,150},{0,136},{-96,136},{-96,140},{-128,140},{-128,132},
          {-152,132},{-152,24.6},{-138.4,24.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, freshAir_BedA[1].weaBus) annotation (Line(
      points={{306,150},{0,150},{0,136},{-96,136},{-96,140},{-128,140},{-128,132},
          {-152,132},{-152,12},{-84,12},{-84,22.2},{-72,22.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, designInfiltration_BedB[1].weaBus) annotation (Line(
      points={{306,150},{0,150},{0,136},{-96,136},{-96,140},{-128,140},{-128,132},
          {-152,132},{-152,-60},{-156,-60},{-156,-79.4},{-144.4,-79.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, freshAir_BedB[1].weaBus) annotation (Line(
      points={{306,150},{0,150},{0,136},{-96,136},{-96,140},{-128,140},{-128,132},
          {-152,132},{-152,-60},{-156,-60},{-156,-92},{-92,-92},{-92,-81.8},{-78,
          -81.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,1000}})),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,
            1000}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisRoomModel_8apartments_NoInfiltration_NewYork_v2_04302024;
