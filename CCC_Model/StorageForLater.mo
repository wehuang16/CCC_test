within CCC_test.CCC_Model;
model StorageForLater
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-18,24},{2,44}})));
  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow heaCoi
    annotation (Placement(transformation(extent={{28,2},{48,22}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium =
        Medium1, m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,24})));
  Buildings.Fluid.HeatExchangers.Heater_T hea
    annotation (Placement(transformation(extent={{34,-34},{54,-14}})));
  CCC.Fluid.HeatPumps.Aixlib_AirToWaterHeatPump_3D
                                         aixlib_AirToWaterHeatPump_3D
    annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
equation
  connect(fan.port_b,heaCoi. port_a1) annotation (Line(points={{2,34},{22,34},{
          22,18},{28,18}},          color={0,127,255}));
  connect(fan1.port_b,heaCoi. port_a2) annotation (Line(points={{64,24},{56,24},
          {56,6},{48,6}},         color={0,127,255}));
  connect(heaCoi.port_b2,hea. port_a) annotation (Line(points={{28,6},{16,6},{
          16,4},{-2,4},{-2,-24},{34,-24}},                color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StorageForLater;
