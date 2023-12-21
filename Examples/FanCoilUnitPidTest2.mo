within CCC_test.Examples;
model FanCoilUnitPidTest2
    replaceable package Medium1 = Buildings.Media.Water "Medium 1 in the component";
      replaceable package Medium2 = Buildings.Media.Air "Medium 2 in the component";
  replaceable parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.126
    "Nominal mass flow rate for Medium 1";
  replaceable parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=0.126
    "Nominal mass flow rate for Medium 2";
  replaceable parameter Modelica.Units.SI.Temperature T_a1_nominal=273.15+70
    "Nominal temperature at port a1";
  replaceable parameter Modelica.Units.SI.Temperature T_a2_nominal=273.15+20
    "Nominal temperature at port a2";
  replaceable parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=500
    "Nominal heat flow rate (positive for heat transfer from 1 to 2)";
          replaceable parameter Modelica.Units.SI.Pressure dp1_nominal
    "Nominal pressure drop for Medium 1";
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuWaterReturn(redeclare
      package Medium = Medium1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={36,38})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuWaterSupply(redeclare
      package Medium = Medium1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,20})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{-112,34},{-92,54}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1)
    annotation (Placement(transformation(extent={{92,34},{112,54}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-58,70},{-38,90}})));
  Modelica.Blocks.Sources.Constant const4(k=5)
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Math.Gain        gain(k=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-10,74},{10,94}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-54,2},{-34,22}})));
  Modelica.Blocks.Sources.Constant const1(k=6)
    annotation (Placement(transformation(extent={{-72,38},{-52,58}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium1,
    m_flow_nominal=m1_flow_nominal,
    dp_nominal=dp1_nominal,
    Q_flow_nominal=Q_flow_nominal)
    annotation (Placement(transformation(extent={{-18,2},{2,22}})));
  Modelica.Blocks.Sources.Constant const2(k=-0.1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
equation
  connect(port_a1, port_a1)
    annotation (Line(points={{-102,44},{-102,44}}, color={0,127,255}));
  connect(const4.y, conPID.u_s) annotation (Line(points={{-67,84},{-64,84},{-64,
          80},{-60,80}}, color={0,0,127}));
  connect(tempFcuWaterSupply.T, add.u1) annotation (Line(points={{-82,31},{-82,
          64},{-56,64},{-56,60},{-22,60},{-22,56},{-12,56}},
                                                color={0,0,127}));
  connect(tempFcuWaterReturn.T, add.u2) annotation (Line(points={{36,49},{36,52},
          {20,52},{20,36},{-12,36},{-12,44}},
                                      color={0,0,127}));
  connect(gain.y, fan.m_flow_in) annotation (Line(points={{11,84},{20,84},{20,
          54},{18,54},{18,34},{-44,34},{-44,24}},
                            color={0,0,127}));
  connect(conPID.y, gain.u) annotation (Line(points={{-37,80},{-22,80},{-22,84},
          {-12,84}}, color={0,0,127}));
  connect(const2.y, hea.u) annotation (Line(points={{-59,-30},{-28,-30},{-28,18},
          {-20,18}}, color={0,0,127}));
  connect(hea.port_b, tempFcuWaterReturn.port_a) annotation (Line(points={{2,12},
          {22,12},{22,38},{26,38}}, color={0,127,255}));
  connect(conPID.u_m, add.y) annotation (Line(points={{-48,68},{-12,68},{-12,66},
          {16,66},{16,50},{11,50}}, color={0,0,127}));
  connect(tempFcuWaterReturn.port_b, port_b1) annotation (Line(points={{46,38},
          {86,38},{86,44},{102,44}}, color={0,127,255}));
  connect(port_a1, tempFcuWaterSupply.port_a) annotation (Line(points={{-102,44},
          {-88,44},{-88,58},{-116,58},{-116,20},{-92,20}}, color={0,127,255}));
  connect(tempFcuWaterSupply.port_b, fan.port_a) annotation (Line(points={{-72,
          20},{-58,20},{-58,12},{-54,12}}, color={0,127,255}));
  connect(fan.port_b, hea.port_a)
    annotation (Line(points={{-34,12},{-18,12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanCoilUnitPidTest2;
