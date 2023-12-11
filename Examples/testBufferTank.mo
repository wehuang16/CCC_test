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
    annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Blocks.Sources.Constant const6(k=273.15 + 55)
    annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15 + 2)
    annotation (Placement(transformation(extent={{42,-32},{62,-12}})));
  Buildings.Fluid.Interfaces.ConservationEquation conservationEquation(
    redeclare package Medium = MediumPropyleneGlycol (property_T=293.15, X_a=
            0.4),
    T_start=313.15,
    fluidVolume=0.1,
    nPorts=2)
    annotation (Placement(transformation(extent={{2,30},{22,50}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempFcuSupply(redeclare package
      Medium = MediumPropyleneGlycol (property_T=293.15, X_a=0.4))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,8})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-62,40},{-42,60}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=8640,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testBufferTank;
