within CCC_test.obsolete_eas_e;
model ArisRoomModel_8apartments_NoInfiltration_NewYork_v2_for_logistical
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

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
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA1(
    zoneName="Level1:1LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{188,-18},{228,22}})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_BedA[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-26})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_Liv[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,48})));
  Modelica.Blocks.Interfaces.RealOutput ZoneTemp_BedB[8] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-96})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_Liv[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{74,82},{104,110}}),
        iconTransformation(extent={{74,82},{104,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_Liv[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{82,60},{102,80}}),
        iconTransformation(extent={{82,60},{102,80}})));
  Modelica.Blocks.Interfaces.RealInput SensibleGain_Liv[8] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,120}), iconTransformation(extent={{80,110},{100,130}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_BedA[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{80,-2},{110,26}}),
        iconTransformation(extent={{82,4},{112,32}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_BedB[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{80,-68},{110,-40}}),
        iconTransformation(extent={{80,-68},{110,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_BedA[8](redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{86,-16},{106,4}}),
        iconTransformation(extent={{86,-16},{106,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_BedB[8](redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{86,-88},{106,-68}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB1(
    zoneName="Level1:1RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{414,-94},{454,-54}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv1(
    zoneName="Level1:1RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15)
              annotation (Placement(transformation(extent={{430,48},{470,88}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA1(
    zoneName="Level1:1RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{410,-18},{450,22}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB2(
    zoneName="Level2:2LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{190,156},{230,196}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv2(
    zoneName="Level2:2LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{206,298},{246,338}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA2(
    zoneName="Level2:2LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{186,232},{226,272}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB2(
    zoneName="Level2:2RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{418,160},{458,200}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv2(
    zoneName="Level2:2RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{434,302},{474,342}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA2(
    zoneName="Level2:2RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{414,236},{454,276}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB3(
    zoneName="Level3:3LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{192,418},{232,458}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv3(
    zoneName="Level3:3LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{208,560},{248,600}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA3(
    zoneName="Level3:3LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{188,494},{228,534}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB3(
    zoneName="Level3:3RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{410,418},{450,458}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv3(
    zoneName="Level3:3RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{426,560},{466,600}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA3(
    zoneName="Level3:3RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{406,494},{446,534}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedB4(
    zoneName="Level4:4LBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{190,690},{230,730}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LLiv4(
    zoneName="Level4:4LLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{206,832},{246,872}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone LBedA4(
    zoneName="Level4:4LBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{186,766},{226,806}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedB4(
    zoneName="Level4:4RBedroom2",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{416,692},{456,732}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RLiv4(
    zoneName="Level4:4RLivingRoom",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{432,834},{472,874}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone RBedA4(
    zoneName="Level4:4RBedroom1",
    redeclare package Medium = MediumAir,
    T_start=288.15)
    annotation (Placement(transformation(extent={{412,768},{452,808}})));
equation
  connect(port_a_Liv[1], LLiv1.ports[1]) annotation (Line(points={{82.4375,96},
          {116,96},{116,66},{227,66},{227,48.9}},
                                         color={0,127,255}));
  connect(port_b_Liv[1], LLiv1.ports[2]) annotation (Line(points={{92,65.625},{
          202,65.625},{202,66},{229,66},{229,48.9}},
                                         color={0,127,255}));
  connect(port_a_BedA[1], LBedA1.ports[1]) annotation (Line(points={{88.4375,12},
          {180,12},{180,-17.1},{207,-17.1}},
                                    color={0,127,255}));
  connect(port_b_BedA[1], LBedA1.ports[2]) annotation (Line(points={{96,-10.375},
          {176,-10.375},{176,12},{180,12},{180,-17.1},{209,-17.1}},
                                                      color={0,127,255}));
  connect(port_a_BedB[1], LBedB1.ports[1]) annotation (Line(points={{88.4375,
          -54},{88.4375,-112},{211,-112},{211,-93.1}},
                                   color={0,127,255}));
  connect(port_b_BedB[1], LBedB1.ports[2]) annotation (Line(points={{96,-82.375},
          {112,-82.375},{112,-76},{130,-76},{130,-88},{213,-88},{213,-93.1}},
                                                                color={0,127,255}));
  connect(SensibleGain_Liv[1], LLiv1.qGai_flow[2]) annotation (Line(points={{90,
          115.625},{192,115.625},{192,96},{196,96},{196,78},{206,78}}, color={0,
          0,127}));
  connect(LLiv1.TAir, ZoneTemp_Liv[1]) annotation (Line(points={{249,86},{260,86},
          {260,32},{90,32},{90,35.625}}, color={0,0,127}));
  connect(LBedA1.TAir, ZoneTemp_BedA[1]) annotation (Line(points={{229,20},{240,
          20},{240,-30.375},{90,-30.375}}, color={0,0,127}));
  connect(LBedB1.TAir, ZoneTemp_BedB[1]) annotation (Line(points={{233,-56},{248,
          -56},{248,-100.375},{90,-100.375}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,1000}})),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,
            1000}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisRoomModel_8apartments_NoInfiltration_NewYork_v2_for_logistical;
