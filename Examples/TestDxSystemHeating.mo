within CCC_test.Examples;
model TestDxSystemHeating
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.PressureDifference dp_nominal=1000
    "Pressure drop at m_flow_nominal";
  parameter Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.DXCoil datCoiHea(
    nSta=1,
    minSpeRat=0.2,
    sta={
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=16381.47714,
          COP_nominal=3.90494,
          m_flow_nominal=2,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
          Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I())},

    final defOpe=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostOperation.resistive,

    final defTri=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostTimeMethods.timed,

    final tDefRun=1/6,
    final TDefLim=273.65,
    final QDefResCap=10500,
    final QCraCap=200) "DX heating coil data record"
    annotation (Placement(transformation(extent={{70,38},{90,58}})));

  Buildings.Fluid.DXSystems.Heating.AirSource.SingleSpeed sinSpeDX(
    final datCoi=datCoiHea,
    redeclare package Medium = MediumAir,
    final dp_nominal=dp_nominal,
    final T_start=datCoiHea.sta[1].nomVal.TConIn_nominal,
    final show_T=true,
    final from_dp=true,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final dTHys=1e-6) "Single speed DX coil"
    annotation (Placement(transformation(extent={{32,-12},{52,8}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
    final p(displayUnit="Pa") = 101325,
    final T=303.15,
    final nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{130,-24},{110,-4}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    final use_T_in=true,
    final use_p_in=true,
    final nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-14,-82},{6,-62}})));
  Modelica.Blocks.Sources.BooleanStep onOff(final startTime=600)
    "Compressor on-off signal"
    annotation (Placement(transformation(extent={{-30,48},{-10,68}})));
  Modelica.Blocks.Sources.Ramp TConIn(
    final duration=600,
    final startTime=2400,
    final height=-3,
    final offset=273.15 + 23)
    "Temperature"
    annotation (Placement(transformation(extent={{-70,-82},{-50,-62}})));
  Modelica.Blocks.Sources.Ramp p(
    final duration=600,
    final startTime=600,
    final height=dp_nominal,
    final offset=101325) "Pressure"
    annotation (Placement(transformation(extent={{-70,-52},{-50,-32}})));
  Modelica.Blocks.Sources.Constant TEvaIn(final k=273.15 + 0)
    "Evaporator inlet temperature"
    annotation (Placement(transformation(extent={{-70,-16},{-50,4}})));
  Modelica.Blocks.Sources.Constant phi(final k=0.1)
    "Outside air relative humidity"
    annotation (Placement(transformation(extent={{-70,28},{-50,48}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumAir, m_flow_nominal=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={12,-36})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium
      = MediumAir, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{74,-12},{94,8}})));
equation
  connect(TConIn.y,sou. T_in) annotation (Line(
      points={{-49,-72},{-26,-72},{-26,-68},{-16,-68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(onOff.y,sinSpeDX. on)
                               annotation (Line(
      points={{-9,58},{24,58},{24,6},{31,6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p.y,sou. p_in) annotation (Line(
      points={{-49,-42},{-24,-42},{-24,-64},{-16,-64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEvaIn.y,sinSpeDX. TOut) annotation (Line(points={{-49,-6},{31,-6}},
                         color={0,0,127}));
  connect(sinSpeDX.phi,phi. y) annotation (Line(points={{31,-10},{-44,-10},{-44,
          38},{-49,38}},
                     color={0,0,127}));
  connect(sinSpeDX.port_b, senTem1.port_a)
    annotation (Line(points={{52,-2},{74,-2}}, color={0,127,255}));
  connect(senTem1.port_b, sin.ports[1]) annotation (Line(points={{94,-2},{104,
          -2},{104,-14},{110,-14}}, color={0,127,255}));
  connect(sinSpeDX.port_a, senTem.port_b) annotation (Line(points={{32,-2},{30,
          -2},{30,-12},{12,-12},{12,-26}}, color={0,127,255}));
  connect(senTem.port_a, sou.ports[1])
    annotation (Line(points={{12,-46},{12,-72},{6,-72}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestDxSystemHeating;
