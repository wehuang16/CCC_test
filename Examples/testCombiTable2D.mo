within CCC_test.Examples;
model testCombiTable2D
  Modelica.Blocks.Sources.CombiTimeTable OAT(
    tableOnFile=true,
    table=[0,0; 1,0; 1,1; 2,4; 3,9; 4,16],
    tableName="tab1",
    fileName=
        "/home/huangwp/LBNL_work/HIL/hil_aceee_02122024/calibration_files/outdoor_air_temperature_nonG36.txt",

    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-28,-12},{-8,8}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=20736000,
      StopTime=21600000,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testCombiTable2D;
