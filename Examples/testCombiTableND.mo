within CCC_test.Examples;
model testCombiTableND
  AixLib.DataBase.HeatPump.PerformanceData.LookUpTableND
                                       lookUpTableND(nConv=1)
    annotation (Placement(transformation(extent={{-32,18},{-12,38}})));
  Modelica.Blocks.Sources.Step step(
    height=4,
    offset=2,
    startTime=4320)
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  Modelica.Blocks.Sources.Step step1(
    height=5,
    offset=5,
    startTime=4320)
    annotation (Placement(transformation(extent={{-78,-22},{-58,-2}})));
  AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D
                PerformanceDataHPHeating(dataTable=
        AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201())
  annotation (Placement(transformation(
  extent={{-3,-50},{51,6}}, rotation=0)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testCombiTableND;
