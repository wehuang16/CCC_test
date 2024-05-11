within CCC_test.Examples;
model testAnyBlock

            package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  Modelica.Blocks.Sources.Constant const1(k=4)
    annotation (Placement(transformation(extent={{-88,-4},{-68,16}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-88,-50},{-68,-30}})));

  CCC.Controls.calculateCOP calculateCOP1
    annotation (Placement(transformation(extent={{-12,-30},{8,-10}})));
  Modelica.Blocks.Interfaces.RealOutput COP
    annotation (Placement(transformation(extent={{98,32},{118,52}})));
  Modelica.Blocks.Interfaces.RealOutput COP1
    annotation (Placement(transformation(extent={{98,-14},{118,6}})));
  Modelica.Blocks.Interfaces.RealOutput COP2
    annotation (Placement(transformation(extent={{102,-64},{122,-44}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2)
    annotation (Placement(transformation(extent={{132,12},{144,24}})));
  hil_flexlab_model.Test1.Examples.FlexlabX1aG36NoDemandFlexibility
    flexlabX1aG36NoDemandFlexibility
    annotation (Placement(transformation(extent={{-138,36},{-118,56}})));
  hil_flexlab_model.Validation.SupplyAirPressureTrimAndRespond
    supplyAirPressureTrimAndRespond
    annotation (Placement(transformation(extent={{-44,-92},{-24,-72}})));
  hil_flexlab_model.Validation.G36ZoneAirTemperatureCalibration
    g36ZoneAirTemperatureCalibration
    annotation (Placement(transformation(extent={{-16,40},{4,60}})));
  hil_flexlab_model.Validation.SupplyAirTempTrimAndRespond
    supplyAirTempTrimAndRespond
    annotation (Placement(transformation(extent={{-94,54},{-74,74}})));
  hil_flexlab_model.Validation.SupplyAirTempTrimAndRespond
    supplyAirTempTrimAndRespond1
    annotation (Placement(transformation(extent={{-142,2},{-122,22}})));
equation
  connect(const1.y, calculateCOP1.QUse) annotation (Line(points={{-67,6},{-22,6},
          {-22,-15},{-14,-15}}, color={0,0,127}));
  connect(const2.y, calculateCOP1.ElePow) annotation (Line(points={{-67,-40},{
          -22,-40},{-22,-26},{-14,-26}}, color={0,0,127}));
  connect(const1.y, COP) annotation (Line(points={{-67,6},{94,6},{94,42},{108,
          42}}, color={0,0,127}));
  connect(const2.y, COP1) annotation (Line(points={{-67,-40},{-22,-40},{-22,-34},
          {94,-34},{94,-4},{108,-4}}, color={0,0,127}));
  connect(COP, multiSum.u[1]) annotation (Line(points={{108,42},{108,16.95},{
          132,16.95}}, color={0,0,127}));
  connect(COP1, multiSum.u[2]) annotation (Line(points={{108,-4},{108,19.05},{
          132,19.05}}, color={0,0,127}));
  connect(multiSum.y, COP2) annotation (Line(points={{145.02,18},{150,18},{150,
          -54},{112,-54}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testAnyBlock;
