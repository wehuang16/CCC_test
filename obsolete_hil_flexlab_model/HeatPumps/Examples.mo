within CCC_test.obsolete_hil_flexlab_model.HeatPumps;
package Examples "Contains example usage of heat pump models"
  extends Modelica.Icons.ExamplesPackage;

  model BlackBox_Generic_TSetpoint_Cooling
    "Example model to test BlackBox_Generic_TSetpoint for cooling mode"
    extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
      annotation (__Dymola_choicesAllMatching=true);

      IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
      redeclare package Medium = Medium,
      tau=30,
      m_flow_nominal=m_flow,
      inputType=IDEAS.Fluid.Types.InputType.Constant,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      use_inputFilter=false)
      annotation (Placement(transformation(extent={{-14,-24},{-34,-4}})));
    CCC_test.obsolete_hil_flexlab_model.HeatPumps.BlackBox_Generic_TSetpoint AirWaterHP(
      tauHeatLoss=3600,
      QNom=10590,
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow,
      modulation_min=16,
      modulation_start=25)
      annotation (Placement(transformation(extent={{-74,16},{-56,36}})));
      //cDry=10000, this has been recorded as final parameter
      //mWater=4, this has been recorded as final parameter
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          293.15)
      annotation (Placement(transformation(extent={{-124,-20},{-110,-6}})));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
      annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    IDEAS.Fluid.Sources.Boundary_pT bou(
      redeclare package Medium = Medium,
      p=200000,
      T=298.15,
      nPorts=2) annotation (Placement(transformation(extent={{72,-10},{52,10}})));
    constant Modelica.Units.SI.MassFlowRate m_flow=0.4
      "Nominal mass flow rate";
    Modelica.Blocks.Sources.Constant Tset_HP(k=273.15 + 7, y(unit="K"))
      "Temperature set point"
      annotation (Placement(transformation(extent={{-28,66},{-52,90}})));
    Modelica.Blocks.Sources.Ramp     Tambient_HX(
      height=50,
      duration=10000,                                           y(unit="K"),
      offset=273.15 - 10,
      startTime=2000) "Temperature sources of the heat pump"
      annotation (Placement(transformation(extent={{-158,10},{-136,32}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort HP_Tout(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow,
      tau=0,
      allowFlowReversal=false) "Outlet temperature of the heat pump"
      annotation (Placement(transformation(extent={{-24,18},{-4,38}})));
    Modelica.Blocks.Sources.Step     Temp_ReturnWater(
      height=4,                                                      y(unit="K"),
      offset=273.15 + 10,
      startTime=13000)
      "Temperature of the water returning to the HP"
      annotation (Placement(transformation(extent={{-100,-64},{-74,-38}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.5)
      annotation (Placement(transformation(extent={{-116,68},{-96,88}})));
    Modelica.Blocks.Sources.Constant On_signal(k=1)
      annotation (Placement(transformation(extent={{-166,64},{-146,84}})));
  equation

    connect(AirWaterHP.heatPort, fixedTemperature.port) annotation (Line(
        points={{-65,16},{-64,16},{-64,-12},{-70,-12},{-70,-13},{-110,-13}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(pump.port_b, AirWaterHP.port_a) annotation (Line(
        points={{-34,-14},{-56,-14},{-56,20}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Tset_HP.y, AirWaterHP.TSet) annotation (Line(points={{-53.2,78},{
            -70.4,78},{-70.4,38}},
                             color={0,0,127}));
    connect(bou.ports[1], pump.port_a) annotation (Line(points={{52,2},{4,2},{4,
            -14},{-14,-14}},    color={0,127,255}));
    connect(TReturn.port, pump.heatPort) annotation (Line(points={{-40,-50},{-24,
            -50},{-24,-20.8}}, color={191,0,0}));
    connect(Tambient_HX.y, AirWaterHP.TSource) annotation (Line(points={{-134.9,
            21},{-108,21},{-108,25.2},{-81.74,25.2}},
                                                  color={0,0,127}));
    connect(HP_Tout.port_a, AirWaterHP.port_b) annotation (Line(points={{-24,28},
            {-40,28},{-40,32},{-56,32}},color={0,127,255}));
    connect(HP_Tout.port_b, bou.ports[2]) annotation (Line(points={{-4,28},{24,
            28},{24,-2},{52,-2}}, color={0,127,255}));
    connect(Temp_ReturnWater.y, TReturn.T) annotation (Line(points={{-72.7,-51},{-67.35,
            -51},{-67.35,-50},{-62,-50}}, color={0,0,127}));
    connect(On_signal.y, greaterThreshold.u) annotation (Line(points={{-145,
            74},{-132.5,74},{-132.5,78},{-118,78}}, color={0,0,127}));
    connect(greaterThreshold.y, AirWaterHP.HP_On) annotation (Line(points={{
            -95,78},{-88,78},{-88,33.6},{-81.56,33.6}}, color={255,0,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      experiment(StopTime=15000, Tolerance=1e-06),
      __Dymola_experimentSetupOutput,
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}})),
      Commands(file=
            "modelica://RTUPCM/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/BlackBox_Generic_TSetpoint_Cooling.mos"
          "Simulate and plot"),
      Documentation(info="<html>
<p>This example shows the modulation behaviour of an inverter controlled air-to-water heat pump when the inlet water temperature is changed. </p>
<p>The modulation level can be seen from heater.heatSource.modulation.</p>
</html>",   revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
  end BlackBox_Generic_TSetpoint_Cooling;

  model BlackBox_Generic_TSetpoint_Heating
    "Example model to test BlackBox_Generic_TSetpoint for heating mode"
    extends Modelica.Icons.Example;
    package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
      annotation (__Dymola_choicesAllMatching=true);

      IDEAS.Fluid.Movers.FlowControlled_m_flow pump(
      redeclare package Medium = Medium,
      tau=30,
      m_flow_nominal=m_flow,
      inputType=IDEAS.Fluid.Types.InputType.Constant,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      use_inputFilter=false)
      annotation (Placement(transformation(extent={{-14,-24},{-34,-4}})));
    CCC_test.obsolete_hil_flexlab_model.HeatPumps.BlackBox_Generic_TSetpoint AirWaterHP(
      tauHeatLoss=3600,
      QNom=10528,
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow,
      modulation_min=20,
      redeclare Data.BlackBox_Generic_TSetpoint.Aermec_ANKI045_60HZ_Heating
        energyPump)
      annotation (Placement(transformation(extent={{-74,14},{-56,34}})));

      //cDry=10000, this has been recorded as final parameter
      //mWater=4, this has been recorded as final parameter
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          293.15)
      annotation (Placement(transformation(extent={{-124,-20},{-110,-6}})));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TReturn
      annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    IDEAS.Fluid.Sources.Boundary_pT bou(
      redeclare package Medium = Medium,
      p=200000,
      T=298.15,
      nPorts=2) annotation (Placement(transformation(extent={{72,-10},{52,10}})));
    constant Modelica.Units.SI.MassFlowRate m_flow=0.25
      "Nominal mass flow rate";
    Modelica.Blocks.Sources.Constant Tset_HP(k=273.15 + 35,y(unit="K"))
      "Temperature set point"
      annotation (Placement(transformation(extent={{-28,66},{-52,90}})));
    Modelica.Blocks.Sources.Ramp     Tambient_HX(
      height=50,
      duration=10000,                                           y(unit="K"),
      offset=273.15 - 10,
      startTime=2000) "Temperature sources of the heat pump"
      annotation (Placement(transformation(extent={{-158,10},{-136,32}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort HP_Tout(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow,
      tau=0,
      allowFlowReversal=false) "Outlet temperature of the heat pump"
      annotation (Placement(transformation(extent={{-24,18},{-4,38}})));
    Modelica.Blocks.Sources.Step     Temp_ReturnWater(
      height=4,                                                      y(unit="K"),
      offset=273.15 + 28,
      startTime=13000)
      "Temperature of the water returning to the HP"
      annotation (Placement(transformation(extent={{-100,-64},{-74,-38}})));
  equation

    connect(AirWaterHP.heatPort, fixedTemperature.port) annotation (Line(
        points={{-65,14},{-64,14},{-64,-12},{-70,-12},{-70,-13},{-110,-13}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(pump.port_b, AirWaterHP.port_a) annotation (Line(
        points={{-34,-14},{-56,-14},{-56,18}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(Tset_HP.y, AirWaterHP.TSet) annotation (Line(points={{-53.2,78},{-70.4,
            78},{-70.4,36}}, color={0,0,127}));
    connect(bou.ports[1], pump.port_a) annotation (Line(points={{52,2},{4,2},{4,
            -14},{-14,-14}},    color={0,127,255}));
    connect(TReturn.port, pump.heatPort) annotation (Line(points={{-40,-50},{-24,
            -50},{-24,-20.8}}, color={191,0,0}));
    connect(Tambient_HX.y, AirWaterHP.TSource) annotation (Line(points={{-134.9,21},
            {-108,21},{-108,23.2},{-81.74,23.2}}, color={0,0,127}));
    connect(HP_Tout.port_a, AirWaterHP.port_b) annotation (Line(points={{-24,28},{
            -40,28},{-40,30},{-56,30}}, color={0,127,255}));
    connect(HP_Tout.port_b, bou.ports[2]) annotation (Line(points={{-4,28},{24,
            28},{24,-2},{52,-2}}, color={0,127,255}));
    connect(Temp_ReturnWater.y, TReturn.T) annotation (Line(points={{-72.7,-51},{-67.35,
            -51},{-67.35,-50},{-62,-50}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      experiment(StopTime=15000, Tolerance=1e-06),
      __Dymola_experimentSetupOutput,
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}})),
      Commands(file=
            "modelica://RTUPCM/Resources/Scripts/Dymola/Fluid/HeatPumps/Examples/BlackBox_Generic_TSetpoint_Heating.mos"
          "Simulate and plot"),
      Documentation(info="<html>
<p>This example shows the modulation behaviour of an inverter controlled air-to-water heat pump when the inlet water temperature is changed. </p>
<p>The modulation level can be seen from heater.heatSource.modulation.</p>
</html>",   revisions="<html>
<ul>
<li>
June 5, 2018 by Filip Jorissen:<br/>
Cleaned up implementation for
<a href=\"https://github.com/open-ideas/IDEAS/issues/821\">#821</a>.
</li>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
  end BlackBox_Generic_TSetpoint_Heating;
  annotation ();
end Examples;
