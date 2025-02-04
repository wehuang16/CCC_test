within CCC_test.TRC_troubleshooting;
model Aixlib_AirToWaterHeatPump_3D_fake
              replaceable package Medium_eva = Buildings.Media.Air;
  replaceable package Medium_con = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.MassFlowRate  mEva_flow_nominal=2.333;
  parameter Modelica.Units.SI.MassFlowRate  mCon_flow_nominal=0.92;
  parameter Modelica.Units.SI.PressureDifference  dp_nominal=100 "nominal pressure drop through each piece of equipment";
  replaceable model PerDataMainHP =
      CCC.Fluid.HeatPumps.BaseClasses.LookUpTableND_AirToWater (
        nConv=1,
        interpMethod=SDF.Types.InterpolationMethod.Akima,
        extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
        filename_Pel=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating.sdf",
        dataset_Pel="/elec_power",
        dataUnit_Pel="W",
        scaleUnits_Pel={"K","K",""},
        filename_QCon=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_heating.sdf",
        dataset_QCon="/condenser_heat",
        dataUnit_QCon="W",
        scaleUnits_QCon={"K","K",""})
  "Performance data of a heat pump in main operation mode";
  replaceable model PerDataRevHP =
      CCC.Fluid.Chillers.BaseClasses.LookUpTableND_AirToWater (
        nConv=1,
        interpMethod=SDF.Types.InterpolationMethod.Akima,
        extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
        filename_Pel=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_cooling.sdf",
        dataset_Pel="/elec_power",
        dataUnit_Pel="W",
        scaleUnits_Pel={"K","K",""},
        filename_QCon=
            "modelica://CCC/Resources/Data/Heat_Pump_Performance_Maps/heat_pump_performance_map_Aris_cooling.sdf",
        dataset_QCon="/evaporator_heat",
        dataUnit_QCon="W",
        scaleUnits_QCon={"K","K",""})
  "Performance data of a heat pump in reversible operation mode";

  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium_con) annotation (Placement(transformation(extent={{96,48},{116,68}}),
        iconTransformation(extent={{98,58},{118,78}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium_con) annotation (Placement(transformation(extent={{-112,46},{-92,
            66}}), iconTransformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (Placement(
        transformation(extent={{-126,-82},{-102,-58}}), iconTransformation(
          extent={{-122,-50},{-100,-28}})));
  Modelica.Blocks.Interfaces.BooleanInput Mode
    "Current operation mode: true: main operation mode, false: reversible operation mode"
    annotation (Placement(transformation(extent={{126,-14},{102,10}}),
        iconTransformation(extent={{124,8},{100,32}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium =
        Medium_con, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{56,46},{76,66}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium =
        Medium_con, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-56,74},{-36,94}})));
  Modelica.Blocks.Interfaces.RealInput TOutAir
    annotation (Placement(transformation(extent={{126,-58},{100,-32}}),
        iconTransformation(extent={{126,-46},{100,-20}})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-112,32}),
        iconTransformation(extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-112,20})));

  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium_con)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium_con,
    m_flow_nominal=mCon_flow_nominal,
    dp_nominal=dp_nominal,
    Q_flow_nominal=18500)
    annotation (Placement(transformation(extent={{-12,-22},{8,-2}})));
  Modelica.Blocks.Logical.Switch ModeSwitch1
    annotation (Placement(transformation(extent={{18,-122},{38,-102}})));
  Modelica.Blocks.Logical.Switch ModeSwitch
    annotation (Placement(transformation(extent={{-52,-42},{-32,-22}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{50,-52},{70,-32}})));
  Modelica.Blocks.Sources.Constant const(final k=0) annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={48,-176})));
  Modelica.Blocks.Logical.Switch OnOffSwitch
    annotation (Placement(transformation(extent={{84,-100},{104,-80}})));
  Modelica.Blocks.Logical.Switch ModeSwitch2
    annotation (Placement(transformation(extent={{32,110},{52,130}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-18,92},{2,112}})));
