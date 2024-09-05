within CCC_test.CCC_Model;
model TRC_building_low_rise_rochester_old1

          extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

       parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

                  parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/Data/energyPlusFiles/US+MF+CZ6A+gasfurnace+slab+IECC_2021_V960.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-150,20},{-130,40}})));

  Modelica.Blocks.Sources.Constant qIntGai1[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-106,42},{-86,62}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_FrontRow_BottomFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-46,22},{-6,62}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner1(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{94,28},{114,48}})));
  Modelica.Blocks.Sources.Constant qIntGai2[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-104,-22},{-84,-2}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon2(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_FrontRow_BottomFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-44,-42},{-4,-2}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner2(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{96,-36},{116,-16}})));
  Modelica.Blocks.Sources.Constant qIntGai3[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-104,-84},{-84,-64}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon3(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_FrontRow_BottomFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-44,-104},{-4,-64}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner3(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{96,-98},{116,-78}})));
  Modelica.Blocks.Sources.Constant qIntGai4[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-106,-168},{-86,-148}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon4(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_BackRow_BottomFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-46,-188},{-6,-148}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner4(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{94,-182},{114,-162}})));
  Modelica.Blocks.Sources.Constant qIntGai5[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-112,-232},{-92,-212}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon5(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_BackRow_BottomFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-52,-252},{-12,-212}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner5(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{88,-246},{108,-226}})));
  Modelica.Blocks.Sources.Constant qIntGai6[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-112,-294},{-92,-274}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon6(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_BackRow_BottomFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-52,-314},{-12,-274}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner6(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{88,-308},{108,-288}})));
  Modelica.Blocks.Sources.Constant qIntGai7[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-102,-370},{-82,-350}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon7(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_FrontRow_MiddleFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-42,-390},{-2,-350}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner7(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{98,-384},{118,-364}})));
  Modelica.Blocks.Sources.Constant qIntGai8[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-118,-434},{-98,-414}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon8(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_FrontRow_MiddleFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-58,-454},{-18,-414}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner8(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{82,-448},{102,-428}})));
  Modelica.Blocks.Sources.Constant qIntGai9[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-118,-518},{-98,-498}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon9(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_FrontRow_MiddleFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-58,-538},{-18,-498}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner9(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{82,-532},{102,-512}})));
  Modelica.Blocks.Sources.Constant qIntGai10
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-118,-586},{-98,-566}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon10(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_BackRow_MiddleFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-58,-606},{-18,-566}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner10(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{82,-600},{102,-580}})));
  Modelica.Blocks.Sources.Constant qIntGai11
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{204,46},{224,66}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon11(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_BackRow_MiddleFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{264,26},{304,66}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner11(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{404,32},{424,52}})));
  Modelica.Blocks.Sources.Constant qIntGai12
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{196,-48},{216,-28}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon12(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_BackRow_MiddleFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{256,-68},{296,-28}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner12(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{396,-62},{416,-42}})));
  Modelica.Blocks.Sources.Constant qIntGai13
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{200,-116},{220,-96}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon13(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_FrontRow_TopFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{260,-136},{300,-96}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner13(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{400,-130},{420,-110}})));
  Modelica.Blocks.Sources.Constant qIntGai14
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{208,-190},{228,-170}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon14(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_FrontRow_TopFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{268,-210},{308,-170}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner14(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{408,-204},{428,-184}})));
  Modelica.Blocks.Sources.Constant qIntGai15
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{206,-258},{226,-238}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon15(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_FrontRow_TopFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{266,-278},{306,-238}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner15(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{406,-272},{426,-252}})));
  Modelica.Blocks.Sources.Constant qIntGai16
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{204,-336},{224,-316}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon16(
    redeclare package Medium = MediumAir,
    zoneName="living_unit1_BackRow_TopFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{264,-356},{304,-316}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner16(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{404,-350},{424,-330}})));
  Modelica.Blocks.Sources.Constant qIntGai17
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{206,-406},{226,-386}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon17(
    redeclare package Medium = MediumAir,
    zoneName="living_unit2_BackRow_TopFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{266,-426},{306,-386}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner17(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{406,-420},{426,-400}})));
  Modelica.Blocks.Sources.Constant qIntGai18
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{216,-478},{236,-458}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon18(
    redeclare package Medium = MediumAir,
    zoneName="living_unit3_BackRow_TopFloor",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{276,-498},{316,-458}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner18(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{416,-492},{436,-472}})));
  Modelica.Blocks.Sources.Constant qIntGai19
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{222,-552},{242,-532}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon19(
    redeclare package Medium = MediumAir,
    zoneName="Breezeway",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{282,-572},{322,-532}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner19(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{422,-566},{442,-546}})));
  Modelica.Blocks.Sources.Constant qIntGai20
                                           [3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{224,-622},{244,-602}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon20(
    redeclare package Medium = MediumAir,
    zoneName="attic",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{284,-642},{324,-602}})));
  CCC.Fluid.BaseClasses.Trc_custom_air_conditioner trc_custom_air_conditioner20(
    mRec_flow_nominal=mRec_flow_nominal,
    TCooSet=TCooSet,
    THeaSet=THeaSet)
    annotation (Placement(transformation(extent={{424,-636},{444,-616}})));
