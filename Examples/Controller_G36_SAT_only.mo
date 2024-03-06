within CCC_test.Examples;
block Controller_G36_SAT_only
  "Multizone AHU controller that composes subsequences for controlling fan speed, dampers, and supply air temperature"

    parameter Real TSupSetMax(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=291.15
    "Highest cooling supply air temperature setpoint. It is typically 18 degC (65 degF) in mild and dry climates, 16 degC (60 degF) or lower in humid climates"
    annotation (Dialog(tab="Supply air temperature", group="Temperature limits"));

    parameter Real TSupSetUnocc(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=273.15+18.3
    "Highest cooling supply air temperature setpoint. It is typically 18 degC (65 degF) in mild and dry climates, 16 degC (60 degF) or lower in humid climates"
    annotation (Dialog(tab="Supply air temperature", group="Temperature limits"));

  parameter Real samplePeriod(
    final unit="s",
    final quantity="Time")=120
    "Sample period of component, set to the same value to the trim and respond sequence";

  parameter Boolean have_perZonRehBox=true
    "Check if there is any VAV-reheat boxes on perimeter zones"
    annotation (Dialog(group="System and building parameters"));

  parameter Boolean have_duaDucBox=false
    "Check if the AHU serves dual duct boxes"
    annotation (Dialog(group="System and building parameters"));

  parameter Boolean have_airFloMeaSta=false
    "Check if the AHU has AFMS (Airflow measurement station)"
    annotation (Dialog(group="System and building parameters"));

  // ----------- Parameters for economizer control -----------
  parameter Boolean use_enthalpy=false
    "Set to true if enthalpy measurement is used in addition to temperature measurement"
    annotation (Dialog(tab="Economizer"));

  parameter Real delta(
    final unit="s",
    final quantity="Time")=5
    "Time horizon over which the outdoor air flow measurment is averaged"
    annotation (Dialog(tab="Economizer"));

  parameter Real delTOutHis(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=1
    "Delta between the temperature hysteresis high and low limit"
    annotation (Dialog(tab="Economizer"));

  parameter Real delEntHis(
    final unit="J/kg",
    final quantity="SpecificEnergy")=1000
    "Delta between the enthalpy hysteresis high and low limits"
    annotation (Dialog(tab="Economizer", enable=use_enthalpy));

  parameter Real retDamPhyPosMax(
    final min=0,
    final max=1,
    final unit="1") = 1
    "Physically fixed maximum position of the return air damper"
    annotation (Dialog(tab="Economizer", group="Damper limits"));

  parameter Real retDamPhyPosMin(
    final min=0,
    final max=1,
    final unit="1") = 0
    "Physically fixed minimum position of the return air damper"
    annotation (Dialog(tab="Economizer", group="Damper limits"));

  parameter Real outDamPhyPosMax(
    final min=0,
    final max=1,
    final unit="1") = 1
    "Physically fixed maximum position of the outdoor air damper"
    annotation (Dialog(tab="Economizer", group="Damper limits"));

  parameter Real outDamPhyPosMin(
    final min=0,
    final max=1,
    final unit="1") = 0
    "Physically fixed minimum position of the outdoor air damper"
    annotation (Dialog(tab="Economizer", group="Damper limits"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeMinOut=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(group="Economizer PID controller"));

  parameter Real kMinOut(final unit="1")=0.05
    "Gain of controller for minimum outdoor air intake"
    annotation (Dialog(group="Economizer PID controller"));

  parameter Real TiMinOut(
    final unit="s",
    final quantity="Time")=1200
    "Time constant of controller for minimum outdoor air intake"
    annotation (Dialog(group="Economizer PID controller",
      enable=controllerTypeMinOut == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
          or controllerTypeMinOut == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real TdMinOut(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for minimum outdoor air intake"
    annotation (Dialog(group="Economizer PID controller",
      enable=controllerTypeMinOut == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeMinOut == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Boolean use_TMix=true
    "Set to true if mixed air temperature measurement is enabled"
     annotation(Dialog(group="Economizer freeze protection"));

  parameter Boolean use_G36FrePro=false
    "Set to true to use G36 freeze protection"
    annotation(Dialog(group="Economizer freeze protection"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeFre=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation(Dialog(group="Economizer freeze protection", enable=use_TMix));

  parameter Real kFre(final unit="1/K") = 0.1
    "Gain for mixed air temperature tracking for freeze protection, used if use_TMix=true"
     annotation(Dialog(group="Economizer freeze protection", enable=use_TMix));

  parameter Real TiFre(
    final unit="s",
    final quantity="Time",
    final max=TiMinOut)=120
    "Time constant of controller for mixed air temperature tracking for freeze protection. Require TiFre < TiMinOut"
     annotation(Dialog(group="Economizer freeze protection",
       enable=use_TMix
         and (controllerTypeFre == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
           or controllerTypeFre == Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real TdFre(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for freeze protection"
    annotation (Dialog(group="Economizer freeze protection",
      enable=use_TMix and
          (controllerTypeFre == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeFre == Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real TFreSet(
     final unit="K",
     final displayUnit="degC",
     final quantity="ThermodynamicTemperature")= 279.15
    "Lower limit for mixed air temperature for freeze protection, used if use_TMix=true"
     annotation(Dialog(group="Economizer freeze protection", enable=use_TMix));

  parameter Real yMinDamLim=0
    "Lower limit of damper position limits control signal output"
    annotation (Dialog(tab="Economizer", group="Damper limits"));

  parameter Real yMaxDamLim=1
    "Upper limit of damper position limits control signal output"
    annotation (Dialog(tab="Economizer", group="Damper limits"));

  parameter Real retDamFulOpeTim(
    final unit="s",
    final quantity="Time")=180
    "Time period to keep RA damper fully open before releasing it for minimum outdoor airflow control
    at disable to avoid pressure fluctuations"
    annotation (Dialog(tab="Economizer", group="Economizer delays at disable"));

  parameter Real disDel(
    final unit="s",
    final quantity="Time")=15
    "Short time delay before closing the OA damper at disable to avoid pressure fluctuations"
    annotation (Dialog(tab="Economizer", group="Economizer delays at disable"));

  // ----------- parameters for fan speed control  -----------
  parameter Real pIniSet(
    final unit="Pa",
    final displayUnit="Pa",
    final quantity="PressureDifference")=60
    "Initial pressure setpoint for fan speed control"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Real pMinSet(
    final unit="Pa",
    final displayUnit="Pa",
    final quantity="PressureDifference")=25
    "Minimum pressure setpoint for fan speed control"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Real pMaxSet(
    final unit="Pa",
    final displayUnit="Pa",
    final quantity="PressureDifference")=400
    "Maximum pressure setpoint for fan speed control"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Real pDelTim(
    final unit="s",
    final quantity="Time")=600
    "Delay time after which trim and respond is activated"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Integer pNumIgnReq=2
    "Number of ignored requests for fan speed control"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Real pTriAmo(
    final unit="Pa",
    final displayUnit="Pa",
    final quantity="PressureDifference")=-12.0
    "Trim amount for fan speed control"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Real pResAmo(
    final unit="Pa",
    final displayUnit="Pa",
    final quantity="PressureDifference")=15
    "Respond amount (must be opposite in to triAmo) for fan speed control"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Real pMaxRes(
    final unit="Pa",
    final displayUnit="Pa",
    final quantity="PressureDifference")=32
    "Maximum response per time interval (same sign as resAmo) for fan speed control"
    annotation (Dialog(tab="Fan speed", group="Trim and respond for reseting duct static pressure setpoint"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController
    controllerTypeFanSpe=Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation (Dialog(group="Fan speed PID controller"));

  parameter Real kFanSpe(final unit="1")=0.1
    "Gain of fan fan speed controller, normalized using pMaxSet"
    annotation (Dialog(group="Fan speed PID controller"));

  parameter Real TiFanSpe(
    final unit="s",
    final quantity="Time")=60
    "Time constant of integrator block for fan speed"
    annotation (Dialog(group="Fan speed PID controller",
      enable=controllerTypeFanSpe == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
          or controllerTypeFanSpe == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real TdFanSpe(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block for fan speed"
    annotation (Dialog(group="Fan speed PID controller",
      enable=controllerTypeFanSpe == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeFanSpe == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real yFanMax=1 "Maximum allowed fan speed"
    annotation (Dialog(group="Fan speed PID controller"));

  parameter Real yFanMin=0.1 "Lowest allowed fan speed if fan is on"
    annotation (Dialog(group="Fan speed PID controller"));

  // ----------- parameters for minimum outdoor airflow setting  -----------
  parameter Real VPriSysMax_flow(
    final unit="m3/s",
    final quantity="VolumeFlowRate")
    "Maximum expected system primary airflow at design stage"
    annotation (Dialog(tab="Minimum outdoor airflow rate", group="Nominal conditions"));

  parameter Real peaSysPop "Peak system population"
    annotation (Dialog(tab="Minimum outdoor airflow rate", group="Nominal conditions"));

  // ----------- parameters for supply air temperature control  -----------
  parameter Real TSupSetMin(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=285.15
    "Lowest cooling supply air temperature setpoint"
    annotation (Dialog(tab="Supply air temperature", group="Temperature limits"));

  parameter Real TSupSetDes(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=286.15
    "Nominal supply air temperature setpoint"
    annotation (Dialog(tab="Supply air temperature", group="Temperature limits"));

  parameter Real TOutMin(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=289.15
    "Lower value of the outdoor air temperature reset range. Typically value is 16 degC (60 degF)"
    annotation (Dialog(tab="Supply air temperature", group="Temperature limits"));

  parameter Real TOutMax(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=294.15
    "Higher value of the outdoor air temperature reset range. Typically value is 21 degC (70 degF)"
    annotation (Dialog(tab="Supply air temperature", group="Temperature limits"));

  parameter Real iniSetSupTem(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=supTemSetPoi.maxSet
    "Initial setpoint for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Real maxSetSupTem(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=supTemSetPoi.TSupSetMax
    "Maximum setpoint for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Real minSetSupTem(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")=supTemSetPoi.TSupSetDes
    "Minimum setpoint for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Real delTimSupTem(
    final unit="s",
    final quantity="Time")=600
    "Delay timer for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Integer numIgnReqSupTem=2
    "Number of ignorable requests for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Real triAmoSupTem(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=0.1
    "Trim amount for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Real resAmoSupTem(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=-0.2
    "Response amount for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Real maxResSupTem(
    final unit="K",
    final displayUnit="K",
    final quantity="TemperatureDifference")=-0.6
    "Maximum response per time interval for supply temperature control"
    annotation (Dialog(tab="Supply air temperature", group="Trim and respond for reseting TSup setpoint"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeTSup=
      Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller for supply air temperature signal"
    annotation (Dialog(group="Supply air temperature"));

  parameter Real kTSup(final unit="1/K")=0.05
    "Gain of controller for supply air temperature signal"
    annotation (Dialog(group="Supply air temperature"));

  parameter Real TiTSup(
    final unit="s",
    final quantity="Time")=600
    "Time constant of integrator block for supply air temperature control signal"
    annotation (Dialog(group="Supply air temperature",
      enable=controllerTypeTSup == Buildings.Controls.OBC.CDL.Types.SimpleController.PI
          or controllerTypeTSup == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real TdTSup(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of integrator block for supply air temperature control signal"
    annotation (Dialog(group="Supply air temperature",
      enable=controllerTypeTSup == Buildings.Controls.OBC.CDL.Types.SimpleController.PD
          or controllerTypeTSup == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real uHeaMax(min=-0.9)=-0.25
    "Upper limit of controller signal when heating coil is off. Require -1 < uHeaMax < uCooMin < 1."
    annotation (Dialog(group="Supply air temperature"));

  parameter Real uCooMin(max=0.9)=0.25
    "Lower limit of controller signal when cooling coil is off. Require -1 < uHeaMax < uCooMin < 1."
    annotation (Dialog(group="Supply air temperature"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonHeaSet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone air temperature heating setpoint"
    annotation (Placement(transformation(extent={{-240,280},{-200,320}}),
        iconTransformation(extent={{-240,320},{-200,360}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TZonCooSet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Zone air temperature cooling setpoint"
    annotation (Placement(transformation(extent={{-240,250},{-200,290}}),
        iconTransformation(extent={{-240,290},{-200,330}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-240,220},{-200,260}}),
        iconTransformation(extent={{-240,260},{-200,300}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput ducStaPre(
    final unit="Pa",
    final displayUnit="Pa")
    "Measured duct static pressure"
    annotation (Placement(transformation(extent={{-240,190},{-200,230}}),
        iconTransformation(extent={{-240,230},{-200,270}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uOpeMod
    "AHU operation mode status signal"
    annotation (Placement(transformation(extent={{-240,-230},{-200,-190}}),
        iconTransformation(extent={{-240,-270},{-200,-230}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uZonTemResReq
    "Zone cooling supply air temperature reset request"
    annotation (Placement(transformation(extent={{-240,-260},{-200,-220}}),
        iconTransformation(extent={{-240,-300},{-200,-260}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uZonPreResReq
    "Zone static pressure reset requests"
    annotation (Placement(transformation(extent={{-240,-290},{-200,-250}}),
        iconTransformation(extent={{-240,-330},{-200,-290}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput ySupFan
    "Supply fan status, true if fan should be on"
    annotation (Placement(transformation(extent={{200,260},{240,300}}),
        iconTransformation(extent={{200,280},{240,320}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ySupFanSpe(
    final min=0,
    final max=1,
    final unit="1") "Supply fan speed"
    annotation (Placement(transformation(extent={{200,190},{240,230}}),
        iconTransformation(extent={{200,220},{240,260}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSupSet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Setpoint for supply air temperature"
    annotation (Placement(transformation(extent={{200,160},{240,200}}),
        iconTransformation(extent={{200,160},{240,200}})));

  Buildings.Controls.OBC.CDL.Reals.Average TZonSetPoiAve
    "Average of all zone set points"
    annotation (Placement(transformation(extent={{-160,270},{-140,290}})));

  Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplyFan
    supFan(
    final samplePeriod=samplePeriod,
    final have_perZonRehBox=have_perZonRehBox,
    final have_duaDucBox=have_duaDucBox,
    final have_airFloMeaSta=have_airFloMeaSta,
    final iniSet=pIniSet,
    final minSet=pMinSet,
    final maxSet=pMaxSet,
    final delTim=pDelTim,
    final numIgnReq=pNumIgnReq,
    final triAmo=pTriAmo,
    final resAmo=pResAmo,
    final maxRes=pMaxRes,
    final controllerType=controllerTypeFanSpe,
    final k=kFanSpe,
    final Ti=TiFanSpe,
    final Td=TdFanSpe,
    final yFanMax=yFanMax,
    final yFanMin=yFanMin) "Supply fan controller"
    annotation (Placement(transformation(extent={{-160,200},{-140,220}})));

  Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplyTemperature
    supTemSetPoi(
    final samplePeriod=samplePeriod,
    final TSupSetMin=TSupSetMin,
    final TSupSetMax=TSupSetMax,
    final TSupSetDes=TSupSetDes,
    final TOutMin=TOutMin,
    final TOutMax=TOutMax,
    final iniSet=iniSetSupTem,
    final maxSet=maxSetSupTem,
    final minSet=minSetSupTem,
    final delTim=delTimSupTem,
    final numIgnReq=numIgnReqSupTem,
    final triAmo=triAmoSupTem,
    final resAmo=resAmoSupTem,
    final maxRes=maxResSupTem) "Setpoint for supply temperature"
    annotation (Placement(transformation(extent={{0,170},{20,190}})));

equation
  connect(supFan.ySupFanSpe, ySupFanSpe)
    annotation (Line(points={{-138,210},{220,210}},
      color={0,0,127}));
  connect(supTemSetPoi.TSupSet, TSupSet)
    annotation (Line(points={{22,180},{220,180}}, color={0,0,127}));
  connect(supTemSetPoi.TOut, TOut)
    annotation (Line(points={{-2,184},{-60,184},{-60,240},{-220,240}},
      color={0,0,127}));
  connect(supTemSetPoi.uSupFan, supFan.ySupFan)
    annotation (Line(points={{-2,176},{-84,176},{-84,217},{-138,217}},
      color={255,0,255}));
  connect(supTemSetPoi.uZonTemResReq, uZonTemResReq)
    annotation (Line(points={{-2,180},{-52,180},{-52,-240},{-220,-240}},
      color={255,127,0}));
  connect(supTemSetPoi.uOpeMod, uOpeMod)
    annotation (Line(points={{-2,172},{-48,172},{-48,-210},{-220,-210}},
      color={255,127,0}));
  connect(supFan.uOpeMod, uOpeMod)
    annotation (Line(points={{-162,218},{-180,218},{-180,-210},{-220,-210}},
      color={255,127,0}));
  connect(supFan.uZonPreResReq, uZonPreResReq)
    annotation (Line(points={{-162,207},{-176,207},{-176,-270},{-220,-270}},
      color={255,127,0}));
  connect(supFan.ducStaPre, ducStaPre)
    annotation (Line(points={{-162,202},{-192,202},{-192,210},{-220,210}},
      color={0,0,127}));
  connect(supTemSetPoi.TZonSetAve, TZonSetPoiAve.y)
    annotation (Line(points={{-2,188},{-20,188},{-20,280},{-138,280}},
      color={0,0,127}));
  connect(supFan.ySupFan, ySupFan)
    annotation (Line(points={{-138,217},{60,217},{60,280},{220,280}},
      color={255,0,255}));
  connect(TZonSetPoiAve.u2, TZonCooSet)
    annotation (Line(points={{-162,274},{-180,274},{-180,270},{-220,270}},
      color={0,0,127}));
  connect(TZonHeaSet, TZonSetPoiAve.u1)
    annotation (Line(points={{-220,300},{-180,300},{-180,286},{-162,286}},
      color={0,0,127}));

annotation (defaultComponentName="conAHU",
    Diagram(coordinateSystem(extent={{-200,-360},{200,320}}, initialScale=0.2)),
    Icon(coordinateSystem(extent={{-200,-360},{200,320}}, initialScale=0.2),
        graphics={Rectangle(
          extent={{200,360},{-198,-384}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-200,450},{200,372}},
          textString="%name",
          lineColor={0,0,255}),           Text(
          extent={{-200,348},{-116,332}},
          lineColor={0,0,0},
          textString="TZonHeaSet"),       Text(
          extent={{102,-48},{202,-68}},
          lineColor={255,0,255},
          textString="yReqOutAir"),       Text(
          extent={{-196,-238},{-122,-258}},
          lineColor={255,127,0},
          textString="uOpeMod"),          Text(
          extent={{-200,318},{-114,302}},
          lineColor={0,0,0},
          textString="TZonCooSet"),       Text(
          extent={{-198,260},{-120,242}},
          lineColor={0,0,0},
          textString="ducStaPre"),        Text(
          extent={{-198,288},{-162,272}},
          lineColor={0,0,0},
          textString="TOut"),             Text(
          extent={{-196,110},{-90,88}},
          lineColor={0,0,0},
          textString="uDesSysVenEff"),    Text(
          extent={{-196,140},{-22,118}},
          lineColor={0,0,0},
          textString="VSumDesAreBreZon_flow"),
                                          Text(
          extent={{-196,170},{-20,148}},
          lineColor={0,0,0},
          textString="VSumDesPopBreZon_flow"),
                                          Text(
          extent={{-196,200},{-88,182}},
          lineColor={0,0,0},
          textString="sumDesZonPop"),     Text(
          extent={{-200,-42},{-154,-62}},
          lineColor={0,0,0},
          textString="TSup"),             Text(
          extent={{-200,18},{-84,0}},
          lineColor={0,0,0},
          textString="uOutAirFra_max"),   Text(
          extent={{-196,48},{-62,30}},
          lineColor={0,0,0},
          textString="VSumSysPriAir_flow"),
                                          Text(
          extent={{-196,80},{-42,58}},
          lineColor={0,0,0},
          textString="VSumUncOutAir_flow"),
                                          Text(
          extent={{-200,-162},{-126,-180}},
          lineColor={0,0,0},
          textString="VOut_flow"),        Text(
          visible=use_enthalpy,
          extent={{-200,-130},{-134,-148}},
          lineColor={0,0,0},
          textString="hOutCut"),          Text(
          visible=use_enthalpy,
          extent={{-200,-100},{-160,-118}},
          lineColor={0,0,0},
          textString="hOut"),             Text(
          extent={{-198,-70},{-146,-86}},
          lineColor={0,0,0},
          textString="TOutCut"),          Text(
          visible=use_TMix,
          extent={{-200,-200},{-154,-218}},
          lineColor={0,0,0},
          textString="TMix"),             Text(
          extent={{-194,-270},{-68,-290}},
          lineColor={255,127,0},
          textString="uZonTemResReq"),    Text(
          extent={{-192,-300},{-74,-320}},
          lineColor={255,127,0},
          textString="uZonPreResReq"),    Text(
          visible=use_G36FrePro,
          extent={{-200,-330},{-110,-348}},
          lineColor={255,127,0},
          textString="uFreProSta"),       Text(
          extent={{106,252},{198,230}},
          lineColor={0,0,0},
          textString="ySupFanSpe"),       Text(
          extent={{122,192},{202,172}},
          lineColor={0,0,0},
          textString="TSupSet"),          Text(
          extent={{68,72},{196,52}},
          lineColor={0,0,0},
          textString="yAveOutAirFraPlu"), Text(
          extent={{48,132},{196,110}},
          lineColor={0,0,0},
          textString="VDesUncOutAir_flow"),
                                          Text(
          extent={{150,-104},{200,-126}},
          lineColor={0,0,0},
          textString="yHea"),             Text(
          extent={{94,-288},{200,-308}},
          lineColor={0,0,0},
          textString="yOutDamPos"),       Text(
          extent={{98,-228},{198,-248}},
          lineColor={0,0,0},
          textString="yRetDamPos"),       Text(
          extent={{78,14},{196,-6}},
          lineColor={0,0,0},
          textString="VEffOutAir_flow"),  Text(
          extent={{120,312},{202,292}},
          lineColor={255,0,255},
          textString="ySupFan"),          Text(
          extent={{150,-166},{200,-188}},
          lineColor={0,0,0},
          textString="yCoo")}),
Documentation(info="<html>
<p>
Block that is applied for multizone VAV AHU control. It outputs the supply fan status
and the operation speed, outdoor and return air damper position, supply air
temperature setpoint and the valve position of the cooling and heating coils.
It is implemented according to the ASHRAE Guideline 36, PART 5.N.
</p>
<p>
The sequence consists of five subsequences.
</p>
<h4>Supply fan speed control</h4>
<p>
The fan speed control is implemented according to PART 5.N.1. It outputs
the boolean signal <code>ySupFan</code> to turn on or off the supply fan.
In addition, based on the pressure reset request <code>uZonPreResReq</code>
from the VAV zones controller, the
sequence resets the duct pressure setpoint, and uses this setpoint
to modulate the fan speed <code>ySupFanSpe</code> using a PI controller.
See
<a href=\"modelica://Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplyFan\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplyFan</a>
for more detailed description.
</p>
<h4>Minimum outdoor airflow setting</h4>
<p>
According to current occupany, supply operation status <code>ySupFan</code>,
zone temperatures and the discharge air temperature, the sequence computes the
minimum outdoor airflow rate setpoint, which is used as input for the economizer control.
More detailed information can be found in
<a href=\"modelica://Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.OutdoorAirFlow\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.OutdoorAirFlow</a>.
</p>
<h4>Economizer control</h4>
<p>
The block outputs outdoor and return air damper position, <code>yOutDamPos</code> and
<code>yRetDamPos</code>. First, it computes the position limits to satisfy the minimum
outdoor airflow requirement. Second, it determines the availability of the economizer based
on the outdoor condition. The dampers are modulated to track the supply air temperature
loop signal, which is calculated from the sequence below, subject to the minimum outdoor airflow
requirement and economizer availability. Optionally, there is also an override for freeze protection.
See
<a href=\"modelica://Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Economizers.Controller\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Economizers.Controller</a>
for more detailed description.
</p>
<h4>Supply air temperature setpoint</h4>
<p>
Based on PART 5.N.2, the sequence first sets the maximum supply air temperature
based on reset requests collected from each zone <code>uZonTemResReq</code>. The
outdoor temperature <code>TOut</code> and operation mode <code>uOpeMod</code> are used
along with the maximum supply air temperature, for computing the supply air temperature
setpoint. See
<a href=\"modelica://Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplyTemperature\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplyTemperature</a>
for more detailed description.
</p>
<h4>Coil valve control</h4>
<p>
The subsequence retrieves supply air temperature setpoint from previous sequence.
Along with the measured supply air temperature and the supply fan status, it
generates coil valve positions. See
<a href=\"modelica://Buildings.Obsolete.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplySignals\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.SetPoints.SupplySignals</a>
</p>
</html>",
revisions="<html>
<ul>
<li>
March 16, 2020, by Jianjun Hu:<br/>
Reimplemented to add new block for specifying the minimum outdoor airfow setpoint.
This new block avoids vector-valued calculations.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1829\">#1829</a>.
</li>
<li>
October 27, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller_G36_SAT_only;
