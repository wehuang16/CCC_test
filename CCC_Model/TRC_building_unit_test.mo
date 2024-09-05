within CCC_test.CCC_Model;
model TRC_building_unit_test

        extends Modelica.Icons.Example;
        package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  parameter Modelica.Units.SI.MassFlowRate mOut_flow_nominal=0.04
    "Outdoor air mass flow rate, assuming constant infiltration air flow rate";
  parameter Modelica.Units.SI.MassFlowRate mRec_flow_nominal=1
    "Nominal mass flow rate for recirculated air";

              parameter Real TCooSet(unit="K")=273.15+23.89
    "Zone cooling temperature setpoint";
        parameter Real THeaSet(unit="K")=273.15+21.11
    "Zone heating temperature setpoint";
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building
                 building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/Data/energyPlusFiles/ASHRAE901_ApartmentMidRise_STD2022_Rochester.idf"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.mos"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_MN_Rochester.Intl.AP.726440_TMY3.epw"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-140,-12},{-120,8}})));

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon1(
    redeclare package Medium = MediumAir,
    zoneName="M SW Apartment",
    nPorts=4) "Thermal zone"
    annotation (Placement(transformation(extent={{-40,48},{0,88}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     fan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mRec_flow_nominal)
    "Fan"
    annotation (Placement(transformation(extent={{-20,-62},{0,-42}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                hea(
    redeclare final package Medium = MediumAir,
    m_flow_nominal=mRec_flow_nominal,
    dp_nominal=200,
    show_T=true,
    Q_flow_nominal=1)
    "Ideal heater"
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Buildings.Fluid.Sources.Boundary_pT
                            pAtm(redeclare package Medium = MediumAir,
                                                                    nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{-100,18},{-80,38}})));
  Buildings.Fluid.FixedResistances.PressureDrop
                                      duc(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=mOut_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{-50,18},{-70,38}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData
                                           freshAir(
    redeclare package Medium = MediumAir,
    m_flow=mOut_flow_nominal,
    nPorts=1)
    "Outside air supply"
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{-100,68},{-80,88}})));
  Modelica.Blocks.Sources.Constant const(k=mRec_flow_nominal)
    annotation (Placement(transformation(extent={{-150,-42},{-130,-22}})));
  Modelica.Blocks.Math.Gain        gain(k=5000)
    annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));
  Buildings.Controls.OBC.ASHRAE.G36.ThermalZones.ControlLoops conLoo(
    kCooCon=0.3,
    TiCooCon=300,
    kHeaCon=0.3,
    TiHeaCon=300)
    annotation (Placement(transformation(extent={{110,2},{130,22}})));
  Modelica.Blocks.Sources.Constant const2(k=TCooSet)
    annotation (Placement(transformation(extent={{60,16},{80,36}})));
  Modelica.Blocks.Sources.Constant const3(k=THeaSet)
    annotation (Placement(transformation(extent={{66,-20},{86,0}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{164,-10},{184,10}})));
  CCC.Controls.SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{86,-68},{106,-48}})));
  Modelica.Blocks.Continuous.Integrator coolingEnergy(k=1/3600000)
    annotation (Placement(transformation(extent={{142,-76},{162,-56}})));
  Modelica.Blocks.Continuous.Integrator heatingEnergy(k=1/3600000)
    annotation (Placement(transformation(extent={{134,-44},{154,-24}})));
equation
  connect(fan.port_b,hea.port_a)
    annotation (Line(points={{0,-52},{10,-52},{10,-50},{20,-50}},
                                                color={0,127,255}));
  connect(building.weaBus,freshAir.weaBus)
    annotation (Line(points={{-120,-2},{-110,-2},{-110,-1.8},{-100,-1.8}},
                                                                      color={255,204,51},thickness=0.5));
  connect(duc.port_a, zon1.ports[1]) annotation (Line(points={{-50,28},{-21.5,28},
          {-21.5,48.9}}, color={0,127,255}));
  connect(freshAir.ports[1], zon1.ports[2]) annotation (Line(points={{-80,-2},{-20.5,
          -2},{-20.5,48.9}}, color={0,127,255}));
  connect(fan.port_a, zon1.ports[3]) annotation (Line(points={{-20,-52},{-24,-52},
          {-24,48.9},{-19.5,48.9}}, color={0,127,255}));
  connect(hea.port_b, zon1.ports[4]) annotation (Line(points={{40,-50},{48,-50},
          {48,42},{-18.5,42},{-18.5,48.9}}, color={0,127,255}));
  connect(duc.port_b,pAtm.ports[1])
    annotation (Line(points={{-70,28},{-80,28}},color={0,127,255}));
  connect(zon1.qGai_flow, qIntGai.y)
    annotation (Line(points={{-42,78},{-79,78}}, color={0,0,127}));
  connect(const.y, fan.m_flow_in) annotation (Line(points={{-129,-32},{-10,-32},
          {-10,-40}}, color={0,0,127}));
  connect(gain.y, hea.u)
    annotation (Line(points={{11,-14},{18,-14},{18,-44}}, color={0,0,127}));
  connect(zon1.TAir, conLoo.TZon) annotation (Line(points={{1,86},{98,86},{98,12},
          {108,12}}, color={0,0,127}));
  connect(const2.y, conLoo.TCooSet)
    annotation (Line(points={{81,26},{108,26},{108,18}}, color={0,0,127}));
  connect(const3.y, conLoo.THeaSet)
    annotation (Line(points={{87,-10},{108,-10},{108,6}}, color={0,0,127}));
  connect(conLoo.yCoo, add.u1) annotation (Line(points={{132,18},{154,18},{154,6},
          {162,6}}, color={0,0,127}));
  connect(conLoo.yHea, add.u2) annotation (Line(points={{132,6},{152,6},{152,-6},
          {162,-6}}, color={0,0,127}));
  connect(add.y, gain.u) annotation (Line(points={{185,0},{196,0},{196,-86},{-12,
          -86},{-12,-14}}, color={0,0,127}));
  connect(hea.Q_flow, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{41,-44},{76,-44},{76,-58},{84,-58}}, color={0,0,
          127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy,
    heatingEnergy.u) annotation (Line(points={{108,-54.4},{122,-54.4},{122,-34},
          {132,-34}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy,
    coolingEnergy.u) annotation (Line(points={{108,-63.8},{132,-63.8},{132,-66},
          {140,-66}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TRC_building_unit_test;
