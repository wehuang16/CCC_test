within CCC_test.ESTCP;
model wet_pad
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;
equation
  port_b.h_outflow = inStream(port_a.h_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);
  // Transport of substances
  port_b.C_outflow = inStream(port_a.C_outflow);
  // Outflowing property at port_a is unaffected by this model.

  if allowFlowReversal then
    port_a.h_outflow =  inStream(port_b.h_outflow);
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);
    port_a.C_outflow =  inStream(port_b.C_outflow);
  else
    port_a.h_outflow =  Medium.h_default;
    port_a.Xi_outflow = Medium.X_default[1:Medium.nXi];
    port_a.C_outflow =  zeros(Medium.nC);
  end if;

  // No pressure drop
  dp = 0;

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;



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
