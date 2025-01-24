within CCC_test.CCC_Model;
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
  AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con = Medium_con,
    redeclare package Medium_eva = Medium_eva,
    use_refIne=false,
    mFlow_conNominal=mCon_flow_nominal,
    VCon=0.05,
    dpCon_nominal=dp_nominal,
    mFlow_evaNominal=mEva_flow_nominal,
    VEva=0.05,
    dpEva_nominal=dp_nominal,
    redeclare model PerDataMainHP =
        PerDataMainHP,
    redeclare model PerDataRevHP = PerDataRevHP,
    useBusConnectorOnly=true,
    use_conCap=false,
    use_evaCap=false)
    annotation (Placement(transformation(extent={{-12,24},{8,48}})));

  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={0,-14})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
    annotation (Placement(transformation(extent={{30,-34},{60,0}}),
        iconTransformation(extent={{-22,30},{-4,56}})));
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
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium =
        Medium_eva, m_flow_nominal=1)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,18})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium =
        Medium_eva, m_flow_nominal=1)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-66,6})));
  Modelica.Blocks.Logical.Switch ModeSwitch
    annotation (Placement(transformation(extent={{-54,-52},{-34,-32}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-8,-72},{12,-52}})));
  Modelica.Blocks.Logical.Switch ModeSwitch1
    annotation (Placement(transformation(extent={{-12,-142},{8,-122}})));
  Modelica.Blocks.Interfaces.RealInput TOutAir
    annotation (Placement(transformation(extent={{126,-58},{100,-32}}),
        iconTransformation(extent={{126,-46},{100,-20}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     boundary3(
    redeclare package Medium = Medium_eva,
    addPowerToMedium=false,
    m_flow_nominal=mEva_flow_nominal)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={88,-75})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = Medium_eva,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-122,-21})));
  Modelica.Blocks.Sources.Constant const1(k=mEva_flow_nominal)
    annotation (Placement(transformation(extent={{134,-18},{154,2}})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-112,32}),
        iconTransformation(extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-112,20})));
  Modelica.Blocks.Logical.Switch OnOffSwitch
    annotation (Placement(transformation(extent={{36,-78},{56,-58}})));
  Modelica.Blocks.Sources.Constant const(final k=0) annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={26,-98})));

  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium_con)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.0001, uHigh=0.0002)
    annotation (Placement(transformation(extent={{-200,6},{-180,26}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{-146,-2},{-126,18}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false)
    annotation (Placement(transformation(extent={{-202,-30},{-182,-10}})));
  Modelica.Blocks.Interfaces.RealOutput QCon
    "Name is a bit confusing, but this represents the useful heat flow of the heat exchanger: this will be condenser hear flow for heating, and evaporator heat flow for cooling"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-74,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-85,111})));
  Modelica.Blocks.Interfaces.RealOutput QEva
    "Name is a bit confusing, but this represents the non-useful heat flow of the heat exchanger: this will be evaporator hear flow for heating, and condenser heat flow for cooling"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-50,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-53,111})));
  Modelica.Blocks.Interfaces.RealOutput Pel
    "electricity consumption of the heat pump" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-22,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-19,111})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=heatPump.innerCycle.QCon)
    annotation (Placement(transformation(extent={{-170,104},{-150,124}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=heatPump.innerCycle.QEva)
    annotation (Placement(transformation(extent={{-102,126},{-82,146}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=heatPump.innerCycle.Pel)
    annotation (Placement(transformation(extent={{-36,126},{-16,146}})));
  Modelica.Blocks.Interfaces.RealOutput QHeating
    "Heat pump thermal power during heating mode. Zero if in cooling mode."
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={28,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={31,111})));
  Modelica.Blocks.Interfaces.RealOutput QCooling
    "Heat pump thermal power during cooling mode. Zero if in heating mode."
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={60,112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={59,111})));
  CCC.Controls.SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{-138,82},{-118,102}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Medium_eva,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={142,-73})));
  Modelica.Blocks.Logical.Switch EvaFanOnOff
    annotation (Placement(transformation(extent={{58,-162},{78,-142}})));
  Modelica.Blocks.Sources.Constant const2(final k=0)
                                                    annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={22,-168})));
  Modelica.Blocks.Interfaces.RealOutput EvaFanPow
    "electricity consumption of the evaporator fan" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={64,-112}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=270,
        origin={65,-111})));