equation
  connect(TWatSup.port_b, port_b) annotation (Line(points={{76,56},{92,56},{92,58},
          {106,58}}, color={0,127,255}));
  connect(port_a, senMasFlo.port_a) annotation (Line(points={{-102,56},{-94,56},
          {-94,60},{-86,60}}, color={0,127,255}));
  connect(senMasFlo.port_b, TWatRet.port_a) annotation (Line(points={{-66,60},{
          -62,60},{-62,84},{-56,84}}, color={0,127,255}));
  connect(TWatRet.port_b, hea.port_a) annotation (Line(points={{-36,84},{-30,84},
          {-30,-14},{-12,-14},{-12,-12}}, color={0,127,255}));
  connect(hea.port_b, TWatSup.port_a) annotation (Line(points={{8,-12},{22,-12},
          {22,-14},{38,-14},{38,56},{56,56}}, color={0,127,255}));
  connect(TWatSup.T,ModeSwitch1. u1) annotation (Line(points={{66,67},{50,67},{
          50,88},{2,88},{2,-104},{16,-104}},      color={0,0,127}));
  connect(Mode,ModeSwitch1. u2) annotation (Line(points={{114,-2},{114,-24},{8,
          -24},{8,-112},{16,-112}},              color={255,0,255}));
  connect(TSupSet,ModeSwitch1. u3) annotation (Line(points={{-114,-70},{-114,
          -120},{16,-120}},       color={0,0,127}));
  connect(ModeSwitch1.y, conPID.u_m) annotation (Line(points={{39,-112},{42,
          -112},{42,-54},{60,-54}},  color={0,0,127}));
  connect(TSupSet,ModeSwitch. u1) annotation (Line(points={{-114,-70},{-114,-24},
          {-54,-24}},                               color={0,0,127}));
  connect(Mode, ModeSwitch1.u2) annotation (Line(points={{114,-2},{124,-2},{124,
          -124},{26,-124},{26,-112},{16,-112}},  color={255,0,255}));
  connect(TWatSup.T,ModeSwitch. u3) annotation (Line(points={{66,67},{66,72},{
          36,72},{36,-28},{-26,-28},{-26,-50},{-54,-50},{-54,-40}},
                                                color={0,0,127}));
  connect(conPID.y,OnOffSwitch. u1) annotation (Line(points={{71,-42},{82,-42},
          {82,-82}},          color={0,0,127}));
  connect(const.y,OnOffSwitch. u3) annotation (Line(points={{56.8,-176},{62,
          -176},{62,-98},{82,-98}},    color={0,0,127}));
  connect(Mode, ModeSwitch.u2) annotation (Line(points={{114,-2},{-84,-2},{-84,
          -32},{-54,-32}}, color={255,0,255}));
  connect(ModeSwitch.y, conPID.u_s) annotation (Line(points={{-31,-32},{40,-32},
          {40,-42},{48,-42}}, color={0,0,127}));
  connect(OnOff, OnOffSwitch.u2) annotation (Line(points={{-112,32},{-80,32},{
          -80,-90},{82,-90}}, color={255,0,255}));
  connect(Mode, ModeSwitch2.u2) annotation (Line(points={{114,-2},{132,-2},{132,
          2},{150,2},{150,146},{-6,146},{-6,120},{30,120}}, color={255,0,255}));
  connect(OnOffSwitch.y, ModeSwitch2.u1) annotation (Line(points={{105,-90},{
          132,-90},{132,-92},{172,-92},{172,162},{30,162},{30,128}}, color={0,0,
          127}));
  connect(gain.y, ModeSwitch2.u3) annotation (Line(points={{3,102},{22,102},{22,
          112},{30,112}}, color={0,0,127}));
  connect(OnOffSwitch.y, gain.u) annotation (Line(points={{105,-90},{156,-90},{
          156,-78},{192,-78},{192,178},{-44,178},{-44,102},{-20,102}}, color={0,
          0,127}));
  connect(ModeSwitch2.y, hea.u) annotation (Line(points={{53,120},{62,120},{62,
          118},{80,118},{80,14},{-14,14},{-14,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>In reverse operation mode, the condenser becomes the evaporator, and the evaporator becomes the condenser.</p>
</html>"));
end Aixlib_AirToWaterHeatPump_3D_fake;
