within CCC_test.Examples;
model testAnyBlock
  HpModeSelectorTest hpModeSelectorTest
    annotation (Placement(transformation(extent={{-4,20},{16,40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D lookUpTable2D
    annotation (Placement(transformation(extent={{-24,-26},{-4,-6}})));
  AixLib.DataBase.HeatPump.PerformanceData.LookUpTableND lookUpTableND
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
equation
  connect(booleanConstant1.y, hpModeSelectorTest.u) annotation (Line(points={{
          -39,20},{-16,20},{-16,24.6},{-6,24.6}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testAnyBlock;