equation
  connect(sigBus1,heatPump. sigBus) annotation (Line(
      points={{45,-17},{45,20},{-18,20},{-18,32.1},{-11.9,32.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFac.y,sigBus1. iceFacMea) annotation (Line(points={{8.8,-14},{26,
          -14},{26,-16.915},{45.075,-16.915}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Mode, sigBus1.modeSet) annotation (Line(points={{114,-2},{66,-2},{66,-16.915},
          {45.075,-16.915}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TWatRet.port_b, heatPump.port_a1) annotation (Line(points={{-36,84},{
          -26,84},{-26,42},{-12,42}},
                                  color={0,127,255}));
  connect(heatPump.port_b1, TWatSup.port_a) annotation (Line(points={{8,42},{50,
          42},{50,56},{56,56}}, color={0,127,255}));
  connect(TWatSup.port_b, port_b) annotation (Line(points={{76,56},{92,56},{92,58},
          {106,58}}, color={0,127,255}));
  connect(heatPump.port_a2, TAirRet.port_b) annotation (Line(points={{8,30},{54,
          30},{54,18},{60,18}}, color={0,127,255}));
  connect(heatPump.port_b2, TAirSup.port_a) annotation (Line(points={{-12,30},{
          -50,30},{-50,6},{-56,6}},
                                color={0,127,255}));
  connect(TSupSet, ModeSwitch.u1) annotation (Line(points={{-114,-70},{-88,-70},
          {-88,-30},{-66,-30},{-66,-34},{-56,-34}}, color={0,0,127}));
  connect(TSupSet, ModeSwitch1.u3) annotation (Line(points={{-114,-70},{-80,-70},
          {-80,-140},{-14,-140}}, color={0,0,127}));
  connect(TWatSup.T, ModeSwitch.u3) annotation (Line(points={{66,67},{14,67},{
          14,68},{-46,68},{-46,-50},{-56,-50}}, color={0,0,127}));
  connect(TWatSup.T, ModeSwitch1.u1) annotation (Line(points={{66,67},{20,67},{
          20,68},{-28,68},{-28,-124},{-14,-124}}, color={0,0,127}));
  connect(ModeSwitch.y, conPID.u_s) annotation (Line(points={{-33,-42},{-20,-42},
          {-20,-62},{-10,-62}}, color={0,0,127}));
  connect(ModeSwitch1.y, conPID.u_m) annotation (Line(points={{9,-132},{12,-132},
          {12,-76},{2,-76},{2,-74}}, color={0,0,127}));
  connect(Mode, ModeSwitch.u2) annotation (Line(points={{114,-2},{76,-2},{76,
          -44},{-56,-44},{-56,-42}}, color={255,0,255}));
  connect(Mode, ModeSwitch1.u2) annotation (Line(points={{114,-2},{76,-2},{76,
          -44},{-22,-44},{-22,-132},{-14,-132}}, color={255,0,255}));
  connect(TAirSup.port_b, boundary4.ports[1]) annotation (Line(points={{-76,6},{
          -98,6},{-98,-21},{-112,-21}}, color={0,127,255}));
  connect(OnOffSwitch.y, sigBus1.nSet) annotation (Line(points={{57,-68},{62,
          -68},{62,-38},{45.075,-38},{45.075,-16.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID.y, OnOffSwitch.u1) annotation (Line(points={{13,-62},{16,-62},
          {16,-60},{34,-60}}, color={0,0,127}));
  connect(const.y, OnOffSwitch.u3) annotation (Line(points={{34.8,-98},{38,-98},
          {38,-84},{34,-84},{34,-76}}, color={0,0,127}));
  connect(port_a, senMasFlo.port_a) annotation (Line(points={{-102,56},{-94,56},
          {-94,60},{-86,60}}, color={0,127,255}));
  connect(senMasFlo.port_b, TWatRet.port_a) annotation (Line(points={{-66,60},{
          -62,60},{-62,84},{-56,84}}, color={0,127,255}));
  connect(senMasFlo.m_flow, hysteresis.u) annotation (Line(points={{-76,71},{
          -76,74},{-212,74},{-212,16},{-202,16}}, color={0,0,127}));
  connect(hysteresis.y, logicalSwitch.u2) annotation (Line(points={{-179,16},{
          -166,16},{-166,8},{-148,8}}, color={255,0,255}));
  connect(logicalSwitch.u1, OnOff) annotation (Line(points={{-148,16},{-154,16},
          {-154,32},{-112,32}}, color={255,0,255}));
  connect(logicalSwitch.y, OnOffSwitch.u2) annotation (Line(points={{-125,8},{
          -114,8},{-114,6},{-106,6},{-106,-68},{34,-68}}, color={255,0,255}));
  connect(booleanConstant.y, logicalSwitch.u3) annotation (Line(points={{-181,
          -20},{-156,-20},{-156,0},{-148,0}}, color={255,0,255}));
  connect(QEva, QEva)
    annotation (Line(points={{-50,112},{-50,112}}, color={0,0,127}));
  connect(realExpression.y, QCon) annotation (Line(points={{-149,114},{-92,114},
          {-92,112},{-74,112}}, color={0,0,127}));
  connect(realExpression1.y, QEva)
    annotation (Line(points={{-81,136},{-50,136},{-50,112}}, color={0,0,127}));
  connect(realExpression2.y, Pel) annotation (Line(points={{-15,136},{-2,136},{
          -2,112},{-22,112}}, color={0,0,127}));
  connect(realExpression.y, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-149,114},{-149,92},{-140,92}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy, QHeating)
    annotation (Line(points={{-116,95.6},{-42,95.6},{-42,94},{28,94},{28,112}},
        color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy, QCooling)
    annotation (Line(points={{-116,86.2},{-58,86.2},{-58,98},{10,98},{10,112},{
          60,112}},
        color={0,0,127}));
  connect(TAirRet.port_a, boundary3.port_b) annotation (Line(points={{80,18},{86,
          18},{86,-60},{72,-60},{72,-75},{78,-75}}, color={0,127,255}));
  connect(boundary1.ports[1], boundary3.port_a) annotation (Line(points={{132,-73},
          {132,-75},{98,-75}}, color={0,127,255}));
  connect(TOutAir, boundary1.T_in) annotation (Line(points={{113,-45},{113,-56},
          {162,-56},{162,-69.4},{154,-69.4}}, color={0,0,127}));
  connect(logicalSwitch.y, EvaFanOnOff.u2) annotation (Line(points={{-125,8},{
          -100,8},{-100,-152},{56,-152}}, color={255,0,255}));
  connect(const1.y, boundary3.m_flow_in) annotation (Line(points={{155,-8},{158,
          -8},{158,-10},{88,-10},{88,-64.2}}, color={0,0,127}));
  connect(boundary3.P, EvaFanOnOff.u1) annotation (Line(points={{77,-66.9},{64,
          -66.9},{64,-94},{46,-94},{46,-144},{56,-144}}, color={0,0,127}));
  connect(const2.y, EvaFanOnOff.u3) annotation (Line(points={{30.8,-168},{56,
          -168},{56,-160}}, color={0,0,127}));
  connect(EvaFanOnOff.y, EvaFanPow) annotation (Line(points={{79,-152},{86,-152},
          {86,-134},{90,-134},{90,-112},{64,-112}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>In reverse operation mode, the condenser becomes the evaporator, and the evaporator becomes the condenser.</p>
</html>"));
end Aixlib_AirToWaterHeatPump_3D_fake;
