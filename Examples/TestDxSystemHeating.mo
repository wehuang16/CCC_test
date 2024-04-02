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
    minSpeRat=0.3015873015873016,
    sta={
        Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.DXSystems.Heating.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=12356,
          COP_nominal=4.443036565080653,
          m_flow_nominal=0.5684,
          TEvaIn_nominal=273.15 - 5,
          TConIn_nominal=273.15 + 21),
        perCur=
          Buildings.Fluid.DXSystems.Heating.AirSource.Examples.PerformanceCurves.Curve_I(
          capFunT={1.119274275,-0.010386676170938,0,0.012,0,0},
          capFunFF={1,0,0,0},
          EIRFunT={0.966475472847719,0.005914950101249,0.000191201688297,-0.012965668198361,
            0.000042253229429,-0.000524002558712},
          EIRFunFF={1,0,0},
          TConInMin=-100 + 273.15,
          TConInMax=100 + 273.15,
          TEvaInMin=-34.4 + 273.15,
          TEvaInMax=40 + 273.15))},
    final defOpe=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostOperation.reverseCycle,

    final defTri=Buildings.Fluid.DXSystems.Heating.BaseClasses.Types.DefrostTimeMethods.onDemand,
    final tDefRun=1/6,
    final TDefLim=277.59444444444,
    final QDefResCap=10500,
    final QCraCap=0,
    defEIRFunT={0.1528,0,0,0,0,0})
                       "DX heating coil data record"
    annotation (Placement(transformation(extent={{70,38},{90,58}})));

  Buildings.Fluid.DXSystems.Heating.AirSource.SingleSpeed sinSpeDX(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final datCoi=datCoiHea,
    redeclare package Medium = MediumAir,
    final dp_nominal=dp_nominal,
    final T_start=datCoiHea.sta[1].nomVal.TConIn_nominal,
    final show_T=true,
    final from_dp=true,
    final dTHys=1e-6) "Single speed DX coil"
    annotation (Placement(transformation(extent={{32,-12},{52,8}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
    final p(displayUnit="Pa") = 101325,
    final nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{130,-24},{110,-4}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 101325,
    final use_T_in=true,
    final nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-74,-68},{-54,-48}})));
  Modelica.Blocks.Sources.BooleanStep onOff(final startTime=600)
    "Compressor on-off signal"
    annotation (Placement(transformation(extent={{-30,48},{-10,68}})));
  Modelica.Blocks.Sources.Ramp TConIn(
    final duration=600,
    final startTime=2400,
    final height=0,
    final offset=273.15 + 23)
    "Temperature"
    annotation (Placement(transformation(extent={{-114,-74},{-94,-54}})));
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
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        MediumAir, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{74,-12},{94,8}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov(
    redeclare package Medium = MediumAir,
    redeclare Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW12 per,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,-58})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-0.03,
    duration=2700,
    offset=0.15)
    annotation (Placement(transformation(extent={{-112,-42},{-92,-22}})));
equation
  connect(TConIn.y,sou. T_in) annotation (Line(
      points={{-93,-64},{-84,-64},{-84,-54},{-76,-54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(onOff.y,sinSpeDX. on)
                               annotation (Line(
      points={{-9,58},{24,58},{24,6},{31,6}},
      color={255,0,255},
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
  connect(senTem.port_a, mov.port_b)
    annotation (Line(points={{12,-46},{12,-58},{-10,-58}}, color={0,127,255}));
  connect(mov.port_a, sou.ports[1])
    annotation (Line(points={{-30,-58},{-54,-58}}, color={0,127,255}));
  connect(ramp.y, mov.y)
    annotation (Line(points={{-91,-32},{-20,-32},{-20,-46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestDxSystemHeating;
