within CCC_test.Examples;
model NonArisMultiFamilyTest3
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating datTabHea;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling
    datTabCoo;
    replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating datTabHeaHpwh;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling
    datTabCooHpwh;

    parameter Modelica.Units.SI.MassFlowRate mTankHx_flow_nominal=0.5
    "Water tank heat exchanger glycol nominal mass flow rate";
      parameter Modelica.Units.SI.MassFlowRate mOccupant_flow_nominal=0.126
    "Occupant hot water usage nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mMultiSplit_flow_nominal=0.3
    "Fan coil units total glycol nominal mass flow rate";

  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=6000,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=mTankHx_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={28,-267})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.2,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-54,-292},{-34,-272}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{128,-270},{148,-250}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{158,-270},{178,-250}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{206,-264},{186,-246}})));
  CCC_test.Examples.ReversibleAirToWaterEuropeanNorm2D_withPowerData
    reversibleAirToWaterEuropeanNorm2D_withPowerData1(
    redeclare package MediumCon = MediumWater,
    redeclare package MediumEva = MediumAir,
    QUse_flow_nominal=2200,
    y_nominal=1,
    TCon_nominal=333.15,
    dpCon_nominal=2000,
    TEva_nominal=293.15,
    dpEva_nominal=2000,
    datTabHea=datTabHeaHpwh,
    datTabCoo=datTabCooHpwh)
    annotation (Placement(transformation(extent={{-10,-12},{10,12}},
        rotation=0,
        origin={112,-314})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpHpSupply(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mTankHx_flow_nominal,
    nominalValuesDefineDefaultPressureCurve=true) "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={134,-294})));
  Modelica.Blocks.Sources.Constant const3(k=0.2)
    annotation (Placement(transformation(extent={{196,-302},{216,-282}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 55)
    annotation (Placement(transformation(extent={{54,-352},{74,-332}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(k=true)
    annotation (Placement(transformation(extent={{58,-396},{78,-376}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fanHpwhCondenser(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.136,
    nominalValuesDefineDefaultPressureCurve=true) "Fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={188,-370})));
  Modelica.Blocks.Sources.Constant const5(k=0.1)
    annotation (Placement(transformation(extent={{144,-360},{164,-340}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{266,-326},{246,-308}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{286,-392},{266,-374}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={4,-305})));
  Modelica.Fluid.Sources.Boundary_pT boundary5(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={26,-319})));
equation
  connect(tan.port_b, boundary.ports[1]) annotation (Line(points={{18,-267},{8,-267},
          {8,-266},{-34,-266},{-34,-282}}, color={0,127,255}));
  connect(tan.port_a, tempTankOutlet.port_a) annotation (Line(points={{38,-267},
          {48,-267},{48,-266},{128,-266},{128,-260}}, color={0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_b) annotation (Line(points={{148,
          -260},{178,-260},{178,-260}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary2.ports[1]) annotation (Line(points={{178,-260},
          {186,-260},{186,-255}}, color={0,127,255}));
  connect(const3.y, pumpHpSupply.m_flow_in) annotation (Line(points={{217,-292},
          {224,-292},{224,-276},{188,-276},{188,-280},{116,-280},{116,-294},{
          122,-294}},                              color={0,0,127}));
  connect(const4.y, reversibleAirToWaterEuropeanNorm2D_withPowerData1.ySet)
    annotation (Line(points={{75,-342},{75,-344},{88,-344},{88,-312},{100.4,-312}},
        color={0,0,127}));
  connect(booleanConstant1.y, reversibleAirToWaterEuropeanNorm2D_withPowerData1.hea)
    annotation (Line(points={{79,-386},{100.4,-386},{100.4,-323}}, color={255,0,
          255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_b2,
    fanHpwhCondenser.port_a) annotation (Line(points={{102,-320},{92,-320},{92,-370},
          {178,-370}}, color={0,127,255}));
  connect(const5.y, fanHpwhCondenser.m_flow_in) annotation (Line(points={{165,-350},
          {176,-350},{176,-352},{188,-352},{188,-358}}, color={0,0,127}));
  connect(fanHpwhCondenser.port_b, boundary3.ports[1]) annotation (Line(points=
          {{198,-370},{256,-370},{256,-383},{266,-383}}, color={0,127,255}));
  connect(boundary1.ports[1], reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_a2)
    annotation (Line(points={{246,-317},{246,-320},{122,-320}}, color={0,127,
          255}));
  connect(tan.portHex_a, pumpHpSupply.port_b) annotation (Line(points={{38,
          -270.42},{72,-270.42},{72,-272},{134,-272},{134,-284}}, color={0,127,
          255}));
  connect(pumpHpSupply.port_a,
    reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_b1) annotation (Line(
        points={{134,-304},{134,-308},{122,-308}}, color={0,127,255}));
  connect(boundary4.ports[1], tan.portHex_b) annotation (Line(points={{14,-305},
          {28,-305},{28,-304},{38,-304},{38,-274.2}}, color={0,127,255}));
  connect(boundary5.ports[1], reversibleAirToWaterEuropeanNorm2D_withPowerData1.port_a1)
    annotation (Line(points={{36,-319},{80,-319},{80,-308},{102,-308}}, color={
          0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-400},
            {520,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-400},{520,100}})),
    experiment(
      StopTime=8640,
      Interval=300,
      __Dymola_Algorithm="Dassl"));
end NonArisMultiFamilyTest3;
