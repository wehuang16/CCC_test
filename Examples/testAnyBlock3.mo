within CCC_test.Examples;
model testAnyBlock3
              package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  Modelica.Blocks.Sources.BooleanConstant
                                   booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-154,48},{-134,68}})));
  Modelica.Blocks.Sources.Constant WaterHeaterHeatPumpSetpoint(k=273.15 + 65)
    annotation (Placement(transformation(extent={{-118,-14},{-98,6}})));
  Modelica.Blocks.Sources.Sine     sine(
    amplitude=1,
    f=0.00004629629,
    offset=0.5)
    annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = MediumWater,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    Q_flow_nominal=3500) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,16})));
  Buildings.Fluid.Sensors.MassFlowRate MasFloHeaPum(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,44})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumSupTem(redeclare package
      Medium = MediumWater, m_flow_nominal=1)
    "HeatPumpSupplyTemperature"
    annotation (Placement(transformation(extent={{-4,58},{16,78}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    VTan=0.302833,
    hTan=1.2,
    dIns=0.05,
    nSeg=5,
    T_start=313.15,
    tau=1)  annotation (Placement(transformation(extent={{22,-22},{42,-2}})));
  Buildings.Fluid.Movers.SpeedControlled_y mov(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-18,-24})));
  Buildings.Fluid.Sensors.TemperatureTwoPort HeaPumRetTem(redeclare package
      Medium = MediumWater, m_flow_nominal=1)              "HeatPumpReturnTemp"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={6,-40})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-76,-18},{-56,2}})));
equation
  connect(mov.port_a, HeaPumRetTem.port_b) annotation (Line(points={{-18,-34},{
          -10,-34},{-10,-40},{-4,-40}}, color={0,127,255}));
  connect(mov.port_b, hea.port_a) annotation (Line(points={{-18,-14},{-18,-4},{
          -12,-4},{-12,6}}, color={0,127,255}));
  connect(MasFloHeaPum.port_a, hea.port_b)
    annotation (Line(points={{-12,34},{-12,26}}, color={0,127,255}));
  connect(MasFloHeaPum.port_b, HeaPumSupTem.port_a)
    annotation (Line(points={{-12,54},{-12,68},{-4,68}}, color={0,127,255}));
  connect(HeaPumSupTem.port_b, tan.port_a) annotation (Line(points={{16,68},{20,
          68},{20,2},{18,2},{18,-12},{22,-12}}, color={0,127,255}));
  connect(tan.port_b, HeaPumRetTem.port_a) annotation (Line(points={{42,-12},{
          46,-12},{46,-40},{16,-40}}, color={0,127,255}));
  connect(HeaPumSupTem.T,conPID. u_m) annotation (Line(points={{6,79},{6,82},{
          -50,82},{-50,-30},{-66,-30},{-66,-20}},color={0,0,127}));
  connect(conPID.y, mov.y) annotation (Line(points={{-55,-8},{-40,-8},{-40,-24},
          {-30,-24}}, color={0,0,127}));
  connect(WaterHeaterHeatPumpSetpoint.y, conPID.u_s) annotation (Line(points={{
          -97,-4},{-86,-4},{-86,-8},{-78,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end testAnyBlock3;
