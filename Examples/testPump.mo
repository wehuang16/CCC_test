within CCC_test.Examples;
model testPump
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1.0*(
      mCor_flow_nominal + mSou_flow_nominal + mNor_flow_nominal +
      mPle_flow_nominal) "Nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mCor_flow_nominal=0.130*1.2
    "*1.2Design mass flow rate core";
  parameter Modelica.Units.SI.MassFlowRate mSou_flow_nominal=0.2313*1.2
    "*1.2Design mass flow rate perimeter 1";
  parameter Modelica.Units.SI.MassFlowRate mPle_flow_nominal=0.03*1.2
    "Design mass flow rate perimeter 2";
  parameter Modelica.Units.SI.MassFlowRate mNor_flow_nominal=0.130*1.2
    "*1.2Design mass flow rate perimeter 3";

      parameter Modelica.Units.SI.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";




  Modelica.Blocks.Sources.Constant const1(k=0.06393)
    annotation (Placement(transformation(extent={{-76,60},{-56,80}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=1,
    duration=4320,
    offset=0,
    startTime=2160)
    annotation (Placement(transformation(extent={{-100,22},{-80,42}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    redeclare package Medium = MediumAir,
    per(pressure(V_flow={0,1/1.2}, dp={200,0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Supply air fan"
    annotation (Placement(transformation(extent={{-14,-12},{6,8}})));

  Buildings.Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa"),
    T=285.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-46,2})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo1(redeclare package Medium =
        MediumAir,
    p(displayUnit="Pa"),
                   nPorts=1)
              "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={82,6})));
  Buildings.Fluid.FixedResistances.PressureDrop dpRetDuc1(
    dp_nominal=20,
    m_flow_nominal=0.5,
    redeclare package Medium = MediumAir)
                   "Pressure drop for return duct"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={36,-2})));
  Buildings.Fluid.Sensors.RelativePressure dpDisSupFan(redeclare package Medium =
        MediumAir) "Supply fan static discharge pressure"
                                                        annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={38,36})));
  Buildings.Fluid.Sensors.RelativePressure dpfan(redeclare package Medium =
        MediumAir) "Supply fan static discharge pressure" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-10,46})));
equation
  connect(ramp.y, fanSup.y)
    annotation (Line(points={{-79,32},{-4,32},{-4,10}}, color={0,0,127}));
  connect(sinCoo.ports[1], fanSup.port_a) annotation (Line(points={{-36,2},{-20,
          2},{-20,-2},{-14,-2}}, color={0,127,255}));
  connect(fanSup.port_b, dpRetDuc1.port_a)
    annotation (Line(points={{6,-2},{26,-2}}, color={0,127,255}));
  connect(dpRetDuc1.port_b, sinCoo1.ports[1]) annotation (Line(points={{46,-2},
          {66,-2},{66,6},{72,6}}, color={0,127,255}));
  connect(dpDisSupFan.port_a, dpRetDuc1.port_a) annotation (Line(points={{28,36},
          {20,36},{20,-2},{26,-2}}, color={0,127,255}));
  connect(dpDisSupFan.port_b, dpRetDuc1.port_b) annotation (Line(points={{48,36},
          {52,36},{52,-2},{46,-2}}, color={0,127,255}));
  connect(dpfan.port_a, fanSup.port_a) annotation (Line(points={{-20,46},{-24,
          46},{-24,2},{-20,2},{-20,-2},{-14,-2}}, color={0,127,255}));
  connect(dpfan.port_b, fanSup.port_b) annotation (Line(points={{0,46},{12,46},
          {12,-2},{6,-2}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPump;
