within CCC_test.Examples;
model TestDxSystemCoolingVariable
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.PressureDifference dp_nominal=1000
    "Pressure drop at m_flow_nominal";

  parameter
    Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.DXCoil
    datCoi(nSta=4, sta={
        Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.Stage(
        spe=900/60,
        nomVal=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-12000,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=0.9),
        perCur=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Examples.PerformanceCurves.Curve_I()),
        Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1200/60,
        nomVal=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-18000,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=1.2),
        perCur=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Examples.PerformanceCurves.Curve_I()),
        Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-21000,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=1.5),
        perCur=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Examples.PerformanceCurves.Curve_II()),
        Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.Stage(
        spe=2400/60,
        nomVal=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Data.Generic.BaseClasses.NominalValues(
          Q_flow_nominal=-30000,
          COP_nominal=3,
          SHR_nominal=0.8,
          m_flow_nominal=1.8),
        perCur=
          Buildings.Fluid.DXSystems.Cooling.AirSource.Examples.PerformanceCurves.Curve_III())})
    "Coil data"
    annotation (Placement(transformation(extent={{76,40},{96,60}})));
  Buildings.Fluid.DXSystems.Cooling.AirSource.VariableSpeed
    varSpeDX(
    redeclare package Medium = MediumAir,
    final dp_nominal=dp_nominal,
    final datCoi=datCoi,
    final minSpeRat=datCoi.minSpeRat,
    final T_start=datCoi.sta[1].nomVal.TEvaIn_nominal,
    final from_dp=true,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Variable speed DX coil"
    annotation (Placement(transformation(extent={{84,-10},{104,10}})));
  Modelica.Blocks.Sources.TimeTable speRat(final table=[0.0,0.0; 100,0.0; 900,
        0.2; 1800,0.8; 2700,0.75; 3600,0.75])
    "Speed ratio "
    annotation (Placement(transformation(extent={{-68,30},{-48,50}})));
  Modelica.Blocks.Sources.Constant TConIn(final k=273.15 + 25)
    "Condenser inlet temperature"
    annotation (Placement(transformation(extent={{-84,0},{-64,20}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        MediumAir, m_flow_nominal=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={36,0})));
  Modelica.Blocks.Sources.Constant const(final k=1)
    annotation (Placement(transformation(extent={{-88,-38},{-68,-18}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov(
    redeclare package Medium = MediumAir,
    redeclare Buildings.Fluid.Movers.Data.Fans.Greenheck.BIDW12 per,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-56})));
  Buildings.Fluid.Sources.Boundary_pT sou1(
    redeclare package Medium = MediumAir,
    p(displayUnit="Pa") = 101325,
    final use_T_in=true,
    final nPorts=1,
    final T=299.85)
    "Source"
    annotation (Placement(transformation(extent={{-78,-68},{-58,-48}})));
  Modelica.Blocks.Sources.Ramp TEvaIn1(
    final duration=600,
    final startTime=2400,
    final height=-5,
    final offset=273.15 + 23)
    "Temperature"
    annotation (Placement(transformation(extent={{-112,-68},{-92,-48}})));
  Buildings.Fluid.Sources.Boundary_pT sin1(
    redeclare package Medium = MediumAir,
    final p(displayUnit="Pa") = 101325,
    final nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{146,-48},{126,-28}})));
equation
  connect(speRat.y,varSpeDX. speRat)   annotation (Line(
      points={{-47,40},{72,40},{72,8},{83,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varSpeDX.TOut,TConIn. y) annotation (Line(
      points={{83,3},{-58,3},{-58,10},{-63,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem.port_b, varSpeDX.port_a)
    annotation (Line(points={{46,0},{84,0}}, color={0,127,255}));
  connect(TEvaIn1.y, sou1.T_in) annotation (Line(points={{-91,-58},{-84,-58},{
          -84,-54},{-80,-54}}, color={0,0,127}));
  connect(sou1.ports[1], mov.port_a) annotation (Line(points={{-58,-58},{-58,
          -56},{-40,-56}}, color={0,127,255}));
  connect(const.y, mov.y)
    annotation (Line(points={{-67,-28},{-30,-28},{-30,-44}}, color={0,0,127}));
  connect(mov.port_b, senTem.port_a) annotation (Line(points={{-20,-56},{20,-56},
          {20,0},{26,0}}, color={0,127,255}));
  connect(varSpeDX.port_b, sin1.ports[1]) annotation (Line(points={{104,0},{120,
          0},{120,-38},{126,-38}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestDxSystemCoolingVariable;
