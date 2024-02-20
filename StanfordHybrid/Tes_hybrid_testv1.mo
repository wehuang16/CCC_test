within CCC_test.StanfordHybrid;
model Tes_hybrid_testv1 "Tes storage implementation"
  replaceable package Medium = Buildings.Media.Water "Medium for water flow";
  parameter Modelica.Units.SI.MassFlowRate mTes_flow_nominal = 1e-15 "Nominal mass flow rate through TES device";
  parameter Modelica.Units.SI.ThermalConductivity k=0.584 "Thermal conductivity of PCM";
  parameter Modelica.Units.SI.SpecificHeatCapacity c=2910 "Specific heat capacity of PCM";
  parameter Modelica.Units.SI.Density d(displayUnit="kg/m3") = 1500 "Mass density of PCM";
  parameter Modelica.Units.SI.Temperature TSol=273.15+29.5 "Solidus temperature of PCM.";
  parameter Modelica.Units.SI.Temperature TLiq=273.15+29.66 "Liquidus temperature of PCM";
  parameter Modelica.Units.SI.Temperature T_start=TSol - 2 "start temperature of PCM";

  parameter Modelica.Units.SI.SpecificInternalEnergy LHea=278140 "Latent heat of phase change";
  parameter Modelica.Units.SI.Energy Tes_nominal=1.08e7 "Design capacity (factor * 1kWh)";
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal(displayUnit="Pa", min=0)
    "Pressure drop of pipe and other resistances that are in series";
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal(displayUnit="Pa", min=0)
    "Nominal pressure drop of fully open valve";
  parameter Modelica.Units.SI.PressureDifference dp_nominal(min=0, displayUnit="Pa")
    "Nominal pressure raise, used for default pressure curve if not specified in record per";

  Buildings.Fluid.Sensors.TemperatureTwoPort senTemTes(
    redeclare package Medium = Medium,
    m_flow_nominal=mTes_flow_nominal)
           "Temperature for leaving water of TES" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-60,20})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for  supply water (typically from return side of plant)"
    annotation (Placement(transformation(extent={{90,46},{110,66}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for return water (typically to return side of plant)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSupDis(
    redeclare package Medium = Medium,
    m_flow_nominal=mTes_flow_nominal)
           "Temperature for supply water to TES from return port" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={86,36})));
  Modelica.Blocks.Interfaces.RealOutput TTes "Outlet fluid temperature of TES"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Buildings.Fluid.Storage.PCM.CoilRegisterFourPort coilRegisterFourPort(
    m1_flow_nominal=mTes_flow_nominal/2,
    m2_flow_nominal=mTes_flow_nominal/2,
    TStart_pcm=T_start,
    Design(TesNominal=Tes_nominal, PCM(
        k=k,
        c=c,
        d=d,
        TSol=TSol,
        TLiq=TLiq,
        LHea=LHea)),
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Interfaces.RealOutput SOC "state of charge of PCM"
    annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
equation
  connect(senTemSupDis.port_a, port_a)
    annotation (Line(points={{96,36},{100,36},{100,56}}, color={0,127,255}));
  connect(senTemTes.T, TTes) annotation (Line(points={{-60,31},{-60,70},{40,70},
          {40,100},{110,100}}, color={0,0,127}));
  connect(senTemTes.port_a, coilRegisterFourPort.port_b1) annotation (Line(
        points={{-50,20},{-44,20},{-44,6},{-14,6},{-14,24.2},{-20,24.2}},
                                                                      color={0,
          127,255}));
  connect(coilRegisterFourPort.SOC, SOC) annotation (Line(points={{-19,11},{-16,
          11},{-16,-100},{110,-100}}, color={0,0,127}));
  connect(senTemTes.port_b, port_b) annotation (Line(points={{-70,20},{-88,20},{
          -88,-80},{100,-80}}, color={0,127,255}));
  connect(coilRegisterFourPort.port_a2, senTemSupDis.port_b) annotation (Line(
        points={{-20,15.8},{66,15.8},{66,36},{76,36}},       color={0,127,255}));
  connect(coilRegisterFourPort.port_a1, senTemSupDis.port_b) annotation (Line(
        points={{-40,24.2},{-40,36},{76,36}},    color={0,127,255}));
  connect(coilRegisterFourPort.port_b2, senTemTes.port_a) annotation (Line(
        points={{-40,15.8},{-46,15.8},{-46,20},{-50,20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{100,100}})),
    experiment(
      StartTime=24192000,
      StopTime=24537600,
      Interval=59.9999616,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end Tes_hybrid_testv1;
