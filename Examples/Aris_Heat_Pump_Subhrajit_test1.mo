within CCC_test.Examples;
model Aris_Heat_Pump_Subhrajit_test1
      extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

   parameter Modelica.Units.SI.MassFlowRate mHP_flow_nominal=0.92 "Nominal mass flow rate from the heat pump";
   parameter Modelica.Units.SI.Temperature TankTempSetpoint=273.15+48;

   parameter Modelica.Units.SI.MassFlowRate fcu_air_flow_nominal=0.14951;

   parameter Modelica.Units.SI.TemperatureDifference DomesticHotWaterTempDelta=7;

   parameter Modelica.Units.SI.TemperatureDifference TempSetpointHpDeadband=3;

  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D aixlib_AirToWaterHeatPump_3D(
      redeclare package Medium_eva = MediumAir, redeclare package Medium_con =
        MediumWater)
    annotation (Placement(transformation(extent={{-110,34},{-90,54}})));

  Modelica.Blocks.Sources.CombiTimeTable OAT(
    table=[0,295.3125; 300,295.133333333333; 600,294.908333333333; 900,294.775;
        1200,294.85; 1500,294.645833333333; 1800,294.304166666667; 2100,294.275;
        2400,294.345833333333; 2700,294.6; 3000,294.716666666667; 3300,294.720833333333;
        3600,294.775; 3900,294.775; 4200,294.775; 4500,294.816666666667; 4800,294.9;
        5100,294.783333333333; 5400,294.741666666667; 5700,294.133333333333; 6000,
        293.429166666667; 6300,293.433333333333; 6600,293.016666666667; 6900,292.8375;
        7200,292.658333333333; 7500,292.2625; 7800,291.8875; 8100,291.841666666667;
        8400,291.625; 8700,291.525; 9000,291.366666666667; 9300,291.275; 9600,291.175;
        9900,291.216666666667; 10200,291.1125; 10500,291.179166666667; 10800,291.266666666667;
        11100,291.05; 11400,290.791666666667; 11700,290.616666666667; 12000,290.466666666667;
        12300,290.466666666667; 12600,290.35; 12900,290.125; 13200,290.025; 13500,
        290.004166666667; 13800,290.233333333333; 14100,290.525; 14400,290.304166666667;
        14700,289.975; 15000,289.941666666667; 15300,289.8375; 15600,289.708333333333;
        15900,289.754166666667; 16200,290.0375; 16500,290.225; 16800,290.191666666667;
        17100,289.804166666667; 17400,289.595833333333; 17700,289.75; 18000,289.566666666667;
        18300,289.533333333333; 18600,289.7; 18900,289.775; 19200,289.8625; 19500,
        289.716666666667; 19800,289.579166666667; 20100,289.720833333333; 20400,
        289.433333333333; 20700,289.425; 21000,289.541666666667; 21300,289.525;
        21600,289.525; 21900,289.379166666667; 22200,289.158333333333; 22500,289.195833333333;
        22800,289.533333333333; 23100,289.666666666667; 23400,289.65; 23700,289.708333333333;
        24000,289.8875; 24300,290.066666666667; 24600,290.35; 24900,290.645833333333;
        25200,291.070833333333; 25500,291.5375; 25800,291.941666666667; 26100,292.241666666667;
        26400,292.716666666667; 26700,293.183333333333; 27000,293.633333333333;
        27300,294.170833333333; 27600,294.708333333333; 27900,295.033333333333;
        28200,295.208333333333; 28500,295.520833333333; 28800,295.845833333333;
        29100,296.375; 29400,296.879166666667; 29700,297.2125; 30000,297.420833333333;
        30300,297.854166666667; 30600,298.995833333333; 30900,298.95; 31200,298.8375;
        31500,299.575; 31800,299.4125; 32100,299.966666666667; 32400,300.683333333333;
        32700,301; 33000,301.008333333333; 33300,302.095833333333; 33600,302.129166666667;
        33900,302.045833333333; 34200,302.591666666667; 34500,302.795833333333;
        34800,302.8625; 35100,302.479166666667; 35400,302.65; 35700,302.404166666667;
        36000,302.941666666667; 36300,303.4625; 36600,304.170833333333; 36900,304.429166666667;
        37200,304.641666666667; 37500,304.979166666667; 37800,304.6; 38100,305.158333333333;
        38400,305.4; 38700,305.475; 39000,305.516666666667; 39300,305.933333333333;
        39600,306.15; 39900,305.908333333333; 40200,305.733333333333; 40500,305.925;
        40800,306.175; 41100,306.616666666667; 41400,306.4; 41700,306.491666666667;
        42000,306.9; 42300,306.991666666667; 42600,307.458333333333; 42900,307.441666666667;
        43200,307.916666666667; 43500,308.141666666667; 43800,308.266666666667;
        44100,308.166666666667; 44400,308.15; 44700,308.275; 45000,308.3; 45300,
        308.15; 45600,308.366666666667; 45900,308.4; 46200,308.4; 46500,308.85;
        46800,309.516666666667; 47100,309.908333333333; 47400,309.65; 47700,309.65;
        48000,309.966666666667; 48300,310.366666666667; 48600,310.383333333333;
        48900,310.333333333333; 49200,310.525; 49500,310.525; 49800,310.575; 50100,
        310.55; 50400,310.925; 50700,311.458333333333; 51000,311.775; 51300,311.9;
        51600,312.158333333333; 51900,312.491666666667; 52200,312.25; 52500,312.583333333333;
        52800,312.783333333333; 53100,312.9; 53400,313.141666666667; 53700,313.4;
        54000,313.4; 54300,313.633333333333; 54600,313.525; 54900,313.475; 55200,
        313.416666666667; 55500,313.65; 55800,313.408333333333; 56100,313.566666666667;
        56400,313.808333333333; 56700,313.933333333333; 57000,313.841666666667;
        57300,313.225; 57600,313.233333333333; 57900,313.216666666667; 58200,313.508333333333;
        58500,313.65; 58800,313.741666666667; 59100,313.333333333333; 59400,313.291666666667;
        59700,313.258333333333; 60000,313.633333333333; 60300,313.658333333333;
        60600,313.466666666667; 60900,313.3; 61200,313.4; 61500,313.4; 61800,313.4;
        62100,313.291666666667; 62400,313.15; 62700,312.95; 63000,313.116666666667;
        63300,312.941666666667; 63600,312.9; 63900,312.9; 64200,312.9; 64500,312.708333333333;
        64800,312.65; 65100,312.641666666667; 65400,312.433333333333; 65700,312.4;
        66000,312.391666666667; 66300,311.983333333333; 66600,311.9; 66900,311.9;
        67200,311.9; 67500,311.9; 67800,311.733333333333; 68100,311.65; 68400,311.341666666667;
        68700,310.591666666667; 69000,310.15; 69300,309.858333333333; 69600,309.45;
        69900,308.791666666667; 70200,308.55; 70500,307.891666666667; 70800,307.4;
        71100,307.4; 71400,307.15; 71700,306.933333333333; 72000,306.6; 72300,306.075;
        72600,305.616666666667; 72900,305.1375; 73200,304.391666666667; 73500,303.875;
        73800,303.2125; 74100,302.825; 74400,302.141666666667; 74700,301; 75000,
        300.383333333333; 75300,299.525; 75600,299.15; 75900,299.179166666667; 76200,
        299.854166666667; 76500,300.475; 76800,300.791666666667; 77100,300.275;
        77400,299.520833333333; 77700,299.341666666667; 78000,298.7625; 78300,298.1625;
        78600,297.691666666667; 78900,297.608333333333; 79200,296.8625; 79500,296.208333333333;
        79800,295.816666666667; 80100,295.3625; 80400,295.208333333333; 80700,295.541666666667;
        81000,296.120833333333; 81300,296.575; 81600,297.15; 81900,297.433333333333;
        82200,296.920833333333; 82500,295.995833333333; 82800,295.141666666667;
        83100,294.7125; 83400,294.454166666667; 83700,294.454166666667; 84000,294.575;
        84300,295; 84600,295.625; 84900,295.979166666667; 85200,295.25; 85500,294.3125;
        85800,293.9; 86100,294.191666666667; 86400,294.191666666667],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.92,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-154,34},{-134,54}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.92,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{12,42},{-10,64}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pum(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.92,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,50})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumWater,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-98,82})));
  Modelica.Blocks.Sources.BooleanConstant bool
    annotation (Placement(transformation(extent={{-166,84},{-146,104}})));
  CCC.Fluid.BaseClasses.HpSetpointController_Subhrajit_alt
    hpSetpointController_Subhrajit(DomesticHotWaterTempDelta=
        DomesticHotWaterTempDelta)
    annotation (Placement(transformation(extent={{-200,50},{-180,74}})));
  Modelica.Blocks.Sources.Constant const(k=0.92)
    annotation (Placement(transformation(extent={{-270,46},{-250,66}})));
  Modelica.Blocks.Sources.Constant const1(k=TankTempSetpoint)
    annotation (Placement(transformation(extent={{-270,-4},{-250,16}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0.0,1; 21600,0; 64800,1],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-346,80},{-326,100}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-296,74},{-276,94}})));
  Modelica.Blocks.Sources.Constant const2(k=0.05)
    annotation (Placement(transformation(extent={{-248,18},{-228,38}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{40,-46},{60,-26}})));
  Modelica.Blocks.Sources.Constant const3(k=TankTempSetpoint)
    annotation (Placement(transformation(extent={{-58,-12},{-38,8}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 12)
    annotation (Placement(transformation(extent={{-82,-54},{-62,-34}})));
  Buildings.Fluid.Sources.Boundary_pT bou2(redeclare package Medium =
        MediumWater, nPorts=1)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={152,40})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    VTan=0.3028,
    hTan=1.2,
    dIns=0.02815,
    nSeg=20,
    T_start=TankTempSetpoint,
    redeclare package MediumHex = MediumWater,
    hHex_a=1.1999,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=TankTempSetpoint,
    THex_nominal=TankTempSetpoint + DomesticHotWaterTempDelta,
    mHex_flow_nominal=mHP_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={32,39})));
  Buildings.Fluid.Sources.MassFlowSource_T pum1(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-198,-56})));
  Modelica.Blocks.Math.Gain UnitConversion(k=1000)
    "convert water flow from m3/s to kg/s, assuming water density is 1000kg/m3"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-242,-54})));
  Modelica.Blocks.Sources.CombiTimeTable DrawProfile(
    table=[0,0; 300,0; 600,0; 900,1.26180417808599e-05; 1200,0; 1500,0; 1800,0;
        2100,0; 2400,0; 2700,0; 3000,0; 3300,0; 3600,0; 3900,0; 4200,0; 4500,0;
        4800,0; 5100,0; 5400,0; 5700,0; 6000,0; 6300,0; 6600,0; 6900,0; 7200,0;
        7500,0; 7800,0; 8100,0; 8400,0; 8700,0; 9000,0; 9300,0; 9600,0; 9900,0;
        10200,0; 10500,0; 10800,0; 11100,0; 11400,0; 11700,0; 12000,0; 12300,0;
        12600,0; 12900,0; 13200,0; 13500,0; 13800,0; 14100,0; 14400,0; 14700,0;
        15000,0; 15300,0; 15600,0; 15900,0; 16200,0; 16500,0; 16800,0; 17100,0;
        17400,0; 17700,0; 18000,0; 18300,0; 18600,0; 18900,0; 19200,0; 19500,0;
        19800,0; 20100,0; 20400,0; 20700,0; 21000,0; 21300,0; 21600,0; 21900,0;
        22200,0; 22500,0; 22800,0; 23100,0; 23400,0; 23700,0; 24000,0; 24300,0;
        24600,0; 24900,0; 25200,0; 25500,0; 25800,0; 26100,0; 26400,0; 26700,0;
        27000,0; 27300,0; 27600,0; 27900,0; 28200,0; 28500,0; 28800,0; 29100,0;
        29400,0; 29700,0; 30000,0; 30300,0; 30600,0; 30900,0; 31200,0; 31500,0;
        31800,0; 32100,0; 32400,0; 32700,5.04721671234398e-05; 33000,
        5.04721671234398e-05; 33300,1.26180417808599e-05; 33600,0; 33900,0;
        34200,0.000176652584932039; 34500,0.00010094433424688; 34800,0; 35100,0;
        35400,0; 35700,1.26180417808599e-05; 36000,0; 36300,0; 36600,
        1.26180417808599e-05; 36900,6.30902089042997e-05; 37200,0; 37500,0;
        37800,0; 38100,0; 38400,0; 38700,3.78541253425798e-05; 39000,0; 39300,0;
        39600,0; 39900,0; 40200,0; 40500,1.26180417808599e-05; 40800,
        5.04721671234398e-05; 41100,6.30902089042997e-05; 41400,
        2.52360835617199e-05; 41700,0; 42000,6.30902089042997e-05; 42300,
        0.000201888668493759; 42600,8.83262924660196e-05; 42900,0; 43200,0;
        43500,0; 43800,0; 44100,0; 44400,0; 44700,0; 45000,0.000113562376027739;
        45300,0.000201888668493759; 45600,3.78541253425798e-05; 45900,0; 46200,
        0; 46500,0; 46800,0; 47100,0; 47400,0; 47700,0; 48000,0; 48300,
        8.83262924660196e-05; 48600,0.000201888668493759; 48900,
        6.30902089042997e-05; 49200,0; 49500,0; 49800,0; 50100,0; 50400,0;
        50700,0; 51000,0; 51300,0; 51600,0; 51900,0; 52200,0; 52500,0; 52800,0;
        53100,0; 53400,8.83262924660196e-05; 53700,3.78541253425798e-05; 54000,
        0; 54300,0; 54600,0; 54900,0; 55200,0; 55500,0; 55800,0; 56100,0; 56400,
        0; 56700,0; 57000,0; 57300,0; 57600,0; 57900,0; 58200,0; 58500,0; 58800,
        0; 59100,0; 59400,0; 59700,0; 60000,0; 60300,0; 60600,0; 60900,0; 61200,
        0; 61500,0; 61800,0; 62100,0; 62400,0; 62700,0; 63000,0; 63300,0; 63600,
        0; 63900,0; 64200,0.000113562376027739; 64500,7.57082506851597e-05;
        64800,0; 65100,0; 65400,0; 65700,0; 66000,0; 66300,0; 66600,0; 66900,
        5.04721671234398e-05; 67200,0; 67500,0; 67800,1.26180417808599e-05;
        68100,0; 68400,0; 68700,0; 69000,0; 69300,0; 69600,0; 69900,0; 70200,0;
        70500,0; 70800,0; 71100,0; 71400,0; 71700,0; 72000,0; 72300,0; 72600,0;
        72900,0; 73200,1.26180417808599e-05; 73500,1.26180417808599e-05; 73800,
        3.78541253425798e-05; 74100,1.26180417808599e-05; 74400,
        2.52360835617199e-05; 74700,0; 75000,0; 75300,1.26180417808599e-05;
        75600,0; 75900,0; 76200,0; 76500,0; 76800,0; 77100,0; 77400,0; 77700,0;
        78000,0; 78300,0; 78600,0; 78900,1.26180417808599e-05; 79200,0; 79500,0;
        79800,0; 80100,0; 80400,0; 80700,0; 81000,0; 81300,0; 81600,
        1.26180417808599e-05; 81900,1.26180417808599e-05; 82200,0; 82500,0;
        82800,0; 83100,0; 83400,0; 83700,0; 84000,0; 84300,0; 84600,0; 84900,0;
        85200,0; 85500,0; 85800,0; 86100,0; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-292,-62},{-272,-42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Ttank[20]
    "Temperature of water in the tank"
    annotation (Placement(transformation(extent={{22,76},{42,96}})));
  Modelica.Blocks.Logical.Hysteresis HpHysteresis(
    uLow=TankTempSetpoint - TempSetpointHpDeadband,
    uHigh=TankTempSetpoint + TempSetpointHpDeadband,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{82,92},{102,112}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{128,92},{148,112}})));
