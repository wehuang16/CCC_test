within CCC_test.obsolete;
model Aixlib_AirToWaterHeatPump_2D
  replaceable package Medium_eva = Buildings.Media.Air;
  replaceable package Medium_con = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (                           property_T = 273.15 + 50, X_a = 0.4);
  parameter Modelica.Units.SI.MassFlowRate mEva_flow_nominal = 2.333;
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal = 0.92;
  parameter Modelica.Units.SI.PressureDifference dp_nominal = 100
  "nominal pressure drop through each piece of equipment";
  //The below parameters were taken from from AixLib.Fluid.HeatPumps.ModularReversible.Examples.AirToWater2D_OneRoomRadiator
  // and are based on a radiator system to heat up or cool down one room. All in Kelvin for units
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=20000
    "Nominal heat flow rate of radiator";
  parameter Modelica.Units.SI.Temperature TRadSup_nominal=273.15 + 50
    " nominal supply water temperature";
  parameter Modelica.Units.SI.Temperature TRadRet_nominal=273.15 + 45
    " nominal return water temperature";
   parameter Modelica.Units.SI.Temperature TRooSetHea=293.15
    "Room set temperature for heating";
  parameter Modelica.Units.SI.Temperature TRooSetCoo=296.15
    "Room set temperature for cooling";
  parameter Modelica.Units.SI.Temperature TRadMinSup=290.15
    "Minimal radiator supply temperature to avoid condensation effects";
   parameter Modelica.Units.SI.Temperature TAir_nominal=293.15
    "Air temperature at nominal condition"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TRad_nominal=TAir_nominal
    "Radiative temperature at nominal condition"
    annotation (Dialog(group="Nominal condition"));

  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium_con)
                                                                                      annotation (
    Placement(transformation(origin = {120, 4}, extent = {{150, 110}, {170, 130}}), iconTransformation(origin = {0, 22}, extent = {{160, 58}, {180, 78}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium_con)
                                                                                      annotation (
    Placement(transformation(origin = {-98, 0}, extent = {{-112, 110}, {-92, 130}}), iconTransformation(origin = {0, 20}, extent = {{-120, 60}, {-100, 80}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (
    Placement(transformation(origin = {-100, 0}, extent = {{-124, -72}, {-100, -48}}), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput Mode "Current operation mode: true: main operation mode, false: reversible operation mode" annotation (
    Placement(transformation(origin = {120, -28}, extent = {{184, 68}, {160, 92}}), iconTransformation(origin = {26.6667, 13.3333}, extent = {{153.333, 6.66667}, {133.333, 26.6667}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium = Medium_con, m_flow_nominal = 1) annotation (
    Placement(transformation(origin = {-2, 2}, extent = {{72, 112}, {92, 132}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium = Medium_con, m_flow_nominal = 1) annotation (
    Placement(transformation(origin = {-32, 0}, extent = {{-48, 110}, {-28, 130}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium = Medium_eva, m_flow_nominal = 1) annotation (
    Placement(transformation(origin = {64, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium = Medium_eva, m_flow_nominal = 1) annotation (
    Placement(transformation(origin = {-44, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Logical.Switch ModeSwitch annotation (
    Placement(transformation(extent = {{-54, -52}, {-34, -32}})));
    // PID CONTROLLER ADDED
  Buildings.Controls.Continuous.LimPID conPID(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = k, Ti = Ti, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.2, reverseActing = true) annotation (
    Placement(transformation(extent = {{-18, -70}, {2, -50}})));
  Modelica.Blocks.Logical.Switch ModeSwitch1 annotation (
    Placement(transformation(extent = {{-30, -136}, {-10, -116}})));
  Modelica.Blocks.Interfaces.RealInput TOutAir annotation (
    Placement(transformation(origin = {107.692, 6.15385}, extent = {{200.308, -58.1538}, {172.308, -30.1538}}), iconTransformation(origin = {36.9231, 1.53846}, extent = {{143.077, -41.5385}, {123.077, -21.5385}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow boundary3(redeclare package
      Medium =                                                                      Medium_eva, addPowerToMedium = false, m_flow_nominal = mEva_flow_nominal) annotation (
    Placement(transformation(extent = {{10, -9}, {-10, 9}}, rotation = 0, origin = {110, -15})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(redeclare package Medium = Medium_eva, use_T_in = false, nPorts = 1) annotation (
    Placement(transformation(origin = {-114, 98}, extent = {{8, -8}, {-8, 8}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const1(k = mEva_flow_nominal) annotation (
    Placement(transformation(origin = {-14, 20}, extent = {{214, -22}, {194, -2}})));
  Modelica.Blocks.Logical.Switch OnOffSwitch annotation (
    Placement(transformation(origin = {2, 0}, extent = {{22, -78}, {42, -58}})));
  Modelica.Blocks.Sources.Constant const(final k = 0) annotation (
    Placement(transformation(origin = {10, -110}, extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_con)
                                                                                        annotation (
    Placement(transformation(origin = {-66, 0}, extent = {{-86, 110}, {-66, 130}})));
  Modelica.Blocks.Interfaces.RealOutput QCon "Name is a bit confusing, but this represents the useful heat flow of the heat exchanger: this will be condenser hear flow for heating, and evaporator heat flow for cooling" annotation (
    Placement(transformation(origin = {-80, 192}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-70, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput QEva "Name is a bit confusing, but this represents the non-useful heat flow of the heat exchanger: this will be evaporator hear flow for heating, and condenser heat flow for cooling" annotation (
    Placement(transformation(origin = {-56, 192}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-50, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput Pel "electricity consumption of the heat pump" annotation (
    Placement(transformation(origin = {-28, 192}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-30, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium = Medium_eva, use_T_in = true, nPorts = 1) annotation (
    Placement(transformation(origin = {140, -61}, extent = {{8, -9}, {-8, 9}})));
  Modelica.Blocks.Logical.Switch EvaFanOnOff annotation (
    Placement(transformation(extent = {{30, -162}, {50, -142}})));
  Modelica.Blocks.Sources.Constant const2(final k = 0) annotation (
    Placement(transformation(origin = {-20, -168}, extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput EvaFanPow "electricity consumption of the evaporator fan" annotation (
    Placement(transformation(origin = {100, -212}, extent = {{-12, -12}, {12, 12}}, rotation = 270), iconTransformation(origin = {70, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput TWatOut annotation (
    Placement(transformation(origin = {-100, -14}, extent = {{-122, -92}, {-100, -70}}), iconTransformation(origin = {-9.09091, -16.3636}, extent = {{-110.909, -83.6364}, {-90.9091, -63.6364}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium = Medium_con, m_flow_nominal = 1, V = 0.04, nPorts = 2) annotation (
    Placement(transformation(origin = {11, 4}, extent = {{45, 120}, {27, 100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow(Q_flow(displayUnit = "kW")) annotation (
    Placement(transformation(origin = {0, -10}, extent = {{134, 100}, {114, 120}})));
  CCC.Controls.HPController hPController(
    delayTime=0,
    deltaTLow=0,
    deltaTHigh=6,
    desTLow=0,
    desTHigh=15,
    installerMaxPercent=0.68) annotation (Placement(transformation(origin={70,-24},
          extent={{-180,-142},{-140,-102}})));
  parameter Modelica.Units.SI.Time Ti = 600 "Time constant of Integrator block";
  parameter Real k = 0.01 "Gain of controller";
  Modelica.Blocks.Interfaces.RealOutput pumpFlow annotation (
    Placement(transformation(origin = {-59, -213}, extent = {{-13, -13}, {13, 13}}, rotation = 270), iconTransformation(origin = {-49.516, -109.951}, extent = {{-10.387, -10.387}, {10.387, 10.387}}, rotation = 270)));
  Modelica.Blocks.Interfaces.BooleanInput OnOff annotation (
    Placement(transformation(origin = {-100, 20}, extent = {{-124, 8}, {-100, 32}}), iconTransformation(origin = {-16.6667, 13.3333}, extent = {{-103.333, 6.66667}, {-83.3333, 26.6667}})));
  Modelica.Blocks.Interfaces.BooleanInput defrostStatus annotation (
    Placement(transformation(origin = {-100, 0}, extent = {{-124, -32}, {-100, -8}}), iconTransformation(origin = {-16.6667, -120}, extent = {{-103.333, 90}, {-83.3333, 110}})));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation (
    Placement(transformation(origin = {2, -10}, extent = {{240, 100}, {220, 120}})));
  Modelica.Blocks.Sources.Constant const3(k = -5) annotation (
    Placement(transformation(origin = {-22, 2}, extent = {{240, 60}, {220, 80}})));
  Modelica.Blocks.Math.Product product1 annotation (
    Placement(transformation(origin = {-20, -32}, extent = {{196, 100}, {176, 120}})));
  // ------------- HEAT PUMP PARAMETERIZATION ---------- //
  AixLib.Fluid.HeatPumps.ModularReversible.AirToWaterTableData2D AirToWaterTableData2D(
  redeclare package MediumCon = Medium_con,
  redeclare package MediumEva = Medium_eva,
  TCon_start=TRadSup_nominal "known",
  QHea_flow_nominal=Q_flow_nominal "known",
  use_intSafCtr=true,
  dpCon_nominal(displayUnit="Pa") = 2000,
  dpEva_nominal(displayUnit="Pa") = 200,
  energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
  TConHea_nominal=TRad_nominal "known",
  TEvaHea_nominal=283.15,
  TConCoo_nominal=TRadMinSup "known",
  TEvaCoo_nominal=303.15,
  redeclare
    CCC.Fluid.HeatPumps.Data.LG_DATA_Heating datTabHea,
  redeclare
    CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling datTabCoo,
  redeclare
      AixLib.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021
      safCtrPar(
      use_minOnTime=true,
      minOnTime=300,
      use_minOffTime=true,
      minOffTime=300,
      use_maxCycRat=true))
  annotation (
    Placement(transformation(origin = {-3, 107}, extent = {{-15, -15}, {15, 15}})));
  // 2D DATA TABLES FOR BOTH HEATING AND COOLING
    // DATA TABLE FOR SAFETY CONTROL

  Modelica.Blocks.Interfaces.RealOutput COP annotation (
    Placement(transformation(origin = {20, 192}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {30, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
 Modelica.Blocks.Sources.BooleanConstant MainOperationMode "heating mode is true, cooling mode is false. Hard coded to be true/in heating mode" annotation (
    Placement(transformation(origin = {-62, 64}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(TWatSup.port_b, port_b) annotation (
    Line(points = {{90, 124}, {280, 124}}, color = {0, 127, 255}));
  connect(TSupSet, ModeSwitch.u1) annotation (
    Line(points = {{-212, -60}, {-76, -60}, {-76, -34}, {-56, -34}}, color = {0, 0, 127}));
  connect(TSupSet, ModeSwitch1.u3) annotation (
    Line(points = {{-212, -60}, {-46, -60}, {-46, -134}, {-32, -134}}, color = {0, 0, 127}));
  connect(ModeSwitch.y, conPID.u_s) annotation (
    Line(points = {{-33, -42}, {-26, -42}, {-26, -60}, {-20, -60}}, color = {0, 0, 127}));
  connect(ModeSwitch1.y, conPID.u_m) annotation (
    Line(points = {{-9, -126}, {-8, -126}, {-8, -72}}, color = {0, 0, 127}));
  connect(Mode, ModeSwitch.u2) annotation (
    Line(points = {{292, 52}, {20, 52}, {20, -42}, {-24, -42}, {-24, -58}, {-66, -58}, {-66, -42}, {-56, -42}}, color = {255, 0, 255}));
  connect(Mode, ModeSwitch1.u2) annotation (
    Line(points = {{292, 52}, {20, 52}, {20, -42}, {-24, -42}, {-24, -58}, {-42, -58}, {-42, -126}, {-32, -126}}, color = {255, 0, 255}));
  connect(TAirSup.port_b, boundary4.ports[1]) annotation (
    Line(points = {{-54, 98}, {-106, 98}}, color = {0, 127, 255}));
    // PID CONTROLLER HERE
  connect(conPID.y, OnOffSwitch.u1) annotation (
    Line(points = {{3, -60}, {22, -60}}, color = {0, 0, 127}));
  connect(const.y, OnOffSwitch.u3) annotation (
    Line(points = {{19, -110}, {19, -76}, {22, -76}}, color = {0, 0, 127}));
  connect(port_a, senMasFlo.port_a) annotation (
    Line(points = {{-200, 120}, {-152, 120}}, color = {0, 127, 255}));
  connect(senMasFlo.port_b, TWatRet.port_a) annotation (
    Line(points = {{-132, 120}, {-80, 120}}, color = {0, 127, 255}));
  connect(QEva, QEva) annotation (
    Line(points = {{-56, 192}, {-56, 192}}, color = {0, 0, 127}));
  connect(TAirRet.port_a, boundary3.port_b) annotation (
    Line(points = {{74, 82}, {82, 82}, {82, -15}, {100, -15}}, color = {0, 127, 255}));
  connect(boundary1.ports[1], boundary3.port_a) annotation (
    Line(points = {{132, -61}, {132, -60}, {126, -60}, {126, -15}, {120, -15}}, color = {0, 127, 255}));
  connect(TOutAir, boundary1.T_in) annotation (
    Line(points = {{294, -38}, {294, -37.7}, {150, -37.7}, {150, -57}}, color = {0, 0, 127}));
  connect(const1.y, boundary3.m_flow_in) annotation (
    Line(points = {{179, 8}, {128, 8}, {128, -4.2}, {110, -4.2}}, color = {0, 0, 127}));
  connect(boundary3.P, EvaFanOnOff.u1) annotation (
    Line(points = {{99, -6.9}, {68, -6.9}, {68, -134}, {28, -134}, {28, -144}}, color = {0, 0, 127}));
  connect(const2.y, EvaFanOnOff.u3) annotation (
    Line(points = {{-11, -168}, {20, -168}, {20, -160}, {28, -160}}, color = {0, 0, 127}));
  connect(TWatOut, ModeSwitch.u3) annotation (
    Line(points = {{-211, -95}, {-70, -95}, {-70, -50}, {-56, -50}}, color = {0, 0, 127}));
  connect(TWatOut, ModeSwitch1.u1) annotation (
    Line(points = {{-211, -95}, {-70, -95}, {-70, -118}, {-32, -118}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (
    Line(points = {{114, 100}, {97, 100}, {97, 114}, {56, 114}}, color = {191, 0, 0}));
  connect(TWatSup.port_a, vol.ports[1]) annotation (
    Line(points = {{70, 124}, {47, 124}}, color = {0, 127, 255}));
  connect(hPController.SwitchSet, EvaFanOnOff.u2) annotation (
    Line(points = {{-69, -152}, {28, -152}}, color = {255, 0, 255}));
  connect(hPController.SwitchSet, OnOffSwitch.u2) annotation (
    Line(points = {{-69, -152}, {-4, -152}, {-4, -82}, {8, -82}, {8, -68}, {22, -68}}, color = {255, 0, 255}));
  connect(TSupSet, hPController.TWatSet) annotation (
    Line(points = {{-212, -60}, {-148, -60}, {-148, -160}, {-113, -160}}, color = {0, 0, 127}));
  connect(TWatSup.T, hPController.TWatOut) annotation (
    Line(points = {{80, 135}, {80, 136}, {-90, 136}, {-90, 60}, {-140, 60}, {-140, -149}, {-113, -149}}, color = {0, 0, 127}));
  connect(const3.y, product1.u2) annotation (
    Line(points = {{197, 72}, {178, 72}}, color = {0, 0, 127}));
  connect(add.y, product1.u1) annotation (
    Line(points = {{221, 100}, {185.5, 100}, {185.5, 84}, {178, 84}}, color = {0, 0, 127}));
  connect(product1.y, prescribedHeatFlow.Q_flow) annotation (
    Line(points = {{155, 78}, {147.5, 78}, {147.5, 100}, {134, 100}}, color = {0, 0, 127}));
  connect(TOutAir, add.u2) annotation (
    Line(points = {{294, -38}, {166, -38}, {166, 34}, {248, 34}, {248, 94}, {244, 94}}, color = {0, 0, 127}));
  connect(TWatOut, add.u1) annotation (
    Line(points = {{-211, -95}, {-70, -95}, {-70, -88}, {260, -88}, {260, 106}, {244, 106}}, color = {0, 0, 127}));
  connect(TWatRet.port_b, AirToWaterTableData2D.port_a1) annotation (
    Line(points = {{-60, 120}, {-39, 120}, {-39, 116}, {-18, 116}}, color = {0, 127, 255}));
  connect(TAirSup.port_a, AirToWaterTableData2D.port_b2) annotation (
    Line(points = {{-34, 98}, {-18, 98}}, color = {0, 127, 255}));
  connect(AirToWaterTableData2D.port_a2, TAirRet.port_b) annotation (
    Line(points = {{12, 98}, {37, 98}, {37, 82}, {54, 82}}, color = {0, 127, 255}));
  connect(AirToWaterTableData2D.port_b1, vol.ports[2]) annotation (
    Line(points = {{12, 116}, {26, 116}, {26, 125}, {47, 125}, {47, 124}}, color = {0, 127, 255}));
  connect(AirToWaterTableData2D.QEva_flow, QEva) annotation (
    Line(points = {{13.5, 93.5}, {22, 93.5}, {22, 133}, {-56, 133}, {-56, 192}}, color = {0, 0, 127}));
  connect(AirToWaterTableData2D.P, Pel) annotation (
    Line(points = {{13.5, 107}, {29, 107}, {29, 140}, {-28, 140}, {-28, 192}}, color = {0, 0, 127}));
  connect(AirToWaterTableData2D.QCon_flow, QCon) annotation (
    Line(points = {{13.5, 120.5}, {13.5, 120.75}, {17.5, 120.75}, {17.5, 147}, {-80, 147}, {-80, 192}}, color = {0, 0, 127}));
  connect(AirToWaterTableData2D.COP, COP) annotation (
    Line(points = {{14, 112}, {20, 112}, {20, 192}}, color = {0, 0, 127}));
  connect(OnOffSwitch.y, AirToWaterTableData2D.ySet) annotation (
    Line(points = {{45, -68}, {52, -68}, {52, 24}, {-28, 24}, {-28, 110}, {-20, 110}}, color = {0, 0, 127}));
  connect(EvaFanOnOff.y, EvaFanPow) annotation (
    Line(points = {{52, -152}, {100, -152}, {100, -212}}, color = {0, 0, 127}));
  connect(hPController.FlowSet, pumpFlow) annotation (
    Line(points = {{-69, -140}, {-59, -140}, {-59, -213}}, color = {0, 0, 127}));
  connect(OnOff, hPController.OnOff) annotation (
    Line(points = {{-212, 40}, {-172, 40}, {-172, -137}, {-112, -137}, {-112, -138}}, color = {255, 0, 255}));
  connect(defrostStatus, hPController.defrostStatus) annotation (
    Line(points = {{-212, -20}, {-180, -20}, {-180, -144}, {-112, -144}}, color = {255, 0, 255}));

 connect(MainOperationMode.y, AirToWaterTableData2D.hea) annotation (
    Line(points = {{-51, 64}, {-21, 64}, {-20, 104}}, color = {255, 0, 255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {160, 160}})),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, 180}, {280, -200}})),
    Documentation(info = "<html>
<p>In reverse operation mode, the condenser becomes the evaporator, and the evaporator becomes the condenser.</p>
</html>"),
    __Dymola_DymolaStoredErrors(thetext = ""));
end Aixlib_AirToWaterHeatPump_2D;
