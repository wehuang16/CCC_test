within CCC_test.EvaporativeCooler.OpenTank.Validation;
model OpenTank
  "Validation model for the gradual rise and fall of the water level in an open tank"
  extends Modelica.Icons.Example;

  replaceable package Medium = Buildings.Media.Water "Medium model";

  parameter Modelica.Units.SI.Height height=1 "Height of the tank";
  parameter Modelica.Units.SI.Area crossArea=1 "Cross-sectional area of the tank";
  parameter Modelica.Units.SI.Height level_start=0.3 "Initial water level in the tank";
  parameter Modelica.Units.SI.MassFlowRate m_flow=0.5
    "Magnitude of the mass flow rate that fills or drains the tank";

  Modelica.Units.SI.Height levelExp(
    start=level_start,
    fixed=true,
    stateSelect=StateSelect.never)
    "Water level computed from an independent mass balance of the tank";

  CCC_test.EvaporativeCooler.OpenTank.OpenTank tank(
    redeclare final package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    height=height,
    crossArea=crossArea,
    level_start=level_start,
    nPorts=1,
    use_portsData=false) "Open tank"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    T=293.15,
    nPorts=1)
    "Mass flow source that fills or drains the tank"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Modelica.Blocks.Sources.Step m_flow_step(
    height=-2*m_flow,
    offset=m_flow,
    startTime=600)
    "Mass flow rate signal: filling until t = 600 s, then draining"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));

  inner Modelica.Fluid.System system(
    p_ambient=101325,
    T_ambient=293.15)
    "System-wide properties"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

equation
  connect(m_flow_step.y, sou.m_flow_in)
    annotation (Line(points={{-79,30},{-70,30},{-70,8},{-60,8}},
      color={0,0,127}));
  connect(sou.ports[1], tank.ports[1])
    annotation (Line(points={{-40,0},{-20,0},{-20,-10},{0,-10}},
                                               color={0,127,255}));

  // Reference level obtained by integrating the mass balance independently
  der(levelExp) = tank.ports[1].m_flow/(tank.medium.d*crossArea);

  assert(abs(tank.level - levelExp) < 1e-4,
    "Water level deviates from the level computed by integrating the mass balance, the maximum deviation being "
      + String(abs(tank.level - levelExp)) + " m.");

  annotation (
    experiment(StopTime=1200, Tolerance=1e-6),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Humidifiers/EvaporativeCoolers/OpenTank/Validation/OpenTank.mos"
      "Simulate and plot"),
    Documentation(info="<html>
<p>
This model validates the open tank model
<a href=\"modelica://CCC_test.EvaporativeCooler.OpenTank.OpenTank\">
Buildings.Fluid.Humidifiers.EvaporativeCoolers.OpenTank.OpenTank</a>.
</p>
<p>
The tank is connected to a mass flow source that fills the tank with
<code>m_flow = 0.5 kg/s</code> until <code>t = 600 s</code>, and then drains the
tank with the same mass flow rate until <code>t = 1200 s</code>.
The tank has a cross-sectional area of <code>crossArea = 1 m2</code>, an initial
water level of <code>level_start = 0.3 m</code> and a height of
<code>height = 1 m</code>. Hence, the water level rises gradually from
<code>0.3 m</code> to about <code>0.6 m</code> during the first half of the
simulation, and falls gradually back to <code>0.3 m</code> during the second
half. The tank never runs empty nor overflows.
</p>
<p>
The variable <code>levelExp</code> is obtained by integrating the mass balance
<code>der(levelExp) = m_flow/(rho*crossArea)</code> independently of the tank
model. An assertion verifies that the water level <code>tank.level</code>
computed by the tank model tracks this reference with an absolute error of less
than <code>1e-4 m</code>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 16, 2026 by Cline:<br/>
First implementation.
</li>
</ul>
</html>"));
end OpenTank;
