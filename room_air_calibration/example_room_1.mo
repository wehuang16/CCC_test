within CCC_test.room_air_calibration;
model example_room_1

    package MediumAir = Buildings.Media.Air;
   package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+20, X_a=
            0.5);
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.5,
    V=5000)                                                    "Mixing volume"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={46,0})));
  Buildings.HeatTransfer.Convection.Interior convHot(
    A=1,
    hFixed=200,
    til=Buildings.Types.Tilt.Wall)
    "Convective heat transfer"
    annotation (Placement(transformation(extent={{-12,22},{-32,42}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature TA
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{-74,22},{-54,42}})));
  Modelica.Blocks.Interfaces.RealOutput supply_air_temperature
    annotation (Placement(transformation(extent={{100,36},{120,56}})));
  Modelica.Blocks.Interfaces.RealOutput room_air_temperature
    annotation (Placement(transformation(extent={{98,-2},{118,18}})));
  Modelica.Blocks.Interfaces.RealOutput outside_air_temperature
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput supply_airflow
    annotation (Placement(transformation(extent={{102,-96},{122,-76}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=vol.T)
    annotation (Placement(transformation(extent={{28,-42},{48,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow fixHeaFlo(T_ref=
        293.15)
    "Fixed heat flow rate"
    annotation (Placement(transformation(extent={{-114,72},{-94,92}})));
  Modelica.Blocks.Sources.CombiTimeTable heat_gain(
    table=[0,0.0; 9,1000; 12,500; 13,1000; 18,0; 24,0],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600)
    annotation (Placement(transformation(extent={{-172,78},{-152,98}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://CCC_test/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    annotation (Placement(transformation(extent={{-224,42},{-204,62}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-184,14},{-144,54}}),   iconTransformation(
          extent={{-242,-42},{-222,-22}})));
  Buildings.Controls.OBC.ASHRAE.G36.ThermalZones.ControlLoops conLoo(
    kCooCon=0.3,
    TiCooCon=600,
    kHeaCon=0.3,
    TiHeaCon=600)
    annotation (Placement(transformation(extent={{-60,-62},{-40,-42}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                hea(
    redeclare final package Medium = MediumAir,
    m_flow_nominal=0.5,
    dp_nominal=200,
    Q_flow_nominal=4000)
    "Ideal heater"
    annotation (Placement(transformation(extent={{-126,-16},{-106,4}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                     fan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=0.5)
    "Fan"
    annotation (Placement(transformation(extent={{-186,-16},{-166,4}})));
  Modelica.Blocks.Sources.CombiTimeTable cooling_setpoint(
    table=[0,273.15 + 26.67; 7,273.15 + 23.33; 19,273.15 + 26.67; 24,273.15 +
        26.67],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600)
    annotation (Placement(transformation(extent={{-194,-84},{-174,-64}})));
  Modelica.Blocks.Sources.CombiTimeTable heating_setpoint(
    table=[0,273.15 + 15.56; 7,273.15 + 21.11; 19,273.15 + 15.56; 24,273.15 +
        15.56],
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600)
    annotation (Placement(transformation(extent={{-110,-102},{-90,-82}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-16,-70},{4,-50}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSupply(redeclare package
      Medium = MediumAir, m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{-48,-14},{-28,6}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemReturn(redeclare package
      Medium = MediumAir, m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{-238,-32},{-218,-12}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=0.5)
    annotation (Placement(transformation(extent={{-240,86},{-220,106}})));
  Modelica.Blocks.Interfaces.RealOutput return_air_temperature
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput thermal_power
    annotation (Placement(transformation(extent={{104,-152},{124,-132}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = MediumAir,
      nPorts=1)
    annotation (Placement(transformation(extent={{-254,-86},{-234,-66}})));
equation
  connect(convHot.solid, vol.heatPort)
    annotation (Line(points={{-12,32},{46,32},{46,10}}, color={191,0,0}));
  connect(TA.port, convHot.fluid)
    annotation (Line(points={{-54,32},{-32,32}}, color={191,0,0}));
  connect(realExpression.y, room_air_temperature) annotation (Line(points={{49,
          -32},{94,-32},{94,8},{108,8}}, color={0,0,127}));
  connect(fixHeaFlo.port, vol.heatPort) annotation (Line(points={{-94,82},{12,
          82},{12,32},{46,32},{46,10}}, color={191,0,0}));
  connect(heat_gain.y[1], fixHeaFlo.Q_flow) annotation (Line(points={{-151,88},
          {-124,88},{-124,82},{-114,82}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-204,52},{-190,52},{-190,34},{-164,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus.TDryBul, TA.T) annotation (Line(
      points={{-163.9,34.1},{-84,34.1},{-84,32},{-76,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TA.T, outside_air_temperature) annotation (Line(points={{-76,32},{-80,
          32},{-80,-22},{110,-22},{110,-40}}, color={0,0,127}));
  connect(realExpression.y, conLoo.TZon) annotation (Line(points={{49,-32},{52,
          -32},{52,-28},{-78,-28},{-78,-52},{-62,-52}}, color={0,0,127}));
  connect(cooling_setpoint.y[1], conLoo.TCooSet) annotation (Line(points={{-173,
          -74},{-74,-74},{-74,-46},{-62,-46}}, color={0,0,127}));
  connect(heating_setpoint.y[1], conLoo.THeaSet) annotation (Line(points={{-89,
          -92},{-72,-92},{-72,-58},{-62,-58}}, color={0,0,127}));
  connect(conLoo.yHea, sub.u1) annotation (Line(points={{-38,-58},{-28,-58},{
          -28,-54},{-18,-54}}, color={0,0,127}));
  connect(conLoo.yCoo, sub.u2) annotation (Line(points={{-38,-46},{-28,-46},{
          -28,-52},{-26,-52},{-26,-66},{-18,-66}}, color={0,0,127}));
  connect(sub.y, hea.u) annotation (Line(points={{6,-60},{14,-60},{14,-58},{
          -128,-58},{-128,0}}, color={0,0,127}));
  connect(fan.port_b, hea.port_a)
    annotation (Line(points={{-166,-6},{-126,-6}}, color={0,127,255}));
  connect(senTemReturn.port_b, fan.port_a) annotation (Line(points={{-218,-22},
          {-192,-22},{-192,-6},{-186,-6}}, color={0,127,255}));
  connect(hea.port_b, senTemSupply.port_a) annotation (Line(points={{-106,-6},{
          -78,-6},{-78,-4},{-48,-4}}, color={0,127,255}));
  connect(senTemSupply.port_b, vol.ports[1]) annotation (Line(points={{-28,-4},
          {30,-4},{30,1},{36,1}}, color={0,127,255}));
  connect(senTemReturn.port_a, vol.ports[2]) annotation (Line(points={{-238,-22},
          {-244,-22},{-244,-38},{-96,-38},{-96,0},{-54,0},{-54,12},{30,12},{30,
          2},{36,2},{36,-1}}, color={0,127,255}));
  connect(con2.y, fan.m_flow_in) annotation (Line(points={{-218,96},{-210,96},{
          -210,68},{-230,68},{-230,14},{-194,14},{-194,6},{-176,6}}, color={0,0,
          127}));
  connect(bou.ports[1], senTemReturn.port_a) annotation (Line(points={{-234,-76},
          {-228,-76},{-228,-38},{-244,-38},{-244,-22},{-238,-22}}, color={0,127,
          255}));
  connect(senTemSupply.T, supply_air_temperature) annotation (Line(points={{-38,
          7},{-38,16},{92,16},{92,46},{110,46}}, color={0,0,127}));
  connect(return_air_temperature, senTemReturn.T) annotation (Line(points={{110,
          80},{14,80},{14,112},{-246,112},{-246,-6},{-228,-6},{-228,-11}},
        color={0,0,127}));
  connect(fan.m_flow_in, supply_airflow) annotation (Line(points={{-176,6},{
          -164,6},{-164,14},{112,14},{112,-86}}, color={0,0,127}));
  connect(hea.Q_flow, thermal_power) annotation (Line(points={{-105,0},{2,0},{2,
          -142},{114,-142}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=17280000,
      StopTime=18144000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end example_room_1;
