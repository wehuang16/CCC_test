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
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=180,origin={130,50})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u heaDyn(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=6000,
    Q_flow_nominal=7000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    "Dynamic model of the heater"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));

  Buildings.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    use_T_in=false,
    nPorts=1,
    m_flow=2*m_flow_nominal,
    T=299.15) "Source" annotation (Placement(transformation(extent={{-80,40},{
            -60,60}})));
  Modelica.Blocks.Sources.Constant const(k=-1)
    annotation (Placement(transformation(extent={{-24,36},{-4,56}})));
equation
  connect(heaDyn.port_b, senTem2.port_a) annotation (Line(
      points={{20,-10},{40,-10}},
      color={0,127,255}));

  connect(sou.ports[1], heaDyn.port_a) annotation (Line(
      points={{-60,50},{-40,50},{-40,-10},{0,-10}},
      color={0,127,255}));
  connect(senTem2.port_b, sin.ports[1]) annotation (Line(
      points={{60,-10},{100,-10},{100,50},{120,50}},
      color={0,127,255}));
  connect(const.y, heaDyn.u) annotation (Line(points={{-3,46},{0,46},{0,4},{-2,
          4},{-2,-4}}, color={0,0,127}));
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
      StopTime=1200,
      Tolerance=1e-6));
end HeaterCooler_u;
