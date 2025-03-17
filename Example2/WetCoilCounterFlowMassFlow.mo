within CCC_test.Example2;
model WetCoilCounterFlowMassFlow
  "Model of a cooling coil that tests variable mass flow rates"
  extends Modelica.Icons.Example;
  extends
    Buildings.Fluid.HeatExchangers.Examples.BaseClasses.EffectivenessNTUMassFlow(
    sou_1(nPorts=1),
    sin_1(nPorts=1),
    sin_2(nPorts=1),
    sou_2(nPorts=1),
    relHum(k=0.98));

  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp2_nominal(displayUnit="Pa") = 200,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    dp1_nominal(displayUnit="Pa") = 3000,
    UA_nominal=Q_flow_nominal/Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        T_a1_nominal,
        T_b1_nominal,
        T_a2_nominal,
        T_b2_nominal),
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{66,28},{86,48}})));

  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum(redeclare package
      Medium = Medium2, m_flow_nominal=m2_flow_nominal)
    annotation (Placement(transformation(extent={{42,-20},{22,0}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHumBefore(redeclare
      package Medium = Medium2, m_flow_nominal=m2_flow_nominal)
    annotation (Placement(transformation(extent={{110,0},{90,18}})));
  CCC.Controls.Dehumidifier dehumidifier(m_flow_nominal=1, const1(k=1))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,-10})));
equation
  connect(sou_1.ports[1], hex.port_a1) annotation (Line(
      points={{18,62},{60,62},{60,44},{66,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b1, sin_1.ports[1]) annotation (Line(
      points={{86,44},{116,44},{116,60},{120,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senRelHum.port_b, sin_2.ports[1]) annotation (Line(
      points={{22,-10},{18,-10},{18,10},{24,10},{24,24},{20,24}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sou_2.ports[1], senRelHumBefore.port_a) annotation (Line(points={{118,
          24},{114,24},{114,9},{110,9}}, color={0,127,255}));
  connect(senRelHumBefore.port_b, hex.port_a2) annotation (Line(points={{90,9},
          {86,9},{86,24},{90,24},{90,32},{86,32}}, color={0,127,255}));
  connect(hex.port_b2, dehumidifier.port_a) annotation (Line(points={{66,32},{
          62,32},{62,6},{78,6},{78,-9.8},{71.4,-9.8}}, color={0,127,255}));
  connect(dehumidifier.port_b, senRelHum.port_a) annotation (Line(points={{49,
          -10.2},{50,-10},{42,-10}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{200,200}})),
experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatExchangers/Examples/WetCoilCounterFlowMassFlow.mos"
        "Simulate and plot"),
Documentation(info="<html>
<p>
This model demonstrates the use of
<a href=\"modelica://Buildings.Fluid.HeatExchangers.WetCoilCounterFlow\">
Buildings.Fluid.HeatExchangers.WetCoilCounterFlow</a>
for different inlet conditions.
</p>
</html>", revisions="<html>
<ul>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
May 27, 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end WetCoilCounterFlowMassFlow;
