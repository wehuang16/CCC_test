within CCC_test.Examples;
model testCombiTable2D
  Modelica.Blocks.Sources.CombiTimeTable OAT(
    tableOnFile=true,
    table=[0,0; 1,0; 1,1; 2,4; 3,9; 4,16],
    tableName="tab1",
    fileName=
        "/home/huangwp/LBNL_work/HIL/convert_csv_to_txt/supply_air_flow.txt",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-28,-12},{-8,8}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=21600000,
      StopTime=21600420,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testCombiTable2D;
