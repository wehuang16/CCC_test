within CCC_test.CCC_Model;
model TrcWaterTankGroup_1Tank
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

    parameter Modelica.Units.SI.MassFlowRate mHP_flow_nominal=0.92 "Nominal mass flow rate from the heat pump";
   parameter Modelica.Units.SI.Temperature TankTempSetpoint;
   parameter Modelica.Units.SI.TemperatureDifference TempSetpointHpDeadbandBelow;
   parameter Modelica.Units.SI.TemperatureDifference TempSetpointHpDeadbandAbove;
   parameter Modelica.Units.SI.TemperatureDifference TempSetpointResistanceDeadbandBelow;
   parameter Modelica.Units.SI.TemperatureDifference TempSetpointResistanceDeadbandAbove;
   parameter Modelica.Units.SI.Power ResistanceHeatingPower;
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    use_T_in=false,
    m_flow=0.05,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(extent={{-132,-162},{-112,
            -142}})));
  Buildings.Fluid.Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    VTan=0.2,
    hTan=1.019,
    dIns=0.050,
    nSeg=5,
    T_start=TankTempSetpoint,
    redeclare package MediumHex = MediumPropyleneGlycol,
    hHex_a=1.0189,
    hHex_b=0,
    Q_flow_nominal=18500,
    TTan_nominal=TankTempSetpoint,
    THex_nominal=TankTempSetpoint + 6,
    mHex_flow_nominal=mHP_flow_nominal)
                annotation (Placement(transformation(
        extent={{10,-9},{-10,9}},
        rotation=0,
        origin={-26,-143})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempTankOutlet(redeclare package
      Medium = MediumWater)
    annotation (Placement(transformation(extent={{44,-152},{64,-132}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{102,-144},{122,-124}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumWater,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{178,-150},{158,-132}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempTanBot
    "bottom tank tempearture"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={8,-126})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-140,-206},{-120,-186}}),
        iconTransformation(extent={{-140,-206},{-120,-186}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{176,-168},{196,-148}}),
        iconTransformation(extent={{176,-168},{196,-148}})));
  Modelica.Blocks.Sources.CombiTimeTable hotWaterUse(
    tableOnFile=false,
    table=[0,0.13021238827816; 60,0.0623812712154713; 120,0.129920432250631;
        180,0.130698981657376; 240,0.313366136215004; 300,0.38080797857432; 360,
        0.376428638161378; 420,0.372730528479337; 480,0.373703715237769; 540,
        0.0930366541060696; 600,0; 660,0.111527202516272; 720,0.217896515212855;
        780,0.221691943570739; 840,0.159018716327738; 900,0.0128460652112983;
        960,0.106758587399956; 1020,0.47598564354894; 1080,0.0390247890131108;
        1140,0.00963454890847373; 1200,0; 1260,0; 1320,0; 1380,0; 1440,0; 1500,
        0; 1560,0; 1620,0; 1680,0; 1740,0; 1800,0; 1860,0; 1920,0; 1980,0; 2040,
        0; 2100,0; 2160,0; 2220,0; 2280,0; 2340,0; 2400,0; 2460,0; 2520,0; 2580,
        0; 2640,0; 2700,0; 2760,0; 2820,0; 2880,0; 2940,0; 3000,0; 3060,0; 3120,
        0; 3180,0; 3240,0; 3300,0; 3360,0; 3420,0; 3480,0; 3540,0; 3600,0; 3660,
        0; 3720,0; 3780,0; 3840,0; 3900,0; 3960,0; 4020,0; 4080,0; 4140,0; 4200,
        0; 4260,0; 4320,0; 4380,0; 4440,0; 4500,0; 4560,0; 4620,0; 4680,0; 4740,
        0; 4800,0; 4860,0; 4920,0; 4980,0; 5040,0; 5100,0; 5160,0; 5220,0; 5280,
        0; 5340,0; 5400,0; 5460,0; 5520,0; 5580,0; 5640,0; 5700,0; 5760,0; 5820,
        0; 5880,0; 5940,0; 6000,0; 6060,0; 6120,0; 6180,0; 6240,0; 6300,0; 6360,
        0; 6420,0; 6480,0; 6540,0; 6600,0; 6660,0; 6720,0; 6780,0; 6840,0; 6900,
        0; 6960,0; 7020,0; 7080,0; 7140,0; 7200,0; 7260,0; 7320,0; 7380,0; 7440,
        0; 7500,0; 7560,0; 7620,0; 7680,0; 7740,0; 7800,0; 7860,0; 7920,0; 7980,
        0; 8040,0; 8100,0; 8160,0; 8220,0; 8280,0; 8340,0; 8400,0; 8460,0; 8520,
        0; 8580,0; 8640,0; 8700,0; 8760,0; 8820,0; 8880,0; 8940,0; 9000,0; 9060,
        0; 9120,0; 9180,0; 9240,0; 9300,0; 9360,0; 9420,0; 9480,0; 9540,0; 9600,
        0; 9660,0; 9720,0; 9780,0; 9840,0; 9900,0; 9960,0; 10020,
        0.062186633863785; 10080,0; 10140,0; 10200,0; 10260,0; 10320,0; 10380,0;
        10440,0; 10500,0; 10560,0; 10620,0; 10680,0; 10740,0; 10800,0; 10860,0;
        10920,0; 10980,0; 11040,0; 11100,0; 11160,0; 11220,0; 11280,0; 11340,0;
        11400,0; 11460,0; 11520,0; 11580,0; 11640,0; 11700,0; 11760,0; 11820,0;
        11880,0; 11940,0; 12000,0; 12060,0; 12120,0; 12180,0; 12240,0; 12300,0;
        12360,0; 12420,0; 12480,0; 12540,0; 12600,0; 12660,0; 12720,0; 12780,0;
        12840,0; 12900,0; 12960,0; 13020,0; 13080,0; 13140,0; 13200,0; 13260,0;
        13320,0; 13380,0; 13440,0; 13500,0; 13560,0; 13620,0; 13680,0; 13740,0;
        13800,0; 13860,0; 13920,0; 13980,0; 14040,0; 14100,0; 14160,0; 14220,0;
        14280,0; 14340,0; 14400,0; 14460,0; 14520,0; 14580,0; 14640,0; 14700,0;
        14760,0; 14820,0; 14880,0; 14940,0; 15000,0; 15060,0; 15120,0; 15180,0;
        15240,0; 15300,0; 15360,0; 15420,0; 15480,0; 15540,0; 15600,0; 15660,0;
        15720,0; 15780,0; 15840,0; 15900,0; 15960,0; 16020,0; 16080,0; 16140,0;
        16200,0; 16260,0; 16320,0; 16380,0; 16440,0; 16500,0; 16560,0; 16620,0;
        16680,0; 16740,0; 16800,0; 16860,0; 16920,0; 16980,0; 17040,0; 17100,0;
        17160,0; 17220,0; 17280,0; 17340,0; 17400,0; 17460,0; 17520,0; 17580,0;
        17640,0; 17700,0; 17760,0; 17820,0; 17880,0; 17940,0; 18000,0; 18060,0;
        18120,0; 18180,0; 18240,0; 18300,0; 18360,0; 18420,0; 18480,0; 18540,0;
        18600,0; 18660,0; 18720,0; 18780,0; 18840,0; 18900,0; 18960,0; 19020,0;
        19080,0; 19140,0; 19200,0; 19260,0; 19320,0; 19380,0; 19440,0; 19500,0;
        19560,0; 19620,0; 19680,0; 19740,0; 19800,0; 19860,0; 19920,0; 19980,0;
        20040,0; 20100,0; 20160,0; 20220,0; 20280,0; 20340,0; 20400,0; 20460,0;
        20520,0; 20580,0; 20640,0; 20700,0; 20760,0; 20820,0; 20880,0; 20940,
        0.00768817539161035; 21000,0; 21060,0; 21120,0; 21180,0; 21240,0; 21300,
        0; 21360,0; 21420,0; 21480,0; 21540,0; 21600,0; 21660,0; 21720,0; 21780,
        0; 21840,0; 21900,0; 21960,0; 22020,0; 22080,0; 22140,0; 22200,0; 22260,
        0; 22320,0; 22380,0; 22440,0; 22500,0; 22560,0; 22620,0; 22680,0; 22740,
        0; 22800,0; 22860,0; 22920,0; 22980,0; 23040,0; 23100,0; 23160,0; 23220,
        0; 23280,0; 23340,0; 23400,0; 23460,0; 23520,0; 23580,0; 23640,0; 23700,
        0; 23760,0; 23820,0; 23880,0; 23940,0; 24000,0; 24060,0; 24120,0; 24180,
        0; 24240,0; 24300,0; 24360,0; 24420,0; 24480,0; 24540,0; 24600,0; 24660,
        0; 24720,0; 24780,0; 24840,0; 24900,0; 24960,0; 25020,0; 25080,0; 25140,
        0; 25200,0; 25260,0; 25320,0; 25380,0; 25440,0; 25500,0; 25560,0; 25620,
        0; 25680,0; 25740,0; 25800,0; 25860,0; 25920,0; 25980,0; 26040,0; 26100,
        0; 26160,0; 26220,0; 26280,0; 26340,0; 26400,0; 26460,0; 26520,0; 26580,
        0; 26640,0; 26700,0; 26760,0; 26820,0; 26880,0; 26940,0; 27000,0; 27060,
        0; 27120,0; 27180,0; 27240,0; 27300,0; 27360,0; 27420,0; 27480,0; 27540,
        0; 27600,0; 27660,0; 27720,0; 27780,0; 27840,0; 27900,0; 27960,0; 28020,
        0.429759272523434; 28080,0.465475226557877; 28140,0.340712684126935;
        28200,0.239793217277568; 28260,0; 28320,0; 28380,0; 28440,0; 28500,0;
        28560,0.0241350316091059; 28620,0; 28680,0; 28740,0; 28800,0; 28860,0;
        28920,0; 28980,0.274049391174364; 29040,0.406500108996917; 29100,
        0.379834791815889; 29160,0.35745149637196; 29220,0.364458441032668;
        29280,0.360079100619725; 29340,0.362025474136589; 29400,
        0.454283578835913; 29460,0.370589517610788; 29520,0.488539752732708;
        29580,0.414480240416057; 29640,0.363971847653452; 29700,
        0.367961913363022; 29760,0.356380990937685; 29820,0.36299866089502;
        29880,0.367086045280433; 29940,0.368740462769767; 30000,
        0.217215284481953; 30060,0; 30120,0; 30180,0; 30240,0.0862243467970477;
        30300,0; 30360,0.0864189841487341; 30420,0.347427672760113; 30480,
        0.378277693002398; 30540,0.243199370932079; 30600,0.249914359565258;
        30660,0.0374676901996201; 30720,0.145296783033851; 30780,
        0.0706533586621407; 30840,0; 30900,0; 30960,0; 31020,0.122718850238236;
        31080,0.127487465354551; 31140,0; 31200,0; 31260,0.0642303260564915;
        31320,0.142085266731027; 31380,0; 31440,0; 31500,0; 31560,0; 31620,0;
        31680,0; 31740,0; 31800,0; 31860,0; 31920,0; 31980,0; 32040,0; 32100,0;
        32160,0; 32220,0; 32280,0; 32340,0; 32400,0; 32460,0; 32520,0; 32580,0;
        32640,0; 32700,0; 32760,0.0419443492884058; 32820,0.0150843947556912;
        32880,0; 32940,0; 33000,0; 33060,0; 33120,0; 33180,0.0735729189374358;
        33240,0; 33300,0; 33360,0; 33420,0; 33480,0; 33540,0; 33600,0; 33660,0;
        33720,0.00700694466070817; 33780,0; 33840,0; 33900,0.0977079505465417;
        33960,0.214490361558344; 34020,0.0681230730902183; 34080,0; 34140,0;
        34200,0.0389274703372676; 34260,0.0390247890131108; 34320,
        0.0469076017564075; 34380,0.0537199090654293; 34440,0.00866136215004204;
        34500,0; 34560,0; 34620,0; 34680,0; 34740,0; 34800,0; 34860,0; 34920,0;
        34980,0; 35040,0; 35100,0.00953723023263056; 35160,0; 35220,0; 35280,0;
        35340,0; 35400,0; 35460,0; 35520,0; 35580,0; 35640,0; 35700,0; 35760,0;
        35820,0; 35880,0; 35940,0; 36000,0; 36060,0; 36120,0; 36180,0; 36240,
        0.257699853632712; 36300,0.329034443025754; 36360,0; 36420,0; 36480,
        0.152595683722089; 36540,0; 36600,0; 36660,0; 36720,0; 36780,0; 36840,
        0.077173709943633; 36900,0; 36960,0.105785400641525; 37020,
        0.0864189841487341; 37080,0; 37140,0; 37200,0; 37260,0; 37320,0; 37380,
        0; 37440,0; 37500,0; 37560,0; 37620,0; 37680,0.0172254056242409; 37740,
        0; 37800,0; 37860,0; 37920,0; 37980,0; 38040,0; 38100,0; 38160,0; 38220,
        0; 38280,0; 38340,0; 38400,0; 38460,0; 38520,0; 38580,
        0.0970267198156395; 38640,0.429564635171748; 38700,0.274730621905266;
        38760,0.313366136215004; 38820,0.0800932702189281; 38880,0; 38940,0;
        39000,0.0619919965120986; 39060,0.242031546821961; 39120,
        0.0404845691507583; 39180,0.267626358568715; 39240,0.0151817134315344;
        39300,0; 39360,0; 39420,0.0614080844570396; 39480,0.0899224564790882;
        39540,0; 39600,0; 39660,0; 39720,0; 39780,0; 39840,0; 39900,0; 39960,0;
        40020,0; 40080,0; 40140,0; 40200,0; 40260,0; 40320,0; 40380,0; 40440,0;
        40500,0; 40560,0; 40620,0; 40680,0; 40740,0; 40800,0; 40860,0; 40920,0;
        40980,0; 41040,0.168750583912055; 41100,0; 41160,0.0687069851452773;
        41220,0.157169661486718; 41280,0.0369810968204042; 41340,
        0.0124567905079256; 41400,0.0239403942574196; 41460,0; 41520,0; 41580,0;
        41640,0; 41700,0; 41760,0; 41820,0; 41880,0; 41940,0; 42000,0; 42060,0;
        42120,0; 42180,0.285241038896328; 42240,0.493697642552396; 42300,
        0.721715300052941; 42360,0.400952944473856; 42420,0.354531936096665;
        42480,0.368448506742238; 42540,0.348303540842702; 42600,
        0.365334309115256; 42660,0.36942169350067; 42720,0.363582572950079;
        42780,0.35900859518545; 42840,0.470730435053408; 42900,
        0.496033290772632; 42960,0.389566659400206; 43020,0.327088069508891;
        43080,0; 43140,0; 43200,0; 43260,0; 43320,0; 43380,0; 43440,0; 43500,0;
        43560,0; 43620,0; 43680,0; 43740,0; 43800,0.0516762168727227; 43860,
        0.0364945034411884; 43920,0; 43980,0; 44040,0; 44100,0; 44160,0; 44220,
        0; 44280,0; 44340,0.00544984584721745; 44400,0; 44460,0; 44520,0; 44580,
        0; 44640,0; 44700,0; 44760,0.0506057114384479; 44820,0; 44880,0; 44940,
        0; 45000,0; 45060,0.0180039550309863; 45120,0.0631598206222167; 45180,0;
        45240,0; 45300,0; 45360,0; 45420,0; 45480,0.0114836037494939; 45540,0;
        45600,0; 45660,0; 45720,0; 45780,0; 45840,0; 45900,0; 45960,0; 46020,0;
        46080,0; 46140,0; 46200,0; 46260,0; 46320,0.0451558655912304; 46380,0;
        46440,0; 46500,0; 46560,0; 46620,0.117269004391019; 46680,
        0.125638410513531; 46740,0; 46800,0.0717238640964156; 46860,0; 46920,
        0.113960169412351; 46980,0; 47040,0; 47100,0; 47160,0.0550823705272337;
        47220,0; 47280,0.00739621936408084; 47340,0.227823020148859; 47400,
        0.053525271713743; 47460,0; 47520,0; 47580,0; 47640,0; 47700,
        0.0925500607268537; 47760,0; 47820,0; 47880,0; 47940,0; 48000,0; 48060,
        0; 48120,0; 48180,0; 48240,0; 48300,0.129920432250631; 48360,
        0.0412631185575037; 48420,0; 48480,0.0255948117467534; 48540,
        0.0313366136215004; 48600,0; 48660,0; 48720,0; 48780,0; 48840,0; 48900,
        0; 48960,0; 49020,0; 49080,0; 49140,0; 49200,0; 49260,0; 49320,0; 49380,
        0; 49440,0; 49500,0; 49560,0; 49620,0; 49680,0; 49740,0; 49800,0; 49860,
        0; 49920,0; 49980,0; 50040,0; 50100,0; 50160,0; 50220,0; 50280,0; 50340,
        0; 50400,0; 50460,0; 50520,0; 50580,0; 50640,0; 50700,0; 50760,0; 50820,
        0; 50880,0; 50940,0; 51000,0; 51060,0; 51120,0; 51180,0; 51240,
        0.249817040889415; 51300,0; 51360,0; 51420,0; 51480,0.0412631185575037;
        51540,0; 51600,0; 51660,0; 51720,0; 51780,0; 51840,0; 51900,0; 51960,0;
        52020,0; 52080,0; 52140,0; 52200,0; 52260,0; 52320,0; 52380,
        0.254780293357416; 52440,0; 52500,0.123789355672511; 52560,
        0.478515929120862; 52620,0.233759459375292; 52680,0.186754538943041;
        52740,0; 52800,0; 52860,0; 52920,0; 52980,0; 53040,0; 53100,0; 53160,0;
        53220,0; 53280,0; 53340,0; 53400,0.085251160038616; 53460,0; 53520,
        0.00905063685341472; 53580,0; 53640,0; 53700,0; 53760,0; 53820,0; 53880,
        0.0987784559808166; 53940,0; 54000,0; 54060,0.0567367880165675; 54120,0;
        54180,0; 54240,0; 54300,0; 54360,0.264998754320949; 54420,
        0.0286116906978917; 54480,0.125541091837688; 54540,0.236873657002273;
        54600,0; 54660,0.0151817134315344; 54720,0; 54780,0; 54840,0; 54900,0;
        54960,0.116879729687646; 55020,0; 55080,0.378180374326555; 55140,0;
        55200,0.00992650493600324; 55260,0; 55320,0; 55380,0; 55440,0; 55500,0;
        55560,0.103644389772975; 55620,0; 55680,0.0383435582822086; 55740,0;
        55800,0; 55860,0; 55920,0; 55980,0; 56040,0; 56100,0; 56160,0; 56220,0;
        56280,0; 56340,0; 56400,0; 56460,0; 56520,0; 56580,0; 56640,0; 56700,0;
        56760,0; 56820,0; 56880,0; 56940,0.163398056740681; 57000,0; 57060,0;
        57120,0; 57180,0; 57240,0; 57300,0; 57360,0; 57420,0; 57480,0; 57540,0;
        57600,0; 57660,0; 57720,0; 57780,0; 57840,0; 57900,0; 57960,0; 58020,0;
        58080,0; 58140,0; 58200,0; 58260,0; 58320,0.0926473794026969; 58380,
        0.0504110740867615; 58440,0; 58500,0; 58560,0; 58620,0; 58680,0; 58740,
        0; 58800,0; 58860,0; 58920,0; 58980,0; 59040,0; 59100,
        0.0747407430475538; 59160,0.063938370028962; 59220,0; 59280,0; 59340,
        0.0171280869483977; 59400,0.00496325246800162; 59460,0; 59520,0; 59580,
        0; 59640,0; 59700,0; 59760,0; 59820,0; 59880,0; 59940,0; 60000,0; 60060,
        0; 60120,0; 60180,0; 60240,0; 60300,0; 60360,0; 60420,0; 60480,0; 60540,
        0; 60600,0; 60660,0; 60720,0; 60780,0; 60840,0; 60900,0; 60960,0; 61020,
        0; 61080,0; 61140,0; 61200,0; 61260,0; 61320,0; 61380,0; 61440,0; 61500,
        0; 61560,0; 61620,0; 61680,0; 61740,0; 61800,0; 61860,0; 61920,0; 61980,
        0; 62040,0; 62100,0; 62160,0; 62220,0; 62280,0; 62340,0; 62400,0; 62460,
        0; 62520,0; 62580,0; 62640,0; 62700,0; 62760,0; 62820,0; 62880,0; 62940,
        0; 63000,0; 63060,0; 63120,0; 63180,0; 63240,0; 63300,0; 63360,
        0.050119118059232; 63420,0; 63480,0; 63540,0; 63600,0; 63660,0; 63720,0;
        63780,0; 63840,0; 63900,0; 63960,0; 64020,0.418178350098097; 64080,
        0.2229570863567; 64140,0; 64200,0; 64260,0; 64320,0; 64380,0; 64440,0;
        64500,0; 64560,0; 64620,0; 64680,0; 64740,0; 64800,0; 64860,
        0.204758493974028; 64920,0.39890925228115; 64980,0.404164460776681;
        65040,0.391221076889539; 65100,0.396573604060914; 65160,
        0.383046308118713; 65220,0; 65280,0.00622839525396282; 65340,0; 65400,0;
        65460,0; 65520,0; 65580,0; 65640,0.216242097723522; 65700,
        0.545179222073433; 65760,0.557733331257201; 65820,0.43851795334932;
        65880,0.438323315997633; 65940,0.422752327862726; 66000,
        0.436279623804927; 66060,0.437544766590888; 66120,0.328645168322382;
        66180,0.31171171872567; 66240,0.343924200429759; 66300,
        0.339934134720189; 66360,0.300812027031235; 66420,0.309473389181277;
        66480,0.297795148080097; 66540,0.303536949954844; 66600,
        0.0804825449223008; 66660,0; 66720,0; 66780,0; 66840,0; 66900,
        0.00827208744666937; 66960,0; 67020,0; 67080,0; 67140,0; 67200,0; 67260,
        0; 67320,0; 67380,0; 67440,0; 67500,0; 67560,0; 67620,0; 67680,0; 67740,
        0; 67800,0; 67860,0; 67920,0; 67980,0; 68040,0; 68100,0; 68160,0; 68220,
        0; 68280,0; 68340,0; 68400,0; 68460,0; 68520,0; 68580,0; 68640,0; 68700,
        0; 68760,0; 68820,0; 68880,0; 68940,0; 69000,0; 69060,0; 69120,0; 69180,
        0; 69240,0; 69300,0; 69360,0; 69420,0; 69480,0; 69540,0; 69600,
        0.118826103204509; 69660,0; 69720,0; 69780,0; 69840,0; 69900,0; 69960,0;
        70020,0.119993927314627; 70080,0; 70140,0; 70200,0; 70260,0; 70320,
        0.289523060633428; 70380,0.424990657407119; 70440,0.399687801687895;
        70500,0.0327963937591479; 70560,0.0304607455389119; 70620,
        0.159797265734483; 70680,0.264122886238361; 70740,0.256142754819221;
        70800,0.255364205412475; 70860,0.270740556195696; 70920,
        0.0674418423593161; 70980,0; 71040,0; 71100,0.0780495780262215; 71160,
        0.254196381302357; 71220,0; 71280,0.264609479617577; 71340,
        0.0344508112484818; 71400,0; 71460,0.0338668991934228; 71520,
        0.0108023730185918; 71580,0.116198498956744; 71640,0.13634346485628;
        71700,0; 71760,0; 71820,0; 71880,0; 71940,0; 72000,0; 72060,0; 72120,0;
        72180,0.0310446575939709; 72240,0; 72300,0.0378569649029927; 72360,
        0.0642303260564915; 72420,0.0536225903895861; 72480,0; 72540,0; 72600,
        0.0239403942574196; 72660,0; 72720,0; 72780,0; 72840,0; 72900,
        0.0653981501666096; 72960,0; 73020,0; 73080,0.0441826788327987; 73140,0;
        73200,0; 73260,0; 73320,0; 73380,0; 73440,0; 73500,0.0678311170626888;
        73560,0; 73620,0; 73680,0; 73740,0; 73800,0; 73860,0.0670525676559434;
        73920,0; 73980,0; 74040,0; 74100,0; 74160,0; 74220,0; 74280,0; 74340,0;
        74400,0; 74460,0; 74520,0; 74580,0; 74640,0; 74700,0; 74760,0; 74820,0;
        74880,0.0545957771480178; 74940,0.0105104169910623; 75000,
        0.0349374046276977; 75060,0.0350347233035408; 75120,0.0168361309208682;
        75180,0; 75240,0; 75300,0; 75360,0; 75420,0; 75480,0; 75540,0; 75600,
        0.0449612282395441; 75660,0.0875868082588521; 75720,0.042625580019308;
        75780,0.0137219332938868; 75840,0.019561053844477; 75900,0; 75960,
        0.00515788981968796; 76020,0; 76080,0; 76140,0; 76200,0; 76260,
        0.0133326585905141; 76320,0; 76380,0; 76440,0.0134299772663573; 76500,0;
        76560,0; 76620,0.0178093176792999; 76680,0; 76740,0; 76800,0; 76860,0;
        76920,0; 76980,0; 77040,0; 77100,0; 77160,0; 77220,0; 77280,0; 77340,0;
        77400,0; 77460,0.0203396032512223; 77520,0.00739621936408084; 77580,0;
        77640,0; 77700,0; 77760,0; 77820,0; 77880,0; 77940,0; 78000,0; 78060,0;
        78120,0; 78180,0.0437934041294261; 78240,0; 78300,0; 78360,0; 78420,
        0.092160786023481; 78480,0.104325620503877; 78540,0.0377596462271496;
        78600,0; 78660,0.0587804802092741; 78720,0.115225312198312; 78780,0;
        78840,0; 78900,0; 78960,0; 79020,0; 79080,0; 79140,0; 79200,0; 79260,0;
        79320,0; 79380,0; 79440,0; 79500,0; 79560,0; 79620,0; 79680,0; 79740,0;
        79800,0; 79860,0; 79920,0; 79980,0; 80040,0; 80100,0; 80160,0; 80220,0;
        80280,0.0848618853352434; 80340,0.0611161284295101; 80400,0; 80460,
        0.0151817134315344; 80520,0.0221886580922425; 80580,0; 80640,0; 80700,0;
        80760,0; 80820,0; 80880,0; 80940,0.492627137118122; 81000,
        0.238041481112391; 81060,0.296627323969979; 81120,0; 81180,
        0.0543038211204883; 81240,0.250206315592787; 81300,0.289231104605898;
        81360,0.222665130329171; 81420,0.244561832393884; 81480,
        0.399201208308679; 81540,0.12836333343714; 81600,0; 81660,
        0.0916741926442652; 81720,0.0887546323689701; 81780,0.364069166329295;
        81840,0.112889663978076; 81900,0; 81960,0.0582938868300582; 82020,0;
        82080,0; 82140,0; 82200,0; 82260,0; 82320,0; 82380,0.0131380212388278;
        82440,0.0551796892030768; 82500,0.279401918345738; 82560,
        0.358716639157921; 82620,0.0998489614150914; 82680,0.0964428077605805;
        82740,0.382754352091184; 82800,0.162522188658092; 82860,0; 82920,
        0.0911875992650494; 82980,0; 83040,0; 83100,0.0162522188658092; 83160,
        0.062770545918844; 83220,0.0296821961321665; 83280,0.0427228986951512;
        83340,0; 83400,0; 83460,0.101114104201053; 83520,0.208748559683598;
        83580,0.0515788981968796; 83640,0; 83700,0; 83760,0; 83820,
        0.0411657998816605; 83880,0.113473576033135; 83940,0.00836940612251253;
        84000,0; 84060,0.0492432499766435; 84120,0.0682203917660615; 84180,
        0.0667606116284139; 84240,0.0498271620317025; 84300,0; 84360,
        0.186851857618884; 84420,0.121648344803961; 84480,0.16398196879574;
        84540,0.239111986546666; 84600,0.0451558655912304; 84660,0; 84720,0;
        84780,0; 84840,0; 84900,0; 84960,0; 85020,0; 85080,0; 85140,0; 85200,0;
        85260,0; 85320,0; 85380,0; 85440,0; 85500,0; 85560,0; 85620,0; 85680,0;
        85740,0.0222859767680857; 85800,0; 85860,0; 85920,0; 85980,0; 86040,0;
        86100,0; 86160,0; 86220,0; 86280,0; 86340,0; 86400,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-116,-96},{-96,-76}})));
  Modelica.Blocks.Math.Gain UnitConversion(k=0.06309)
    "convert gpm to kg/s for water, assuming 1000kg/m3 for water"
    annotation (Placement(transformation(extent={{-76,-94},{-56,-74}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempTanTop
    "top tank tempearture" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,-196})));
  Modelica.Blocks.Logical.Hysteresis HpHysteresis(uLow=TankTempSetpoint +
        TempSetpointHpDeadbandBelow, uHigh=TankTempSetpoint +
        TempSetpointHpDeadbandAbove,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{42,-116},{62,-96}})));
  Modelica.Blocks.Logical.Hysteresis ResistanceHysteresis(uLow=TankTempSetpoint
         + TempSetpointResistanceDeadbandBelow,
                                             uHigh=TankTempSetpoint +
        TempSetpointResistanceDeadbandAbove)
    annotation (Placement(transformation(extent={{10,-242},{30,-222}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo[5]
    annotation (Placement(transformation(extent={{192,-244},{212,-224}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{80,-114},{100,-94}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{42,-242},{62,-222}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realTrue=
        ResistanceHeatingPower)
    annotation (Placement(transformation(extent={{74,-242},{94,-222}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput
                                           RequestDhw
    "True if domestic hot water is requested" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={104,-40})));
  Modelica.Blocks.Sources.Constant const(k=TankTempSetpoint)
    annotation (Placement(transformation(extent={{-102,-272},{-82,-252}})));
  Modelica.Blocks.Interfaces.RealOutput HotWaterTankTempSetpoint annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-140,-252})));
  Buildings.Fluid.Sensors.VolumeFlowRate DHWTanHeaPumFlo(redeclare package
      Medium = MediumPropyleneGlycol, m_flow_nominal=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-126})));
  Buildings.Fluid.Sensors.VolumeFlowRate DHWTanHeaLoaFlo(redeclare package
      Medium = MediumPropyleneGlycol, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-74,-152},{-54,-132}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHxInlet(redeclare package
      Medium = MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-66,-194},{-46,-174}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHxOutlet(redeclare package
      Medium = MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{96,-190},{116,-170}})));
  CCC.Controls.EnergyFlowSensor energyFlowSensor(redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-38,-222},{-18,-202}})));
  Modelica.Blocks.Interfaces.RealOutput ThermalPowerFromHeatPump annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,-320})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-44,-254})));
  Modelica.Blocks.Math.Gain gain1(k=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={116,-232})));
  Modelica.Blocks.Interfaces.RealOutput ThermalPowerFromResistanceElement
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-22,-320})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-122,-60},{-102,-40}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=5)         annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={148,-236})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt
    annotation (Placement(transformation(extent={{232,-92},{252,-72}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput hotWatScaFac
    "hot water scaling factor" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-160,-88})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{-36,-88},{-16,-68}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = MediumPropyleneGlycol,
    m_flow_nominal=mHP_flow_nominal,
    dpValve_nominal=1)
    annotation (Placement(transformation(extent={{-114,-206},{-94,-186}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal    booToRea
    annotation (Placement(transformation(extent={{278,-122},{298,-102}})));
equation
  connect(tan.port_a, tempTankOutlet.port_a) annotation (Line(points={{-26,-134},
          {14,-134},{14,-142},{44,-142}}, color={0,127,255}));
  connect(tempTankOutlet.port_b, senMasFlo.port_a) annotation (Line(points={{64,
          -142},{96,-142},{96,-134},{102,-134}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary1.ports[1]) annotation (Line(points={{122,
          -134},{152,-134},{152,-141},{158,-141}},     color={0,127,255}));
  connect(tan.heaPorVol[5], tempTanBot.port) annotation (Line(points={{-26,
          -142.784},{-26,-158},{-8,-158},{-8,-126},{-2,-126}}, color={191,0,0}));
  connect(tempTanTop.port, tan.heaPorVol[1]) annotation (Line(points={{12,-196},
          {-6,-196},{-6,-158},{-26,-158},{-26,-143.216}}, color={191,0,0}));
  connect(tempTanBot.T, HpHysteresis.u) annotation (Line(points={{19,-126},{28,-126},
          {28,-106},{40,-106}}, color={0,0,127}));
  connect(tempTanTop.T, ResistanceHysteresis.u) annotation (Line(points={{33,-196},
          {38,-196},{38,-216},{-2,-216},{-2,-232},{8,-232}}, color={0,0,127}));
  connect(HpHysteresis.y, not1.u) annotation (Line(points={{63,-106},{63,-104},{
          78,-104}}, color={255,0,255}));
  connect(ResistanceHysteresis.y, not2.u)
    annotation (Line(points={{31,-232},{40,-232}}, color={255,0,255}));
  connect(not2.y, booleanToReal1.u)
    annotation (Line(points={{63,-232},{72,-232}}, color={255,0,255}));
  connect(const.y, HotWaterTankTempSetpoint) annotation (Line(points={{-81,-262},
          {-76,-262},{-76,-260},{-74,-260},{-74,-252},{-140,-252}}, color={0,0,
          127}));
  connect(boundary.ports[1], DHWTanHeaLoaFlo.port_a) annotation (Line(points={{
          -112,-152},{-78,-152},{-78,-142},{-74,-142}}, color={0,127,255}));
  connect(DHWTanHeaLoaFlo.port_b, tan.port_b) annotation (Line(points={{-54,
          -142},{-45,-142},{-45,-152},{-26,-152}}, color={0,127,255}));
  connect(tan.portHex_b, tempHxOutlet.port_a) annotation (Line(points={{-16,
          -150.2},{38,-150.2},{38,-180},{96,-180}}, color={0,127,255}));
  connect(tempHxOutlet.port_b, port_b) annotation (Line(points={{116,-180},{150,
          -180},{150,-158},{186,-158}}, color={0,127,255}));
  connect(tempHxInlet.port_b, energyFlowSensor.port_a) annotation (Line(points={{-46,
          -184},{-40,-184},{-40,-168},{-72,-168},{-72,-212.4},{-38.2,-212.4}},
                                                               color={0,127,255}));
  connect(energyFlowSensor.port_b, DHWTanHeaPumFlo.port_a) annotation (Line(
        points={{-17.8,-212.4},{-12,-212.4},{-12,-160},{-86,-160},{-86,-142},{
          -90,-142},{-90,-136}},                                    color={0,
          127,255}));
  connect(tempHxOutlet.T, energyFlowSensor.TempSupply) annotation (Line(points={{106,
          -169},{106,-164},{-27.8,-164},{-27.8,-200.8}},                color={
          0,0,127}));
  connect(energyFlowSensor.Q_flow, gain.u) annotation (Line(points={{-27.4,-223},
          {-27.4,-232},{-44,-232},{-44,-242}}, color={0,0,127}));
  connect(gain.y, ThermalPowerFromHeatPump) annotation (Line(points={{-44,-265},
          {-46,-265},{-46,-286},{-86,-286},{-86,-320},{-80,-320}}, color={0,0,
          127}));
  connect(booleanToReal1.y, gain1.u) annotation (Line(points={{95,-232},{104,
          -232}},            color={0,0,127}));
  connect(booleanToReal1.y, ThermalPowerFromResistanceElement) annotation (Line(
        points={{95,-232},{95,-240},{98,-240},{98,-294},{-22,-294},{-22,-320}},
                                                          color={0,0,127}));
  connect(hotWaterUse.y[1], UnitConversion.u) annotation (Line(points={{-95,-86},
          {-86,-86},{-86,-84},{-78,-84}}, color={0,0,127}));
  connect(DHWTanHeaPumFlo.port_b, tan.portHex_a) annotation (Line(points={{-90,
          -116},{-16,-116},{-16,-146.42}}, color={0,127,255}));
  connect(gain1.y, replicator.u) annotation (Line(points={{127,-232},{164,-232},
          {164,-262},{128,-262},{128,-236},{136,-236}}, color={0,0,127}));
  connect(replicator.y, preHeaFlo.Q_flow) annotation (Line(points={{159,-236},{
          184,-236},{184,-234},{192,-234}}, color={0,0,127}));
  connect(tan.heaPorVol, preHeaFlo.port) annotation (Line(points={{-26,-143},{
          -4,-143},{-4,-146},{234,-146},{234,-234},{212,-234}}, color={191,0,0}));
  connect(booToInt.y, RequestDhw) annotation (Line(points={{254,-82},{262,-82},
          {262,-66},{104,-66},{104,-40}}, color={255,127,0}));
  connect(UnitConversion.y, mul.u2)
    annotation (Line(points={{-55,-84},{-38,-84}}, color={0,0,127}));
  connect(mul.u1, hotWatScaFac) annotation (Line(points={{-38,-72},{-50,-72},{
          -50,-68},{-134,-68},{-134,-88},{-160,-88}}, color={0,0,127}));
  connect(mul.y, boundary.m_flow_in) annotation (Line(points={{-14,-78},{-8,-78},
          {-8,-80},{-4,-80},{-4,-100},{-132,-100},{-132,-144}}, color={0,0,127}));
  connect(port_a, val.port_a)
    annotation (Line(points={{-130,-196},{-114,-196}}, color={0,127,255}));
  connect(val.port_b, tempHxInlet.port_a) annotation (Line(points={{-94,-196},{
          -76,-196},{-76,-184},{-66,-184}}, color={0,127,255}));
  connect(booToRea.y, val.y) annotation (Line(points={{300,-112},{300,-142},{
          -104,-142},{-104,-184}}, color={0,0,127}));
  connect(not1.y, booToInt.u) annotation (Line(points={{101,-104},{150,-104},{
          150,-82},{230,-82}}, color={255,0,255}));
  connect(not1.y, booToRea.u) annotation (Line(points={{101,-104},{266,-104},{
          266,-112},{276,-112}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -300},{180,-60}}), graphics={
        Rectangle(
          extent={{-18,-96},{62,-136}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,-176},{62,-216}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-2},{30,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={144,-156},
          rotation=360),
        Rectangle(
          extent={{-40,-2},{40,2}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={62,-74},
          rotation=360),
        Rectangle(
          extent={{-2,-43},{2,43}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          origin={102,-115},
          rotation=360),
        Rectangle(
          extent={{22,-72},{18,-96}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{114,-154},{100,-158}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,-136},{62,-176}},
          lineColor={255,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{12,-146},{32,-166}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Rectangle(
          extent={{72,-88},{62,-222}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,-90},{-28,-224}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,-88},{72,-96}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,-216},{72,-224}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{48,-84},{124,-84},{122,-84}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{78,-150},{78,-84},{80,-84}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{44,-230},{92,-230},{92,-84}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{-18,-136},{62,-176}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{12,-146},{32,-166}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-18,-88},{-28,-222}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{72,-88},{62,-222}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-120,-196},{50,-198}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-48,-206},{50,-210}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-120,-234},{-46,-238}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,-206},{-46,-236}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{18,-204},{50,-206}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Rectangle(
          extent={{18,-198},{50,-202}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-200},{20,-204}},
          pattern=LinePattern.None,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-300},{180,
            -60}})));
end TrcWaterTankGroup_1Tank;
