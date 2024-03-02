within CCC_test.Examples;
model testVAVBox
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

  VAVBranch_ResistantReheatCoil              nor(
    redeclare package MediumA = MediumAir,
    redeclare package MediumW = MediumWater,
    m_flow_nominal=mNor_flow_nominal,
    VRoo=54)                             "North-facing thermal zone"
    annotation (Placement(transformation(extent={{-10,-2},{30,38}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=1,
    duration=4320,
    offset=0,
    startTime=2160)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 101325,
    T=285.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-46,-42})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    redeclare package Medium = MediumAir,
    per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10 + dpBuiStaSet,0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Supply air fan"
    annotation (Placement(transformation(extent={{-14,-56},{6,-36}})));

  Buildings.Fluid.Sources.Boundary_pT sinCoo1(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 101325,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,70})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=0.2,
    f=0.00046296296,
    offset=0.7)
    annotation (Placement(transformation(extent={{-80,38},{-60,58}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
equation
  connect(sinCoo.ports[1],fanSup. port_a) annotation (Line(points={{-36,-42},{-20,
          -42},{-20,-46},{-14,-46}},
                                 color={0,127,255}));
  connect(ramp.y,fanSup. y)
    annotation (Line(points={{-79,-20},{-4,-20},{-4,-34}},
                                                        color={0,0,127}));
  connect(fanSup.port_b, nor.port_a) annotation (Line(points={{6,-46},{18,-46},{
          18,-2},{0,-2}}, color={0,127,255}));
  connect(nor.port_b, sinCoo1.ports[1])
    annotation (Line(points={{0,38},{0,70},{20,70}}, color={0,127,255}));
  connect(sine.y, nor.yVAV) annotation (Line(points={{-59,48},{-24,48},{-24,26},
          {-14,26}}, color={0,0,127}));
  connect(const2.y, nor.yVal) annotation (Line(points={{-59,8},{-22,8},{-22,10},
          {-14,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testVAVBox;
