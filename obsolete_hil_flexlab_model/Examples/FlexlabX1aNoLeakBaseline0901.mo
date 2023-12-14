within CCC_test.obsolete_hil_flexlab_model.Examples;
model FlexlabX1aNoLeakBaseline0901
  "DR mode - Variable air volume flow system with terminal reheat and five thermal zones at Flexlab X1 cell"
  extends Modelica.Icons.Example;
  extends
    CCC_test.obsolete_hil_flexlab_model.BaseClasses.PartialOpenLoopX1aNoLeakage0830(
                                                      occSch(
      occupancy={0,86399},
      firstEntryOccupied=true,
      period=86400), fanSup(per(use_powerCharacteristic=true, power(V_flow={
              0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4}, P={367,396,425,454,483,512,
              541,570}))));
//  extends BaseClasses.PartialOpenLoopX1aV1(min(nin=3),
//      ave(nin=3));

  parameter Modelica.Units.SI.VolumeFlowRate VPriSysMax_flow=m_flow_nominal/1.2
    "Maximum expected system primary airflow rate at design stage";
  parameter Modelica.Units.SI.VolumeFlowRate minZonPriFlo[numZon]={
      mCor_flow_nominal,mSou_flow_nominal,mNor_flow_nominal}/1.2
    "Minimum expected zone primary flow rate";
  parameter Modelica.Units.SI.Time samplePeriod=120
    "Sample period of component, set to the same value as the trim and respond that process yPreSetReq";
  parameter Modelica.Units.SI.PressureDifference dpDisRetMax=40
    "Maximum return fan discharge static pressure setpoint";

  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVNor(
    V_flow_nominal=mNor_flow_nominal/1.2,
    AFlo=AFloNor,
    final samplePeriod=samplePeriod,
    kDam=0.5,
    VDisSetMin_flow=0.3*mNor_flow_nominal/1.2,
    VDisConMin_flow=0.2*mNor_flow_nominal/1.2,
    dTDisZonSetMax=5,
    TDisMin=285.95)                  "Controller for terminal unit north zone"
    annotation (Placement(transformation(extent={{654,4},{674,24}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVCor(
    V_flow_nominal=mCor_flow_nominal/1.2,
    AFlo=AFloCor,
    final samplePeriod=samplePeriod,
    VDisSetMin_flow=0.3*mCor_flow_nominal/1.2,
    VDisConMin_flow=0.2*mCor_flow_nominal/1.2,
    dTDisZonSetMax=5,
    TDisMin=285.95)                  "Controller for terminal unit mid zone"
    annotation (Placement(transformation(extent={{778,104},{798,124}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.Controller conVAVSou(
    V_flow_nominal=mSou_flow_nominal/1.2,
    AFlo=AFloSou,
    final samplePeriod=samplePeriod,
    VDisSetMin_flow=0.2625*mSou_flow_nominal/1.2,
    VDisConMin_flow=0.2625*mSou_flow_nominal/1.2,
    dTDisZonSetMax=5,
    TDisMin=285.95)   "Controller for terminal unit south zone"
    annotation (Placement(transformation(extent={{1020,32},{1040,52}})));
  Modelica.Blocks.Routing.Multiplex3 TDis "Discharge air temperatures"
    annotation (Placement(transformation(extent={{110,276},{130,296}})));
  Modelica.Blocks.Routing.Multiplex3 VDis_flow
    "Air flow rate at the terminal boxes"
    annotation (Placement(transformation(extent={{176,242},{196,262}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum TZonResReq(nin=3)
    "Number of zone temperature requests"
    annotation (Placement(transformation(extent={{298,288},{318,308}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum PZonResReq(nin=3)
    "Number of zone pressure requests"
    annotation (Placement(transformation(extent={{300,254},{320,274}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yOutDam(k=1)
    "Outdoor air damper control signal"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

  Buildings.Controls.OBC.CDL.Continuous.Switch swiFreSta
    "Switch for freeze stat"
    annotation (Placement(transformation(extent={{60,-202},{80,-182}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant freStaSetPoi1(k=273.15
         + 3) "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant yFreHeaCoi(final k=1)
    "Flow rate signal for heating coil when freeze stat is on"
    annotation (Placement(transformation(extent={{0,-192},{20,-172}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep(final nout=
        numZon) "Replicate real input"
    annotation (Placement(transformation(extent={{-144,350},{-124,370}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(final nout=
        numZon) "Replicate boolean input"
    annotation (Placement(transformation(extent={{-146,316},{-126,336}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.ModeAndSetPoints TZonSet[numZon](
    final TZonHeaOn=fill(273.15 + 21.1, numZon),
    final TZonHeaOff=fill(THeaOff, numZon),
    TZonCooOn=fill(273.15 + 23.3, numZon),
    final TZonCooOff=fill(TCooOff, numZon)) "Zone setpoint temperature"
    annotation (Placement(transformation(extent={{-32,322},{-12,342}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.OutdoorAirFlow.Zone
    zonOutAirSet[numZon](
    final AFlo=AFlo,
    final have_occSen=fill(false, numZon),
    final have_winSen=fill(false, numZon),
    final desZonPop={0.05*AFlo[i] for i in 1:numZon},
    final minZonPriFlo=minZonPriFlo)
    "Zone level calculation of the minimum outdoor airflow setpoint"
    annotation (Placement(transformation(extent={{228,420},{248,440}})));
  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator reaRep1(final nout=
        numZon) "Replicate design uncorrected minimum outdoor airflow setpoint"
    annotation (Placement(transformation(extent={{480,478},{500,498}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep1(final nout=
       numZon) "Replicate signal whether the outdoor airflow is required"
    annotation (Placement(transformation(extent={{480,438},{500,458}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.OutdoorAirFlow.SumZone
    zonToSys(final numZon=numZon) "Sum up zone calculation output"
    annotation (Placement(transformation(extent={{274,420},{294,440}})));
  Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Controller conAHU(
    retDamPhyPosMax=0.7,
    outDamPhyPosMin=0.3,
    pMinSet=250,
    final pMaxSet=250,
    pTriAmo=0,
    pResAmo=0,
    final yFanMin=yFanMin,
    final VPriSysMax_flow=VPriSysMax_flow,
    final peaSysPop=2*sum({0.05*AFlo[i] for i in 1:numZon}),
    TSupSetMin=284.55,
    TSupSetMax=284.55,
    TSupSetDes=284.55,
    numIgnReqSupTem=0,
    triAmoSupTem=0,
    resAmoSupTem=0)                                            "AHU controller"
    annotation (Placement(transformation(extent={{360,418},{440,546}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-124,446},{-144,466}})));
  Modelica.Blocks.Sources.CombiTimeTable cooSetDR(
    table=[0,3.4; 5,3.4; 5,2.2; 6,2.2; 6,1.7; 7,1.7; 7,0; 22,0; 22,3.4; 24,3.4],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600) "cooling schedule for demand response"
    annotation (Placement(transformation(extent={{-142,400},{-122,420}})));
  Modelica.Blocks.Sources.CombiTimeTable heaSetDR(
    table=[0,-5.5; 5,-5.5; 5,-3.3; 6,-3.3; 6,-1.7; 7,-1.7; 7,0; 22,0; 22,-5.5; 24,
        -5.5],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600) "heating schedule for demand response"
    annotation (Placement(transformation(extent={{-140,222},{-120,242}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-122,270},{-142,290}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant ecoHigCut(k=273.15 + 18)
    "economizer high cut off temp"
    annotation (Placement(transformation(extent={{66,472},{86,492}})));
equation
  connect(fanSup.port_b, dpDisSupFan.port_a) annotation (Line(
      points={{320,-40},{320,0},{320,-10},{320,-10}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
  connect(TRooAir.y2[1], conVAVCor.TZon) annotation (Line(
      points={{511,170},{766,170},{766,114},{776,114}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TSupNor.T, conVAVNor.TDis) annotation (Line(points={{697,90},{638,90},
          {638,9},{652,9}},   color={0,0,127}));
  connect(TSupCor.T, conVAVCor.TDis) annotation (Line(points={{869,94},{762,94},
          {762,109},{776,109}},
                              color={0,0,127}));
  connect(TSupSou.T, conVAVSou.TDis) annotation (Line(points={{1069,90},{1002,
          90},{1002,37},{1018,37}}, color={0,0,127}));
  connect(conVAVNor.yDam,nor.yVAV)  annotation (Line(points={{676,20},{688,20},{
          688,46},{694,46}}, color={0,0,127}));
  connect(conVAVNor.yVal,nor.yVal)  annotation (Line(points={{676,15},{684,15},{
          684,30},{694,30}},    color={0,0,127}));
  connect(conVAVCor.yVal, cor.yVal) annotation (Line(points={{800,115},{808,115},
          {808,36},{866,36}},   color={0,0,127}));
  connect(conVAVCor.yDam, cor.yVAV) annotation (Line(points={{800,120},{836,120},
          {836,52},{866,52}}, color={0,0,127}));
  connect(conVAVSou.yDam, sou.yVAV) annotation (Line(points={{1042,48},{1048,48},
          {1048,44},{1066,44}},       color={0,0,127}));
  connect(conVAVSou.yVal, sou.yVal) annotation (Line(points={{1042,43},{1042,40},
          {1056,40},{1056,28},{1066,28}},
                                      color={0,0,127}));

  connect(conVAVNor.yZonTemResReq, TZonResReq.u[1]) annotation (Line(points={{676,
          15.6667},{750,15.6667},{750,224},{270,224},{270,295.667},{296,295.667}},
                                                                         color=
          {255,127,0}));
  connect(conVAVCor.yZonTemResReq, TZonResReq.u[2]) annotation (Line(points={{800,
          115.667},{808,115.667},{808,240},{274,240},{274,298},{296,298}},
                                                                     color={255,
          127,0}));
  connect(conVAVSou.yZonTemResReq, TZonResReq.u[3]) annotation (Line(points={{1042,
          43.6667},{1054,43.6667},{1054,216},{278,216},{278,300.333},{296,
          300.333}},
        color={255,127,0}));
  connect(conVAVNor.yZonPreResReq, PZonResReq.u[1]) annotation (Line(points={{676,
          12.3333},{758,12.3333},{758,236},{284,236},{284,261.667},{298,261.667}},
                                                                         color=
          {255,127,0}));
  connect(conVAVCor.yZonPreResReq, PZonResReq.u[2]) annotation (Line(points={{800,
          112.333},{814,112.333},{814,246},{288,246},{288,264},{298,264}},
                                                                     color={255,
          127,0}));
  connect(conVAVSou.yZonPreResReq, PZonResReq.u[3]) annotation (Line(points={{1042,
          40.3333},{1060,40.3333},{1060,224},{292,224},{292,266.333},{298,
          266.333}},
        color={255,127,0}));
  connect(VSupNor_flow.V_flow,conVAVNor. VDis_flow) annotation (Line(points={{697,128},
          {632,128},{632,12.3333},{652,12.3333}},
                                             color={0,0,127}));
  connect(VSupCor_flow.V_flow, conVAVCor.VDis_flow) annotation (Line(points={{869,134},
          {764,134},{764,112.333},{776,112.333}},color={0,0,127}));
  connect(VSupSou_flow.V_flow, conVAVSou.VDis_flow) annotation (Line(points={{1069,
          128},{1008,128},{1008,40.3333},{1018,40.3333}},
                                                     color={0,0,127}));
  connect(TSup.T,conVAVNor. TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{546,-20},{546,7.33333},{652,7.33333}},
                                        color={0,0,127}));
  connect(TSup.T, conVAVCor.TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{764,-20},{764,107.333},{776,107.333}},
                                             color={0,0,127}));
  connect(TSup.T, conVAVSou.TSupAHU) annotation (Line(points={{340,-29},{340,
          -20},{678,-20},{678,35.3333},{1018,35.3333}},
                                           color={0,0,127}));
  connect(yOutDam.y, eco.yExh)
    annotation (Line(points={{-18,-10},{-3,-10},{-3,-34}}, color={0,0,127}));
  connect(swiFreSta.y, gaiHeaCoi.u) annotation (Line(points={{82,-192},{88,-192},
          {88,-210},{98,-210}}, color={0,0,127}));
  connect(freSta.y, swiFreSta.u2) annotation (Line(points={{22,-92},{40,-92},{40,
          -192},{58,-192}},    color={255,0,255}));
  connect(yFreHeaCoi.y, swiFreSta.u1) annotation (Line(points={{22,-182},{40,-182},
          {40,-184},{58,-184}}, color={0,0,127}));
  connect(occSch.tNexNonOcc, reaRep.u) annotation (Line(points={{-297,-210},{-236,
          -210},{-236,360},{-146,360}}, color={0,0,127}));
  connect(occSch.occupied, booRep.u) annotation (Line(points={{-297,-216},{-232,
          -216},{-232,326},{-148,326}}, color={255,0,255}));
  connect(reaRep.y, TZonSet.tNexOcc) annotation (Line(points={{-122,360},{-78,360},
          {-78,341},{-34,341}}, color={0,0,127}));
  connect(booRep.y, TZonSet.uOcc) annotation (Line(points={{-124,326},{-80,326},
          {-80,338.025},{-34,338.025}}, color={255,0,255}));
  connect(conVAVSou.uOpeMod, TZonSet[1].yOpeMod) annotation (Line(points={{1018,32},
          {502,32},{502,325},{-10,325}},       color={255,127,0}));
  connect(conVAVCor.uOpeMod, TZonSet[1].yOpeMod) annotation (Line(points={{776,104},
          {34,104},{34,325},{-10,325}},color={255,127,0}));
  connect(conVAVNor.uOpeMod, TZonSet[1].yOpeMod) annotation (Line(points={{652,4},
          {54,4},{54,325},{-10,325}},  color={255,127,0}));
  connect(flo.TRooAir, TZonSet.TZon) annotation (Line(points={{1028.86,494.94},
          {1096,494.94},{1096,604},{-54,604},{-54,335},{-34,335}},color={0,0,127}));
  connect(TDis.y, zonOutAirSet.TDis) annotation (Line(points={{131,286},{132,286},
          {132,427},{226,427}}, color={0,0,127}));
  connect(VDis_flow.y, zonOutAirSet.VDis_flow) annotation (Line(points={{197,252},
          {210,252},{210,424},{226,424}}, color={0,0,127}));
  connect(zonOutAirSet.VUncOut_flow_nominal, reaRep1.y) annotation (Line(points=
         {{226,421},{216,421},{216,358},{514,358},{514,488},{502,488}}, color={0,
          0,127}));
  connect(zonOutAirSet.uReqOutAir, booRep1.y) annotation (Line(points={{226,433},
          {204,433},{204,352},{510,352},{510,448},{502,448}}, color={255,0,255}));
  connect(flo.TRooAir, zonOutAirSet.TZon) annotation (Line(points={{1028.86,
          494.94},{1072,494.94},{1072,620},{210,620},{210,430},{226,430}},
                                                                   color={0,0,127}));
  connect(zonOutAirSet.yDesZonPeaOcc, zonToSys.uDesZonPeaOcc) annotation (Line(
        points={{250,439},{262,439},{262,438},{272,438}}, color={0,0,127}));
  connect(zonOutAirSet.VDesPopBreZon_flow, zonToSys.VDesPopBreZon_flow)
    annotation (Line(points={{250,436},{272,436}}, color={0,0,127}));
  connect(zonOutAirSet.VDesAreBreZon_flow, zonToSys.VDesAreBreZon_flow)
    annotation (Line(points={{250,433},{262,433},{262,434},{272,434}}, color={0,
          0,127}));
  connect(zonOutAirSet.yDesPriOutAirFra, zonToSys.uDesPriOutAirFra) annotation (
     Line(points={{250,430},{262,430},{262,428},{272,428}}, color={0,0,127}));
  connect(zonOutAirSet.VUncOutAir_flow, zonToSys.VUncOutAir_flow) annotation (
      Line(points={{250,427},{262,427},{262,426},{272,426}}, color={0,0,127}));
  connect(zonOutAirSet.yPriOutAirFra, zonToSys.uPriOutAirFra)
    annotation (Line(points={{250,424},{272,424}}, color={0,0,127}));
  connect(zonOutAirSet.VPriAir_flow, zonToSys.VPriAir_flow) annotation (Line(
        points={{250,421},{262,421},{262,422},{272,422}}, color={0,0,127}));
  connect(zonToSys.ySumDesZonPop, conAHU.sumDesZonPop) annotation (Line(points={{296,439},
          {296,522},{356,522},{356,515.778}},           color={0,0,127}));
  connect(zonToSys.VSumDesPopBreZon_flow, conAHU.VSumDesPopBreZon_flow)
    annotation (Line(points={{296,436},{298,436},{298,510.444},{356,510.444}},
        color={0,0,127}));
  connect(zonToSys.VSumDesAreBreZon_flow, conAHU.VSumDesAreBreZon_flow)
    annotation (Line(points={{296,433},{300,433},{300,505.111},{356,505.111}},
        color={0,0,127}));
  connect(zonToSys.yDesSysVenEff, conAHU.uDesSysVenEff) annotation (Line(points={{296,430},
          {302,430},{302,499.778},{356,499.778}},           color={0,0,127}));
  connect(zonToSys.VSumUncOutAir_flow, conAHU.VSumUncOutAir_flow) annotation (
      Line(points={{296,427},{303,427},{303,494.444},{356,494.444}}, color={0,0,
          127}));
  connect(zonToSys.uOutAirFra_max, conAHU.uOutAirFra_max) annotation (Line(
        points={{296,424},{302,424},{302,483.778},{356,483.778}}, color={0,0,127}));
  connect(zonToSys.VSumSysPriAir_flow, conAHU.VSumSysPriAir_flow) annotation (
      Line(points={{296,421},{304,421},{304,489.111},{356,489.111}}, color={0,0,
          127}));
  connect(TOut.y, conAHU.TOut) annotation (Line(points={{-279,180},{18.5,180},{
          18.5,531.778},{356,531.778}},
                                   color={0,0,127}));
  connect(dpDisSupFan.p_rel, conAHU.ducStaPre) annotation (Line(points={{311,0},
          {140,0},{140,526.444},{356,526.444}}, color={0,0,127}));
  connect(TSup.T, conAHU.TSup) annotation (Line(points={{340,-29},{198,-29},{
          198,472},{356,472},{356,473.111}},
                                         color={0,0,127}));
  connect(VOut1.V_flow, conAHU.VOut_flow) annotation (Line(points={{-61,-20.9},
          {-61,218},{-18,218},{-18,454},{356,454},{356,451.778}},color={0,0,127}));
  connect(TMix.T, conAHU.TMix) annotation (Line(points={{40,-29},{40,444.667},{
          356,444.667}},
                     color={0,0,127}));
  connect(TZonSet[1].yOpeMod, conAHU.uOpeMod) annotation (Line(points={{-10,325},
          {158,325},{158,437.556},{356,437.556}}, color={255,127,0}));
  connect(TZonResReq.y, conAHU.uZonTemResReq) annotation (Line(points={{320,298},
          {322,298},{322,432.222},{356,432.222}}, color={255,127,0}));
  connect(PZonResReq.y, conAHU.uZonPreResReq) annotation (Line(points={{322,264},
          {324,264},{324,426.889},{356,426.889}}, color={255,127,0}));
  connect(conAHU.ySupFanSpe, fanSup.y) annotation (Line(points={{444,524.667},{
          472,524.667},{472,-12},{310,-12},{310,-28}},
                                                   color={0,0,127}));
  connect(conAHU.VDesUncOutAir_flow, reaRep1.u) annotation (Line(points={{444,
          503.333},{447,503.333},{447,488},{478,488}},
                                              color={0,0,127}));
  connect(conAHU.yReqOutAir, booRep1.u) annotation (Line(points={{444,471.333},
          {444,448},{478,448}},color={255,0,255}));
  connect(conAHU.yAveOutAirFraPlu, zonToSys.yAveOutAirFraPlu) annotation (Line(
        points={{444,492.667},{430,492.667},{430,414},{266,414},{266,432},{272,
          432}},
        color={0,0,127}));
  connect(conAHU.yHea, swiFreSta.u3) annotation (Line(points={{444,460.667},{
          444,-240},{40,-240},{40,-200},{58,-200}},
                                                color={0,0,127}));
  connect(conAHU.yCoo, gaiCooCoi.u) annotation (Line(points={{444,450},{460,450},
          {460,-272},{80,-272},{80,-248},{98,-248}}, color={0,0,127}));
  connect(conAHU.yRetDamPos, eco.yRet) annotation (Line(points={{444,439.333},{
          444,442},{422,442},{422,202},{-16.8,202},{-16.8,-34}},
                                                             color={0,0,127}));
  connect(conAHU.yOutDamPos, eco.yOut) annotation (Line(points={{444,428.667},{
          416,428.667},{416,430},{420,430},{420,168},{-10,168},{-10,-34}},
                                                                       color={0,
          0,127}));
  connect(TZonSet[1].TZonCooSet, conAHU.TZonCooSet) annotation (Line(points={{-10,339},
          {174,339},{174,537.111},{356,537.111}},      color={0,0,127}));
  connect(TZonSet[1].TZonHeaSet, conAHU.TZonHeaSet) annotation (Line(points={{-10,332},
          {174,332},{174,542.444},{356,542.444}},      color={0,0,127}));
  connect(conVAVNor.yDam_actual, nor.y_actual) annotation (Line(points={{652,10},
          {642,10},{642,72},{746,72},{746,54},{740,54}}, color={0,0,127}));
  connect(conVAVCor.yDam_actual, cor.y_actual) annotation (Line(points={{776,110},
          {770,110},{770,74},{924,74},{924,60},{912,60}},color={0,0,127}));
  connect(conVAVSou.yDam_actual, sou.y_actual) annotation (Line(points={{1018,38},
          {1012,38},{1012,68},{1126,68},{1126,52},{1112,52}}, color={0,0,127}));
  connect(cooSetDR.y[1], add.u2) annotation (Line(points={{-121,410},{-92,410},
          {-92,450},{-122,450}}, color={0,0,127}));
  connect(TZonSet[1].TZonCooSet, add.u1) annotation (Line(points={{-10,339},{8,
          339},{8,462},{-122,462}}, color={0,0,127}));
  connect(add.y, conVAVSou.TZonCooSet) annotation (Line(points={{-145,456},{
          -162,456},{-162,48.6667},{1018,48.6667}},
                                          color={0,0,127}));
  connect(add.y, conVAVNor.TZonCooSet) annotation (Line(points={{-145,456},{
          -162,456},{-162,20.6667},{652,20.6667}},
                                         color={0,0,127}));
  connect(add.y, conVAVCor.TZonCooSet) annotation (Line(points={{-145,456},{
          -162,456},{-162,120.667},{776,120.667}},
                                           color={0,0,127}));
  connect(VSupCor_flow.V_flow, VDis_flow.u2[1]) annotation (Line(points={{869,134},
          {154,134},{154,252},{174,252}},      color={0,0,127}));
  connect(TSupCor.T, TDis.u2[1]) annotation (Line(points={{869,94},{80,94},{80,286},
          {108,286}},      color={0,0,127}));
  connect(conVAVSou.TZon, TRooAir.y1[1]) annotation (Line(points={{1018,42},{
          980,42},{980,177},{511,177}}, color={0,0,127}));
  connect(conVAVNor.TZon, TRooAir.y3[1]) annotation (Line(points={{652,14},{646,
          14},{646,163},{511,163}}, color={0,0,127}));
  connect(TSupSou.T, TDis.u1[1]) annotation (Line(points={{1069,90},{72,90},{72,
          293},{108,293}}, color={0,0,127}));
  connect(TSupNor.T, TDis.u3[1]) annotation (Line(points={{697,90},{88,90},{88,279},
          {108,279}}, color={0,0,127}));
  connect(VSupSou_flow.V_flow, VDis_flow.u1[1]) annotation (Line(points={{1069,128},
          {148,128},{148,259},{174,259}}, color={0,0,127}));
  connect(VSupNor_flow.V_flow, VDis_flow.u3[1]) annotation (Line(points={{697,128},
          {160,128},{160,245},{174,245}}, color={0,0,127}));
  connect(TZonSet[1].TZonHeaSet, add1.u1) annotation (Line(points={{-10,332},{
          -64,332},{-64,286},{-120,286}}, color={0,0,127}));
  connect(heaSetDR.y[1], add1.u2) annotation (Line(points={{-119,232},{-66,232},
          {-66,274},{-120,274}}, color={0,0,127}));
  connect(add1.y, conVAVNor.TZonHeaSet) annotation (Line(points={{-143,280},{
          -182,280},{-182,22.3333},{652,22.3333}},
                                         color={0,0,127}));
  connect(add1.y, conVAVCor.TZonHeaSet) annotation (Line(points={{-143,280},{
          -182,280},{-182,110},{298,110},{298,122.333},{776,122.333}},
                                                               color={0,0,127}));
  connect(add1.y, conVAVSou.TZonHeaSet) annotation (Line(points={{-143,280},{
          -182,280},{-182,50.3333},{1018,50.3333}},
                                          color={0,0,127}));
  connect(ecoHigCut.y, conAHU.TOutCut) annotation (Line(points={{88,482},{224,
          482},{224,467.778},{356,467.778}},
                                        color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-380,-320},{1400,
            640}}), graphics={Line(
          points={{508,144}},
          color={0,127,255},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialOpenLoopFlexlabX1a\">
BaseClasses.PartialOpenLoopFlexlabX1a</a>
for a description of the HVAC system and the building envelope.
</p>
<p>
The control is based on ASHRAE Guideline 36, and implemented
using the sequences from the library
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1\">
Buildings.Controls.OBC.ASHRAE.G36_PR1</a> for
multi-zone VAV systems with economizer. The schematic diagram of the HVAC and control
sequence is shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavControlSchematics.png\" border=\"1\"/>
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
Note that this model, because of the frequent time sampling,
has longer computing time than
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
The reason is that the time integrator cannot make large steps
because it needs to set a time step each time the control samples
its input.
</p>
</html>", revisions="<html>
<ul>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&circ;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36.mos"
        "Simulate and plot"),
    experiment(
      StartTime=21081600,
      StopTime=21600000,
      Interval=299.999808,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end FlexlabX1aNoLeakBaseline0901;
