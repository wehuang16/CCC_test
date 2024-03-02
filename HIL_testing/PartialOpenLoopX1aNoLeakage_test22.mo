within CCC_test.HIL_testing;
partial model PartialOpenLoopX1aNoLeakage_test22
  "Validated Partial model of variable air volume flow system with terminal reheat and 3 VAV zones at flexlab x1a"

  package MediumA = Buildings.Media.Air "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

  constant Integer numZon=3 "Total number of served VAV boxes";
  constant Real leakageFrac=0.2 "Leakage fraction of AHU upstream duct";
  parameter Modelica.Units.SI.Volume VRooCor=flo.VRooCor
    "Room volume core";
  parameter Modelica.Units.SI.Volume VRooSou=flo.VRooSou
    "Room volume south";
  parameter Modelica.Units.SI.Volume VRooNor=flo.VRooNor
    "Room volume north";
  //parameter Modelica.Units.SI.Volume VRooPle=AFloPle*flo.hRoo "Room volume plenum";

  parameter Modelica.Units.SI.Area AFloCor=flo.cor.AFlo "Floor area core";
  parameter Modelica.Units.SI.Area AFloSou=flo.sou.AFlo "Floor area south";
  parameter Modelica.Units.SI.Area AFloNor=flo.nor.AFlo "Floor area north";
  //parameter Modelica.Units.SI.Area AFloPle=flo.ple.AFlo "Floor area plenum";

  parameter Modelica.Units.SI.Area AFlo[numZon]={flo.cor.AFlo,flo.sou.AFlo,
      flo.nor.AFlo} "Floor area of each zone";
  final parameter Modelica.Units.SI.Area ATot=sum(AFlo) "Total floor area";

  constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate mCor_flow_nominal=0.130*1.2
    "*1.2Design mass flow rate core";
  parameter Modelica.Units.SI.MassFlowRate mSou_flow_nominal=0.2313*1.2
    "*1.2Design mass flow rate perimeter 1";
  parameter Modelica.Units.SI.MassFlowRate mPle_flow_nominal=0.03*1.2
    "Design mass flow rate perimeter 2";
  parameter Modelica.Units.SI.MassFlowRate mNor_flow_nominal=0.130*1.2
    "*1.2Design mass flow rate perimeter 3";
 // parameter Modelica.Units.SI.MassFlowRate mCor_flow_nominal=6*VRooCor*conv
 //   "Design mass flow rate core";
 // parameter Modelica.Units.SI.MassFlowRate mSou_flow_nominal=6*VRooSou*conv
 //   "Design mass flow rate perimeter 1";
 // parameter Modelica.Units.SI.MassFlowRate mPle_flow_nominal=9*VRooPle*conv
 //   "Design mass flow rate perimeter 2";
 // parameter Modelica.Units.SI.MassFlowRate mNor_flow_nominal=6*VRooNor*conv
 //   "Design mass flow rate perimeter 3";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1.0*(
      mCor_flow_nominal + mSou_flow_nominal + mNor_flow_nominal +
      mPle_flow_nominal) "Nominal mass flow rate";
  parameter Modelica.Units.SI.Angle lat=37.87*3.14159/180 "Latitude";

  parameter Modelica.Units.SI.Temperature THeaOn=293.15
    "Heating setpoint during on";
  parameter Modelica.Units.SI.Temperature THeaOff=285.15
    "Heating setpoint during off";
  parameter Modelica.Units.SI.Temperature TCooOn=273.15 + 23.3
    "Cooling setpoint during on";
  parameter Modelica.Units.SI.Temperature TCooOff=303.15
    "Cooling setpoint during off";
  parameter Modelica.Units.SI.PressureDifference dpBuiStaSet(min=0) = 12
    "Building static pressure";
  parameter Real yFanMin = 0.1 "Minimum fan speed";

//  parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_nominal= 2.5*yFanMin*m_flow_nominal*1000*(20 - 4)
//    "Nominal capacity of heating coil";

  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Evaluate=true);

  parameter Boolean use_windPressure=true "Set to true to enable wind pressure";

  parameter Boolean sampleModel=true
    "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
    annotation (Evaluate=true, Dialog(tab=
          "Experimental (may be changed in future releases)"));

  Buildings.Fluid.Sources.Outside amb(redeclare package Medium = MediumA,
      nPorts=3) "Ambient conditions"
    annotation (Placement(transformation(extent={{-136,-56},{-114,-34}})));
