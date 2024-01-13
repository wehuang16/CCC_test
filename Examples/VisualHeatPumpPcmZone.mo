within CCC_test.Examples;
model VisualHeatPumpPcmZone
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone Zone(
    zoneName="FlexLab-X3-ZoneA-North-Zone Thermal Zone",
    redeclare package Medium = MediumAir,
    T_start=278.15,
    nPorts=2) annotation (Placement(transformation(extent={{34,34},{74,74}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Pump(redeclare package Medium =
        MediumPropyleneGlycol, m_flow_nominal=1) "pump" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-52,-10})));
  Buildings.Fluid.HeatExchangers.Heater_T Heat_Pump
    annotation (Placement(transformation(extent={{-18,-20},{2,0}})));
 Buildings.Controls.Continuous.LimPID PI_Controller(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.2,
    reverseActing=reverseActing)
    annotation (Placement(transformation(extent={{-48,-78},{-28,-58}})));
  Modelica.Blocks.Sources.Step Setpoint
    annotation (Placement(transformation(extent={{-88,-78},{-68,-58}})));
  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building Building(
    idfName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/energyPlusFiles/X1-2021-V8_v2_correctedInternalGain.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/US_Berkeley_20210913.mos"))
    annotation (Placement(transformation(extent={{-88,42},{-68,62}})));

  Modelica.Blocks.Sources.Pulse Internal_Load(period(displayUnit="d") = 86400)
    annotation (Placement(transformation(extent={{-36,42},{-16,62}})));
  Modelica.Blocks.Tables.CombiTable1Ds Temperature_Map
    annotation (Placement(transformation(extent={{-12,-80},{12,-56}})));
  RTUPCM.Fluid.HeatExchangers.PcmCoilDiscretizedLNT PCM(
    redeclare package Medium = Buildings.Media.Water,
    dp_nominal=10,
    m_flow_nominal=0.0035,
    Design(
      t_fin_pcm=0.0001,
      l_fin_flow=0.0032,
      Metal(
        k=154,
        c=893,
        d(displayUnit="kg/m3") = 2730),
      A_screen=0.34,
      n_channels=5,
      n_unitcells=5,
      L=0.4066,
      W=0.0541,
      t_case=0.005,
      t_res=51,
      t_fin_flow=0.0001524,
      h_fin_flow=0.0019,
      n_fins_meter_pcm=3937,
      PCM(
        k=0.584,
        c=2910,
        d(displayUnit="kg/m3") = 1500,
        LHea=278140,
        TSol=302.65,
        TLiq=302.81),
      n_fins_meter_flow=866,
      h_fin_pcm=0.0063),
    TStart_pcm=298.05)
    annotation (Placement(transformation(extent={{24,-20},{44,0}})));
  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow Fan_Coil_Unit
    annotation (Placement(transformation(extent={{58,-14},{78,6}})));
equation
  connect(Pump.port_b, Heat_Pump.port_a)
    annotation (Line(points={{-42,-10},{-18,-10}}, color={0,127,255}));
  connect(Setpoint.y, PI_Controller.u_s)
    annotation (Line(points={{-67,-68},{-50,-68}}, color={0,0,127}));
  connect(Zone.TAir, PI_Controller.u_m) annotation (Line(points={{75,72},{88,72},
          {88,-88},{-38,-88},{-38,-80}}, color={0,0,127}));
  connect(Internal_Load.y, Zone.qGai_flow[1]) annotation (Line(points={{-15,52},
          {24,52},{24,63.3333},{32,63.3333}}, color={0,0,127}));
  connect(PI_Controller.y, Temperature_Map.u)
    annotation (Line(points={{-27,-68},{-14.4,-68}}, color={0,0,127}));
  connect(Temperature_Map.y[1], Heat_Pump.TSet) annotation (Line(points={{13.2,
          -68},{20,-68},{20,14},{-20,14},{-20,-2}}, color={0,0,127}));
  connect(Heat_Pump.port_b, PCM.port_a)
    annotation (Line(points={{2,-10},{24,-10}}, color={0,127,255}));
  connect(PCM.port_b, Fan_Coil_Unit.port_b2)
    annotation (Line(points={{44,-10},{58,-10}}, color={0,127,255}));
  connect(Fan_Coil_Unit.port_a2, Pump.port_a) annotation (Line(points={{78,-10},
          {84,-10},{84,-34},{-82,-34},{-82,-10},{-62,-10}}, color={0,127,255}));
  connect(Zone.ports[1], Fan_Coil_Unit.port_a1)
    annotation (Line(points={{53,34.9},{53,2},{58,2}}, color={0,127,255}));
  connect(Fan_Coil_Unit.port_b1, Zone.ports[2]) annotation (Line(points={{78,2},
          {82,2},{82,28},{58,28},{58,34.9},{55,34.9}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{140,100}}), graphics={
        Rectangle(
          extent={{-100,88},{140,20}},
          lineColor={255,255,255},
          fillColor={255,245,230},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,18},{142,-40}},
          lineColor={255,255,255},
          fillColor={255,230,253},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-42},{140,-100}},
          lineColor={255,255,255},
          fillColor={231,255,242},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{96,40},{132,20}},
          textColor={0,0,0},
          textString="Building"),
        Text(
          extent={{98,-22},{130,-38}},
          textColor={0,0,0},
          textString="HVAC"),
        Text(
          extent={{96,-78},{132,-98}},
          textColor={0,0,0},
          textString="Controls"),
        Text(
          extent={{26,-74},{70,-94}},
          textColor={0,0,0},
          fontSize=10,
          textString="Zone Air Temperature")}));
end VisualHeatPumpPcmZone;
