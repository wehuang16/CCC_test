within CCC_test.Examples;
model testSpawnExportFmu
  CCC.Fluid.BaseClasses.ArisRoomModel_1Room
                      arisRoomModel_1Room
    annotation (Placement(transformation(extent={{-64,24},{-22,54}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testSpawnExportFmu;
