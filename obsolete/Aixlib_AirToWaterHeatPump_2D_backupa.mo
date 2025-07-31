within CCC_test.obsolete;
model Aixlib_AirToWaterHeatPump_2D_backupa

               replaceable package Medium_eva = Buildings.Media.Air;
  replaceable package Medium_con = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 300
    "Time constant of Integrator block";
   parameter Real k(min=0) = 0.3 "Gain of controller";
   parameter Modelica.Units.SI.MassFlowRate  mEva_flow_nominal=1;
   parameter Modelica.Units.SI.HeatFlowRate  Q_flow_nominal=50000;
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium
      = Medium_con, m_flow_nominal=1)                                                                           annotation (
    Placement(transformation(origin={8,12},    extent = {{72, 112}, {92, 132}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium
      = Medium_con, m_flow_nominal=1)                                                                           annotation (
    Placement(transformation(origin={-22,10},   extent = {{-48, 110}, {-28, 130}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium
      = Medium_eva, m_flow_nominal=1)                                                                           annotation (
    Placement(transformation(origin={74,92},    extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium
      = Medium_eva, m_flow_nominal=1)                                                                           annotation (
    Placement(transformation(origin={-34,108},   extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Logical.Switch ModeSwitch annotation (
    Placement(transformation(extent={{-44,-42},{-24,-22}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=true)                                                                                                                                                                                             annotation (
    Placement(transformation(extent={{-8,-60},{12,-40}})));
  Modelica.Blocks.Logical.Switch ModeSwitch1 annotation (
    Placement(transformation(extent={{-20,-126},{0,-106}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow boundary3(
    redeclare package Medium = Medium_eva,
    addPowerToMedium=false,
    m_flow_nominal=mEva_flow_nominal)                                                                                                                         annotation (
    Placement(transformation(extent = {{10, -9}, {-10, 9}}, rotation = 0, origin={120,-5})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = Medium_eva,
    use_T_in=false,
    nPorts=1)                                                                                                       annotation (
    Placement(transformation(origin={-104,108},   extent = {{8, -8}, {-8, 8}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const1(k=mEva_flow_nominal)   annotation (
    Placement(transformation(origin={-4,30},     extent = {{214, -22}, {194, -2}})));
  Modelica.Blocks.Logical.Switch OnOffSwitch annotation (
    Placement(transformation(origin={12,10},  extent = {{22, -78}, {42, -58}})));
  Modelica.Blocks.Sources.Constant const(final k=0)   annotation (
    Placement(transformation(origin={20,-100},    extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium_con)                                                                     annotation (
    Placement(transformation(origin={-56,10},   extent = {{-86, 110}, {-66, 130}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Medium_eva,
    use_T_in=true,
    nPorts=1)                                                                                                      annotation (
    Placement(transformation(origin={150,-51},    extent = {{8, -9}, {-8, 9}})));
  Modelica.Blocks.Logical.Switch EvaFanOnOff annotation (
    Placement(transformation(extent={{40,-152},{60,-132}})));
  Modelica.Blocks.Sources.Constant const2(final k=0)   annotation (
    Placement(transformation(origin={-10,-158},    extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium_con,
    m_flow_nominal=1,
    V=0.04,
    nPorts=2)                                                                                                                     annotation (
    Placement(transformation(origin={21,14},   extent = {{45, 120}, {27, 100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow(Q_flow(
        displayUnit="kW"))                                                                                annotation (
    Placement(transformation(origin={10,0},     extent = {{134, 100}, {114, 120}})));
  CCC.Controls.HPController hPController(
    delayTime=0,
    deltaTLow=0,
    deltaTHigh=6,
    desTLow=0,
    desTHigh=15,
    installerMaxPercent=0.68) annotation (Placement(transformation(origin={80,-14},
          extent={{-180,-142},{-140,-102}})));
  Modelica.Blocks.Math.Add add(k2=-1)   annotation (
    Placement(transformation(origin={12,0},     extent = {{240, 100}, {220, 120}})));
  Modelica.Blocks.Sources.Constant const3(k=-5)   annotation (
    Placement(transformation(origin={-12,12},   extent = {{240, 60}, {220, 80}})));
  Modelica.Blocks.Math.Product product1 annotation (
    Placement(transformation(origin={-10,-22},    extent = {{196, 100}, {176, 120}})));
  AixLib.Fluid.HeatPumps.ModularReversible.AirToWaterTableData2D AirToWaterTableData2D(
    redeclare package MediumCon = Medium_con,
    redeclare package MediumEva = Medium_eva,
    use_intSafCtr=true,
    dpCon_nominal(displayUnit="Pa") = 2000,
    dpEva_nominal(displayUnit="Pa") = 200,
    QHea_flow_nominal=Q_flow_nominal,
    TConHea_nominal=323.15,
    TEvaHea_nominal=283.15,
    TConCoo_nominal=280.15,
    TEvaCoo_nominal=303.15,
    redeclare CCC.Fluid.HeatPumps.Data.LG_DATA_Heating
                                   datTabHea,
    redeclare CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling
                                   datTabCoo,
    redeclare
      AixLib.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021
      safCtrPar(
      use_minOnTime=true,
      minOnTime=300,
      use_minOffTime=true,
      minOffTime=300,
      use_maxCycRat=true))
  annotation (
    Placement(transformation(origin={7,117},     extent = {{-15, -15}, {15, 15}})));
 Modelica.Blocks.Sources.BooleanConstant MainOperationMode "heating mode is true, cooling mode is false. Hard coded to be true/in heating mode" annotation (
    Placement(transformation(origin={-52,74},    extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium_con)                                                                   annotation (
    Placement(transformation(origin={130,14},   extent = {{150, 110}, {170, 130}}), iconTransformation(origin = {0, 22}, extent = {{160, 58}, {180, 78}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium_con)                                                                   annotation (
    Placement(transformation(origin={-88,10},   extent = {{-112, 110}, {-92, 130}}), iconTransformation(origin = {0, 20}, extent = {{-120, 60}, {-100, 80}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (
    Placement(transformation(origin={-90,10},    extent = {{-124, -72}, {-100, -48}}), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput Mode "Current operation mode: true: main operation mode, false: reversible operation mode" annotation (
    Placement(transformation(origin={130,-18},    extent = {{184, 68}, {160, 92}}), iconTransformation(origin = {26.6667, 13.3333}, extent = {{153.333, 6.66667}, {133.333, 26.6667}})));
  Modelica.Blocks.Interfaces.RealInput TOutAir annotation (
    Placement(transformation(origin={117.692,16.1538},    extent = {{200.308, -58.1538}, {172.308, -30.1538}}), iconTransformation(origin = {36.9231, 1.53846}, extent = {{143.077, -41.5385}, {123.077, -21.5385}})));
  Modelica.Blocks.Interfaces.RealOutput QCon "Name is a bit confusing, but this represents the useful heat flow of the heat exchanger: this will be condenser hear flow for heating, and evaporator heat flow for cooling" annotation (
    Placement(transformation(origin={-70,202},    extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-70, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput QEva "Name is a bit confusing, but this represents the non-useful heat flow of the heat exchanger: this will be evaporator hear flow for heating, and condenser heat flow for cooling" annotation (
    Placement(transformation(origin={-46,202},    extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-50, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput Pel "electricity consumption of the heat pump" annotation (
    Placement(transformation(origin={-18,202},    extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-30, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput EvaFanPow "electricity consumption of the evaporator fan" annotation (
    Placement(transformation(origin={110,-202},    extent = {{-12, -12}, {12, 12}}, rotation = 270), iconTransformation(origin = {70, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput TWatOut annotation (
    Placement(transformation(origin={-90,-4},      extent = {{-122, -92}, {-100, -70}}), iconTransformation(origin = {-9.09091, -16.3636}, extent = {{-110.909, -83.6364}, {-90.9091, -63.6364}})));
  Modelica.Blocks.Interfaces.RealOutput pumpFlow annotation (
    Placement(transformation(origin={-49,-203},    extent = {{-13, -13}, {13, 13}}, rotation = 270), iconTransformation(origin = {-49.516, -109.951}, extent = {{-10.387, -10.387}, {10.387, 10.387}}, rotation = 270)));
  Modelica.Blocks.Interfaces.BooleanInput OnOff annotation (
    Placement(transformation(origin={-90,30},     extent = {{-124, 8}, {-100, 32}}), iconTransformation(origin = {-16.6667, 13.3333}, extent = {{-103.333, 6.66667}, {-83.3333, 26.6667}})));
  Modelica.Blocks.Interfaces.BooleanInput defrostStatus annotation (
    Placement(transformation(origin={-90,10},    extent = {{-124, -32}, {-100, -8}}), iconTransformation(origin = {-16.6667, -120}, extent = {{-103.333, 90}, {-83.3333, 110}})));
  Modelica.Blocks.Interfaces.RealOutput COP annotation (
    Placement(transformation(origin={30,202},    extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {30, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(TWatSup.port_b,port_b)  annotation (
    Line(points={{100,134},{290,134}},     color = {0, 127, 255}));
  connect(TSupSet,ModeSwitch. u1) annotation (
    Line(points={{-202,-50},{-66,-50},{-66,-24},{-46,-24}},          color = {0, 0, 127}));
  connect(TSupSet,ModeSwitch1. u3) annotation (
    Line(points={{-202,-50},{-36,-50},{-36,-124},{-22,-124}},          color = {0, 0, 127}));
  connect(ModeSwitch.y,conPID. u_s) annotation (
    Line(points={{-23,-32},{-16,-32},{-16,-50},{-10,-50}},          color = {0, 0, 127}));
  connect(ModeSwitch1.y,conPID. u_m) annotation (
    Line(points={{1,-116},{2,-116},{2,-62}},           color = {0, 0, 127}));
  connect(Mode,ModeSwitch. u2) annotation (
    Line(points={{302,62},{30,62},{30,-32},{-14,-32},{-14,-48},{-56,-48},{-56,
          -32},{-46,-32}},                                                                                      color = {255, 0, 255}));
  connect(Mode,ModeSwitch1. u2) annotation (
    Line(points={{302,62},{30,62},{30,-32},{-14,-32},{-14,-48},{-32,-48},{-32,
          -116},{-22,-116}},                                                                                      color = {255, 0, 255}));
  connect(TAirSup.port_b,boundary4. ports[1]) annotation (
    Line(points={{-44,108},{-96,108}},     color = {0, 127, 255}));
  connect(conPID.y,OnOffSwitch. u1) annotation (
    Line(points={{13,-50},{32,-50}},     color = {0, 0, 127}));
  connect(const.y,OnOffSwitch. u3) annotation (
    Line(points={{28.8,-100},{28.8,-66},{32,-66}},    color = {0, 0, 127}));
  connect(port_a,senMasFlo. port_a) annotation (
    Line(points={{-190,130},{-142,130}},      color = {0, 127, 255}));
  connect(senMasFlo.port_b,TWatRet. port_a) annotation (
    Line(points={{-122,130},{-70,130}},      color = {0, 127, 255}));
  connect(QEva,QEva)  annotation (
    Line(points={{-46,202},{-46,202}},      color = {0, 0, 127}));
  connect(TAirRet.port_a,boundary3. port_b) annotation (
    Line(points={{84,92},{92,92},{92,-5},{110,-5}},            color = {0, 127, 255}));
  connect(boundary1.ports[1],boundary3. port_a) annotation (
    Line(points={{142,-51},{142,-50},{136,-50},{136,-5},{130,-5}},              color = {0, 127, 255}));
  connect(TOutAir,boundary1. T_in) annotation (
    Line(points={{304,-28},{304,-27.7},{159.6,-27.7},{159.6,-47.4}},    color = {0, 0, 127}));
  connect(const1.y,boundary3. m_flow_in) annotation (
    Line(points={{189,18},{138,18},{138,5.8},{120,5.8}},          color = {0, 0, 127}));
  connect(boundary3.P,EvaFanOnOff. u1) annotation (
    Line(points={{109,3.1},{78,3.1},{78,-124},{38,-124},{38,-134}},             color = {0, 0, 127}));
  connect(const2.y,EvaFanOnOff. u3) annotation (
    Line(points={{-1.2,-158},{30,-158},{30,-150},{38,-150}},         color = {0, 0, 127}));
  connect(TWatOut,ModeSwitch. u3) annotation (
    Line(points={{-201,-85},{-60,-85},{-60,-40},{-46,-40}},          color = {0, 0, 127}));
  connect(TWatOut,ModeSwitch1. u1) annotation (
    Line(points={{-201,-85},{-60,-85},{-60,-108},{-22,-108}},          color = {0, 0, 127}));
  connect(prescribedHeatFlow.port,vol. heatPort) annotation (
    Line(points={{124,110},{107,110},{107,124},{66,124}},        color = {191, 0, 0}));
  connect(hPController.SwitchSet,EvaFanOnOff. u2) annotation (
    Line(points={{-58.5714,-141.714},{-10,-141.714},{-10,-142},{38,-142}},
                                             color = {255, 0, 255}));
  connect(hPController.SwitchSet,OnOffSwitch. u2) annotation (
    Line(points={{-58.5714,-141.714},{6,-141.714},{6,-72},{18,-72},{18,-58},{32,
          -58}},                                                                       color = {255, 0, 255}));
  connect(TSupSet,hPController. TWatSet) annotation (
    Line(points={{-202,-50},{-138,-50},{-138,-150.286},{-102.857,-150.286}},
                                                                          color = {0, 0, 127}));
  connect(TWatSup.T,hPController. TWatOut) annotation (
    Line(points={{90,145},{90,146},{-80,146},{-80,70},{-130,70},{-130,-138.857},
          {-102.857,-138.857}},                                                                          color = {0, 0, 127}));
  connect(const3.y,product1. u2) annotation (
    Line(points={{207,82},{188,82}},      color = {0, 0, 127}));
  connect(add.y,product1. u1) annotation (
    Line(points={{231,110},{195.5,110},{195.5,94},{188,94}},          color = {0, 0, 127}));
  connect(product1.y,prescribedHeatFlow. Q_flow) annotation (
    Line(points={{165,88},{157.5,88},{157.5,110},{144,110}},          color = {0, 0, 127}));
  connect(TOutAir,add. u2) annotation (
    Line(points={{304,-28},{176,-28},{176,44},{258,44},{258,104},{254,104}},            color = {0, 0, 127}));
  connect(TWatOut,add. u1) annotation (
    Line(points={{-201,-85},{-60,-85},{-60,-78},{270,-78},{270,116},{254,116}},              color = {0, 0, 127}));
  connect(TWatRet.port_b,AirToWaterTableData2D. port_a1) annotation (
    Line(points={{-50,130},{-29,130},{-29,126},{-8,126}},           color = {0, 127, 255}));
  connect(TAirSup.port_a,AirToWaterTableData2D. port_b2) annotation (
    Line(points={{-24,108},{-8,108}},     color = {0, 127, 255}));
  connect(AirToWaterTableData2D.port_a2,TAirRet. port_b) annotation (
    Line(points={{22,108},{47,108},{47,92},{64,92}},        color = {0, 127, 255}));
  connect(AirToWaterTableData2D.QEva_flow,QEva)  annotation (
    Line(points={{23.5,103.5},{32,103.5},{32,143},{-46,143},{-46,202}},          color = {0, 0, 127}));
  connect(AirToWaterTableData2D.P,Pel)  annotation (
    Line(points={{23.5,117},{39,117},{39,150},{-18,150},{-18,202}},            color = {0, 0, 127}));
  connect(AirToWaterTableData2D.QCon_flow,QCon)  annotation (
    Line(points={{23.5,130.5},{23.5,130.75},{27.5,130.75},{27.5,157},{-70,157},
          {-70,202}},                                                                                   color = {0, 0, 127}));
  connect(AirToWaterTableData2D.COP,COP)  annotation (
    Line(points={{23.5,121.5},{30,121.5},{30,202}},  color = {0, 0, 127}));
  connect(OnOffSwitch.y,AirToWaterTableData2D. ySet) annotation (
    Line(points={{55,-58},{62,-58},{62,34},{-18,34},{-18,119.85},{-9.65,119.85}},      color = {0, 0, 127}));
  connect(EvaFanOnOff.y,EvaFanPow)  annotation (
    Line(points={{61,-142},{110,-142},{110,-202}},        color = {0, 0, 127}));
  connect(hPController.FlowSet,pumpFlow)  annotation (
    Line(points={{-58.5714,-130.286},{-49,-130.286},{-49,-203}},
                                                           color = {0, 0, 127}));
  connect(OnOff,hPController. OnOff) annotation (
    Line(points={{-202,50},{-162,50},{-162,-127},{-102.857,-127},{-102.857,
          -127.429}},                                                                 color = {255, 0, 255}));
  connect(defrostStatus,hPController. defrostStatus) annotation (
    Line(points={{-202,-10},{-170,-10},{-170,-133.143},{-102.857,-133.143}},
                                                                          color = {255, 0, 255}));
 connect(MainOperationMode.y,AirToWaterTableData2D. hea) annotation (
    Line(points={{-41,74},{-9.65,74},{-9.65,113.85}}, color = {255, 0, 255}));
  connect(AirToWaterTableData2D.port_b1, vol.ports[1]) annotation (Line(points={
          {22,126},{28,126},{28,120},{42,120},{42,140},{57.9,140},{57.9,134}},
        color={0,127,255}));
  connect(TWatSup.port_a, vol.ports[2]) annotation (Line(points={{80,134},{72,134},
          {72,140},{56.1,140},{56.1,134}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Aixlib_AirToWaterHeatPump_2D_backupa;
