within CCC_test.Examples;
model NonArisMultiFamilyTest
  extends Modelica.Icons.Example;
    package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater;

  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Heating datTabHea;
  replaceable parameter CCC.Fluid.HeatPumps.Data.LG_DATA_Cooling
    datTabCoo;

      replaceable parameter
    IBPSA.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021 safCtrParEurNor;
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-64,18},{-44,38}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=true)
    annotation (Placement(transformation(extent={{-62,-24},{-42,-4}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 25)
    annotation (Placement(transformation(extent={{36,60},{56,80}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 5)
    annotation (Placement(transformation(extent={{24,-54},{44,-34}})));
  Buildings.Fluid.Sources.MassFlowSource_T           freshAirCor(
    redeclare package Medium = MediumAir,
    m_flow=0.2,
    T=283.15,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={84,16})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=180,
        origin={-80,5})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = MediumAir,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-9},{-10,9}},
        rotation=0,
        origin={84,41})));
  Buildings.Fluid.Sources.MassFlowSource_T           freshAirCor1(
    redeclare package Medium = MediumAir,
    m_flow=0.3,
    T=306.15,
    nPorts=1) "Outside air supply"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,66})));
  CCC_test.Examples.ReversibleAirToWaterEuropeanNorm2D_withPowerData
    reversibleAirToWaterEuropeanNorm2D_withPowerData(
    redeclare package MediumCon = MediumAir,
    redeclare package MediumEva = MediumAir,
    QUse_flow_nominal=14800,
    y_nominal=1,
    TCon_nominal=333.15,
    dpCon_nominal=2000,
    TEva_nominal=293.15,
    dpEva_nominal=2000,                               datTabHea=datTabHea,
    datTabCoo=datTabCoo,
    safCtrParEurNor=safCtrParEurNor)
    annotation (Placement(transformation(extent={{-2,20},{18,44}})));
equation
  connect(freshAirCor1.ports[1],
    reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a1) annotation (Line(
        points={{-38,66},{-8,66},{-8,38},{-2,38}}, color={0,127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b1, boundary2.ports[
    1]) annotation (Line(points={{18,38},{68,38},{68,41},{74,41}}, color={0,127,
          255}));
  connect(const.y, reversibleAirToWaterEuropeanNorm2D_withPowerData.ySet)
    annotation (Line(points={{-43,28},{-22,28},{-22,34},{-3.6,34}}, color={0,0,127}));
  connect(booleanConstant.y, reversibleAirToWaterEuropeanNorm2D_withPowerData.hea)
    annotation (Line(points={{-41,-14},{-10,-14},{-10,23},{-3.6,23}}, color={255,
          0,255}));
  connect(boundary1.ports[1], reversibleAirToWaterEuropeanNorm2D_withPowerData.port_b2)
    annotation (Line(points={{-70,5},{-70,4},{-12,4},{-12,26},{-2,26}}, color={0,
          127,255}));
  connect(reversibleAirToWaterEuropeanNorm2D_withPowerData.port_a2, freshAirCor.ports[
    1]) annotation (Line(points={{18,26},{68,26},{68,16},{74,16}}, color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=300,
      __Dymola_Algorithm="Dassl"));
end NonArisMultiFamilyTest;
