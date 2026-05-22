within CCC_test.ESTCP;
model wet_pad2_test_reverse
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

  parameter Real satEff = 0.75 "Saturation efficiency";
  Real T_a(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");
  Real T_b(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");

  Real test_1;
  Real test_2;
  Real test_3;
  Real test_4;

public

  Buildings.Utilities.Psychrometrics.TWetBul_TDryBulXi wetBul_a(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,12},{10,34}})));
  Buildings.Utilities.Psychrometrics.TWetBul_TDryBulXi wetBul_b(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-52},{10,-30}})));
protected


  Real h_reverseFlow_b;

  Real h_reverseFlow_a;

  Real X_w_reverseFlow_b[Medium.nXi];

  Real X_w_reverseFlow_a[Medium.nXi];

  Real T_reverseFlow_b(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");

  Real T_reverseFlow_a(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");

equation
  dp = -25;

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;

  h_reverseFlow_b = inStream(port_b.h_outflow);

  X_w_reverseFlow_b = inStream(port_b.Xi_outflow);


  T_reverseFlow_b = Medium.temperature(state=
    Medium.setState_phX(p=port_b.p, h=h_reverseFlow_b, X=X_w_reverseFlow_b));

  h_reverseFlow_a = Medium.specificEnthalpy(state=
    Medium.setState_pTX(p=port_a.p, T=T_reverseFlow_a, X=X_w_reverseFlow_a));

  wetBul_a.TDryBul = T_reverseFlow_a;
  wetBul_a.Xi = X_w_reverseFlow_a;
  wetBul_a.p = port_a.p;

  wetBul_b.TDryBul = T_reverseFlow_b;
  wetBul_b.Xi = X_w_reverseFlow_b;
  wetBul_b.p = port_b.p;


  T_reverseFlow_a =T_reverseFlow_b - satEff*(T_reverseFlow_b - wetBul_b.TWetBul);

  wetBul_b.TWetBul = wetBul_a.TWetBul;

  T_a = T_reverseFlow_a;

  T_b = T_reverseFlow_b;

  port_a.h_outflow = h_reverseFlow_a;

  port_b.h_outflow = h_reverseFlow_b;

  port_a.Xi_outflow = X_w_reverseFlow_a;

  port_b.Xi_outflow = X_w_reverseFlow_b;

  test_1 = inStream(port_a.h_outflow);
  test_2 = inStream(port_b.h_outflow);
  test_3 = inStream(port_a.Xi_outflow[1]);
  test_4 = inStream(port_b.Xi_outflow[1]);

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
end wet_pad2_test_reverse;
