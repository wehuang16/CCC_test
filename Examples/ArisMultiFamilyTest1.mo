within CCC_test.Examples;
model ArisMultiFamilyTest1
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  parameter Modelica.Units.SI.MassFlowRate mOccupant_flow_nominal=0.126
    "Occupant hot water usage nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mFcu_flow_nominal=0.3
    "Fan coil units total glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mTankHx_flow_nominal=0.5
    "Water tank heat exchanger glycol nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mHp_flow_nominal=mFcu_flow_nominal+mTankHx_flow_nominal
    "Heat pump glycol nominal mass flow rate";
  CCC.Fluid.HeatPumps.BaseClasses.CCC_HP_wTSup_ctr_withPowerData_3D cCC_HP_wTSup_ctr_withPowerData_3D(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumPropyleneGlycol (property_T=293.15, X_a
          =0.4),
    datTabHea=CCC.Fluid.HeatPumps.Data.LG_DATA_Heating(),
    datTabCoo=CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling(),
    Q_flow_nominal=18500,
    TCon_nominal=308.15,
    TEva_nominal=280.15,
    mCon_flow_nominal=0.92,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{8,48},{28,64}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{64,64},{84,84}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-118,42},{-98,62}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-66,72},{-46,92}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mOccupant_flow_nominal,
    VTan=0.3,
    hTan=1.2,
    dIns=0.050,
    nSeg=5,
    T_start=321.15,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.199,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=313.15,
    THex_nominal=328.15,
    mHex_flow_nominal=0.92)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={-24,-51})));
  Modelica.Fluid.Sources.Boundary_pT      hpPump(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={24,14})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,24})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{72,-32},{52,-14}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.006,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-80,-96},{-60,-76}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{76,-56},{96,-36}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{154,-50},{134,-32}})));

  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-44,-106},{-24,-86}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{106,-56},{126,-36}})));

  Buildings.Fluid.Movers.FlowControlled_m_flow pumpHpSupply(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4),
    m_flow_nominal=mTankHx_flow_nominal,
    nominalValuesDefineDefaultPressureCurve=true) "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-58,-32})));

  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpReturn(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={48,-76})));
  Modelica.Blocks.Math.Gain        gain(k=0.92)
    annotation (Placement(transformation(extent={{-116,-10},{-96,10}})));
  Modelica.Blocks.Sources.Constant const3(k=273.15 + 2)
    annotation (Placement(transformation(extent={{114,14},{134,34}})));
  Modelica.Blocks.Sources.Constant const4(k=5)
    annotation (Placement(transformation(extent={{-202,8},{-182,28}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-122,-70},{-102,-50}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=300,
    yMin=0,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-164,-24},{-144,-4}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-190,-56},{-170,-36}})));
equation
  connect(booleanConstant1.y, cCC_HP_wTSup_ctr_withPowerData_3D.Mode)
    annotation (Line(points={{85,74},{90,74},{90,56},{29.2,56}}, color={255,0,
          255}));
  connect(const6.y, cCC_HP_wTSup_ctr_withPowerData_3D.TSupSet) annotation (Line(
        points={{-97,52},{-97,50.1},{6.9,50.1}}, color={0,0,127}));
  connect(booleanConstant.y, cCC_HP_wTSup_ctr_withPowerData_3D.IO) annotation (
      Line(points={{-45,82},{0,82},{0,53.6},{6.8,53.6}}, color={255,0,255}));
  connect(hpPump.ports[1], cCC_HP_wTSup_ctr_withPowerData_3D.port_a)
    annotation (Line(points={{24,24},{34,24},{34,62},{29,62}}, color={0,127,255}));
  connect(cCC_HP_wTSup_ctr_withPowerData_3D.port_b, tempHpSupply.port_a)
    annotation (Line(points={{7,61.8},{-4,61.8},{-4,40},{-46,40},{-46,34}},
        color={0,127,255}));
  connect(boundary.ports[1], tan.port_b) annotation (Line(points={{-60,-86},{-50,
          -86},{-50,-51},{-34,-51}}, color={0,127,255}));
  connect(tan.port_a, tempTankOutlet.port_a) annotation (Line(points={{-14,-51},
          {-14,-52},{2,-52},{2,-46},{76,-46}},   color={0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_a) annotation (Line(points={{96,-46},
          {106,-46}},                       color={0,127,255}));
  connect(tan.portHex_a, pumpHpSupply.port_b) annotation (Line(points={{-14,-54.42},
          {-8,-54.42},{-8,-54},{-2,-54},{-2,-42},{-58,-42}}, color={0,127,255}));
  connect(tempHpReturn.port_b, boundary2.ports[1]) annotation (Line(points={{48,
          -66},{32,-66},{32,-23},{52,-23}}, color={0,127,255}));
  connect(tempHpReturn.T, hpPump.T_in) annotation (Line(points={{37,-76},{38,-76},
          {38,-6},{20,-6},{20,2}}, color={0,0,127}));
  connect(senMasFlo.port_b, boundary1.ports[1]) annotation (Line(points={{126,-46},
          {128,-46},{128,-41},{134,-41}}, color={0,127,255}));
  connect(gain.y, pumpHpSupply.m_flow_in) annotation (Line(points={{-95,0},{-36,
          0},{-36,-32},{-46,-32}}, color={0,0,127}));
  connect(const3.y, cCC_HP_wTSup_ctr_withPowerData_3D.TOutAir) annotation (Line(
        points={{135,24},{166,24},{166,50.7},{29.3,50.7}}, color={0,0,127}));
  connect(tempHpSupply.port_b, pumpHpSupply.port_a) annotation (Line(points={{
          -46,14},{-48,14},{-48,-22},{-58,-22}}, color={0,127,255}));
  connect(tan.portHex_b, tempHpReturn.port_a) annotation (Line(points={{-14,
          -58.2},{6,-58.2},{6,-96},{48,-96},{48,-86}}, color={0,127,255}));
  connect(tempHpSupply.T, add.u1) annotation (Line(points={{-35,24},{-28,24},{
          -28,-4},{-84,-4},{-84,-40},{-132,-40},{-132,-54},{-124,-54}}, color={
          0,0,127}));
  connect(tempHpReturn.T, add.u2) annotation (Line(points={{37,-76},{-136,-76},
          {-136,-66},{-124,-66}}, color={0,0,127}));
  connect(const4.y, conPID.u_s) annotation (Line(points={{-181,18},{-168,18},{
          -168,4},{-172,4},{-172,-8},{-176,-8},{-176,-14},{-166,-14}}, color={0,
          0,127}));
  connect(add.y, conPID.u_m) annotation (Line(points={{-101,-60},{-104,-60},{
          -104,-26},{-154,-26}}, color={0,0,127}));
  connect(conPID.y, gain.u) annotation (Line(points={{-143,-14},{-128,-14},{
          -128,0},{-118,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -400},{560,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-400},{560,
            100}})),
    experiment(
      StartTime=21427200,
      StopTime=21470400,
      Interval=300,
      __Dymola_Algorithm="Dassl"));
end ArisMultiFamilyTest1;
