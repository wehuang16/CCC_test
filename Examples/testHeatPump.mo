within CCC_test.Examples;
model testHeatPump
      package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;
     replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating datTabHeaHpwh;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling
    datTabCooHpwh;
    replaceable parameter CCC.Fluid.HeatPumps.Data.ARIS_DATA_EASE datTabHeaHpwh2;

  CCC.Fluid.HeatPumps.BaseClasses.CCC_HP_wTSup_ctr_withPowerData_3D
    cCC_HP_wTSup_ctr_withPowerData_3D(
    redeclare package MediumAir = MediumAir,
    redeclare package MediumWat = MediumPropyleneGlycol (property_T=293.15, X_a
          =0.4),
    datTabHea=datTabHeaHpwh2,
    datTabCoo=datTabCooHpwh,
    Q_flow_nominal=18500,
    TCon_nominal=308.15,
    TEva_nominal=280.15,
    mCon_flow_nominal=0.92,
    mEva_flow_nominal=2.333)
    annotation (Placement(transformation(extent={{-6,4},{14,20}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Blocks.Sources.BooleanPulse    booleanPulse(width=50, period=864)
    annotation (Placement(transformation(extent={{-94,36},{-74,56}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 2)
    annotation (Placement(transformation(extent={{42,-32},{62,-12}})));
  Modelica.Fluid.Sources.MassFlowSource_T hpPump(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=0.5,
    T=321.15,
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
equation
  connect(booleanPulse.y, cCC_HP_wTSup_ctr_withPowerData_3D.IO) annotation (
      Line(points={{-73,46},{-14,46},{-14,9.6},{-7.2,9.6}}, color={255,0,255}));
  connect(booleanConstant1.y, cCC_HP_wTSup_ctr_withPowerData_3D.Mode)
    annotation (Line(points={{71,30},{76,30},{76,12},{15.2,12}}, color={255,0,
          255}));
  connect(const6.y, cCC_HP_wTSup_ctr_withPowerData_3D.TSupSet) annotation (Line(
        points={{-71,10},{-37.05,10},{-37.05,6.1},{-7.1,6.1}}, color={0,0,127}));
  connect(const4.y, cCC_HP_wTSup_ctr_withPowerData_3D.TOutAir) annotation (Line(
        points={{63,-22},{68,-22},{68,6.7},{15.3,6.7}}, color={0,0,127}));
  connect(hpPump.ports[1], cCC_HP_wTSup_ctr_withPowerData_3D.port_a)
    annotation (Line(points={{16,-66},{20,-66},{20,18},{15,18}}, color={0,127,
          255}));
  connect(cCC_HP_wTSup_ctr_withPowerData_3D.port_b, tempHpSupply.port_a)
    annotation (Line(points={{-7,17.8},{-36,17.8},{-36,0}}, color={0,127,255}));
  connect(tempHpSupply.port_b, senMasFlo.port_a) annotation (Line(points={{-36,
          -20},{-38,-20},{-38,-42}}, color={0,127,255}));
  connect(senMasFlo.port_b, boundary2.ports[1]) annotation (Line(points={{-38,
          -62},{-38,-76},{-40,-76},{-40,-89},{-36,-89}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testHeatPump;
