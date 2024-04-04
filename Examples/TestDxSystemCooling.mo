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
          Q_flow_nominal=-11412,
          COP_nominal=3.5982365827168037,
          SHR_nominal=0.8,
          m_flow_nominal=0.5578,
          TEvaIn_nominal=21 + 273.15),
        perCur=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Examples.PerformanceCurves.Curve_II(
          capFunT={1.008993521905866,0.006512749025457,0,0.003917565735935,-0.000222646705889,
            0},
          capFunFF={1,0,0,0},
          EIRFunT={0.429214441601141,-0.003604841598515,0.000045783162727,0.026490875804937,
            -0.000159212286878,-0.000159062656483},
          EIRFunFF={1,0,0,0},
          TEvaInMin=13.88 + 273.15,
          TEvaInMax=23.88 + 273.15))},
      nSta=1) "DX cooling coil data record"
    annotation (Placement(transformation(extent={{58,36},{78,56}})));
  Buildings.Fluid.DXSystems.Cooling.AirSource.VariableSpeed
                                                          sinSpeDX(
    redeclare package Medium = MediumAir,
    final dp_nominal=dp_nominal,
    final datCoi=datCoiCoo,
    final T_start=datCoiCoo.sta[1].nomVal.TEvaIn_nominal,
    final show_T=true,
    final from_dp=true,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Single speed DX coil"
    annotation (Placement(transformation(extent={{26,-20},{46,0}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = MediumAir,
    final p(displayUnit="Pa") = 101325,
    final nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{162,4},{142,24}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 101325,
    final use_T_in=true,
    final nPorts=1,
    final T=299.85)
    "Source"
    annotation (Placement(transformation(extent={{-78,-48},{-58,-28}})));
  Modelica.Blocks.Sources.BooleanStep onOff(final startTime=1800)
    "Compressor on-off signal"
    annotation (Placement(transformation(extent={{-40,34},{-20,54}})));
  Modelica.Blocks.Sources.Ramp TEvaIn(
    final duration=600,
    final startTime=2400,
    final height=-5,
    final offset=273.15 + 23)
    "Temperature"
    annotation (Placement(transformation(extent={{-112,-48},{-92,-28}})));
  Modelica.Blocks.Sources.Constant TConIn(final k=273.15 + 25)
    "Condenser inlet temperature"
    annotation (Placement(transformation(extent={{-80,14},{-60,34}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumAir, m_flow_nominal=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={4,-36})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        MediumAir, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{106,-32},{126,-12}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov(
    redeclare package Medium = MediumAir,
    redeclare Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW12 per,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-36})));
  Modelica.Blocks.Sources.Constant const(final k=1)
    annotation (Placement(transformation(extent={{-88,-18},{-68,2}})));
equation
  connect(TEvaIn.y,sou. T_in) annotation (Line(
      points={{-91,-38},{-84,-38},{-84,-34},{-80,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TConIn.y,sinSpeDX. TOut) annotation (Line(points={{-59,24},{-18,24},{-18,
          -7},{25,-7}},  color={0,0,127}));
  connect(senTem.port_b, sinSpeDX.port_a) annotation (Line(points={{14,-36},{20,
          -36},{20,-10},{26,-10}}, color={0,127,255}));
  connect(senTem1.port_b, sin.ports[1]) annotation (Line(points={{126,-22},{136,
          -22},{136,14},{142,14}},   color={0,127,255}));
  connect(sou.ports[1], mov.port_a) annotation (Line(points={{-58,-38},{-56,-38},
          {-56,-36},{-40,-36}}, color={0,127,255}));
  connect(mov.port_b, senTem.port_a)
    annotation (Line(points={{-20,-36},{-6,-36}}, color={0,127,255}));
  connect(const.y, mov.y)
    annotation (Line(points={{-67,-8},{-30,-8},{-30,-24}}, color={0,0,127}));
  connect(sinSpeDX.port_b, senTem1.port_a) annotation (Line(points={{46,-10},{100,
          -10},{100,-22},{106,-22}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestDxSystemCooling;
