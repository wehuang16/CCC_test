within CCC_test.ESTCP;
model PressureCurve "Displays the pressure curve of the mover"
  extends Modelica.Icons.Example;

  package Medium = Buildings.Media.Air "Medium model";

  parameter Modelica.Units.SI.Density rho_default=
    Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default) "Default medium density";
  parameter Buildings.Fluid.Movers.Data.Generic per(
    pressure(V_flow={0.945419103313839, 2.83300844704353, 4.71734892787522},
                 dp={ 3010.50788091068, 2632.22416812609, 830.122591943958}))
    "Performance data"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  Buildings.Fluid.Movers.SpeedControlled_y mov(
    redeclare final package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    per=per,
    addPowerToMedium=false)
               "Mover"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Sources.Constant one(final k=1) "Constant one"
    annotation (Placement(transformation(extent={{-76,50},{-56,70}})));
  Buildings.Fluid.Sources.Boundary_pT      bou1(
    redeclare final package Medium = Medium,
    nPorts=1) "Boundary that forces a mass flow rate"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Ramp ram(
    height=1,
    duration=1,
    offset=0) "Ramp signal"
    annotation (Placement(transformation(extent={{-116,20},{-96,40}})));
  Buildings.Fluid.Sources.Boundary_pT bou2(
    redeclare final package Medium = Medium,
    nPorts=1) "Boundary"
    annotation (Placement(transformation(extent={{80,-20},{60,0}})));

  Buildings.Fluid.Movers.SpeedControlled_y mov1(
    redeclare final package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    per=per,
    addPowerToMedium=false)
               "Mover"
    annotation (Placement(transformation(extent={{-18,-122},{2,-102}})));
  Modelica.Blocks.Sources.Constant one1(final k=0.5)
                                                  "Constant one"
    annotation (Placement(transformation(extent={{-58,-82},{-38,-62}})));
  Buildings.Fluid.Sources.Boundary_pT      bou3(redeclare final package Medium
      = Medium, nPorts=1)
              "Boundary that forces a mass flow rate"
    annotation (Placement(transformation(extent={{-100,-122},{-80,-102}})));
  Modelica.Blocks.Sources.Ramp ram1(
    height=per.V_flow_max*rho_default,
    duration=1,
    offset=0) "Ramp signal"
    annotation (Placement(transformation(extent={{-118,-82},{-98,-62}})));
  Buildings.Fluid.Sources.Boundary_pT bou4(redeclare final package Medium =
        Medium, nPorts=1)
              "Boundary"
    annotation (Placement(transformation(extent={{62,-122},{42,-102}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDro(
    redeclare final package Medium = Medium,
    final m_flow_nominal=6,
    final dp_nominal=3000)       "Flow resistance"
    annotation (Placement(transformation(extent={{-56,-20},{-36,0}})));
  Buildings.Fluid.FixedResistances.PressureDrop preDro1(
    redeclare final package Medium = Medium,
    final m_flow_nominal=6,
    final dp_nominal=3000)       "Flow resistance"
    annotation (Placement(transformation(extent={{-60,-122},{-40,-102}})));
equation
  connect(mov.port_b, bou2.ports[1])
    annotation (Line(points={{20,-10},{60,-10}}, color={0,127,255}));
  connect(one1.y, mov1.y)
    annotation (Line(points={{-37,-72},{-8,-72},{-8,-100}}, color={0,0,127}));
  connect(mov1.port_b, bou4.ports[1])
    annotation (Line(points={{2,-112},{42,-112}}, color={0,127,255}));
  connect(bou3.ports[1], preDro1.port_a)
    annotation (Line(points={{-80,-112},{-60,-112}}, color={0,127,255}));
  connect(preDro1.port_b, mov1.port_a)
    annotation (Line(points={{-40,-112},{-18,-112}}, color={0,127,255}));
  connect(bou1.ports[1], preDro.port_a)
    annotation (Line(points={{-80,-10},{-56,-10}}, color={0,127,255}));
  connect(preDro.port_b, mov.port_a)
    annotation (Line(points={{-36,-10},{0,-10}}, color={0,127,255}));
  connect(one.y, mov.y) annotation (Line(points={{-55,60},{-23.5,60},{-23.5,2},{
          10,2}}, color={0,0,127}));
  annotation (experiment(Tolerance=1e-6, StopTime=3600),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Fluid/Movers/Validation/PressureCurve.mos"
        "Simulate and plot"),
        Documentation(info="
<html>
<p>
This model validates the pressure curve that is specified in the instance <code>per</code>
and provided to the mover.
</p>
</html>", revisions="<html>
<ul>
<li>
May 1, 2023, by Hongxiang Fu:<br/>
First implementation. This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3371\">#3371</a>.
</li>
</ul>
</html>"));
end PressureCurve;
