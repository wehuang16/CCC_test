within CCC_test.Examples;
model ArisMultiFamily2Test
    extends Modelica.Icons.Example;
  extends obsolete_eas_e.ArisHeatPumpConfiguration;

  extends CCC_test.Baseclasses.ArisWaterTankGroup;

  Modelica.Fluid.Sources.Boundary_pT hpPump2ab(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=325.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-98,-30})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp2ab(redeclare package Medium =
        MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-220})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumpHpSupply1ab(redeclare
      package Medium = MediumPropyleneGlycol, m_flow_nominal=1) "pump"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={122,-286})));
  Modelica.Blocks.Sources.Constant const5ab(k=0.5)
    annotation (Placement(transformation(extent={{62,-306},{82,-286}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol,
    T_start=303.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{244,-290},{264,-270}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp3ab(redeclare package Medium =
        MediumPropyleneGlycol) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={284,-298})));
  Modelica.Fluid.Sources.Boundary_pT hpPump3ab(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={316,-270})));
  Modelica.Blocks.Sources.Constant const4ab(k=0)
    annotation (Placement(transformation(extent={{134,-246},{154,-226}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2
    annotation (Placement(transformation(extent={{-138,80},{-118,100}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant3(k=false)
    annotation (Placement(transformation(extent={{-136,48},{-116,68}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant4(k=false)
    annotation (Placement(transformation(extent={{-134,18},{-114,38}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-136,-14},{-116,6}})));
  Modelica.Blocks.Sources.Constant        const(k=273.15 + 15)
    annotation (Placement(transformation(extent={{24,92},{44,112}})));
equation
  connect(flowRouterSupply.port_b1, jun2.port_1) annotation (Line(points={{140.6,
          -44.2},{150,-44.2},{150,-66},{-82,-66},{-82,-100},{-74,-100}}, color={
          0,127,255}));
  connect(hpPump2ab.ports[1], flowRouterReturn.port_a) annotation (Line(points={
          {-88,-30},{-36,-30},{-36,-46},{-12.4,-46}}, color={0,127,255}));
  connect(const4ab.y, conservationEquation.Q_flow) annotation (Line(points={{155,
          -236},{232,-236},{232,-274},{242,-274}}, color={0,0,127}));
  connect(temp3ab.port_b, hpPump3ab.ports[1]) annotation (Line(points={{294,-298},
          {300,-298},{300,-270},{306,-270}}, color={0,127,255}));
  connect(pumpHpSupply1ab.port_b, conservationEquation.ports[1]) annotation (
      Line(points={{132,-286},{238,-286},{238,-296},{253,-296},{253,-290}},
        color={0,127,255}));
  connect(conservationEquation.ports[2], temp3ab.port_a) annotation (Line(
        points={{255,-290},{255,-298},{274,-298}}, color={0,127,255}));
  connect(const5ab.y, pumpHpSupply1ab.m_flow_in) annotation (Line(points={{83,-296},
          {106,-296},{106,-266},{122,-266},{122,-274}}, color={0,0,127}));
  connect(temp2ab.port_b, pumpHpSupply1ab.port_a) annotation (Line(points={{100,
          -230},{100,-286},{112,-286}}, color={0,127,255}));
  connect(flowRouterSupply.port_b, temp2ab.port_a) annotation (Line(points={{140.4,
          -33.6},{192,-33.6},{192,-210},{100,-210}}, color={0,127,255}));
  connect(booleanConstant2.y, hpModeSelector.ModeHp1) annotation (Line(points={
          {-117,90},{-72,90},{-72,66},{-67,66}}, color={255,0,255}));
  connect(booleanConstant3.y, hpModeSelector.ModeHp2) annotation (Line(points={
          {-115,58},{-78,58},{-78,63},{-67,63}}, color={255,0,255}));
  connect(booleanConstant4.y, hpModeSelector.ModeHp3) annotation (Line(points={
          {-113,28},{-78,28},{-78,56},{-76,56},{-76,59.8},{-67.2,59.8}}, color=
          {255,0,255}));
  connect(booleanConstant1.y, hpModeSelector.SpaceConditioningMode) annotation (
     Line(points={{-115,-4},{-74,-4},{-74,44},{-76,44},{-76,52.6},{-68,52.6}},
        color={255,0,255}));
  connect(const.y, TOut1.u) annotation (Line(points={{45,102},{82,102},{82,100},
          {124,100},{124,60},{110,60}}, color={0,0,127}));
  connect(flowConstraintBreaker.port_b, flowRouterReturn.port_a1) annotation (
      Line(points={{-118,-235.6},{-134,-235.6},{-134,-214},{-148,-214},{-148,
          -51.4},{-12.4,-51.4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ArisMultiFamily2Test;
