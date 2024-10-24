within CCC_test.Example2;
model TestDoubleTankSetpointLogic
  Modelica.Blocks.Sources.Constant WaterHeaterTankSetpointUpper(k=49)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-250,50}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={232,-122})));
  Modelica.Blocks.Sources.Constant WaterHeaterTankSetpointLower(k=41)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-246,-62}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={296,-120})));
  Modelica.Blocks.Sources.Sine WaterHeaterTankTempUpper(
    amplitude=3,
    f=1/3600,
    offset=51) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-168,84}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={232,-122})));
  Modelica.Blocks.Sources.Sine WaterHeaterTankTempLower(
    amplitude=3,
    f=1/2700,
    offset=39) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-172,-24}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={232,-122})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-84,60},{-64,80}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-130,-60},{-110,-40}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{-48,4},{-28,24}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{114,-14},{134,6}})));
  Modelica.Blocks.Logical.Pre pre1
    annotation (Placement(transformation(extent={{-102,8},{-82,28}})));
  Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=180)
    annotation (Placement(transformation(extent={{24,-6},{44,14}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-10,2},{10,22}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{62,-14},{82,6}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-84,-60},{-64,-40}})));
equation
  connect(WaterHeaterTankTempUpper.y, less.u1)
    annotation (Line(points={{-146,84},{-86,84},{-86,70}}, color={0,0,127}));
  connect(WaterHeaterTankSetpointUpper.y, less.u2)
    annotation (Line(points={{-228,50},{-86,50},{-86,62}}, color={0,0,127}));
  connect(WaterHeaterTankTempLower.y, greater.u1) annotation (Line(points={{
          -150,-24},{-94,-24},{-94,-50},{-132,-50}}, color={0,0,127}));
  connect(WaterHeaterTankSetpointLower.y, greater.u2) annotation (Line(points={
          {-224,-62},{-178,-62},{-178,-58},{-132,-58}}, color={0,0,127}));
  connect(pre1.y, logicalSwitch.u2) annotation (Line(points={{-81,18},{-58,18},
          {-58,14},{-50,14}}, color={255,0,255}));
  connect(less.y, logicalSwitch.u3)
    annotation (Line(points={{-63,70},{-63,6},{-50,6}}, color={255,0,255}));
  connect(logicalSwitch.y, booleanToReal.u)
    annotation (Line(points={{-27,14},{-27,12},{-12,12}}, color={255,0,255}));
  connect(booleanToReal.y, sampler.u)
    annotation (Line(points={{11,12},{16,12},{16,4},{22,4}}, color={0,0,127}));
  connect(sampler.y, realToBoolean.u)
    annotation (Line(points={{45,4},{56,4},{56,-4},{60,-4}}, color={0,0,127}));
  connect(realToBoolean.y, y) annotation (Line(points={{83,-4},{118,-4},{118,-4},
          {124,-4}}, color={255,0,255}));
  connect(realToBoolean.y, pre1.u) annotation (Line(points={{83,-4},{83,32},{
          -104,32},{-104,18}}, color={255,0,255}));
  connect(greater.y, not1.u) annotation (Line(points={{-109,-50},{-109,-54},{
          -92,-54},{-92,-50},{-86,-50}}, color={255,0,255}));
  connect(not1.y, logicalSwitch.u1) annotation (Line(points={{-63,-50},{-60,-50},
          {-60,22},{-50,22}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end TestDoubleTankSetpointLogic;
