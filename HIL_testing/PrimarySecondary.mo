within CCC_test.HIL_testing;
model PrimarySecondary
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  hil_flexlab_model.Test1.BaseClasses1.ParallelValvesFlow
                                                       parallelValvesFlow(
      redeclare package Medium = MediumWater)
    "determine the cooling coil mass flow rate"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={132,0})));
  Buildings.Fluid.Movers.SpeedControlled_y pumpSup1(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW18 per,
    addPowerToMedium=false) "Supply air fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,-2})));
  Modelica.Blocks.Sources.Constant
                               const(k=1)
    annotation (Placement(transformation(extent={{-112,36},{-92,56}})));
  Buildings.Fluid.Sources.Boundary_pT souCoo(
    redeclare package Medium = MediumWater,
    T=280.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-122,-4})));
  Buildings.Fluid.FixedResistances.Junction JunctionConverge(
    redeclare package Medium = MediumWater,
    m_flow_nominal={1,-2,1},
    dp_nominal(each displayUnit="Pa") = {0,0,0}) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-14,86})));
  Buildings.Fluid.FixedResistances.Junction JunctionDiverge(
    redeclare package Medium = MediumWater,
    m_flow_nominal={2,-1,-1},
    dp_nominal(each displayUnit="Pa") = {0,0,0})
    annotation (Placement(transformation(extent={{-26,10},{-6,-10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{-58,-12},{-38,8}})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo(redeclare package Medium =
        MediumWater, nPorts=1) "Sink for cooling coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-114,82})));
  Buildings.Fluid.Movers.SpeedControlled_y pumpSup2(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW18 per,
    addPowerToMedium=false) "Supply air fan" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,0})));
  Buildings.Fluid.FixedResistances.Junction JunctionConverge1(
    redeclare package Medium = MediumWater,
    m_flow_nominal={1,-2,1},
    dp_nominal(each displayUnit="Pa") = {0,0,0}) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,86})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{10,14},{38,-14}})));
  IBPSA.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dp_nominal=0,
    Q_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={150,44})));
  Modelica.Blocks.Sources.Constant
                               const1(k=2000)
    annotation (Placement(transformation(extent={{154,70},{174,90}})));
  Modelica.Blocks.Sources.Constant
                               const2(k=0.5)
    annotation (Placement(transformation(extent={{128,-100},{148,-80}})));
  Modelica.Blocks.Sources.Constant
                               const4(k=0.5)
    annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dp_nominal=100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,42})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={108,48})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    strict=true,
    reverseActing=true)
    annotation (Placement(transformation(extent={{66,30},{86,50}})));
  Modelica.Blocks.Sources.Constant
                               const3(k=150)
    annotation (Placement(transformation(extent={{32,30},{52,50}})));
equation
  connect(const.y, pumpSup1.y)
    annotation (Line(points={{-91,46},{-78,46},{-78,10}}, color={0,0,127}));
  connect(souCoo.ports[1], pumpSup1.port_a) annotation (Line(points={{-112,-4},
          {-110,-4},{-110,-2},{-88,-2}}, color={0,127,255}));
  connect(pumpSup1.port_b, senMasFlo.port_a)
    annotation (Line(points={{-68,-2},{-58,-2}}, color={0,127,255}));
  connect(senMasFlo.port_b, JunctionDiverge.port_1)
    annotation (Line(points={{-38,-2},{-38,0},{-26,0}}, color={0,127,255}));
  connect(JunctionConverge.port_2, sinCoo.ports[1]) annotation (Line(points={{
          -24,86},{-98,86},{-98,82},{-104,82}}, color={0,127,255}));
  connect(JunctionDiverge.port_2, val1.port_1) annotation (Line(points={{-6,0},
          {2,0},{2,-1.77636e-15},{10,-1.77636e-15}}, color={0,127,255}));
  connect(val1.port_2, pumpSup2.port_a) annotation (Line(points={{38,
          -1.77636e-15},{45,-1.77636e-15},{45,0},{52,0}}, color={0,127,255}));
  connect(JunctionConverge1.port_2, JunctionConverge.port_1)
    annotation (Line(points={{20,86},{-4,86}}, color={0,127,255}));
  connect(JunctionConverge1.port_3, val1.port_3) annotation (Line(points={{30,
          76},{28,76},{28,14},{24,14}}, color={0,127,255}));
  connect(pumpSup2.port_b, parallelValvesFlow.port_a)
    annotation (Line(points={{72,0},{122,0}}, color={0,127,255}));
  connect(parallelValvesFlow.port_b, hea.port_a)
    annotation (Line(points={{142.2,0},{150,0},{150,34}}, color={0,127,255}));
  connect(hea.port_b, JunctionConverge1.port_1)
    annotation (Line(points={{150,54},{150,86},{40,86}}, color={0,127,255}));
  connect(const1.y, hea.u) annotation (Line(points={{175,80},{178,80},{178,64},
          {134,64},{134,32},{144,32}}, color={0,0,127}));
  connect(const2.y, parallelValvesFlow.CoolingSignal) annotation (Line(points={
          {149,-90},{154,-90},{154,-16},{120,-16},{120,-8}}, color={0,0,127}));
  connect(const4.y, val1.y)
    annotation (Line(points={{13,-50},{24,-50},{24,-16.8}}, color={0,0,127}));
  connect(JunctionConverge.port_3, res.port_b)
    annotation (Line(points={{-14,76},{-16,76},{-16,52}}, color={0,127,255}));
  connect(res.port_a, JunctionDiverge.port_3)
    annotation (Line(points={{-16,32},{-16,10}}, color={0,127,255}));
  connect(pumpSup2.port_b, senRelPre.port_a) annotation (Line(points={{72,0},{
          88,0},{88,4},{108,4},{108,38}}, color={0,127,255}));
  connect(senRelPre.port_b, JunctionConverge1.port_1) annotation (Line(points={
          {108,58},{90,58},{90,76},{44,76},{44,86},{40,86}}, color={0,127,255}));
  connect(senRelPre.p_rel, conPID.u_m) annotation (Line(points={{117,48},{122,
          48},{122,28},{76,28}}, color={0,0,127}));
  connect(const3.y, conPID.u_s)
    annotation (Line(points={{53,40},{64,40}}, color={0,0,127}));
  connect(conPID.y, pumpSup2.y) annotation (Line(points={{87,40},{88,40},{88,12},
          {62,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end PrimarySecondary;
