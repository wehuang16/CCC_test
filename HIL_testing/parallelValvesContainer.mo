within CCC_test.HIL_testing;
model parallelValvesContainer

          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);
  hil_flexlab_model.Test1.BaseClasses1.ParallelValvesFlow parallelValves2_1(
      redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-24,14},{-4,34}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=64800,
    offset=0,
    startTime=6480)
    annotation (Placement(transformation(extent={{-78,-2},{-58,18}})));
  Buildings.Fluid.Sources.Boundary_pT sinCoo1(redeclare package Medium =
        MediumWater, nPorts=1)
              "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-6})));
  Modelica.Blocks.Sources.Constant
                               const(k=0.5)
    annotation (Placement(transformation(extent={{-156,64},{-136,84}})));
  Buildings.Fluid.Movers.SpeedControlled_y fanSup1(
    redeclare package Medium = MediumWater,
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per,
    addPowerToMedium=false)                                    "Supply air fan"
    annotation (Placement(transformation(extent={{-98,48},{-78,68}})));
  Buildings.Fluid.Sources.Boundary_pT souCoo1(redeclare package Medium =
        MediumWater, nPorts=1)
              "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-126,26})));
equation
  connect(ramp.y, parallelValves2_1.CoolingSignal) annotation (Line(points={{-57,8},
          {-26,8},{-26,16}},                   color={0,0,127}));
  connect(const.y, fanSup1.y) annotation (Line(points={{-135,74},{-96,74},{-96,
          78},{-88,78},{-88,70}}, color={0,0,127}));
  connect(souCoo1.ports[1], fanSup1.port_a) annotation (Line(points={{-116,26},
          {-104,26},{-104,58},{-98,58}}, color={0,127,255}));
  connect(parallelValves2_1.port_b, sinCoo1.ports[1]) annotation (Line(points={
          {-3.8,24},{16,24},{16,18},{40,18},{40,4}}, color={0,127,255}));
  connect(fanSup1.port_b, parallelValves2_1.port_a) annotation (Line(points={{
          -78,58},{-30,58},{-30,24},{-24,24}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end parallelValvesContainer;
