within CCC_test.Examples;
model testBufferTank
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
     replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating datTabHeaHpwh;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling
    datTabCooHpwh;
    replaceable parameter CCC.Fluid.HeatPumps.Data.ARIS_DATA_EASE datTabHeaHpwh2;

  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{70,26},{90,46}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-92,60},{-72,80}})));
  Modelica.Blocks.Math.Gain        gain(k=0.1)
    annotation (Placement(transformation(extent={{-94,16},{-74,36}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=293.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{2,30},{22,50}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{-28,-2},{-8,18}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-62,40},{-42,60}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_m_flow_in=true,
    use_T_in=false,
    m_flow=0.1,
    T=318.15,
    nPorts=1) annotation (Placement(transformation(extent={{-82,-34},{-62,-14}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuSupply1(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{38,-8},{58,12}},
        rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{84,-56},{64,-38}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.3,
    Ti=300,
    y_start=0.2,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-8,-68},{12,-48}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 22)
    annotation (Placement(transformation(extent={{-80,-66},{-60,-46}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(
    table=[273.15 - 6.67,273.15 + 48.89; 273.15 + 4.44,273.15 + 35],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-44,-60},{-24,-40}})));
equation
  connect(const2.y, conservationEquation.Q_flow) annotation (Line(points={{-41,
          50},{-10,50},{-10,46},{0,46}}, color={0,0,127}));
  connect(boundary.ports[1], tempFcuSupply.port_a) annotation (Line(points={{
          -62,-24},{-34,-24},{-34,8},{-28,8}}, color={0,127,255}));
  connect(tempFcuSupply.port_b, conservationEquation.ports[1]) annotation (Line(
        points={{-8,8},{-2,8},{-2,18},{11,18},{11,30}}, color={0,127,255}));
  connect(conservationEquation.ports[2], tempFcuSupply1.port_a)
    annotation (Line(points={{13,30},{13,2},{38,2}}, color={0,127,255}));
  connect(tempFcuSupply1.port_b, boundary1.ports[1]) annotation (Line(points={{
          58,2},{64,2},{64,-34},{60,-34},{60,-47},{64,-47}}, color={0,127,255}));
  connect(gain.y, boundary.m_flow_in) annotation (Line(points={{-73,26},{-70,26},
          {-70,-6},{-82,-6},{-82,-16}}, color={0,0,127}));
  connect(tempFcuSupply1.T, conPID.u_m) annotation (Line(points={{48,13},{48,20},
          {2,20},{2,-70}}, color={0,0,127}));
  connect(conPID.y, gain.u) annotation (Line(points={{13,-58},{28,-58},{28,-78},
          {-96,-78},{-96,26}}, color={0,0,127}));
  connect(const1.y, combiTable1Ds1.u) annotation (Line(points={{-59,-56},{-52,
          -56},{-52,-50},{-46,-50}}, color={0,0,127}));
  connect(combiTable1Ds1.y[1], conPID.u_s) annotation (Line(points={{-23,-50},{
          -18,-50},{-18,-58},{-10,-58}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testBufferTank;