equation
  connect(OAT.y[1], aixlib_AirToWaterHeatPump_3D.TOutAir) annotation (Line(
        points={{1,-50},{6,-50},{6,32},{-84,32},{-84,40.7},{-88.7,40.7}},
                  color={0,0,127}));
  connect(val.port_2, aixlib_AirToWaterHeatPump_3D.port_a) annotation (Line(
        points={{-134,44},{-118,44},{-118,51},{-111,51}}, color={0,127,255}));
  connect(aixlib_AirToWaterHeatPump_3D.port_b, pum.port_a) annotation (Line(
        points={{-89.2,50.8},{-77.6,50.8},{-77.6,50},{-66,50}}, color={0,127,255}));
  connect(pum.port_b, val1.port_2) annotation (Line(points={{-46,50},{-16,50},{-16,
          53},{-10,53}}, color={0,127,255}));
  connect(val.port_2, bou1.ports[1]) annotation (Line(points={{-134,44},{-118,44},
          {-118,82},{-108,82}}, color={0,127,255}));
  connect(bool.y, aixlib_AirToWaterHeatPump_3D.OnOff) annotation (Line(points={{
          -145,94},{-122,94},{-122,46},{-111.2,46}}, color={255,0,255}));
  connect(hpSetpointController_Subhrajit.ValCon, val.y) annotation (Line(points
        ={{-178,71.2},{-160,71.2},{-160,72},{-144,72},{-144,56}}, color={0,0,127}));
  connect(hpSetpointController_Subhrajit.ModeHp, aixlib_AirToWaterHeatPump_3D.Mode)
    annotation (Line(points={{-178,68},{-128,68},{-128,60},{-80,60},{-80,46},{
          -88.8,46}},  color={255,0,255}));
  connect(hpSetpointController_Subhrajit.TSupSet, aixlib_AirToWaterHeatPump_3D.TSupSet)
    annotation (Line(points={{-178,58.6},{-168,58.6},{-168,32},{-116,32},{-116,40.1},
          {-111.1,40.1}}, color={0,0,127}));
  connect(hpSetpointController_Subhrajit.ValCon, val1.y) annotation (Line(
        points={{-178,71.2},{-120,71.2},{-120,100},{1,100},{1,66.2}}, color={0,0,
          127}));
  connect(hpSetpointController_Subhrajit.PumSp, pum.m_flow_in) annotation (Line(
        points={{-178,53},{-160,53},{-160,62},{-72,62},{-72,70},{-56,70},{-56,62}},
        color={0,0,127}));
  connect(const.y, hpSetpointController_Subhrajit.PumSpDhw) annotation (Line(
        points={{-249,56},{-212,56},{-212,66},{-202,66}}, color={0,0,127}));
  connect(const1.y, hpSetpointController_Subhrajit.DhwTankTempSetpoint)
    annotation (Line(points={{-249,6},{-202,6},{-202,56.6}}, color={0,0,127}));
  connect(combiTimeTable.y[1], realToBoolean.u) annotation (Line(points={{-325,
          90},{-308,90},{-308,84},{-298,84}}, color={0,0,127}));
  connect(val1.port_3, hea1.port_a) annotation (Line(points={{1,42},{12,42},{12,
          -42},{40,-42},{40,-36}}, color={0,127,255}));
  connect(hea1.port_b, val.port_3) annotation (Line(points={{60,-36},{66,-36},{
          66,-78},{-128,-78},{-128,34},{-144,34}}, color={0,127,255}));
  connect(const4.y, hea1.TSet) annotation (Line(points={{-61,-44},{-26,-44},{
          -26,-32},{10,-32},{10,-44},{14,-44},{14,-28},{38,-28}}, color={0,0,
          127}));
  connect(tan.port_a,bou2. ports[1]) annotation (Line(points={{42,39},{92,39},{
          92,40},{142,40}},
                         color={0,127,255}));
  connect(tan.portHex_b, val.port_1) annotation (Line(points={{42,31.8},{44,
          31.8},{44,28},{4,28},{4,30},{-154,30},{-154,44}},       color={0,127,255}));
  connect(val1.port_1,tan. portHex_a) annotation (Line(points={{12,53},{42,53},
          {42,35.58}},                                           color={0,127,255}));
  connect(pum1.ports[1],tan. port_b) annotation (Line(points={{-188,-56},{-88,
          -56},{-88,-26},{22,-26},{22,39}},
                                     color={0,127,255}));
  connect(UnitConversion.y,pum1. m_flow_in) annotation (Line(points={{-231,-54},
          {-218,-54},{-218,-48},{-210,-48}}, color={0,0,127}));
  connect(DrawProfile.y[1],UnitConversion. u) annotation (Line(points={{-271,
          -52},{-271,-54},{-254,-54}},
                                  color={0,0,127}));
  connect(tan.heaPorVol,Ttank. port) annotation (Line(points={{32,39},{32,70},{
          16,70},{16,86},{22,86}},
                                color={191,0,0}));
  connect(Ttank[17].T,HpHysteresis. u) annotation (Line(points={{43,86},{50,86},
          {50,102},{80,102}},          color={0,0,127}));
  connect(HpHysteresis.y,not1. u)
    annotation (Line(points={{103,102},{126,102}}, color={255,0,255}));
  connect(not1.y, hpSetpointController_Subhrajit.RequestDhw) annotation (Line(
        points={{149,102},{154,102},{154,118},{-212,118},{-212,70},{-202,70}},
                                                                     color={255,
          0,255}));
  connect(const2.y, hpSetpointController_Subhrajit.PumSpSpaceConditioning)
    annotation (Line(points={{-227,28},{-212,28},{-212,54},{-210,54},{-210,61.8},
          {-202,61.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Aris_Heat_Pump_Subhrajit_test1;
