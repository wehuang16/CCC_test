within CCC_test.ESTCP;
model wet_pad2_test
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

  Real h_forwardFlow_a;

  Real h_forwardFlow_b;

  Real X_w_forwardFlow_a[Medium.nXi];

  Real X_w_forwardFlow_b[Medium.nXi];

  Real T_forwardFlow_a(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");

  Real T_forwardFlow_b(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");


equation
  dp = 25;

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;

  h_forwardFlow_a = inStream(port_a.h_outflow);

  X_w_forwardFlow_a = inStream(port_a.Xi_outflow);


  T_forwardFlow_a = Medium.temperature(state=
    Medium.setState_phX(p=port_a.p, h=h_forwardFlow_a, X=X_w_forwardFlow_a));


  h_forwardFlow_b = Medium.specificEnthalpy(state=
    Medium.setState_pTX(p=port_b.p, T=T_forwardFlow_b, X=X_w_forwardFlow_b));


  wetBul_a.TDryBul = T_forwardFlow_a;
  wetBul_a.Xi = X_w_forwardFlow_a;
  wetBul_a.p = port_a.p;

  wetBul_b.TDryBul = T_forwardFlow_b;
  wetBul_b.Xi = X_w_forwardFlow_b;
  wetBul_b.p = port_b.p;

  T_forwardFlow_b =T_forwardFlow_a - satEff*(T_forwardFlow_a - wetBul_a.TWetBul);


  wetBul_b.TWetBul = wetBul_a.TWetBul;

  T_a = T_forwardFlow_a;

  T_b = T_forwardFlow_b;

  port_a.h_outflow = h_forwardFlow_a;

  port_b.h_outflow = h_forwardFlow_b;

  port_a.Xi_outflow = X_w_forwardFlow_a;

  port_b.Xi_outflow = X_w_forwardFlow_b;

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
end wet_pad2_test;