equation
  connect(zon1.qGai_flow,qIntGai1. y)
    annotation (Line(points={{-48,52},{-85,52}},   color={0,0,127}));
  connect(zon1.TAir,trc_custom_air_conditioner1. ZAT) annotation (Line(points={{-5,60},
          {84,60},{84,44.4},{92,44.4}},                color={0,0,127}));
  connect(trc_custom_air_conditioner1.port_b,zon1. ports[4]) annotation (Line(
        points={{114.8,30.4},{118,30.4},{118,16},{-24.5,16},{-24.5,22.9}},
        color={0,127,255}));
  connect(zon1.ports[3],trc_custom_air_conditioner1. port_a) annotation (Line(
        points={{-25.5,22.9},{-25.5,20},{88,20},{88,30.6},{93.6,30.6}},
        color={0,127,255}));
  connect(zon2.qGai_flow,qIntGai2. y)
    annotation (Line(points={{-46,-12},{-83,-12}}, color={0,0,127}));
  connect(zon2.TAir,trc_custom_air_conditioner2. ZAT) annotation (Line(points={{-3,-4},
          {86,-4},{86,-19.6},{94,-19.6}},              color={0,0,127}));
  connect(trc_custom_air_conditioner2.port_b,zon2. ports[4]) annotation (Line(
        points={{116.8,-33.6},{120,-33.6},{120,-48},{-22.5,-48},{-22.5,-41.1}},
        color={0,127,255}));
  connect(zon2.ports[3],trc_custom_air_conditioner2. port_a) annotation (Line(
        points={{-23.5,-41.1},{-23.5,-44},{90,-44},{90,-33.4},{95.6,-33.4}},
        color={0,127,255}));
  connect(zon3.qGai_flow,qIntGai3. y)
    annotation (Line(points={{-46,-74},{-83,-74}}, color={0,0,127}));
  connect(zon3.TAir,trc_custom_air_conditioner3. ZAT) annotation (Line(points={{-3,-66},
          {86,-66},{86,-81.6},{94,-81.6}},             color={0,0,127}));
  connect(trc_custom_air_conditioner3.port_b,zon3. ports[4]) annotation (Line(
        points={{116.8,-95.6},{120,-95.6},{120,-110},{-22.5,-110},{-22.5,-103.1}},
        color={0,127,255}));
  connect(zon3.ports[3],trc_custom_air_conditioner3. port_a) annotation (Line(
        points={{-23.5,-103.1},{-23.5,-106},{90,-106},{90,-95.4},{95.6,-95.4}},
        color={0,127,255}));
  connect(zon4.qGai_flow,qIntGai4. y)
    annotation (Line(points={{-48,-158},{-85,-158}},
                                                   color={0,0,127}));
  connect(zon4.TAir,trc_custom_air_conditioner4. ZAT) annotation (Line(points={{-5,-150},
          {84,-150},{84,-165.6},{92,-165.6}},          color={0,0,127}));
  connect(trc_custom_air_conditioner4.port_b,zon4. ports[4]) annotation (Line(
        points={{114.8,-179.6},{118,-179.6},{118,-194},{-24.5,-194},{-24.5,
          -187.1}},
        color={0,127,255}));
  connect(zon4.ports[3],trc_custom_air_conditioner4. port_a) annotation (Line(
        points={{-25.5,-187.1},{-25.5,-190},{88,-190},{88,-179.4},{93.6,-179.4}},
        color={0,127,255}));
  connect(zon5.qGai_flow,qIntGai5. y)
    annotation (Line(points={{-54,-222},{-91,-222}},
                                                   color={0,0,127}));
  connect(zon5.TAir,trc_custom_air_conditioner5. ZAT) annotation (Line(points={{-11,
          -214},{76,-214},{76,-229.6},{86,-229.6}},    color={0,0,127}));
  connect(trc_custom_air_conditioner5.port_b,zon5. ports[4]) annotation (Line(
        points={{108.8,-243.6},{114,-243.6},{114,-258},{-30.5,-258},{-30.5,
          -251.1}},
        color={0,127,255}));
  connect(zon5.ports[3],trc_custom_air_conditioner5. port_a) annotation (Line(
        points={{-31.5,-251.1},{-31.5,-258},{82,-258},{82,-243.4},{87.6,-243.4}},
        color={0,127,255}));
  connect(zon6.qGai_flow,qIntGai6. y)
    annotation (Line(points={{-54,-284},{-91,-284}},
                                                   color={0,0,127}));
  connect(zon6.TAir,trc_custom_air_conditioner6. ZAT) annotation (Line(points={{-11,
          -276},{76,-276},{76,-291.6},{86,-291.6}},    color={0,0,127}));
  connect(trc_custom_air_conditioner6.port_b,zon6. ports[4]) annotation (Line(
        points={{108.8,-305.6},{114,-305.6},{114,-320},{-30.5,-320},{-30.5,
          -313.1}},
        color={0,127,255}));
  connect(zon6.ports[3],trc_custom_air_conditioner6. port_a) annotation (Line(
        points={{-31.5,-313.1},{-31.5,-320},{82,-320},{82,-305.4},{87.6,-305.4}},
        color={0,127,255}));
  connect(zon7.qGai_flow,qIntGai7. y)
    annotation (Line(points={{-44,-360},{-81,-360}},
                                                   color={0,0,127}));
  connect(zon7.TAir,trc_custom_air_conditioner7. ZAT) annotation (Line(points={{-1,-352},
          {88,-352},{88,-367.6},{96,-367.6}},          color={0,0,127}));
  connect(trc_custom_air_conditioner7.port_b,zon7. ports[4]) annotation (Line(
        points={{118.8,-381.6},{122,-381.6},{122,-396},{-20.5,-396},{-20.5,
          -389.1}},
        color={0,127,255}));
  connect(zon7.ports[3],trc_custom_air_conditioner7. port_a) annotation (Line(
        points={{-21.5,-389.1},{-21.5,-392},{92,-392},{92,-381.4},{97.6,-381.4}},
        color={0,127,255}));
  connect(zon8.qGai_flow,qIntGai8. y)
    annotation (Line(points={{-60,-424},{-97,-424}},
                                                   color={0,0,127}));
  connect(zon8.TAir,trc_custom_air_conditioner8. ZAT) annotation (Line(points={{-17,
          -416},{72,-416},{72,-431.6},{80,-431.6}},    color={0,0,127}));
  connect(trc_custom_air_conditioner8.port_b,zon8. ports[4]) annotation (Line(
        points={{102.8,-445.6},{106,-445.6},{106,-460},{-36.5,-460},{-36.5,
          -453.1}},
        color={0,127,255}));
  connect(zon8.ports[3],trc_custom_air_conditioner8. port_a) annotation (Line(
        points={{-37.5,-453.1},{-37.5,-456},{76,-456},{76,-445.4},{81.6,-445.4}},
        color={0,127,255}));
  connect(zon9.qGai_flow,qIntGai9. y)
    annotation (Line(points={{-60,-508},{-97,-508}},
                                                   color={0,0,127}));
  connect(zon9.TAir,trc_custom_air_conditioner9. ZAT) annotation (Line(points={{-17,
          -500},{72,-500},{72,-515.6},{80,-515.6}},    color={0,0,127}));
  connect(trc_custom_air_conditioner9.port_b,zon9. ports[4]) annotation (Line(
        points={{102.8,-529.6},{106,-529.6},{106,-544},{-36.5,-544},{-36.5,
          -537.1}},
        color={0,127,255}));
  connect(zon9.ports[3],trc_custom_air_conditioner9. port_a) annotation (Line(
        points={{-37.5,-537.1},{-37.5,-540},{76,-540},{76,-529.4},{81.6,-529.4}},
        color={0,127,255}));
  connect(zon10.qGai_flow, qIntGai10.y)
    annotation (Line(points={{-60,-576},{-97,-576}}, color={0,0,127}));
  connect(zon10.TAir, trc_custom_air_conditioner10.ZAT) annotation (Line(points=
         {{-17,-568},{72,-568},{72,-583.6},{80,-583.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner10.port_b, zon10.ports[4]) annotation (Line(
        points={{102.8,-597.6},{106,-597.6},{106,-612},{-36.5,-612},{-36.5,
          -605.1}}, color={0,127,255}));
  connect(zon10.ports[3], trc_custom_air_conditioner10.port_a) annotation (Line(
        points={{-37.5,-605.1},{-37.5,-608},{76,-608},{76,-597.4},{81.6,-597.4}},
        color={0,127,255}));
  connect(zon11.qGai_flow, qIntGai11.y)
    annotation (Line(points={{262,56},{225,56}}, color={0,0,127}));
  connect(zon11.TAir, trc_custom_air_conditioner11.ZAT) annotation (Line(points=
         {{305,64},{394,64},{394,48.4},{402,48.4}}, color={0,0,127}));
  connect(trc_custom_air_conditioner11.port_b, zon11.ports[4]) annotation (Line(
        points={{424.8,34.4},{428,34.4},{428,20},{285.5,20},{285.5,26.9}},
        color={0,127,255}));
  connect(zon11.ports[3], trc_custom_air_conditioner11.port_a) annotation (Line(
        points={{284.5,26.9},{284.5,24},{398,24},{398,34.6},{403.6,34.6}},
        color={0,127,255}));
  connect(zon12.qGai_flow, qIntGai12.y)
    annotation (Line(points={{254,-38},{217,-38}}, color={0,0,127}));
  connect(zon12.TAir, trc_custom_air_conditioner12.ZAT) annotation (Line(points=
         {{297,-30},{386,-30},{386,-45.6},{394,-45.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner12.port_b, zon12.ports[4]) annotation (Line(
        points={{416.8,-59.6},{420,-59.6},{420,-74},{277.5,-74},{277.5,-67.1}},
        color={0,127,255}));
  connect(zon12.ports[3], trc_custom_air_conditioner12.port_a) annotation (Line(
        points={{276.5,-67.1},{276.5,-70},{390,-70},{390,-59.4},{395.6,-59.4}},
        color={0,127,255}));
  connect(zon13.qGai_flow, qIntGai13.y)
    annotation (Line(points={{258,-106},{221,-106}}, color={0,0,127}));
  connect(zon13.TAir, trc_custom_air_conditioner13.ZAT) annotation (Line(points=
         {{301,-98},{390,-98},{390,-113.6},{398,-113.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner13.port_b, zon13.ports[4]) annotation (Line(
        points={{420.8,-127.6},{424,-127.6},{424,-142},{281.5,-142},{281.5,
          -135.1}}, color={0,127,255}));
  connect(zon13.ports[3], trc_custom_air_conditioner13.port_a) annotation (Line(
        points={{280.5,-135.1},{280.5,-138},{394,-138},{394,-127.4},{399.6,
          -127.4}}, color={0,127,255}));
  connect(zon14.qGai_flow, qIntGai14.y)
    annotation (Line(points={{266,-180},{229,-180}}, color={0,0,127}));
  connect(zon14.TAir, trc_custom_air_conditioner14.ZAT) annotation (Line(points=
         {{309,-172},{398,-172},{398,-187.6},{406,-187.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner14.port_b, zon14.ports[4]) annotation (Line(
        points={{428.8,-201.6},{432,-201.6},{432,-216},{289.5,-216},{289.5,
          -209.1}}, color={0,127,255}));
  connect(zon14.ports[3], trc_custom_air_conditioner14.port_a) annotation (Line(
        points={{288.5,-209.1},{288.5,-212},{402,-212},{402,-201.4},{407.6,
          -201.4}}, color={0,127,255}));
  connect(zon15.qGai_flow, qIntGai15.y)
    annotation (Line(points={{264,-248},{227,-248}}, color={0,0,127}));
  connect(zon15.TAir, trc_custom_air_conditioner15.ZAT) annotation (Line(points=
         {{307,-240},{396,-240},{396,-255.6},{404,-255.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner15.port_b, zon15.ports[4]) annotation (Line(
        points={{426.8,-269.6},{430,-269.6},{430,-284},{287.5,-284},{287.5,
          -277.1}}, color={0,127,255}));
  connect(zon15.ports[3], trc_custom_air_conditioner15.port_a) annotation (Line(
        points={{286.5,-277.1},{286.5,-280},{400,-280},{400,-269.4},{405.6,
          -269.4}}, color={0,127,255}));
  connect(zon16.qGai_flow, qIntGai16.y)
    annotation (Line(points={{262,-326},{225,-326}}, color={0,0,127}));
  connect(zon16.TAir, trc_custom_air_conditioner16.ZAT) annotation (Line(points=
         {{305,-318},{394,-318},{394,-333.6},{402,-333.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner16.port_b, zon16.ports[4]) annotation (Line(
        points={{424.8,-347.6},{428,-347.6},{428,-362},{285.5,-362},{285.5,
          -355.1}}, color={0,127,255}));
  connect(zon16.ports[3], trc_custom_air_conditioner16.port_a) annotation (Line(
        points={{284.5,-355.1},{284.5,-358},{398,-358},{398,-347.4},{403.6,
          -347.4}}, color={0,127,255}));
  connect(zon17.qGai_flow, qIntGai17.y)
    annotation (Line(points={{264,-396},{227,-396}}, color={0,0,127}));
  connect(zon17.TAir, trc_custom_air_conditioner17.ZAT) annotation (Line(points=
         {{307,-388},{396,-388},{396,-403.6},{404,-403.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner17.port_b, zon17.ports[4]) annotation (Line(
        points={{426.8,-417.6},{430,-417.6},{430,-432},{287.5,-432},{287.5,
          -425.1}}, color={0,127,255}));
  connect(zon17.ports[3], trc_custom_air_conditioner17.port_a) annotation (Line(
        points={{286.5,-425.1},{286.5,-428},{400,-428},{400,-417.4},{405.6,
          -417.4}}, color={0,127,255}));
  connect(zon18.qGai_flow, qIntGai18.y)
    annotation (Line(points={{274,-468},{237,-468}}, color={0,0,127}));
  connect(zon18.TAir, trc_custom_air_conditioner18.ZAT) annotation (Line(points=
         {{317,-460},{406,-460},{406,-475.6},{414,-475.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner18.port_b, zon18.ports[4]) annotation (Line(
        points={{436.8,-489.6},{440,-489.6},{440,-504},{297.5,-504},{297.5,
          -497.1}}, color={0,127,255}));
  connect(zon18.ports[3], trc_custom_air_conditioner18.port_a) annotation (Line(
        points={{296.5,-497.1},{296.5,-500},{410,-500},{410,-489.4},{415.6,
          -489.4}}, color={0,127,255}));
  connect(zon19.qGai_flow, qIntGai19.y)
    annotation (Line(points={{280,-542},{243,-542}}, color={0,0,127}));
  connect(zon19.TAir, trc_custom_air_conditioner19.ZAT) annotation (Line(points=
         {{323,-534},{412,-534},{412,-549.6},{420,-549.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner19.port_b, zon19.ports[4]) annotation (Line(
        points={{442.8,-563.6},{446,-563.6},{446,-578},{303.5,-578},{303.5,
          -571.1}}, color={0,127,255}));
  connect(zon19.ports[3], trc_custom_air_conditioner19.port_a) annotation (Line(
        points={{302.5,-571.1},{302.5,-574},{416,-574},{416,-563.4},{421.6,
          -563.4}}, color={0,127,255}));
  connect(zon20.qGai_flow, qIntGai20.y)
    annotation (Line(points={{282,-612},{245,-612}}, color={0,0,127}));
  connect(zon20.TAir, trc_custom_air_conditioner20.ZAT) annotation (Line(points=
         {{325,-604},{414,-604},{414,-619.6},{422,-619.6}}, color={0,0,127}));
  connect(trc_custom_air_conditioner20.port_b, zon20.ports[4]) annotation (Line(
        points={{444.8,-633.6},{448,-633.6},{448,-648},{305.5,-648},{305.5,
          -641.1}}, color={0,127,255}));
  connect(zon20.ports[3], trc_custom_air_conditioner20.port_a) annotation (Line(
        points={{304.5,-641.1},{304.5,-644},{418,-644},{418,-633.4},{423.6,
          -633.4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TRC_building_low_rise_rochester_old1;