//  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow heaCoi(
//    redeclare package Medium1 = MediumW,
//    redeclare package Medium2 = MediumA,
//    UA_nominal = QHeaCoi_nominal/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
//      T_a1=45,
//      T_b1=35,
//      T_a2=3,
//      T_b2=20),
//    m2_flow_nominal=m_flow_nominal,
//    allowFlowReversal1=false,
//    allowFlowReversal2=allowFlowReversal,
//    dp1_nominal=0,
//    dp2_nominal=200 + 200 + 100 + 40,
//    m1_flow_nominal=QHeaCoi_nominal/4200/10,
//    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
//    "Heating coil"
//    annotation (Placement(transformation(extent={{118,-36},{98,-56}})));

  Buildings.Fluid.FixedResistances.PressureDrop dpRetDuc(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=40) "Pressure drop for return duct"
    annotation (Placement(transformation(extent={{400,130},{380,150}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup(
    redeclare package Medium = MediumA,
    per(pressure(V_flow={0,m_flow_nominal/1.2*2}, dp=2*{780 + 10 + dpBuiStaSet,
            0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Supply air fan"
    annotation (Placement(transformation(extent={{300,-50},{320,-30}})));

  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for supply fan flow rate"
    annotation (Placement(transformation(extent={{400,-50},{420,-30}})));

  Buildings.Fluid.Sensors.VolumeFlowRate senRetFlo(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal)
    "Sensor for return fan flow rate"
    annotation (Placement(transformation(extent={{360,130},{340,150}})));

  Modelica.Blocks.Routing.RealPassThrough TOut(y(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC",
      min=0))
    annotation (Placement(transformation(extent={{-300,170},{-280,190}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSup(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{330,-50},{350,-30}})));
  Buildings.Fluid.Sensors.RelativePressure dpDisSupFan(redeclare package Medium =
        MediumA) "Supply fan static discharge pressure" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={320,0})));
  Buildings.Controls.SetPoints.OccupancySchedule occSch(occupancy=3600*{6,19})
    "Occupancy schedule"
    annotation (Placement(transformation(extent={{-318,-220},{-298,-200}})));
  Buildings.Utilities.Math.Min min(nin=3) "Computes lowest room temperature"
    annotation (Placement(transformation(extent={{1200,440},{1220,460}})));
  Buildings.Utilities.Math.Average ave(nin=3)
    "Compute average of room temperatures"
    annotation (Placement(transformation(extent={{1200,410},{1220,430}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TRet(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Return air temperature sensor"
    annotation (Placement(transformation(extent={{110,130},{90,150}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TMix(
    redeclare package Medium = MediumA,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Mixed air temperature sensor"
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Buildings.Fluid.Sensors.VolumeFlowRate VOut1(redeclare package Medium =
        MediumA, m_flow_nominal=m_flow_nominal) "Outside air volume flow rate"
    annotation (Placement(transformation(extent={{-72,-44},{-50,-22}})));

  hil_flexlab_model.Test1.ThermalZones.VAVBranch_ResistantReheatCoil nor(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mNor_flow_nominal,
    VRoo=VRooNor,
    allowFlowReversal=allowFlowReversal) "North-facing thermal zone"
    annotation (Placement(transformation(extent={{698,18},{738,58}})));
  hil_flexlab_model.Test1.ThermalZones.VAVBranch_ResistantReheatCoil cor(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mCor_flow_nominal,
    VRoo=VRooCor,
    allowFlowReversal=allowFlowReversal) "Middle thermal zone"
    annotation (Placement(transformation(extent={{870,24},{910,64}})));
  hil_flexlab_model.Test1.ThermalZones.VAVBranch_ResistantReheatCoil sou(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mSou_flow_nominal,
    VRoo=VRooSou,
    allowFlowReversal=allowFlowReversal) "South-facing window thermal zone"
    annotation (Placement(transformation(extent={{1070,16},{1110,56}})));
  Buildings.Fluid.FixedResistances.Junction splRetNor(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,m_flow_nominal - mNor_flow_nominal,
        mNor_flow_nominal},
    from_dp=false,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return from north and mid and south zone"
    annotation (Placement(transformation(extent={{746,10},{766,-10}})));
  Buildings.Fluid.FixedResistances.Junction splRetCor(
    redeclare package Medium = MediumA,
    m_flow_nominal={mSou_flow_nominal + mCor_flow_nominal,mSou_flow_nominal,
        mCor_flow_nominal},
    from_dp=false,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return from mid and south zone"
    annotation (Placement(transformation(extent={{988,10},{1008,-10}})));
  Buildings.Fluid.FixedResistances.Junction splSupNor(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,m_flow_nominal - mNor_flow_nominal,
        mNor_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply"
    annotation (Placement(transformation(extent={{698,-30},{718,-50}})));
  Buildings.Fluid.FixedResistances.Junction splSupCor(
    redeclare package Medium = MediumA,
    m_flow_nominal={mSou_flow_nominal + mCor_flow_nominal,mSou_flow_nominal,
        mCor_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply into Middle and South Zone"
    annotation (Placement(transformation(extent={{824,-30},{844,-50}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("Resources/weatherdata/US_Berkeley_2021_0822.mos"))
    annotation (Placement(transformation(extent={{-360,170},{-340,190}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{-330,170},{-310,190}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
  hil_flexlab_model.Test1.ThermalZones.Floor flo(redeclare final package Medium =
        MediumA, final use_windPressure=use_windPressure)
    "Model of a floor of the building that is served by this VAV system"
    annotation (Placement(transformation(extent={{806,382},{1140,570}})));
  Modelica.Blocks.Routing.DeMultiplex3 TRooAir(u(each unit="K", each
        displayUnit="degC")) "Demultiplex for room air temperature"
    annotation (Placement(transformation(extent={{490,160},{510,180}})));

  Buildings.Fluid.Sensors.TemperatureTwoPort TSupNor(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mNor_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={708,90})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSupCor(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mCor_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={880,94})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSupSou(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mSou_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1080,90})));
  Buildings.Fluid.Sensors.VolumeFlowRate VSupNor_flow(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mNor_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air flow rate" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={708,128})));
  Buildings.Fluid.Sensors.VolumeFlowRate VSupCor_flow(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mCor_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air flow rate" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={880,134})));
  Buildings.Fluid.Sensors.VolumeFlowRate VSupSou_flow(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mSou_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air flow rate" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1080,128})));
/*
  Results res(
    final A=ATot,
    PFan=fanSup.P + 0,
    PCooSen=cooCoi.QSen2_flow,
    PHea=heaCoi.Q2_flow + cor.terHea.Q_flow + sou.terHea.Q_flow + nor.terHea.Q_flow,
    PCooLat=cooCoi.QLat2_flow) "Results of the simulation";
*/
  /*fanRet*/

protected
  model Results "Model to store the results of the simulation"
    parameter Modelica.Units.SI.Area A "Floor area";
    input Modelica.Units.SI.Power PFan "Fan energy";
    input Modelica.Units.SI.Power PHea "Heating energy";
    input Modelica.Units.SI.Power PCooSen "Sensible cooling energy";
    input Modelica.Units.SI.Power PCooLat "Latent cooling energy";

    Real EFan(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Fan energy";
    Real EHea(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Heating energy";
    Real ECooSen(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Sensible cooling energy";
    Real ECooLat(
      unit="J/m2",
      start=0,
      nominal=1E5,
      fixed=true) "Latent cooling energy";
    Real ECoo(unit="J/m2") "Total cooling energy";
  equation

    A*der(EFan) = PFan;
    A*der(EHea) = PHea;
    A*der(ECooSen) = PCooSen;
    A*der(ECooLat) = PCooLat;
    ECoo = ECooSen + ECooLat;

  end Results;
public
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter
                                             gaiHeaCoi(k=m_flow_nominal*1000*40
        /4200/10) "Gain for heating coil mass flow rate"
    annotation (Placement(transformation(extent={{100,-220},{120,-200}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter
                                             gaiCooCoi(k=m_flow_nominal*1000*15
        /4200/10) "Gain for cooling coil mass flow rate"
    annotation (Placement(transformation(extent={{100,-258},{120,-238}})));
  Buildings.Controls.OBC.CDL.Logical.OnOffController freSta(bandwidth=1)
    "Freeze stat for heating coil"
    annotation (Placement(transformation(extent={{0,-102},{20,-82}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant      freStaTSetPoi(k=273.15
         + 3) "Freeze stat set point for heating coil"
    annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  Buildings.Fluid.Sensors.VolumeFlowRate VSupPle_flow(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mPle_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air flow rate" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={624,126})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TSupPle(
    redeclare package Medium = MediumA,
    initType=Modelica.Blocks.Types.Init.InitialState,
    m_flow_nominal=mPle_flow_nominal,
    allowFlowReversal=allowFlowReversal) "Discharge air temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={624,84})));
  Buildings.Fluid.FixedResistances.PressureDrop dpRetDuc1(
    m_flow_nominal=mPle_flow_nominal,
    redeclare package Medium = MediumA,
    allowFlowReversal=allowFlowReversal,
    dp_nominal=40) "Pressure drop for return duct"
    annotation (Placement(transformation(extent={{558,38},{538,58}})));
  Buildings.Fluid.FixedResistances.Junction splSupRoo(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,m_flow_nominal - mPle_flow_nominal,
        mPle_flow_nominal},
    from_dp=true,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving)
    "Splitter for room supply into the plenum and other vav zones"
    annotation (Placement(transformation(extent={{564,-30},{584,-50}})));
  Buildings.Fluid.FixedResistances.Junction splRetRoo1(
    redeclare package Medium = MediumA,
    m_flow_nominal={m_flow_nominal,m_flow_nominal - mPle_flow_nominal,
        mPle_flow_nominal},
    from_dp=false,
    linearized=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal(each displayUnit="Pa") = {0,0,0},
    portFlowDirection_1=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=if allowFlowReversal then Modelica.Fluid.Types.PortFlowDirection.Bidirectional
         else Modelica.Fluid.Types.PortFlowDirection.Entering)
    "Splitter for room return"
    annotation (Placement(transformation(extent={{636,10},{656,-10}})));
equation
  connect(fanSup.port_b, dpDisSupFan.port_a) annotation (Line(
      points={{320,-40},{320,-10}},
      color={0,0,0},
      smooth=Smooth.None,
      pattern=LinePattern.Dot));
  connect(TSup.port_a, fanSup.port_b) annotation (Line(
      points={{330,-40},{320,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(amb.ports[1], VOut1.port_a) annotation (Line(
      points={{-114,-46.4667},{-94,-46.4667},{-94,-33},{-72,-33}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splRetCor.port_1, splRetNor.port_2) annotation (Line(
      points={{988,0},{766,0}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splSupNor.port_3,nor. port_a) annotation (Line(
      points={{708,-30},{708,18}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splSupNor.port_2, splSupCor.port_1) annotation (Line(
      points={{718,-40},{824,-40}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(splSupCor.port_3, cor.port_a) annotation (Line(
      points={{834,-30},{834,24},{880,24}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-340,180},{-320,180}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaBus.TDryBul, TOut.u) annotation (Line(
      points={{-319.95,180.05},{-310,180.05},{-310,180},{-302,180}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(amb.weaBus, weaBus) annotation (Line(
      points={{-136,-44.78},{-320,-44.78},{-320,180}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaBus, flo.weaBus) annotation (Line(
      points={{-320,180},{-320,598.923},{1016.57,598.923}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(flo.TRooAir, min.u) annotation (Line(
      points={{1147.26,476},{1176,476},{1176,450},{1198,450}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(flo.TRooAir, ave.u) annotation (Line(
      points={{1147.26,476},{1176,476},{1176,420},{1198,420}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TRooAir.u, flo.TRooAir) annotation (Line(
      points={{488,170},{472,170},{472,208},{1168,208},{1168,476},{1147.26,476}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(nor.port_b, TSupNor.port_a) annotation (Line(
      points={{708,58},{708,80}},
      color={0,127,255},
      thickness=0.5));
  connect(cor.port_b,TSupCor. port_a) annotation (Line(
      points={{880,64},{880,84}},
      color={0,127,255},
      thickness=0.5));
  connect(sou.port_b, TSupSou.port_a) annotation (Line(
      points={{1080,56},{1080,80}},
      color={0,127,255},
      thickness=0.5));

  connect(TSupNor.port_b, VSupNor_flow.port_a) annotation (Line(
      points={{708,100},{708,118}},
      color={0,127,255},
      thickness=0.5));
  connect(TSupCor.port_b,VSupCor_flow. port_a) annotation (Line(
      points={{880,104},{880,124}},
      color={0,127,255},
      thickness=0.5));
  connect(TSupSou.port_b, VSupSou_flow.port_a) annotation (Line(
      points={{1080,100},{1080,118}},
      color={0,127,255},
      thickness=0.5));

  connect(senRetFlo.port_a, dpRetDuc.port_b)
    annotation (Line(points={{360,140},{380,140}}, color={0,127,255}));
  connect(TSup.port_b, senSupFlo.port_a)
    annotation (Line(points={{350,-40},{400,-40}}, color={0,127,255}));
  connect(dpDisSupFan.port_b, amb.ports[2]) annotation (Line(
      points={{320,10},{320,14},{-88,14},{-88,-45},{-114,-45}},
      color={0,0,0},
      pattern=LinePattern.Dot));
  connect(senRetFlo.port_b, TRet.port_a) annotation (Line(points={{340,140},{
          226,140},{110,140}}, color={0,127,255}));
  connect(freStaTSetPoi.y, freSta.reference)
    annotation (Line(points={{-18,-86},{-2,-86}}, color={0,0,127}));
  connect(freSta.u, TMix.T) annotation (Line(points={{-2,-98},{-10,-98},{-10,-70},
          {20,-70},{20,-20},{40,-20},{40,-29}}, color={0,0,127}));
  connect(sou.port_a, splSupCor.port_2) annotation (Line(points={{1080,16},{1080,
          -40},{844,-40}}, color={0,127,255}));
  connect(VSupNor_flow.port_b, flo.portsNor[1]) annotation (Line(points={{708,138},
          {708,200},{760,200},{760,456},{912,456},{912,529.508},{931.613,
          529.508}},                      color={0,127,255}));
  connect(VSupCor_flow.port_b, flo.portsCor[1]) annotation (Line(points={{880,144},
          {880,168},{1000,168},{1000,304},{864,304},{864,480.338},{931.613,
          480.338}},
        color={0,127,255}));
  connect(VSupSou_flow.port_b, flo.portsSou[1]) annotation (Line(points={{1080,
          138},{1080,192},{1096,192},{1096,422.492},{931.613,422.492}},
                                                               color={0,127,255}));
  connect(splRetCor.port_2, flo.portsSou[2]) annotation (Line(points={{1008,0},
          {1040,0},{1040,160},{1080,160},{1080,192},{1096,192},{1096,422.492},{
          938.874,422.492}},                  color={0,127,255}));
  connect(splRetCor.port_3, flo.portsCor[2]) annotation (Line(points={{998,10},
          {998,304},{864,304},{864,480.338},{938.874,480.338}},
        color={0,127,255}));
  connect(splRetNor.port_3, flo.portsNor[2]) annotation (Line(points={{756,10},
          {756,456},{912,456},{912,529.508},{938.874,529.508}},         color={0,
          127,255}));
  connect(VSupPle_flow.port_a, TSupPle.port_b)
    annotation (Line(points={{624,116},{624,94}}, color={0,127,255}));
  connect(TSupPle.port_a, dpRetDuc1.port_a)
    annotation (Line(points={{624,74},{624,48},{558,48}}, color={0,127,255}));
  connect(senSupFlo.port_b, splSupRoo.port_1)
    annotation (Line(points={{420,-40},{564,-40}}, color={0,127,255}));
  connect(splSupRoo.port_2, splSupNor.port_1)
    annotation (Line(points={{584,-40},{698,-40}}, color={0,127,255}));
  connect(dpRetDuc1.port_b, splSupRoo.port_3) annotation (Line(points={{538,48},
          {534,48},{534,-30},{574,-30}}, color={0,127,255}));
  connect(dpRetDuc.port_a, splRetRoo1.port_1) annotation (Line(points={{400,140},
          {584,140},{584,0},{636,0}}, color={0,127,255}));
  connect(splRetRoo1.port_2, splRetNor.port_1)
    annotation (Line(points={{656,0},{746,0}}, color={0,127,255}));
  connect(VSupPle_flow.port_b, flo.portsEas[1]) annotation (Line(points={{624,136},
          {618,136},{618,344},{1048,344},{1048,480.338},{1097.16,480.338}},
        color={0,127,255}));
  connect(flo.portsEas[2], splRetRoo1.port_3) annotation (Line(points={{1104.42,
          480.338},{1104.42,290},{646,290},{646,10}}, color={0,127,255}));
  connect(VOut1.port_b, TMix.port_a) annotation (Line(points={{-50,-33},{-40,-33},
          {-40,-40},{30,-40}}, color={0,127,255}));
  connect(TRet.port_b, amb.ports[3]) annotation (Line(points={{90,140},{20,140},
          {20,136},{-102,136},{-102,-43.5333},{-114,-43.5333}}, color={0,127,255}));
  connect(TMix.port_b, fanSup.port_a)
    annotation (Line(points={{50,-40},{300,-40}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-380,
            -400},{1420,600}}), graphics={Line(points={{310,404}}, color={28,
              108,200}), Line(
          points={{34,406}},
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
The figure below shows the schematic diagram of the HVAC system
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavSchematics.png\" border=\"1\"/>
</p>
<p>
Most of the HVAC control in this model is open loop.
Two models that extend this model, namely
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>
and
<a href=\"modelica://Buildings.Examples.VAVReheat.Guideline36\">
Buildings.Examples.VAVReheat.Guideline36</a>
add closed loop control. See these models for a description of
the control sequence.
</p>
<p>
To model the heat transfer through the building envelope,
a model of five interconnected rooms is used.
The five room model is representative of one floor of the
new construction medium office building for Chicago, IL,
as described in the set of DOE Commercial Building Benchmarks
(Deru et al, 2009). There are four perimeter zones and one core zone.
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
The thermal room model computes transient heat conduction through
walls, floors and ceilings and long-wave radiative heat exchange between
surfaces. The convective heat transfer coefficient is computed based
on the temperature difference between the surface and the room air.
There is also a layer-by-layer short-wave radiation,
long-wave radiation, convection and conduction heat transfer model for the
windows. The model is similar to the
Window 5 model and described in TARCOG 2006.
</p>
<p>
Each thermal zone can have air flow from the HVAC system, through leakages of the building envelope (except for the core zone) and through bi-directional air exchange through open doors that connect adjacent zones. The bi-directional air exchange is modeled based on the differences in static pressure between adjacent rooms at a reference height plus the difference in static pressure across the door height as a function of the difference in air density.
Infiltration is a function of the
flow imbalance of the HVAC system.
</p>
<h4>References</h4>
<p>
Deru M., K. Field, D. Studer, K. Benne, B. Griffith, P. Torcellini,
 M. Halverson, D. Winiarski, B. Liu, M. Rosenberg, J. Huang, M. Yazdanian, and D. Crawley.
<i>DOE commercial building research benchmarks for commercial buildings</i>.
Technical report, U.S. Department of Energy, Energy Efficiency and
Renewable Energy, Office of Building Technologies, Washington, DC, 2009.
</p>
<p>
TARCOG 2006: Carli, Inc., TARCOG: Mathematical models for calculation
of thermal performance of glazing systems with our without
shading devices, Technical Report, Oct. 17, 2006.
</p>
</html>", revisions="<html>
<ul>
<li>
September 26, 2017, by Michael Wetter:<br/>
Separated physical model from control to facilitate implementation of alternate control
sequences.
</li>
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
</html>"));
end PartialOpenLoopX1aNoLeakage_test22;
