within CCC_test.Examples;
model ArisRoomModel_1RoomTestContainer
          package MediumAir = Buildings.Media.Air;
  package MediumWater = Buildings.Media.Water;
    package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+50, X_a=
            0.4);

  ExampleRoom arisRoomModel_1RoomTest
    annotation (Placement(transformation(extent={{352,26},{394,56}})));
  Modelica.Blocks.Sources.Constant const(each k=0.0453)
    annotation (Placement(transformation(extent={{212,100},{232,120}})));
equation
  connect(const.y, arisRoomModel_1RoomTest.m_flow) annotation (Line(points={{
          233,110},{344,110},{344,34.2},{350,34.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{100,
            -100},{520,200}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{100,-100},{520,200}})),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ArisRoomModel_1RoomTestContainer;
