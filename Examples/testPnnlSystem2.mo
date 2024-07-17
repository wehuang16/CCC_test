within CCC_test.Examples;
model testPnnlSystem2
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=false) "Weather data reader"
    annotation (Placement(transformation(extent={{-36,-4},{-16,16}})));
  Buildings.Controls.DemandResponse.Client
                                 client(
    nSam=48,
    nHis=10,
    predictionModel=Buildings.Controls.Predictors.Types.PredictionModel.WeatherRegression)
    annotation (Placement(transformation(extent={{-66,-34},{-46,-14}})));
  Buildings.Examples.VAVReheat.BaseClasses.PowerCalculation
                               PTot(
    PCooExp=2200,
    PHeaExp=1000,
    PFanExp=50,
    PRehExp=10)
    annotation (Placement(transformation(extent={{-184,-44},{-164,-24}})));
  Buildings.Controls.Sources.DayType
                           dayType(days={Buildings.Controls.Types.Day.WorkingDay,
        Buildings.Controls.Types.Day.WorkingDay,Buildings.Controls.Types.Day.WorkingDay,
        Buildings.Controls.Types.Day.WorkingDay,Buildings.Controls.Types.Day.WorkingDay,
        Buildings.Controls.Types.Day.WorkingDay,Buildings.Controls.Types.Day.WorkingDay})
    annotation (Placement(transformation(extent={{-126,-74},{-106,-54}})));
  Modelica.Blocks.Sources.CombiTimeTable bui90(
    tableOnFile=true,
    tableName="b90",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/Controls/DemandResponse/Examples/B90_DR_Data.mos"),
    columns={2,3,4,5})
                     "LBNL building 90 data"
    annotation (Placement(transformation(extent={{-166,76},{-146,96}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant
                                            con(k=false)
    annotation (Placement(transformation(extent={{-126,46},{-106,66}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant
                                            con1(k=true)
    annotation (Placement(transformation(extent={{-126,-104},{-106,-84}})));
  Buildings.Examples.VAVReheat.BaseClasses.ShedFactor
                         sheFac
    annotation (Placement(transformation(extent={{-16,-134},{4,-114}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter
                                                  gai(k=1/10)
    annotation (Placement(transformation(extent={{-126,76},{-106,96}})));
  Modelica.Blocks.Continuous.Integrator ene(u(unit="W"))
    "Integrator to compute energy from power"
    annotation (Placement(transformation(extent={{-126,-44},{-106,-24}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter
                                           addPar(p=5000)
    annotation (Placement(transformation(extent={{-156,-44},{-136,-24}})));
  Buildings.Controls.OBC.CDL.Continuous.AddParameter
                                           addPar1(p=1)
    annotation (Placement(transformation(extent={{64,-134},{84,-114}})));
  Buildings.Controls.OBC.CDL.Continuous.MultiplyByParameter
                                                  gai1(k=-1)
    annotation (Placement(transformation(extent={{24,-134},{44,-114}})));
  Buildings.Examples.VAVReheat.BaseClasses.DemandLimitLevelGeneration
                                         demLimLevGen
    annotation (Placement(transformation(extent={{124,-134},{144,-114}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus annotation (Placement(
        transformation(extent={{-106,-14},{-86,6}}),  iconTransformation(extent=
           {{-164,36},{-144,56}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-16,6},{-10,6},{-10,22},{-96,22},{-96,-4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus.TDryBul,client. TOut) annotation (Line(
      points={{-96,-4},{-96,-31},{-67,-31}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dayType.y,client. typeOfDay) annotation (Line(points={{-105,-64},{-72,
          -64},{-72,-16},{-67,-16}},
                              color={0,127,0}));
  connect(con.y,client. isEventDay) annotation (Line(points={{-104,56},{-72,56},
          {-72,-20},{-67,-20}},
                             color={255,0,255}));
  connect(con1.y,client. shed) annotation (Line(points={{-104,-94},{-72,-94},{
          -72,-27},{-67,-27}},
                       color={255,0,255}));
  connect(client.PPreNoShe[1],sheFac. PConPre) annotation (Line(points={{-45,-19},
          {-32,-19},{-32,-128},{-18,-128}},                color={0,0,127}));
  connect(bui90.y[4],gai. u)
    annotation (Line(points={{-145,86},{-128,86}}, color={0,0,127}));
  connect(gai.y,sheFac. PGenPre) annotation (Line(points={{-104,86},{-72,86},{
          -72,-120},{-18,-120}},                 color={0,0,127}));
  connect(ene.y,client. ECon) annotation (Line(points={{-105,-34},{-74,-34},{
          -74,-24},{-67,-24}},
                     color={0,0,127}));
  connect(PTot.PTot,addPar. u)
    annotation (Line(points={{-162,-34},{-158,-34}},
                                                 color={0,0,127}));
  connect(addPar.y,ene. u)
    annotation (Line(points={{-134,-34},{-128,-34}},
                                                 color={0,0,127}));
  connect(addPar1.u,gai1. y)
    annotation (Line(points={{62,-124},{46,-124}},
                                               color={0,0,127}));
  connect(sheFac.yShe,gai1. u)
    annotation (Line(points={{6,-124},{22,-124}},  color={0,0,127}));
  connect(addPar1.y,client. yShed) annotation (Line(points={{86,-124},{94,-124},
          {94,-100},{-72,-100},{-72,-29},{-67,-29}},
                                              color={0,0,127}));
  connect(sheFac.yShe,demLimLevGen. uShe) annotation (Line(points={{6,-124},{14,
          -124},{14,-108},{114,-108},{114,-124},{122,-124}},color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPnnlSystem2;
