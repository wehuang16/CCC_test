within CCC_test.CCC_Model;
model Aixlib_AirToWaterHeatPump_3D_issue20_05222024
              replaceable package Medium_eva = Buildings.Media.Air;
  replaceable package Medium_con = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.MassFlowRate  mEva_flow_nominal=2.333;
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
    mFlow_conNominal=0.5,
    VCon=0.05,
    dpCon_nominal=0,
    mFlow_evaNominal=0.5,
    VEva=0.05,
    dpEva_nominal=0,
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
    annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
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
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary3(
    redeclare package Medium = Medium_eva,
    use_m_flow_in=true,
    use_T_in=true,
    m_flow=0.5,
    T=308.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={96,-31})));
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
  Modelica.Blocks.Interfaces.RealOutput nSet annotation (Placement(
        transformation(extent={{100,-98},{126,-72}}), iconTransformation(extent=
           {{100,-98},{126,-72}})));
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
  connect(port_a, TWatRet.port_a) annotation (Line(points={{-102,56},{-102,54},{
          -74,54}}, color={0,127,255}));
  connect(TWatRet.port_b, heatPump.port_a1) annotation (Line(points={{-54,54},{
          -18,54},{-18,42},{-12,42}},
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
  connect(TOutAir, boundary3.T_in) annotation (Line(points={{113,-45},{113,-27.4},
          {108,-27.4}}, color={0,0,127}));
  connect(boundary3.ports[1], TAirRet.port_a) annotation (Line(points={{86,-31},
          {86,-32},{82,-32},{82,4},{84,4},{84,18},{80,18}}, color={0,127,255}));
  connect(TAirSup.port_b, boundary4.ports[1]) annotation (Line(points={{-76,6},{
          -98,6},{-98,-21},{-112,-21}}, color={0,127,255}));
  connect(const1.y, boundary3.m_flow_in) annotation (Line(points={{155,-8},{168,
          -8},{168,-23.8},{106,-23.8}}, color={0,0,127}));
  connect(OnOffSwitch.y, sigBus1.nSet) annotation (Line(points={{57,-68},{62,
          -68},{62,-38},{45.075,-38},{45.075,-16.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID.y, OnOffSwitch.u1) annotation (Line(points={{13,-62},{16,-62},
          {16,-60},{34,-60}}, color={0,0,127}));
  connect(OnOff, OnOffSwitch.u2) annotation (Line(points={{-112,32},{-102,32},{
          -102,30},{-70,30},{-70,-68},{34,-68}}, color={255,0,255}));
  connect(const.y, OnOffSwitch.u3) annotation (Line(points={{34.8,-98},{38,-98},
          {38,-84},{34,-84},{34,-76}}, color={0,0,127}));
  connect(OnOffSwitch.y, nSet)
    annotation (Line(points={{57,-68},{113,-68},{113,-85}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>In reverse operation mode, the condenser becomes the evaporator, and the evaporator becomes the condenser.</p>
</html>"));
end Aixlib_AirToWaterHeatPump_3D_issue20_05222024;
