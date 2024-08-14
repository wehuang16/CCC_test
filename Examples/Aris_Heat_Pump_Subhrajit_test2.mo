within CCC_test.Examples;
model Aris_Heat_Pump_Subhrajit_test2
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
  CCC.Fluid.HeatExchangers.FanCoilUnit fanCoilUnit(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    m2_flow_nominal=fcu_air_flow_nominal,
    zone_temp_cooling_setpoint=295.15,
    zone_temp_heating_setpoint=293.15)
    annotation (Placement(transformation(extent={{-14,-32},{6,-12}})));
  CCC.Fluid.BaseClasses.DummyZone dummyZone(vol2(T_start=295.15))
    annotation (Placement(transformation(extent={{96,-56},{116,-36}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan4(
    redeclare package Medium = MediumAir,
    m_flow_nominal=fcu_air_flow_nominal,
    addPowerToMedium=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-46})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = MediumAir,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={156,-64})));
  Modelica.Blocks.Sources.CombiTimeTable coolingLoad(
    table=[0,13228.5408035624; 300,12687.4819807613; 600,5730.77302994459; 900,0;
        1200,0; 1500,0; 1800,0; 2100,0; 2400,3519.38963724903; 2700,14688.4030482052;
        3000,6701.14981793009; 3300,0; 3600,0; 3900,0; 4200,0; 4500,0; 4800,3486.49674234035;
        5100,14692.0118638285; 5400,9372.55683520851; 5700,0; 6000,0; 6300,0; 6600,
        0; 6900,0; 7200,0; 7500,0; 7800,0; 8100,240.593379005812; 8400,15092.8128255642;
        8700,13473.4947681017; 9000,0; 9300,0; 9600,0; 9900,0; 10200,0; 10500,0;
        10800,0; 11100,0; 11400,0; 11700,0; 12000,0; 12300,311.918588777951; 12600,
        15244.5690733009; 12900,10006.4180720813; 13200,0; 13500,0; 13800,0; 14100,
        0; 14400,0; 14700,0; 15000,0; 15300,0; 15600,0; 15900,0; 16200,0; 16500,
        0; 16800,0; 17100,0; 17400,0; 17700,0; 18000,0; 18300,0; 18600,0; 18900,
        0; 19200,0; 19500,0; 19800,0; 20100,0; 20400,0; 20700,0; 21000,0; 21300,
        0; 21600,12061.3502906802; 21900,14181.9387756134; 22200,0; 22500,0; 22800,
        0; 23100,0; 23400,0; 23700,0; 24000,0; 24300,0; 24600,0; 24900,0; 25200,
        0; 25500,0; 25800,0; 26100,0; 26400,0; 26700,0; 27000,0; 27300,0; 27600,
        0; 27900,0; 28200,0; 28500,0; 28800,0; 29100,0; 29400,0; 29700,0; 30000,
        0; 30300,0; 30600,0; 30900,0; 31200,0; 31500,12924.0365108027; 31800,14113.4321236508;
        32100,11376.1653389893; 32400,0; 32700,0; 33000,0; 33300,0; 33600,0; 33900,
        0; 34200,0; 34500,0; 34800,0; 35100,3.52240213405723; 35400,0; 35700,0;
        36000,0; 36300,0; 36600,0; 36900,0; 37200,0; 37500,0; 37800,0; 38100,0;
        38400,0; 38700,0; 39000,0; 39300,0; 39600,0; 39900,0; 40200,0; 40500,0;
        40800,0; 41100,0; 41400,14364.0280005093; 41700,12561.3745013762; 42000,
        9711.16813586089; 42300,62.6956231134459; 42600,0; 42900,0; 43200,0; 43500,
        0; 43800,0; 44100,0; 44400,12261.4572698862; 44700,11787.4322014242; 45000,
        10242.6234041929; 45300,548.263947095562; 45600,0; 45900,0; 46200,0; 46500,
        0; 46800,7359.41899894224; 47100,4871.87527243539; 47400,3359.67867049395;
        47700,2673.48838125837; 48000,6859.33733357862; 48300,10189.6479805664;
        48600,9433.02437319951; 48900,9003.05796802462; 49200,8966.17058965763;
        49500,870.115620311852; 49800,0; 50100,0; 50400,0; 50700,0; 51000,0; 51300,
        0; 51600,0; 51900,12203.041267106; 52200,11912.8096653546; 52500,9198.10781654638;
        52800,8855.46711943022; 53100,7540.9839169118; 53400,0; 53700,0; 54000,0;
        54300,9176.67454501227; 54600,10119.8811378184; 54900,8933.82815392164;
        55200,8660.50927577656; 55500,8441.15094131983; 55800,1636.01170087933;
        56100,0; 56400,0; 56700,0; 57000,9170.66833178927; 57300,10962.5666047407;
        57600,9273.03750847049; 57900,8776.75221196593; 58200,8763.82288754207;
        58500,8343.40665339245; 58800,8308.81448129348; 59100,1664.79185709276;
        59400,0; 59700,0; 60000,0; 60300,1533.06410677284; 60600,14063.3312922608;
        60900,9766.58944140958; 61200,9112.02352230706; 61500,8819.53563294041;
        61800,8770.62334821683; 62100,8784.41825172636; 62400,8788.30748564175;
        62700,4991.4955437243; 63000,0; 63300,0; 63600,0; 63900,8359.34684624408;
        64200,11203.9537097645; 64500,9898.03316025159; 64800,9511.43919394016;
        65100,8629.64773087217; 65400,0; 65700,0; 66000,0; 66300,10463.0731442787;
        66600,10749.1119198659; 66900,10090.3854296505; 67200,9879.84068617448;
        67500,9917.03677189618; 67800,5641.37709247852; 68100,0; 68400,0; 68700,
        4390.39448111887; 69000,12980.9228585087; 69300,11498.7657359049; 69600,
        11151.7974038988; 69900,11039.537090465; 70200,10859.771903302; 70500,10994.9789862472;
        70800,11004.4618940337; 71100,8619.76797493308; 71400,0; 71700,0; 72000,
        0; 72300,9975.58294344891; 72600,12695.4810271385; 72900,11878.0070381611;
        73200,11746.3689988525; 73500,11498.7115150483; 73800,11015.470229566; 74100,
        0; 74400,2654.45494952058; 74700,8375.67811025718; 75000,7993.9667107488;
        75300,13149.3860259612; 75600,12307.1688838415; 75900,3185.22663246582;
        76200,0; 76500,0; 76800,6698.77488247088; 77100,13894.5879227639; 77400,
        12759.3593013929; 77700,12282.4580542905; 78000,12115.2420003284; 78300,
        8114.28862919231; 78600,0; 78900,0; 79200,0; 79500,0; 79800,252.078545807244;
        80100,15394.1177698283; 80400,13551.7519301945; 80700,12697.7631868138;
        81000,7162.99144684866; 81300,0; 81600,0; 81900,0; 82200,0; 82500,0; 82800,
        0; 83100,0; 83400,0; 83700,0; 84000,0; 84300,0; 84600,9192.32617078454;
        84900,14624.2423913189; 85200,13338.3967501766; 85500,13022.5714183419;
        85800,12787.502263903; 86100,12509.0662983275; 86400,12509.0662983275],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-48,-112},{-28,-92}})));

  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,-92})));
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
  CCC.Fluid.BaseClasses.HpSetpointController_Subhrajit
    hpSetpointController_Subhrajit(DomesticHotWaterTempDelta=
        DomesticHotWaterTempDelta)
    annotation (Placement(transformation(extent={{-200,50},{-180,74}})));
  Modelica.Blocks.Sources.Constant const(k=0.92)
    annotation (Placement(transformation(extent={{-270,46},{-250,66}})));
  Modelica.Blocks.Sources.Constant const1(k=TankTempSetpoint)
    annotation (Placement(transformation(extent={{-270,-4},{-250,16}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{-270,86},{-250,106}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0.0,1; 21600,0; 64800,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-320,92},{-300,112}})));
  Modelica.Blocks.Sources.CombiTimeTable OAT(
    table=[0,295.3125; 300,295.133333333333; 600,294.908333333333; 900,294.775;
        1200,294.85; 1500,294.645833333333; 1800,294.304166666667; 2100,294.275;
        2400,294.345833333333; 2700,294.6; 3000,294.716666666667; 3300,
        294.720833333333; 3600,294.775; 3900,294.775; 4200,294.775; 4500,
        294.816666666667; 4800,294.9; 5100,294.783333333333; 5400,
        294.741666666667; 5700,294.133333333333; 6000,293.429166666667; 6300,
        293.433333333333; 6600,293.016666666667; 6900,292.8375; 7200,
        292.658333333333; 7500,292.2625; 7800,291.8875; 8100,291.841666666667;
        8400,291.625; 8700,291.525; 9000,291.366666666667; 9300,291.275; 9600,
        291.175; 9900,291.216666666667; 10200,291.1125; 10500,291.179166666667;
        10800,291.266666666667; 11100,291.05; 11400,290.791666666667; 11700,
        290.616666666667; 12000,290.466666666667; 12300,290.466666666667; 12600,
        290.35; 12900,290.125; 13200,290.025; 13500,290.004166666667; 13800,
        290.233333333333; 14100,290.525; 14400,290.304166666667; 14700,289.975;
        15000,289.941666666667; 15300,289.8375; 15600,289.708333333333; 15900,
        289.754166666667; 16200,290.0375; 16500,290.225; 16800,290.191666666667;
        17100,289.804166666667; 17400,289.595833333333; 17700,289.75; 18000,
        289.566666666667; 18300,289.533333333333; 18600,289.7; 18900,289.775;
        19200,289.8625; 19500,289.716666666667; 19800,289.579166666667; 20100,
        289.720833333333; 20400,289.433333333333; 20700,289.425; 21000,
        289.541666666667; 21300,289.525; 21600,289.525; 21900,289.379166666667;
        22200,289.158333333333; 22500,289.195833333333; 22800,289.533333333333;
        23100,289.666666666667; 23400,289.65; 23700,289.708333333333; 24000,
        289.8875; 24300,290.066666666667; 24600,290.35; 24900,290.645833333333;
        25200,291.070833333333; 25500,291.5375; 25800,291.941666666667; 26100,
        292.241666666667; 26400,292.716666666667; 26700,293.183333333333; 27000,
        293.633333333333; 27300,294.170833333333; 27600,294.708333333333; 27900,
        295.033333333333; 28200,295.208333333333; 28500,295.520833333333; 28800,
        295.845833333333; 29100,296.375; 29400,296.879166666667; 29700,297.2125;
        30000,297.420833333333; 30300,297.854166666667; 30600,298.995833333333;
        30900,298.95; 31200,298.8375; 31500,299.575; 31800,299.4125; 32100,
        299.966666666667; 32400,300.683333333333; 32700,301; 33000,
        301.008333333333; 33300,302.095833333333; 33600,302.129166666667; 33900,
        302.045833333333; 34200,302.591666666667; 34500,302.795833333333; 34800,
        302.8625; 35100,302.479166666667; 35400,302.65; 35700,302.404166666667;
        36000,302.941666666667; 36300,303.4625; 36600,304.170833333333; 36900,
        304.429166666667; 37200,304.641666666667; 37500,304.979166666667; 37800,
        304.6; 38100,305.158333333333; 38400,305.4; 38700,305.475; 39000,
        305.516666666667; 39300,305.933333333333; 39600,306.15; 39900,
        305.908333333333; 40200,305.733333333333; 40500,305.925; 40800,306.175;
        41100,306.616666666667; 41400,306.4; 41700,306.491666666667; 42000,
        306.9; 42300,306.991666666667; 42600,307.458333333333; 42900,
        307.441666666667; 43200,307.916666666667; 43500,308.141666666667; 43800,
        308.266666666667; 44100,308.166666666667; 44400,308.15; 44700,308.275;
        45000,308.3; 45300,308.15; 45600,308.366666666667; 45900,308.4; 46200,
        308.4; 46500,308.85; 46800,309.516666666667; 47100,309.908333333333;
        47400,309.65; 47700,309.65; 48000,309.966666666667; 48300,
        310.366666666667; 48600,310.383333333333; 48900,310.333333333333; 49200,
        310.525; 49500,310.525; 49800,310.575; 50100,310.55; 50400,310.925;
        50700,311.458333333333; 51000,311.775; 51300,311.9; 51600,
        312.158333333333; 51900,312.491666666667; 52200,312.25; 52500,
        312.583333333333; 52800,312.783333333333; 53100,312.9; 53400,
        313.141666666667; 53700,313.4; 54000,313.4; 54300,313.633333333333;
        54600,313.525; 54900,313.475; 55200,313.416666666667; 55500,313.65;
        55800,313.408333333333; 56100,313.566666666667; 56400,313.808333333333;
        56700,313.933333333333; 57000,313.841666666667; 57300,313.225; 57600,
        313.233333333333; 57900,313.216666666667; 58200,313.508333333333; 58500,
        313.65; 58800,313.741666666667; 59100,313.333333333333; 59400,
        313.291666666667; 59700,313.258333333333; 60000,313.633333333333; 60300,
        313.658333333333; 60600,313.466666666667; 60900,313.3; 61200,313.4;
        61500,313.4; 61800,313.4; 62100,313.291666666667; 62400,313.15; 62700,
        312.95; 63000,313.116666666667; 63300,312.941666666667; 63600,312.9;
        63900,312.9; 64200,312.9; 64500,312.708333333333; 64800,312.65; 65100,
        312.641666666667; 65400,312.433333333333; 65700,312.4; 66000,
        312.391666666667; 66300,311.983333333333; 66600,311.9; 66900,311.9;
        67200,311.9; 67500,311.9; 67800,311.733333333333; 68100,311.65; 68400,
        311.341666666667; 68700,310.591666666667; 69000,310.15; 69300,
        309.858333333333; 69600,309.45; 69900,308.791666666667; 70200,308.55;
        70500,307.891666666667; 70800,307.4; 71100,307.4; 71400,307.15; 71700,
        306.933333333333; 72000,306.6; 72300,306.075; 72600,305.616666666667;
        72900,305.1375; 73200,304.391666666667; 73500,303.875; 73800,303.2125;
        74100,302.825; 74400,302.141666666667; 74700,301; 75000,
        300.383333333333; 75300,299.525; 75600,299.15; 75900,299.179166666667;
        76200,299.854166666667; 76500,300.475; 76800,300.791666666667; 77100,
        300.275; 77400,299.520833333333; 77700,299.341666666667; 78000,298.7625;
        78300,298.1625; 78600,297.691666666667; 78900,297.608333333333; 79200,
        296.8625; 79500,296.208333333333; 79800,295.816666666667; 80100,
        295.3625; 80400,295.208333333333; 80700,295.541666666667; 81000,
        296.120833333333; 81300,296.575; 81600,297.15; 81900,297.433333333333;
        82200,296.920833333333; 82500,295.995833333333; 82800,295.141666666667;
        83100,294.7125; 83400,294.454166666667; 83700,294.454166666667; 84000,
        294.575; 84300,295; 84600,295.625; 84900,295.979166666667; 85200,295.25;
        85500,294.3125; 85800,293.9; 86100,294.191666666667; 86400,
        294.191666666667],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-168,-22},{-148,-2}})));
  Buildings.Fluid.HeatExchangers.SensibleCooler_T
                                          coo(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{46,26},{66,46}})));
  Modelica.Blocks.Sources.Constant const2(k=TankTempSetpoint)
    annotation (Placement(transformation(extent={{22,100},{42,120}})));
  Modelica.Blocks.Sources.BooleanConstant bool1(k=false)
    annotation (Placement(transformation(extent={{-254,116},{-234,136}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-118,-44},{-98,-24}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       0.01)
    annotation (Placement(transformation(extent={{-190,-44},{-170,-24}})));
  Modelica.Blocks.Sources.Constant const3(k=0.01)
    annotation (Placement(transformation(extent={{-162,-70},{-142,-50}})));
equation
  connect(fanCoilUnit.port_b2, fan4.port_a) annotation (Line(points={{-14.2,-27},
          {-66,-27},{-66,-46},{40,-46}}, color={0,127,255}));
  connect(fan4.port_b, dummyZone.port_a)
    annotation (Line(points={{60,-46},{95.8,-46}}, color={0,127,255}));
  connect(dummyZone.port_b, fanCoilUnit.port_a2) annotation (Line(points={{116.4,
          -46},{134,-46},{134,-27.2},{6.2,-27.2}}, color={0,127,255}));
  connect(dummyZone.port_b, bou.ports[1]) annotation (Line(points={{116.4,-46},{
          140,-46},{140,-64},{146,-64}}, color={0,127,255}));
  connect(fanCoilUnit.m_flow_air, fan4.m_flow_in) annotation (Line(points={{7.2,
          -30.2},{10,-30.2},{10,-26},{50,-26},{50,-34}}, color={0,0,127}));
  connect(coolingLoad.y[1], gain.u) annotation (Line(points={{-27,-102},{2,-102},
          {2,-92},{10,-92}}, color={0,0,127}));
  connect(gain.y, dummyZone.zoneLoad) annotation (Line(points={{33,-92},{58,-92},
          {58,-40},{94,-40}}, color={0,0,127}));
  connect(val.port_2, aixlib_AirToWaterHeatPump_3D.port_a) annotation (Line(
        points={{-134,44},{-118,44},{-118,51},{-111,51}}, color={0,127,255}));
  connect(val1.port_3, fanCoilUnit.port_a1) annotation (Line(points={{1,42},{1,-8},
          {-20,-8},{-20,-17.6},{-14.2,-17.6}}, color={0,127,255}));
  connect(fanCoilUnit.port_b1, val.port_3) annotation (Line(points={{6.2,-17.6},
          {28,-17.6},{28,4},{-144,4},{-144,34}}, color={0,127,255}));
  connect(aixlib_AirToWaterHeatPump_3D.port_b, pum.port_a) annotation (Line(
        points={{-89.2,50.8},{-77.6,50.8},{-77.6,50},{-66,50}}, color={0,127,255}));
  connect(pum.port_b, val1.port_2) annotation (Line(points={{-46,50},{-16,50},{-16,
          53},{-10,53}}, color={0,127,255}));
  connect(val.port_2, bou1.ports[1]) annotation (Line(points={{-134,44},{-118,44},
          {-118,82},{-108,82}}, color={0,127,255}));
  connect(bool.y, aixlib_AirToWaterHeatPump_3D.OnOff) annotation (Line(points={{
          -145,94},{-122,94},{-122,46},{-111.2,46}}, color={255,0,255}));
  connect(hpSetpointController_Subhrajit.ValCon, val.y) annotation (Line(points=
         {{-178,71.2},{-160,71.2},{-160,72},{-144,72},{-144,56}}, color={0,0,127}));
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
  connect(dummyZone.zoneTemp, fanCoilUnit.TZon) annotation (Line(points={{118,
          -40},{128,-40},{128,-34},{0.4,-34}}, color={0,0,127}));
  connect(combiTimeTable.y[1],realToBoolean. u) annotation (Line(points={{-299,
          102},{-282,102},{-282,96},{-272,96}},
                                              color={0,0,127}));
  connect(OAT.y[1], aixlib_AirToWaterHeatPump_3D.TOutAir) annotation (Line(
        points={{-147,-12},{-147,32},{-128,32},{-128,26},{-84,26},{-84,40.7},{
          -88.7,40.7}},
                  color={0,0,127}));
  connect(val1.port_1, coo.port_a) annotation (Line(points={{12,53},{36,53},{36,
          36},{46,36}}, color={0,127,255}));
  connect(coo.port_b, val.port_1) annotation (Line(points={{66,36},{82,36},{82,
          10},{-162,10},{-162,44},{-154,44}}, color={0,127,255}));
  connect(const2.y, coo.TSet) annotation (Line(points={{43,110},{48,110},{48,52},
          {44,52},{44,44}}, color={0,0,127}));
  connect(bool1.y, hpSetpointController_Subhrajit.RequestDhw) annotation (Line(
        points={{-233,126},{-212,126},{-212,70},{-202,70}}, color={255,0,255}));
  connect(greaterEqualThreshold.y, switch1.u2)
    annotation (Line(points={{-169,-34},{-120,-34}}, color={255,0,255}));
  connect(const3.y, switch1.u3) annotation (Line(points={{-141,-60},{-128,-60},
          {-128,-42},{-120,-42}}, color={0,0,127}));
  connect(fanCoilUnit.m_flow_water, greaterEqualThreshold.u) annotation (Line(
        points={{7.2,-13.8},{12,-13.8},{12,-4},{-192,-4},{-192,-34}}, color={0,
          0,127}));
  connect(fanCoilUnit.m_flow_water, switch1.u1) annotation (Line(points={{7.2,
          -13.8},{-120,-13.8},{-120,-26}}, color={0,0,127}));
  connect(hpSetpointController_Subhrajit.PumSpSpaceConditioning, fanCoilUnit.m_flow_water)
    annotation (Line(points={{-202,61.8},{-202,22},{7.2,22},{7.2,-13.8}}, color=
         {0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Aris_Heat_Pump_Subhrajit_test2;
