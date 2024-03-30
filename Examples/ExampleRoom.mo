within CCC_test.Examples;
model ExampleRoom
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/SingleFamilyHouse_TwoSpeed_ZoneAirBalance/SingleFamilyHouse_TwoSpeed_ZoneAirBalance.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{118,90},{138,110}})));

  Modelica.Blocks.Sources.Constant qIntGai[3](each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(extent={{236,172},{256,192}})));
  Buildings.Fluid.Sources.Boundary_pT pAtm(
    redeclare package Medium = MediumAir,
    p=101300,
    nPorts=1)   "Boundary condition"
    annotation (Placement(transformation(extent={{170,52},{190,72}})));
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone cor(
    zoneName="LIVING ZONE",
    redeclare package Medium = MediumAir,
    T_start=288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{302,14},{342,54}})));
  Buildings.Fluid.FixedResistances.PressureDrop ducCor(
    redeclare package Medium = MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=0.3*cor.V*1.2/3600)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{326,-36},{306,-16}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData freshAirCor(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    m_flow=0.3*cor.V*1.2/3600,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{304,-92},{324,-72}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{144,142},{164,162}}),
        iconTransformation(extent={{286,104},{306,124}})));
  Modelica.Blocks.Interfaces.RealOutput TOut
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={142,210})));
  Modelica.Blocks.Interfaces.RealOutput TZone annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={296,210})));
  Modelica.Blocks.Interfaces.RealInput m_flow
    annotation (Placement(transformation(extent={{60,-38},{100,2}})));
equation
  connect(building.weaBus,weaBus)  annotation (Line(
      points={{138,100},{154,100},{154,152}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(qIntGai.y,cor. qGai_flow) annotation (Line(points={{257,182},{262,182},
          {262,150},{294,150},{294,52},{292,52},{292,44},{300,44}},
                              color={0,0,127}));
  connect(cor.ports[1], ducCor.port_a) annotation (Line(points={{321,14.9},{321,
          -10},{332,-10},{332,-26},{326,-26}}, color={0,127,255}));
  connect(ducCor.port_b, pAtm.ports[1]) annotation (Line(points={{306,-26},{196,
          -26},{196,62},{190,62}},     color={0,127,255}));
  connect(freshAirCor.ports[1], cor.ports[2]) annotation (Line(points={{324,-82},
          {334,-82},{334,8},{323,8},{323,14.9}}, color={0,127,255}));
  connect(building.weaBus, freshAirCor.weaBus) annotation (Line(
      points={{138,100},{290,100},{290,-81.8},{304,-81.8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, TOut) annotation (Line(
      points={{154,152},{154,194},{142,194},{142,210}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cor.TAir, TZone) annotation (Line(points={{343,52},{348,52},{348,192},
          {296,192},{296,210}}, color={0,0,127}));
  connect(m_flow, freshAirCor.m_flow_in) annotation (Line(points={{80,-18},{292,
          -18},{292,-74},{304,-74}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,200}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,200}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ExampleRoom;
