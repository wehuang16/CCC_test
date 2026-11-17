within CCC_test.EvaporativeCooler.OpenTank.Validation;
model TankWithBlowdown
  extends Modelica.Icons.Example;
  replaceable package Medium = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.Height height=0.5 "Height of the tank";
  parameter Modelica.Units.SI.Area crossArea=2 "Cross-sectional area of the tank";
  parameter Modelica.Units.SI.Height level_target=0.15 "Target water level in the tank";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=2
    "Mass flow nominal";
  parameter Modelica.Units.SI.MassFlowRate mMakUp_flow_nominal=0.5
    "Make up water mass flow nominal";
  parameter Real cycCon=4
    "Cycle of concentration for blowdown";
  CCC_test.EvaporativeCooler.OpenTank.OpenTank tank(
    redeclare final package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    height=height,
    crossArea=crossArea,
    level_start=level_target,
    use_portsData=false,
    nPorts=3) "Open tank"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Fluid.System system(p_ambient=101325, T_ambient=293.15)
    "System-wide properties"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov(
    redeclare package Medium = Medium,
    per=per,
    addPowerToMedium=true)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,20})));
  parameter Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDro(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=20000)         "Pressure drop" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,10})));
  Buildings.Fluid.FixedResistances.Junction junBloDow(
    redeclare package Medium = Medium,
    m_flow_nominal={m_flow_nominal,-m_flow_nominal,-m_flow_nominal},
    dp_nominal={25,-25,-25}) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,50})));
  Buildings.Fluid.Sources.MassFlowSource_T MakUpWat(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=288.15,
    nPorts=1) "Make up water"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=tank.level)
    annotation (Placement(transformation(extent={{-220,-80},{-200,-60}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=
        mMakUp_flow_nominal)
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=1)
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  Buildings.Fluid.FixedResistances.Junction junEva(
    redeclare package Medium = Medium,
    m_flow_nominal={m_flow_nominal,-m_flow_nominal,-m_flow_nominal},
    dp_nominal={25,-25,-25}) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,110})));
  Modelica.Fluid.Sources.MassFlowSource_T sinEva(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=293.15,
    nPorts=1) "Mass flow sink for evaporative water" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,110})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=-0.02)
    annotation (Placement(transformation(extent={{100,122},{120,142}})));
  Modelica.Fluid.Sources.MassFlowSource_T sinBloDow(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=293.15,
    nPorts=1) "Mass flow sink for blowdown water" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,50})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=1/(cycCon - 1))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,50})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-102,-80},{-82,-60}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(
    uLow=level_target - 0.05,
    uHigh=level_target + 0.05,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{-180,-80},{-160,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
equation
  connect(tank.ports[1], mov.port_a) annotation (Line(points={{-1.33333,-10},{-1.33333,
          -20},{-50,-20},{-50,10}},
                          color={0,127,255}));
  connect(preDro.port_b, tank.ports[2]) annotation (Line(points={{30,0},{30,-12},
          {0,-12},{0,-10}}, color={0,127,255}));
  connect(junBloDow.port_2, preDro.port_a)
    annotation (Line(points={{30,40},{30,20}}, color={0,127,255}));
  connect(MakUpWat.ports[1], tank.ports[3]) annotation (Line(points={{-20,-50},
          {1.33333,-50},{1.33333,-10}}, color={0,127,255}));
  connect(gai.y, MakUpWat.m_flow_in)
    annotation (Line(points={{-48,-70},{-42,-70},{-42,-42}}, color={0,0,127}));
  connect(con1.y, mov.y)
    annotation (Line(points={{-98,20},{-62,20}}, color={0,0,127}));
  connect(mov.port_b, junEva.port_1) annotation (Line(points={{-50,30},{-50,142},
          {30,142},{30,120}}, color={0,127,255}));
  connect(junEva.port_2, junBloDow.port_1)
    annotation (Line(points={{30,100},{30,60}}, color={0,127,255}));
  connect(con2.y, sinEva.m_flow_in) annotation (Line(points={{122,132},{140,132},
          {140,102},{80,102}}, color={0,0,127}));
  connect(junEva.port_3, sinEva.ports[1])
    annotation (Line(points={{40,110},{60,110}}, color={0,127,255}));
  connect(junBloDow.port_3, sinBloDow.ports[1])
    annotation (Line(points={{40,50},{60,50}}, color={0,127,255}));
  connect(gai1.y, sinBloDow.m_flow_in) annotation (Line(points={{98,50},{90,50},
          {90,42},{80,42}}, color={0,0,127}));
  connect(con2.y, gai1.u) annotation (Line(points={{122,132},{140,132},{140,50},
          {122,50}}, color={0,0,127}));
  connect(booToRea.y, gai.u)
    annotation (Line(points={{-80,-70},{-72,-70}}, color={0,0,127}));
  connect(realExpression.y, hys.u) annotation (Line(points={{-199,-70},{-182,
          -70}},       color={0,0,127}));
  connect(hys.y, not1.u) annotation (Line(points={{-158,-70},{-142,-70}},
                       color={255,0,255}));
  connect(not1.y, booToRea.u) annotation (Line(points={{-118,-70},{-104,-70}},
                 color={255,0,255}));
  annotation (experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TankWithBlowdown;
