within CCC_test.obsolete;
model CCC_HP_wTSup_ctr_07022024
  "Heat pump model for use with any heat pump data"
  replaceable package MediumAir =
      IBPSA.Media.Air "Medium model for air";
  replaceable package MediumWat =
      IBPSA.Media.Water "Medium model for water";

replaceable parameter IBPSA.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater datTabHea;
  replaceable parameter IBPSA.Fluid.Chillers.ModularReversible.Data.EuropeanNorm2D.Generic
    datTabCoo;
  replaceable parameter
    IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021 safCtrParEurNor;

 parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=12000
    "Nominal heat flow rate of radiator";

 parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal=0.575;
  parameter Modelica.Units.SI.MassFlowRate  mEva_flow_nominal=1.293;

  CCC.Fluid.HeatPumps.BaseClasses.ReversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration
    reversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration(
    redeclare package MediumCon = MediumWat,
    redeclare package MediumEva = MediumAir,
    QUse_flow_nominal=Q_flow_nominal,
    y_nominal=1,
    use_intSafCtr=false,
    TCon_nominal=333.15,
    dpCon_nominal=2000,
    TEva_nominal=sou.T,
    dpEva_nominal=2000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    datTabHea=datTabHea,
    datTabCoo=datTabCoo,
    safCtrParEurNor=safCtrParEurNor)
    annotation (Placement(transformation(extent={{6,36},{-14,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumWat)
    annotation (Placement(transformation(extent={{100,70},{120,90}}),
        iconTransformation(extent={{100,70},{120,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumWat)
    annotation (Placement(transformation(extent={{-120,68},{-100,88}}),
        iconTransformation(extent={{-120,68},{-100,88}})));
  IBPSA.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
                                      use_T_in=true, nPorts=1)
    annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));
  IBPSA.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
                                      use_T_in=true, nPorts=1)
    annotation (Placement(transformation(extent={{44,-4},{24,16}})));
  IBPSA.Fluid.Movers.FlowControlled_m_flow mov(redeclare package Medium =
        MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mEva_flow_nominal,
    dp_nominal=20000)                          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,36})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium =
        MediumWat, m_flow_nominal=mCon_flow_nominal)
                                                 annotation (Placement(
        transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={-40,75})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium =
        MediumWat, m_flow_nominal=mCon_flow_nominal)
                                                 annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={39,77})));
  Modelica.Blocks.Interfaces.RealInput TOutAir
    annotation (Placement(transformation(extent={{126,-46},{100,-20}}),
        iconTransformation(extent={{126,-46},{100,-20}})));
  Modelica.Blocks.Interfaces.BooleanInput IO
    annotation (Placement(transformation(extent={{-124,-16},{-100,8}}),
        iconTransformation(extent={{-124,-16},{-100,8}})));
  Modelica.Blocks.Interfaces.BooleanInput Mode "true=heating, false=cooling"
    annotation (Placement(transformation(extent={{124,8},{100,32}}),
        iconTransformation(extent={{124,8},{100,32}})));
  Modelica.Blocks.Sources.Constant const(k=mEva_flow_nominal)
    annotation (Placement(transformation(extent={{-90,28},{-70,48}})));
  Modelica.Blocks.Sources.Constant constTSetRooHea(final k=0)
    "Room set point temperature for heating"
    annotation (Placement(transformation(extent={{-74,-64},{-64,-54}})));
  Modelica.Blocks.Continuous.LimPID PIDHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=400,
    yMax=1,
    yMin=0)   "PI control for heating"
    annotation (Placement(transformation(extent={{-24,-16},{-4,4}})));
  Modelica.Blocks.Logical.Switch swiHeaCooYSet
    "Switch ySet for heating and cooling" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={22,-48},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (Placement(
        transformation(extent={{-124,-36},{-100,-12}}), iconTransformation(
          extent={{-122,-50},{-100,-28}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-132,10},{-112,30}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-140,-58},{-120,-38}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium =
        MediumAir, m_flow_nominal=mEva_flow_nominal) annotation (Placement(
        transformation(
        extent={{-7,-8},{7,8}},
        rotation=270,
        origin={22,25})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium =
        MediumAir, m_flow_nominal=mEva_flow_nominal) annotation (Placement(
        transformation(
        extent={{-7,-8},{7,8}},
        rotation=0,
        origin={-30,43})));
equation
  connect(sou.ports[1], mov.port_a) annotation (Line(points={{-46,8},{-48,8},{
          -48,26}},   color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration.port_b1,
    TWatSup.port_a)
    annotation (Line(points={{-14,54},{-40,54},{-40,68}}, color={0,127,255}));
  connect(TWatSup.port_b, port_b)
    annotation (Line(points={{-40,82},{-40,78},{-110,78}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration.port_a1,
    TWatRet.port_b)
    annotation (Line(points={{6,54},{39,54},{39,70}}, color={0,127,255}));
  connect(TWatRet.port_a, port_a)
    annotation (Line(points={{39,84},{39,80},{110,80}}, color={0,127,255}));
  connect(TOutAir, sin.T_in) annotation (Line(points={{113,-33},{56,-33},{56,10},
          {46,10}},  color={0,0,127}));
  connect(TOutAir,sou. T_in) annotation (Line(points={{113,-33},{-80,-33},{-80,12},
          {-68,12}},  color={0,0,127}));
  connect(const.y, mov.m_flow_in) annotation (Line(points={{-69,38},{-69,36},{
          -60,36}},    color={0,0,127}));
  connect(reversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration.hea,
    Mode) annotation (Line(points={{7.6,39},{94,39},{94,20},{112,20}}, color={
          255,0,255}));
  connect(IO, swiHeaCooYSet.u2) annotation (Line(points={{-112,-4},{-82,-4},{
          -82,-20},{-92,-20},{-92,-48},{10,-48}}, color={255,0,255}));
  connect(swiHeaCooYSet.u3, constTSetRooHea.y) annotation (Line(points={{10,-40},
          {10,-32},{-62,-32},{-62,-50},{-58,-50},{-58,-59},{-63.5,-59}},
                                                     color={0,0,127}));
  connect(PIDHea.y, swiHeaCooYSet.u1) annotation (Line(points={{-3,-6},{2,-6},{
          2,-56},{10,-56}}, color={0,0,127}));
  connect(swiHeaCooYSet.y,
    reversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration.ySet)
    annotation (Line(points={{33,-48},{38,-48},{38,-8},{14,-8},{14,50},{7.6,50}},
        color={0,0,127}));
  connect(TSupSet, switch1.u1) annotation (Line(points={{-112,-24},{-102,-24},{
          -102,28},{-134,28}}, color={0,0,127}));
  connect(TSupSet, switch2.u3) annotation (Line(points={{-112,-24},{-150,-24},{
          -150,-56},{-142,-56}}, color={0,0,127}));
  connect(TWatSup.T, switch1.u3) annotation (Line(points={{-48.8,75},{-150,75},
          {-150,12},{-134,12}}, color={0,0,127}));
  connect(TWatSup.T, switch2.u1) annotation (Line(points={{-48.8,75},{-52,75},{
          -52,52},{-96,52},{-96,-40},{-142,-40}}, color={0,0,127}));
  connect(switch1.y, PIDHea.u_s) annotation (Line(points={{-111,20},{-78,20},{
          -78,-6},{-26,-6}}, color={0,0,127}));
  connect(switch2.y, PIDHea.u_m) annotation (Line(points={{-119,-48},{-102,-48},
          {-102,-42},{-78,-42},{-78,-28},{-14,-28},{-14,-18}}, color={0,0,127}));
  connect(Mode, switch1.u2) annotation (Line(points={{112,20},{94,20},{94,40},{
          12,40},{12,16},{-42,16},{-42,22},{-100,22},{-100,38},{-142,38},{-142,
          20},{-134,20}}, color={255,0,255}));
  connect(Mode, switch2.u2) annotation (Line(points={{112,20},{94,20},{94,40},{
          12,40},{12,16},{-42,16},{-42,22},{-100,22},{-100,38},{-142,38},{-142,
          -22},{-152,-22},{-152,-48},{-142,-48}}, color={255,0,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration.port_b2,
    TAirSup.port_a)
    annotation (Line(points={{6,42},{22,42},{22,32}}, color={0,127,255}));
  connect(TAirSup.port_b, sin.ports[1])
    annotation (Line(points={{22,18},{22,6},{24,6}}, color={0,127,255}));
  connect(mov.port_b, TAirRet.port_a)
    annotation (Line(points={{-48,46},{-48,43},{-37,43}}, color={0,127,255}));
  connect(TAirRet.port_b,
    reversibleAirToWaterEuropeanNorm2D_CorrectedCoolingConfiguration.port_a2)
    annotation (Line(points={{-23,43},{-22,43},{-22,42},{-14,42}}, color={0,127,
          255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-60},{100,100}})), Icon(
        coordinateSystem(extent={{-100,-60},{100,100}}), graphics={
        Rectangle(
          extent={{-12,80},{12,-80}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          rotation=90,
          origin={0,78}),
        Line(
          points={{60,80},{-56,80}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled},
          thickness=0.5),
        Rectangle(
          extent={{-80,60},{80,-20}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,80},{12,-80}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={0,-38},
          rotation=90)}));
end CCC_HP_wTSup_ctr_07022024;
