within CCC_test.Examples;
model testPnnlSystem
  Modelica.Blocks.Sources.CombiTimeTable bui90(
    tableOnFile=true,
    tableName="b90",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/Data/Examples/VAVReheat/DR_input_data.mos"),
    columns={2})     "LBNL building 90 data"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger
                                             reaToInt
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
equation
  connect(bui90.y[1],reaToInt. u)
    annotation (Line(points={{-19,10},{-2,10}},  color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end testPnnlSystem;
