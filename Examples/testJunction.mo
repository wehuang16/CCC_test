within CCC_test.Examples;
model testJunction
            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=4)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-96,5})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           pumpFcuWaterSupply[4](
    redeclare package Medium = MediumPropyleneGlycol,
    redeclare each parameter
      Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per(pressure(
          V_flow={5.55555555556e-07,0.00005,0.00014}, dp={17066.9518717,10000,0})),
    addPowerToMedium=false,
    m_flow_nominal=1)       "pump" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={18,6})));
  Modelica.Blocks.Sources.Constant const1[4](k=1)
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol,
    use_T_in=false,
    T=323.15,
    nPorts=4)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={206,-3})));
  Modelica.Blocks.Sources.Constant const2[4](k=0.5)
    annotation (Placement(transformation(extent={{-106,-68},{-86,-48}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow
                                           pumpFcuWaterSupply1[4](
    redeclare package Medium = MediumPropyleneGlycol,
    redeclare each parameter
      Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per(pressure(
          V_flow={5.55555555556e-07,0.00005,0.00014}, dp={17066.9518717,10000,0})),
    addPowerToMedium=false,
    m_flow_nominal=1)       "pump" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={24,-44})));
  CCC.Controls.junDiv junDiv[4](redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{-52,-20},{-32,0}})));
  CCC.Controls.junConv junConv[4](redeclare package Medium =
        MediumPropyleneGlycol)
    annotation (Placement(transformation(extent={{106,-14},{126,6}})));
equation
  connect(const1.y, pumpFcuWaterSupply.m_flow_in)
    annotation (Line(points={{-49,60},{18,60},{18,18}}, color={0,0,127}));
  connect(const2.y, pumpFcuWaterSupply1.m_flow_in)
    annotation (Line(points={{-85,-58},{24,-58},{24,-32}}, color={0,0,127}));
  connect(junDiv.port_2, pumpFcuWaterSupply.port_a) annotation (Line(points={{
          -31.4,-9.6},{4,-9.6},{4,6},{8,6}}, color={0,127,255}));
  connect(junDiv.port_3, pumpFcuWaterSupply1.port_a) annotation (Line(points={{
          -41.6,-20.6},{-41.6,-44},{14,-44}}, color={0,127,255}));
  connect(junConv.port_1, pumpFcuWaterSupply.port_b) annotation (Line(points={{
          105.2,-3.8},{34,-3.8},{34,6},{28,6}}, color={0,127,255}));
  connect(junConv.port_3, pumpFcuWaterSupply1.port_b) annotation (Line(points={
          {116.2,-14.8},{110,-14.8},{110,-44},{34,-44}}, color={0,127,255}));
  connect(junDiv.port_1, boundary2.ports) annotation (Line(points={{-52.6,-9.6},
          {-82,-9.6},{-82,5},{-86,5}}, color={0,127,255}));
  connect(junConv.port_2, boundary1.ports) annotation (Line(points={{126.4,-3.8},
          {128,-3},{196,-3}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testJunction;
