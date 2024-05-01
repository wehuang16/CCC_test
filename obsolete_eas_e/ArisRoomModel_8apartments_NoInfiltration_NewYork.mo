within CCC_test.obsolete_eas_e;
model ArisRoomModel_8apartments_NoInfiltration_NewYork
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/Data/energyPlusFiles/400_3rd_Street_v2.2_V960.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_NY_New.York-Downtown.Manhattan.Heli.720553_TMYx.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_NY_New.York-Downtown.Manhattan.Heli.720553_TMYx.mos"))
    annotation (Placement(transformation(extent={{270,88},{290,108}})));

  Modelica.Blocks.Sources.Constant HeatGain_LBed1[3](each k=0)
    annotation (Placement(transformation(extent={{130,-56},{150,-36}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB1(
    zoneName="Level1:1LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{192,-94},{232,-54}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv1(
    zoneName="Level1:1LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2) annotation (Placement(transformation(extent={{208,48},{248,88}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{296,140},{316,160}}),
        iconTransformation(extent={{286,104},{306,124}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA1(
    zoneName="Level1:1LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{188,-18},{228,22}})));
  Modelica.Blocks.Interfaces.RealOutput TOut
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={312,1008})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedA1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-26})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LLiv1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,48})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedB1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-96})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LLiv1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{74,82},{104,
            110}}), iconTransformation(extent={{74,82},{104,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LLiv1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{82,60},{102,80}}),
        iconTransformation(extent={{82,60},{102,80}})));
  Modelica.Blocks.Interfaces.RealOutput RelHum annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={316,-112})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_LLiv1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={92,112}), iconTransformation(extent={{80,110},{100,130}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv1(each k=0)
    annotation (Placement(transformation(extent={{128,84},{148,104}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv1(each k=0)
    annotation (Placement(transformation(extent={{136,36},{156,56}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedA1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{80,-2},{110,26}}),
        iconTransformation(extent={{82,4},{112,32}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedB1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{80,-68},{110,
            -40}}), iconTransformation(extent={{80,-68},{110,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedA1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{86,-16},{106,4}}),
        iconTransformation(extent={{86,-16},{106,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedB1(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{86,-88},{106,-68}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed1[3](each k=0)
    annotation (Placement(transformation(extent={{376,-92},{396,-72}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB1(
    zoneName="Level1:1RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{414,-94},{454,-54}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv1(
    zoneName="Level1:1RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2) annotation (Placement(transformation(extent={{430,48},{470,88}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA1(
    zoneName="Level1:1RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{410,-18},{450,22}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv1(each k=0)
    annotation (Placement(transformation(extent={{360,66},{380,86}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv1(each k=0)
    annotation (Placement(transformation(extent={{362,22},{382,42}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedA1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={522,-26}), iconTransformation(extent={{522,-34},{542,-14}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RLiv1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={522,40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={530,48})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedB1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={522,-96}), iconTransformation(extent={{520,-112},{540,-92}},
          rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RLiv1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{506,82},{536,
            110}}), iconTransformation(extent={{516,80},{546,108}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RLiv1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{514,60},{534,
            80}}), iconTransformation(extent={{518,60},{538,80}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_RLiv1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={524,112}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={530,116})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedA1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{512,-2},{542,
            26}}), iconTransformation(extent={{516,4},{546,32}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedB1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{512,-68},{542,
            -40}}), iconTransformation(extent={{516,-66},{546,-38}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedA1(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{520,-16},{540,
            4}}), iconTransformation(extent={{520,-16},{540,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedB1(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{518,-88},{538,-68}})));
  Modelica.Blocks.Sources.Constant HeatGain_LBed2[3](each k=0)
    annotation (Placement(transformation(extent={{128,194},{148,214}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB2(
    zoneName="Level2:2LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{190,156},{230,196}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv2(
    zoneName="Level2:2LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{206,298},{246,338}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA2(
    zoneName="Level2:2LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{186,232},{226,272}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv2(each k=0)
    annotation (Placement(transformation(extent={{126,334},{146,354}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv2(each k=0)
    annotation (Placement(transformation(extent={{134,286},{154,306}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedA2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,224})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LLiv2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,290}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,300})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedB2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,154})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LLiv2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{72,332},{102,
            360}}), iconTransformation(extent={{78,334},{108,362}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LLiv2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{82,312},{102,
            332}}), iconTransformation(extent={{82,312},{102,332}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_LLiv2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,362}), iconTransformation(extent={{84,362},{104,382}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedA2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{78,248},{108,
            276}}), iconTransformation(extent={{78,256},{108,284}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedB2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{78,184},{108,
            212}}), iconTransformation(extent={{78,184},{108,212}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedA2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{84,236},{104,
            256}}), iconTransformation(extent={{84,236},{104,256}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedB2(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{84,162},{104,182}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed2[3](each k=0)
    annotation (Placement(transformation(extent={{380,162},{400,182}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB2(
    zoneName="Level2:2RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{418,160},{458,200}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv2(
    zoneName="Level2:2RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{434,302},{474,342}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA2(
    zoneName="Level2:2RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{414,236},{454,276}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv2(each k=0)
    annotation (Placement(transformation(extent={{364,320},{384,340}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv2(each k=0)
    annotation (Placement(transformation(extent={{366,276},{386,296}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedA2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={526,228}), iconTransformation(extent={{522,222},{542,242}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RLiv2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={526,294}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={530,304})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedB2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={526,158}), iconTransformation(extent={{520,144},{540,164}},
          rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RLiv2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{510,336},{540,
            364}}), iconTransformation(extent={{510,336},{540,364}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RLiv2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{518,316},{538,
            336}}), iconTransformation(extent={{518,316},{538,336}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_RLiv2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={528,366}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={524,372})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedA2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{516,252},{546,
            280}}), iconTransformation(extent={{516,260},{546,288}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedB2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{516,186},{546,
            214}}), iconTransformation(extent={{516,190},{546,218}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedA2(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{524,238},{544,
            258}}), iconTransformation(extent={{520,240},{540,260}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedB2(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{522,166},{542,186}})));
  Modelica.Blocks.Sources.Constant HeatGain_LBed3[3](each k=0)
    annotation (Placement(transformation(extent={{130,456},{150,476}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB3(
    zoneName="Level3:3LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{192,418},{232,458}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv3(
    zoneName="Level3:3LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{208,560},{248,600}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA3(
    zoneName="Level3:3LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{188,494},{228,534}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv3(each k=0)
    annotation (Placement(transformation(extent={{128,596},{148,616}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv3(each k=0)
    annotation (Placement(transformation(extent={{136,548},{156,568}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedA3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,486})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LLiv3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,552}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,564})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedB3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,416})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LLiv3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{76,598},{106,
            626}}), iconTransformation(extent={{76,598},{106,626}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LLiv3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{80,576},{100,
            596}}), iconTransformation(extent={{80,576},{100,596}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_LLiv3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={92,624}), iconTransformation(extent={{82,626},{102,646}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedA3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{80,510},{110,
            538}}), iconTransformation(extent={{76,520},{106,548}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedB3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{76,448},{106,
            476}}), iconTransformation(extent={{76,448},{106,476}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedA3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{82,500},{102,
            520}}), iconTransformation(extent={{82,500},{102,520}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedB3(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{86,424},{106,444}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed3[3](each k=0)
    annotation (Placement(transformation(extent={{372,420},{392,440}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB3(
    zoneName="Level3:3RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{410,418},{450,458}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv3(
    zoneName="Level3:3RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{426,560},{466,600}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA3(
    zoneName="Level3:3RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{406,494},{446,534}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv3(each k=0)
    annotation (Placement(transformation(extent={{356,578},{376,598}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv3(each k=0)
    annotation (Placement(transformation(extent={{358,534},{378,554}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedA3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={518,486}), iconTransformation(extent={{522,478},{542,498}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RLiv3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={518,552}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={530,560})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedB3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={518,416}), iconTransformation(extent={{520,400},{540,420}},
          rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RLiv3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{502,594},{532,
            622}}), iconTransformation(extent={{510,592},{540,620}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RLiv3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{510,574},{530,
            594}}), iconTransformation(extent={{518,572},{538,592}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_RLiv3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={520,624}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={524,628})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedA3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{508,510},{538,
            538}}), iconTransformation(extent={{516,516},{546,544}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedB3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{516,446},{546,
            474}}), iconTransformation(extent={{516,446},{546,474}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedA3(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{520,496},{540,
            516}}), iconTransformation(extent={{520,496},{540,516}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedB3(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{514,424},{534,444}})));
  Modelica.Blocks.Sources.Constant HeatGain_LBed4[3](each k=0)
    annotation (Placement(transformation(extent={{128,728},{148,748}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB4(
    zoneName="Level4:4LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{190,690},{230,730}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv4(
    zoneName="Level4:4LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{206,832},{246,872}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA4(
    zoneName="Level4:4LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{186,766},{226,806}})));
  Modelica.Blocks.Sources.Constant RadiantGain_LLiv4(each k=0)
    annotation (Placement(transformation(extent={{126,868},{146,888}})));
  Modelica.Blocks.Sources.Constant LatentGain_LLiv4(each k=0)
    annotation (Placement(transformation(extent={{134,820},{154,840}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedA4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,758})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LLiv4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,824}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,834})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_LBedB4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,688})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LLiv4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{76,868},{106,
            896}}), iconTransformation(extent={{76,868},{106,896}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LLiv4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{80,846},{100,
            866}}), iconTransformation(extent={{80,846},{100,866}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_LLiv4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,896}), iconTransformation(extent={{82,896},{102,916}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedA4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{78,782},{108,
            810}}), iconTransformation(extent={{76,790},{106,818}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_LBedB4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{76,718},{106,
            746}}), iconTransformation(extent={{76,718},{106,746}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedA4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{82,770},{102,
            790}}), iconTransformation(extent={{82,770},{102,790}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_LBedB4(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{84,696},{104,716}})));
  Modelica.Blocks.Sources.Constant HeatGain_RBed4[3](each k=0)
    annotation (Placement(transformation(extent={{378,694},{398,714}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB4(
    zoneName="Level4:4RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{416,692},{456,732}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv4(
    zoneName="Level4:4RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{432,834},{472,874}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA4(
    zoneName="Level4:4RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{412,768},{452,808}})));
  Modelica.Blocks.Sources.Constant RadiantGain_RLiv4(each k=0)
    annotation (Placement(transformation(extent={{362,852},{382,872}})));
  Modelica.Blocks.Sources.Constant LatentGain_RLiv4(each k=0)
    annotation (Placement(transformation(extent={{364,808},{384,828}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedA4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={524,760}), iconTransformation(extent={{520,752},{540,772}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RLiv4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={524,826}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={528,834})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_RBedB4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={524,690}), iconTransformation(extent={{518,674},{538,694}},
          rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RLiv4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{508,868},{538,
            896}}), iconTransformation(extent={{508,866},{538,894}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RLiv4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{516,848},{536,
            868}}), iconTransformation(extent={{516,846},{536,866}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_RLiv4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={526,898}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={522,902})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedA4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{514,784},{544,
            812}}), iconTransformation(extent={{514,790},{544,818}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_RBedB4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{522,720},{552,
            748}}), iconTransformation(extent={{514,720},{544,748}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedA4(redeclare package Medium
      = MediumAir) annotation (Placement(transformation(extent={{526,770},{546,
            790}}), iconTransformation(extent={{518,770},{538,790}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_RBedB4(redeclare package Medium
      = MediumAir)
    annotation (Placement(transformation(extent={{520,698},{540,718}})));
equation
  connect(HeatGain_LBed1.y, LBedB1.qGai_flow) annotation (Line(points={{151,-46},
          {182,-46},{182,-64},{190,-64}}, color={0,0,127}));
  connect(building.weaBus,weaBus)  annotation (Line(
      points={{290,98},{306,98},{306,150}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(HeatGain_LBed1.y, LBedA1.qGai_flow) annotation (Line(points={{151,-46},
          {184,-46},{184,-24},{178,-24},{178,12},{186,12}}, color={0,0,127}));
  connect(weaBus.TDryBul, TOut) annotation (Line(
      points={{306.05,150.05},{306.05,992},{312,992},{312,1008}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(LLiv1.TAir, ZoneTemp_LLiv1) annotation (Line(points={{249,86},{254,86},
          {254,28},{116,28},{116,40},{90,40}}, color={0,0,127}));
  connect(weaBus.relHum, RelHum) annotation (Line(
      points={{306.05,150.05},{306.05,-96},{316,-96},{316,-112}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(RadiantGain_LLiv1.y, LLiv1.qGai_flow[1]) annotation (Line(points={{149,94},
          {196,94},{196,77.3333},{206,77.3333}},         color={0,0,127}));
  connect(LatentGain_LLiv1.y, LLiv1.qGai_flow[3]) annotation (Line(points={{157,46},
          {162,46},{162,78.6667},{206,78.6667}},     color={0,0,127}));
  connect(SensibleGain_LLiv1, LLiv1.qGai_flow[2]) annotation (Line(points={{92,
          112},{196,112},{196,78},{206,78}}, color={0,0,127}));
  connect(LBedB1.TAir, ZoneTemp_LBedB1) annotation (Line(points={{233,-56},{248,
          -56},{248,-54},{250,-54},{250,-96},{90,-96}}, color={0,0,127}));
  connect(LBedA1.TAir, ZoneTemp_LBedA1) annotation (Line(points={{229,20},{234,
          20},{234,-26},{90,-26}}, color={0,0,127}));
  connect(port_a_LLiv1, LLiv1.ports[1]) annotation (Line(points={{89,96},{116,
          96},{116,66},{227,66},{227,48.9}}, color={0,127,255}));
  connect(port_b_LLiv1, LLiv1.ports[2]) annotation (Line(points={{92,70},{202,
          70},{202,66},{229,66},{229,48.9}}, color={0,127,255}));
  connect(port_a_LBedA1, LBedA1.ports[1]) annotation (Line(points={{95,12},{180,
          12},{180,-17.1},{207,-17.1}}, color={0,127,255}));
  connect(port_b_LBedA1, LBedA1.ports[2]) annotation (Line(points={{96,-6},{176,
          -6},{176,12},{180,12},{180,-17.1},{209,-17.1}}, color={0,127,255}));
  connect(port_a_LBedB1, LBedB1.ports[1]) annotation (Line(points={{95,-54},{95,
          -112},{211,-112},{211,-93.1}}, color={0,127,255}));
  connect(port_b_LBedB1, LBedB1.ports[2]) annotation (Line(points={{96,-78},{
          112,-78},{112,-76},{130,-76},{130,-88},{213,-88},{213,-93.1}}, color=
          {0,127,255}));
  connect(HeatGain_RBed1.y, RBedB1.qGai_flow) annotation (Line(points={{397,-82},
          {400,-82},{400,-64},{412,-64}}, color={0,0,127}));
  connect(HeatGain_RBed1.y, RBedA1.qGai_flow) annotation (Line(points={{397,-82},
          {400,-82},{400,12},{408,12}}, color={0,0,127}));
  connect(RLiv1.TAir, ZoneTemp_RLiv1) annotation (Line(points={{471,86},{474,86},
          {474,66},{504,66},{504,40},{522,40}}, color={0,0,127}));
  connect(RadiantGain_RLiv1.y, RLiv1.qGai_flow[1]) annotation (Line(points={{381,76},
          {418,76},{418,77.3333},{428,77.3333}},         color={0,0,127}));
  connect(LatentGain_RLiv1.y, RLiv1.qGai_flow[3]) annotation (Line(points={{383,32},
          {414,32},{414,76},{418,76},{418,78.6667},{428,78.6667}},     color={0,
          0,127}));
  connect(SensibleGain_RLiv1, RLiv1.qGai_flow[2]) annotation (Line(points={{524,
          112},{418,112},{418,78},{428,78}}, color={0,0,127}));
  connect(RBedB1.TAir, ZoneTemp_RBedB1) annotation (Line(points={{455,-56},{506,
          -56},{506,-96},{522,-96}}, color={0,0,127}));
  connect(RBedA1.TAir, ZoneTemp_RBedA1) annotation (Line(points={{451,20},{462,
          20},{462,-26},{522,-26}}, color={0,0,127}));
  connect(port_a_RLiv1, RLiv1.ports[1]) annotation (Line(points={{521,96},{484,
          96},{484,70},{476,70},{476,68},{449,68},{449,48.9}}, color={0,127,255}));
  connect(port_b_RLiv1, RLiv1.ports[2]) annotation (Line(points={{524,70},{476,
          70},{476,68},{451,68},{451,48.9}}, color={0,127,255}));
  connect(port_a_RBedA1, RBedA1.ports[1]) annotation (Line(points={{527,12},{
          464,12},{464,-6},{429,-6},{429,-17.1}}, color={0,127,255}));
  connect(port_b_RBedA1, RBedA1.ports[2]) annotation (Line(points={{530,-6},{
          431,-6},{431,-17.1}}, color={0,127,255}));
  connect(port_a_RBedB1, RBedB1.ports[1]) annotation (Line(points={{527,-54},{
          466,-54},{466,-78},{433,-78},{433,-93.1}}, color={0,127,255}));
  connect(port_b_RBedB1, RBedB1.ports[2]) annotation (Line(points={{528,-78},{
          435,-78},{435,-93.1}}, color={0,127,255}));
  connect(HeatGain_LBed2.y, LBedB2.qGai_flow) annotation (Line(points={{149,204},
          {180,204},{180,186},{188,186}}, color={0,0,127}));
  connect(HeatGain_LBed2.y, LBedA2.qGai_flow) annotation (Line(points={{149,204},
          {172,204},{172,262},{184,262}}, color={0,0,127}));
  connect(LLiv2.TAir, ZoneTemp_LLiv2) annotation (Line(points={{247,336},{260,
          336},{260,288},{164,288},{164,280},{120,280},{120,290},{88,290}},
        color={0,0,127}));
  connect(RadiantGain_LLiv2.y, LLiv2.qGai_flow[1]) annotation (Line(points={{147,344},
          {196,344},{196,327.333},{204,327.333}},          color={0,0,127}));
  connect(LatentGain_LLiv2.y, LLiv2.qGai_flow[3]) annotation (Line(points={{155,296},
          {196,296},{196,328.667},{204,328.667}},      color={0,0,127}));
  connect(SensibleGain_LLiv2, LLiv2.qGai_flow[2]) annotation (Line(points={{90,
          362},{192,362},{192,328},{204,328}}, color={0,0,127}));
  connect(LBedB2.TAir, ZoneTemp_LBedB2) annotation (Line(points={{231,194},{231,
          208},{160,208},{160,154},{88,154}}, color={0,0,127}));
  connect(LBedA2.TAir, ZoneTemp_LBedA2) annotation (Line(points={{227,270},{227,
          284},{164,284},{164,224},{88,224}}, color={0,0,127}));
  connect(port_a_LLiv2, LLiv2.ports[1]) annotation (Line(points={{87,346},{116,
          346},{116,320},{196,320},{196,288},{225,288},{225,298.9}}, color={0,
          127,255}));
  connect(port_b_LLiv2, LLiv2.ports[2]) annotation (Line(points={{92,322},{196,
          322},{196,288},{227,288},{227,298.9}}, color={0,127,255}));
  connect(port_a_LBedA2, LBedA2.ports[1]) annotation (Line(points={{93,262},{
          176,262},{176,220},{205,220},{205,232.9}}, color={0,127,255}));
  connect(port_b_LBedA2, LBedA2.ports[2]) annotation (Line(points={{94,246},{
          176,246},{176,220},{207,220},{207,232.9}}, color={0,127,255}));
  connect(port_a_LBedB2, LBedB2.ports[1]) annotation (Line(points={{93,198},{
          120,198},{120,144},{209,144},{209,156.9}}, color={0,127,255}));
  connect(port_b_LBedB2, LBedB2.ports[2]) annotation (Line(points={{94,172},{
          180,172},{180,144},{211,144},{211,156.9}}, color={0,127,255}));
  connect(HeatGain_RBed2.y, RBedB2.qGai_flow) annotation (Line(points={{401,172},
          {401,180},{416,180},{416,190}}, color={0,0,127}));
  connect(HeatGain_RBed2.y, RBedA2.qGai_flow) annotation (Line(points={{401,172},
          {408,172},{408,224},{404,224},{404,266},{412,266}}, color={0,0,127}));
  connect(RLiv2.TAir, ZoneTemp_RLiv2) annotation (Line(points={{475,340},{496,
          340},{496,294},{526,294}}, color={0,0,127}));
  connect(RadiantGain_RLiv2.y, RLiv2.qGai_flow[1]) annotation (Line(points={{385,330},
          {408.5,330},{408.5,331.333},{432,331.333}},          color={0,0,127}));
  connect(LatentGain_RLiv2.y, RLiv2.qGai_flow[3]) annotation (Line(points={{387,286},
          {424,286},{424,332.667},{432,332.667}},      color={0,0,127}));
  connect(SensibleGain_RLiv2, RLiv2.qGai_flow[2]) annotation (Line(points={{528,
          366},{420,366},{420,332},{432,332}}, color={0,0,127}));
  connect(RBedB2.TAir, ZoneTemp_RBedB2) annotation (Line(points={{459,198},{504,
          198},{504,158},{526,158}}, color={0,0,127}));
  connect(RBedA2.TAir, ZoneTemp_RBedA2) annotation (Line(points={{455,274},{504,
          274},{504,228},{526,228}}, color={0,0,127}));
  connect(port_a_RLiv2, RLiv2.ports[1]) annotation (Line(points={{525,350},{492,
          350},{492,292},{453,292},{453,302.9}}, color={0,127,255}));
  connect(port_b_RLiv2, RLiv2.ports[2]) annotation (Line(points={{528,326},{488,
          326},{488,292},{455,292},{455,302.9}}, color={0,127,255}));
  connect(port_a_RBedA2, RBedA2.ports[1]) annotation (Line(points={{531,266},{
          468,266},{468,224},{433,224},{433,236.9}}, color={0,127,255}));
  connect(port_b_RBedA2, RBedA2.ports[2]) annotation (Line(points={{534,248},{
          468,248},{468,224},{435,224},{435,236.9}}, color={0,127,255}));
  connect(port_a_RBedB2, RBedB2.ports[1]) annotation (Line(points={{531,200},{
          472,200},{472,148},{437,148},{437,160.9}}, color={0,127,255}));
  connect(port_b_RBedB2, RBedB2.ports[2]) annotation (Line(points={{532,176},{
          472,176},{472,148},{439,148},{439,160.9}}, color={0,127,255}));
  connect(HeatGain_LBed3.y, LBedB3.qGai_flow) annotation (Line(points={{151,466},
          {180,466},{180,448},{190,448}}, color={0,0,127}));
  connect(HeatGain_LBed3.y, LBedA3.qGai_flow) annotation (Line(points={{151,466},
          {172,466},{172,524},{186,524}}, color={0,0,127}));
  connect(LLiv3.TAir, ZoneTemp_LLiv3) annotation (Line(points={{249,598},{249,
          612},{160,612},{160,576},{112,576},{112,552},{90,552}}, color={0,0,
          127}));
  connect(RadiantGain_LLiv3.y, LLiv3.qGai_flow[1]) annotation (Line(points={{149,606},
          {196,606},{196,589.333},{206,589.333}},          color={0,0,127}));
  connect(LatentGain_LLiv3.y, LLiv3.qGai_flow[3]) annotation (Line(points={{157,558},
          {196,558},{196,590.667},{206,590.667}},      color={0,0,127}));
  connect(SensibleGain_LLiv3, LLiv3.qGai_flow[2]) annotation (Line(points={{92,
          624},{196,624},{196,590},{206,590}}, color={0,0,127}));
  connect(LBedB3.TAir, ZoneTemp_LBedB3) annotation (Line(points={{233,456},{244,
          456},{244,408},{112,408},{112,416},{90,416}}, color={0,0,127}));
  connect(LBedA3.TAir, ZoneTemp_LBedA3) annotation (Line(points={{229,532},{240,
          532},{240,484},{124,484},{124,486},{90,486}}, color={0,0,127}));
  connect(port_a_LLiv3, LLiv3.ports[1]) annotation (Line(points={{91,612},{116,
          612},{116,580},{196,580},{196,548},{227,548},{227,560.9}}, color={0,
          127,255}));
  connect(port_b_LLiv3, LLiv3.ports[2]) annotation (Line(points={{90,586},{196,
          586},{196,548},{229,548},{229,560.9}}, color={0,127,255}));
  connect(port_a_LBedA3, LBedA3.ports[1]) annotation (Line(points={{95,524},{
          176,524},{176,484},{207,484},{207,494.9}}, color={0,127,255}));
  connect(port_b_LBedA3, LBedA3.ports[2]) annotation (Line(points={{92,510},{
          176,510},{176,484},{209,484},{209,494.9}}, color={0,127,255}));
  connect(port_a_LBedB3, LBedB3.ports[1]) annotation (Line(points={{91,462},{
          124,462},{124,408},{211,408},{211,418.9}}, color={0,127,255}));
  connect(port_b_LBedB3, LBedB3.ports[2]) annotation (Line(points={{96,434},{
          180,434},{180,408},{213,408},{213,418.9}}, color={0,127,255}));
  connect(HeatGain_RBed3.y, RBedB3.qGai_flow) annotation (Line(points={{393,430},
          {396,430},{396,448},{408,448}}, color={0,0,127}));
  connect(HeatGain_RBed3.y, RBedA3.qGai_flow) annotation (Line(points={{393,430},
          {400,430},{400,484},{396,484},{396,524},{404,524}}, color={0,0,127}));
  connect(RLiv3.TAir, ZoneTemp_RLiv3) annotation (Line(points={{467,598},{488,
          598},{488,552},{518,552}}, color={0,0,127}));
  connect(RadiantGain_RLiv3.y, RLiv3.qGai_flow[1]) annotation (Line(points={{377,588},
          {377,589.333},{424,589.333}},          color={0,0,127}));
  connect(LatentGain_RLiv3.y, RLiv3.qGai_flow[3]) annotation (Line(points={{379,544},
          {396,544},{396,590.667},{424,590.667}},      color={0,0,127}));
  connect(SensibleGain_RLiv3, RLiv3.qGai_flow[2]) annotation (Line(points={{520,
          624},{412,624},{412,590},{424,590}}, color={0,0,127}));
  connect(RBedB3.TAir, ZoneTemp_RBedB3) annotation (Line(points={{451,456},{496,
          456},{496,416},{518,416}}, color={0,0,127}));
  connect(RBedA3.TAir, ZoneTemp_RBedA3) annotation (Line(points={{447,532},{496,
          532},{496,486},{518,486}}, color={0,0,127}));
  connect(port_a_RLiv3, RLiv3.ports[1]) annotation (Line(points={{517,608},{484,
          608},{484,548},{445,548},{445,560.9}}, color={0,127,255}));
  connect(port_b_RLiv3, RLiv3.ports[2]) annotation (Line(points={{520,584},{480,
          584},{480,548},{447,548},{447,560.9}}, color={0,127,255}));
  connect(port_a_RBedA3, RBedA3.ports[1]) annotation (Line(points={{523,524},{
          460,524},{460,484},{425,484},{425,494.9}}, color={0,127,255}));
  connect(port_b_RBedA3, RBedA3.ports[2]) annotation (Line(points={{530,506},{
          460,506},{460,484},{427,484},{427,494.9}}, color={0,127,255}));
  connect(port_a_RBedB3, RBedB3.ports[1]) annotation (Line(points={{531,460},{
          464,460},{464,408},{429,408},{429,418.9}}, color={0,127,255}));
  connect(port_b_RBedB3, RBedB3.ports[2]) annotation (Line(points={{524,434},{
          464,434},{464,408},{431,408},{431,418.9}}, color={0,127,255}));
  connect(HeatGain_LBed4.y, LBedB4.qGai_flow) annotation (Line(points={{149,738},
          {180,738},{180,720},{188,720}}, color={0,0,127}));
  connect(HeatGain_LBed4.y, LBedA4.qGai_flow) annotation (Line(points={{149,738},
          {172,738},{172,796},{184,796}}, color={0,0,127}));
  connect(LLiv4.TAir, ZoneTemp_LLiv4) annotation (Line(points={{247,870},{247,
          884},{160,884},{160,848},{108,848},{108,824},{88,824}}, color={0,0,
          127}));
  connect(RadiantGain_LLiv4.y, LLiv4.qGai_flow[1]) annotation (Line(points={{147,878},
          {196,878},{196,861.333},{204,861.333}},          color={0,0,127}));
  connect(LatentGain_LLiv4.y, LLiv4.qGai_flow[3]) annotation (Line(points={{155,830},
          {196,830},{196,862.667},{204,862.667}},      color={0,0,127}));
  connect(SensibleGain_LLiv4, LLiv4.qGai_flow[2]) annotation (Line(points={{90,
          896},{192,896},{192,862},{204,862}}, color={0,0,127}));
  connect(LBedB4.TAir, ZoneTemp_LBedB4) annotation (Line(points={{231,728},{244,
          728},{244,680},{112,680},{112,688},{88,688}}, color={0,0,127}));
  connect(LBedA4.TAir, ZoneTemp_LBedA4) annotation (Line(points={{227,804},{240,
          804},{240,756},{116,756},{116,758},{88,758}}, color={0,0,127}));
  connect(port_a_LLiv4, LLiv4.ports[1]) annotation (Line(points={{91,882},{116,
          882},{116,852},{196,852},{196,820},{225,820},{225,832.9}}, color={0,
          127,255}));
  connect(port_b_LLiv4, LLiv4.ports[2]) annotation (Line(points={{90,856},{196,
          856},{196,820},{227,820},{227,832.9}}, color={0,127,255}));
  connect(port_a_LBedA4, LBedA4.ports[1]) annotation (Line(points={{93,796},{
          176,796},{176,756},{205,756},{205,766.9}}, color={0,127,255}));
  connect(port_b_LBedA4, LBedA4.ports[2]) annotation (Line(points={{92,780},{
          176,780},{176,756},{207,756},{207,766.9}}, color={0,127,255}));
  connect(port_a_LBedB4, LBedB4.ports[1]) annotation (Line(points={{91,732},{
          116,732},{116,680},{209,680},{209,690.9}}, color={0,127,255}));
  connect(port_b_LBedB4, LBedB4.ports[2]) annotation (Line(points={{94,706},{
          180,706},{180,680},{211,680},{211,690.9}}, color={0,127,255}));
  connect(HeatGain_RBed4.y, RBedB4.qGai_flow) annotation (Line(points={{399,704},
          {399,712},{414,712},{414,722}}, color={0,0,127}));
  connect(HeatGain_RBed4.y, RBedA4.qGai_flow) annotation (Line(points={{399,704},
          {399,688},{372,688},{372,798},{410,798}}, color={0,0,127}));
  connect(RLiv4.TAir, ZoneTemp_RLiv4) annotation (Line(points={{473,872},{492,
          872},{492,826},{524,826}}, color={0,0,127}));
  connect(RadiantGain_RLiv4.y, RLiv4.qGai_flow[1]) annotation (Line(points={{383,862},
          {406.5,862},{406.5,863.333},{430,863.333}},          color={0,0,127}));
  connect(LatentGain_RLiv4.y, RLiv4.qGai_flow[3]) annotation (Line(points={{385,818},
          {420,818},{420,864.667},{430,864.667}},      color={0,0,127}));
  connect(SensibleGain_RLiv4, RLiv4.qGai_flow[2]) annotation (Line(points={{526,
          898},{420,898},{420,864},{430,864}}, color={0,0,127}));
  connect(RBedB4.TAir, ZoneTemp_RBedB4) annotation (Line(points={{457,730},{508,
          730},{508,690},{524,690}}, color={0,0,127}));
  connect(RBedA4.TAir, ZoneTemp_RBedA4) annotation (Line(points={{453,806},{504,
          806},{504,760},{524,760}}, color={0,0,127}));
  connect(port_a_RLiv4, RLiv4.ports[1]) annotation (Line(points={{523,882},{488,
          882},{488,824},{451,824},{451,834.9}}, color={0,127,255}));
  connect(port_b_RLiv4, RLiv4.ports[2]) annotation (Line(points={{526,858},{484,
          858},{484,824},{453,824},{453,834.9}}, color={0,127,255}));
  connect(port_a_RBedA4, RBedA4.ports[1]) annotation (Line(points={{529,798},{
          464,798},{464,756},{431,756},{431,768.9}}, color={0,127,255}));
  connect(port_b_RBedA4, RBedA4.ports[2]) annotation (Line(points={{536,780},{
          464,780},{464,756},{433,756},{433,768.9}}, color={0,127,255}));
  connect(port_a_RBedB4, RBedB4.ports[1]) annotation (Line(points={{537,734},{
          468,734},{468,680},{435,680},{435,692.9}}, color={0,127,255}));
  connect(port_b_RBedB4, RBedB4.ports[2]) annotation (Line(points={{530,708},{
          468,708},{468,680},{437,680},{437,692.9}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,1000}})),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,
            1000}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisRoomModel_8apartments_NoInfiltration_NewYork;
