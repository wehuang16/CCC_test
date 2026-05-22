within CCC_test.ESTCP;
model wet_pad
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

  parameter Real satEff = 0.75 "Saturation efficiency";
  Real T_a(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");
  Real T_b(final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature");

  /*
  Real h_a;
  Real h_b;
  Real X_w_a;
  Real X_w_b;
  */
  //Real phi_a;
  //Real phi_b;
  Real test_1;
  Real test_2;
  Real test_3;
  Real test_4;

public
  Buildings.Utilities.Psychrometrics.TWetBul_TDryBulXi wetBul_a(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,12},{10,34}})));
protected
  /*
  Real h_boundary_a;
  Real h_boundary_b;
  Real X_w_boundary_a;
  Real X_w_boundary_b;
  */
  // No pressure drop
equation
  dp = 0;

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;


  //port_b.h_outflow = inStream(port_a.h_outflow);
  //port_b.Xi_outflow = inStream(port_a.Xi_outflow);
  /*
  h_boundary_a = inStream(port_a.h_outflow);
  h_boundary_b = inStream(port_b.h_outflow);
  X_w_boundary_a = inStream(port_a.Xi_outflow[1]);
  X_w_boundary_b = inStream(port_b.Xi_outflow[1]);
  */

  port_a.h_outflow = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=inStream(port_a.h_outflow),
    y2=inStream(port_b.h_outflow),
    x_small=m_flow_small);

  port_b.h_outflow = port_a.h_outflow;


  port_a.Xi_outflow = Modelica.Fluid.Utilities.regStep(
    x=port_a.m_flow,
    y1=inStream(port_a.Xi_outflow),
    y2=inStream(port_b.Xi_outflow),
    x_small=m_flow_small);



  port_b.Xi_outflow = port_a.Xi_outflow;
  // Outflowing property at port_a is unaffected by this model.
  /*
  if allowFlowReversal then
    port_a.h_outflow =  inStream(port_b.h_outflow);
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  else
    port_a.h_outflow =  Medium.h_default;
    port_a.Xi_outflow = Medium.X_default[1:Medium.nXi];
  end if;
  */

  T_a = Medium.temperature(state=
    Medium.setState_phX(p=port_a.p, h=port_a.h_outflow, X=port_a.Xi_outflow));
  T_b = Medium.temperature(state=
    Medium.setState_phX(p=port_b.p, h=port_b.h_outflow, X=port_b.Xi_outflow));


  wetBul_a.TDryBul = T_a;
  wetBul_a.Xi = port_a.Xi_outflow;
  wetBul_a.p = port_a.p;

  test_1 = inStream(port_a.h_outflow);
  test_2 = inStream(port_b.h_outflow);
  test_3 = inStream(port_a.Xi_outflow[1]);
  test_4 = inStream(port_b.Xi_outflow[1]);


  /*
  x_w_a =  port_a.Xi_outflow[1]/(1 - port_a.Xi_outflow[1]);
  x_w_b =  port_b.Xi_outflow[1]/(1 - port_b.Xi_outflow[1]);
  (T_a,phi_a) =  CCC_test.ESTCP.Tphi_hxp(port_a.h_outflow,x_w_a,port_a.p);
  (T_b,phi_b) =  CCC_test.ESTCP.Tphi_hxp(port_b.h_outflow,x_w_b,port_b.p);
  */

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
end wet_pad;
