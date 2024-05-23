within CCC_test.Examples;
model testFmuInitialization2
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  CCC.Fluid.BaseClasses.ArisRoomModel_1Room_ModelicaRoom
                                            RoomModel
    annotation (Placement(transformation(extent={{-16,-74},{26,-44}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-20,54},{0,74}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{34,8},{54,28}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    annotation (Placement(transformation(extent={{100,-56},{120,-36}})));
equation
  connect(RoomModel.ZoneTAir2, y2)
    annotation (Line(points={{3.6,-43},{3.6,-46},{110,-46}}, color={0,0,127}));
  connect(u, add.u2) annotation (Line(points={{-120,0},{26,0},{26,12},{32,12}},
        color={0,0,127}));
  connect(const.y, add.u1) annotation (Line(points={{1,64},{26,64},{26,24},{32,
          24}}, color={0,0,127}));
  connect(add.y, y) annotation (Line(points={{55,18},{76,18},{76,0},{110,0}},
        color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testFmuInitialization2;
