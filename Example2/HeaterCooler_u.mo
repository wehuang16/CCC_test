within CCC_test.Example2;
model HeaterCooler_u "Model that demonstrates the ideal heater model"
  extends Modelica.Icons.Example;

  package Medium = Buildings.Media.Air;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=3000/1000/20
    "Nominal mass flow rate";

  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    use_T_in=false,
    p(displayUnit="Pa"),
    T=293.15,
    nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=180,origin={160,38})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u heaDyn(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=6000,
    Q_flow_nominal=7000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    "Dynamic model of the heater"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));

  Buildings.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    use_T_in=false,
    nPorts=1,
    m_flow=2*m_flow_nominal,
    T=299.15) "Source" annotation (Placement(transformation(extent={{-80,40},{
            -60,60}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-1,
    duration=43200,
    startTime=21600)
    annotation (Placement(transformation(extent={{-24,36},{-4,56}})));
  Buildings.Fluid.Sensors.RelativeHumidity   senRelHum(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{70,-64},{90,-44}})));
  Buildings.Fluid.HeatExchangers.PrescribedOutlet preOut(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{78,-20},{98,0}})));
  Buildings.Fluid.Sensors.MassFraction       senMasFra(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{70,-92},{90,-72}})));
  Buildings.Fluid.Sensors.RelativeHumidity   senRelHum1(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{142,-54},{162,-34}})));
  Buildings.Fluid.Sensors.MassFraction       senMasFra1(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{142,-82},{162,-62}})));
  Buildings.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{76,24},{96,44}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{118,-28},{138,-8}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{28,18},{48,38}})));
  Buildings.Fluid.Sensors.Pressure           senPre(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{24,70},{44,90}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{156,58},{176,78}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{112,58},{132,78}})));
  Buildings.Fluid.Sensors.Pressure           senPre1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{180,-26},{200,-6}})));
equation
  connect(heaDyn.port_b, senTem.port_a)
    annotation (Line(points={{20,-10},{40,-10}}, color={0,127,255}));

  connect(sou.ports[1], heaDyn.port_a) annotation (Line(
      points={{-60,50},{-40,50},{-40,-10},{0,-10}},
      color={0,127,255}));
  connect(ramp.y, heaDyn.u) annotation (Line(points={{-3,46},{0,46},{0,4},{-2,4},
          {-2,-4}}, color={0,0,127}));
  connect(senTem.port_b, preOut.port_a)
    annotation (Line(points={{60,-10},{78,-10}}, color={0,127,255}));
  connect(senTem.port_b, senRelHum.port)
    annotation (Line(points={{60,-10},{60,-64},{80,-64}}, color={0,127,255}));
  connect(senTem.port_b, senMasFra.port)
    annotation (Line(points={{60,-10},{60,-92},{80,-92}}, color={0,127,255}));
  connect(preOut.port_b, senTem1.port_a) annotation (Line(points={{98,-10},{112,
          -10},{112,-18},{118,-18}}, color={0,127,255}));
  connect(senTem1.port_b, sin.ports[1]) annotation (Line(points={{138,-18},{144,
          -18},{144,38},{150,38}}, color={0,127,255}));
  connect(senTem1.port_b, senRelHum1.port) annotation (Line(points={{138,-18},{
          168,-18},{168,-58},{152,-58},{152,-54}}, color={0,127,255}));
  connect(senTem1.port_b, senMasFra1.port) annotation (Line(points={{138,-18},{
          168,-18},{168,-86},{152,-86},{152,-82}}, color={0,127,255}));
  connect(const1.y, x_pTphi.phi)
    annotation (Line(points={{49,28},{74,28}}, color={0,0,127}));
  connect(senTem.T, x_pTphi.T)
    annotation (Line(points={{50,1},{56,1},{56,34},{74,34}}, color={0,0,127}));
  connect(senTem.port_b, senPre.port) annotation (Line(points={{60,-10},{64,-10},
          {64,64},{34,64},{34,70}}, color={0,127,255}));
  connect(senPre.p, x_pTphi.p_in) annotation (Line(points={{45,80},{66,80},{66,
          40},{74,40}}, color={0,0,127}));
  connect(less.y, switch1.u2)
    annotation (Line(points={{133,68},{154,68}}, color={255,0,255}));
  connect(senMasFra.X, less.u2) annotation (Line(points={{91,-82},{100,-82},{
          100,-78},{110,-78},{110,60}}, color={0,0,127}));
  connect(senMasFra.X, switch1.u3) annotation (Line(points={{91,-82},{122,-82},
          {122,60},{154,60}}, color={0,0,127}));
  connect(switch1.y, preOut.X_wSet) annotation (Line(points={{177,68},{190,68},
          {190,8},{76,8},{76,-6}}, color={0,0,127}));
  connect(x_pTphi.X[1], less.u1) annotation (Line(points={{97,34},{104,34},{104,
          52},{102,52},{102,68},{110,68}}, color={0,0,127}));
  connect(x_pTphi.X[1], switch1.u1) annotation (Line(points={{97,34},{104,34},{
          104,52},{102,52},{102,84},{144,84},{144,76},{154,76}}, color={0,0,127}));
  connect(senTem1.port_b, senPre1.port) annotation (Line(points={{138,-18},{168,
          -18},{168,-32},{190,-32},{190,-26}}, color={0,127,255}));
  connect(senTem.T, preOut.TSet)
    annotation (Line(points={{50,1},{50,-2},{76,-2}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{200,
            200}})),
    __Dymola_Commands(file= "modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatExchangers/Validation/HeaterCooler_u.mos" "Simulate and plot"),
    Documentation(info="<html>
<p>
Model that demonstrates the use of an ideal heater.
Both heater models are identical, except that one model is configured
as a steady-state model, whereas the other is configured as a dynamic model.
Both heaters add heat to the medium to track a set-point for the outlet
temperature.
</p>
</html>", revisions="<html>
<ul>
<li>
September 11, 2014, by Christoph Nytsch-Geusen:<br/>
Rename experiment to HetaterColler_u
in the Annex 60 library.
</li>
<li>
September 19, 2013, by Michael Wetter:<br/>
Removed fan with a prescribed mass flow source for inclusion of the test model
in the Annex 60 library.
</li>
<li>
July 11, 2011, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end HeaterCooler_u;
