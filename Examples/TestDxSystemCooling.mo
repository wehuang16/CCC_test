within CCC_test.Examples;
model TestDxSystemCooling
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.PressureDifference dp_nominal=1000
    "Pressure drop at m_flow_nominal";

  parameter Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.DXCoil datCoiCoo(sta={
        Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-21000,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=1.5),
        perCur=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Examples.PerformanceCurves.Curve_II())},
      nSta=1) "DX cooling coil data record"
    annotation (Placement(transformation(extent={{58,36},{78,56}})));
  Buildings.Fluid.DXSystems.Cooling.AirSource.SingleSpeed sinSpeDX(
    redeclare package Medium = MediumAir,
    final dp_nominal=dp_nominal,
    final datCoi=datCoiCoo,
    final T_start=datCoiCoo.sta[1].nomVal.TEvaIn_nominal,
    final show_T=true,
    final from_dp=true,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Single speed DX coil"
    annotation (Placement(transformation(extent={{50,-22},{70,-2}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
    final p(displayUnit="Pa") = 101325,
    final nPorts=1,
    final T=303.15)
    "Sink"
    annotation (Placement(transformation(extent={{134,-38},{114,-18}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 101325 + dp_nominal,
    final use_T_in=true,
    final nPorts=1,
    final use_p_in=true,
    final T=299.85)
    "Source"
    annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
  Modelica.Blocks.Sources.BooleanStep onOff(final startTime=600)
    "Compressor on-off signal"
    annotation (Placement(transformation(extent={{-40,34},{-20,54}})));
  Modelica.Blocks.Sources.Ramp TEvaIn(
    final duration=600,
    final startTime=2400,
    final height=-5,
    final offset=273.15 + 23)
    "Temperature"
    annotation (Placement(transformation(extent={{-80,-66},{-60,-46}})));
  Modelica.Blocks.Sources.Ramp p(
    final duration=600,
    final startTime=600,
    final height=dp_nominal,
    final offset=101325)
    "Pressure"
    annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Modelica.Blocks.Sources.Constant TConIn(final k=273.15 + 25)
    "Condenser inlet temperature"
    annotation (Placement(transformation(extent={{-80,14},{-60,34}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumAir, m_flow_nominal=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,-36})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium
      = MediumAir, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{82,-32},{102,-12}})));
equation
  connect(TEvaIn.y,sou. T_in) annotation (Line(
      points={{-59,-56},{-32,-56},{-32,-32},{-22,-32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(onOff.y,sinSpeDX. on)
                               annotation (Line(
      points={{-19,44},{44,44},{44,-4},{49,-4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p.y,sou. p_in) annotation (Line(
      points={{-59,-16},{-30,-16},{-30,-28},{-22,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TConIn.y,sinSpeDX. TOut) annotation (Line(points={{-59,24},{42,24},{
          42,-9},{49,-9}},
                         color={0,0,127}));
  connect(sou.ports[1], senTem.port_a)
    annotation (Line(points={{0,-36},{10,-36}}, color={0,127,255}));
  connect(senTem.port_b, sinSpeDX.port_a) annotation (Line(points={{30,-36},{44,
          -36},{44,-12},{50,-12}}, color={0,127,255}));
  connect(sinSpeDX.port_b, senTem1.port_a) annotation (Line(points={{70,-12},{
          76,-12},{76,-22},{82,-22}}, color={0,127,255}));
  connect(senTem1.port_b, sin.ports[1]) annotation (Line(points={{102,-22},{106,
          -22},{106,-28},{114,-28}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestDxSystemCooling;
