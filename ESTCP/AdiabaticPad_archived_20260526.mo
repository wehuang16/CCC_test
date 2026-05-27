within CCC_test.ESTCP;
model AdiabaticPad_archived_20260526
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

  parameter Real satEff = 0.75 "Saturation efficiency";
  Real T_a(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");
  Real T_b(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");

public

  Buildings.Utilities.Psychrometrics.TWetBul_TDryBulXi wetBulIn(redeclare
      package Medium = Medium) "Calculate wetbulb temperature at the inlet"
    annotation (Placement(transformation(extent={{-20,40},{0,62}})));
  Buildings.Utilities.Psychrometrics.TWetBul_TDryBulXi wetBulOutForFlo(
      redeclare package Medium = Medium)
    "Calculate wetbulb temperature at the outlet for forward fluid flow"
    annotation (Placement(transformation(extent={{-18,-20},{2,2}})));

  Buildings.Utilities.Psychrometrics.TWetBul_TDryBulXi wetBulOutRevFlo(
      redeclare package Medium = Medium)
    "Calculate wetbulb temperature at the outlet for reverse fluid flow"
    annotation (Placement(transformation(extent={{-16,-68},{4,-46}})));
protected

  Real h_forwardFlow_a;
  Real h_reverseFlow_b;
  Real h_forwardFlow_b;
  Real h_reverseFlow_a;
  Real X_w_forwardFlow_a[Medium.nXi];
  Real X_w_reverseFlow_b[Medium.nXi];
  Real X_w_forwardFlow_b[Medium.nXi];
  Real X_w_reverseFlow_a[Medium.nXi];
  Real T_forwardFlow_a(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");
  Real T_reverseFlow_b(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");
  Real T_forwardFlow_b(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");
  Real T_reverseFlow_a(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");

equation
  dp = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=25,
    y2=-25,
    x_small=m_flow_small);

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;

  h_forwardFlow_a = inStream(port_a.h_outflow);
  h_reverseFlow_b = inStream(port_b.h_outflow);
  X_w_forwardFlow_a = inStream(port_a.Xi_outflow);
  X_w_reverseFlow_b = inStream(port_b.Xi_outflow);

  T_forwardFlow_a = Medium.temperature(state=
    Medium.setState_phX(p=port_a.p, h=h_forwardFlow_a, X=X_w_forwardFlow_a));
  T_reverseFlow_b = Medium.temperature(state=
    Medium.setState_phX(p=port_b.p, h=h_reverseFlow_b, X=X_w_reverseFlow_b));

  h_forwardFlow_b = Medium.specificEnthalpy(state=
    Medium.setState_pTX(p=port_b.p, T=T_forwardFlow_b, X=X_w_forwardFlow_b));
  h_reverseFlow_a = Medium.specificEnthalpy(state=
    Medium.setState_pTX(p=port_a.p, T=T_reverseFlow_a, X=X_w_reverseFlow_a));

  wetBulIn.TDryBul = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=T_forwardFlow_a,
    y2=T_reverseFlow_b,
    x_small=m_flow_small);
  wetBulIn.Xi = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=X_w_forwardFlow_a,
    y2=X_w_reverseFlow_b,
    x_small=m_flow_small);
  wetBulIn.p = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=port_a.p,
    y2=port_b.p,
    x_small=m_flow_small);

  wetBulOutForFlo.TWetBul = wetBulIn.TWetBul;
  wetBulOutRevFlo.TWetBul = wetBulIn.TWetBul;

  wetBulOutForFlo.TDryBul = T_forwardFlow_b;
  wetBulOutForFlo.Xi = X_w_forwardFlow_b;
  wetBulOutForFlo.p = port_b.p;

  wetBulOutRevFlo.TDryBul = T_reverseFlow_a;
  wetBulOutRevFlo.Xi = X_w_reverseFlow_a;
  wetBulOutRevFlo.p = port_a.p;

  T_forwardFlow_b = T_forwardFlow_a - satEff*(T_forwardFlow_a - wetBulIn.TWetBul);
  T_reverseFlow_a = T_reverseFlow_b - satEff*(T_reverseFlow_b - wetBulIn.TWetBul);

  T_a = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=T_forwardFlow_a,
    y2=T_reverseFlow_a,
    x_small=m_flow_small);

  T_b = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=T_forwardFlow_b,
    y2=T_reverseFlow_b,
    x_small=m_flow_small);

  port_a.h_outflow = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=h_forwardFlow_a,
    y2=h_reverseFlow_a,
    x_small=m_flow_small);

  port_b.h_outflow = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=h_forwardFlow_b,
    y2=h_reverseFlow_b,
    x_small=m_flow_small);

  port_a.Xi_outflow = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=X_w_forwardFlow_a,
    y2=X_w_reverseFlow_a,
    x_small=m_flow_small);

  port_b.Xi_outflow = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=X_w_forwardFlow_b,
    y2=X_w_reverseFlow_b,
    x_small=m_flow_small);

  if not allowFlowReversal then
    assert(m_flow > -m_flow_small,
      "Reverting flow occurs even though allowFlowReversal is false");
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AdiabaticPad_archived_20260526;
