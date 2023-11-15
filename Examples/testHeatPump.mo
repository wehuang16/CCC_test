within CCC_test.Examples;
model testHeatPump
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
  CCC.Fluid.HeatPumps.BaseClasses.CCC_HP_wTSup_ctr_withPowerData
    cCC_HP_wTSup_ctr_withPowerData(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumPropyleneGlycol (property_T=293.15, X_a
          =0.4),
    datTabHea=CCC.Fluid.HeatPumps.Data.LG_DATA_Heating(),
    datTabCoo=CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling())
    annotation (Placement(transformation(extent={{-6,4},{14,20}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-94,36},{-74,56}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 50)
    annotation (Placement(transformation(extent={{-88,-4},{-68,16}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 0)
    annotation (Placement(transformation(extent={{32,-26},{52,-6}})));
  Modelica.Fluid.Sources.MassFlowSource_T hpPump(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.2,
    T=299.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={16,-76})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-36,-10})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-16,-98},{-36,-80}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-38,-52})));
  Modelica.Fluid.Sources.MassFlowSource_T hpPump1(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.3,
    T=288.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,70})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempHpSupply1(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,80})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-22,82})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=270,
        origin={-56,55})));
equation
  connect(booleanConstant.y,cCC_HP_wTSup_ctr_withPowerData. IO) annotation (
      Line(points={{-73,46},{-14,46},{-14,9.6},{-7.2,9.6}},
                                                         color={255,0,255}));
  connect(booleanConstant1.y,cCC_HP_wTSup_ctr_withPowerData. Mode) annotation (
      Line(points={{71,30},{76,30},{76,12},{15.2,12}}, color={255,0,255}));
  connect(const6.y,cCC_HP_wTSup_ctr_withPowerData. TSupSet) annotation (Line(
        points={{-67,6},{-37.05,6},{-37.05,6.1},{-7.1,6.1}},    color={0,0,127}));
  connect(const4.y,cCC_HP_wTSup_ctr_withPowerData. TOutAir) annotation (Line(
        points={{53,-16},{58,-16},{58,6.7},{15.3,6.7}}, color={0,0,127}));
  connect(hpPump.ports[1], cCC_HP_wTSup_ctr_withPowerData.port_a) annotation (
      Line(points={{16,-66},{20,-66},{20,18},{15,18}}, color={0,127,255}));
  connect(cCC_HP_wTSup_ctr_withPowerData.port_b, tempHpSupply.port_a)
    annotation (Line(points={{-7,17.8},{-36,17.8},{-36,0}}, color={0,127,255}));
  connect(tempHpSupply.port_b, senMasFlo.port_a) annotation (Line(points={{-36,
          -20},{-38,-20},{-38,-42}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary2.ports[1]) annotation (Line(points={{-38,
          -62},{-38,-76},{-40,-76},{-40,-89},{-36,-89}}, color={0,127,255}));
  connect(hpPump1.ports[1], cCC_HP_wTSup_ctr_withPowerData.port_a) annotation (
      Line(points={{52,70},{24,70},{24,22},{15,22},{15,18}}, color={0,127,255}));
  connect(cCC_HP_wTSup_ctr_withPowerData.port_b, tempHpSupply1.port_a)
    annotation (Line(points={{-7,17.8},{-8,17.8},{-8,96},{24,96},{24,80},{20,80}},
        color={0,127,255}));
  connect(tempHpSupply1.port_b, senMasFlo1.port_a) annotation (Line(points={{
          -1.77636e-15,80},{-1.77636e-15,82},{-12,82}}, color={0,127,255}));
  connect(senMasFlo1.port_b, boundary1.ports[1]) annotation (Line(points={{-32,
          82},{-44,82},{-44,62},{-56,62},{-56,65}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testHeatPump;
